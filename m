Return-Path: <netdev+bounces-146737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2879D559F
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A128519B
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC841D4323;
	Thu, 21 Nov 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhi5quU/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C123098E;
	Thu, 21 Nov 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229183; cv=none; b=AcJknMn+KPkIOrgt/KkqcS9YCh4+1HJFUTH8f5SRG1V7aZVStuhecSZ0zbKOMmZjutdU7PUw/g2l8u8HYeE8fZAcyRAAdTPDJc2W6xWy/cevYsgz+hRquJthn6eB+L9iM7OsCX2heIKDivmmXog7xgQJ4A0V0gi08equ/xO63i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229183; c=relaxed/simple;
	bh=B8qDvfPULVWvMgZkxlUWxZQtkkngTTpNRPkD7iLA/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W12tvZuA7VRyd/nv91jTNtCD69LB4PSkwzlsOYGIOP7cvUkX7F7XJs72oEcBX2GAIxaScX8fgKu/lWnCIwTlMlsLrhyixmEquKbYScWRYJrscHRzIko67hul6Ljv9A5Uut8Ru+knOPjsuHgvNykfJ94CqzBpCrBqy8NUhW63ErY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hhi5quU/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21288402a26so14344055ad.0;
        Thu, 21 Nov 2024 14:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732229181; x=1732833981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz00sH94+EWwFPuEsmTdejC/s0s5/Fjq48pe4/Lh2Cs=;
        b=Hhi5quU/1i8U8YNK7WikSRsaqGaMT4xVyQJC43ycztwCAVIlfssABbCIrWMa4n/h/8
         5JZ+wF/SbBXyVesnd6gBUEqp0Ssk/8wAUTV5BGsNxhNY2Las0dhERNJs0daPz4nalCqL
         ZiU8g5RlGhBmoj6C+ipaHIQ1nMlZTvdrdLLXbkGuHq632WaIXg1p2y2yJoHljhI2QaSK
         f9a0NBVtzkGnPKGvxRqBofDw2nHhXeJ9Sd5nW2G+GjeKkN1Q3dBj8/m7MMOoi4KTt9lU
         0OtsRTRiEiz2G1B8z5wTfcFUx2Ocfe7b0dELnD0tPdgwaiEvn+qX0TqwcjfNtAZlsteN
         +mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229181; x=1732833981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dz00sH94+EWwFPuEsmTdejC/s0s5/Fjq48pe4/Lh2Cs=;
        b=nqIVYqbeZtsThLxPZ+B1K1XZlvtQYauKcWetS8UwvgBXL4QpobFQoaEHMX4Nsollgt
         t6j3IYp7Kctstk45eKrsf2igbZpxLRE1LsbkH/YXLLf2QcgDY7KhUL2YhTcA+kXSl057
         jNB+Zpc/eDoE5Z3/Pn1x59pF46oSQYbOyyPzAcg2Yg+jso3Gelk5dvN/wmSXfw4L/xIF
         dMsmGxGFGRdz+2d+cVPS31vL3MHXoUIL4lF5OUqDVCAwNxp4F/TbbOUm1Wa1MtBFIhcF
         jBXDrAohQSrYMPQuLM4S1bj69fsL/qJ0oJI5miCkeCQK5036YMVdRT0kbhmYVAXCoQ4I
         RIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMepCXB+4Z+Z7o844OULyqi231WNhWY7V/igqDLmVKVCLO2iw3DBCCJXoqgBnyhUcsHLVSUDs6w2o=@vger.kernel.org, AJvYcCVrw/MMLp481zrxq4O6ceUBis5dadKIYq2bTjZwALW7r6R76crubNgAXU3yHAEC/wi+G1wTweMFxNC/qKA9@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwVH+i/YcDhohK/KgvKoJ8IEBJt9TCNgJcth6bb3xBVBQ0mn9
	dsmmSsAdoFhoO4j1etfnM8rANRoCTfic+bU8i66i77DccreMSuo=
X-Gm-Gg: ASbGncuho190bOSafHoXCIqetOaBEMlZHtGOY6Mt0thtJyVFe4CsddmRp5W1JReLEAB
	iHOlBHPxkJ2hFjd+NkbL+y52OlPMzkqpeTQjI8gg8vPEx6Kt5rMJiy9wrjiJKLOxs2jJfz5DHPR
	1cE80/1lnxBxUZBJ7xbOhgnqVPSNLVXIQre87HBmWa7u29MPs0dnQfN7vAIGM3/xp3XaFDj0dA9
	FpZPUlAhbFsGhH6U8la/6xxoJpgbK9H0DmtYGhDaenf6yn/252Ax8X2q1w7ExBm9NXuoHqjE6I=
X-Google-Smtp-Source: AGHT+IFjRI1i6uSTwsAPegQoHq3JoUEKY1x5RTEXDctgnlWzpbgDhhm9fmHuaQl4nvuurvM3efYaow==
X-Received: by 2002:a17:902:f711:b0:20c:dbff:b9d8 with SMTP id d9443c01a7336-2129f28a632mr11817765ad.37.1732229180892;
        Thu, 21 Nov 2024 14:46:20 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c760sm3502945ad.30.2024.11.21.14.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:46:20 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Slight improvement in readability
Date: Fri, 22 Nov 2024 04:16:04 +0530
Message-ID: <20241121224604.12071-1-puthen1977@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removed few extra spaces and changed from "a" to "an ISP"

Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
---
 Documentation/networking/eql.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/eql.rst b/Documentation/networking/eql.rst
index a628c4c81166..4f47121323c9 100644
--- a/Documentation/networking/eql.rst
+++ b/Documentation/networking/eql.rst
@@ -23,9 +23,9 @@ EQL Driver: Serial IP Load Balancing HOWTO
 
   Which is worse? A huge fee for a 56K leased line or two phone lines?
   It's probably the former.  If you find yourself craving more bandwidth,
-  and have a ISP that is flexible, it is now possible to bind modems
+  and have an ISP that is flexible, it is now possible to bind modems
   together to work as one point-to-point link to increase your
-  bandwidth.  All without having to have a special black box on either
+  bandwidth. All without having to have a special black box on either
   side.
 
 
@@ -288,7 +288,7 @@ EQL Driver: Serial IP Load Balancing HOWTO
   the load across two or more Cirrus chips.
 
   The good news is that one gets nearly the full advantage of the
-  second, third, and fourth line's bandwidth.  (The bad news is
+  second, third, and fourth line's bandwidth. (The bad news is
   that the connection establishment seemed fragile for the higher
   speeds.  Once established, the connection seemed robust enough.)
 
-- 
2.43.0


