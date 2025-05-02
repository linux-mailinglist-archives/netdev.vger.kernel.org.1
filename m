Return-Path: <netdev+bounces-187417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF9AA70BA
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 13:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA0C4C4C97
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37686242D95;
	Fri,  2 May 2025 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pR4bre/Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830161BEF77
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185912; cv=none; b=QNsYZqRkNMA+lSa0js6vCXApG3VSwaBhjyrU1LAaSgPOu7nIHzdWrtKsIx89YUnk1qNdn3SrJkN1nZaFl0gRbGjxgsSxQdh2+GKsnZd6WHg/MQ+IU6foGYizxtjappoSO7orugbmZ6S+HafRB5IP2DQp5Kf1yGCX+35eL7/mI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185912; c=relaxed/simple;
	bh=/Qfaa5IyFCCFoRULRgV1xt53mRz76tyNzsu9CICXJgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P9lWkafhO+AQppLoDAWYC2cBcRtdbzCWAi+Fo03vgiGsuLU1UjIYAjV91eIA6v5jYI82Rl/0v8UJgD1K/ifaES8UjcLi4UrRbMUCO5fcEB4LG7epA66wc7L6nEET7o4VdzKRf814cmTIbCoCfyVcpyqXyMnw8kAQR+5g3rIZmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pR4bre/Z; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a064a3e143so801727f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1746185909; x=1746790709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opE2Rk7Z/vvW9LY5nxxm+jPrTKbT89psF5fPgce7U/k=;
        b=pR4bre/ZqP3XtvetazXCKa4dyVINxn8KyVr1FhEL9NibGiDdyDDOHrziT3cbGrfycI
         MFTiEmrzg7/ECvUr49ozdbSaoBIhqytUwOGKixMVvnHAyeTHBAvkhyPTVwxDuUha96Cj
         cw2THCsD2M/p0Ieqm9DEQ1FhEnl8Ri6haeV+WIxg/i7DgoVd3wadS/7hNAgDbxKRCQj4
         Vtcjg6dqGyinpSvLpZJfuxI7HI72oixxnNXb7iN5YvvlSJJ8/WQqKuMNDz3QuuX7diGC
         PV0qfx2eRsPqG8N6TMKOolpr7WIEjRf1z/j7zq7xV2zY/TqYOgMMOBFTg5UoqqQMbnN0
         /8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746185909; x=1746790709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opE2Rk7Z/vvW9LY5nxxm+jPrTKbT89psF5fPgce7U/k=;
        b=Dt/HaFDoh1dIQmC5E4lcIqOeDbHq6P+RvGeZoNfxqkgz+51ckcI5KBIrG2hhxjH3Ig
         Gtx5DhnutFUxung+MFt9BcLSfa//nVdz8+siYclDBgkkpY03b2cR3krVxoGaLzuXp4QP
         e1tKUvgNKE28GIy3OjBE/xG6UPir8NMStkzBaw6N7RVLnK+d7vTmz/5nDGfHBW2UluWU
         LKkET09lyLk7LiJocDxBOzT3skFTzAHYaKAIjf2s7dDOruYOjdjp5T5WBruVlUA0b+Y1
         fl2kvPNvOwy52yxELEhIHKnbJKlFbV19kbkbOdUiOn8qrEW+IVIwYp/pP6PizrMbDwtV
         L+pw==
X-Gm-Message-State: AOJu0Yx7FZFbP+kzmYON5WrSgwGIkxLQfldeR1uLRYDryOkGTIebRITi
	UgOiRpXZ1wr/y9HGf10mrQ0pxEc1KQcRNXqrrk+BUR+cGtDtTehFfc85HRyyuPbNSNNMMKNfjrc
	+UCk=
X-Gm-Gg: ASbGncuEAh5mmo4YkwFsvziOCg8W7oblfzmadSxJ5T4WUhzXcoh9tUGNzSjbKMAU1br
	/H/F2b5Ch1h4My3tYCNNx+Uzpr5I7nNvw3fbIR6lBKLQ6R2wK8dBjaYmQoZA2tfMA8nWqO/z26W
	vGPGpMxGZ+nW1MNRpv1qV7Qjnh9r9mGl1G43v93rIc9m2WkeULm+MuOSQloz3G8wXDp/tM9dU/D
	JPK6DdN3M1ae6wHUcRXo9OtQ5ZslUinrhgAuuJUG/5vPw0np3HhtWJINt/sNBH9BnqwgEDBdkYF
	xjhiif5RQ72Rv8zEJpGhlruzR3LxKi++Jg==
X-Google-Smtp-Source: AGHT+IFCI92PiUuQm6fkrP/eygFzMWkhZEcuAdnmmMbLjS2Yzdm42SAVieEPAUTrfX7qyOyd8JMdgg==
X-Received: by 2002:a5d:4082:0:b0:3a0:7d15:1d8a with SMTP id ffacd0b85a97d-3a099ae9ce2mr1695329f8f.38.1746185908872;
        Fri, 02 May 2025 04:38:28 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7cbbsm1951621f8f.53.2025.05.02.04.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 04:38:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	horms@kernel.org,
	donald.hunter@gmail.com
Subject: [PATCH net-next 1/5] tools: ynl-gen: extend block_start/end by noind arg
Date: Fri,  2 May 2025 13:38:17 +0200
Message-ID: <20250502113821.889-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250502113821.889-1-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

In order to allow block with no indentation, like switch-case, extend
block_start/end by "noind" arg allowing caller to instruct writer to
do no indentation.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9613a6135003..b4889974f645 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1345,16 +1345,18 @@ class CodeWriter:
     def nl(self):
         self._nl = True
 
-    def block_start(self, line=''):
+    def block_start(self, line='', noind=False):
         if line:
             line = line + ' '
         self.p(line + '{')
-        self._ind += 1
+        if not noind:
+            self._ind += 1
 
-    def block_end(self, line=''):
+    def block_end(self, line='', noind=False):
         if line and line[0] not in {';', ','}:
             line = ' ' + line
-        self._ind -= 1
+        if not noind:
+            self._ind -= 1
         self._nl = False
         if not line:
             # Delay printing closing bracket in case "else" comes next
-- 
2.49.0


