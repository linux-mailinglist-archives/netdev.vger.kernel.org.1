Return-Path: <netdev+bounces-130987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0298C560
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D27B24059
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A701CEAC1;
	Tue,  1 Oct 2024 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYfcCh3Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7201CDFCA;
	Tue,  1 Oct 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807367; cv=none; b=WD2q56zLynZKBQUN9LBunPCSHk56x5eN1Vl7NnvIHYcQ0BD5VnmQNn7e4wdgtdHTneYf8YM0F8ywP74fhkKMM/oTbGM0u5qWv+pGovNL0nRLBqOukleZKnMdXPkVvpo9/Gdc8z74/Xdm8CbVj/aC3nOrQE68Q/fYDhcRuubfqT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807367; c=relaxed/simple;
	bh=lPXA040TtFtcChL0NIAfL6DNCp52wqj/Kschiuuo53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0VhNKARlXwmM9HNZgx2Titq/3MUWAeAQhJOrEFkhqE086+AUicXmgCzJ1myYDVvuutNmyR7VO5DgNwWFqXzEiolGqB+ebIyvmzN0Aiu0gKvS4FQsplQT6aH34TKuzPvjBww7RXyUshEIcFOajDF/0F8TwaFmZwK/6Pf2mNMKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYfcCh3Y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-719ba0654f9so4968937b3a.3;
        Tue, 01 Oct 2024 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807365; x=1728412165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC9YYCI7GpBan+FLHwaAVr2Bv2esNxWuipK7ENQ5lAQ=;
        b=FYfcCh3Yd+lTeigfKe5d3HJOLcL+FmG7kDpo99hbfGbJk/Br+GnCAMqRrIN7VYemUA
         XnDnE+akW8P5gkvcTkScDQXU5A/aDh/MqLWnZttWwJLuvA4DPOlmC6OmXpCuzNHoZ7wI
         BoJxhquYbVSgcr41OjgyE5ZvpbFOOTbim6xEzML9o7i7JxEaY5kKrTSsR1pt9Ym9f6pB
         VgBeOZnNUTZV4p5HLpTl0j5VuGJE+8A9O7dG2JnsI4dmrGuM36M3oTCdeiBrfZAt6zC4
         DZFJn+MfQcRMZu2rpEwsV6NA/C0vrFo6sw7/qrnSkXay/BmB3FnwuNNPy0wExwruHpsh
         Zw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807365; x=1728412165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZC9YYCI7GpBan+FLHwaAVr2Bv2esNxWuipK7ENQ5lAQ=;
        b=TzHeN+4diCe93Vat6k8FJQlhVNff3wfprD7VH/b3KJyut4IkDG0LkSK9E/OZ2acj7C
         EWvqGMosOXwlM1F+IHwXG2oWyRew91RsdJTfhqxtkdUoFeDiefgXPd3fMW1Ak4+sXQjE
         1u5vLmEHcHGRpXc+vk7aspCVZ/NfJPc1SdI3JSZyLZC519EhU1Gq1/es6mUzYnCinUVw
         m72QrjoHym6vlH0seAKVVaZkbEK6qpVgAYdP5O4Qa6hNJaIWnECxhC4W2E4WAIMFG17v
         YjOC+02LDmpjQsjbMPfKwWmtA7zEzvQe75SfuR2GZSsmQ94u2Aeel9cEYLZdeXqjaNQU
         J/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNKLHBGGMbSaRS3+pPk9qqeOmFUxtPfZ/B3RS5BzOmjfJYp8JpvxiTptokiz2kfbtEyJrWbw6c6VOIYG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYWvwpjLVV8P8XdFtusec6pJt/OckjYZq9aUHCl/WjmIzSDZW
	MZ3ukvBgq1Y94hX20/UDeirSLnpJuovoaysczzKz341PS2pqw0XpzSPC7lXn
X-Google-Smtp-Source: AGHT+IF+KhBldFk4V8U/mKoMt31YjvjYWuE1qDl2IUJZLe6+7ElAUe8WCVrlGHRCpsoxyoNBVm2Fcw==
X-Received: by 2002:a05:6a20:db0a:b0:1d4:fb5b:bf44 with SMTP id adf61e73a8af0-1d5db1a4301mr980866637.5.1727807365351;
        Tue, 01 Oct 2024 11:29:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 5/9] net: smsc911x: use devm for register_netdev
Date: Tue,  1 Oct 2024 11:29:12 -0700
Message-ID: <20241001182916.122259-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need to call in _remove.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 843e3606c2ea..4e0a277a5ee3 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2246,8 +2246,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 
 	SMSC_TRACE(pdata, ifdown, "Stopping driver");
 
-	unregister_netdev(dev);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
@@ -2390,7 +2388,7 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_init_fail;
 	}
 
-	retval = register_netdev(dev);
+	retval = devm_register_netdev(&pdev->dev, dev);
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error %i registering device", retval);
 		goto out_init_fail;
-- 
2.46.2


