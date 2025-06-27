Return-Path: <netdev+bounces-201856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B43C0AEB33D
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BC7A73CD
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 09:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7BC293B7D;
	Fri, 27 Jun 2025 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rQCRHcWf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5779E293468
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751017617; cv=none; b=AIbDsw7kzSnwJN3msj8DWCih6zJq4DMki6nm4cCVZnopBPB+/lxMRMjof44EVHRIVY/6fts86JXRvgsXv2SlD8H/vq7ucnV+I5DJXk5Id1/rER7GnvvxTsAHSJGeea5DEKS0HymNuGUHR2yUcVd3SSnoO4904QEUs2ob4FdRATs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751017617; c=relaxed/simple;
	bh=kO2WeblatSlet/cNTxuN/FVA5yiK3wmwGX8QqVbf2mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aO3zF+JynbqCs6igEA5Af/Scct4jNJKtFBnuoQPkmcIC6QfKywbgOSIhJZGt2QRnh03W+PxYPbIKtNqlimsedqttCa1XClx4NyjSJPtl9VjsAS2XQFkqO/5o9pzMEN7LXx5u9MyJZErwa0xtvB4WY0UH+TPlSZkypv3Holol75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rQCRHcWf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so3707679a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751017613; x=1751622413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDeWbqKTIH6157R35znSRCPjP2Xy3NrN5iuxUW1EKgg=;
        b=rQCRHcWfb/VYrzQRHTOcxUyhRbHHuJQtDzgufTl5UiAdblJc3h2fWueifkK5PDfx+z
         DN9XSl0TTaGwfvIQRPePE3hJYK0DYaiRJP32cmN5Bi8dY3zgChwQ24LQqE+4f4phlNZK
         cAnXr3mLUzpqgdS378pJHqyJZIoawww2uQBuruzhq6cALzujnd6RAYGFP1FFqn9zzim4
         F+cLlpdEOtxfcIBxnbxNREdNfJkVHSKmzo+J3OhZMwakzQFlBZiWFIMmjIqNWxteAr6N
         TZmegwTOgJAwJqQiXsFd8V5/PPSuZycMmsXGgac+2H8yVYozS5WfwGwLBOoCjyEf+Zg8
         BSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751017613; x=1751622413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDeWbqKTIH6157R35znSRCPjP2Xy3NrN5iuxUW1EKgg=;
        b=o6W3lwmrJKeHyUdzQzgKvOeZ2NsYmOWxPqMdJidPGerCibw4EeE2azSPeZWC+648Cv
         tj19Ssz0oOcP1zLfTY/0lXIgNLpe+nxfJTI+9PP3oFchc7ymAtOjPXXdTZo7Je1G4Pyv
         2TsLawr4h4lrKl7/vC+fpSD9qo40QSePnjKNHrI7LzevRas6O5SSe3eDomLAHxHuX7Zg
         G0Kk6kgjSjdu6ptam9WtuwXEVqaHMubDaiJQmUo0PbQHN3KcOmkr7i1pPqoFh3ZuWOLr
         IUG73utomLgN80MMSDbviMBlW9AWoTMXSAuHrduagVtcv01KpgR2p3YAhM0JpqAq5F06
         Whvw==
X-Gm-Message-State: AOJu0YyEKgzo21dv9C+1RJ2+je51uaBQ9pQEewUSovc0aNQL/DR5yIsJ
	Ay4FdQStGysGWmZpjPRbdzNX1ZKxm+Fi9HFshYAAqwNahGiSlWDQo5UMJSNWK/EUZfI=
X-Gm-Gg: ASbGnctyoe29N+FnRmnTlclTvsPtLJdCA3jDRdDFAI640fviUTVsNZ/i5dpGY/z7aZP
	J6Zs50qF4QiYyX1Dl5bXWYsNuAWN4Wo0evURWSchkVFaD+t4Q9CbpYoUAIPs3iLjc8Vd/bKthqT
	X2RVxQPW6jYWe+Z7FlriX58LGWLw6kP0+gkbqiQ8JWPBFlCPvYUNB+Qmv5wNETEhy9WIS3TGhv0
	eFIDIPbVbnF+NRDy9e05zDbIZ9ofD6VDyce0/2VIF3u3cR+vrPolCrfIgA06ZzFH/DUkOtr2xdX
	q6/xiPK44pgy6l1M5Cf2Lt4zz18vuaG6m3mLb8R+ZLLSbz/13lZFIBh2k7ZmfwVwI2YxA4T2tQ7
	Hh7XYsAZiShrYWwv5nAh5/lq2C3I+
X-Google-Smtp-Source: AGHT+IGamxkvfyWlJmgp1hhY5UORTBdewR3x71Li3bnsbY49A6WmpgDzjHC9FJlD5wJ1vkvvUWxGxg==
X-Received: by 2002:a05:6402:35cb:b0:602:a0:1f2c with SMTP id 4fb4d7f45d1cf-60c88f51cabmr1915273a12.9.1751017612632;
        Fri, 27 Jun 2025 02:46:52 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c83223583sm1238951a12.81.2025.06.27.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 02:46:52 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>
Cc: netdev@vger.kernel.org
Subject: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
Date: Fri, 27 Jun 2025 11:46:41 +0200
Message-ID: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=kO2WeblatSlet/cNTxuN/FVA5yiK3wmwGX8QqVbf2mk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoXmiC/6XZ6NzlO7o4Hdr+BdnHAzvkTsq3aaE+o juLRIucbk2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaF5oggAKCRCPgPtYfRL+ TiBjCACt7rqJP2cvB1ZvMqiL67MNpU05l7vDKWp03keunn0Qyqy6kBggQt/865DSUnb/dKY/I+Q dOG6jfch/Xe0JkmFUuBAF1yrezYxMeMn0eXzAPh+OK+JdkOUyPFg2bAAhiAFuvjXW6FfoW9xfnG IXeTZhkOkq/bA/j9vLy5UXXCbhIa03vnwFUv5HlnmSjY7NTEW7mnt+xHhTU+qchkz7JiAne6wbk eSkWHgb3Z2gqwFeQ5RH0Aeo1AZE93apV6AHsoz+R+3IXHhpZdwof3DSiGkZl15O9SOWxf40cr63 0RUDqAB2G2IsDWX7+IL8KVNoano+VMgEKHpGDdsJAle2v45E
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This is not only a cosmetic change because the section mismatch checks
also depend on the name and for drivers the checks are stricter than for
ops.

However aq_pci_driver also passes the stricter checks just fine, so no
further changes needed.

Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 08630ee94251..ed5231dece3f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -463,7 +463,7 @@ static const struct dev_pm_ops aq_pm_ops = {
 };
 #endif
 
-static struct pci_driver aq_pci_ops = {
+static struct pci_driver aq_pci_driver = {
 	.name = AQ_CFG_DRV_NAME,
 	.id_table = aq_pci_tbl,
 	.probe = aq_pci_probe,
@@ -476,11 +476,11 @@ static struct pci_driver aq_pci_ops = {
 
 int aq_pci_func_register_driver(void)
 {
-	return pci_register_driver(&aq_pci_ops);
+	return pci_register_driver(&aq_pci_driver);
 }
 
 void aq_pci_func_unregister_driver(void)
 {
-	pci_unregister_driver(&aq_pci_ops);
+	pci_unregister_driver(&aq_pci_driver);
 }
 

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
-- 
2.49.0


