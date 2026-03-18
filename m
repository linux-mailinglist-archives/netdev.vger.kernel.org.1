Return-Path: <netdev+bounces-269170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCobGkD7umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:21:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C53F2C1F40
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C6E301F3A0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979393EF673;
	Wed, 18 Mar 2026 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACshw3Ka"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18A3D3332
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861692; cv=none; b=twCo7NMYDSn9b+UKqMVWHCBe2jARLEYrMlVubAJ5wTKK9WwVFORB2mu5mS1yYjLU0+5vvb7giS2mdVN1xFDkG63s8Q43862CA4Gb2vj7ZayQQRAUUnTDarsQKItBd7uaJ7qSR6nMMSyVrYTOecyzS2GX+jnjIQ5hNGJHd+tSf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861692; c=relaxed/simple;
	bh=GDi+SP7TojNzy5Hpcz7mVRnWh7BjfImltYSEk3/gEK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBGpxSF9s0Ezau0BYRjVv9aLmJO70DngHZUhVkzXsfx31nLlwB1eDp7blh7B85So7peUvG98RwfzglnzdCOxj+bBCa+O9VLC1DLe1wM2fpXIFhfiT4r0nz8Zsrqi16A/yyE6jVGxv2yaVfoNKgrcGNUEdli/yYEKsE0p/Lxb2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACshw3Ka; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab46931cf1so11114125ad.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773861690; x=1774466490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NPQGa+9XMA5plq4J8pHqZnzGZoUGgCAorDU5naqXgW8=;
        b=ACshw3KalYW23q6WdmUHkzmnJreui0bfPWyKv3R3X/wmEpam5Srbkj0VdgQT1QdHPr
         0d1beZ2YyuB1uDvLCZKUyrP7+TrzYzpr8dDI75VYyOPd8SWgbh8DdcX459mQj/5Lwgrt
         LQ47XE5j3M6F+sCszpqypB93dFPo1VSsCJ660V3ClYjY52MTmA4HefqSe5EEIt1CROKD
         86fywP+u/fQKpKjnzg45Ltky+TgHE6E4y8nTu6BZCYW8PjZCEXwxsnfAvoy5/LMuxG41
         fncjgDQJCamU7OEQjeM+aEqNuC28YxBI2MZar7ghjtYKvusmYNpFUUA93bYiwu9MEcNN
         SSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861690; x=1774466490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPQGa+9XMA5plq4J8pHqZnzGZoUGgCAorDU5naqXgW8=;
        b=RTEp2W8RvNQOk461V7//fmKBdvgnrmQaKJ/OkYzEps5m5Ipg6whff3V31Vj+9LYxPv
         1+sJmGbQ5U5Q009FAcPt28TpYgK9BEbXsIgz0N74PLpep4CtSkVK8KE53iI63wmnd3ss
         /0aMUOCkYp/GPlcNPzvunoCcwk5e8uoZgArM9oa/VLJuTSgJ8H8X3mpoLRGcNmCGyROu
         5OAUICONEj5A715zMsIXJUVgWb5FBxrQHLO+wBuQe0V/b+rTa6Pn9bBFTfSUugITXXTr
         Cw6lJ1LX/ylViYyg1btOSVKYnCEHv3R/+aSC9BDlRHi5WxYcgWuqvJR/4k2KE0Zp+ioM
         D9gg==
X-Gm-Message-State: AOJu0YxecxwKunrcvKCzOM4WQBik4H5DcqHmXWmhbvfpk7ZuhFKWfgg1
	rm74FyjwlD4vnAert5g4j2MdLytLEFOhvmYEN9PDdj1/2Intjptg5VS9ZiD3sw==
X-Gm-Gg: ATEYQzzPH7NUYnH2ERECyaE8HLMVehqa4phS/1nyiGdrmZ6eWUzeUxIr1m8Da4zfehr
	WGfjgOMTi+lukF9w6ulWhg8hnEl7/2KbJ5vylpKm9CAVtKJReU+k9tdkVxppPBw1hZSbizOTWew
	aCi+OTor8mqstRwnajIaFa+527/XO/G8T+6iqloisCcP9YT6HccDPA3IELUSTJ3NX66P4vUPGq8
	2nfVW+slDIDUiNUyvdeFET95PrmJU2AGMi++GCYxMGOvNBXU/qb1RgAaAxiC/nFuPdkOU7X+QQc
	tWB4zlNaCCGfQ1fbubaGxltgc7KKTfKnPlMdrO8hl/xfRPxLkK2HzpplRE+D+MlfgOiTMyZdCGB
	NQJkjsVfwxG2glKlHpZwJiiW/FS93c+yCHFMKDCGNWFEyRUz48ZCgOhpNe/1cC08ZFcuyAfZpIr
	vUoqWdFlFKt0XxZSA0gZYD5jMeFAJ2+xnrCmZrJstAr/m6lk/8ZRqmwOh5LWLmEX8b6A==
X-Received: by 2002:a17:90b:5547:b0:35b:9d0c:a2f3 with SMTP id 98e67ed59e1d1-35bc606ff0emr476139a91.15.1773861690455;
        Wed, 18 Mar 2026 12:21:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63204f2sm409269a91.16.2026.03.18.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:21:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Elad Nachman <enachman@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] net: marvell: prestera: use kzalloc_flex
Date: Wed, 18 Mar 2026 12:21:11 -0700
Message-ID: <20260318192111.6802-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269170-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.879];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C53F2C1F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplify allocation by using a flexible array member in this struct. No
need to free separately.

Add __counted_by to get extra runtime analysis. Move counting variable
assignment to right after allocation as required by __counted_by.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/marvell/prestera/prestera_devlink.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
index 06b876f6b27f..9c043cddb0f9 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
@@ -125,8 +125,8 @@ struct prestera_trap_item {
 
 struct prestera_trap_data {
 	struct prestera_switch *sw;
-	struct prestera_trap_item *trap_items_arr;
 	u32 traps_count;
+	struct prestera_trap_item trap_items_arr[] __counted_by(traps_count);
 };
 
 #define PRESTERA_TRAP_METADATA DEVLINK_TRAP_METADATA_TYPE_F_IN_PORT
@@ -451,19 +451,12 @@ int prestera_devlink_traps_register(struct prestera_switch *sw)
 	struct prestera_trap *prestera_trap;
 	int err, i;
 
-	trap_data = kzalloc_obj(*trap_data);
+	trap_data = kzalloc_flex(*trap_data, trap_items_arr, traps_count);
 	if (!trap_data)
 		return -ENOMEM;
 
-	trap_data->trap_items_arr = kzalloc_objs(struct prestera_trap_item,
-						 traps_count);
-	if (!trap_data->trap_items_arr) {
-		err = -ENOMEM;
-		goto err_trap_items_alloc;
-	}
-
-	trap_data->sw = sw;
 	trap_data->traps_count = traps_count;
+	trap_data->sw = sw;
 	sw->trap_data = trap_data;
 
 	err = devlink_trap_groups_register(devlink, prestera_trap_groups_arr,
@@ -489,8 +482,6 @@ int prestera_devlink_traps_register(struct prestera_switch *sw)
 	devlink_trap_groups_unregister(devlink, prestera_trap_groups_arr,
 				       groups_count);
 err_groups_register:
-	kfree(trap_data->trap_items_arr);
-err_trap_items_alloc:
 	kfree(trap_data);
 	return err;
 }
@@ -594,6 +585,5 @@ void prestera_devlink_traps_unregister(struct prestera_switch *sw)
 
 	devlink_trap_groups_unregister(dl, prestera_trap_groups_arr,
 				       ARRAY_SIZE(prestera_trap_groups_arr));
-	kfree(trap_data->trap_items_arr);
 	kfree(trap_data);
 }
-- 
2.53.0


