Return-Path: <netdev+bounces-160087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC6AA18133
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 16:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF01816BD16
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F7A1F3D4D;
	Tue, 21 Jan 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U087Brbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8432881ACA
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473755; cv=none; b=LQ3cnDcNFx0oK0ll8D/GEbwrqOPB6+N1mIHS7vpWC4BwB7Y0nITCJis+3XQfKVnJnqKLOJ8+kBZqAh0aLZjyuckquE24NyC2aaVTwf6ejzLzeBXKFbm/05loTBOzX1BLV9KAj8TfZ7i8Ui3RNFyjBhNvPSrB3xGICd5VfFYmyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473755; c=relaxed/simple;
	bh=QKc4g2WBu8GFkENtwOHPQDOhpL8lZPTFWNB9sbaaGzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g39pXONZ+YXqDzs2Y0vh1uwpr10ZYHu3lUHhxaQHdZJjxCTRO/WN4sDrqgDZ1ZtAMGShPyt5RzXa9nSRo255vmLsSQXOaNKaGHRb3kL4/CLVZ0QtouGc5DTyneU9l7biBkrtaSFC/Vn+X9E6VVg7/IJRfLyhjLN7s3ZBqkBf9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U087Brbq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so13555988a12.1
        for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737473752; x=1738078552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TR5R4qiN+ejIDdDIkVSXrZVAGsuQzro+UTLnH2PKoio=;
        b=U087BrbqcUwW9g4cjpDCC92udphO1R+EW7ZW2ciKMPZh1DgWrALNHiqXAlAUEurPNx
         mSjBvZPbJb83jGkN2WKBW/VpIFwnaP/EgHbxnU14iPPgzQMVSs7lJiq7bekh4FyNCOxB
         808pxPMWE2jzKnT35gpNm6hMFA+oYCJRO0uIRjIAGduilQeVmSo/ZYzx9cBH1Zh/qBjx
         L1cxxmdM4Stgr0Sq0DdXDCpy7ny5avM5RYc5g07RDu4aGdS72vIBH/cUT2WB47FGtRzs
         CeQXNIckvYAEPH9k8Ncf4lEncD0t0YXf2yOtncxChfBWqbrxb7tsv8Jnb4zwIMI88WDx
         iDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473752; x=1738078552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TR5R4qiN+ejIDdDIkVSXrZVAGsuQzro+UTLnH2PKoio=;
        b=r5jDRIlnBcIdSp5aCNaXfmaGfV7l5C6eDG87BBkBoiNr0OvG9JDE4P8gTDrWpaSGa+
         YFBsi9ujGxEBpHxxWgTVZtTyo3HuamDRHiyzcke1Uc8qOg/B2r9JncTlhipZS9/KQOb4
         qmpl518353uEG1ARjHN72rC38R2/J+mVwO0gNmMttSRWy0nn9EbC4x/toSQFJfLDhPlI
         yQJps706UJDPFMcLjR6k2nBOJKRZHExG9IHZ1v7rGKvr7Rgj7sb4BIYZ5hm18yowksd8
         nobcrCu6EvGvF2bn3beuhcB3cCBjTxO3Z6yULROAAmtmkpG6K0BUy8TGmW8T0FU3WO71
         BvdA==
X-Forwarded-Encrypted: i=1; AJvYcCUn/L0Jr3piqYzKftHDQkF+n56N1FQYomQ/zMAJ4ZuyPWse12V71n5c30sg+6LC0ZfSQPl2UeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtvDsGY2trDb5jv35VK02UG5QVtnKiQXIBYjPzgxm8j4EhX6am
	OkiTIbGEwXN6W/ptFRCPYXkIaTSkDpOF2bSE/t79irqrIZ9oiCxGWZzBj8f+xLCLLCTu6XYwdcq
	f3J23LAkpl8okemPd8P+8scWBin2Zsb1khB6l4CiyjtbXzgxkXgb6
X-Gm-Gg: ASbGncsuC0q+euMg4NUeLrphvDL0WlsKXxoue3bqGDJ+8XnwLuMJjElzZyU8t7xV9m1
	Dams415UI4p/g2aEdSbD/m9UhXyxu4Oyd42/VRjk3dl8EQLw/lhw=
X-Google-Smtp-Source: AGHT+IGjXY4Il0vsLyEtPwoPn9s+ERxEe38SIZHR0tsHYmrHWi6gjZ8wV0XBlgjxke0w7JCBFB/FgaVu2EVbEGAt32E=
X-Received: by 2002:a05:6402:84f:b0:5db:68bd:ab78 with SMTP id
 4fb4d7f45d1cf-5db7dcec97emr15881731a12.10.1737473751505; Tue, 21 Jan 2025
 07:35:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126144344.4177332-1-edumazet@google.com> <Z4o_UC0HweBHJ_cw@PC-LX-SteWu>
 <CANn89iLSPdPvotnGhPb3Rq2gkmpn3kLGJO8=3PDFrhSjUQSAkg@mail.gmail.com>
 <Z4pmD3l0XUApJhtD@PC-LX-SteWu> <CANn89i+e-V4hkUmUALsJe3ZQYtTkxduN5Sv+OiV+vzEmOdU1+Q@mail.gmail.com>
 <CANn89iJghv1JSwO7AVh97mU1Laj11SooiioZOHJ+UbUVeAcKUQ@mail.gmail.com>
 <Z4370QW5kLDptEEQ@PC-LX-SteWu> <CANn89iLMeMRtxBiOa7uZpG-8A0YNH=8NkhXmjfd2Qw4EZSZsNQ@mail.gmail.com>
 <Z4-5zhRXZbjQ6XxE@PC-LX-SteWu>
In-Reply-To: <Z4-5zhRXZbjQ6XxE@PC-LX-SteWu>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 21 Jan 2025 16:35:40 +0100
X-Gm-Features: AbW1kvadDJX6U5pxQtLi7B45G7Hjd0LrLwFwwSiwbfBCcjG8MPtdZzTxE9Fnkh0
Message-ID: <CANn89iJ0+==pXHdMBcAXDd4MFDMvtFQhajKWWKj5kX7gU+NtTw@mail.gmail.com>
Subject: Re: [PATCH net] net: hsr: avoid potential out-of-bound access in fill_frame_info()
To: Stephan Wurm <stephan.wurm@a-eberle.de>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+671e2853f9851d039551@syzkaller.appspotmail.com, 
	WingMan Kwok <w-kwok2@ti.com>, Murali Karicheri <m-karicheri2@ti.com>, 
	MD Danish Anwar <danishanwar@ti.com>, Jiri Pirko <jiri@nvidia.com>, 
	George McCollister <george.mccollister@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 4:15=E2=80=AFPM Stephan Wurm <stephan.wurm@a-eberle=
.de> wrote:

> I did some additional experiments.
>
> First, I was able to get v6.13 running on the system, although it did
> not fix my issue.
>
> Then I played around with VLAN interfaces.
>
> I created an explicit VLAN interface on top of the prp interface. In that
> case the VLAN header gets transparently attached to the tx frames and
> forwarding through the interface layers works as expected.
>
> It was even possible to get my application working on top of the vlan
> interface, but it resulted in two VLAN headers - the inner from the
> application, the outer from the vlan interface.
>
> So when sending vlan tagged frames directly from an application through
> a prp interface the mac_len field does not get updated, even though the
> VLAN protocol header is properly detected; when sending frames through
> an explicit vlan interface, the mac_len seems to be properly parsed
> into the skb.
>
> Now I am running out of ideas how to proceed.
>
> For the time being I would locally revert this fix, to make my
> application working again.
> But I can support in testing proposed solutions.


If mac_len can not be used, we need yet another pskb_may_pull()

I am unsure why hsr_get_node() is working, since it also uses skb->mac_len

Please test the following patch :

diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index 87bb3a91598ee96b825f7aaff53aafb32ffe4f9..8942592130c151f2c948308e1ae1=
6a6736822d5
100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -700,9 +700,11 @@ static int fill_frame_info(struct hsr_frame_info *fram=
e,
                frame->is_vlan =3D true;

        if (frame->is_vlan) {
-               if (skb->mac_len < offsetofend(struct hsr_vlan_ethhdr, vlan=
hdr))
+               if (pskb_may_pull(skb,
+                                 skb_mac_offset(skb) +
+                                 offsetofend(struct hsr_vlan_ethhdr, vlanh=
dr)))
                        return -EINVAL;
-               vlan_hdr =3D (struct hsr_vlan_ethhdr *)ethhdr;
+               vlan_hdr =3D (struct hsr_vlan_ethhdr *)skb_mac_header(skb);
                proto =3D vlan_hdr->vlanhdr.h_vlan_encapsulated_proto;
        }

