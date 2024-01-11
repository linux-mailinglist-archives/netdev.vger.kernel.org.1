Return-Path: <netdev+bounces-63136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCBE82B53F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01067B230A6
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E54D55C3E;
	Thu, 11 Jan 2024 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Jl6XVnZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D855C2B
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d44200b976so32968225ad.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705001729; x=1705606529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5wchxMLJIDdtw7nkvmYCJeO8akS/waSguaZY8y181s=;
        b=Jl6XVnZa6+B4lsj3050BeD4HWWiwnaEU+t5L0Pds58mS+wbfvI+6PdvRKLSubdSHik
         0dgn+dxVo3v7oYGy7dttwv+89M+gJQ62UMdvlUjaPuZXE7CDqt6O+6psalJnsNpMMneE
         AWfSA+S3ISU+nZK8QAo5zTrLpZsI1Rkh7zidWvf3aZ+xWHBhIWU3t/ZegxbOxxCKqZUS
         TWRK0ntnRTK0TkdqHu4k0yAL/opkYm6qhnjI05oYRA6dr3o/nOH9QRfh6HjpFUwtA7co
         PIcB20+IvbzMJjDvfnhhoUjh3m6gnNYMKW6Nt0mUbAY/r5AoSulU40iP+Aanalc4nHa7
         /k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001729; x=1705606529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5wchxMLJIDdtw7nkvmYCJeO8akS/waSguaZY8y181s=;
        b=UiJdg//NtZ6zzi/PE0Ujve/MAvHS2tggMFgVbuv5haV7wKeJDnVQWsT84FdCqTIXIl
         8gVj2jeiT50SZzXfxBY+SHvxTziWmkm6UUkRS37aN3LZe0Qs03rYYCJjdUJkZIEL84NO
         SzvCvL0ZbkU6Y42kX3Fk7E50RRFTpK5TExmUoxJg8fPNfeLf5YNEs65D93140tBGyePY
         RZ7dyoGqCjPX03Fs7OsrTkqOKt54ZU84VmwS4/aBvJVKrwaHlWO9Xpg2lQV1Xp8LG+Xp
         tUmfl0wuV0PGnpMIaI03Q10GODH45RpOtMM8CgHz7KLucSDzl3Bu1KKK5G0M7v4Hu37V
         Aamg==
X-Gm-Message-State: AOJu0YyG8FLbXBhSFuwLiZsNPDwcfbsNY8Ip9+jiwgfmTAX/NztaNscY
	XOW9DKqsn6XtULwZANPfj1vl81Ra3JrNNqGAvrj1BA+seciaTQ==
X-Google-Smtp-Source: AGHT+IGJYUtauertM1K9H8eFK8NhkpqP2hD/HOCmTz80gpwfzKo29QeipsI1ZHrDPf6jYZert0DOOw==
X-Received: by 2002:a17:90b:68d:b0:28d:e4aa:e8ef with SMTP id m13-20020a17090b068d00b0028de4aae8efmr264530pjz.72.1705001729317;
        Thu, 11 Jan 2024 11:35:29 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id r12-20020a17090ad40c00b0028db680bfc1sm4252644pju.47.2024.01.11.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:35:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] man/tc-mirred: don't recommend modprobe
Date: Thu, 11 Jan 2024 11:34:44 -0800
Message-ID: <20240111193451.48833-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ip link add instead of explicit modprobe.
Kernel will do correct module loading if necessary.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/tc-mirred.8 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/man/man8/tc-mirred.8 b/man/man8/tc-mirred.8
index 38833b452d92..2d9795b1b16f 100644
--- a/man/man8/tc-mirred.8
+++ b/man/man8/tc-mirred.8
@@ -84,8 +84,7 @@ interface, it is possible to send ingress traffic through an instance of
 
 .RS
 .EX
-# modprobe ifb
-# ip link set ifb0 up
+# ip link add dev ifb0 type ifb
 # tc qdisc add dev ifb0 root sfq
 # tc qdisc add dev eth0 handle ffff: ingress
 # tc filter add dev eth0 parent ffff: u32 \\
-- 
2.43.0


