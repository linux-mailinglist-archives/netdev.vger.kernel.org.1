Return-Path: <netdev+bounces-196845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21EAD6B0A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580D37AD143
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316122F16C;
	Thu, 12 Jun 2025 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPtthYoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE622D78F;
	Thu, 12 Jun 2025 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717480; cv=none; b=hJ4o4GIaHwH8J018xtpmNKOq6A1x1Q/98iRdHKOSLm9l/iSDJm9uHj6V/ADcENn0I/lBVAbWOTj7f7ptaZKVLdUysPmoftuBT7YpQLbqbQmVDAynIQ0evPMRPxjKHjxgzIF3pxPXA98VE/hWIVe48jcNjSd31ImKK/eyxQ/X56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717480; c=relaxed/simple;
	bh=XejVSRtPDX8wqZ/staI8F6QRFJxANYGNa1nbegLejT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iv8MpxfX6LlLGthnn3rORTdxU8voGpC59msrbml8xfMCLkjXrNyq/b2uibIc2D2n34F29aaFu288qzDY8zWtdq3cTj/vhSQbnVd7J0Qy9bNO0c4H+VBmUtiYGlKVgV9vGvviQsgnFP2i8NKP0PnOAKIJGp0OaC5Y8cFgGJbsktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPtthYoK; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so502471f8f.0;
        Thu, 12 Jun 2025 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717477; x=1750322277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7cH50gVxX6qICo5DanmfB424fMjg9VvlFFVHp3kmuw=;
        b=FPtthYoKC610aS5HWQfA2yhmWxuQ0QqK5oGhTfiS4JcvKc8TLWLCknPcPxP4dXqIaS
         jJwSIwJ7tWZTTodmfCUA/+i52y7lWA5+MhHpivwXVUGKa2CnxrRAJydUtVYopumkJXJy
         Cv7jvpiSuky/pnDv4aDK878ZjCHoRJV251kdC9oCl/uC2Iw2YpHM/a610fEn+db5PX+z
         BBuyqF9tT6EK4KYzhbx1RGaQByQIEmoMGLgvYCPEvlcrTnT2++NTWTNH7Y0KjdfbhniI
         AIGn26nLO63CrMnvRI0JjztRHQ8q2zQ9hDB419wvGR3K2CXblVQ1saSu8LOgF8rhKpab
         8SWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717477; x=1750322277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7cH50gVxX6qICo5DanmfB424fMjg9VvlFFVHp3kmuw=;
        b=EBhmmrud89RSLEvuCe3dZ7Us6oo2JSfksimZza20ka8wC/bd8XyCFUaQQCQLYWO8lR
         yjVFv7aX13OzxPHTpg6FLkIJBurcWcW7i8ZF/LeAyidMQj61i71l04wfYuQeOyn6ewVt
         jgCi6gd+d6vccs+t6jCSAduhlPS4U6kxQPVhJnr+j/Ouzy5RcJy3UZWcCv+Ang490W6S
         SOZMdt+xE7d2snzWd2C0bIYpX5jbfNB5wsnSySNArki+hKBAkLQgm4mHgTkv8jzmyjTo
         0vIsV17CAoUsCSRs2n5/RigYHQpZQLl3M5yB2bKB0TwbW24posLzgn/4sZzY9+1UuiEo
         wjXA==
X-Forwarded-Encrypted: i=1; AJvYcCUOTKVDxD3KErEfBIabl0L6rvGqspIDggKkZY6evULbzkL2M8uAEZdA4W2ny2I6CxY2T99mvK/A@vger.kernel.org, AJvYcCVrU1QDEsVAqsUcyuGLjCPoSqsklOBSjG2KtUbQCX9v2xCfmJrzKRfzKGUK6qbewowi2ZDeOB3/PbKDmWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUV78cdd9v499c7fY7RyB/VKqEKe24jB+SvU3hd8PHJaUHJ35p
	VN/0N7c4Tqwl43qBOVGn7QM++VS1ZXtNhMsBKgPFuAcPqVkEeg7OifwC
X-Gm-Gg: ASbGncure5xdUdF82X06FITanvpUyXmdg2Ot1lP2egVSBmHgpxtyCJnW8irLNvbMhs2
	7AQWY4W0mVkgo0zsLdRRVqliMiPgUZ4NqFB6W07xQ3Hzj0+N2vJgD+ZLLYomdt9ECPY/XrETGFd
	Dy8SURL1Njo18tqUhwBkWcmURWXF1ovQ+/6Fb3UnxLsq1/JNL6XlM7N1KYYw4qQB5p+Z//KgkdU
	ONrUkqnIKIc0rpR7mtRS1CzUifQRsdVeDqrP7rIE7cnhv4SqqPsj+tirkEtrudbL6KRIG8jgRJ5
	R4hexG8YfCoMxMeSqi+gD2Se12pObdwfRAFi7Y/x2VCOlM33H94K1Tq2v+tUybzaH2p+okJriwZ
	fnf/Jwne1Jv17ZrKJ9c8ycIt0uRsa7YTu6agvulfaQZ5901vJ6z0lAAFtZPPgdXpLYpjs/eHPPm
	K8zA==
X-Google-Smtp-Source: AGHT+IHYLFjic5AKHmX5O5c729EMv4fxnyD8SpuPtkh12oezKYHOxsya6Mj7xU/TivnYJ1QobAjh9A==
X-Received: by 2002:a05:6000:43c5:10b0:3a3:7987:945f with SMTP id ffacd0b85a97d-3a56076bff6mr1279137f8f.57.1749717477274;
        Thu, 12 Jun 2025 01:37:57 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:56 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v3 06/14] net: dsa: b53: prevent FAST_AGE access on BCM5325
Date: Thu, 12 Jun 2025 10:37:39 +0200
Message-Id: <20250612083747.26531-7-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement FAST_AGE registers so we should avoid reading or
writing them.

Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

 v3: no changes

 v2: no changes

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index f897fab6b5896..4bd8edaec867d 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -487,6 +487,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 {
 	unsigned int i;
 
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_CTRL,
 		   FAST_AGE_DONE | FAST_AGE_DYNAMIC | mask);
 
@@ -511,6 +514,9 @@ static int b53_flush_arl(struct b53_device *dev, u8 mask)
 
 static int b53_fast_age_port(struct b53_device *dev, int port)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write8(dev, B53_CTRL_PAGE, B53_FAST_AGE_PORT_CTRL, port);
 
 	return b53_flush_arl(dev, FAST_AGE_PORT);
@@ -518,6 +524,9 @@ static int b53_fast_age_port(struct b53_device *dev, int port)
 
 static int b53_fast_age_vlan(struct b53_device *dev, u16 vid)
 {
+	if (is5325(dev))
+		return 0;
+
 	b53_write16(dev, B53_CTRL_PAGE, B53_FAST_AGE_VID_CTRL, vid);
 
 	return b53_flush_arl(dev, FAST_AGE_VLAN);
-- 
2.39.5


