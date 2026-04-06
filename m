Return-Path: <netdev+bounces-275760-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL5JBbky1Gm4sAcAu9opvQ
	(envelope-from <netdev+bounces-275760-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:24:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F13A7D66
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D23C93019D95
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1439EF12;
	Mon,  6 Apr 2026 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ob+AoFJG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4EC39E19A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514225; cv=none; b=LXKWeu9/9Tdvm4nASkvu0sniRwfIrSkesI2mGgpRMQyX24h4THXkojdOMLC2XPGxsZL7g9KoNJpgzVnv3pspGlIKd+eBPeaS20rWd1UA93JbhrjQ7c62kc7p9C2qkPRY4pzRagQi5vvai2i5BZ8B13TQ9OxD3aG9QyheeozKD/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514225; c=relaxed/simple;
	bh=eQqN3WwmL+GKV66eTNFDfzI/Xpo7OnGTSMQNKgBmduM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ow79bpFLTzRbAMUpc8OB3bCXYKPz7JyVnmzykaAb05elIh4+OMOxyRdkTOAKRv2h6nGsOdhY5/foWYqOKHDxiEtX+oyrUlw6NXftBMOpm84uccBenhmL5bdabT2DBxP2y65X31STVv0ZSWhRbJzp5hYXw2SX1vRr7UM11xGWqpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ob+AoFJG; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-6501418152cso4125225d50.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514221; x=1776119021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fcKNgQxRCjege+WF/XA3NchdYviyxkpeHKiS3ggmS6Y=;
        b=Tz4sjEY8H4vL9jrpM0sKbbKreFgh1RyWSkuFE7wLynJHUvkkWiaa0vLymTod8s/a/2
         zZG7PHi4+Ig5i3zDWAvt+hD+nQHPGROPwnA9aUk/4HHnw9iu/IAlDxN0qVA/+q4KzsOA
         3ezrRwD+tVbOokMnev/xGxLXujW0DNYnouPPrU1I8ISBl6wRypVPjbMmJwIQp70nk+59
         0UFmbi2exCbcwSvibjB3/2ZdoIiXC9npc6XwBMjPiuSFx//DlJq9672+p0OIBfvjlFcb
         vECbQhcPjPkozp9p9QAzlmZ3sHto7ZTkmLfqeGPMFxLZjzMDtIO9QFWxFi+KguEDrV+D
         u0fw==
X-Gm-Message-State: AOJu0Yz9aFGcATPZE2AimQZVwLY9RMiD7HG/ELW9TG3ntNFTKikkZtaM
	NrgQsQarNdkw7lvwQbk+6AaveXhU5dfwZHwHLtASfkRiEDI/WXjPqQ1Lje7YrFO1jBXNSDTKub1
	u3KJl3yTzRsGbIlaJZsEd4HC+0sNfCr698OYIiUjxr+3d+reBYdqiwLMFcVqblchBF55eLSa9bq
	RN4X41jkh8jwYdqy9TnCUFbhPkMALAYoK5oLX3Tke7f5ZznMN4Ls8qNXJUDxr/G2gyrA09V77rf
	0LdgKbZPvWCq8sci0EK
X-Gm-Gg: AeBDietHcfiIuh4V+3Mp1op1OGv5jkPIBEf957QZJuNplQZhprY6oForr49Mk5bxjYf
	07i8ffn8UcEhsvTkROLXLDYoyUeGnfjXsz4caZ559pwd2LL+NmuAEekjGhPrFYRx07pxCzsl81c
	QIGziWTC2MeyWj50hxIjlnPOBQEOYiKil7Ykp9gvwHq03ZRsT3aPCx5Fjt+a4zYf/3GJiV0wH1n
	QFRoaPdWcJ5vhbWiD5y36onWG8fxhGat8PUmXzQ/LKMuXjPr5gmjJIGhUw8kCbqVphAw8sprjgC
	zieSA1fFtC4//BmGltsQAC5rLbJzc1QGe1PCyjr1a12itrkThY2oSKp1gd6aroDKYGFB1N4gJ2Z
	fZcYGfc0xrVsp1CEU+/ZpcWD/K0IZ5QYiKgDwZfey2WfVARClnI+aZywIiZVTCIyyM2bpAr9R7o
	YtJmJfDz/nuLwj4nRBVcUHkekySXFK/I1nFsCNP/ZFxZNJJhyZKr/KqaZH9IhoBYU=
X-Received: by 2002:a53:ad4c:0:b0:650:211f:1d4 with SMTP id 956f58d0204a3-6504886c5c4mr9334821d50.47.1775514220819;
        Mon, 06 Apr 2026 15:23:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6503a9b0937sm870960d50.27.2026.04.06.15.23.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 15:23:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0ba59a830so5998947eec.0
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775514220; x=1776119020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcKNgQxRCjege+WF/XA3NchdYviyxkpeHKiS3ggmS6Y=;
        b=Ob+AoFJGsayGsJwzAo83AJ/LU1SrYe35bTizA1jRk1Q45TA1eYH+38E0pfkaA1eGBY
         /Dev+h7CEJr2nOxPE23ULW25wlsibWyLd+twtJM0K0jTwSqc7seojSGHkcaHNnBOhCly
         UwO7iJGmyFCxOC4AGUtQ2/ZRiRmmMmI2CjXFk=
X-Received: by 2002:a05:7300:1909:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2cbfc16e25dmr7463224eec.21.1775514219647;
        Mon, 06 Apr 2026 15:23:39 -0700 (PDT)
X-Received: by 2002:a05:7300:1909:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2cbfc16e25dmr7463201eec.21.1775514219104;
        Mon, 06 Apr 2026 15:23:39 -0700 (PDT)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm11771909eec.21.2026.04.06.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:38 -0700 (PDT)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [PATCH net-next 3/3] selftests: net: psp: add crypt-offset and spi-threshold test cases
Date: Mon,  6 Apr 2026 15:23:05 -0700
Message-ID: <20260406222305.4111170-4-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-275760-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4A6F13A7D66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add test cases to set and get crypt-offset and spi-threshold attributes,
verifying both the applied value and the restored prior value.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 tools/testing/selftests/drivers/net/psp.py | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/psp.py b/tools/testing/selftests/drivers/net/psp.py
index 864d9fce1094..9253aab29ded 100755
--- a/tools/testing/selftests/drivers/net/psp.py
+++ b/tools/testing/selftests/drivers/net/psp.py
@@ -171,6 +171,38 @@ def dev_get_device_bad(cfg):
     ksft_true(raised)
 
 
+def dev_set_crypt_offset(cfg):
+    """ Set and get the crypt-offset """
+    _init_psp_dev(cfg)
+
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    orig = dev['crypt-offset']
+    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
+                       "crypt-offset": 5})
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['crypt-offset'], 5)
+    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
+                       "crypt-offset": orig})
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['crypt-offset'], orig)
+
+
+def dev_set_spi_threshold(cfg):
+    """ Set and get the spi-threshold """
+    _init_psp_dev(cfg)
+
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    orig = dev['spi-threshold']
+    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
+                       "spi-threshold": 10})
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['spi-threshold'], 10)
+    cfg.pspnl.dev_set({"id": cfg.psp_dev_id,
+                       "spi-threshold": orig})
+    dev = cfg.pspnl.dev_get({'id': cfg.psp_dev_id})
+    ksft_eq(dev['spi-threshold'], orig)
+
+
 def dev_rotate(cfg):
     """ Test key rotation """
     _init_psp_dev(cfg)
-- 
2.45.4


