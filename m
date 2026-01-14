Return-Path: <netdev+bounces-249732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34582D1CCA4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 08:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D52663003B27
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 07:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292263590C4;
	Wed, 14 Jan 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vw+UjI7U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwjLf4jd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270A93587C3
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768375131; cv=none; b=RZMwjCI8f9Whn9zHIhbNtxXjBaqGloQvDT7v/7Qbv8xYw36PXMdpg/3PV+rzkQZCSJMIL9kBPKGym2vNA152+SVtJ0uIcPn+YRBFtfEguJk/9IdNXONXoYqWv/IKeqdJ+yQltALaNHOlJLSQ8lAIkXs3E2JX/PSJhhdvv5UGaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768375131; c=relaxed/simple;
	bh=kqP77k226Wx8tCQ/0jWeIHBXDlzM0lq0ign/yDhfiAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnuZd9BTtNRMPdtqQkqHR/VfnnUmssvvI8+IXplLVh64PN/UVhDsoFC769KwBmBRFXJ+TYHGAlE2EHY6VciLYkFdv8QnF/bqAxXQxUzeAGsEtyfNTL2I32ZS8kimYy+a+W5vh5cZlUj7woBXGK5LhgTNRQJFPeckQtt1I5V+sdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vw+UjI7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QwjLf4jd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768375123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
	b=Vw+UjI7UgeDsiuTK+AldtFGslG1lpa6BX8qwit8ktjV04T28NF/6JZkLXvWX+JezbhZZjZ
	blBvO00IdKaLRR7uXFex1toqeaiQRsB5cvpRNriGftNCRo1DS1vuj5Ni1MFoiHLkqUlU6t
	8ajpR1bV5fdYtvB7Na3Sqt175FSzlFM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-pOzYp4XRMgiwTzmu1fCPkQ-1; Wed, 14 Jan 2026 02:18:42 -0500
X-MC-Unique: pOzYp4XRMgiwTzmu1fCPkQ-1
X-Mimecast-MFC-AGG-ID: pOzYp4XRMgiwTzmu1fCPkQ_1768375121
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c6e05af3bso8962413a91.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 23:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768375121; x=1768979921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
        b=QwjLf4jd4v7iK7Jb9KwEPCFNb7YsGvratPiQCwV9o6Okk0pQNWozGR8RVAJixy12cA
         Z99aqllsIMJZbJwuQw22x947KlhTJEbDozH9fJn/Bx+b5lxpbVZtkF4k1FYvFVx6AXKO
         7tHQoUMFyOgDwksiqgwa6hfdZdC1FUj5/nYGbyzTZT0CvJbeb5+7tpc4YPxAEEqWhspz
         KGje0p/cWV1HaxeIxKggWwefjyjBv4ONknIP31KwU8sxnD/1UdHSjIBTGvw/0CGx81Zg
         3dIS1MU61tPBsBP1lo38wzGMUlGTu6t1VCDtl+DJNlxqJBbioPeyCUxhTtu8QFNAHrIf
         YNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768375121; x=1768979921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/19S94YPYflLVx22ERVlbrXJL08sz9F6OX2XWU/rfQ=;
        b=p1sm/CWsm9EgZgUAsR3kvxLrsHP9JnXZmRozeEBxAwIZXJVRBa+tR97YUaafA+tE0G
         8xAHaFAEN5Ubm3jfJJAiPmUvqbtElkH0AOLTQEDGOMyY1vnTsWt285w3mJ4j+y2lqqCX
         PE+rxaHIi4OIiihSTWNO8GLcYbNX0bSc60oFCGmGAgTquRJxjjDtYQXwB3rpOro1vo+w
         Rx0p6w23X/6WSd0/88iraa24UGs7Y847EraMGqJm0Wve+9FgoSngjZFYjvMU0/0Lu/26
         IwdNo4pQolSYdD6Ql4XhGA/TuWZbJyXoNuvQ4beBqavjeQx0FpyrIVWg+ZnYOorC06BQ
         a+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXms3DLIOJfPkKPnNRmh5gDycB+1KCAI+QCiCf77AYDsxCffmjjnISnOHu5XTMhfXhP47pCcE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNN2SHiWBMk/dBDSWXVdYPJpRyokd0fUL86eNG+x+BchQkyLs
	i7prMLy0UhotvSKvNc9jIa8oxZ4vMZIkveiBzoaOoHhnWWWp09uadbizfjfZUQi0ek3CMfUG5ha
	tYfd6yBIcV3fVXQDTbR19MWGlYQrSM3kQA9kCrS1zVifeKNIIpZQiYYbAt7DywEiffr85EZrPPC
	+UK6nUkm34P1VoJ6r+gUGpvOB6BHq0GSJg
X-Gm-Gg: AY/fxX5ZrIGcROkmdl7Hm+O4tsygS2hRlG7ySWIlQMc84jo2b/tuvNq41bep3xyfWeu
	EpnPMOLiIytmBLdq6H/AAF6uUdKHLKHC/4mqq/jyo6zuQjOz197XTCNYG8VbKYexiaX8jzkLdJC
	2U2un07xK8TG4r678XJf4HGrfv6aEEp3dPFH6boXKcL4yFE0MAWIVcnRBve72WbRg=
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-3510913fd7bmr1582673a91.32.1768375120981;
        Tue, 13 Jan 2026 23:18:40 -0800 (PST)
X-Received: by 2002:a17:90b:28cc:b0:335:2747:a9b3 with SMTP id
 98e67ed59e1d1-3510913fd7bmr1582663a91.32.1768375120558; Tue, 13 Jan 2026
 23:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWIItWq5dV9XTTCJ@kspp> <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
In-Reply-To: <e9607915-892c-4724-b97f-7c90918f86fe@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Jan 2026 15:18:29 +0800
X-Gm-Features: AZwV_Qil4_emZc9UC594LVQZD_WDE3u0sgwiGLvdx73MXFe_Cb2QNMYVC2G9b8k
Message-ID: <CACGkMEuFePpfpFvnJz6xvrKrVG84KmAfODP55cCJgFzZqba29A@mail.gmail.com>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct virtnet_info
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Akihiko Odaki <akihiko.odaki@daynix.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 10:30=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On 1/10/26 9:07 AM, Gustavo A. R. Silva wrote:
> > Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> > along with the following warning:
> >
> > drivers/net/virtio_net.c:429:46: warning: structure containing a flexib=
le array member is not at the end of another structure [-Wflex-array-member=
-not-at-end]
> >
> > This helper creates a union between a flexible-array member (FAM)
> > and a set of members that would otherwise follow it (in this case
> > `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> > overlays the trailing members (rss_hash_key_data) onto the FAM
> > (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> > The static_assert() ensures this alignment remains.
> >
> > Notice that due to tail padding in flexible `struct
> > virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> > (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> > offset 84 in struct virtnet_info) are misaligned by one byte. See
> > below:
> >
> > struct virtio_net_rss_config_trailer {
> >         __le16                     max_tx_vq;            /*     0     2=
 */
> >         __u8                       hash_key_length;      /*     2     1=
 */
> >         __u8                       hash_key_data[];      /*     3     0=
 */
> >
> >         /* size: 4, cachelines: 1, members: 3 */
> >         /* padding: 1 */
> >         /* last cacheline: 4 bytes */
> > };
> >
> > struct virtnet_info {
> > ...
> >         struct virtio_net_rss_config_trailer rss_trailer; /*    80     =
4 */
> >
> >         /* XXX last struct has 1 byte of padding */
> >
> >         u8                         rss_hash_key_data[40]; /*    84    4=
0 */
> > ...
> >         /* size: 832, cachelines: 13, members: 48 */
> >         /* sum members: 801, holes: 8, sum holes: 31 */
> >         /* paddings: 2, sum paddings: 5 */
> > };
> >
> > After changes, those members are correctly aligned at offset 795:
> >
> > struct virtnet_info {
> > ...
> >         union {
> >                 struct virtio_net_rss_config_trailer rss_trailer; /*   =
792     4 */
> >                 struct {
> >                         unsigned char __offset_to_hash_key_data[3]; /* =
  792     3 */
> >                         u8         rss_hash_key_data[40]; /*   795    4=
0 */
> >                 };                                       /*   792    43=
 */
> >         };                                               /*   792    44=
 */
> > ...
> >         /* size: 840, cachelines: 14, members: 47 */
> >         /* sum members: 801, holes: 8, sum holes: 35 */
> >         /* padding: 4 */
> >         /* paddings: 1, sum paddings: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> >
> > As a result, the RSS key passed to the device is shifted by 1
> > byte: the last byte is cut off, and instead a (possibly
> > uninitialized) byte is added at the beginning.
> >
> > As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> > moved to the end, since it seems those three members should stick
> > around together. :)
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> > Changes in v2:
> >  - Update subject and changelog text (include feedback from Simon and
> >    Michael --thanks folks)
> >  - Add Fixes tag and CC -stable.
>
> @Michael, @Jason: This is still apparently targeting 'net-next', but I
> think it should land in the 'net' tree, right?

Right.

Thanks

>
> /P
>


