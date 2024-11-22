Return-Path: <netdev+bounces-146760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D59D5990
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 07:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FB9B2172B
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB04D1632E1;
	Fri, 22 Nov 2024 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mw0DN9Yn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3013A268
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732258181; cv=none; b=ozQsVO+9u22X5TmUoHrazH3H5HSS6KJEaQEpSUxNEHsih6NPPM8Z691GOkjhZM15hEuqk80FR2YOfYaq6g9DWcCDuLBMff5YHI7ijNOEednVfVmRjYhOtyWlaCoJu9y0djgMIP89bimDPOqgPufDQSTpcEW6nTojQxp8eROJz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732258181; c=relaxed/simple;
	bh=cj8FxFYpnx2gePGZBk5MLl9r//X2HfwX0QSLg+uZxus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F6qLmXrURTUfcy8MfqST8UQNd9o8TrJNa4O5jsggEX6hNwk8xVURF7v4ql37+3e4OSkAMb7+eHc4jXD2qeEhzxfUUVg67T4EOyc0bSx7A2QFbr41k4AHkPeN6kxKRDGLqTCUniVTHkgBUAtKeR43Qa1wkOC84uIcEl6UdccyCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mw0DN9Yn; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e6005781c0so1085272b6e.3
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 22:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732258179; x=1732862979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Emi3zUI2rwJq2d7I1jD4qpcNMtg6QfnfoegZT//vDEw=;
        b=mw0DN9YnJT7gB87gYc6tKpMUnHbtN1rWITEfCTGCiB1Te7yWTiZCjmXF6bpEDBVqtR
         sxGCXZcaUAFE+9hX0Rgrc9rNcB34kvmHjQxS9icbRMi0eE1VeCeBj2VoIrJ5wMP+YGXn
         +kFYmZlIrUD3q4Wp15OxL3Va0+Yol76MttCyBPA1MUmL7KSk2r1+Pv5AWxvzDeQwUUNm
         PCbxLwgd7WXi0dlHcVwMcHTYeu0KUR/NH65WZlDIm9Jr7gCPtvPCbwYRfIS8bOCv+XPj
         QTAZa3VOAUd9MiQWRzlwT9ilegZXyrCs7ksT+FLQ4mkt7uShGsl7Ezf7jlUY7j0PlceR
         ARjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732258179; x=1732862979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Emi3zUI2rwJq2d7I1jD4qpcNMtg6QfnfoegZT//vDEw=;
        b=mnaNwVFv+oabKT5FYz4OdEadT7QVgWaQDeD0MjgDBSxEwA6IIA2mjisYXbb4Vg9Odg
         x/FFpbwXwDaST32HzpXF5dCgQKmlyC9rlsSQtqdq0pFpaTCUUFC0Pf00wsFtOncstyLU
         /Rd2LBDOM0ln0SOOLzOAtEiBo2Nq+QrK6NfCC4z9lcoNwQUg4wtxkl0MYxbpRIwj3jeh
         6YsQ9AfB9IOh8Uo72mUwZhjwQZu3AjHm9ySbLmid+IZ+vY0kkSTGMs6S+4TyLy6kRaBh
         X8KUjL/VgxD/XpC0yMqdeYcoAFC1YLMW6TtTSUPnBZ2FnfwlpVR7hLZASUQnPG3L5pF0
         91/Q==
X-Gm-Message-State: AOJu0YzdqKXhBBsyefNPPJw9/j6QHiZwPXQ6IW2rdDP2XQm52agWjSmn
	osxwhJehanFeHLQuNqI2kZJmVatQklQgglFQeixrc53yjcODTuPHEzBfgGSvfMFr9zOI9PqP4cc
	f
X-Gm-Gg: ASbGnctXm/XSuAPOCwkos4rZGntoRmmnxodfMB0pnNW2oD/CEEATH7SvR2TBqZJ72st
	cDSmCxNF0soXHCdceKEKRQBzDfjBSTMNkvDNd9c+6LdyCmm8U0flBl8/pC12srl1Lewi4wRENdC
	fIJqOC7cMeI5n/WIexpeJfoUn5HS7tspQNZrMHce2plny9o75Ez3PF/jmUOJdafhzCTkJKe7jYE
	UGYA9lGGeRJiUsoZDao4MQGOOEDX3VrEzc=
X-Google-Smtp-Source: AGHT+IFzHVL9HHw1ZCHOGDXKN5ZD4NNLoyWiLGa86h+QJ/tH5Qq+a22B3czoBeWlo3Uq4MwGR07Jww==
X-Received: by 2002:a05:6808:3510:b0:3e6:18b6:4bc3 with SMTP id 5614622812f47-3e91587829dmr2356252b6e.24.1732258179237;
        Thu, 21 Nov 2024 22:49:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e4c4d7besm499053b3a.103.2024.11.21.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 22:49:38 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org,
	Mohan Prasad J <mohan.prasad@microchip.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net v1] selftests: fix nested double quotes in f-string
Date: Thu, 21 Nov 2024 22:48:21 -0800
Message-ID: <20241122064821.2821199-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace nested double quotes in f-string with outer single quotes.

Fixes: 6116075e18f7 ("selftests: nic_link_layer: Add link layer selftest for NIC driver")
Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
index db84000fc75b..79fde603cbbc 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/linkconfig.py
@@ -218,5 +218,5 @@ class LinkConfig:
         json_data = process[0]
         """Check if the field exist in the json data"""
         if field not in json_data:
-            raise KsftSkipEx(f"Field {field} does not exist in the output of interface {json_data["ifname"]}")
+            raise KsftSkipEx(f'Field {field} does not exist in the output of interface {json_data["ifname"]}')
         return json_data[field]
-- 
2.43.5


