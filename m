Return-Path: <netdev+bounces-131217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0339298D3E5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22951F20F56
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B101CFED4;
	Wed,  2 Oct 2024 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wloEyCxI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899BA376
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873981; cv=none; b=LhydpA8sxfzp8p+HgoNjfgoLDqsnluNYKMAFw4KW6/ZZiJWP3NowifhoJi7SvnCUvXq82R9VgE04WbEY0PNseskCWNc+Ecp0GGq2Fk2p6A/rMrlZcv1wkP4SntuQ5GoWHYRMkQc8ISXlU1alyzDDzotoMCc9Q12oP6aFSImlA6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873981; c=relaxed/simple;
	bh=qdRoiUJV/Yov0rZQPYpBl2LSQBnZnGJVH2K745EqmXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icYc8AM1DiPZPYRSRIvlNkWoUl//lyIXd7uXvztD6tmKILiIYyEIZ7wo6qzJcXUyK1JuqLpKOr2bRUFx4ACMaRusLtbbVDE+arvSdZDdoCIufqu+NNyVac/OezTCPZjDN4nSR49GX7CkAHHY9kOmovTVTim0TW/T/EY5aq4LWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wloEyCxI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso2726895f8f.1
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 05:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727873978; x=1728478778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st/3yIKgLFCxd81h3jWZRW2Fy2ZRgt+9u39B8oWEiyg=;
        b=wloEyCxIykM5DUpUR+K9xchqfK3iCjlTjaVGypXup9dRvqbbEvBMHr8D0WILb5YuIj
         rcINkjeZOwcbfME2JeNByRFdsihJ8qeA6Uqhf4GA3Y6uvhmDzRqtY0PKlJphG5mZPe8h
         /iM5SntPoUKc+TpLjcolypy2YM26eF7qHlhR3LG91a+2y0pc8pY88i5j3YQ8kcrPLgM4
         1stXWT63J5hQ6UzO0i6q43wjzQ4/OUGHBbkjvFbtRDIiFIL5YNbv0C2WXSMd4RB11374
         HVxdiV07gDfhvLovvfI+wvfSrcBH0bJOqbw22rZQdxgXYgUrz5gVmktkPcncZAfzjtXz
         6OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873978; x=1728478778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=st/3yIKgLFCxd81h3jWZRW2Fy2ZRgt+9u39B8oWEiyg=;
        b=NMw0vIW6h8iL4QmJ+IZsDE4ZYJ5GMoqAmkoV4yY/yv6SQeH/HEzOHJ5ctBbGHnqCEv
         LWFSwXPGE+loxqB6flCqDgvSF+L2VvUKSTIZCBcV0wiXEhdq6U0A1FtN8XQmS0BOY+QG
         EZUY2jl5V1E5wCNgaN5CogI4mCxLt2i0WA11bZ+5dPNYMXouaFrU/9sBiFDAhxx/0r2c
         0dIFZIgugRU3AKGKRN53heKD0IBKCfD6XfQpHEhfqhi+Vw8va6LHXSqyf1Wn4vKQO21z
         LQFacjLEuFwM7R5nm1EfZtQYrhYIMg2PXd99szI+kKk1/J8QggXGlccPSRHnjE4DxZwu
         G6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUei3krh5jnemYvvoF7JejjPg+xNTVCSxCu2gZfOITS+GGHR3grRFMHxSX9buiTpwwZyw3K63g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzBcOva/8Dr/ZW2xiVHaXGTsAsAO8FxrrnSFAx6XGOhMv/e/jW
	oSs6uR4jx0Vkp70HzK6HqCPzKIoBvnkWXUhdonB5VgVJNk5Zj/yYTCu3CFZiMZMnSKb20UJIlfs
	Uhxek+UjBLlSX3ZcnHzXy619rBcvLt0Gh8yzF
X-Google-Smtp-Source: AGHT+IHgjLvHaqBFwPszuX7w/s0xpfyCrHiRrPhwGt7sEo3B5xKRljFKgr291hjq1Vo0g5FUrVD+DmKjceLAZG021rY=
X-Received: by 2002:a5d:694f:0:b0:37c:d129:3e48 with SMTP id
 ffacd0b85a97d-37cfba0a4a1mr1713461f8f.40.1727873977599; Wed, 02 Oct 2024
 05:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com> <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
In-Reply-To: <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 14:59:24 +0200
Message-ID: <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.com>=
 wrote:
>
> Hi,
>
> I would kindly ask if there is any progress :)

Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d5058=
69526c566f132
100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2909,9 +2909,19 @@ static inline void
skb_reset_inner_headers(struct sk_buff *skb)
        skb->inner_transport_header =3D skb->transport_header;
 }

+static inline int skb_mac_header_was_set(const struct sk_buff *skb)
+{
+       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
+}
+
 static inline void skb_reset_mac_len(struct sk_buff *skb)
 {
-       skb->mac_len =3D skb->network_header - skb->mac_header;
+       if (!skb_mac_header_was_set(skb)) {
+               DEBUG_NET_WARN_ON_ONCE(1);
+               skb->mac_len =3D 0;
+       } else {
+               skb->mac_len =3D skb->network_header - skb->mac_header;
+       }
 }

 static inline unsigned char *skb_inner_transport_header(const struct sk_bu=
ff
@@ -3014,11 +3024,6 @@ static inline void
skb_set_network_header(struct sk_buff *skb, const int offset)
        skb->network_header +=3D offset;
 }

-static inline int skb_mac_header_was_set(const struct sk_buff *skb)
-{
-       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
-}
-
 static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
 {
        DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
@@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
sk_buff *skb)

 static inline void skb_reset_mac_header(struct sk_buff *skb)
 {
+       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
        skb->mac_header =3D skb->data - skb->head;
 }

@@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
sk_buff *skb, const int offset)
 {
        skb_reset_mac_header(skb);
        skb->mac_header +=3D offset;
+       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
 }

 static inline void skb_pop_mac_header(struct sk_buff *skb)

