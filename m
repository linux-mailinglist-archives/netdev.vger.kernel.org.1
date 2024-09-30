Return-Path: <netdev+bounces-130515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705F298AB7B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DA42826C6
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7687519408B;
	Mon, 30 Sep 2024 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxFOD4Zj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA461F947;
	Mon, 30 Sep 2024 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719242; cv=none; b=PrvUCq3yYtR3qQB1h4GrJVorvA9IeN20EQzpgy3okIK5VQiy/uKENtQ7f6nNNR82E3zzHIWdNNenQDiyqA6Oz+2lsSjT4XuTi4RUFxXaWZ3420/5Q9IAXRdwVayslIfCxKUGkbdJS8yT7gD0AupVP6Ef6N7/AweJtjJMrOS0lCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719242; c=relaxed/simple;
	bh=eUzqEWnnK8n3AvfH9YkmXsIl4/eedJiXX7mn9Lj0b6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7l41jHeGNN2nRYKFJF9Sl6FEdKMUJJrXkzv5cG/geuNe1ZLth/BwLeNtRlScs/Ch75nYBbdu6KEI/tDxxW5BdIiS2yDjOH/OhTi9nvgc4JsYoRyYK8janvLibJlfynZauQwH7OaVcwwwc/0MZ+WkKccjOD6Cl+ma/ivIv4GBHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxFOD4Zj; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db54269325so3509251a12.2;
        Mon, 30 Sep 2024 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719240; x=1728324040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WPYG6peqU3eI5ZWO2Wyp5w++2dVi5UxQZ4SZW1y5rDI=;
        b=SxFOD4Zjhj203kkM8jUAdM1VqDxTHb/w71rmMopTHQbTmS40Il9pfoCmHpgqiZlCxI
         LauCJ1ww6KpdhbeY2h0pNNgTwkSsQTC2PouxjUeFd29e2WbaTKOH5GVZcBi87P3nTGLo
         KK+lbM7aYRupGBzLsQOa1lHUmheQTGe+fNUXFZ2EGTgQInV0wM77HDCYcIP1XDHpuxmA
         dWLOmJDGiqvYhENYX8L5F/qhZfXtc+05tgghQG7Wm9ZYHjBCLTbl8EeXTIzRZ1HZVfBb
         pxemP+zgk32SRkww1TQrYJieGfL2U1QZOJGKUF3B92b4tHlnqGFb5FTbVb4T15nNNMke
         lI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719240; x=1728324040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPYG6peqU3eI5ZWO2Wyp5w++2dVi5UxQZ4SZW1y5rDI=;
        b=YPhOy0cxoJUAmQUWlwguD5Zsqwlejjw5C8wpvtUiSKJKSzOnqylgfgYVACQliZl9Aa
         WFx5EBQUv5UYIr6GuGIKvxquZm/sVpn9YfsVorEQvPa7JrWJgDF/NqGsYI68bgAAKh0V
         JpvUajL7BMuHRlwUaN8RAm21wmKe8W/PpPip7z/Kz0NFdXe0qLDqoKwJfckv8FAFMe4v
         xsHahs2eMHH5bpoF6VKeBwRAaqfvePqNxtYfzAiWCbQyV8sOe83h4nDzWAEi+knLeCkj
         RQhneBtNJawI18bkuXJObV0i0a850HhTqkkXxYeIv+vdbDxkdyhH3rwlASq5EmPgEwyG
         gUXw==
X-Forwarded-Encrypted: i=1; AJvYcCVHV5mOi0umXksVLF87xfeJvj/UNFh5Rirtk4kckzSKvtaCPnDI9rllMNUUXCC/UHxoNwoDefKhSajdlzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRqrHKzsDm39KvYOy8nhkhxHCM/5sQFXdPMgB+Nvxh5BcagTnd
	6aJZFwWzamZmPGNiqL5ChZP1g9oF4i/b3rNRe4M0UuNkR20vIEmyLxT8uZzG
X-Google-Smtp-Source: AGHT+IGnpeXNdXRkxDBjqhn8ix+HPICBDr5777u/at6LQYy8ljDqI9m1SVtR+TzKXMBINupCQw8P0Q==
X-Received: by 2002:a05:6a21:390:b0:1d3:292a:2f7c with SMTP id adf61e73a8af0-1d4fa7ab370mr19515842637.49.1727719238501;
        Mon, 30 Sep 2024 11:00:38 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next 00/13] ibm: emac: more cleanups
Date: Mon, 30 Sep 2024 11:00:23 -0700
Message-ID: <20240930180036.87598-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added devm for the submodules and removed custom init/exit functions as
EPROBE_DEFER is handled now.

Rosen Penev (13):
  net: ibm: emac: remove custom init/exit functions
  net: ibm: emac: use module_platform_driver for modules
  net: ibm: emac: use devm_platform_ioremap_resource
  net: ibm: emac: use platform_get_irq
  net: ibm: emac: remove bootlist support
  net: ibm: emac: tah: use devm for kzalloc
  net: ibm: emac: tah: devm_platform_get_resources
  net: ibm: emac: rgmii: use devm for kzalloc
  net: ibm: emac: rgmii: devm_platform_get_resource
  net: ibm: emac: zmii: use devm for kzalloc
  net: ibm: emac: zmii: devm_platform_get_resource
  net: ibm: emac: mal: use devm for kzalloc
  net: ibm: emac: mal: use devm for request_irq

 drivers/net/ethernet/ibm/emac/core.c  | 169 ++------------------------
 drivers/net/ethernet/ibm/emac/mal.c   |  79 ++++--------
 drivers/net/ethernet/ibm/emac/mal.h   |   4 -
 drivers/net/ethernet/ibm/emac/rgmii.c |  53 ++------
 drivers/net/ethernet/ibm/emac/rgmii.h |   4 -
 drivers/net/ethernet/ibm/emac/tah.c   |  53 ++------
 drivers/net/ethernet/ibm/emac/tah.h   |   4 -
 drivers/net/ethernet/ibm/emac/zmii.c  |  53 ++------
 drivers/net/ethernet/ibm/emac/zmii.h  |   4 -
 9 files changed, 66 insertions(+), 357 deletions(-)

-- 
2.46.2


