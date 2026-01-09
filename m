Return-Path: <netdev+bounces-248569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD9DD0BBB2
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F57630167A0
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAF36922A;
	Fri,  9 Jan 2026 17:42:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68F5368282
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980540; cv=none; b=dl4U4jSfNw82EwBce+Y9FGsBZhgcyXo3olkumZzUCjdGTwzRDHZ/6RJ8cpxTSpR1soh+Bw9EjCVjozl1eimYpsOfqa4EyXdrFtl3V6OJlUrSBO00U3G6Ko+NW7scJOtXQ8F8y4ghR4gfmFso0WwmayEN6hNrKaiwnuvM7GJ5Kv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980540; c=relaxed/simple;
	bh=5m0OPDAoHdVcGZxe3wMgRXhAnSN2B57F2rHKvA0SyYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=epUVTohQL39KtaIUfmv3PlX0WxIigdTZ87TlBMnjj3irMFvAUiefVRzZYX7QuOjnHZggerawUDDugaAZOjGU+GaicG/PYSwi3LUXvsFaDXm5UCxFyG+vQB7lCUYmQjIV1nZyV02vLZWOtf2INM9/1TkERgkKA1Ksp8UHHZ+cHAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ce614de827so1049322a34.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 09:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767980537; x=1768585337;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8/KQkYe6aBGCJy2yx8mXj5Gk2hKUrzVetGq19pgglDc=;
        b=uQM0XgKssyAIQHVdGzrW/r+vnwpn8QFoCN99kyRDLBabNhtvMAXFknLJsAmc/z9UpU
         SpVdETZ73a8VxBVuMs1BeeFo08KbdemjoNakyaxRliaAxF2/c2Ws68AJOsrYL8lzrAta
         EIYQp4GJV5MtmePM4vP6Vsn8RToSyPkaV0lwUt7xsQJX/w7wwByRUSTQm7J1EBD05dDg
         Fuclo3m+dhp0H7znq62qvxU8Pb2N8RSkbu56jHMedCBS3xg/qbnYxLKfH/yi8hjqvvKt
         ZfZL0qfCFnccMHhou81MtVhzzYMUHPfKxaH3AdmbWWDL6qxLkrnfXPMBscdQqLruq2Jv
         fLdw==
X-Gm-Message-State: AOJu0YyYG31avQvOw+hWfsanATAUfn17Bu6ha6qxdbHhzVBgm8jfQY08
	j8lhUTyTMiMzHzDfCFihfRggXJgqS6GidAjdJ6f8Be58l5DVZwwfnE76
X-Gm-Gg: AY/fxX6/7MyXNZ+/qIsT+BP7cqRcUZJgiU0PC561pdYBUE8QcZSpWdrsV177Yu3XL7t
	KuVThxF3ejtwieFZBLTG0s2JMqzFfgfwi3Fr9iftxZlZER3iQhtg6tOk7N5TjyLViE5UYEP+vD+
	jKAqsdTL7IG0NsF3SOw0ZTBKJ7GIaPlPHA8YVvZxEYy3ZCkcyPY5QI2L5FBHER7/9U0OjnaCz5i
	kOMv6msaycKnP6c0zdby7jJnoH3aBAr4BI5rhWJEfXEgPFH6WVGL9dt9qZDtXsYgGnNltszs14s
	lQ8GNPJVmeSjruYfUQ1OWpjjR2f29l9JGI0r0ki8avwlCBzC2GIOxwLrpgqCbMHPSXYQV57W/CT
	aFVvzHymZOkri2ulUdwRdgj/BXb/dilax7TIY33/URjwfexmShgO0RvQzvEyMSE558NhVmUcgr9
	vPhD82bK7UJdN4
X-Google-Smtp-Source: AGHT+IHqaDAOTgl7gG4NOfQi80vgg90NDfqDx1cS/RqFYdEnoSJ5gipbBVkIZAU5ziJ0LT4W3YovBg==
X-Received: by 2002:a05:6830:2709:b0:7cb:1287:e3d4 with SMTP id 46e09a7af769-7ce50a88c52mr5960088a34.36.1767980537626;
        Fri, 09 Jan 2026 09:42:17 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af6efsm7594765a34.18.2026.01.09.09.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 09:42:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 09 Jan 2026 09:40:58 -0800
Subject: [PATCH net-next 7/8] net: hns: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-grxring_big_v1-v1-7-a0f77f732006@debian.org>
References: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
In-Reply-To: <20260109-grxring_big_v1-v1-0-a0f77f732006@debian.org>
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Cai Huoqing <cai.huoqing@linux.dev>, Christian Benvenuti <benve@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Dimitris Michailidis <dmichail@fungible.com>, 
 Manish Chopra <manishc@marvell.com>, Jian Shen <shenjian15@huawei.com>, 
 Salil Mehta <salil.mehta@huawei.com>, Jijie Shao <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1599; i=leitao@debian.org;
 h=from:subject:message-id; bh=5m0OPDAoHdVcGZxe3wMgRXhAnSN2B57F2rHKvA0SyYY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpYT3xW+c+EO03fUkD7qa3VBjl0tRZrbv2eV6Cr
 WZh9PkZCmWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWE98QAKCRA1o5Of/Hh3
 be9FD/9OSf9UXz9Er7jwkNu8YGckxaxRLWOvxNtXJ3zrb6Cc+X0fFukAgj4kcQaK9e55iN1fN+h
 VatRIc0YYvCqAAgxAHJrdtMyK3XQ+uQNlK2n9cjw5Cb1bdiSS2AB1PBXk00k4Gs60EQaH2rp4l4
 A4bN1QKgLqvlMuImMlIxCu0TajbRupReSNmRN3fuqM+n5bFEaA6tGhU7YLlegL8KWfNcPQSVKjz
 LxOcctBzcvKU+GdrcjpbivkJOZLM8vhjqhw7/u0xSWiB6Dfks5l65llfToBShANxy0ERMDsy12s
 IuZN1rap7BU7qJ8bQXyvk5mmoeEbYUnS956ev57kiqWTtptfclECOBtbypaxzvlJYq3Bq0sTPzE
 X1dtcKKJWoEkRUtqEgHWQgIuiiuWGVHvn4K+WL8qmbWmP9DaTkhgDAkpQyZcYgrP/d20zuW4ISF
 oo0Y7Jt5pFrDd76lnNyE6addUV8xXcBmQkO0d2JeqnQN77zCriVZ9lZHbeUuvzcFF4uu1y3n391
 0PLHmNZ0bNhhqxcaaeoKf1B61pide6qXr8h4ibfN/Z7pbXUwrBtCRIB7L+3pFzxWBHPHUB13YV7
 HWeDNuyfnUOodxDGFzhYlwLJHPJMPZ8Eg5x9cXJSm/uugzNxALaSmXu5/5rPtJuwtUWB4tqcfyS
 GtMmk3xmuVwa3Xg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 60a586a951a0..23b295dedaef 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -1230,21 +1230,11 @@ hns_set_rss(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 			    rxfh->indir, rxfh->key, rxfh->hfunc);
 }
 
-static int hns_get_rxnfc(struct net_device *netdev,
-			 struct ethtool_rxnfc *cmd,
-			 u32 *rule_locs)
+static u32 hns_get_rx_ring_count(struct net_device *netdev)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = priv->ae_handle->q_num;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return priv->ae_handle->q_num;
 }
 
 static const struct ethtool_ops hns_ethtool_ops = {
@@ -1273,7 +1263,7 @@ static const struct ethtool_ops hns_ethtool_ops = {
 	.get_rxfh_indir_size = hns_get_rss_indir_size,
 	.get_rxfh = hns_get_rss,
 	.set_rxfh = hns_set_rss,
-	.get_rxnfc = hns_get_rxnfc,
+	.get_rx_ring_count = hns_get_rx_ring_count,
 	.get_link_ksettings  = hns_nic_get_link_ksettings,
 	.set_link_ksettings  = hns_nic_set_link_ksettings,
 };

-- 
2.47.3


