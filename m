Return-Path: <netdev+bounces-143000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988BF9C0DDC
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18880B22BBF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE93E216443;
	Thu,  7 Nov 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSUkStWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB21194A52
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004495; cv=none; b=VRUo3oG0RvlNVcL+dZjm7aMyXYPmqMjqotQfBEI1odAVe3naprv6szwafsyWfWhCM6dMEjyjG22sjtmlVwIBkAzsiBKc1ml3cu28mmbbeLT8xlxAzv+iglD16XUQLlkYu42EIbN0w7jnnGsu20jQgxPqxxcM6em75rCjfaOcxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004495; c=relaxed/simple;
	bh=x3Hue5Jr3BEWlql6LAsAjH+PurZFdaVhPDfK9DjOcEg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VTkd5KOC+AaQslg3alAMH4S1mFISfwO5EgpZuZKN+4KGH3wKFjHz1JNCCDLpGtQTFkfQTIwtIRwa7FSllEGPpkS4RuMcXnNGg3W53c3xnaM9fxjKQjUpbguPLJ3yyLaQoozl8DrhNqjns6csVPG1d4DHGsjExoKpVV1s0EsRYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSUkStWt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeroendb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so2663159276.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 10:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731004493; x=1731609293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmEBU3YeKw/iHBk5W+DIb15XVTngg+/xscNH9lNBj4E=;
        b=jSUkStWtiWeqigntVDDA9ZIoJiNzh2KggkaLnLFbujvIrmoRl3+zqLCFYE4wvUIVR6
         /4SgcPUckrKsgqkG9xC8oWIZIZS4NlcOaYs+MvMGQLjnkuD3aJIeHqfZVhWT9ZpXtbny
         zSSGL7j0wrcZpTCrWhmDh+4Mb5cwn8aWNoNeCba8nR3fKwsFRgo91n/hJtiH07WMQfXo
         5+8EVfu71b/3qHfLSym94jraLEvCxrwCzOC2B1uh4OJIUYkLK+vWUvHg1OnJugrtagQb
         MTXVeR5yyQnl3IWjYQB2FWumxpAu9CYm61PSCy6iXXCsM45TEZBZO9q52VQwx7R9DEOL
         xv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731004493; x=1731609293;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmEBU3YeKw/iHBk5W+DIb15XVTngg+/xscNH9lNBj4E=;
        b=hxG09ziBiXdlrSHt8Z6SOhZ5kcPnL680CeQRGj4/J8r+Tly5+0NQ1ILV2GkoM7MZFE
         Q3XHjX6Y8kUMsWtn5qvIlfALmjor8myWZg28/2ZqpZe6d6lcWFC19jq80MJGasGzPAHp
         +pOlxI29bFdtbvrz7mRdQGvqZD+bKE0MbEubYNt/fbp6JJ48ROpMRasfkJq9s+LYes2G
         aWfsauXxNv/DEtfQdqdc6vwk6K5oCUxyKdoxo2qEkl2yhW69Qi/r0hGgxEgAN83c7PA8
         qY5q70Zry8Cj8LsN40TxuwgpCd/m4/hLrPyjiKIaY1p1CUqc+qXcUOAcJyzOf/iSkFoC
         XDAw==
X-Gm-Message-State: AOJu0YzB5md1UJBQkmLWkeiBENc74FeSftAQfKe/7e4Sy/JWG/WJ1jL8
	zfTVw0v+B1gY8JrzZ/JdGF/7HOZMefJStKlonIoDyxFfkZc3FdkRO+BMqVH8PFcvwBzKe/NY4Eg
	RG3NDPHY9mhH15wdMfVSMaVhHACeiE7TtRGQQuByktFOfGIVFTjgTOHpJSWD0bhobVVXidkPKoL
	2rCEzoDQlRftQDc91FbqPz07L94RureJGGogm7ccnvNxg=
X-Google-Smtp-Source: AGHT+IExrCnTsQKsIbR08ANldMywBPSMtSnN+oCe+Bx1qFn4EZcC5RZUqmu6l55CqDGF+uGcKLG+fyNVEXZ5Rg==
X-Received: from jeroendb9128802.sea.corp.google.com ([2620:15c:11c:202:dbff:8920:eb2e:2484])
 (user=jeroendb job=sendgmr) by 2002:a25:c705:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e337e46b447mr372276.10.1731004492913; Thu, 07 Nov 2024 10:34:52
 -0800 (PST)
Date: Thu,  7 Nov 2024 10:34:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107183431.1270772-1-jeroendb@google.com>
Subject: [PATCH net] gve: Flow steering trigger reset only for timeout error
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
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
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


