Return-Path: <netdev+bounces-32354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B00796EAA
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 03:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D54281451
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 01:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02727A2A;
	Thu,  7 Sep 2023 01:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4617A29
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 01:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6124C433C7;
	Thu,  7 Sep 2023 01:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694051422;
	bh=X8dwhpURgB7OOA8qmmOf96PP2E0+S0KfHl/U6GaInCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EFYlqE5QotiL6i0oYVJfPyCe+XuEWj1NJTdncmusG0e1gXzsXTIHsxzj5Hcp8+npC
	 NS9trT7JdN/0nb5Y8qAX++vJo07V4NGcdJ3B5f4XMvsjF6avwe0QEISZgRX7JA7ACP
	 2r/lQP3jUaphuN/0ZQueJFytoykidq4L8Pcd4gfxAT08UF14Ne7vtANFGQ+tio/nZj
	 Plg3MPaqPfAWOKU2uCr7/Q/P9GoLAOVNZm8eEJHfX8c0nKVbjssTzDsadPys5YQuRY
	 eBlNEVxtVztjbyxmOlPdqQmoStvwnxQ84kmtZ5kHkFw94Dst7gWjM9VhM4ZhYGEBsy
	 KfL3Nut79RQEQ==
Date: Wed, 6 Sep 2023 18:50:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>, Vakul Garg
 <vakul.garg@nxp.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async
 encrypt/decrypt requests
Message-ID: <20230906185020.165ae46d@kernel.org>
In-Reply-To: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
References: <cover.1694018970.git.sd@queasysnail.net>
	<9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Sep 2023 19:08:31 +0200 Sabrina Dubroca wrote:
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -196,6 +196,9 @@ static void tls_decrypt_done(void *data, int err)
>  	struct sock *sk;
>  	int aead_size;
>  
> +	if (err == -EINPROGRESS)
> +		return;

Maybe a comment here clarifying that caller got -EBUSY and the callback
will fire again without an error? The flow is slightly counter-
-intuitive.

> @@ -443,6 +446,9 @@ static void tls_encrypt_done(void *data, int err)
>  	struct sock *sk;
>  	int pending;
>  
> +	if (err == -EINPROGRESS)
> +		return;

Same here? 

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

