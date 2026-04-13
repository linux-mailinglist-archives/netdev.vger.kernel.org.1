Return-Path: <netdev+bounces-278049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COS8KRfS3GmcWQkAu9opvQ
	(envelope-from <netdev+bounces-278049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:23:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B7B3EB391
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C32A2300D864
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 11:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71B3B0AF1;
	Mon, 13 Apr 2026 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH1w5m0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CB30FF05
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079249; cv=none; b=b94LfDRH+VrrQsaN3uoqDIbI1uzAxLiVgjWef3zjzbQXBE+J4Jp89G/eMS8327KHj1Zzuc5EdcBw7DotJU23860OOD1dWjHkzNiv6pbf5Aa74S9pfKi1/Ml4rjqpJMRXrSknOReK5slWlFBjvA0clMaORO5kf4yYkcYpzfQk31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079249; c=relaxed/simple;
	bh=R5urYhnoHecl+KVX4m8FZXgsJfZf3ZpUYspi2EHPFBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DuA/mG16xUeTQOsc40Igprd5n0xdGNQB+VNkUE6CY2UrEAALkhZgh541/vh7t5+KsjFAjzcbo9F8I1pMaw8s+Ow4wlEoO0k0Cmy/iYpq1BQDW1aHk+IZmIg1JnwmGq2t92QPsXs09mblTGG60U6YSRUwNGjCNAZ/05K+ldhT+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH1w5m0/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82418b0178cso2096826b3a.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776079247; x=1776684047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
        b=dH1w5m0/WlAoZqvADSMi1fTBWlr7hchAIJlgpfCiiMuqLTucEhlMLKpbMXa15uJQJq
         2Tz79GD8D2or5W65WoFY+OHew59Se6fEm7aeHj5uCUvneffTU+0mn0GDaivxMbCSLFyM
         7wsb9n6E4SHVQZTPAnB6ig7iEkePBU1uPr2Ie89U1qk0tZ8PeMn8cK7203+VHVJskavb
         2EZgekwIdmpqb1OeDPFbg9bXjG3ZWaBhvP77HldYwnquWlcGcSkmJWKtZ4bmP25mI/Gi
         Ak3Rzjrj1qT6rOSGcvcVKOoMK9HEVb2VQ2R2w9RGU8109NRgB0nH6NjNx4aWlpIAM5Pj
         Mo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079247; x=1776684047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ7f9KI9JqtBNgCC6+8bgvZa6CW8q9FixqdbvIgHfKA=;
        b=Hq84Ch990XREJbuosQ8bn60AOZQOZ0PZFbAvPnzSGadAP8XcH9Ml0LTy8GznwEIfQE
         9SNbbpfBxxUb5MT7RZuXTFOD/45IKoyYi/BpOLAXWOEKJW2BhrCFy3PbgybfQc+cJop3
         pnrs0Q50IXRFoSSkbezECUIbNltCjm9f9XQF5iDgAS7wdAsEaif/b++QAwRItHzwLvIE
         cabRijvVDP/mNWF3aKrT8RT4gI49AqBOtjYZwept4VMZGHDYxObryzSzG1STr3DtVj0v
         AH5KVas/Bq4mEN5n2eiJy+GO/TPSmxZlDPklPtsSP7+AcFb9HWWy8rRyepPJV5vUocod
         Fyng==
X-Forwarded-Encrypted: i=1; AFNElJ9GUu3S6LiGdh6S/Op7OcXcPdZKZN9jPOZyrTipvv5wjC5U7JFG5dlrtcPIixamGQGMxtdHrow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwowwcKml8+O/fY416rEFVc/BG1Z7M9VlzUmP5L4mRlJFY1au9
	64aDIHdiNq5S/lsh0/sQ7VBdZHx5u/WhsGMZMTiJfGnPlDiC6cT5vYcX
X-Gm-Gg: AeBDietC/pP/DMBl+44YZJ2D1swQAp6kBKyvF78vWIVOK7XiKJNMPJSoJ10dIIu4PPY
	rDyWgAMo3tNDNKrxVwDiBmNM35bBNCDXomPx5Ms79WEN51YeIe3EZ0F/eL4OkaS11cMgAVwKdlt
	wzMsrsLi6t6qBlrj2i/ZGoAxwc8Xffxj0Bm+gFOyG20PoAxbf/vdWxfM5EMbkBiTs1edKFIS+u0
	alFj+NLI5wBlECCVlUgo7/DzzWlZXdDeYOUEVlYJJd1VGbTbgXiLO7FnlTmXL0gbyEcv3vy4GYU
	i0FbPhwzggGovcuGwPYba6bgeI4pz2AYblzjX7dGHos/qywc2a3tCbtATBTodty9ysKGGYFswpF
	dz7+aYIsG7rhWgEvFX25hO05fjvkeCQqLiEqtmCZCa1QQJ2s5JDKJpIdKMGgT8Mvl4/OnwnC8/0
	TnRJHV3mefbqhrEw==
X-Received: by 2002:a05:6a00:1887:b0:829:924c:348a with SMTP id d2e1a72fcca58-82f0c26b71fmr14463158b3a.45.1776079247519;
        Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4df7f5sm13555346b3a.43.2026.04.13.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:20:47 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] dpf: fix UAF and double free in idpf_plug_vport_aux_dev() error path
Date: Mon, 13 Apr 2026 19:20:30 +0800
Message-ID: <20260413112030.2694563-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-278049-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08B7B3EB391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, idpf_plug_vport_aux_dev() calls
auxiliary_device_uninit(adev), whose release callback
idpf_vport_adev_release() frees the containing
struct iidc_rdma_vport_auxiliary_dev.

The current error path then accesses adev->id and later frees iadev
again, which may lead to a use-after-free and double free.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix it by storing the allocated auxiliary device id in a local
variable and avoiding direct freeing of iadev after
auxiliary_device_uninit().

Fixes: be91128c579c ("idpf: implement RDMA vport auxiliary dev create, init, and destroy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/net/ethernet/intel/idpf/idpf_idc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c
index 6dad0593f7f2..2a18907643fc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
@@ -59,6 +59,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 	char name[IDPF_IDC_MAX_ADEV_NAME_LEN];
 	struct auxiliary_device *adev;
 	int ret;
+	int adev_id;
 
 	iadev = kzalloc(sizeof(*iadev), GFP_KERNEL);
 	if (!iadev)
@@ -74,11 +75,14 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 		goto err_ida_alloc;
 	}
 	adev->id = ret;
+	adev->id = adev_id;
 	adev->dev.release = idpf_vport_adev_release;
 	adev->dev.parent = &cdev_info->pdev->dev;
 	sprintf(name, "%04x.rdma.vdev", cdev_info->pdev->vendor);
 	adev->name = name;
 
+	/* iadev is owned by the auxiliary device */
+	iadev = NULL;
 	ret = auxiliary_device_init(adev);
 	if (ret)
 		goto err_aux_dev_init;
@@ -92,7 +96,7 @@ static int idpf_plug_vport_aux_dev(struct iidc_rdma_core_dev_info *cdev_info,
 err_aux_dev_add:
 	auxiliary_device_uninit(adev);
 err_aux_dev_init:
-	ida_free(&idpf_idc_ida, adev->id);
+	ida_free(&idpf_idc_ida, adev_id);
 err_ida_alloc:
 	vdev_info->adev = NULL;
 	kfree(iadev);
-- 
2.43.0


