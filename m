Return-Path: <netdev+bounces-252488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MGUMxdvcmlpkwAAu9opvQ
	(envelope-from <netdev+bounces-252488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:40:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045C6C8F4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80BB3006B67
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03168333750;
	Thu, 22 Jan 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8EEmdl3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5233FE08
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107217; cv=none; b=kcGJOyYChzE5D3MokI+ln6zU1Crgiprt4YlWdG9MNcyox/RlIiqN3ubJrzI9dWO+AnMV96jUSjmSFpeVgJFYjH+5Vyx9sTybANrC94c5huhkXnsq8D7TZ9QuMErOissxdjdSOc7uhjpPwaiquVr5IHSoGAjotlpRKFTxqp/QLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107217; c=relaxed/simple;
	bh=QRCHqMHUl6k4oyqDF1yNGbk00enGNL+39HiKgi93CiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XddDqpZ7vN3SrEy1abikHv4FQjJKGI+6ZKDB1lrPQllSuaMDdjAhax6fyl1Hsm2lzJKxAKZoWUR44zUXhgtBw/hGeGRoRoWgkQ1o7mcvjoxTnHLoFsm0puWXbo4nAEkkC/FVR974TCBPqlLUh6h/mE4vKhv9p0KjUJxBluW3bBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8EEmdl3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a12ed4d205so9513935ad.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769107209; x=1769712009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/kwJ0a0SAodTDho6g2OsEkjwx23towh2Gp2df1yGT70=;
        b=k8EEmdl3q+xkmOq7vPovi1eGg12BR/dsLNka+NWBRzYjbTigXFTNQtYhME4rzt4l0P
         Dpqv784CW0Ae0HCM5BHpSjTu9bo4XEHGdzrxPIKlScy/LtShO4dBZMf1LGgolWdFw3mm
         vuLdwXzxcpysCWEAIwlNTFtudEkL6YFPCcTFDsGvewRNzfljVAoLnObbH31q2Kd+FXzt
         jVV1H44fsGpspgWcjgRbDbzRwC5MC2o/qNszdWw+CQVTfokxK7mObZxGiuyiQ39qDrui
         RQKrCQtuzyeZaasC1UfBl+YwBhOMUjQDibBXbnEbJGe2Q3oiIcL7COBMX4k/bA7m00l2
         RK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769107209; x=1769712009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kwJ0a0SAodTDho6g2OsEkjwx23towh2Gp2df1yGT70=;
        b=bGd/IOSqp60pWmWMhuTTYH7RN0W1hJ9mOK6MkjTNW4KEnJ45rzIu+hRTy30GP2eXXm
         CYipvp9I3cmgK6AIDOqCzp+eWIXa+XSo1gJ2fZvd0bfDX/ymzT7UTZDf9yQxuNEZqwMv
         +BLrP3wf6LcA8MqvDJTzV87NHjAtF1ozsg1tDmo/IMNjQx0Xg/Bhw3tHJu7kYKfqugMP
         UILh0022ukqFugs8QU2kTGMJ0ge9rmmyvTTgk4yRBn5M0X2cbDb56M/HEEZubUi7d9Ao
         gh+w4U8UdvoMaZ2/221TC1KzozNgTdNm+CzpEDL2oVBpUxw241Jex4YrVZE06Hitl7PT
         8/8w==
X-Forwarded-Encrypted: i=1; AJvYcCWIyuhUHeAr/Tt5E5D8n9ssPXav9oB/59pIVLyQRQdTfaIBvmaGCMgMkswWDWnH5S+1vqor0ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6yAVoUATfKYPiyzJtDmEptIyCccdkGNnoO0mOrqCb28xwpBzy
	PH1t6oxRmW23S+Yc4uFCxKmRK/m7v/G1nlVvw1SL/dC6QEY7QSbo0Zk=
X-Gm-Gg: AZuq6aJY2nqpx+vx05WJeKD6KQUp3G++KYfBv5N10bOviLdRmtmxefv5MZMQhKN2+4A
	uASkbYovXTMCULJhuCGM2xlak2iYB6ovWuZ/amuAvD58oD8lfgVLSHoq05I9ZjstoVJ9V52jJaa
	sMig31ksmbbMF3Cz4MmNFYRLND2T/1HrSOYgzVzbdRwrEnCQiXodzRnRVJ0zdoZ1zOmTbZor0GR
	b+whOy36U6ihyzEGgLBUqB21AAfTPcFbctihs213K/CG5HmYTizubzx6r3dhq8YUSFar/RmyvDy
	eMyHBV+QExokqdZKJ+tb7mTwNyeq+lbvYOzL+rnN7DxQA05RKAj7pmkHkwi9RiOizoaqf3StrQi
	dt4l0gTtXvTP0MP8QUvTzFVJ/vViaZVZCudCT+ZxY+mAhXSpKwCHCESZ3ZhnwCk8eXTDjlen/Z6
	Rf+EJdl3pSztuhMV8=
X-Received: by 2002:a17:903:1208:b0:2a0:bae5:b580 with SMTP id d9443c01a7336-2a7fe44aca3mr4062115ad.3.1769107208630;
        Thu, 22 Jan 2026 10:40:08 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([38.76.140.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd523sm191817745ad.62.2026.01.22.10.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 10:40:08 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jackm@dev.mellanox.co.il,
	ogerlitz@mellanox.com,
	monis@mellanox.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH] net/mlx4: fix MAC table total count corruption in __mlx4_unregister_mac()
Date: Fri, 23 Jan 2026 02:39:07 +0800
Message-ID: <20260122183906.2015-2-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[dev.mellanox.co.il,mellanox.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-252488-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qikeyu2017@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3045C6C8F4
X-Rspamd-Action: no action

In __mlx4_unregister_mac(), when operating in mf_bonded mode
(SR-IOV with bonding), it appears that the code might be incorrectly
decrementing table->total instead of dup_table->total when cleaning
up the duplicate table entry.

If this is the case, it would cause the primary table's total counter
to be decremented twice (once for itself and once when it should
decrement the duplicate table), leading to counter corruption.
Over time, table->total could become negative, which would
break the "table->total == table->max" fullness check in
__mlx4_register_mac().

The registration path correctly increments both counters:
  ++table->total;
  if (dup) {
      ...
      ++dup_table->total;
  }

However, the unregistration path seems to have a typo:
  --table->total;
  if (dup) {
      ...
      --table->total; // Should this be --dup_table->total?

Fixes: 5f61385d2ebc2 ("net/mlx4_core: Keep VLAN/MAC tables mirrored in multifunc HA mode")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 drivers/net/ethernet/mellanox/mlx4/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/port.c b/drivers/net/ethernet/mellanox/mlx4/port.c
index e3d0b13c1610..6d0295c471da 100644
--- a/drivers/net/ethernet/mellanox/mlx4/port.c
+++ b/drivers/net/ethernet/mellanox/mlx4/port.c
@@ -410,7 +410,7 @@ void __mlx4_unregister_mac(struct mlx4_dev *dev, u8 port, u64 mac)
 		if (mlx4_set_port_mac_table(dev, dup_port, dup_table->entries))
 			mlx4_warn(dev, "Fail to set mac in duplicate port %d during unregister\n", dup_port);
 
-		--table->total;
+		--dup_table->total;
 	}
 out:
 	if (dup) {
-- 
2.34.1


