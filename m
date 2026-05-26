Return-Path: <netdev+bounces-291879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK+2GoLqFWqXegcAu9opvQ
	(envelope-from <netdev+bounces-291879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:46:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6C5DB84D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37E533014833
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CDB3446B0;
	Tue, 26 May 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzsmxkpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062602DEA7B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821184; cv=none; b=Gz0R+JXgnS4+e4XL2WIJjant4jkq80OmFbo52LjNR+uIFE/m59nP8KJxrvO3uEaZ3hcVv3VjZlNt5DvNF1IWTf0CKQpjFNPGaN45tozJ9TkogN9bV400RQvZ3qOkYOPxA3tKvJV8iTZMZPnnfOi0loufJa9pbKXMenHpwX+L2v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821184; c=relaxed/simple;
	bh=XdW9He5EDu8NwLUMQOJO5rBU9vk4TninkbjLV/S6asg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FokF+OTyEgeqtjUMNiFoVigedO36clASe0J2HNleblArdjjVC8TdwckiCJEI4h2X77AhpBq+EDdC2uftt+T+ltOHpQujkv6IOjMa98rJN403XnAPhWU1QraeGxKKc/CPd7r0vjErb1T5C14D880F+DWm3rlFeIbVI8NVgxodE/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzsmxkpU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7c23248f3a3so115576177b3.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821182; x=1780425982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr3UqMOgY8Q0sOVcNzul/LXQuYjMqGkRarSoqlIbOyM=;
        b=ZzsmxkpUc05f7wiPWwm7aNDiOKxACVbJl3J/NATKTztPi+CYy3kd/YjhMFmXvvZHBD
         iz/mcuQkT36erQydBwzaaII8V+uZGugdYhrcZnWRNnwYW2j8SmMSne4kQv3hMz5gfB9l
         HTdAQEYsPBEYI+MM/JS45lKMR08Spa0FGOfym7gOJ2b+ToI3hE2LprcLxrWTZaeDo1ue
         RzDHSGyAkOv+TjLuiRvaGFqYdy0S/g0yr7KddA+S3Jh2JB6RDkbSC0cmWIYqQqiU9/3q
         YdBCSB5/ljq1dSZLMVdfrbSUfuIx0G/jC59N/KLSyFedogwOTPjMZUn3VSVqbHP1QeQW
         KgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821182; x=1780425982;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sr3UqMOgY8Q0sOVcNzul/LXQuYjMqGkRarSoqlIbOyM=;
        b=s30O+Hi4Wx7fCbxJyzH8ge6dDQHWORSIB5jT4TXi6fb2VuozC8BWx2tXGoWmLFCR4w
         WUpieR8/E/3kxStqMglDAgzys0Tl5pOj+0HGamZ5hMCoAhb5OFopNAznzi5NYXfKTwpk
         OsWYauaMj7oEbZqYNVkjh2BcNLBivnBzt0Bv0m73JMUmK1GZ5OM8X+DLPOivF0u+ZO5t
         gZz7quKxa1cGWBhJEyPRmaaTLOUgLNpjrUOZIOC2TengWdFTi7SsISCQWXYObptCwdYz
         gjnWYs9zV01T5c+gYiqYkBhLpYqBAnUj7dSYoYQXsbI2pSYUO5/O+zkenfG0dtVvE3Df
         Q/rQ==
X-Gm-Message-State: AOJu0Yypdeq/CbQvq7gogoGm9yid2Y5qGbmrIV47JLG4rKieOBUvEuPJ
	NV+Y+pTooDU6e4oqLb6YhiD/IuVpxdCY1UeNgCJm+ywaNINmKqG82ZErqkUHhg==
X-Gm-Gg: Acq92OHaj3o5Nr8ali1LxveX5uplHIzpAbmezR1t/M0ui9JP1+SMVr0mrToXy6XsJvH
	bkasxJBwLga6+L+twh5irpM2dWXynMLCjPOqXI7fHFVgRIoUjMqT7ef6TkjiEZEZ1v97YsrFYP6
	4xaw3pgDrEuakPU8PFmObD1gClCf0QRfA2puAhmDCGkU1MgNq7epAneygbXroa4SC0+LaJtLPXP
	6pbMzamR+dC7Cgu7mJVim8fQNSwvFhUVtsm4yDkcvhcwPPyPeV+5rEagPZ2l0w7NlWc81Q5MrzT
	hYZYNUSvqifEdnbuEQZx5Vgg3zdfhSXYytVb+pennwO6l8gvhKhb0qmfl2J8gcHKOcNKgCJ+t1E
	mWmpQEPz4jqv6dvD3yMT7YFg/9/5NCLLE+llaZt4ezZdTVgEuL+ASZbbL2F+xvKVCgH6ygxXKeQ
	3RX9kNbJJEi7EvLnxjbUeCfMps/ypnHF/S7tazTAJTwsr0S4s2eVQi3PXxAvFBxaIsHycoj1pf/
	yQlklHvQFawz6xViw==
X-Received: by 2002:a05:690c:3388:b0:7bd:9ce7:164c with SMTP id 00721157ae682-7d338682c32mr218938457b3.43.1779821181917;
        Tue, 26 May 2026 11:46:21 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d389813ee6sm64269647b3.2.2026.05.26.11.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:46:20 -0700 (PDT)
Date: Tue, 26 May 2026 14:46:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 richardcochran@gmail.com, 
 yangbo.lu@nxp.com, 
 kuniyu@google.com, 
 willemb@google.com, 
 matttbe@kernel.org
Message-ID: <willemdebruijn.kernel.178a41a53d041@gmail.com>
In-Reply-To: <20260526153650.2779821-1-kuba@kernel.org>
References: <20260526153650.2779821-1-kuba@kernel.org>
Subject: Re: [PATCH net] ethtool: vclock: propagate errors from
 ptp_get_vclocks_index()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291879-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,nxp.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.764];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05B6C5DB84D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> ptp_get_vclocks_index() was written with sock_timestamping_bind_phc()
> in mind. Any return <= 0 will get converted to EINVAL by the virtue
> of sock_timestamping_bind_phc() not finding a matching vclock.
> 
> ethtool's phc_vclocks_prepare_data(), however, should not be silently
> returning empty messages on allocation errors or when PHC does not
> exist at all.
> 
> Commit c156174a6707 ("ethtool: add a new command for getting PHC virtual
> clocks") added phc_vclocks_prepare_data(), but let's not treat this
> as a fix in case some user space app now depends on the failures being
> silent.
> 
> The check in sock_timestamping_bind_phc() is not strickly necessary,

strictly

> but include it just for clarity.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

>  
> diff --git a/net/core/sock.c b/net/core/sock.c
> index b37b664b6eb9..9e33e979a283 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -870,6 +870,8 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
>  
>  	num = ethtool_get_phc_vclocks(dev, &vclock_index);
>  	dev_put(dev);
> +	if (num < 0)
> +		return num;
>  
>  	for (i = 0; i < num; i++) {
>  		if (*(vclock_index + i) == phc_index) {

Not for this patch:

This is called by sk_setsockopt and by MPTCP for every subflow.
Apparently MPTCP does not check the return value. Should it?

