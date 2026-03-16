Return-Path: <netdev+bounces-268162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJsuHqkGuGkWYQEAu9opvQ
	(envelope-from <netdev+bounces-268162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3029A768
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE8603030D28
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10C39769A;
	Mon, 16 Mar 2026 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCnLRfjK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3E396D0D
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667569; cv=none; b=pNsWwfR5NfiHq41i9egyssu4Vt4+iqpc+Rs5i7UFs3nVg3qMVFx2SPqHP5/Pwx6oCvMcilog1/VJyoH36Y04WjYXwGvwUL5e7KYLTaTO/XSay+0LpQEC0zWKOajuJzRC76JiMXxGZQvj+QTN3IfwVNGh33TpCcvUkAqCPhap/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667569; c=relaxed/simple;
	bh=EF7ThkIDWGZ71T6IecTms8KOZntoVVYPN0bKX3Nt7x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSYQc2XV/CpHrpGYC0OkC+5QpDmok2VPhLW6J2zh3ggjl1ko7bixib3NBv2UkBtmRyzv+xVqwoGumHi2He3sH/xLFTgmWAPjmAPFgvs4gPdXnd7K3lSCz0HFB1bbTF+Ep8Wi3fBX6Dgy1NJhxVE9CXPCJgcObrGuiYuiMn2Eb8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCnLRfjK; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad21f437eeso36681735ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773667567; x=1774272367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP3lPjxS6zYX+flCgYkDZV1k9Jb2LZBcKTV9VF2r+hA=;
        b=fCnLRfjKOcknIW/B2OxCvv7orDx43Ie80kG6u9IE6CRdVXhPee0zdSJnallf4xs/lT
         yc1b4r4YWnb8UWHGRJTdbBRtDxeNC8Bf5Pdz5tC7trpiweULDlLM1hfg0/Ru4QSGJCUY
         iBwkY52M2XYM4iQY8HbNSfes8zRhBqX6mCGA8HIDkoaPYD84qjbe3mwlKaJt6HI4W1rW
         fXPVq2R50f8zlF5NbBXadh7QlftErhrHQKjS8UWb0PBzmmCNVepasbFj756+T5Ds2Ttr
         nnRXD57K+8oz4+OlufwHS5Um3IxfEaZNyd0L0DRIiVSqCTWTS4UNk7hbfzBNsljVZrfF
         QWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667567; x=1774272367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP3lPjxS6zYX+flCgYkDZV1k9Jb2LZBcKTV9VF2r+hA=;
        b=dctIHmR3nBEy3QJMI3OsbKtDqs1JajgsjyjJRgvFEUaSaoEDkIg2PgFYyYIxnv9lZ9
         3BX4tc8740/EQBWG7y+lWauDlkJfFPSKKkU4kZhfvbiqi1e7yE7FWJsgAJ1AEZBkeTbb
         WkQ6cvFbBeAxiID/vyNwMg0Hbn22cez2hzEhS1tYiGqYgT1MWhD7Sr5pZ7dKVREXA9AW
         ZdFsC1/2ttC2XFGSutO2Gr12LB1u6/nazhk0RMXjpI+BKMforxPrVL4CYMZ/xf4RqPmt
         5Zu8Ub9KYoG4GFNH9T7SaupQaEk+SSJulg1G6jn3yoV0tJ8fEk1i+oIOJBEE7q7F6NKC
         2Rxw==
X-Forwarded-Encrypted: i=1; AJvYcCVoaqo+q+fzl70YpU9dMPIWNpSKu8rgGRsTCcrk5cztazwoHKFk0cP9nA/02GiT5ptVor/QJvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZWBVzFudOhzZIUqAKZgzAcIPf718mOczx9XkE3GtI3gJdsZFP
	27v8CcW0LiswelMMtFnJPG2Tq4aveN/BDk6vYs05csEsQknPyyWIu1NtU8alJlpoDLk=
X-Gm-Gg: ATEYQzxFY3OBTw/5nglfdHycpMLwg6eOst9+tLeEC+9OlyKJI5Gr1RlYXESCMUd94BO
	R34oUJiS869XmuGiN2BbQwkM2bo44V+jxFqe72jMoHE3FIvlv5nlAzyv3QrOaBRozFqcFHVjnUR
	o8wGuqrncXjzU65ERRSKIrbwSm0CnS1aI2+eeitREgxVasnqfj7FvmaBeIL6BF1vxjst+qwUKWb
	H4VC650fY0KE4KD3urloYMyoCZpBBUUTXX78MEnvFTSpArHx0G5EqEPGtMvuc8TEeRIYjAKxmhY
	q8vSojD5w9dT8KITKmy6CIHxU81xMLq+tt/79iihkxNIclbz/aNCJ2SiszQ9d6ZiL5RQ2/AK3+7
	ZA8ztx+2LGHG6mRNhbL2Waxk/a/S7RnMZJnvLdyIhCOOYLHrMYPtI1io0YRWHMxbOmR51AI7vpl
	Ny1YV+VXke35E5/7pNKctaiKOW
X-Received: by 2002:a17:902:f708:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2aecd8cc00emr101838685ad.10.1773667567266;
        Mon, 16 Mar 2026 06:26:07 -0700 (PDT)
Received: from ubuntu.. ([152.58.131.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece60e6f6sm111100865ad.28.2026.03.16.06.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:26:06 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: jonas.gorski@gmail.com
Cc: florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] net: dsa: bcm_sf2: fix missing clk_disable_unprepare() in error paths
Date: Mon, 16 Mar 2026 13:25:47 +0000
Message-ID: <20260316132547.1274-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
References: <CAOiHx==pVOOtvOb3eooRGt8EcwjTtkY-33Nn+Cu_m3pu2gVtpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268162-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohdabd6602@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E7D3029A768
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Smatch reports:
drivers/net/dsa/bcm_sf2.c:997 bcm_sf2_sw_resume() warn:
'priv->clk' from clk_prepare_enable() not released on lines: 983,990.

The clock enabled by clk_prepare_enable() in bcm_sf2_sw_resume()
is not released if bcm_sf2_sw_rst() or bcm_sf2_cfp_resume() fails.

Add the missing clk_disable_unprepare() calls in the error paths
to properly release the clock resource.

Fixes: e9ec5c3bd238 ("net: dsa: bcm_sf2: request and handle clocks")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>

v2:
- Add Fixes tag as suggested by Jonas Gorski
---
 drivers/net/dsa/bcm_sf2.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 960685596093..de3efa3ce9a7 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -980,15 +980,19 @@ static int bcm_sf2_sw_resume(struct dsa_switch *ds)
 	ret = bcm_sf2_sw_rst(priv);
 	if (ret) {
 		pr_err("%s: failed to software reset switch\n", __func__);
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
 	}
 
 	bcm_sf2_crossbar_setup(priv);
 
 	ret = bcm_sf2_cfp_resume(ds);
-	if (ret)
+	if (ret) {
+		if (!priv->wol_ports_mask)
+			clk_disable_unprepare(priv->clk);
 		return ret;
-
+	}
 	if (priv->hw_params.num_gphy == 1)
 		bcm_sf2_gphy_enable_set(ds, true);
 
-- 
2.43.0


