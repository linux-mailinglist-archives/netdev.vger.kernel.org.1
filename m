Return-Path: <netdev+bounces-252467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAieNGRicmnfjQAAu9opvQ
	(envelope-from <netdev+bounces-252467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:46:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B376B9C1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3721B304A786
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6292C3D669A;
	Thu, 22 Jan 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAOZzs/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F08B34575D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101562; cv=none; b=HsLNzgkyom3tz9y4IjSz7O+Q8m14XoDFzFpkp0bsW7NnAWQ7AlSGOOW/uCiGB8CHIJpyDdmc8dgFQsVOKS1P7LKlMwIFF1xlMfFfpX6eZL8TmC/msfrRWcSw9Z6X3xGYvPO+ZTDjLudxdVfltcsjNNPGegNujD4PYn6WkcUySfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101562; c=relaxed/simple;
	bh=yv4xKODfxfq+wy1Y+Bo1fBawePnmFjDbAAErAv67a0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cmgNCfsWC9ICa7CEVn+AYeXmZ9pBdGHnq4BLIuJ3BAk5odSED5AfKMDtpve5EA5ifPu8O3GJ43AuQV+xq+sFGiVw/NidWp0u0+/bNZ4omJVlN+juOBPodgH43zuv/QX/3aBaR6ib6YJhv1I05MYYdE7KVNYphQki6opvDzD1CsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAOZzs/u; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so729198a12.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769101552; x=1769706352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UvjAXki3OZEHPndISMzpaWlTeQRauyvYG4EdwXf6i0=;
        b=gAOZzs/uc0+WLyXRy7ZCG4lRt9pWU1hRTpb8C6RYih6PYctdVrxzSrHV5MJrwcY2yR
         yHRKQD9XM+6Czr4q/YQGp2cwLypXvCtQw1GdQEXFa+MSGvBRvIQs0XwCXUlmPjcr7A+z
         74MThn49pyC/2hDUkrQMk242iV81IPdhtnTLvIKW9F22Kw2v2iQTzktJthR5w8Cuy5nl
         CBpGNDO7OBMBMfcb8rDjQHvkOfpKsscUwi/bvRY4kpz8Y4M4w/IGfp07cSQAG9DA2mqH
         Q6HgFYD0lhbTJlumlnQjFY+G7+wxTM/CWOAkQY5dpa7Oj7KIHre1U4xI0O+ZCwc8inXL
         8xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101552; x=1769706352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UvjAXki3OZEHPndISMzpaWlTeQRauyvYG4EdwXf6i0=;
        b=AqDJvwU8bV/gnSUOIqMCC1xr+J60jKbEG8V/Xx/C72+RJc1jxgoUtNlGUElpcsPpms
         lnHATvOmq76YeBxslohjLVusp6x1RIIt6PR2xN+6i72MBvDhbV9AaN87/QEXB5zZruCJ
         ryl1in8MHgbNwgD1Lca/VYaLBNgVk4LMEOymdXUnYOxN9Q86inZ7FIp8g+SOmVs/fBug
         i1oiV3FI+Ob35JkocQDITcnkput2rLfcujPtX+36pa/TDudFGIUXlmCDdEYZApsFD6YC
         nlkbdmYr5XeBfdiIt++5uh1Z45+Pkxn6sx2ZkarN03i5vV61bwK46Qlm2fewQxTq3EBb
         WSXg==
X-Gm-Message-State: AOJu0YweNrzx9FiUvQ0AK6lKdLbFPh4e1pISgCp6upEXUtgRNtXNwPIF
	nJY3f3WWvRjyvf69JyrO1rOiZIdMRPGywK2HWvaQZmeU6Pzi3fdFkLBt+UmnXQ==
X-Gm-Gg: AZuq6aJf1fZAoK3P9N6/EVyJaZO0Sx0+sJx+W5ulhKD8pzNh3V7u/fn0Z2guN1eQB/y
	gEa6XJggbg2R2wSh59lEK1+v0Uhp/S+W+XzpFukpODEArTsOEZTvE6OWjkrHT0gqF8FxPlzJPpt
	QpZPOiE3oFggBbs64p+kfZsUY82IVdQg58jGbcMJ94NiVSA+1O0cPjvhcU6wT6WmJ239gz5DlJJ
	9iiMnXp+imTlQZXXZlsG1DFiXlVapm5AdG0ZWFT2NcetM2aaUPNkQMEsdoRNLd7mlyziYBoKbZN
	+qfSECSs8r04wfDtQJxZ2iNjmmRBUin3x4c1Ds2vU8z8hOQSFW3OH8BTAWI7s9KFcbiC27d+dun
	JtENsW9aG+3kKzDla1aKztPABoMRNwvWFiqh88k3Ucm5bWuzTTAUHBrkSWYKBCATQDTO+ujtVbC
	PHS+Qdh1pMZDGGNu/33A+rU4kJ721S8ZV9hkpWaKtE+nNpjmZmDEkNNQ==
X-Received: by 2002:a17:90b:4f8a:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-35368f28fd0mr134794a91.34.1769101551003;
        Thu, 22 Jan 2026 09:05:51 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536ac58fb9sm8953a91.4.2026.01.22.09.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:05:50 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Fri, 23 Jan 2026 01:05:09 +0800
Message-ID: <20260122170512.2713738-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252467-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94B376B9C1
X-Rspamd-Action: no action

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v6: https://lore.kernel.org/r/20260118013019.1078847-1-mmyangfl@gmail.com
  - send only the first patch targeting net tree
v5: https://lore.kernel.org/r/20260114114745.213252-1-mmyangfl@gmail.com
  - avoid type casting
  - split patches
v4: https://lore.kernel.org/r/20260108004309.4087448-1-mmyangfl@gmail.com
  - add missing u64_stats_init
v3: https://lore.kernel.org/r/20260105020905.3522484-1-mmyangfl@gmail.com
  - use u64_stats_t
  - fix calculations of rx_frames/tx_frames
v2: https://lore.kernel.org/r/20251025171314.1939608-1-mmyangfl@gmail.com
  - run tests and fix MIB parsing in 510026a39849
  - no major changes between versions
v1: https://lore.kernel.org/r/20251024084918.1353031-1-mmyangfl@gmail.com
  - take suggestion from David Laight
  - protect MIB stats with a lock
 drivers/net/dsa/yt921x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 1c511f5dc6ab..7b8c1549a0fb 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
 		u64 *valp = &((u64 *)mib)[i];
-		u64 val = *valp;
 		u32 val0;
-		u32 val1;
+		u64 val;
 
 		res = yt921x_reg_read(priv, reg, &val0);
 		if (res)
 			break;
 
 		if (desc->size <= 1) {
-			if (val < (u32)val)
-				/* overflow */
-				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
-			val |= val0;
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
 		} else {
+			u32 val1;
+
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-- 
2.51.0


