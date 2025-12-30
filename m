Return-Path: <netdev+bounces-246386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D34CEA8B0
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 20:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 645BC302E04E
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8B2E6CC7;
	Tue, 30 Dec 2025 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V51zEPOV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DD28489E
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767123350; cv=none; b=aVBWW04ufU9rzb7+mUW6mOMUX/+VAHUrM7ellC2rMe4mc+C1YY+dSjreTvpQyatIlicMuVw9N89XGABvWmVwVenrTPB7pq1u/PnpCBKfg7LpxPtHBSLalNxZQo/BVEdXFoNL9huLJLq2QyukTiMY5/QoeG1VeUNM1JTP11Jjh+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767123350; c=relaxed/simple;
	bh=2fZeFI8ChalvAPPCVG+1WXDPJh0uoiPyhnhHPGeZFas=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Zjvcrsj2yyP6GdOCtrb/VDl+dOc/FIYXrfI2UrG5ryRxMYmNImDMDUF0plUZE2umwuPDwdb727dH0q2CbCx4cLSEliEBx2g0vfQoPsBn3RQwPuCj5pgSvS0ei5x550Gq4CtDIDWAXdAOmHZdd6NWg2ONH4Yusmd79g9r+ulW7OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V51zEPOV; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6432842cafdso8923746d50.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 11:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767123347; x=1767728147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbLbN5qo8BhCJ3h1f/M+MLdJNxCUmuM3GwhK4z+mTLA=;
        b=V51zEPOVHXhb5idn+Y2psWcL0uZLT4o1RLbTrzzj+FzbwJ+yF3yBJaUXmxy0y/QOo8
         cmA7/2ODa7NVlS6eaWqwNr8E2b3X4brSS4YFxtJROuBi88PZf0xZiz6zy8DHNFzEcJWb
         onuwqgXd8ckYSuuHeUFHJY5KjFoqxYC5y0J1B4ogpAlxr+lUW3QNkhGWLcHYWTWalzF1
         Nu4oT+T+N8/kT8mVqJQfN3/OqzhtNT5K821J+tOPHecwc+6jQQGaRFYjNzlSMULOgFtf
         V3JziBFsjaLXp1KwtDAFWUur8br+tW/8iqRSow1zAlAFcknw5yEd8SuuevntaRhDDSvi
         mMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767123347; x=1767728147;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbLbN5qo8BhCJ3h1f/M+MLdJNxCUmuM3GwhK4z+mTLA=;
        b=j1PK684FB9YBB9Xrz4Z/TudsnT9O0VPxfcR1gLdLeTw4e6hNXLMr3+DkWiRLCaH3Po
         iWQ2lDO7ogSNGn2bOMcqICZdBnu497WvpOTrhz54MdXQx/XA9PB6TB0NnQBII9oacZ9I
         /lufonFhlmqG5SpomhOuvoe5zTPGfrYbkuFPZRTyJl1HUbV7fj+zxzEEV0bodE3wSeAk
         g4/WgkQwP8RHjYpIC3WSrSPwmnbcxO4OorjBdLul7vu+4mpKucXfPnDeBTRXDCn3Ikpc
         6Q4mR0bGGdKQqM1KKzOnfGB5c4tK6pIHvdNVFEcYuzVed9C+H3hj2RYlf1YzCUoS+Zb+
         1ArA==
X-Forwarded-Encrypted: i=1; AJvYcCXEjJCZBwqLOElQ2Ov6VwgB75zV38oUAMujlb6sqdAyA7uojUAkrEdmD7oScunH+TBciYQ3H7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKFxPaDEh/uOoq80ynlDGzpOTznLuBuGVg29ywLD2h2DmUQ4l5
	4kFrSZBTlELr8KrfpyRxrwRWWoxw5B4aqr1VFP37cgbkIexIBJjbSosU
X-Gm-Gg: AY/fxX56F1GVUliyNHGeeVWDZYfXv0ws9opJqLxQnrOn4aMK5G5p/9sUQ1ilvTPxFt1
	ur8ClJJecn4ExpANfkw6OSnjoWsgCG5K4d88DrRZgsM8nK76HZvof2njvRhtEAeemIRQUmU9kVL
	J5KnAtUas8lMBiYsGgVJ5Ov8C2DpkAQJNFonuPJY6DIswnYMwR1tp67uqK4SL33HaA7dfuv1PDR
	ryQv58vYVXTrwkSWiNZrt8a4bgF4FDVu8EzPfrlQK0QQ+iNnzyv/aas3VlNmomFZKDLwZfiqVMA
	rNFj5ikcV9d8dITdGyRh8a2fIYM3xjl3TJUNNQ3hbkLxvBf/mpceYpT98gs+5pzcZnJF78SF4FD
	k1D16wir8wQWFZglXhNuIP6UIySaJiqnG0FIZJC+4T9T6CrNKHRQirltfJh+89VV3797KRToVoT
	ZyXwm5jD371xXPT6+trO4SihJClPm0n3zccO3D2fZWc+vywcrNToFP01vFyNw=
X-Google-Smtp-Source: AGHT+IGskJuGH1ry4lW++SW/O5+eFpbYgJV1JB4rR83UjJdJAPT2DRTtF+kwsfPk5XXMD9qFGe8aFQ==
X-Received: by 2002:a05:690e:1281:b0:646:7d1b:614f with SMTP id 956f58d0204a3-6467d1b653fmr24659651d50.56.1767123346798;
        Tue, 30 Dec 2025 11:35:46 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb44f9a42sm128149897b3.29.2025.12.30.11.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 11:35:46 -0800 (PST)
Date: Tue, 30 Dec 2025 14:35:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alper Ak <alperyasinak1@gmail.com>, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 kuba@kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Breno Leitao <leitao@debian.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.332a5aa0f6f9f@gmail.com>
In-Reply-To: <20251227073743.17272-1-alperyasinak1@gmail.com>
References: <20251227073743.17272-1-alperyasinak1@gmail.com>
Subject: Re: [PATCH] net: ipv4: ipmr: Prevent information leak in
 ipmr_sk_ioctl()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alper Ak wrote:
> struct sioc_vif_req has a padding hole after the vifi field due to
> alignment requirements. These padding bytes were uninitialized,
> potentially leaking kernel stack memory to userspace when the
> struct is copied via sock_ioctl_inout().
> 
> Reported by Smatch:
>     net/ipv4/ipmr.c:1575 ipmr_sk_ioctl() warn: check that 'buffer'
>     doesn't leak information (struct has a hole after 'vifi')
> 
> Fixes: e1d001fa5b47 ("net: ioctl: Use kernel memory on protocol ioctl callbacks")

The commit mentions other similar cases. If this is a concern for
sioc_vif_req, then it likely would alos be for sioc_mif_req6, which
similarly has a hole.

> Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
> ---
>  net/ipv4/ipmr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index ca9eaee4c2ef..18441fbe7ed7 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -1571,6 +1571,7 @@ int ipmr_sk_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>  	/* These userspace buffers will be consumed by ipmr_ioctl() */
>  	case SIOCGETVIFCNT: {
>  		struct sioc_vif_req buffer;
> +		memset(&buffer, 0, sizeof(buffer));
>  
>  		return sock_ioctl_inout(sk, cmd, arg, &buffer,
>  				      sizeof(buffer));

sock_ioctl_inout copies the whole struct from userspace, calls a
domain specific callback and then copies the whole struct back:

       if (copy_from_user(karg, arg, size))
               return -EFAULT;

       ret = READ_ONCE(sk->sk_prot)->ioctl(sk, cmd, karg);
       if (ret)
               return ret;

       if (copy_to_user(arg, karg, size))
               return -EFAULT;

As a result every byte of the memset will be overwritten with the
copy_from_user.


> -- 
> 2.43.0
> 



