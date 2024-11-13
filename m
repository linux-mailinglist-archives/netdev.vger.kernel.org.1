Return-Path: <netdev+bounces-144509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C489C7A87
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61F72834FE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0DF202F91;
	Wed, 13 Nov 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsJCPV7c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAE61FF7C7
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520781; cv=none; b=khvhsfmUehnMeXEZURQYzpl+aJ3BUZEQoalvb1XKNEM7sz55R7zvRW1uyKjJw198YPzl8qrIUUQQiuywT+QRvpJ1yDso+PHcBLv6qoYLrj89IUmOMhx06Kp5JhbFDTnJ6HmN2yWpkQ/Ib+zQYBGc4BEPCLUJjBgTSTX6VIUlcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520781; c=relaxed/simple;
	bh=oa4jHsPwhGmEGp/xTbs7SGwv0y0lkkYSeGlEeRdKrSE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F3RuCcJMICo7d+FcQAEgD15eOZDDo3POwTfX8qUotl7lIgCBNknq55s4lhCtwHzRgr+NLr/Xe7QyGCOpZ5VOh7XiNJlKn045B03u/hEyGwG1AVg7dEM2PJvn4lkfGVqcKo7lokFclrgsuWy2kMWB2jsBa7aWTFwT4svXV/unDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsJCPV7c; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7cbe272efa6so6439166a12.3
        for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 09:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731520779; x=1732125579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OGy65TxNl8Iw/c/Xptd/4fsGkFAaUFJrtao3dkf0rx0=;
        b=tsJCPV7cLvaYROw75rx5G5mM8xUt21WQroxc4V0uikQKRuXzcUW68WU+wzbEeCzd/s
         rL0ogkyNNZBJnDgCR1D0HqM4tNSu6wgGOYZIvgN8WXW06KNEkgNijBLc2yGl05DDsY+9
         zxg1//xG0AKPtRC67vnsaBaMMEoRo8wrtGTHr1YhUGPF/CAqHPf4OWlxIkMZ3OnXW8lT
         jJyYhkfPUU2wg5pS5y/tPxld0XjY2KI++KWWNZMXnZurAy/KVe8IghtH0z3KiBcccTZl
         Bt5zPpz49GXT5sJkUACKJ8+DSiPjrM/jDFdHZyoIpapxlPzeQllxb9Em1qZ3NGhDAfh6
         vA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520779; x=1732125579;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGy65TxNl8Iw/c/Xptd/4fsGkFAaUFJrtao3dkf0rx0=;
        b=bkW6v7uUZhf0wi3qlQ+ILcTNxHeNJ+Roe3ep9kQuEc7NkiL4bnbBUd0ULymwMnCV6y
         UZYxFRpARGoAlV2ux5nhd3cvUixTNFhnaGjQGA/Eud2XHfzd3nN078hzFBl4ewhhT+Rd
         GBCYsy3Sv+QKZZ5AK34osNtJ++aNhBtce/sXsXUz3RaaY0k8hpqbz0vF3zh4C9A+1nO9
         DDSqDVHWjm7lZQm7jmRNW/IIdAX/TPssxveqVIMV8d0RTYnxHF5jpGAfRdKyBx7oT6JP
         fvBqXp83vmsGg0SRZvteHfT2RJ2LqMmpO/schFa44mwhKGQVQCjMMuL0I1QM7z5aQQwc
         Prkw==
X-Gm-Message-State: AOJu0YzDJTrMZ5i7/qDme0UN55oHNz/FB2gjFYH1X5bgUfkUZ1L5EMW5
	a88lKI8X06lC3NHtgL2dCSEqoE/YrO0FZZ2BuKZGu249bmYYQk+42K5Uok4/WvxuacdcqoMmRj5
	HxV68guk3dEIl4Tb8t1lKk3QNcERqCUe2SBzzcAOrmnBhJ8YldXopCKGmE7xg1BXyoAFPezkIBI
	Q9S19bLeWpqdDlWi5wsWsjEFlILQHVTOyVeZ4xXkf30Z8=
X-Google-Smtp-Source: AGHT+IFnQmgQwAkgXmsMOhAVpX9rj07R7oOJPSSW/T5CmMuKWbs0D1lxQHdUyOHeErsKTzwFQKa/GTC2muDPJQ==
X-Received: from jeroendb9128802.sea.corp.google.com ([2620:15c:11c:202:6a11:574c:76ac:faa3])
 (user=jeroendb job=sendgmr) by 2002:a63:3e85:0:b0:7e6:b3ab:697 with SMTP id
 41be03b00d2f7-7f6f1a10ac7mr11209a12.5.1731520777728; Wed, 13 Nov 2024
 09:59:37 -0800 (PST)
Date: Wed, 13 Nov 2024 09:59:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241113175930.2585680-1-jeroendb@google.com>
Subject: [PATCH net V2] gve: Flow steering trigger reset only for timeout error
From: Jeroen de Borst <jeroendb@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	stable@vger.kernel.org, pabeni@redhat.com, jeroendb@google.com, 
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ziwei Xiao <ziweixiao@google.com>

When configuring flow steering rules, the driver is currently going
through a reset for all errors from the device. Instead, the driver
should only reset when there's a timeout error from the device.

Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
Cc: stable@vger.kernel.org
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
v2: Added missing Signed-off-by

 drivers/net/ethernet/google/gve/gve_adminq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index e44e8b139633..060e0e674938 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -1248,10 +1248,10 @@ gve_adminq_configure_flow_rule(struct gve_priv *priv,
 			sizeof(struct gve_adminq_configure_flow_rule),
 			flow_rule_cmd);
 
-	if (err) {
+	if (err == -ETIME) {
 		dev_err(&priv->pdev->dev, "Timeout to configure the flow rule, trigger reset");
 		gve_reset(priv, true);
-	} else {
+	} else if (!err) {
 		priv->flow_rules_cache.rules_cache_synced = false;
 	}
 
-- 
2.47.0.277.g8800431eea-goog


