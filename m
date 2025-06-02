Return-Path: <netdev+bounces-194654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C9AACBBD6
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 21:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DAB1883284
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 19:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2877227E8A;
	Mon,  2 Jun 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef+ggQyi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA0221FD0;
	Mon,  2 Jun 2025 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748893203; cv=none; b=Ijke6AhjatVPwPdJgJPoMU9EkjPeUPggx0SlD/qm1mexiJyKeyaW+AYQBzyeGUAU8aQmb/lGxCHCxfwVyTZU0rssSTG13k6T2VKGSVV6lVv+KawOIuHZzEoCpUrhhqAYp6YelHlkcDG0zAtvvHE7uaCeKL9RnkoDGbaM+FRewoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748893203; c=relaxed/simple;
	bh=xGkaJcSVZIGZYDU20IlWkf8xu961WZ6N54Xce5GByBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3WlhFMe/nJGrEfY49KhPJAao74W9hwYJuwmz251H7+4uIO9fB6ymBUOOr8QgTvA73fNraKbrpmeEE/oAKpeSqpq0cfGo6MIcVDijCcoCZtYEuLYjBNFlngEaAy6q9Wn0w2Bbrvj5amXacQiniw0MHe6cRRtCh5JuP/QWhpoOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef+ggQyi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604f26055c6so11120694a12.1;
        Mon, 02 Jun 2025 12:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748893199; x=1749497999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bchcVw16Rv9Ke6TBr+mieEKvbKHdwpSqUXH/kZd7AFk=;
        b=ef+ggQyiChSsjb7Idy34WlBbmRuiCE+hN3DmmaUCxLH0uvS69dajEt57eny1XhiVZ2
         pjrq342VBL/kFfkNEEnQLh4SoDsk2AseEwO3Ki8UELQWPeTzR8hBs7VbwoOw8YlzQQEF
         b0S08d/m7P6zV/SrLIM3yuAAPS9lr7iG2SS2SJEEYDvm7actViS6w4N5+JN5kG9b8svR
         Vr4qCGUimBmXmk8qCIEu0jQ7Cfe0ord00LgPlRveBM2eLXLuShmQGeSnKFOL6kv1Hg1O
         ql17ICPh/jtK4wccoZDUmWVRRKOes4osdkcyYbKHaVL1beO5mmkgTFcwwuTE/CiWTlY4
         337w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748893199; x=1749497999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bchcVw16Rv9Ke6TBr+mieEKvbKHdwpSqUXH/kZd7AFk=;
        b=YTsFtVWsPVD652JIsd9wlycKx9o8WDG3UFcM6lbAih35J4ZTfIci1AGF7CwTQXbx/h
         Y+J/0hpR0jU2Il/ibEw27qs4yF/KIrrKIWiyPM+KoF8RAcWlcgR2kKqWApFe+VavyiWi
         En/wetJqyyeYtBSCFPdBpN8DS5RyAe/teG1JuugVDWVz1bxbIF7EnZeywbyKbg8oVYPc
         W3AIp+r+abgmxIGdMoVUt6FmQ0P3cB2gBn8VviSneGyazDv/eTkmq4NSvvvsV0GIrm99
         7o67oYDMg38+M60kOMIbKLE8XcxU8lDworyGKkzQg3SiQ0Yw3+PzSQMbW2SLrxmA+1Ih
         nIqA==
X-Forwarded-Encrypted: i=1; AJvYcCUEYsMCkm+nqnUKMfqPFS8lzi6uwSOR8d59nlxdAQdmb5s0zEqysDLd5qmsJyKWZqB/fNYZYXuFgDXzB4Y=@vger.kernel.org, AJvYcCXcHNZZwF6+iXLUAd6MPkmw044oDvapYl6GyVU02JhrLAytJ4c8Pn8OvtaYQs7zxBZLgLIkY2LT@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFI3QLX0wJNPzlc9JPn7jc+QbZMkndq8ErGaJf1+t8JtmHsPo
	LysmKaKg/+5HpuKCOVsazOEA97iwLNcmcpYDAz05QWpSZoazJBubdxqp
X-Gm-Gg: ASbGncv6J/wfFF8mML9tqntmaFlbviTZB8VzfOTB8duzahERsbEzsyDMvVq/srW05KM
	ScNsHyk4A997iI1cvCMtbbLTLGzJGgXrE99Jq0VqyWWnbq2PqNZ4+nesUMAeNIj+OHNGspZURlI
	LWfKK8LQFl9vMwillwlC9uBOm1FzmcLVCOiJKmiqJalY9woOvz8l4PNRNz19e5cPwP0uqt+Vcrx
	U4g/I1GmVxrXTgEj0mFhGZo1GJgS7RkrdQ5q2AcxQ4E6D28Z5wUe2ALAoIwdQ3Ae197L1VWQ406
	Q64/UMwBch1xDWmqH1maZoxbDouYHA5rUbE4EuS3azIUCebVfeyk2DP25fjPaNQn15CfDlOScSl
	HAalkx2DFsmf674xX5NSHSUsi/kZ1XfE=
X-Google-Smtp-Source: AGHT+IHb/jsqEVAsc45ECKj+RtiMfmptnFT6BSiubYaBx6CB3I6qZSBCmHXuavZdxbsd0dNItTWoYQ==
X-Received: by 2002:a17:907:868e:b0:ad8:93a3:29a0 with SMTP id a640c23a62f3a-adde0d54c7cmr69970766b.18.1748893198864;
        Mon, 02 Jun 2025 12:39:58 -0700 (PDT)
Received: from localhost (dslb-002-205-016-252.002.205.pools.vodafone-ip.de. [2.205.16.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82ccf8sm833259366b.44.2025.06.02.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 12:39:58 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/5] net: dsa: b53: do not enable EEE on bcm63xx
Date: Mon,  2 Jun 2025 21:39:49 +0200
Message-ID: <20250602193953.1010487-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602193953.1010487-1-jonas.gorski@gmail.com>
References: <20250602193953.1010487-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM63xx internal switches do not support EEE, but provide multiple RGMII
ports where external PHYs may be connected. If one of these PHYs are EEE
capable, we may try to enable EEE for the MACs, which then hangs the
system on access of the (non-existent) EEE registers.

Fix this by checking if the switch actually supports EEE before
attempting to configure it.

Fixes: 22256b0afb12 ("net: dsa: b53: Move EEE functions to b53")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
v1 -> v2:
* add Reviewed-by, Tested-by

 drivers/net/dsa/b53/b53_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 132683ed3abe..8a6a370c8580 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2353,6 +2353,9 @@ int b53_eee_init(struct dsa_switch *ds, int port, struct phy_device *phy)
 {
 	int ret;
 
+	if (!b53_support_eee(ds, port))
+		return 0;
+
 	ret = phy_init_eee(phy, false);
 	if (ret)
 		return 0;
@@ -2367,7 +2370,7 @@ bool b53_support_eee(struct dsa_switch *ds, int port)
 {
 	struct b53_device *dev = ds->priv;
 
-	return !is5325(dev) && !is5365(dev);
+	return !is5325(dev) && !is5365(dev) && !is63xx(dev);
 }
 EXPORT_SYMBOL(b53_support_eee);
 
-- 
2.43.0


