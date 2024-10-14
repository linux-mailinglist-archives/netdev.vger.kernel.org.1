Return-Path: <netdev+bounces-135295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E7399D7DF
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050651C22798
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D171CF2B6;
	Mon, 14 Oct 2024 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jva9GzQ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECA1CEEAA
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936390; cv=none; b=A/WlxrFNdA0ZnA2qzR2ASyu4UJhaRBmvusZjEVTIOUQH3KWBXF/3AORJ4k9ZRNEUjV7T2gLR0iEYE7EQ+xgyYC4M3zIjRnd1ejOR0KuZLcESf+ngvk304pHyeekx1ByeryJzM0FD8xyOHyW9h4NZPgRj5gyodVviCFopewLt3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936390; c=relaxed/simple;
	bh=4Ri6T/8OAnNvzcSG8Fe8w51CffeTL4mskN3jbG4uPus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMNAfPsF+G1qJrpULdxkyk05tIfJKLQNaPsMFwset1g4JBcyZRA23Mf2VbaN2SZ7VpCd6XRfbccplf8RVOkG6Y+AQI/8f11WCVq0UFikCF9K8U/u6AQTb4OecmA65VbiJFLUVnA7bEPr327Aoj/iY/mAKv3twOmSfXFtM4ms5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jva9GzQ+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 254A43F233
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728936386;
	bh=yKWzm2dNvhWm9z8YkvsjycCHxzeK70hrT0KE+1kqPr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jva9GzQ+H/OqZ2Xrb1G/+4i56ocThFRq0bcTK60lbqAFzO2hRgaK4UTdSAK3cL4F2
	 byXdxLtNQ8BBllZbQu8tKA9072Ix2RqhSru64h9bsz8CMjBkemKcdduUt41eYWoAXZ
	 YUGi1QfJzkivR/eo32PFbN+RfT53KhDzA5uDsUAFkf+NjhrAE7Cv+gmkQK65bUaNy1
	 mZX+btcNZdo1F6GrZ2AMtdZOny9eSkRdbvgsc9fPKAtGoaJuyXzoqp+jKrVw631iXR
	 MDoNFalnKrPM4ghaMbgvggVsrizXfrvHxnIRiNdy9oGxPDOauueylxR7S/mYhnjoSs
	 f/H9ce6iJ4jew==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d5ca5bfc8so1490943f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 13:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936385; x=1729541185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKWzm2dNvhWm9z8YkvsjycCHxzeK70hrT0KE+1kqPr4=;
        b=iplOAk9VhrxTuXFnecI4F7qgddmqOw5G7Voadz25fiIIaOb9xdJQ/V1zcF3Eu5OQNS
         ybqUF54CCIkXgtxd2gZE4UwbTlKwT4ezalfD1ymlpz7O9VyWdptoOQ+sy+6aKki+Hmzg
         D2vGslNAU68pkeCpuA8TS/lQFppWz/d1ZMOQUqjJ7SbsW6iLBWCP2wfrHWbLxN+eol1m
         jZZMAm9+pIWLvIr+WPYWMZWo/ypBQZf8DyM1cWLasp9RfYx9AwU6Y32zxlMLGAc8jgcz
         ftmDCnA9wGSSqNukPMmL1sqzzlK6xNQEUrDAmo27s/eCPlT2ITE4VeDRi4L02+D0I9u2
         0JrA==
X-Forwarded-Encrypted: i=1; AJvYcCX03fu8WmIbiRs4nHBU5GNOO/NeNSVjapMHS7VKQETTdj+GrCOhyy255Euuk1np0bczrubiRcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9VreFNRzRCMagCAE5ekOjZXXHBsvbJ60x1WwF+RN87WCOjg4k
	dlXVWHMLogyTQSZmKVIPcO8xN2vO7VmJULFAYA1ZKuHwJwTJty5Nt08U8iyBBOp1SGsZsJV2T9H
	i4m0k63ncIXnooFWcZ1/Zls4Xo7vAgyWxOvHXRWsUFeCVYQjX3T9cWntwFnO6LFwCYt47aZbprw
	6Ldpz9c04qWkkOPRq42kAO6UO1wveQZRVDzfjRO/tw7Z8D
X-Received: by 2002:adf:fa89:0:b0:37c:c9ae:23fb with SMTP id ffacd0b85a97d-37d5529ad6amr8623563f8f.40.1728936385578;
        Mon, 14 Oct 2024 13:06:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4Rv+5feZ6KMU+bI/PuCXsLMCpYt6xl/6DTOnQJErbOP78zNn0YELGl8S9OXhnnUC1Gk5vtffyIMyaLxksW1E=
X-Received: by 2002:adf:fa89:0:b0:37c:c9ae:23fb with SMTP id
 ffacd0b85a97d-37d5529ad6amr8623550f8f.40.1728936385133; Mon, 14 Oct 2024
 13:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com>
 <20240912113518.5941b0cf@gmx.net> <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
 <CAMqyJG1W1ER0Q_poS7HQhsogxr1cBo2inRmyz_y5zxPoMtRhrA@mail.gmail.com>
 <CANn89iJ+ijDsTebhKeviXYyB=NQxP2=srpZ99Jf677+xTe7wqg@mail.gmail.com>
 <CAMqyJG1aPBsRFz1XK2JvqY+QUg2HhxugVXG1ZaF8yKYg=KoP3Q@mail.gmail.com> <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
In-Reply-To: <CANn89i+4c0iLXXjFpD1OWV7OBHr5w4S975MKRVB9VU2L-htm4w@mail.gmail.com>
From: En-Wei WU <en-wei.wu@canonical.com>
Date: Mon, 14 Oct 2024 22:06:14 +0200
Message-ID: <CAMqyJG2MqU46jRC1NzYCUeJ45fiP5Z5nS78Mi0FLFjbKbLVrFg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Seiderer <ps.report@gmx.net>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the late reply.

I've tested this debug patch (with CONFIG_DEBUG_NET=3Dy) on my machine,
and the DEBUG_NET_WARN_ON_ONCE never got triggered.

Thanks.

On Wed, 2 Oct 2024 at 14:59, Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Oct 2, 2024 at 12:40=E2=80=AFPM En-Wei WU <en-wei.wu@canonical.co=
m> wrote:
> >
> > Hi,
> >
> > I would kindly ask if there is any progress :)
>
> Can you now try this debug patch (with CONFIG_DEBUG_NET=3Dy ) :
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 39f1d16f362887821caa022464695c4045461493..e0e4154cbeb90474d92634d50=
5869526c566f132
> 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2909,9 +2909,19 @@ static inline void
> skb_reset_inner_headers(struct sk_buff *skb)
>         skb->inner_transport_header =3D skb->transport_header;
>  }
>
> +static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> +{
> +       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> +}
> +
>  static inline void skb_reset_mac_len(struct sk_buff *skb)
>  {
> -       skb->mac_len =3D skb->network_header - skb->mac_header;
> +       if (!skb_mac_header_was_set(skb)) {
> +               DEBUG_NET_WARN_ON_ONCE(1);
> +               skb->mac_len =3D 0;
> +       } else {
> +               skb->mac_len =3D skb->network_header - skb->mac_header;
> +       }
>  }
>
>  static inline unsigned char *skb_inner_transport_header(const struct sk_=
buff
> @@ -3014,11 +3024,6 @@ static inline void
> skb_set_network_header(struct sk_buff *skb, const int offset)
>         skb->network_header +=3D offset;
>  }
>
> -static inline int skb_mac_header_was_set(const struct sk_buff *skb)
> -{
> -       return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
> -}
> -
>  static inline unsigned char *skb_mac_header(const struct sk_buff *skb)
>  {
>         DEBUG_NET_WARN_ON_ONCE(!skb_mac_header_was_set(skb));
> @@ -3043,6 +3048,7 @@ static inline void skb_unset_mac_header(struct
> sk_buff *skb)
>
>  static inline void skb_reset_mac_header(struct sk_buff *skb)
>  {
> +       DEBUG_NET_WARN_ON_ONCE(skb->data < skb->head);
>         skb->mac_header =3D skb->data - skb->head;
>  }
>
> @@ -3050,6 +3056,7 @@ static inline void skb_set_mac_header(struct
> sk_buff *skb, const int offset)
>  {
>         skb_reset_mac_header(skb);
>         skb->mac_header +=3D offset;
> +       DEBUG_NET_WARN_ON_ONCE(skb_mac_header(skb) < skb->head);
>  }
>
>  static inline void skb_pop_mac_header(struct sk_buff *skb)

