Return-Path: <netdev+bounces-209119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B4AB0E63D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3DDAA0518
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD42882BC;
	Tue, 22 Jul 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+LICdLE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9B28751F;
	Tue, 22 Jul 2025 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222420; cv=none; b=FB0oIIhE2wLI2NYFaxedfPJg02KIKwYvcG1+YB/7hGOGJMi+PcOlye0lLGPcurjYqvUqUORw8Xxh+/nexDsiL/YdM7SkhvLli/1imsz1/BftuGEgaIZDOi47jBl8fjVH1K34zeE0FVglbDFOcHQN4pYNBjxLENCr16sBZTXaXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222420; c=relaxed/simple;
	bh=6/DG5Ax7DefKuSbsb8FH078AQhAi7Ut2Ot3M9BW1sXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmjHbsHepl7aiDMO0RlJL6mr9CYDlMnPH0cU40K2G9XPc0HaCIFF2vkIzQtnWwbiJao/Obp4u/IznOZcY2k/Q8IFDYd3pGgcDsyussXW3/NXcn8KEU2K4vr9HoS6Y8hJFBYLWUStNN4UJdhwDlHO1Ccz/abN7bg18chTfu4jfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+LICdLE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab380b8851so52134141cf.2;
        Tue, 22 Jul 2025 15:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753222416; x=1753827216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6/DG5Ax7DefKuSbsb8FH078AQhAi7Ut2Ot3M9BW1sXo=;
        b=i+LICdLER/2zuJhFpJ84JCK4W9fCOSMXRD/WrIBSH7Xq6owcl5SEsWRi2isEeWLCKn
         5F41Lj7rbI4QvrOIPJoRPl7aemgY9ywOvMxGZaRts93LLd6dLGmnOMuahAqMXpkOo81D
         zJyoHMBxHdYXTzQtvVwe/j1a/BfID9Hbz1UEtDVQf+DMxhkER4jAFPautZ/Fmf8ZTbLt
         4lRtigXTdQAuD0BXjKGw4O3GflAgoK2nvww1LAqV4LeC6b2UxCu2MhM6MCZ1gVO+NDVr
         7vLyxwz1gvI1N8Aqi1jS4NTkDTtB7mO6Sx3qz14nBv4cJ5myg6f9SXx0UDPRbydNvwyA
         cyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222416; x=1753827216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/DG5Ax7DefKuSbsb8FH078AQhAi7Ut2Ot3M9BW1sXo=;
        b=NOV8mtELzEFRSVg+BT/t8tu9auOBIrpp5lIlwqAD2YJTcnySRs3yzHumkMvl/mWkef
         IvLd1Lml1cAsZrraIsXQE3Lj6yBcPUsSbVJpDkyuna3MMJlcemsEPHR2vkmQA2RtYuoB
         BuQfAH0HNWT0WUIWEawitMzZP0rAKPIFaE5TEKHWt9yaBqqDaJmvvHTxbZ5E9vMuUPds
         1qfU3geV0srwB7HI0Ydr5jAWjc1/gclbp4QC0RhM86kokjGV1RxSmiNp/bC0WPv4ZvNN
         Bw2UbutwFaNh9sixiyezP7UjXb9wAO8xYtji6xyP2W2HtOZNp0Bw3ffqfBXJprYOpLlV
         21RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+MzPrUykpHoVPSCsKxXLdJCvc440e46w/gvh4D/YeH/sscgIj8mhg8LjYvA2V/2DEgASus0RHRQ6lYCA=@vger.kernel.org, AJvYcCX02qyl/PyMgsv2OmB/OejuX/DbWLQ4eT+vqMvXQVj0/EH6jqH+3YjBC6dKmbarJIfhPUvxCTgm@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrWvbh3ifPrw6+zqJhP3a2+J6fBI+A0qzE4kNxaggRF2v6KKc
	O2QyjQGR5pRY8BDj5nam+5qAh2BMTKuMNVwSvNfCr9DsUj97av4g12pCWo0AgQO1VRI/AA==
X-Gm-Gg: ASbGncvlUewUw5qEyNlLuxu8Ki0W6Bs1XLvlhENhpOsPTnNazWgTzCwEQ459FxSbUGC
	522A4NJM0EEX4MPRZKq1CdO4WqDXXRG/2O4KRyDvxyLvrEf0mhb+ZSC1U1w0PjClZpvUAn4yOf9
	T9PDX5vKn2vj82DrI1HLXpVMCOVmFOQAtgWjpPjx2cDHsARbCLrP6esaoa3A1R5bs2KP0iBI59T
	8RGRGwsEh0650Zqnn+AJffEabF627k27iVULwQWxWjZC7FaqMF6jRjh16WQ+yGFnc2VZuHRAnIx
	FfY539s6jtyKQ/B+teH8teN0fPmIUkBNpiA9/HSATnyxH9cAMnpw+rH4ZsU36pETLZcUKKxzRWf
	ypOUPbujgyF1ocDQZYAh1pEB0ri99h6I=
X-Google-Smtp-Source: AGHT+IFt/VJe8Vve18hXv16+SkMiiHIscsKCzciiZrSiTtJ+jPSOCXPvIhvY8wXN6QPZmTLddKIqOw==
X-Received: by 2002:a05:622a:d0:b0:4ab:5934:33bc with SMTP id d75a77b69052e-4ae6de2d54bmr11938981cf.3.1753222415792;
        Tue, 22 Jul 2025 15:13:35 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb49a0147sm60368531cf.21.2025.07.22.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:13:35 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] samples:pktgen: This file was missing shebang line, so added it
Date: Wed, 23 Jul 2025 03:40:18 +0530
Message-ID: <20250722221110.6462-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 samples/pktgen/parameters.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/pktgen/parameters.sh b/samples/pktgen/parameters.sh
index 81906f199454..419001ddf387 100644
--- a/samples/pktgen/parameters.sh
+++ b/samples/pktgen/parameters.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # Common parameter parsing for pktgen scripts
 #
--
2.49.1


