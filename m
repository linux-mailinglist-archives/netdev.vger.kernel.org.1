Return-Path: <netdev+bounces-142938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 329289C0B6E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB25C284BF6
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36753212F0E;
	Thu,  7 Nov 2024 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2OlUNKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CD7215F6C
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996254; cv=none; b=HJk1L9d1onXxs5rM05BfttTeSqJfD2r4h0pFBbDTLAVr57R1p4mJK5TEXkwiz+4w3BZCixRk7+k+zYXZ9rgP+Idnac2mpe1FsBUQCNBY4oAJx2vrc4ONwI8x8CzzA6XzaufToThIDxJHaNuW/BwEQpeMIClqp1q5ILIEX51NJmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996254; c=relaxed/simple;
	bh=8E5A7DVhi89w1cXfx1F1B2K/lHBu9iKTsKg7PuEICzk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ETpoXoObaQ3mESKoiiZYn5Rz+FWbT23B9f1PRCW0kaAoGifKdp58SVe+T1YUpNQo24czb4tXBzDdmXNO9hYwN5lyGJexvQA4CTQzpe1bKwTLV09knFyNajC1iaPcZczAZO6JxUlnSU984Lg/ubOnDlfbUxsV5Bu5rfAMaukWAz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2OlUNKh; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46097806aaeso7501441cf.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730996250; x=1731601050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wvq6irtvA5d69LGZVrsJ1HfLgEE/F0sQXT6lQ2Axoc=;
        b=k2OlUNKhoCgkOGPaFvGZeBoqfKpYfPaFdmbZLZtqoBPMyVk4gbLjorCOoyOJ4iXASq
         c7eG+qSK4/+gVnLV7b4fbfBFGmUjfbSyIq205r3mBZh36fa2CfPemMtQy0i36668UlOa
         0Tv2r8E47Q5j5X2pjBlvtmQ47b/R5Yxg9ZvESsiYQlrpLwCu5Cro1j2GmjCujFCjg7Ik
         h4tDWLb7ceCFYLUZWcJpGK/Ue2ETVg8K0j5iakEM6Tv55OFWdFgWqs9i/LAczQ5cAAvB
         7mSS1MxXyF6qBa5j0V2S+ZIrjthYxN/AcuSiDKvxy5pn+JtPtDX51rVjpM62BAkQgZJu
         dyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996250; x=1731601050;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wvq6irtvA5d69LGZVrsJ1HfLgEE/F0sQXT6lQ2Axoc=;
        b=ZAmW5oZev4fvsaq8p4Z/IFOpi/a0X9ByODRFvHKPJoa60vCoEFY8nQ0f5+TWjhDVfU
         U0zykeakXesIv5St54p56SERpQ0AfQb1MDBENQHJF2HwqcOU4CoJwMvaapf1gGI7A6ur
         SgH2q8nixR+yxUDl99CUMYhDx4oTVoQHaAJNVjYOCu7ld9awi8cqQSle4c2puKK5cOKB
         QTSItZljnyQl/QF1DchLgcHz0PVJP/AIs1ldFr2jckzoGMNClfzt0JDih1q82LtODD+v
         m4JxOqD4R6HBAwn587UiniIphblDOIz47VcB0EmFVxAHQ4+iqrmpbx0e0qH8qwyfbj1e
         yp/w==
X-Forwarded-Encrypted: i=1; AJvYcCX7prE0ecN+R45zt6hnC68j1v3SECXPYqBHj830cMGm1dIoBxi+Cv8ZYrY15NxajwwYrB6Vu4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4kVp07sqywIdJgUWoHk7ft6ScMyd8/QyA8uKM/Mul4eFQRSb
	ZZWrs1QRvV+wdgdnnrmUgFZSwEO6mpZu5nhat/uX0Ak5hEF6XsAr
X-Google-Smtp-Source: AGHT+IHeNGd71n4/zaQVVMbwLxEe+2JYM3ju+ijZUOadgpljSTgaho8TWbelrFmn6Z7vYMPQN39bqw==
X-Received: by 2002:ac8:5906:0:b0:461:1c54:5bd5 with SMTP id d75a77b69052e-462b86572d4mr297432431cf.9.1730996250102;
        Thu, 07 Nov 2024 08:17:30 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff46d104sm9502641cf.46.2024.11.07.08.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 08:17:29 -0800 (PST)
Date: Thu, 07 Nov 2024 11:17:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <672ce819549a5_1f2676294c7@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241107132231.9271-3-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-3-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: support SO_PRIORITY cmsg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> The Linux socket API currently allows setting SO_PRIORITY at the
> socket level, applying a uniform priority to all packets sent through
> that socket. The exception to this is IP_TOS, when the priority value
> is calculated during the handling of
> ancillary data, as implemented in commit <f02db315b8d88>
> ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data").
> However, this is a computed
> value, and there is currently no mechanism to set a custom priority
> via control messages prior to this patch.
> 
> According to this pacth, if SO_PRIORITY is specified as ancillary data,

typo: patch

> the packet is sent with the priority value set through
> sockc->priority, overriding the socket-level values
> set via the traditional setsockopt() method. This is analogous to
> the existing support for SO_MARK, as implemented in commit
> <c6af0c227a22> ("ip: support SO_MARK cmsg").

If both cmsg SO_PRIORITY and IP_TOS are passed, then the one that
takes precedence is the last one in the cmsg list.
 
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index cf377377b52d..f6a03b418dde 100644
> diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
> index 0e9e01967ec9..4304a68d1db0 100644
> --- a/net/ipv4/raw.c
> +++ b/net/ipv4/raw.c
> @@ -358,7 +358,7 @@ static int raw_send_hdrinc(struct sock *sk, struct flowi4 *fl4,
>  	skb_reserve(skb, hlen);
>  
>  	skb->protocol = htons(ETH_P_IP);
> -	skb->priority = READ_ONCE(sk->sk_priority);
> +	skb->priority = sockc->priority;

This has the side effect that raw_send_hdrinc will now interpret cmsg
IP_TOS, where it previously did not (as only sockcm_cookie was passed,
not all of ipcm_cookie). This is an improvement, but good to make
explicit.

