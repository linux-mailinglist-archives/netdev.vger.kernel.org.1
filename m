Return-Path: <netdev+bounces-176493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1327A6A8B8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B985F3B736C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7E1DEFC6;
	Thu, 20 Mar 2025 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b="n+mlRouH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E5E175D53
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481329; cv=none; b=rekrGVlI6Lp5ezxfnaAqZ+dTN9NCs9PdY8k2s8e6FbbdrDtIeotAkgCMSDbeyN/EC30LBH+gFrJcZeb03IYUJSABGKSC8kOODTRQCmfYK4ZsY68wQZmaClnnRKlH39QoDs4JXBhCKameJWKfWeEAluYtC4sLu1M27FEtLz6sPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481329; c=relaxed/simple;
	bh=n3xFPwrJPtxclM7S8P+g/6TIgiGrvVfs9QqNnV00cOg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=NxV/pA5C6CZm3x3F+47H4+SVLrWgpPA/8CKfXN5CICursb6oWMp3Oqh5yADS/eaUi6zzg63W3QTGsQRr+cZ+1n4tzKY5C9O76e2B8uZi5Bu3AjKbkaY7IRlHWsEG/t5FKV9iYA5c9rwYVJrqrgjCoZU9ja/TJoyFSYBhZGcXgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai; spf=none smtp.mailfrom=avride.ai; dkim=pass (2048-bit key) header.d=avride-ai.20230601.gappssmtp.com header.i=@avride-ai.20230601.gappssmtp.com header.b=n+mlRouH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=avride.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=avride.ai
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so5862655e9.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=avride-ai.20230601.gappssmtp.com; s=20230601; t=1742481325; x=1743086125; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n3xFPwrJPtxclM7S8P+g/6TIgiGrvVfs9QqNnV00cOg=;
        b=n+mlRouHx7fZnCFQz2S0IZRRi+yHI0uIt28ELJuI9XU7NBdoZrQUYaFXn9zGiCQQgI
         qrnwj4i46oM/a3fu3ONzS6WW0sy+81QWo9LLTX21u4/RY3afUAGv2xnN3YC0QR0+TTS3
         zl/VR0EHhCWq4eVfZ/oC24qd2f9HNMvbLmk32a80hZP1MQDBJZ5oyym7vmEixcbdHSc3
         LpN4r6Udlzx7gR1+d/ACXkydAzV27mU5VU0xwc0rPuSa1Fy1q7bry8wUzU67nB+YWLyu
         +RXA/u2My718jIrOvt6xCIVCfl5+en8hIDVbzT3B3rR5Oqb0oCGh4ftIiZUvhJKWvSEn
         BoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742481325; x=1743086125;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3xFPwrJPtxclM7S8P+g/6TIgiGrvVfs9QqNnV00cOg=;
        b=Z46hOaoYUkhi7ZjgOCd2DAdPNfdVopeO2yx/GAzx/atCUX6NqGcJCIicznEH0Ddsfv
         NXwUfkOnaiRQqNJ6NVgYig76P34Xh5RjyrcKpqj0u2/g2Y/zWCPzzhz10G1z3oXouxzM
         FnPzmPoHV4Jl70nENufnU6jtjZCrnnSty4QynI3xoI3oD30WSPxpb7pt2WegSmBo4Fhp
         kYwbxdX0MEq8OZ0xw3x00o5zUGzyTWbMdhM0RFTDfuXw8hD1SHOPAo6kp7goaRVcHPcE
         Vbyw1TYxpKsFaFSdR4imrSv6567Nf1iD8hRIf/SFjoLXXggDsD5Md4tUj4ecAv3QtU30
         ct0Q==
X-Gm-Message-State: AOJu0YzFsOpdlJ0MQm5CbvlFye+aLxoHEgbYtSw8/z1de54OspD1qNS8
	kiX5kINl8DlVk6pjwKRZ/Nd3N8JrN6OmSxVKHpZlpQIkgWZLVQSCHN10dhc6SOsEKxnQkperdOo
	D
X-Gm-Gg: ASbGncufF3eDidHO1wQM1ziSjkaTYVy4yB+KW2C5F/dyoLZD/edUbCuWTpdjXOxDPCG
	lx213cxao8gkAfUeJTfAtycxtVk7G+F++RpGParFRKxcQY6r2NhBihVhVGmM/8sTNr+gZTnpuep
	UBEFekZTu2/oUHowdrpHTXjqEdJohmQQk0+pPnI8kSCt3mfgezTdV8Cpfgrk6D3w1Fe4sGWSjbe
	s52XEKn9A5d+8QPyRV9T9u8k3j6xEecB6mFlZjtnjDapBK85ETm7HNoGEbVPrYUcgMzc6AgpBRQ
	6cAruKqMCYq6HYWatSaDlsNkq6VFCAFcqDQmlA4FEHMW/ySpc5iLNpxiYLRBLIJ0GA4BvfhoQg=
	=
X-Google-Smtp-Source: AGHT+IFv3iJTO9xK48CGSCzrOzQH4tL5nbghMGiL2zrpFUd2w4j2sx7LMW7jwpE/xy7tSO84+HMEvQ==
X-Received: by 2002:a05:600c:34cc:b0:43b:c95f:fd9 with SMTP id 5b1f17b1804b1-43d43780293mr65074335e9.5.1742481325270;
        Thu, 20 Mar 2025 07:35:25 -0700 (PDT)
Received: from smtpclient.apple ([2a02:14a:105:a03:dc00:625a:5dc3:5bc0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cbbc88f2sm24001313f8f.101.2025.03.20.07.35.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Mar 2025 07:35:25 -0700 (PDT)
From: Kamil Zaripov <zaripov-kamil@avride.ai>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: bnxt_en: Incorrect tx timestamp report
Message-Id: <DE1DD9A1-3BB2-4AFB-AE3B-9389D3054875@avride.ai>
Date: Thu, 20 Mar 2025 16:35:13 +0200
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3774.600.62)

Hi all,

I've encountered a bug in the bnxt_en driver and I am unsure about the =
correct approach to fix it. Every 2^48 nanoseconds (or roughly 78.19 =
hours) there is a probability that the hardware timestamp for a sent =
packet may deviate by either 2^48 nanoseconds less or 2^47 nanoseconds =
more compared to the actual time.

This issue likely occurs within the bnxt_async_event_process function =
when handling the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event. It appears =
that the payload of this event contains bits 48=E2=80=9363 of the PHC =
timer counter. During event handling, this function reads bits 0=E2=80=934=
7 of the same counter to combine them and subsequently updates the =
cycle_last field within the struct timecounter. The relevant code can be =
found here:
=
https://elixir.bootlin.com/linux/v6.13.7/source/drivers/net/ethernet/broad=
com/bnxt/bnxt.c#L2829-L2833

The issue arises if bits 48=E2=80=9363 of the PHC counter increment by 1 =
between sending the ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE event and its =
actual handling by the driver. In such a case, cycle_last becomes =
approximately 2^48 nanoseconds behind the real-time value.

A possibly related issue involves the BCM57502 network card, which =
seemingly possesses only a single PHC device. However, the bnxt_en =
driver creates four PHC Linux devices when operating in quad-port mode. =
Consequently, clock synchronization daemons like phc2sys attempt to =
independently synchronize the system clock to each of these four PHC =
clocks. This scenario can lead to unstable synchronization and might =
also trigger additional ASYNC_EVENT_CMPL_EVENT_ID_PHC_UPDATE events.

Given these issues, I have two questions:

1. Would it be beneficial to modify the bnxt_en driver to create only a =
single PHC Linux device for network cards that physically have only one =
PHC?

2. Is there a method available to read the complete 64-bit PHC counter =
to mitigate the observed problem of 2^48-nanosecond time jumps?

Best regards,
Zaripov Kamil


