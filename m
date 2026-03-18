Return-Path: <netdev+bounces-269074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLz1EGjGumlobwIAu9opvQ
	(envelope-from <netdev+bounces-269074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:36:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0B72BE55C
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E643298051
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034293E122F;
	Wed, 18 Mar 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOJhrXtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD83DFC76
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846651; cv=none; b=iwRNCzr6rXW6DAL2cfZrwYLgqRkaGywKMTo9IGjB7If8AGJZst+Zama9nMpRxdqp5tHCXC2VEt9bzat8KW9is2MGeyXpXLDCqSbmoPhkJohoylzWK/mIKb8gVc0dNQo2GgzkCoGiCjWrdPig2aTbcs/uhIzVT13QfrdYOTtrsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846651; c=relaxed/simple;
	bh=QG2BtrENZ1xORdkNqsDB6dpPSvjNG1S30qT6a0FlLMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kM1WTGCf3UDAIGoVMJziKwYCJI5ReIYoq3XDm33fBwMUgtKWHxaoVfWIYiMMr/4L1px+hrTAlRlwLdfG7YD3KHAZ9mJvstkCCsraG3KOwjPLiDHCL2AojEl8AZaRIONja1uIIs0kIvL0/5pP3LtOZIx4ACoykScmZf3O8BRJlzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOJhrXtC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82989744ee0so26553b3a.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773846649; x=1774451449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3RkPnsLYSDbKLEv/BKhHIWIll2IYC1YAGuzM3YXuSw=;
        b=VOJhrXtCM03xnJ2IfuxoTlqAVuzKpLmEjqqPKPINQ9M5MHaasEIcFOfwmaSugv3Bsf
         rNMMwBD9OnQDskrbV/UAbmoIzp+vOgeslUbux4sru4BG7+fVjljuNix7JJO5p8Y9uZS6
         /WfXLpKcSYfjpeFT8N0e+wmWTSbrGvMAMbQMr84yS/7OGEaVDpRlox7WcDyd0QRwbeZb
         JQIZpog8kjLljS/1XfCfZ4H24IRDLdLKtzmKcCgY7pYjyots+IQNDOzjn0O4YD4eNpNs
         QYMzrisFI+d4gWgpp50CPHk0USXPvAOkySP0pBZvbEZeb54PWpMfRnmg8lgXZOIUXn1O
         0B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846649; x=1774451449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3RkPnsLYSDbKLEv/BKhHIWIll2IYC1YAGuzM3YXuSw=;
        b=hHY/U1Uspz9K99XCsGSb7z8lOY/r88CIlY0UJ49ezSYpVz2VZSJ+Zinj+7al9BcffW
         wgqqnHNUzbDxNUglcn0brRRfPo+VrVnIY85kq0q7Z5bfUV2HEIBmeMdM+dliyZUaIE9S
         fxt7JTPe3Xf0m/BDopn1N9MZiBYdtrS5cFXxcrbJuq2bjTW8cJycM3IXSwk3TLqZRitx
         N4cWd7jOQQQzx3Lv7TdIbGcb2CfNKO7AztE8DPIgKf8RuaaLwqavTZQ83E/MDJUMu0QX
         NP29iutq1e8nko83HAoyTQBEpw6f+4psQe4aErSwSIvAgKw1opWj01OhkKd6EQFlnysy
         9WKw==
X-Forwarded-Encrypted: i=1; AJvYcCVo1mxRUZFl+wxrQiON632TWeXUwEHx/+z0+7yeqYFvrAWP9DFWrYOpt2XvhEZfNpt1LQ2pIZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEiQThj2E8nDdPaOUL0UCfL8r7KEf5FR29FVCAj+vH/pclNVm
	UXWmXYqgSuEWKu7PPWdbufLqeP+EH9So+kSc3mKpS8ztSv/4qMuK95YL
X-Gm-Gg: ATEYQzwGueaByeG7sAEwE7sf6BOpHeKQcoOj4jHpV7h17QMyzQcs5A5JogMY4Qjb4J/
	RQLFjwBiL2ZHUx2bvX4jwrfJM2+/09sJohTotnPHBokfs77qkKjCATHDtCmVcfIp9PaFuH3VFIL
	LHjFHW23F1fRM2xTOhKQ2Y0id/KxJFVyXXp73h9uVNA7IA+HOR9bwxbC3AA8h1Ji57X5KJ096C6
	qW1rkORzEJia/odJaOPueKlD0RBArvBmg/4VVt5JVy1PisaF4i661C4RtzcpRpXo3yGYNuytiww
	pxQhwX5UzEfj17raEjazh10pgtEzXTWDdcSwlKeSRfXTiWzrB0VyQZnUVst5IHYNEzKeXjQimhh
	OGxbkgmp1P6cszMS05GWYsMr3ZTJSzyJCEClAvvHATa34tb7gQ9jwxEh78ZzQ7VQX6KvGs/ygLr
	xiN3YRknHLeSxot8dJXdPQ
X-Received: by 2002:a05:6a00:3698:b0:824:9848:b020 with SMTP id d2e1a72fcca58-82a6b26e7a3mr3339406b3a.52.1773846649082;
        Wed, 18 Mar 2026 08:10:49 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bef2fdbsm3090533b3a.56.2026.03.18.08.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:10:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ice: fix double free in ice_sf_eth_activate() error path
Date: Wed, 18 Mar 2026 23:10:28 +0800
Message-ID: <20260318151028.634828-1-lgs201920130244@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-269074-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.861];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A0B72BE55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When auxiliary_device_add() fails, ice_sf_eth_activate() jumps to
aux_dev_uninit and calls auxiliary_device_uninit(&sf_dev->adev).

The device release callback ice_sf_dev_release() frees sf_dev, but
the current error path falls through to sf_dev_free and calls
kfree(sf_dev) again, causing a double free.

Keep kfree(sf_dev) for the auxiliary_device_init() failure path, but
avoid falling through to sf_dev_free after auxiliary_device_uninit().

Fixes: 13acc5c4cdbe ("ice: subfunction activation and base devlink ops")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 1a2c94375ca7..ec6020338b9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -305,6 +305,7 @@ ice_sf_eth_activate(struct ice_dynamic_port *dyn_port,
 
 aux_dev_uninit:
 	auxiliary_device_uninit(&sf_dev->adev);
+	goto xa_erase;
 sf_dev_free:
 	kfree(sf_dev);
 xa_erase:
-- 
2.43.0


