Return-Path: <netdev+bounces-227625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 226E1BB3CE2
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AD01895E7C
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 11:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CB22ACF3;
	Thu,  2 Oct 2025 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GWgWwShS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7D21770C
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405569; cv=none; b=qhrVpFsZO8zcmJaVasuhqFM9OEyjDbml+e6ueT13FRtVlO6/FltSouBzZQlmbKhRw3Pu6Y2Ysq9o9VDPwXChxgeL6bnnBa8DJjFnaVOCTeXkIcTE6tK0Jzsrdha7fpqaNsZfNt/IzSrVF9E5BMEW5xWjto7kOJh5w1mQQqA0Bu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405569; c=relaxed/simple;
	bh=cyIdpxNubhuvyduiL9ujFYBh9Qvgfd9olUvMSZ6MOH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UvQcjN1PV18gu1JRGu1+soi2s6qSjA4RtrRIwzMRxI9auUw34RYg7szBKlETQ/3lOm7lbHPWZTW5SxvjnvksD1YC9HzDPVF0/1fRkfi+T5VBa3x2VGpIC9LhzE3Mm3bnXIW+mBIg2bXAZRdhKn3nvmXqFlbPZNswVbYRrmnX3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GWgWwShS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso2169089a12.3
        for <netdev@vger.kernel.org>; Thu, 02 Oct 2025 04:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759405565; x=1760010365; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nnAbOpa9GWwA8Mzz91fJKN8c6IvbEOIGgFBBZyPX5NA=;
        b=GWgWwShSwP65Pw8gqOM5pzOnnI7zSm7KGg9RtF5gk7R+suKm1VUruMZdEtgO1bTX+O
         /IhQ9IYjeQMrEToOT95pS7qxspr1i0Ibgob6O1Ju79CET8jIYYql3t1itmM8/MwxGLQb
         vjx6JhbnlvObf+S/4Wbs9DWMbzdAmo753lIpwQXVvTqk4hzEyI6p1kzvgsXewu1bvWNq
         9BNjy+nOTQqiKFRHNjdRrrbD1kj4e1EsjwmtXKgA525lByyl7FPo+cihGk4KyC/UUnBO
         PQ8kFQMvq7gZTlHZ5gbmdeZ03kqz2FDsSLITBgcje++2gw0KKbxDWD9xLZMipeudfiB7
         7VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405565; x=1760010365;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnAbOpa9GWwA8Mzz91fJKN8c6IvbEOIGgFBBZyPX5NA=;
        b=W2ab3nXzaS/bau7a59jaDEuh82NHxPHkdCpxxkvkVx55ufhD8Dnnk4QRF4py/n5IPW
         WioTwyqmfhhEzakLEi8TobtCVK8LNDr23xn6kS5Pnb390EooOmLsSiUz8eOCqtBe3c/9
         d4UUrmss9+kWxUlLir0kuTSw18bl9x1xx48SB52l69wG2XulzDlGAkKHxflxiLIzNtug
         wi8jYBEnukxaaxF7CyFr3/AkSDWATNFT4H/F0glDMYAjDrQr/WsJ3aOipH3+BpDv+LMK
         5f3RvBWt5B15lD1Gg0kmvgtHQt0fKmD2JokxfNoLU2gm4325NizoqErsirb1OBmPp/4Z
         PRYA==
X-Gm-Message-State: AOJu0YxEVxfmO96Q7yoRckatUxhhohlembeKdjytFuKYThKt1uqwXtd/
	w0de6+GkHnnltXwtulMxNYGkJTdcloIgx1jXzxYuIOdduBxTChpeiqjH+UgM63L/Xk0=
X-Gm-Gg: ASbGnctZQkjTaiqTwXCLrna72pz9JuEx8AwGAZHwVnQmz2ACkK6bjpDLz6G62OPodkm
	UHpk3SU0d2puCrQ1jTZfONjHUvZ+oaxPX79e50RLzJHvL75iEqJWuVtAN0yJBcyKE+5qiX8eWya
	plXQyiWhyOu82SSZcPTshNQR09wjk3vPtIeOyTyYVrAVS/7thScRYf2ILJ/BOXQdnFsegOp55iR
	4RZW4D28iXhaAr9Tdy7TLIC0XgofwfW1Zmq5u/6jbndvgv/Nt7DlIL0sI+XH+5odN+dsbFGakq9
	CP6jqAbKi5PmOGdv569RB4WhT/Dk96hAKMjoFTZ7eR4uZUyXfgK3s/vyWJpIhF12tohX+IP4n4Q
	NMXXXr0YDKcFiG3H0SUfPywvcahBvsJSeT2ZG5w==
X-Google-Smtp-Source: AGHT+IGkuWTBkQWQsXWA2WSywVPtCOF6XTskC6I1+kyLAhpousf+DMtrvWH/4v50S+KzgF58+1ViHg==
X-Received: by 2002:a17:907:948f:b0:b30:2f6b:448f with SMTP id a640c23a62f3a-b46e6816e14mr873905666b.25.1759405564608;
        Thu, 02 Oct 2025 04:46:04 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2dc::49:1c8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b57f0asm187094166b.77.2025.10.02.04.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:46:03 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad
 <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org
Subject: marvell/octeontx2: XDP vs skb headroom reservation
Date: Thu, 02 Oct 2025 13:46:02 +0200
Message-ID: <87h5wh34sl.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

I'm auditing calls to skb_metadata_set() in drivers and something seems
off in oceontx2. I may be completely misreading the code. I'm a total
stranger to that driver.

It would seem that there is a difference between the amount of headroom
that the driver reserves for the XDP buffer vs the skb that is built
from on that buffer, while the two should match.

In the receive handler we have:

otx2_rcv_pkt_handler
  otx2_xdp_rcv_pkt_handler if pfvf->xdp_prog
    xdp_prepare_buff(..., OTX2_HEAD_ROOM, ...)
      where OTX2_HEAD_ROOM = OTX2_ALIGN = 128
  skb = napi_get_frags
    napi_alloc_skb
      skb_reserve(NET_SKB_PAD + NET_IP_ALIGN)
        where NET_SKB_PAD = 64, NET_IP_ALIGN = 0 on x86
  napi_gro_frags

There are no other calls to skb_reserve there, so we seem to have a
mismatch. 128B of headroom in XDP buff, and only 64B of headroom in skb
head.

Again, I could be totally wrong about this, I'm not familiar with the
driver, but I thought you might want to double check this.

Thanks,
-jkbs

