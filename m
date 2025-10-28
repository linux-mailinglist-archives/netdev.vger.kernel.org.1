Return-Path: <netdev+bounces-233336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A758BC121FF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A701A25659
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE11D130E;
	Tue, 28 Oct 2025 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWVGCeLX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABD481CD
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761609625; cv=none; b=VlqFfVcJgsqWyC3Ui3Cwm0zLRZF07d0q4FT5KYcgAZwfn5ykswySRFguyCuASY08vAv8Y82qJTbyfhS9jAn78GE0VCF0mWEB6GDlENb2ojxQZmjxPaiSn8SpxUiiaG2AcM6KNwh3u7Y0C9K3EbRhHC6u7zGGfG/XopankQsXQPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761609625; c=relaxed/simple;
	bh=bcETCkepaF74e7lPUMskBIH6KkDLfN5id3lvNhxFZ9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/npJ0UDjeDVfkwW8sTdZeJ9JQ+yOmgA+yhKsnHgd447ojkrOFSfBMrfiJWNZqdsI5VNz4eAfZPzmV1BMJWVzH9fJkvPhbsCANBgzQMEv/l0WMzRGE6+eTqZuJDw1XLF8s/SRG/BRkVsA8977zzJ3kJmiS0Abcqdz1UKvJCYUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWVGCeLX; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso5435774d50.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761609623; x=1762214423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=LWVGCeLXfF1jJPfpWH9nlwfD9/8dVFUUr0vaLTfLZb1ouBFs2JGsaiVG10UN/7B/WJ
         xJjm5DLAL7GSZIxNCF8jfs4G4axwLR8/sRkxR7SXnwxAEggqpphSt5pzZXFUyMK5DBL2
         GjTFZX9ISxEa7T7oO9DcCtHbbU01DM9WwkTiVf7TXSbqLTyUKYZQTnbTuj3JAcKjYnZf
         0XbCBDh61zkQM4Kaigkxa9zPziq+UELBy2zTcWb8VpanuKmRUAk1Dm+fbsuayJRXBIRD
         jhumMlpM/pZ3KDJgL3nyxWosUYF+81JzvVrRYWm0CIzq+APir7pFhH/Pf7xSIeZKUk/P
         gT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761609623; x=1762214423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hXmhTJZAlfrfDbx5/TiDoR6puyEL1cB+IP+R3Vobds=;
        b=gHNpQV1LfZgJqCH5la/sGyh9rz6GFBn0rh36Y/efA0WQHJsueSuutVsfDKaKt2iPUh
         WpTUem+uEd1487vndg4+fyMuZE7STtjKC4bu54j1GdPZOswOe+M65lJFgPbMdqX+Rxsh
         ZYp4VzdPZyMacGkCGrKMZC2nO4A2zgvaL5nqsfY22SCYLZR+bKKZK9Z7hzM7Z6/YjRcW
         1YCyyDRu4opUWremv3BfXKTQthAxB+ouJ8SR4UPDXrt0OtrDvNb9E9km/cC4b1jGw9cj
         pyplMUtL9mdysOFkivcIbff8ltYl5Dj+I94Vs9PbU+Nbf6rQttusz/g4UId+xT8OM+3B
         W+bg==
X-Gm-Message-State: AOJu0YzXu5cfQdVXycgxEY/S+ruS4CBQU8aLXVjqM8WCw/6M9CGRech/
	3+2pMw3HAHYA+tEJkdVDBhG17rACFMGAs3+oCHNEw84RM7lz9SeZ4waA
X-Gm-Gg: ASbGncuMJstFUzy9HmXOY3JASKJgNxxIzpHijM4aChM5kGKhcdIProxY1oKjDkXWEHL
	Gk6opQDKc7S9hgm/I7rY9OGp+CxMOy62PWg0n9E4HyoaWXQoZFtHAsJ9jNBBdseuQ7L8ZOisdr8
	5kPvry0IfC6wo8sfPx+VzVAEVOsC48zGRqZP7XXyFTfTnTCn2FBuHhQcUjfUJCbTZVaV1pPAsCk
	B/c9lOgiTXjP3B7Fpexf9Z9YkmYTCWan3AplKXMcWK80dWcN14XHKoTzgR9Zrg7BYvV5p3TONsb
	DAoaZTj+DTACtOMTKxtV64pgV7H19XC+3MByyjbHnpukiqiHPWxVcWieps4kyC9yFLeQ6wcIU8Y
	bWHIQmK+RNixaURSiiAxaW6QSCJHPdlnrtczolpO6AlWixmODgjlJwu79W/2aJ4SzX8QEFwqnVd
	8HYiTc958S6a8TpoRDPJE=
X-Google-Smtp-Source: AGHT+IFM7FoSp+6n8D1h1RGRzyioBT8sthh2seeo+TigunDqVeBpnwtLnUyA0CdAXQqwjeY66Eaicw==
X-Received: by 2002:a05:690e:1652:b0:63e:a2b:70db with SMTP id 956f58d0204a3-63f6b9ee47amr1322903d50.27.1761609623183;
        Mon, 27 Oct 2025 17:00:23 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f4c3cc4a1sm2776554d50.11.2025.10.27.17.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:00:22 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Boris Pismenny <borisp@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/5] selftests: drv-net: psp: add assertions on core-tracked psp dev stats
Date: Mon, 27 Oct 2025 17:00:13 -0700
Message-ID: <20251028000018.3869664-3-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251028000018.3869664-1-daniel.zahka@gmail.com>
References: <20251028000018.3869664-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add assertions to existing test cases to cover key rotations and
'stale-events'.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 tools/testing/selftests/drivers/net/psp.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 4ae7a785ff10..06559ef49b9a 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -109,6 +109,10 @@ def _check_data_outq(s, exp_len, force_wait=False):
         time.sleep(0.01)
     ksft_eq(outq, exp_len)
 
+
+def _get_stat(cfg, key):
+    return cfg.pspnl.get_stats({'dev-id': cfg.psp_dev_id})[key]
+
 #
 # Test case boiler plate
 #
@@ -171,11 +175,16 @@ def dev_rotate(cfg):
     """ Test key rotation """
     _init_psp_dev(cfg)
 
+    prev_rotations = _get_stat(cfg, 'key-rotations')
+
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
     rot = cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
     ksft_eq(rot['id'], cfg.psp_dev_id)
 
+    cur_rotations = _get_stat(cfg, 'key-rotations')
+    ksft_eq(cur_rotations, prev_rotations + 2)
+
 
 def dev_rotate_spi(cfg):
     """ Test key rotation and SPI check """
@@ -475,6 +484,7 @@ def data_stale_key(cfg):
     """ Test send on a double-rotated key """
     _init_psp_dev(cfg)
 
+    prev_stale = _get_stat(cfg, 'stale-events')
     s = _make_psp_conn(cfg)
     try:
         rx_assoc = cfg.pspnl.rx_assoc({"version": 0,
@@ -495,6 +505,9 @@ def data_stale_key(cfg):
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
         cfg.pspnl.key_rotate({"id": cfg.psp_dev_id})
 
+        cur_stale = _get_stat(cfg, 'stale-events')
+        ksft_gt(cur_stale, prev_stale)
+
         s.send(b'0123456789' * 200)
         _check_data_outq(s, 2000, force_wait=True)
     finally:
-- 
2.47.3


