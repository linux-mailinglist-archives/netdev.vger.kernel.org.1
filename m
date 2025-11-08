Return-Path: <netdev+bounces-237017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF526C4334F
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 19:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EED84E2C45
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAED537E9;
	Sat,  8 Nov 2025 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CP3FalBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFC025B69F
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762626335; cv=none; b=Qcow6c7Bq5O6GdtO6lIZwQz7RHma9JbSIYNyfUG7Nk3iZxM8b7HvO5eFk8abcmC+LBSF3dXZtRzXNMcRDqujQ9piMujdM9kKqD7LC+0ARnQsHCyyypzxeU40PXe9kSYVCkmu2dWmInVMoR+BJhUe44InBWvDVRqOjlq7exMjBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762626335; c=relaxed/simple;
	bh=OGxf28Ekd12gM5+tjODLefvhvfrvhPeU6fcrodsZnxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nOOhxtMMgDHXNL9S0z/4OnGr/2r1vJBPWpEwWtMzeH8vZxpWBT1K5Llo6j/ai1fzIwHb3APiLalhEMNkxyoGvbOqRIqeo7erESl7smwgyj/RShB4ccLhetHLsPIpnGrb0QLrnS+dQfKxuauDGM8Tg/VTM7OFrQIllgjKmokKcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CP3FalBk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297dd95ffe4so10110305ad.3
        for <netdev@vger.kernel.org>; Sat, 08 Nov 2025 10:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762626332; x=1763231132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pQV4GnxUWhH7PFGCxN2Nr0zgy8swadymqAEd1586zsA=;
        b=CP3FalBkfXpVGM8KWxDhBTBj62coccoXDt1j0r6yaA0wYXg028DDS9ym2wZ/Li6jqh
         yVYq99y8xW9x4YlU/g4nhiRy0GXLLESVO7Oa+QDzojgGD8+TubWPtmuHpIRd0f2RGFY1
         FdBR0QPiDh8lG1jvdl7pqObtm+s6CV/eZe3a/V9QjtlkVHwLjR8GBUzNLnAh/Q10qHAB
         XbTF5aLFuMV+9WmrWW45PfKQqrlKZniYj0cmD1F6by4y8QGQDJCwgoBWsoGyrys1w/9D
         2hkuYbeT22onnkTB6W+ISE7/mD28auIoUoiboUSyNkBt70nxORYqsE7xETFeu+hJ1q4J
         +n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762626332; x=1763231132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQV4GnxUWhH7PFGCxN2Nr0zgy8swadymqAEd1586zsA=;
        b=saPpFaqCzcAOZbwO1cBVdtKxXDtgtv60C6C6bLaGzMGrelkFXyq9wJDGUUlFzxTS1F
         1JMD64jTb5jNj2Ac87cAeWuQ2RjzN/dRnZKF1Y2i/O5oTyFnFP1EKIf51BOvqCz/Zeuj
         KrX57seAgsj7Vyf9czBHXoiPEYr2F2+UWvhcDgxjEoXvjorbECQsj4Xgt8BA7AMhf+2D
         SphzEnNaB0nZYepbEgAgpT/s/HUoxsmnI8Gq68JrvY9w22lcp7AjG57aCIApdhUFw6l6
         k3aFojjweKAlZQ4Jx7y3DdODXznJbj7AydIhrdIb7lx+Fyl+15Wrz89U8Rp25UrFO6TD
         yCIw==
X-Gm-Message-State: AOJu0Ywu8gSCsYH3MqgwNHMCEqyLhyHG9Lee5tWcdvYS/4Twt8dWek/A
	vBZ9uzjQfH24MgW/kZbVpLa37qtYw9fh/wTln7MXQJTwRV7FtERVe/8HPe4jelMpz5gw4TT9Hvi
	LrG1YJv0=
X-Gm-Gg: ASbGncvUtV861YyOvF7j+dMg1qVF0RWEQHyAC6Tmn70gYgN3zHRCjIGTDopI/HsjKGK
	bRCsMUb/aA7jtxMPBHZRrRwiMMPLWsKRkXQ3RglnHWQEC+V0MMRQYIdHCH/CZDXqmFwM/YIv3lY
	hRnhR+Sz0Q/0/wMGsYMDElMW4HTbgPB+QK+YbU7jGcMEoNg/LiF7wlDHU/gbtRPO+t7nU2t65RX
	xGAXgno0Sx6vVcG1hm5HNw+Taw0p11VdAAsHzizZS/F22wgOgCOmT5Eog+gZtfKHibX9fZoJvcl
	PbEHuuALZStRVHRtdOonJe3J33qm3jXlcDdFXmZlC/JV+U9DIv8OAJi4wflc0/AJwjNB56yNlPe
	mvsGiUp+qgJn9Rgim8E2uvscJqnQD0LWFO2F/AeLjiAd6uV3WURtaqt/tmnZDbE4yRfSNjlkFZZ
	wsr1Ii3SEBgZfMQFOtOMQMDAt6yhs5JM1xmHIXevE=
X-Google-Smtp-Source: AGHT+IG17sntRJ1PwcbaHOKPCNzqUg50U1EJQU8AAbhtb5nn8OsSUlIe/vSAuoYBqipW48NjLzWp2A==
X-Received: by 2002:a17:903:3d0f:b0:297:e575:cc5d with SMTP id d9443c01a7336-297e575cd10mr38030205ad.35.1762626332271;
        Sat, 08 Nov 2025 10:25:32 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c963613esm6809899b3a.1.2025.11.08.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 10:25:31 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] netshaper: ignore build result
Date: Sat,  8 Nov 2025 10:25:20 -0800
Message-ID: <20251108182529.25592-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If netshaper is built locally, ignore the result.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 netshaper/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 netshaper/.gitignore

diff --git a/netshaper/.gitignore b/netshaper/.gitignore
new file mode 100644
index 00000000..ec490216
--- /dev/null
+++ b/netshaper/.gitignore
@@ -0,0 +1 @@
+netshaper
-- 
2.51.0


