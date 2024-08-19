Return-Path: <netdev+bounces-119848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802A95739B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B94D1C23092
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBE518C939;
	Mon, 19 Aug 2024 18:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyGTxz7X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790C18C927
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 18:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092711; cv=none; b=GUaWIvT7JKk+/DlFwGZw46xnsUc83Orpd56yAG3hC6WnQpaDFWbCIZrECCHwzK4+HInH07pTZxROBvi8yrjT8KchCMQ8M/X2kBwn6kwH7JZXpIYEHNBJj8dXUtCNRKKZyzKoTsEDyqq37TFbDwb0AMSdAKNzSuqlHS8ab+rKXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092711; c=relaxed/simple;
	bh=/HOjq9X9X2KQMEsqDRneNuPn5l3Rhurp22TwSf3G5Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neylwqAVLGAXXoIpDjvBkA8c4+NTnS0vYW5F6GU7XLQRiJoKDShBcD+p1ygEhcMHyGucI/Q0LC4J6+KUu+PKQP4yAtc0VbnycfrE+0LgyCRFhnQ9tWsfwxcX5UdyhIdcfesWAhVNtFe8M+jftEnLrR2naMDzAJIdpfpRfGG3Nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyGTxz7X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724092708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhdi0ZWmWYR0MqvX3gdvffJxUEfr+B4dJmnDyHHBiGU=;
	b=CyGTxz7XTOoNT3eqG5YlQv61rBcGB2vRnfUOAvka7I8RVwsxpVBIDiQUTZHlech1WW5gC0
	zoHYPPxXOZe8PYbhxRW0EaaBeELjO/qfC5FWwS3JQMhXPGDoQk85LNWXGr14TboCEHctOP
	3xasNuABCJhGVODg/HDiX8DH52h6trk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-o46fiyuiOPObVzgT80IB9g-1; Mon,
 19 Aug 2024 14:38:27 -0400
X-MC-Unique: o46fiyuiOPObVzgT80IB9g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D86441955F6A;
	Mon, 19 Aug 2024 18:38:24 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 595DA19560A3;
	Mon, 19 Aug 2024 18:38:22 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	song@kernel.org,
	yukuai3@huawei.com,
	agruenba@redhat.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	netdev@vger.kernel.org,
	vvidic@valentin-vidic.from.hr,
	heming.zhao@suse.com,
	lucien.xin@gmail.com,
	aahringo@redhat.com
Subject: [PATCH dlm/next 09/12] kobject: export generic helper ops
Date: Mon, 19 Aug 2024 14:37:39 -0400
Message-ID: <20240819183742.2263895-10-aahringo@redhat.com>
In-Reply-To: <20240819183742.2263895-1-aahringo@redhat.com>
References: <20240819183742.2263895-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch exports generic helpers like kset_release() and
kset_get_ownership() so users can use them in their own struct kobj_type
implementation instead of implementing their own functions that do the
same.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 include/linux/kobject.h | 2 ++
 lib/kobject.c           | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 7504b7547ed2..5fbc358e2be6 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -181,6 +181,8 @@ kset_type_create_and_add(const char *name, const struct kset_uevent_ops *u,
 struct kset * __must_check
 kset_create_and_add(const char *name, const struct kset_uevent_ops *u,
 		    struct kobject *parent_kobj);
+void kset_release(struct kobject *kobj);
+void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid);
 
 static inline struct kset *to_kset(struct kobject *kobj)
 {
diff --git a/lib/kobject.c b/lib/kobject.c
index 09dd3d4c7f56..ccd2f6282c81 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -920,19 +920,21 @@ struct kobject *kset_find_obj(struct kset *kset, const char *name)
 }
 EXPORT_SYMBOL_GPL(kset_find_obj);
 
-static void kset_release(struct kobject *kobj)
+void kset_release(struct kobject *kobj)
 {
 	struct kset *kset = container_of(kobj, struct kset, kobj);
 	pr_debug("'%s' (%p): %s\n",
 		 kobject_name(kobj), kobj, __func__);
 	kfree(kset);
 }
+EXPORT_SYMBOL_GPL(kset_release);
 
-static void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
+void kset_get_ownership(const struct kobject *kobj, kuid_t *uid, kgid_t *gid)
 {
 	if (kobj->parent)
 		kobject_get_ownership(kobj->parent, uid, gid);
 }
+EXPORT_SYMBOL_GPL(kset_get_ownership);
 
 static const struct kobj_type kset_ktype = {
 	.sysfs_ops	= &kobj_sysfs_ops,
-- 
2.43.0


