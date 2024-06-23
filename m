Return-Path: <netdev+bounces-105940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA3913BDE
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 17:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE0E1F21A37
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 15:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FBD50F;
	Sun, 23 Jun 2024 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsuTxxDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F7A20E6
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719154855; cv=none; b=lsOTRrGB+StQO6e1cqK8iB2jhmzXASTFopdQlYZP8p+Sx1IQDFj6jj8ooE8cPBd/xw8vplEwVy2W443VmIw/+6QDj59cc107yBCKLBWgb8qYrfJCiZP2vX11lfr/zTQV3IOwvG3OuYIyGVs5Lea56pZEFrBzlRGXsOsCegH7oJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719154855; c=relaxed/simple;
	bh=D+EGc0XhbYxettGeUN2vbWtc+O0CB/mugoCtbu21LX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZmAs9ii5VxpxyL+ahRJN70gsEO3dP6xh0mM9YY9DNjZ+KkVzzyvNGy21f9XDl/4rlOeWxXApeVhC3+8vPViLm1bCMo5+e/BavA6nJkFCavzUh/4k0K76Y+hfv++xWMksbzrRoy3Ft21FMSYCwt5YVb40BteslKXLsqJFmKi8RFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsuTxxDO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421cd1e5f93so26669005e9.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719154851; x=1719759651; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D+EGc0XhbYxettGeUN2vbWtc+O0CB/mugoCtbu21LX8=;
        b=IsuTxxDOtNIC3Rz6eesMARYdPl9NbmgAX4yeNNFlxP0nEcZFkT2Osqzt3keIE2Jkwg
         N3zl6wVnIwbLoR0jSUYK24vDNPlmoGs8aNcXr5yVGvw+o9gfy7A9VTE/FjPKdarFy2ww
         +g0/MjHPfdSkyakha6W0b6swasB8H0Ez9agNf+OZ+/wQs6YmDBF4waKn1umfUTnG1Ayf
         IyEIzTxTfoG5UKJHcRZR5zKuIFccn0jxLr2VKPen7GEOXrQMlhHeVL4tcnOmPiyB2ysc
         85ONEkex8rDtaIPHjPO/1dTN7Kq8w4M7rhNKwrRN0qEBED7DJQMNt4UrtKDyYMBZVzep
         LD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719154852; x=1719759652;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+EGc0XhbYxettGeUN2vbWtc+O0CB/mugoCtbu21LX8=;
        b=tpcvMS/CDnJND1igjLkgbnNC5Pno/beeThB8nxWMvsvXBZ3WHiKF08Ph3s1PGOQ80V
         51zomOEj31Kg2hYDVS/HkKImkIy54BgGqCYFaWlfd+QV8sl4h+c+oBYNF32sNzonyJAO
         y51qv7ScRCSgFov2Up8PY2y2FX2Ih7E7lrxA2kenGDeyC9ni3gsvpWO8LpYbw0Kady58
         7x2IpuvYdxjJ9Lfqg9/3/qJC2+lkz2SdfL9/Y8Z2l1GGc4lKf8p6F8/jVBKRkDu/qdz0
         1SlY/3DU5XMMwIM7Gta+fGkP3GmtXtWH6EMaoc+E7IIfAWO03iTQHjr/gko0vkMy8EIU
         Yn1Q==
X-Gm-Message-State: AOJu0Yyupn0CL76aojrGxyrib5GC2zjss2LzZC/0VBEtZ1EV8CwgEN4H
	hYqweWBe/TE1f8WLDldPWKP+rXzMb6RMqWX4ostyrRvrECg7vzKwzlkCAg==
X-Google-Smtp-Source: AGHT+IG07yIGrXi4GgXHGtDeIjc5ue+uD09jHWfSzXdSxLSRRa8VxYQTsx2wxGmDcP1SUkopGMPXvQ==
X-Received: by 2002:a05:600c:3b1d:b0:424:8e5b:390 with SMTP id 5b1f17b1804b1-4248e5b0824mr14308115e9.0.1719154851200;
        Sun, 23 Jun 2024 08:00:51 -0700 (PDT)
Received: from atlantis ([213.99.216.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366389b85cesm7704443f8f.46.2024.06.23.08.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2024 08:00:50 -0700 (PDT)
From: <noltari@gmail.com>
To: <netdev@vger.kernel.org>
Cc: <"g, hkallweit1"@gmail.com>, <ken.milmore@gmail.com>
Subject: r8169: issues with RTL8125BG on Raspberry Pi 5 + OpenWrt
Date: Sun, 23 Jun 2024 17:00:56 +0200
Message-ID: <00eb01dac57e$272fdbd0$758f9370$@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdrFe2fCUNknA+7tR9ercBJILb0Hlw==
Content-Language: es

Hello all,

I'm having some issues with r8169 on a Raspberry Pi 5 running OpenWrt
(kernel v6.6.34) + RTL8125BG (MCUZone MP2.5G).

As you can see in the following logs, it crashes with " transmit queue 0
timed out".
It works perfectly fine for about less than 1 minute and then it =
crashes.
The crash appearance can be sped up by running a speed test or anything =
that
increases the network load.

Maybe it's a HW issue since the official r8125 driver crashes too...

In the following links you can find the logs from the different tests =
that I
carried out with both r8169 and r8125 drivers.

1. OpenWrt + kernel v6.6.34 + r8169 + ASPM Disabled
https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-ope=
nwr
t-6-6-r8169-aspm-disabled-txt

2. OpenWrt + kernel v6.6.34 + r8169 + ASPM Enabled
https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-ope=
nwr
t-6-6-r8169-aspm-enabled-txt

3. OpenWrt + kernel v6.6.34 + r8125 v9.012.04
https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-ope=
nwr
t-6-6-r8125-9-012-04-txt

4. OpenWrt + kernel v6.6.34 + r8125 v9.013.02
https://gist.github.com/Noltari/b56128eee8e75b57437a860c7c6b8bd5#file-ope=
nwr
t-6-6-r8125-9-013-02-txt

BTW, the same device (RPi 5) is running perfectly fine with a USB3 =
ethernet
adapter (RTL8165B + r8152 driver).

I've ordered another board based on the RTL8111H so I can check if that
works with r8169 or not.
https://www.waveshare.com/pcie-to-gigabit-eth-board-c.htm

Best regards,
=C1lvaro.


