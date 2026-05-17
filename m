Return-Path: <netdev+bounces-288752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /mGnFKrfCWqctgQAu9opvQ
	(envelope-from <netdev+bounces-288752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:32:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 340B0561FCD
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1F71300292A
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2DA327C09;
	Sun, 17 May 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SajrVGvr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A1311973
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779031971; cv=none; b=YGlmnK3kLjokK03qhGbD3Qt3hu0ilbMCAS69vELH37kCDVphoNjdt0ZcGAMV2z5pdUkjBejCfEABv90hMCwjzRftPY5zAh4PnK96ccog1BD3PzJOf48kBS+8AjeoxGim2pVEQMO5VX82Xn1qabK3KamHUURZ6gM2VFHiJFUxclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779031971; c=relaxed/simple;
	bh=nIkhANwfUYNk2cvMxwiDTqwmsh3YjN8mg0957jUG1dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hflN7wqplvnhqkfp78dAHXuxjs2b0owHKNLVlgGwHsRYWmyPuKIqqbFygI1eDcDG3H50F/wj5ZLqKGl0lcXwYw94IYTfo+fXJ5gDX6HEhMoKX1EnAfukzX9n/iQHmigNIXtyg5UVTbM7l2wmthKJQnGVX//iXhq338RfmzglVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SajrVGvr; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so15362795e9.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 08:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779031968; x=1779636768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K7luyMFctbC2xxMMOief5UX3f4LZLtzL3tSnkI5JFM=;
        b=SajrVGvrdmRL+zhorNnVx5YqpSt7jVdkJkhNivWoaWHIhoovKeQs+bB2q7y12OflK/
         Xv8qrpw4ehRdKG3xVaQ9Yr92SbNIr0Y2V4mE0DGU1RefLBocmrGkeYO7onL1X44G/EDJ
         zm+c+v/5rr/KWUutXTSvgINl0cKmQRh7wClkXznbfutVy2ir0Xn3xql2tqFzifH5FtQw
         iV0pL/DqAXxXv6tTi21hFJjBj+eUjVewVs41wLI1HCqReTLKJwEItoGCuiHbQg7/+EQl
         IkjTdcSpXY53GpUr4S4WC8LaXYZ5Ox9ANxlG87/TQPivgk6qWbJV/hRvNWPjEOQBEyHd
         k6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779031968; x=1779636768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1K7luyMFctbC2xxMMOief5UX3f4LZLtzL3tSnkI5JFM=;
        b=NCGO0e3qk53jM/SpSARC6lRIEXYD+4IXKV46Sk3iiKRPHRvxoG7H2Qboe7yCE9iGQe
         Za+lTMVi0unr1cszdUry1YepmwFrsfXR7+40wf9/vYICjpJns+Q6oT7KVpU3/htkRL57
         DhPlBAbQZrBuLH0ekWeKjl1A5QCQwCodSVDSBdkxA72ZA7ZIkZU7woi6PE7l65a9Hrlc
         4OTm8OoXHGhOrKaZvGr3kp3yMJB727acIrrs49e3FJhSezJpRb5jb1YMjiqm0CQDY6Kr
         yk9gKt3qDb0DaTfeLaUDEmFyYCVAnlTZUC+RUYll18p7jcojDcBSDWxfxg9vmpvc6DBp
         aKVg==
X-Gm-Message-State: AOJu0YyyKE+8dHBCKw1H+ljfpqN2XtJnqiMKhp12fuh5HWhJ0xCq8a1j
	5dPph8e+eClOe6UuQivksZCitQpMVGB9oMluR8et/LfHbvuxtEkkHAc=
X-Gm-Gg: Acq92OEbShAJr9Le4EqfECkbsOUcNp/llKI7vy8TdgELtJBoAF4XLU8yP+c98grP6wq
	tawGxmrQ98OBu1gUFxrmHdSMM9jtCh5DANXg+f0u0TrPZmxS1DbaH2vdFdt72b64J7vjV/V5L5J
	EsC4JMvjAoiked5IBrLmZtmv4OvrpLdos8mlDkpsHn6aixHWZDNiXvI6/ei0cmxTQqN4lR4Grjp
	AZEIonfGe9QyCxARE7uhQD4YRGIvIi3qHdik90qVoafiVMzIC20L0sMrCpGE5P6vL+6Fo2agPxF
	IbHVg6sv6/JWwLIXczQDaPeH1kQbkpjgXmEiBlrUg3fqakn4NPEjOQGP8VDKY6GfTfLS6NsWxgQ
	qE5Oz78MY42BHH7jlQsRCTqP0NXfaQpSd0aifzcMN+vAC9Hhz0JGJ2TfDjiUArVGk3ZCv0YE87/
	69OA3yoIfmLPF3bx5PJZCblSqWD4d+ZqQYtaEkGzkd4Mq2JYDIxROFAXk17EQ52tC39X/Xz4+YQ
	yq+ux9Hlg==
X-Received: by 2002:a05:600c:6098:b0:48f:d1b8:9ab1 with SMTP id 5b1f17b1804b1-48fe60ecc51mr191555265e9.9.1779031967646;
        Sun, 17 May 2026 08:32:47 -0700 (PDT)
Received: from kestro-laptop-linux.kestro.home (94-224-231-213.access.telenet.be. [94.224.231.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feab290e1sm95307395e9.2.2026.05.17.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:32:47 -0700 (PDT)
From: Jan Volckaert <janvolck@gmail.com>
To: bjorn@mork.no,
	johan@kernel.org,
	gregkh@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Volckaert <janvolck@gmail.com>
Subject: [PATCH v2 0/2] USB: add MeiG SRM813Q IDs in qmi_wwan and option
Date: Sun, 17 May 2026 17:32:35 +0200
Message-ID: <20260517153237.55995-1-janvolck@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <af3nDLa1A1JcTftq@hovoldconsulting.com>
References: <af3nDLa1A1JcTftq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 340B0561FCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288752-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[janvolck@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add MeiG SRM813Q support by adding USB IDs to:
- qmi_wwan for the network interface
- option for serial interfaces

Split into two patches so each change goes through its respective
maintainer tree (net and usb-serial).

Jan Volckaert (2):
  NET: usb: qmi_wwan: add MeiG SRM813Q
  USB: serial: option: add MeiG SRM813Q

 drivers/net/usb/qmi_wwan.c  | 2 ++
 drivers/usb/serial/option.c | 6 ++++++
 2 files changed, 8 insertions(+)

---
v2:
- Thanks to Johan Hovold for the review and guidance.
- split original submission into two patches per maintainer request
- Link: https://lore.kernel.org/all/af3nDLa1A1JcTftq@hovoldconsulting.com/#r


base-commit: 917719c412c48687d4a176965d1fa35320ec457c
-- 
2.43.0


