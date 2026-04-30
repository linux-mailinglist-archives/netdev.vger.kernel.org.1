Return-Path: <netdev+bounces-282880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OE4uFBZk82le2AEAu9opvQ
	(envelope-from <netdev+bounces-282880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:15:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B94A3E6E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3040E301DAD8
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851E429809;
	Thu, 30 Apr 2026 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0y2IHH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C03A1E8C
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777558546; cv=none; b=fmJoMIIb1IND6lJVN0lXJ2DToM/DbBlQpLh8Q+MMfrJc4vT2+Lj36gAfY4mAgOFzLSH9ysN9TIPjXpNrJtG5q/K1dtCyd3xnKk/b7dyzj9IGpgikk/AIOcFMimcSw99ZmLN/m4dgU1/ySXSJaGA4f5X7ZSANtuAAz/99FkD0PuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777558546; c=relaxed/simple;
	bh=NUgw9VtHhOH1SDxH2pZXbRmyq38I9DnKn/coZE2Y2ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GJGH/jsqUpo+QsOv8X7adnq5wUQ9fZVCURNMtiOAk+ZlvK/krqvBmGwzm+NWlLO8b++rfwHojcC7okjBg0K83bR+8jOHkF/Z4TdlgxYf2wy4ZMDef38YkIP5xj+X3bsTbt1x2w5Hjml9oXeF4GqsVYFehAxo186jwWxZ6b4U+K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0y2IHH1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so93385e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777558541; x=1778163341; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vi8NDKusFCMVruLpinmrdqk1EXLTyT/eTQZyAXfJaw0=;
        b=F0y2IHH1/8mNd+6AXEKvWhxp8R2WdiSyu+paRogKzMLLbqOdLWVGXgbzApHXxmgfgN
         l2DBmwm7j7J5K50yzVDKFyfXWmrtfXLKzFlbLmOpp35eW8zn93818dCNBK09Q9whAZ8C
         tRVOEBvtrnBbW0MUboOcdx4e1/nI+JjZbxXqLfhSfEyT+ycUcyGvbyoRvCaRh0w0I68p
         eSoSNpxKFxFhWbjo8EdW4LhBsgi7whfgr3xwb1eK36QzNNLEyJRs2oSG5U3vaRmADBsE
         YQVGg7ijnIK63xlUekX3GthQeSfu+rFNDHABIdm/20hZNKRGVeSHbP53vUxLlw5vvROd
         lP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777558541; x=1778163341;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vi8NDKusFCMVruLpinmrdqk1EXLTyT/eTQZyAXfJaw0=;
        b=Wn0U1gY4J94iwMeULkCmHN0sOapge2gRnxSiPiNSxOW5mLNYbyPqcsCvea7P1vC1z9
         5VkawK/VVmKky0nLaQu9+1J5pzsqHFzv50jmTyHHcG0fLmsNWZ043ZtPY4HjlSITHqIq
         oI5h/XCJT/1Zn4GmnsqU89IZ0XuVaFbN262Z4EgP4UDtTwBnvxu62NpeX1fs4E0n2hiQ
         MBupy67Qlf9G5I/AMTe8kvVS9xduSeQvYdrFwe9ru92zXPhEemdcPu5273SZIuWTnlVB
         ksbKbTh7NO0P55gNxiFq1DDk5/pI04BzK7lxC6WMTVig5GoF4emEgij5YHnjpu0XRE1F
         WnBg==
X-Forwarded-Encrypted: i=1; AFNElJ9fUBlMaRCfJtSuzO8q/wR7JLW0t2/hSBoTJsxOL18YVEwMulxWjq6Q3S+F4cQG+AG7b0fB6AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPKHWO/s/IqP/nQwNS/rZE3p3YnMaeU80iOgaSob0oVD1BEud
	A3x+3W1DqEThUl6Tx2Jskd1LOy8bbedSBzC4Sjr3QVpNOZnJXQwmJOku53AuyT0DYQ==
X-Gm-Gg: AeBDiesoCQZK2beMN2XonXAWk9fRHBfGvghymeN46HbC4hjZ1NJzC+T5akvYLRKqnxr
	lJnue4Es5opB7YGsIWd/d3Z7n0odSMdQ9dCSnaRlCKyYJVZFeksoniGW2BhW3DRJvvOS+PLqyRB
	lSYRdjnU8v5leLkN57Og22IRDt/r1U5JMWrquCBloChAjtvWAv+BnzOOj1xrH2A11tIk0hWi0Zt
	mI2Yi+fBy7kSG7NR0aUpu/HU/qoL2pmemyvFHSXIX+hdWljAd5VWSDeVPNA4PIHa61ozSy0Kufa
	lB1YN8b2VpwM8N3anaZlniCl5s4sT7upGI+MWjxWgNZxhAIH6P93QRbEMdm/Tt3p5BXKN34qrSt
	OXSK5UYTaqldVU2c6WIew7eh2AD3/baWH9KidX3Z8X1iXuW/4JDTXumjrqoC2up7iOCBM1626IQ
	Q6KEaDyPBHh9wVTR6kh466x2JXjwcIypVNCxOOxv3Z+d9nxejfxh20XctLXJc/5trwxz1gPGxbb
	omFlv95jw==
X-Received: by 2002:a05:600c:8a17:10b0:48a:6321:87f7 with SMTP id 5b1f17b1804b1-48a83089695mr956005e9.8.1777558540959;
        Thu, 30 Apr 2026 07:15:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:353:619f:ca87:2581])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b9313c9sm44276955e9.11.2026.04.30.07.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:15:39 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 16:15:33 +0200
Subject: [PATCH] kcov: refactor common handle ID into kcov_common_handle_id
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
X-B4-Tracking: v=1; b=H4sIAAVk82kC/x3MTQqEMAxA4atI1gZq/Ru9irjQGjWMNtKKDIh3n
 +Dywce7IVJgitAmNwS6OLJ4jSxNwK2DXwh50gZrbGWK3ODXyYWB5sGdEtDJvotHldNGaMus/hR
 NOVoaQQ+HOv69965/nj/4b+jTbQAAAA==
X-Change-ID: 20260430-kcov-refactor-common-handle-25178495b2eb
To: Dmitry Vyukov <dvyukov@google.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Potapenko <glider@google.com>, 
 Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
 Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777558537; l=7319;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=NUgw9VtHhOH1SDxH2pZXbRmyq38I9DnKn/coZE2Y2ro=;
 b=w1wS50tB8THjaYvysUQGGWgnG9EF+LO73Pv68csEK5kfA8uYeJKksc86HaweNr0lcBbvU9z+c
 08zCfmGaVt/BP/BZ2F0vI+j8BtWW7AcZMbnkIlArjRuP127cTiY62qM
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=
X-Rspamd-Queue-Id: 9A4B94A3E6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282880-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,googlegroups.com,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org,linuxfoundation.org,zenithal.me,vger.kernel.org,redhat.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Store common handle IDs in "struct kcov_common_handle_id", which consumes
no space in non-KCOV builds.
This cleanup removes #ifdef boilerplate code from subsystems that
integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
diffstat).
This should also make it easier to add KCOV remote coverage to more
subsystems in the future.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/usb/usbip/usbip_common.h | 29 +----------------------------
 drivers/usb/usbip/vhci_rx.c      |  4 ++--
 drivers/usb/usbip/vhci_sysfs.c   |  2 +-
 drivers/vhost/vhost.h            |  2 +-
 include/linux/kcov.h             | 12 ++++++------
 include/linux/skbuff.h           | 14 +++-----------
 include/linux/types.h            |  6 ++++++
 kernel/kcov.c                    |  6 +++---
 8 files changed, 23 insertions(+), 52 deletions(-)

diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index 282efca64a01..be4c5e65a7f8 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -282,9 +282,7 @@ struct usbip_device {
 		void (*unusable)(struct usbip_device *);
 	} eh_ops;
 
-#ifdef CONFIG_KCOV
-	u64 kcov_handle;
-#endif
+	struct kcov_common_handle_id kcov_handle;
 };
 
 #define kthread_get_run(threadfn, data, namefmt, ...)			   \
@@ -339,29 +337,4 @@ static inline int interface_to_devnum(struct usb_interface *interface)
 	return udev->devnum;
 }
 
-#ifdef CONFIG_KCOV
-
-static inline void usbip_kcov_handle_init(struct usbip_device *ud)
-{
-	ud->kcov_handle = kcov_common_handle();
-}
-
-static inline void usbip_kcov_remote_start(struct usbip_device *ud)
-{
-	kcov_remote_start_common(ud->kcov_handle);
-}
-
-static inline void usbip_kcov_remote_stop(void)
-{
-	kcov_remote_stop();
-}
-
-#else /* CONFIG_KCOV */
-
-static inline void usbip_kcov_handle_init(struct usbip_device *ud) { }
-static inline void usbip_kcov_remote_start(struct usbip_device *ud) { }
-static inline void usbip_kcov_remote_stop(void) { }
-
-#endif /* CONFIG_KCOV */
-
 #endif /* __USBIP_COMMON_H */
diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
index a75f4a898a41..a678e7c89837 100644
--- a/drivers/usb/usbip/vhci_rx.c
+++ b/drivers/usb/usbip/vhci_rx.c
@@ -261,9 +261,9 @@ int vhci_rx_loop(void *data)
 		if (usbip_event_happened(ud))
 			break;
 
-		usbip_kcov_remote_start(ud);
+		kcov_remote_start_common(ud->kcov_handle);
 		vhci_rx_pdu(ud);
-		usbip_kcov_remote_stop();
+		kcov_remote_stop();
 	}
 
 	return 0;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index 5bc8c47788d4..b98d14c43d13 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -425,7 +425,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
 	vdev->ud.tcp_rx     = tcp_rx;
 	vdev->ud.tcp_tx     = tcp_tx;
 	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
-	usbip_kcov_handle_init(&vdev->ud);
+	vdev->ud.kcov_handle = kcov_common_handle();
 
 	spin_unlock(&vdev->ud.lock);
 	spin_unlock_irqrestore(&vhci->lock, flags);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 4fe99765c5c7..0192ade6e749 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -44,7 +44,7 @@ struct vhost_worker {
 	/* Used to serialize device wide flushing with worker swapping. */
 	struct mutex		mutex;
 	struct llist_head	work_list;
-	u64			kcov_handle;
+	struct kcov_common_handle_id kcov_handle;
 	u32			id;
 	int			attachment_cnt;
 	bool			killed;
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 0143358874b0..cdb72b3859d8 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -43,11 +43,11 @@ do {						\
 /* See Documentation/dev-tools/kcov.rst for usage details. */
 void kcov_remote_start(u64 handle);
 void kcov_remote_stop(void);
-u64 kcov_common_handle(void);
+struct kcov_common_handle_id kcov_common_handle(void);
 
-static inline void kcov_remote_start_common(u64 id)
+static inline void kcov_remote_start_common(struct kcov_common_handle_id id)
 {
-	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id));
+	kcov_remote_start(kcov_remote_handle(KCOV_SUBSYSTEM_COMMON, id.val));
 }
 
 static inline void kcov_remote_start_usb(u64 id)
@@ -99,11 +99,11 @@ static inline void kcov_prepare_switch(struct task_struct *t) {}
 static inline void kcov_finish_switch(struct task_struct *t) {}
 static inline void kcov_remote_start(u64 handle) {}
 static inline void kcov_remote_stop(void) {}
-static inline u64 kcov_common_handle(void)
+static inline struct kcov_common_handle_id kcov_common_handle(void)
 {
-	return 0;
+	return (struct kcov_common_handle_id){};
 }
-static inline void kcov_remote_start_common(u64 id) {}
+static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
 static inline void kcov_remote_start_usb_softirq(u64 id) {}
 static inline void kcov_remote_stop_softirq(void) {}
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..a3fe418f7ced 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1082,9 +1082,7 @@ struct sk_buff {
 	__u16			network_header;
 	__u16			mac_header;
 
-#ifdef CONFIG_KCOV
-	u64			kcov_handle;
-#endif
+	struct kcov_common_handle_id kcov_handle;
 
 	); /* end headers group */
 
@@ -5437,20 +5435,14 @@ static inline void skb_reset_csum_not_inet(struct sk_buff *skb)
 }
 
 static inline void skb_set_kcov_handle(struct sk_buff *skb,
-				       const u64 kcov_handle)
+				       struct kcov_common_handle_id kcov_handle)
 {
-#ifdef CONFIG_KCOV
 	skb->kcov_handle = kcov_handle;
-#endif
 }
 
-static inline u64 skb_get_kcov_handle(struct sk_buff *skb)
+static inline struct kcov_common_handle_id skb_get_kcov_handle(struct sk_buff *skb)
 {
-#ifdef CONFIG_KCOV
 	return skb->kcov_handle;
-#else
-	return 0;
-#endif
 }
 
 static inline void skb_mark_for_recycle(struct sk_buff *skb)
diff --git a/include/linux/types.h b/include/linux/types.h
index 608050dbca6a..93166b0b0617 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -224,6 +224,12 @@ struct ustat {
 	char			f_fpack[6];
 };
 
+struct kcov_common_handle_id {
+#ifdef CONFIG_KCOV
+	u64 val;
+#endif
+};
+
 /**
  * struct callback_head - callback structure for use with RCU and task_work
  * @next: next update requests in a list
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 0b369e88c7c9..a43e33a28adb 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -1083,11 +1083,11 @@ void kcov_remote_stop(void)
 EXPORT_SYMBOL(kcov_remote_stop);
 
 /* See the comment before kcov_remote_start() for usage details. */
-u64 kcov_common_handle(void)
+struct kcov_common_handle_id kcov_common_handle(void)
 {
 	if (!in_task())
-		return 0;
-	return current->kcov_handle;
+		return (struct kcov_common_handle_id){ .val = 0 };
+	return (struct kcov_common_handle_id){ .val = current->kcov_handle };
 }
 EXPORT_SYMBOL(kcov_common_handle);
 

---
base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
change-id: 20260430-kcov-refactor-common-handle-25178495b2eb

--  
Jann Horn <jannh@google.com>


