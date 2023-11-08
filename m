Return-Path: <netdev+bounces-46557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EEB7E4F2F
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542301C20A82
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E057EC7;
	Wed,  8 Nov 2023 02:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAqid7J/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776A610B
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 02:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A4EC433C7;
	Wed,  8 Nov 2023 02:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699412005;
	bh=PJyKoOesvT5wAPrlchrV/0ilPeNqDZ33Js96a2BPsbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iAqid7J/kxU5i36WAe7pHig3EqGGNmWo5Zz7T7VrmpqVrhy0c7bJtykXCqWAsj82f
	 RsDezmF04XbteDaWbB0QDNFkmUxJT+tccxnPnTBndso7a27IZ7vZnx+dIl4CTc2Qq4
	 MgKiYC3rDO+JxWNCneLzEnQe6852PAz/FvcfShn78rL0HUHIp1MKlobwwLJxmXqL9S
	 WVXI3XLG2qrrbjfKZofgCSWLZ7Xt8ip25nxjqFYfhSLxMIede50VWp59oXml0U5RFN
	 QsAO7cfP8Eb50PEJUNU+ZLqLjXmc/xvsv5c2nvMZ0d5nemTkCfuYVCjt12O24VsTja
	 wNCQnLlB82bag==
Date: Tue, 7 Nov 2023 18:53:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: "Dae R. Jeong" <threeearcat@gmail.com>, borisp@nvidia.com,
 john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <20231107185324.22eecf10@kernel.org>
In-Reply-To: <ZUq-GrWMvbfhX74a@hog>
References: <ZUNLocdNkny6QPn8@dragonet>
	<20231106143659.12e0d126@kernel.org>
	<ZUq-GrWMvbfhX74a@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 23:45:46 +0100 Sabrina Dubroca wrote:
> Wouldn't it be enough to just move the rcu_assign_pointer after ctx is
> fully initialized, ie just before update_sk_prot? also clearer wrt
> RCU.

I'm not sure, IIUC rcu_assign_pointer() is equivalent to
WRITE_ONCE() on any sane architecture, it depends on address
dependencies to provide ordering. Since here we care about
ctx->sk_prot being updated, when changes to sk->sk_prot
are visible there is no super-obvious address dependency.

There may be one. But to me at least it isn't an obvious
"RCU used right will handle this" case.

> (and maybe get rid of tls_ctx_create and move all that into tls_init,
> it's not much and we don't even set ctx->{tx,rx}_conf in there)

