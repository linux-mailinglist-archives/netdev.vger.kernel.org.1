Return-Path: <netdev+bounces-187585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4356FAA7E6A
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119B21BC0304
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F008A2030A;
	Sat,  3 May 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="bMlEnb1k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54246B8
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246612; cv=none; b=j5ilZAuC4JmqRwTFk4REb5I88i7X4yRrCfkNoYQzSt8HcNIKtFmHhHhdlzaKAp6k7/lbUiEeyIZ+EU7GrD3aQoDFAF/7jRhrI58MlRqzmHHkU6jedA8Bc0j1IeTn3JPp9bvaUyi7XfLPpK5YgLtDUWulIK62vDQ8pYStWc5+sBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246612; c=relaxed/simple;
	bh=QxiMRswJkuoSynqOCz9IQJxo1uYgcyJj6ly+F1R7OnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UdqDuAG7u0/cINMfSPGXW7DRaFGl9SL5XwiSSIApPavjHT3YpMVRG3KFdjvwqjx8Hu5xQ6dINCD0+rgoQyq2H7GwrN/EadKxCLXpv+pV02McEn9hrLLbeuQXTgrDV1JYrV6WHb5PaiRIbyMmZpR+A2DRE5MZ+/DUcxOC9Gvk69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=bMlEnb1k; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736aaeed234so2573781b3a.0
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746246610; x=1746851410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyxDzNRXnL7I1hojL9XNTjNOZBCXHZFUbgUsmuVCr30=;
        b=bMlEnb1kLfR9Bx/rGmiIIJkmR1r2rhjRsq/NW+08RNNzDrDcZsCG0tVH0AMLZK+4d+
         Ofk6MKyYNqmr6979yGxqD3ATalvY3Ig07x64OWH1mC7/RvTuv7YQ4zRpayy2uAXuBxVu
         rwxYGhBCAoJts/dmkxuPtqCpMdSRleI4CdCz+Zcz9gZIHUOODk06ACUOG1sEiaH56SkS
         kCzKnoYD3uyf60Ee1StfGHrcPObVMULN8e4idVhJESucZa/viqxHYqmhWXJ01xSbthkw
         z9e9OJUFixz9Ii0upVWLEr3anjEKSUs2h584sFQdkJfT4XkleuCTvuonc7IoCnb5ywo2
         NhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246610; x=1746851410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyxDzNRXnL7I1hojL9XNTjNOZBCXHZFUbgUsmuVCr30=;
        b=pxyFD8rbdqMsszANHJSn7Ja8iZXnwVfDhIz/ql+Gelmp8obdQFsSsIAqDcUGXGbWHr
         SgZ0kTr/RMa5nN9PgoEd7ZrIgUCxDhqlxw1WyIAO9T7+E/DxruK7RpSLOcVPp09VmcKv
         4H+s5ve8Zni+xvWTzBwWupjqlFNmTnMuJ3V9nOmYcWEEC99bHiDj42dvqrQsfDxq/xmR
         tz5fB/jcyNZGbE6pCFmNx2EwmWIRZWifcX6KGZfRODNCYIYtZ9lKcz/Qn/U8tSF2yjzG
         KamxYMoujVFhzEmjW67xzMyKM5I+5duzEK/cztLF21TWCkYwV0bgvoEtGae4tgIo7ec6
         c8ew==
X-Gm-Message-State: AOJu0YzdlB9y0K+8d+pFDeyzRZP3mZH91usW4AUo3oQwoKo8fPLWeAw6
	Z18TMl4WNqWpfN+BKQg4dwv7i91g7L1gP+j+loYiAq0nTmFRWCGDzZAokxbyPhHRiTixsQ8MoGh
	S
X-Gm-Gg: ASbGnctbGq5JSc6YSYG5iOT/nVqGvjLRuNSrd+coCE5374QHIB2BZT4a0KI1BHQTRNQ
	4OlzGFYSDMljAYsCSeYsy3Kcwnl6qHKXbymYZRzUx/W+tvac8oc1T1l+fy7O1Ib91D0uGVypCje
	FINYVCMr1/SCVADgmxs74D0q7yskehmdM1tsTQOXxIlt0oPsfQYCzYUUT2jpl53JXqvgm1czo6k
	4iOkPXjbp2YNBpFXrarzBOYqom5BnQMT/pbsQyaNtkFWPFz7ajBMfVt/TaBVfXthZdzICF679TK
	5XSMhC8Ba1o5aUjhKXNYl9xYnOeKLic/7FGF
X-Google-Smtp-Source: AGHT+IGLjc6WAFT+LwzPIs5w1bO9Qi1NK6R63xkinXjZDAeT3bRgKd8nvGduytk53KnBifGHGueObw==
X-Received: by 2002:a05:6a00:4518:b0:73f:ff25:90b3 with SMTP id d2e1a72fcca58-74058b287b4mr8495213b3a.24.1746246610096;
        Fri, 02 May 2025 21:30:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405909c883sm2475380b3a.165.2025.05.02.21.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 21:30:09 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v1] io_uring/zcrx: selftests: fix setting ntuple rule into rss
Date: Fri,  2 May 2025 21:30:07 -0700
Message-ID: <20250503043007.857215-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix ethtool syntax for setting ntuple rule into rss. It should be
`context' instead of `action'.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index aef43f82edd5..9c03fd777f3d 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -19,8 +19,8 @@ def _get_combined_channels(cfg):
     return int(values[1])
 
 
-def _create_rss_ctx(cfg, chans):
-    output = ethtool(f"-X {cfg.ifname} context new start {chans - 1} equal 1", host=cfg.remote).stdout
+def _create_rss_ctx(cfg, chan):
+    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1", host=cfg.remote).stdout
     values = re.search(r'New RSS context is (\d+)', output).group(1)
     ctx_id = int(values)
     return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
@@ -32,8 +32,8 @@ def _set_flow_rule(cfg, port, chan):
     return int(values)
 
 
-def _set_flow_rule_rss(cfg, port, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
+def _set_flow_rule_rss(cfg, port, ctx_id):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}", host=cfg.remote).stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
@@ -121,7 +121,7 @@ def test_zcrx_rss(cfg) -> None:
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
     defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
 
-    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans)
+    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans - 1)
     flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
 
-- 
2.47.1


