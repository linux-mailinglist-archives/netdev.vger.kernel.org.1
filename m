Return-Path: <netdev+bounces-259738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCwnO5mCmGlMJQMAu9opvQ
	(envelope-from <netdev+bounces-259738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:49:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7215316909F
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E69B300ECA7
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D934DB7E;
	Fri, 20 Feb 2026 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhORVFea"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0AF2D9EE4
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771602582; cv=none; b=ZakSZol6uaw3jcw+1AAmYjdgy913j/8r8ml9G/O9EyS7CJdrrLWDuSlPPkcNP5KxqjcTzk6IF6GPE55FRymaSZyuUUu6pFClfie1hb7MblcryWQLHL3R/aRNCHKWxDDG5rFWZ7e4IapQ98N7tGiHI+y1hVUxjFY60lLXzETXU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771602582; c=relaxed/simple;
	bh=xz0Ch4aG6rZM2dunWY59tR8SXBBhYC9UWseaD1mtFgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMJps5adUm6eNGqthBRPq3ZZYKDHcHJGXC0djKOTJa6lA6RVEtCPoLh/oCRgHCrRA0sR80WwFu9Hs/CeS4RuPFV2R3obK/JgOtzaTMEReQzW03nOV4gMVQ14FpAu0o/m5PWleNW2TdEZsaxb3ZtlCF0Xz25C87gBmDd3+CcklOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhORVFea; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso30818495e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 07:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771602580; x=1772207380; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mrZY6rdubW6faYA3sLH9L5zj3wJQWap7XC/wATZ9B8Q=;
        b=fhORVFeaODDGfr+ciDPfcRtxw+7uyu0/DGr+nZEPFclbM6gCGeiT0SizTqkg8LpAio
         Jn1JVc3K6CJquLvIkmGsDlHCAEGC1J+TmvltODRT/8KtPCmVfkz86vMSIyHUohoXwiys
         Fa+WJZjl1Q+z2901kBVkWbEXusyT1sv2SUTGanEuZq3BhjtWVUCDmmtFHl547vNI506g
         v/1pEID7XGOonxWwlQev76wpJG30e5FsTr4mvtcs8gHjdJYWPjpP2EkpMM8zLEK663MX
         Se5uks1YLMjBlQCQXlR/B9H2oQCpB8R+T3x+JsCW1IMha8+YGkJNFz1/j2mb+gptfcpv
         /szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771602580; x=1772207380;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mrZY6rdubW6faYA3sLH9L5zj3wJQWap7XC/wATZ9B8Q=;
        b=GOtQcxzDkq9ieYyTy8r1Bj1mYdPcD4C4212Az4+aXxxgnljRO2ACKEAV6iRMZA9sc8
         2AFM+pZQ6UYRatSqV4KEcXp/H78QPYR7ktQYs3le/BvKcglHupHgAfYhPdgMsz1TlYzn
         r80hUhVps1qnxBC3umWZ0WvF6d3/lFpcX2WiL4kVHkVqKAcactrfhT28QMDes51z/2BR
         6X1y1zhUadPZ1TAUK06OgCDM/OPzr1zOFBsyChWYDzqVWoowjPGcQLgJnFc9fQzilxhz
         diT/5U8QNXp6fddSzne7tI433s735aEFBbL9jVnftbRsYznpDEeNiGdtFD6Z6zhF6IYT
         nBVw==
X-Forwarded-Encrypted: i=1; AJvYcCUY046uzukMeww3ZS7Jx0a02pGEuah9aND0RmJN3LQXUwzo1tQXCkvrrOSxHtb4wuisAl2GQqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YylVFTZ8Z0YzqVJYWEUr8wd0btmynw/fQDvioQbugMtThso8NxW
	XRoJRfxbMPziE3Ze/aMey644laVFFJ1kf9v5PHQCRbIRuiKxt9y4kJuM
X-Gm-Gg: AZuq6aJ8RpABRw9JZLgZ9UvtsJevx6hZ4eyRhp3Xct5h0C6RIDArEHKJhWH+2LwdfC9
	1JB2OtrMXobkBJ9F1pt52LJu7vZ7xIT9rGDUcXYpiMBy2xBlfYI58C6VNS3lsTiPPye5AWQurvt
	hur50w4RVL9En0bT2PHMOV2qokJFqJprXxtZRkBrimYc8eYewNr3jldrtXLek4z3/+6tBUw4wwC
	nui29Vmj2LO3rF8dwFAm6KQUb1AStKaF/iIhsQrcJHObpwfRQ2NrgDu06VScA79VVCIjJH3gwOZ
	FvimIJJae/den+tLO4MRRN1cuf2uhbRD+tab4doy/I2sEhYdtT8qKZQHwnm7/10uZi5aj5y2vDX
	fD9QM3DdBgYdEQv5fvDqP9bCCuIW5Rav/y18b9yS7frtlDUcTFkwzwi7Fc64uMosZZNhdwPSZ+6
	kpAdd9xOz/f4mfTl9sdEMLmpj5cs/H6EyqFYQoOF1MAVyyY+we
X-Received: by 2002:a05:600c:3e11:b0:47d:403a:277 with SMTP id 5b1f17b1804b1-483a9492398mr2331235e9.4.1771602579642;
        Fri, 20 Feb 2026 07:49:39 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c048bsm82813375e9.7.2026.02.20.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 07:49:39 -0800 (PST)
Date: Fri, 20 Feb 2026 16:49:34 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	paul@paul-moore.com, samasth.norway.ananda@oracle.com,
	serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <20260220.70d0460d1309@gnoack.org>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219200459.1474232-1-utilityemal77@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,alyssa.is,huawei-partners.com,google.com,namei.org,canonical.com,huawei.com,vger.kernel.org,maowtm.org,buffet.re,digikod.net,paul-moore.com,oracle.com,hallyn.com,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7215316909F
X-Rspamd-Action: no action

Hello!

On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> diff --git a/security/security.c b/security/security.c
> index 67af9228c4e9..c73196b8db4b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4731,6 +4731,26 @@ int security_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>  
>  #endif	/* CONFIG_SECURITY_NETWORK */
>  
> +#if defined(CONFIG_SECURITY_NETWORK) && defined(CONFIG_SECURITY_PATH)
> +/**
> + * security_unix_find() - Check if a named AF_UNIX socket can connect
> + * @path: path of the socket being connected to
> + * @other: peer sock
> + * @flags: flags associated with the socket
> + *
> + * This hook is called to check permissions before connecting to a named
> + * AF_UNIX socket.

Nit: Could we please insert a sentence about locking here?

Something like:

  The caller holds no locks on @other.

(Originally brought up by Mickaël in
https://lore.kernel.org/all/20260217.lievaS8eeng8@digikod.net/)

Thanks,
–Günther

