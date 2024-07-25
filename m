Return-Path: <netdev+bounces-113055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D227193C855
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EA01F216B8
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4424B2A;
	Thu, 25 Jul 2024 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="aZv+Tpdf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B2210F8
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721932096; cv=none; b=Bncea+raX3E2ectSzR33iV0XODUTcu9U7RbStjKp69szIw37YqFVUtbw6nckHovWV7Mhb7VjGBJfFT0QHqNl6y0c20KwrLm8n9sMnKcSfozXCWkGsukTgZr07RjHhABSzpDP4EXLUntG9JUzg3hMSIwQ3Ib+Fq7CF6cT+YZDJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721932096; c=relaxed/simple;
	bh=0BsPn8XJGCoCKyGda5EP4qIdMsX6K/6+DJmuJY1G6vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtzflH1V3fTxWzhRJwhmQr2ijSem2Ih4CbhgD9gly5dj+n5CYa4X+VApjBZtKFT/7SYMpMR9rDzMgDjyII73LhAZcsrybKNXZCbnuwH+8yejcG3BQb305Xo1JbQ+Ppt2CCeX8xsQRJYXvM7Bl0wMMXdah5U+So93KaCGzqQMIjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=aZv+Tpdf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1d6369acso102480b3a.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 11:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1721932094; x=1722536894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5TdDpFHtAeE+XTc1h1664SJXc3iu7oTM5G0nIDorDA=;
        b=aZv+Tpdf4qz4I1J+P5JBNuj+VnoujgN/YXfi4P5s5pnLIpiAUK+mp3XRzE0TCUljMe
         Pnd98k2W8SxqVYxi3pqtgdwjiwW1RRVu6jQtnVRSFYFUfGKEbdYSEDteLSrydtdZS4pV
         1MxxB+oyY8qCsHAGYHCY2zTkwcghnmk/x50L7iDh9FD/OzdquLj0vAHjY1FjNCDInZe6
         mqs9du+wMv3mBO2FLjlW0w2JbUTU6bt06uYia2rLAVNNUKyzayfgjRZJFuc1fBYLu3xR
         twEZxOox6/KKZeVay2P/9Pd9+7oknjWwlTwk1P0VhHnOv3ZDgVbHOYLf1K4S7N65Z4w6
         rYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721932094; x=1722536894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5TdDpFHtAeE+XTc1h1664SJXc3iu7oTM5G0nIDorDA=;
        b=SmD67bMOsO4zoMdGb9Hlv1zleYgDnymCC89EsJgXBB6k4ozCwy6RcuIR/PA4cPnOcU
         jxpKUKc0pjVfYq4wFmFBWDg9C21i24ve/VdqELG2nEYDSWF4qquAa57v2BHjbC2Ka2xh
         IRZ146nld8cIqWv/QG6kMK127ZaBZRtq42CRT+kJqXIsVLtx3EccU8LT2TdRP7+7B78I
         LQLN4zrKueixuDtQx9/yK2JInm7z2K/KSV98H74E4XR8SZ4Kgjh1Bbe10vDN3RyID993
         B0Mc162v2/+fVvrshYz/jcNY1oGUG6ixiJF86DlBYN7UTka9pe4IMluhr0Pen/pApi1P
         20fw==
X-Gm-Message-State: AOJu0YwOddU+98PcfCoQSQc0dNaPI5hi1Ryo/I7YZgfbuOaAbU6iGmDZ
	aY6/Jd3+SCZz79SerV3ZS2BqWfodCTAHF+ICYxRHLE9a0IesBnDE6WnpV/fYKcKHOJANfa0b5kw
	w
X-Google-Smtp-Source: AGHT+IG9w2iMZnTQR8Hu/MK5vZYISB3h+itKJfeA+MW7Q8bhaMBjTWM4M9TNXEx3N+ZyKltoFsexQQ==
X-Received: by 2002:a05:6a00:66cd:b0:704:151d:dcce with SMTP id d2e1a72fcca58-70eaa1e2e1emr5662816b3a.5.1721932094025;
        Thu, 25 Jul 2024 11:28:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e15d7sm1415904b3a.22.2024.07.25.11.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:28:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute] man: update ip-address man page
Date: Thu, 25 Jul 2024 11:27:42 -0700
Message-ID: <20240725182803.148491-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ip address man page had some small things that needed update:
  - ip address delete without address returns not supported
  - always use full words for commands in man pages
       (ie "delete" not "del")

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man8/ip-address.8.in | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/man/man8/ip-address.8.in b/man/man8/ip-address.8.in
index a5ae47ac..d37dddb7 100644
--- a/man/man8/ip-address.8.in
+++ b/man/man8/ip-address.8.in
@@ -19,7 +19,7 @@ ip-address \- protocol address management
 .RI "[ " LIFETIME " ] [ " CONFFLAG-LIST " ]"
 
 .ti -8
-.BR "ip address del"
+.BR "ip address delete"
 .IB IFADDR " dev " IFNAME " [ " mngtmpaddr " ]"
 
 .ti -8
@@ -331,9 +331,9 @@ to assign (or not to assign) protocol tags.
 .SS ip address delete - delete protocol address
 .B Arguments:
 coincide with the arguments of
-.B ip addr add.
-The device name is a required argument. The rest are optional.
-If no arguments are given, the first address is deleted.
+.B ip address add.
+.sp
+The device name is a required argument.
 
 .SS ip address show - look at protocol addresses
 
@@ -444,7 +444,7 @@ This is an alias for
 .BI proto " ADDRPROTO"
 Only show addresses with a given protocol, or those for which the kernel
 response did not include protocol. See the corresponding argument to
-.B ip addr add
+.B ip address add
 for details about address protocols.
 
 .SS ip address flush - flush protocol addresses
-- 
2.43.0


