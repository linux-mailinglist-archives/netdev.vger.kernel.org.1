Return-Path: <netdev+bounces-154028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987029FAEFE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 14:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8D1661A8
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9691A724C;
	Mon, 23 Dec 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wk0HpNEI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEC715C14B
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734962071; cv=none; b=S9U41gc6Biqy4OdaivcQ3cF73YotWBRCatpenxNILK4D0ssERO/y+BvN8uABbiYKa2XVNNRVIAD+9C7OVMQ4d37OHtzKlN6O35d3K78692Po7f2YVjsRkQw2Fi1PQlqPOmEdXEWYYBlYFFP1T0q8V9762NC6Fkszjmh7jUbKRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734962071; c=relaxed/simple;
	bh=2tR0tHdxppZ0Th0u4gzOBhzdqgaqFMl4i0snZ3Dorek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9WuzjYaEKptEqAbaJjjRcheux7l4gryb3hcj8orLUh6M5UKaVpieVv0Q3F8HlwQR0R6eJZXwy6WFJgjfyD25ftR96CvW4Vp6bUdP4jtbKIoY0UqUroEpywUQa3zBQ9TY7l870G/pJg2PbcraBnsPffUtq5elAHwJO8ZeR3babA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wk0HpNEI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so5713465a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 05:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734962067; x=1735566867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ovtq2weSS1D30IURo+8Ucrl55aOpstkC0pWUE0w05lg=;
        b=wk0HpNEISFhjRLbPOwSSHo5ogwyxvubvboCdBWSe5i3cdXmlPkqdA8ePDu5P1vtSDU
         eE5fCiPJ8ZkLoANWE4DmE2pNRnSbrfcAxK0M79GITFu2hzbSvX8//WsrIxFFFcH4CsI/
         Uq6+MqVJtLReq72YP18a2NUl/zQ+Ny6r3HTnRetpAkgRMn6VH5cS7MOBZDCMX02qHwQW
         oYJiwQnWTTd0iHCSDMPbntiSjmOyZ3K5+Y/YVGT6x/u/TtlnBqraLJck+/ziYs8fzIiV
         ZyWht9Z1eBFQSeKAgqpucsjS2TIJsBp8ZC0qle04H5XvavajbwfmSFx9TeGhmdKxC3uF
         N4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734962067; x=1735566867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ovtq2weSS1D30IURo+8Ucrl55aOpstkC0pWUE0w05lg=;
        b=LzosiCYbk2W50o7WwGSnsdkplHv69jbOkKxp5aa5Qm4s1B0xTWcO99zOIywuklvhF2
         FbfQGSc7tR3IReD6qYDh043UtY9mDj/6MKjyMkXhBzk8Upyrmj+mqk4TCDqSOTFeqJvu
         XliHWEjQPTBzHiMPT/8nAY6HivVi8hOabPZ/yHDdLaKM0o5Fn0RctisOFIdisRbx1TxV
         lfHA4tlGdaEjFlJmaI8ZNiSOT/Xd/kfQ2i6eP3iROCmEZGpGu8caI0AHT+v4WUzCnJhw
         pxSvVoJBtzTkoOkg3MdiQAWsuus6J+D1mUzFLvqoSmmRamNtCnzz0yjB8DbDvaqZrW9f
         a9Cw==
X-Gm-Message-State: AOJu0YzbtSA6JaA00SGyo/EVV2p+8qmW0emeUFkqS5dAE/L9sZVR0HDJ
	SRkZ0HJFiWjXLPtI5F2KxeQfbVlh2+vYPqWKYlSgTBq3+7ZuH2y/ukVXJzTTFZqtQBJmElswZ4+
	GnnZD0Am561e0pjzc0d4Zt6H3z/54Vwm7DQ/R
X-Gm-Gg: ASbGncuLYPdH5zCCFqG1TDQr5ubDMTXKpAuLxbQ0+wxzG3JxVSQtjAwj7ZKk1gAT7ul
	0koXbGagpp0ocpO/HCS8RuE+9S3kM4sl7Se3VDCk=
X-Google-Smtp-Source: AGHT+IFKWmkU37S+unHWeoWHc8oy5IT7C44YHR5MhNJ9i7Ss5IMdoZwM8JZW7eLF85ec7GXq49CF2MjJc3C6dQcCRoA=
X-Received: by 2002:a05:6402:5243:b0:5d0:bde9:2992 with SMTP id
 4fb4d7f45d1cf-5d81ddfbd83mr10915095a12.26.1734962067464; Mon, 23 Dec 2024
 05:54:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220142020.1131017-1-antonio.pastor@gmail.com> <20241223133915.2333146-1-antonio.pastor@gmail.com>
In-Reply-To: <20241223133915.2333146-1-antonio.pastor@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 14:54:16 +0100
Message-ID: <CANn89i+9Lt78ErDdbgVuOgvSy=UBz2Vhnp=cJYGvwuuQLp6qjg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: llc: explicitly set skb->transport_header
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 2:40=E2=80=AFPM Antonio Pastor <antonio.pastor@gmai=
l.com> wrote:
>
> 802.2+LLC+SNAP frames received by napi_complete_done with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. As snap_rcv expects transport_header
> to point to SNAP header (OID:PID) after LLC processing advances offset
> over LLC header (llc_rcv & llc_fixup_skb), code doesn't find a match
> and packet is dropped.
>
> Between napi_complete_done and snap_rcv, transport_header is not used
> until __netif_receive_skb_core, where originally it was being reset.
> Commit fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> only does so if not set, on the assumption the value was set correctly
> by GRO (and also on assumption that "network stacks usually reset the
> transport header anyway"). Afterwards it is moved forward by
> llc_fixup_skb.
>
> Locally generated traffic shows up at __netif_receive_skb_core with no
> transport_header set and is processed without issue. On a setup with
> GRO but no DSA, transport_header and network_header are both set to
> point to skb->data which is also correct.
>
> As issue is LLC specific, to avoid impacting non-LLC traffic, and to
> follow up on original assumption made on previous code change,
> llc_fixup_skb to reset and advance the offset. llc_fixup_skb already
> assumes the LLC header is at skb->data, and by definition SNAP header
> immediately follows.
>
> Fixes: fda55eca5a33 ("net: introduce skb_transport_header_was_set()")
> Signed-off-by: Antonio Pastor <antonio.pastor@gmail.com>


11 years with this stuff being broken...
I wonder if we could remove it from the kernel, given nobody cared.

Can you at the same time fix net/802/psnap.c,
snap_rcv() is probably having the same issue ?

I would also use skb_reset_transport_header() as in

diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index 51bccfb00a9cd9f16318bbe9a8cc3fe2460912b1..61b0159b2fbee60bdc2623b6c73=
ed1651b17a050
100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -124,8 +124,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
        if (unlikely(!pskb_may_pull(skb, llc_len)))
                return 0;

-       skb->transport_header +=3D llc_len;
        skb_pull(skb, llc_len);
+       skb_reset_transport_header(skb);
        if (skb->protocol =3D=3D htons(ETH_P_802_2)) {
                __be16 pdulen;
                s32 data_size;

