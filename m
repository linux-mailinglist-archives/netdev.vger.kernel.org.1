Return-Path: <netdev+bounces-306888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KdJFEUlxUmpbPwMAu9opvQ
	(envelope-from <netdev+bounces-306888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:37:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851C6742311
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pyXygfDx;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306888-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306888-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B212301544B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A5395AEB;
	Sat, 11 Jul 2026 16:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD7F2C21E6
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 16:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783787846; cv=none; b=euafYArExSD6AlIhuPRmWYEwct/0cPRlr2JiuzDY9ut0pYAa4bqC7XI5EFLOEmkTk40ozYrIdN0OvBppp+7N+sZ3t1VbDHpb9SbRnQQphQg6s4F0fZw3rP46HkaBJkYUTai63PT0MTmoZsmRf81HG2rzR61fQacOtRsJv6RgCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783787846; c=relaxed/simple;
	bh=o5yO6oWedpT3wJ7sOhO6mTOdoWLsdYRIo1vj7b/+a+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXNme/9rcwjsosR737tJn7VBS7HTkIE52ViQwSvBe/7gLV7k3+3fyfYsUQXZtT99Cpf8JbUyz/kWd+V44OA0Y2UKN+DiR+SlmDqzSPzzj38nncdg6Ga/N+PEMAj29WanJ6mh2lYG7jPd9AH+O4oWFy/UMY4VvTrGiB4UqfL+M14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyXygfDx; arc=none smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1965912b3a.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783787844; x=1784392644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M6jwjtRKl24bKNWqXMmJYe7ZpBH2H/x49wjHmv81PZA=;
        b=pyXygfDxXTlo4CT77IUjLZZPlcw/qqvpbptFT8nthc7dlUlbP4+mqPZAeeIkEXF0TN
         EWuE2PO1Lzca3SIvhKR4SrOPjaeaSSqEsMA+S6hLWtVQEdsV+LC5OP0Zmf+UG3dLbv7M
         eBXtQ1reDHafLUGQc7fVGTrNk7oMRuQxVkpM3x8rUbNpP66Tp16IX1SGVGTFc8vcAiLo
         4Mb+d7TBMy+0Kr5cOciF3UuUUcQf1FDJDMYpRu4FLDjIjkMEwsuS2J3piihCq4U10TRN
         62TiY9PogJuCVd3Ee2JrHosKXLehB8hLKqClpZFk9hJc33KNd+o6YVS2sjaVr/nsnexy
         A8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783787844; x=1784392644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M6jwjtRKl24bKNWqXMmJYe7ZpBH2H/x49wjHmv81PZA=;
        b=Q9z8ip/U5WPyara4ligi5H364TpFEF5KcTyI7+Q2M7CqzOIdCitXP2VunCKW072rub
         sovjVf+vg9F0hy4snCLgpxJGKY5eT81kpHpzij5Opi7/B9PUVSHrKGEZ7XSoXhhbR31B
         LQghijx3RxwVJp5841fQO3QujqgneXQsJM51TzrWPPHaBc/2BA38gHCp2SqsBKADltZD
         eexO6rpmwWcOl0jB8djzQodRw+LTZsvmYkMp0we8BUafO0IbCCPn5UxhnYlb+FGBHoFs
         EIW/tYfVMVc+cr1RgEj0yVrr3/ANOoJ+dUWy2IH3ZlASyRAlK1+Hk/W2l7eqQoTwZn47
         ZLzA==
X-Forwarded-Encrypted: i=1; AHgh+RoSNHWZKhk/PCqupc+Ff/jclpYonarvJT4N74P1XrHba5Wo/JPzPNd9mzffyGKgPIvJWPUZeJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrK4nSNJJTh8zC/O4/ZePW7GjbdkSxS1ZbcFoOoBQHTuoadKJ2
	WbAi1F64rJNN0RyaQZ23/SNbna6Mt8FzZEnWVMbzNeP53NLaTlkaQN6O
X-Gm-Gg: AfdE7cmpy+uwdvxTRcYDFUgYz5tY8FEyt2ybrXnKSVXGk3uFfUEEFjOIpg/yqvShl1O
	T+TjhkZCzv7ElllUk1DNTU35f+67SGP1WvYHdh4qeATGi7gLTs7ClsVBPrn70AL3+haJvjNXa+y
	nao+SGyl6FRH4BF59EFm7S0BhAYVMykQzLoYPzNd2QYLP1Kl2ljvUGx/Gyzr/tmq3BDomCiR1He
	rnzsmBNX7aCG1KqfhKX5Voew+/QE4FvWQm9BcwFpWyUTzIdZ2fEPerRhT5rBawA+f8v+7XBnucS
	MAxypl/26nsszDaHHr3sK9mYI9dVVUEZpyCA63tXqYiNhHQpWheq/rQhuBZFcGReXSKpFojlUOO
	AXSwiv4efyYgPfV73Q73rooAZ2k8E5CVhLxAEMCS8gZscnDRoj4vX6X7x7grDXdiEJCXQbHUG6G
	x1WvTJxtuhBkPFLRFKZ+cNidVCpyLOq+x0
X-Received: by 2002:a05:6a00:14d1:b0:848:4b27:36a3 with SMTP id d2e1a72fcca58-848897d6cbbmr3430978b3a.72.1783787844451;
        Sat, 11 Jul 2026 09:37:24 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:3104:36f4:5e17:15b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm11768948b3a.3.2026.07.11.09.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:37:23 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH net v2] bnxt_en: Handle partially initialized auxiliary devices
Date: Sun, 12 Jul 2026 00:37:16 +0800
Message-ID: <20260711163716.3996929-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306888-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,broadcom.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.chan@broadcom.com,m:pavan.chebbi@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:andrew.gospodarek@broadcom.com,m:vikas.gupta@broadcom.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 851C6742311

bnxt_aux_devices_init() calls auxiliary_device_init() before all fields
used by bnxt_aux_dev_release() are initialized.  After
auxiliary_device_init() succeeds, later errors must unwind with
auxiliary_device_uninit(), which invokes the release callback.

The release callback assumes that aux_priv->id, aux_priv->edev,
edev->net and edev->ulp_tbl are all populated.  If allocation fails
after auxiliary_device_init(), the release path can otherwise dereference
or clear partially initialized state.

Allocate and attach the bnxt_en_dev and ULP table before calling
auxiliary_device_init(), so the release callback only sees a fully
initialized auxiliary private object.  If auxiliary_device_init() itself
fails, free those allocations directly because device_initialize() has not
run and the release callback will not be invoked.

This issue was found by a static analysis checker and confirmed by manual
source review.

Fixes: 194fad5b2781 ("bnxt_en: Refactor bnxt_rdma_aux_device_init/uninit functions")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Allocate edev and ulp before auxiliary_device_init(), as suggested by
  Pavan Chebbi.
v1: https://lore.kernel.org/netdev/20260708143401.3167477-1-ruoyuw560@gmail.com/

 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 5c75193..a515c36 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -566,6 +566,18 @@ void bnxt_aux_devices_init(struct bnxt *bp)
 		if (!aux_priv)
 			goto next_auxdev;
 
+		edev = kzalloc_obj(*edev);
+		if (!edev)
+			goto aux_priv_free;
+		aux_priv->edev = edev;
+		bnxt_set_edev_info(edev, bp);
+
+		ulp = kzalloc_obj(*ulp);
+		if (!ulp)
+			goto edev_free;
+		edev->ulp_tbl = ulp;
+		aux_priv->id = idx;
+
 		aux_dev = &aux_priv->aux_dev;
 		aux_dev->id = bp->auxdev_id;
 		aux_dev->name = bnxt_aux_devices[idx].name;
@@ -573,37 +585,26 @@ void bnxt_aux_devices_init(struct bnxt *bp)
 		aux_dev->dev.release = bnxt_aux_dev_release;
 
 		rc = auxiliary_device_init(aux_dev);
-		if (rc) {
-			kfree(aux_priv);
-			goto next_auxdev;
-		}
+		if (rc)
+			goto ulp_free;
 		bp->aux_priv[idx] = aux_priv;
 
 		/* From this point, all cleanup will happen via the .release
 		 * callback & any error unwinding will need to include a call
 		 * to auxiliary_device_uninit.
 		 */
-		edev = kzalloc_obj(*edev);
-		if (!edev)
-			goto aux_dev_uninit;
-
-		aux_priv->edev = edev;
-		bnxt_set_edev_info(edev, bp);
-
-		ulp = kzalloc_obj(*ulp);
-		if (!ulp)
-			goto aux_dev_uninit;
-
-		edev->ulp_tbl = ulp;
 		bp->edev[idx] = edev;
 		if (idx == BNXT_AUXDEV_RDMA)
 			bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
-		aux_priv->id = idx;
 		bnxt_auxdev_set_state(bp, idx, BNXT_ADEV_STATE_INIT);
 
 		continue;
-aux_dev_uninit:
-		auxiliary_device_uninit(aux_dev);
+ulp_free:
+		kfree(ulp);
+edev_free:
+		kfree(edev);
+aux_priv_free:
+		kfree(aux_priv);
 next_auxdev:
 		if (idx == BNXT_AUXDEV_RDMA)
 			bp->flags &= ~BNXT_FLAG_ROCE_CAP;
-- 
2.51.0

