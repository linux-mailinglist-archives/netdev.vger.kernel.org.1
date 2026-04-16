Return-Path: <netdev+bounces-279018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG/WCJnL4GkdmAAAu9opvQ
	(envelope-from <netdev+bounces-279018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C80240D998
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 13:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7804B3036ED2
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE438F635;
	Thu, 16 Apr 2026 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObCWFDUk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66D386C12
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776339619; cv=none; b=KIo++sNXVyoF0yKOUmpOi25Itp1pr6UYeo98NzHoLu2WZD6Fd6sWrCPzV2TCMEq+1Sy2w62rzXwUoQZq1w1F1ZwZ9LLk7pLW08li+kqv3WBLY/6ef3auZrPmtDRT7M/Vy1NBIgKlc3ZPT7aMZr6lf7Hx/v944Ex2OTqM2UoNd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776339619; c=relaxed/simple;
	bh=wU86KWvNjg9FKa6DyFcGe73DrgV3W3RlisnqLxitXx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4f3GPiMlVbRS8L+ZPCju5czdUywGoZnVsT6ftlSbNk5KvUWyRs6C6/kAu134FdKk9Eo+Af777g7UKrn7C/MqeR5qJllvtssHsywzGwuA8RgQlpPJrZhplrVKaL4UvCDx6LKGcF6UJw/sLxLY92LUHELV8GAhYtdbMP2evkI/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ObCWFDUk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776339615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7y4RG+Ooy20ucTBsnvZrm2OADKlaSNt80O0jTVn3eCg=;
	b=ObCWFDUkP2QO/ajr0gyfLRhpQiOXVuqAQcb10+te76exOKDP99eXKP22dl9iFTbYbH6YOz
	iyWkOMrTadNKsIdPm17l83G7pikX+7/cqJIV38bPmNREQy5wSgwdyxsnBZEYTelUr9zYh/
	V9LtNBj3qa/3st7T1feOEJ+3I24zENE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-HRIe96FFPWqaQpJJXgMH5w-1; Thu,
 16 Apr 2026 07:40:09 -0400
X-MC-Unique: HRIe96FFPWqaQpJJXgMH5w-1
X-Mimecast-MFC-AGG-ID: HRIe96FFPWqaQpJJXgMH5w_1776339607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4110518005AB;
	Thu, 16 Apr 2026 11:40:07 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.76])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB88D180047F;
	Thu, 16 Apr 2026 11:40:01 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v6 1/2] dpll: export __dpll_pin_change_ntf() for use under dpll_lock
Date: Thu, 16 Apr 2026 13:39:51 +0200
Message-ID: <20260416113952.389405-2-poros@redhat.com>
In-Reply-To: <20260416113952.389405-1-poros@redhat.com>
References: <20260416113952.389405-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279018-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C80240D998
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ivan Vecera <ivecera@redhat.com>

Export __dpll_pin_change_ntf() so that drivers can send pin change
notifications from within pin callbacks, which are already called
under dpll_lock. Using dpll_pin_change_ntf() in that context would
deadlock.

Add lockdep_assert_held() to catch misuse without the lock held.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++++
 drivers/dpll/dpll_netlink.h |  2 --
 include/linux/dpll.h        |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 83cbd64abf5a47..95ae786e98aab3 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -842,11 +842,21 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin)
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
+/**
+ * __dpll_pin_change_ntf - notify that the pin has been changed
+ * @pin: registered pin pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside pin
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
+EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
 
 /**
  * dpll_pin_change_ntf - notify that the pin has been changed
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index dd28b56d27c56d..a9cfd55f57fc42 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -11,5 +11,3 @@ int dpll_device_delete_ntf(struct dpll_device *dpll);
 int dpll_pin_create_ntf(struct dpll_pin *pin);
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin);
-
-int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 2ce295b46b8cdc..8f97120ee7b37d 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -276,6 +276,7 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
+int __dpll_pin_change_ntf(struct dpll_pin *pin);
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
 int register_dpll_notifier(struct notifier_block *nb);
-- 
2.52.0


