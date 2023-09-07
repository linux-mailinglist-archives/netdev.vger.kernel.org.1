Return-Path: <netdev+bounces-32360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88331796F63
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D5928145D
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01190EC0;
	Thu,  7 Sep 2023 03:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58B8EA9
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 03:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E988C433C8;
	Thu,  7 Sep 2023 03:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694058448;
	bh=PJhSTVotcMcqXadbS1gofWvsbo02DtFYT7yrRxBf81g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4XfHJ/RojsN6nLgAg5KrsWLAZvXPYG/KNZ/Bw3Uve3wimaEHGCtW2+Y3RYOANRRQ
	 o7g0j67WKs4RLM0j/QfLUDIkkQAcdxX4YvGfjSVT/vtcAc6/EndPJf1l0f+HtwFBYw
	 fSm7hCursaouEM0Brl1LvsabfsdbdcaBmlNUhFC4ybx/qZ7Z44HrXIJvbJMM/bThFn
	 XMNbKz9MdZ99nUsCYQBHM7TsiUZ6RZlEu1+nyfef0G1HSXlPEDzm5eYYqOv4+tyx+Z
	 8Lj9BucPD7xRVBcBjtWabAwUo7T2c0mRyL1ygQBNeXk3kGAK/zwDHmK4xaqHMyu9xs
	 tQm/avw+q4poQ==
Date: Wed, 6 Sep 2023 20:47:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>, Vakul Garg
 <vakul.garg@nxp.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH net 5/5] tls: don't decrypt the next record if it's of a
 different type
Message-ID: <20230906204727.08a79e00@kernel.org>
In-Reply-To: <be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
References: <cover.1694018970.git.sd@queasysnail.net>
	<be8519564777b3a40eeb63002041576f9009a733.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Sep 2023 19:08:35 +0200 Sabrina Dubroca wrote:
> If the next record is of a different type, we won't copy it to
> userspace in this round, tls_record_content_type will stop us just
> after decryption. Skip decryption until the next recvmsg() call.
> 
> This fixes a use-after-free when a data record is decrypted
> asynchronously but doesn't fill the userspace buffer, and the next
> record is non-data, for example in the bad_cmsg selftest.

What's the UAF on?

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index f80a2ea1dd7e..86b835b15872 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2010,6 +2010,9 @@ int tls_sw_recvmsg(struct sock *sk,
>  		else
>  			darg.async = false;
>  
> +		if (ctx->async_capable && control && tlm->control != control)
> +			goto recv_end;

