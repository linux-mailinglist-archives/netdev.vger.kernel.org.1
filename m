Return-Path: <netdev+bounces-281682-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMCLFHRj8GkRSwEAu9opvQ
	(envelope-from <netdev+bounces-281682-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:36:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9823347EFAD
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 09:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E089030AB44F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 07:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900123DA5C3;
	Tue, 28 Apr 2026 07:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OB4sr+/V"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA33D75A0;
	Tue, 28 Apr 2026 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360936; cv=none; b=s+l907JrHcAuRPpWA8+BDMwTi/QwD6sUJD47rIBWzp6+IPnV7eAJCoUoYh7X7Jqce09Hk1zmyNoPau6H32YP2EgXcxpOAxAtenFDtK5X+DIKQGpkVOWHR5MtIsF6Akie2LtAmETf78Nn/8I1yixp6eWjPz8jwY1UrsNy9UafbDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360936; c=relaxed/simple;
	bh=gKY+m2RtVcXm2VZoNIYMq/+KxJ4h9LPXmk9s/YJksto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFeYIYcteGXW2bt3apvPNBOtzSE8ZDNAc0wDvpUkysPWlTnq5kxyFcLWmFVfkykuJRuagb9/GpA/w/9UEMfD0Clk5s50UZXEGYMWeX+1nsMtviKzOd1wqzzsQfvI1XQp9B3UBMVdGzSFSCG/Tcq6MAyw30YIcQm2ld86Pcm9i7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OB4sr+/V; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777360935; x=1808896935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gKY+m2RtVcXm2VZoNIYMq/+KxJ4h9LPXmk9s/YJksto=;
  b=OB4sr+/VUoSw1evdNI3cuzZBD8g0zONZE3l6eT7Xl4EO8eTTtCrLkP/T
   3CzeQduK0toYPY32wAn1JuQymx4As+zoPjM96mnnWp4Gd9g1M6Xb00Nzl
   hJV5p3nU2AByLSGDExsTLX8qsAyDaoBqHMpkcJsLfRUadaRO0AFMzhcC8
   xIfK692m/s/dBdDpkz0yrJ8VKxxYq3aPipmwZ/Qq17LWDEHj9LrPIvzbe
   7ceZkDBI4RR41PlAcp8cDEvwMHqf8iZRK73ywHoWPFDGTP1unM7p13Q7K
   YSV26lEN1kd2LzKnmrC9Q6ZCCxt0y3GC1oNnyZy5yBjZLWYHZXVlXN3Xy
   w==;
X-CSE-ConnectionGUID: WAoq8xvJTm6DCtu64I03Kw==
X-CSE-MsgGUID: C5GQ+9CRSmO10EW3XneP3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89720822"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89720822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:22:14 -0700
X-CSE-ConnectionGUID: 9IQem98NRXW+GtkVuji8mA==
X-CSE-MsgGUID: axNM1riOQeq/XyYYzokHhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="238206403"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 28 Apr 2026 00:22:11 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id F248660; Tue, 28 Apr 2026 09:22:09 +0200 (CEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-usb@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/9] thunderbolt: Add tb_property_merge_dir()
Date: Tue, 28 Apr 2026 09:22:01 +0200
Message-ID: <20260428072209.3084930-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9823347EFAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,wunner.de,linux.intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281682-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mika.westerberg@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]

This allows merging one XDomain property directory into another. We are
going to use this in the subsequent patch.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/property.c | 154 ++++++++++++++++++++++++---------
 include/linux/thunderbolt.h    |   3 +
 2 files changed, 114 insertions(+), 43 deletions(-)

diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..6b9666b61181 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -38,6 +38,7 @@ struct tb_property_dir_entry {
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
 	bool is_root);
+static struct tb_property *tb_property_copy(const struct tb_property *property);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -507,17 +508,9 @@ ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
 	return ret < 0 ? ret : 0;
 }
 
-/**
- * tb_property_copy_dir() - Take a deep copy of directory
- * @dir: Directory to copy
- *
- * The resulting directory needs to be released by calling tb_property_free_dir().
- *
- * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
- */
-struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
+static struct tb_property_dir *copy_dir(const struct tb_property_dir *dir)
 {
-	struct tb_property *property, *p = NULL;
+	struct tb_property *property, *p;
 	struct tb_property_dir *d;
 
 	if (!dir)
@@ -528,56 +521,131 @@ struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
 		return NULL;
 
 	list_for_each_entry(property, &dir->properties, list) {
-		struct tb_property *p;
-
-		p = tb_property_alloc(property->key, property->type);
+		p = tb_property_copy(property);
 		if (!p)
 			goto err_free;
+		list_add_tail(&p->list, &d->properties);
+	}
 
-		p->length = property->length;
+	return d;
 
-		switch (property->type) {
-		case TB_PROPERTY_TYPE_DIRECTORY:
-			p->value.dir = tb_property_copy_dir(property->value.dir);
-			if (!p->value.dir)
-				goto err_free;
-			break;
+err_free:
+	tb_property_free_dir(d);
+	return NULL;
+}
 
-		case TB_PROPERTY_TYPE_DATA:
-			p->value.data = kmemdup(property->value.data,
-						property->length * 4,
-						GFP_KERNEL);
-			if (!p->value.data)
-				goto err_free;
-			break;
+static struct tb_property *tb_property_copy(const struct tb_property *property)
+{
+	struct tb_property *p;
 
-		case TB_PROPERTY_TYPE_TEXT:
-			p->value.text = kzalloc(p->length * 4, GFP_KERNEL);
-			if (!p->value.text)
-				goto err_free;
-			strcpy(p->value.text, property->value.text);
-			break;
+	p = tb_property_alloc(property->key, property->type);
+	if (!p)
+		return NULL;
 
-		case TB_PROPERTY_TYPE_VALUE:
-			p->value.immediate = property->value.immediate;
-			break;
+	p->length = property->length;
+	switch (property->type) {
+	case TB_PROPERTY_TYPE_DIRECTORY:
+		p->value.dir = copy_dir(property->value.dir);
+		if (!p->value.dir)
+			goto err_free;
+		break;
 
-		default:
-			break;
-		}
+	case TB_PROPERTY_TYPE_DATA:
+		p->value.data = kmemdup(property->value.data,
+					property->length * 4,
+					GFP_KERNEL);
+		if (!p->value.data)
+			goto err_free;
+		break;
 
-		list_add_tail(&p->list, &d->properties);
+	case TB_PROPERTY_TYPE_TEXT:
+		p->value.text = kzalloc(p->length * 4, GFP_KERNEL);
+		if (!p->value.text)
+			goto err_free;
+		strcpy(p->value.text, property->value.text);
+		break;
+
+	case TB_PROPERTY_TYPE_VALUE:
+		p->value.immediate = property->value.immediate;
+		break;
+
+	default:
+		break;
 	}
 
-	return d;
+	return p;
 
 err_free:
 	kfree(p);
-	tb_property_free_dir(d);
-
 	return NULL;
 }
 
+/**
+ * tb_property_copy_dir() - Take a deep copy of directory
+ * @dir: Directory to copy
+ *
+ * The resulting directory needs to be released by calling tb_property_free_dir().
+ *
+ * Return: Pointer to &struct tb_property_dir, %NULL in case of failure.
+ */
+struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir)
+{
+	return copy_dir(dir);
+}
+EXPORT_SYMBOL_GPL(tb_property_copy_dir);
+
+/**
+ * tb_property_merge_dir() - Merges directory into parent
+ * @parent: Directory to merge @dir
+ * @dir: Directory that is merged
+ * @replace: Replace existing entries
+ *
+ * This will merge @dir into @parent. Both must have same UUID. The
+ * properties in @dir will overwrite overlapping properties in @parent
+ * if @replace is %true. Contents of @dir is copied (so if it is not
+ * needed afterwards it needs to relesed by calling tb_property_free_dir()).
+ */
+int tb_property_merge_dir(struct tb_property_dir *parent,
+			  const struct tb_property_dir *dir,
+			  bool replace)
+{
+	const struct tb_property *property;
+
+	if (WARN_ON(parent == dir))
+		return -EINVAL;
+
+	if (!uuid_equal(parent->uuid, dir->uuid))
+		return -EINVAL;
+
+	list_for_each_entry(property, &dir->properties, list) {
+		struct tb_property *p, *tmp;
+
+		tmp = tb_property_copy(property);
+		if (!tmp)
+			return -ENOMEM;
+
+		p = tb_property_find(parent, property->key, property->type);
+		if (p) {
+			if (replace) {
+				/*
+				 * Found existing property in parent so
+				 * replace with the new one.
+				 */
+				list_replace(&p->list, &tmp->list);
+				tb_property_free(p);
+			} else {
+				tb_property_free(tmp);
+				continue;
+			}
+		} else {
+			list_add_tail(&tmp->list, &parent->properties);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tb_property_merge_dir);
+
 /**
  * tb_property_add_immediate() - Add immediate property to directory
  * @parent: Directory to add the property
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index bbdbbc84c999..e98d569779f9 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -153,6 +153,9 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 ssize_t tb_property_format_dir(const struct tb_property_dir *dir, u32 *block,
 			       size_t block_len);
 struct tb_property_dir *tb_property_copy_dir(const struct tb_property_dir *dir);
+int tb_property_merge_dir(struct tb_property_dir *parent,
+			  const struct tb_property_dir *dir,
+			  bool replace);
 struct tb_property_dir *tb_property_create_dir(const uuid_t *uuid);
 void tb_property_free_dir(struct tb_property_dir *dir);
 int tb_property_add_immediate(struct tb_property_dir *parent, const char *key,
-- 
2.50.1


