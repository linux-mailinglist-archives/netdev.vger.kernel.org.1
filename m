Return-Path: <netdev+bounces-198989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B02ADE96D
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890CF7A2D2C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D965E27F017;
	Wed, 18 Jun 2025 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJmM+uoe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1015D1;
	Wed, 18 Jun 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750244060; cv=none; b=Qpgip3Am23TAbV58pJ+jxKP6M7l5UrVKbdi7kAvYv/SZS5iZB0BBTqCouEnw1qDi0P2p00GR+xN3s6+hrI2vF02uuQimYgU5F6SujFbLbhRTBCrBbjQstRrtTf8aMI+YKqFNVfuhqyTBNPEnr5fUbRfDSXyh+fkeB+KpUmRMmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750244060; c=relaxed/simple;
	bh=bhzsAZml4X4qT4Ot/BcfPJFMcCpVA3pp2TMW8SoYRe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvfdB+9jSq7RGGFl78BsF/lixreG6MKk+dAyoPQLfmqBgOds1pIFwAcpFUXB+iL7Khe15Itvl86OFuvkr1RtQ2EUDCnQaINPPjOtwWthgCbHe8HbuX++vyOShVBC4fGI6bjhuu73hBkuufpmImWETTC9TzhUKtMWWQVr3r9FKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJmM+uoe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7E5C4CEE7;
	Wed, 18 Jun 2025 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750244058;
	bh=bhzsAZml4X4qT4Ot/BcfPJFMcCpVA3pp2TMW8SoYRe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJmM+uoemA4GdSxk0FI7j3VEJdMBLQuQznbLgTr9CSbBN6xOcWgBM/Eg+nlzldoIi
	 33W8YzRecPhr/nQjSxxf5S13UNF9DEGuBU2X3uOYnS37ELHppnAU3u7vZdEb/wg9NX
	 SS6WIcwOoNpIc/2ovUZg6uiCvX38P6hNiGVgCxCUznFv3tI4sxf83FJ95Y1qAtcugG
	 UnOKiigYdzgtSMf9MbYOlalF+RPMHCHh7yQWHewYpRKShwxCxLj+0dsA+gJAWPGvw/
	 0J36u/+XpOXBUzfjKQ0EDRWoo2MOkQaLinNYR13jHRjf+ov3yRufUe+GUq5gaYaqM2
	 AqSfCnti5PL1Q==
Date: Wed, 18 Jun 2025 11:54:13 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] net/sched: replace strncpy with strscpy
Message-ID: <20250618105413.GF1699@horms.kernel.org>
References: <20250617123531.23523-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617123531.23523-1-pranav.tyagi03@gmail.com>

On Tue, Jun 17, 2025 at 06:05:31PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer should be NUL-terminated and does not require any trailing
> NUL-padding. Also, since NUL-termination is guaranteed,
> use sizeof(conf.algo) in place of sizeof(conf.algo) - 1
> as the size parameter.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  net/sched/em_text.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sched/em_text.c b/net/sched/em_text.c
> index 420c66203b17..1d0debfd62e5 100644
> --- a/net/sched/em_text.c
> +++ b/net/sched/em_text.c
> @@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
>  	struct text_match *tm = EM_TEXT_PRIV(m);
>  	struct tcf_em_text conf;
>  
> -	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
> +	strscpy(conf.algo, tm->config->ops->name, sizeof(conf.algo));

Hi Pranav,

Because the destination is an array I think we can use the two-argument
version of strscpy() here.

	strscpy(conf.algo, tm->config->ops->name);

>  	conf.from_offset = tm->from_offset;
>  	conf.to_offset = tm->to_offset;
>  	conf.from_layer = tm->from_layer;

-- 
pw-bot: changes-requested

