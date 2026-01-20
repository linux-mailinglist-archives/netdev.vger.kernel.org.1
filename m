Return-Path: <netdev+bounces-251341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A69D3BD5F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 03:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72755301739B
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B62459E1;
	Tue, 20 Jan 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo1ANFQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143F25CC79
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768874405; cv=none; b=gPAIsHkvjbQPKlhyyrtyK+RARBki/WkDxnRAvPrlvv630zn0XK+WDmCc9rC2QQRC+bmaiNlJCDyUrQJQXfH3FWrWpnUR8J+oMNM6iNznRc0CHDpi3oxbNl1GMgvRbQL9iziY36HUpSbzTfD8zv143OC9NGSryPCDo49XqKJObq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768874405; c=relaxed/simple;
	bh=rA4jn33vZY454aEHCpZgQgk3ckOe5SHUWCFHGgE003w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NJ5wOGaecns5g2I1vTQ83nioUUHOzkYocRiLFJFaU8+GPW8isteN9gaqfUDdtLNPGgoVdmI7ycW3Nvy1OH+obadixijlae+fqyy8lmF0XDW6g8e4+7L9c1qmiFTZJLZgbATzD1wUjvQWo1QLNJE4PxZ3oGGMb3ryX19Ra/fA7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yo1ANFQn; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so2421093a91.2
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768874403; x=1769479203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2tWDW2nXGL6Hs/Iie8O4LsIJWjCPEnqBn9C1IoyWz4=;
        b=Yo1ANFQnYNuJ/x21KukehQn4psvpFDBOV+dVtviwS4cEldoQve21L0CLLIVsIQDafO
         nE5i2Sntkzr5MF1MxJnHEwscHo6fhvxVoxG+9ie59LTYddtanCrQ9TFuTec8TgNYcUfe
         3sTbUq1X0Uee1wP2PART9aC62iEjoJ8ZbHdiQfq0DVeIpqPGVn3+iLSgNoGjasqhl8em
         IFSAksNQQMZoOI2mawtKRp7Uc9NnvidVhFzUXEWhnT4+6PusbCN+5OYfnLzBTgTKnjSj
         ydGUhy2uaTgRUszOeRrLqZaovjyHnUoWMgA6LOOivvd5t0feewYnD2ZW9a3ylApHYCkC
         emsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768874403; x=1769479203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2tWDW2nXGL6Hs/Iie8O4LsIJWjCPEnqBn9C1IoyWz4=;
        b=fPdHEZggJY+j+/TKppOubm64qU1QCwnaJnL1aTrZ4URTCKBeGMlkZkgfKqglgMGiNd
         lE57Top7wBYhAmFyZgHNub17yTd/vZcVMsC4h6BwN5H4GwVfB3sxFY1oDahLH5u65jtg
         aYP77pcd/uq1J791IyQZWeHoIt0pVZxKfnz4vn7Z8EeBk122V9WQ2UHjTBkaunNhrirH
         fbbrXkDpWjQtT/G7jhLJc466sm2Ze4R94l9KSutctfFHXpPzXXf7ZoL6kTY0jImffgvP
         3rQOZEeA4OABgoadEKAnUtRebyR5rvXQn5ZAgz+tOhdFtD5nbXOvyVqozIaH+uAKLRWw
         AFAg==
X-Forwarded-Encrypted: i=1; AJvYcCX1S3bcZI4z3D3cKxItBHkt5IQ4PVgq5lQXhkjpsrFz8BAAg21zrOM+nFNIzt9qHQJTKj5J8OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE1X2JulFo81OwOFsuy8886OV7UTKPqi1XliyOszjWabBusREE
	AWbbTb3FftYfUBrcPh2x3y/oq4VRH4HXtkwl+jZuLBGTw+BM80AZN2BL
X-Gm-Gg: AZuq6aJQN3XMqghhkTlBLv28B8zAUHg6KjMwRochsqrQkPViD660/SuxnqU1Wyaef2I
	s00p9WZiWFkBz8jxO4rgSwnCN9Q0Il6KqTPJPd9mdJZOQItG9ZNljhmuiEGo/08tViqdz39mKYI
	bYtIyxibC+qvtuTtE2N8s7XYXVK8gcOIMNgGO8uUseyXyrnGkjWfNuvPySBu1PGk7eL+/nClRwo
	DZrpgGZ2buZUkiGQcVPZOPFij1fWKLTDnWInuvYMMNiXspaNupQNz2LtcEU7HNPvjLvzulOMC7p
	n/FnFh7tAlU0RnYMo8Zt+n8szGoBruktdoYs7gMBjvM4O3G1ybJz7UOB0lIv4cgk1FOw+Fjf/vH
	fvXwFNrAszFrRiE80NBq8MKy595NkGj2+0kLzRlDBDh9y/VpmZYsZDXgla4uZwQkfQiSAOLPamu
	aZWA+GJGmXx/q82bw95VW4KIMQyAU=
X-Received: by 2002:a17:90b:1c87:b0:341:88ba:bdd9 with SMTP id 98e67ed59e1d1-3527325d1a2mr9413905a91.25.1768874403233;
        Mon, 19 Jan 2026 18:00:03 -0800 (PST)
Received: from insyelu ([111.55.145.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a10sm12725180a91.15.2026.01.19.17.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 18:00:02 -0800 (PST)
From: Mingj Ye <insyelu@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	nic_swsd@realtek.com,
	tiwai@suse.de
Cc: hayeswang@realtek.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingj Ye <insyelu@gmail.com>
Subject: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Date: Tue, 20 Jan 2026 09:59:49 +0800
Message-Id: <20260120015949.84996-1-insyelu@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the TX queue length reaches the threshold, the netdev watchdog
immediately detects a TX queue timeout.

This patch updates the trans_start timestamp of the transmit queue
on every asynchronous USB URB submission along the transmit path,
ensuring that the network watchdog accurately reflects ongoing
transmission activity.

Signed-off-by: Mingj Ye <insyelu@gmail.com>
---
v2: Update the transmit timestamp when submitting the USB URB.
---
 drivers/net/usb/r8152.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index fa5192583860..880b59ed5422 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2449,6 +2449,8 @@ static int r8152_tx_agg_fill(struct r8152 *tp, struct tx_agg *agg)
 	ret = usb_submit_urb(agg->urb, GFP_ATOMIC);
 	if (ret < 0)
 		usb_autopm_put_interface_async(tp->intf);
+	else
+		netif_trans_update(tp->netdev);
 
 out_tx_fill:
 	return ret;
-- 
2.34.1


