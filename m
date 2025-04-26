Return-Path: <netdev+bounces-186277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD62A9DCF8
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 21:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 554A3465A89
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024721F1908;
	Sat, 26 Apr 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="E8MfXg+3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B11EB9EB
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697333; cv=none; b=fmkbBWGmF0nsdpvb3Btrk+tn2mbavqrrdzEptfUhtjN4yhvX3Dcx5KCbJTaZPNP1Tr8x1M5todpBnk0AZufvPi6ABfiIMJacxK2c2RyEDCpbxmb8sa4hTMlRnchSOqph/vTEWQeTEhRggIez9T/Gd8Q8x74CQsOmMwsbKk54MjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697333; c=relaxed/simple;
	bh=zOxdGQ050cSN2HRN5uDln592bBavgK2vLhm0TLQJdlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fg7GjF1uFLRAtcFMd+YApLCwAuOXuUkHRqFNgBsu+nJuY2wOLUG2KLTAIME2mDtOpy5KSlLDSbvUejaaNL74+svX7PJVmnzXL6EN4sCArjzhb5zFlZ/40/A/jkziWGQLvM3pjZig52okv76PQUY1K9ymQmez4tWwi/T0GQeZwjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=E8MfXg+3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso3405746b3a.2
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745697332; x=1746302132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWM6EJJLIlxoxRTqtmcySDyqnCyGfypQjXufSKl0PmY=;
        b=E8MfXg+3av/nSN8yQiXcV/JmoTX+BED7gaUUGuVxauWZQDNhYJzlott8Or6qrY2Dgy
         fexCzLooi/UOQcBfpQQ2Mrzd4UXPnRETvm22ZoTnGG1WVClIMo8ARJ3KvW07JDpreYMU
         wx1l9jy+AgLe6HKR+Z4dPQ0B1MGqTNF7QFz0/zYi9wn8y4L4rbYSqJGCne2AjBfsaDw2
         9goEvoCAyX5lLNc4NaZ+XVjk5SqXCGEo6+vB1t6cpJTXBq1w8IxhyzADUpTpLgE1Uf18
         NzdyE8g/lQmprCUq1+YzRuBpekxFBbZYZEupj5JOGQY77lafRaAShNwi6+0gwZVQUj0D
         J3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745697332; x=1746302132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWM6EJJLIlxoxRTqtmcySDyqnCyGfypQjXufSKl0PmY=;
        b=EIplCac2FXDWaW7dhplM08Cw4Av2ZnXhNaV1bP73nu2KLMxwt3DPLOPM+qLKzMdrUz
         9VLk9xx87n6RPvAJpU3oAykrCNojKgCBfHRnFskU1pYNwCCtuGVO5qE8MX8lyKhUYQgK
         CH3U3it3QnUjCMOT1rQl3UmFlp4Yf+twXahiNzWx8hxd8yylax+3s+TzkLP2kKiw6DFR
         a+ZjjNG260KajH1hnvgbUbYNx9pAez5QL32We62aSvzzEIhbCiP9uaT1JUFAe8noK+4t
         KZkGZL6ygiCGrZBeIOGOlv3DYUbNYKuga5Ev9H8wPiKNC280i3OL1R8spaNvDxnNI6kk
         l9aQ==
X-Gm-Message-State: AOJu0Yz84cYIHfeAENChdr5t7j1gjApG4M0aQS3wycD1HwWFbPLbcc06
	kkjrmC7PiDOAlRAh/w8nCSkZ62332xfcEV1XVypVlenyraVHgx4sFxcVtKfAzcRlCVzPB+bwswy
	L
X-Gm-Gg: ASbGncvHgTXrk7TL7Q9UoEGt7+sPcOZggB5Sl9xEQvet3HhU75XQlvVBjFY5HZm43H5
	oeZaq7DsXiIlwZ1H+uP5Y2lDfHUFTjkb+TGs8Yfd9K82cu7nF1gsJXGABH0qTyJPbPfKiFMmJ4f
	XytP9TX9or9gfB3a9SweM6fV84qT0v3v8UsvR9glAKR/SpCItYlLLzXKtjEHfcbObzAXd38RB9E
	OfLOhZo/N127jYvF+r8jKwuk9LgQkAGWRj+61VjnJP9y43jMgGmQXarCEPsMBy9Bvt3igJqzk76
	ROTzM4rRRIzSlABa65qMJclnMg==
X-Google-Smtp-Source: AGHT+IHJAnF0Tl0p+01bf0/7XMCxKeW6pc9sFwBfXBaSX9ml9vop9CD8MUiL2VCU+hLogKb6rftdzw==
X-Received: by 2002:a05:6a00:811:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-73fd6bec08cmr8414195b3a.2.1745697332044;
        Sat, 26 Apr 2025 12:55:32 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9db7asm5360389b3a.145.2025.04.26.12.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:55:31 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v1 2/2] io_uring/zcrx: selftests: parse json from ethtool -g
Date: Sat, 26 Apr 2025 12:55:25 -0700
Message-ID: <20250426195525.1906774-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426195525.1906774-1-dw@davidwei.uk>
References: <20250426195525.1906774-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse JSON from ethtool -g instead of parsing text output.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 3962bf002ab6..5b2770cacd39 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -9,10 +9,8 @@ from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
 
 
 def _get_current_settings(cfg):
-    output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
-    rx_ring = re.findall(r'RX:\s+(\d+)', output)
-    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
-    return (int(rx_ring[1]), int(hds_thresh[1]))
+    output = ethtool(f"-g {cfg.ifname}", json=True, host=cfg.remote)[0]
+    return (output['rx'], output['hds-thresh'])
 
 
 def _get_combined_channels(cfg):
-- 
2.47.1


