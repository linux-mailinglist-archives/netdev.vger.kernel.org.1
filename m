Return-Path: <netdev+bounces-176085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF8A68B86
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B09C167FD2
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 11:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298E253F14;
	Wed, 19 Mar 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLdyJFiD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91D220C480;
	Wed, 19 Mar 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742383354; cv=none; b=r/GnVBPaL0edYUnpNXqL4UPyxlChSx4n4fXU0GmSy6cCBnwfs++9Z2S0Drn02seyWkq2gjal7Lhxan2VyS7LAxTKzOG1aB8/j3kZvW1YCYtJHekDo9JNh94fKTsBSiWu4A4gxKzrvBrAwxv4UuiLY1eb6dSNr1/+9OecndDdTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742383354; c=relaxed/simple;
	bh=osJJQcQ2nmAo0FdyEwaJWn0c0MRWHvUi1OLb8L87Z9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b0baWjamudxPHsiGESAo62iyfDFoefuT9jVDIDl0ayfA/QqqPj1cNPu4bPfN26+lITM2Id1nwbuQAewNeOiekns4EwsYhsaajKYbJCqcVv3wNIa0TSXWUrp8JK6ssOAXrjtEiQmtFFl10sF3lwSOIwFSRzR90FQnFzmesih6Fx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLdyJFiD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso45563125e9.3;
        Wed, 19 Mar 2025 04:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742383351; x=1742988151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbeE2fgp81u7MCwe3BPnaNUz6esZhVHQ8xy+UyX7a/g=;
        b=BLdyJFiDosH/X84AkGacgFEKnn39JPcS4OxoDF/cG8FHntYKQBZlNK54SKYOyyD2VF
         Mjy1U5cZXGcIn5UdnyAaI+IrlBNsESYZiwK23dP9lgAsb0obXGqIE7I2wB058z07uU9r
         4S0I8Rx81wq8X7zUwR9uocQx3sVJU9cWlrj4NMwPCGZnAO8RNjdVozA1jTi0qxAQ81Xn
         K7htSaZIJnjQgxNlUp0inRF8FBs/EZwkX9Vs0PciJP4S8aVZGmAdLGftdHp8bjaxyJZp
         JE7etNZCXEz8NtQ6KklmDR7RdhyPFSF9CjFpJRWX+qUeEeXCiy+tFMchGMZ7znXdGfLW
         6FSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742383351; x=1742988151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbeE2fgp81u7MCwe3BPnaNUz6esZhVHQ8xy+UyX7a/g=;
        b=IBwNMTa2cC04qCKY1vkHYa/QA5TI/qW32Rh1ICp8fxwhGztsKyJUBxx4zW7hTQj8n5
         PljshbLxXl9M6WvlmU7n8Eb8mXuhZslA4ZSBVVDmPaRTjPzqTzwJR0puTxR7g6tFa7U7
         kjXFCL6Wgrl+Xq0vUHUnqxPv4n1CA20/+WnwUEMMe1JF6jjmxl/j9QaGIEukLnWBoPzZ
         h7cl54OFQ85BtjlXgqUhlXKGB7sXm2qoH8P6AWqYInVmqO9nz/AUJWm7DIDP4Pd8TffU
         qdcvXRGVyApkuAXt/wpD5bCazW9AHnVd6AdULvOwUCO0rzNN/Xu3FSRYg2RBNsQbtsE3
         31mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqd3A3mahWyDAmVz/0MQIMPQXKC+nX6ktcX+laVe+CoAkOGC8VIgDpqnAtsrDAqIbkywGLyxQyNbGRl8w=@vger.kernel.org, AJvYcCWOeU7aDu2dTPmI6Ldgew3FqLgpmLgtFk4UCmzXrNF04RD+PXQc+bA+uVD2kxapk9a7JvSlV2it@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+H3tZ7IpkGo4Zb1IOka+EX4gUbdahrxpUcFeHbn4yh67JTnY6
	kF0Qg/jAtm2hQWYrD9OnO8kqb81qzqW46NJAc900rA2gRXupGQJl
X-Gm-Gg: ASbGncvDhM7BwJpyBI+cSC3Vq4RpIPmGxeCzCS7/JDhmbJu4Imed785UwmI1nXj/KiN
	xjafdm6yg4kPSyb8l6Wh+QPrSDiq1ovegCMI2eHYAjzEFJbhsrUHzspigR6JB1d6T7wxwqEqP1E
	/zFbySt26aQZeG/eVVJvpkGb/CmxbWo6w5dzcRHGiyxex6onprUUsOudTFvK4/o78OKgi5iRmt+
	xDjzquoj62vGOVqmSFDqITEQb2/++DE5bDGXn/Rfe9G/6MSITTudvGZyEZExputEFxF8uHmSMAt
	rWsoxGwcA6xFf4C10GZ1jGqUs+tjgSKJBBLLUOoDG4vK
X-Google-Smtp-Source: AGHT+IEtvR8KBMumARxwGWjxQg1PRfyg+4GfclicvVVuvjC+VjFTVVyF5Tz8P6tJPJ43nA6VNeT8fA==
X-Received: by 2002:a05:600c:3494:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-43d437a9710mr23798875e9.16.1742383350941;
        Wed, 19 Mar 2025 04:22:30 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:7659:65a:5e42:31a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f331dasm16129995e9.8.2025.03.19.04.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 04:22:30 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qasim Ijaz <qasdev00@gmail.com>
Subject: [PATCH 0/4] net: fix bugs and error handling in qinheng ch9200 driver and mii interface 
Date: Wed, 19 Mar 2025 11:21:52 +0000
Message-Id: <20250319112156.48312-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series aims to fix various issues throughout the QinHeng CH9200
driver. This driver fails to handle failures throughout, which in one
case has lead to a uninit access bug found via syzbot. Upon reviewing
the driver I fixed a few more issues which I have included in this patch
series.

Parts of this series are the product of discussions and suggestions I had
from others like Andrew Lunn and Simon Horman, you can view those
discussions below:

Link: <https://lore.kernel.org/all/20250218002443.11731-1-qasdev00@gmail.com/>
Link: <https://lore.kernel.org/all/20250311161157.49065-1-qasdev00@gmail.com/>

Qasim Ijaz (4):
  fix uninitialised access in mii_nway_restart()
  remove extraneous return in control_write() to propagate failures
  improve error handling in get_mac_address()
  add error handling in ch9200_bind()

 drivers/net/mii.c        |  2 ++
 drivers/net/usb/ch9200.c | 59 ++++++++++++++++++++++++++--------------
 2 files changed, 41 insertions(+), 20 deletions(-)

-- 
2.39.5


