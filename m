Return-Path: <netdev+bounces-144365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA24E9C6D43
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D43B25CB2
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 10:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8201FF023;
	Wed, 13 Nov 2024 10:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from localhost.localdomain (unknown [83.217.201.225])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4AF16DEB4
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.217.201.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495568; cv=none; b=WGjfrW9C63PAxuf6Lyp3xcPSfaApgTQ9Z7PkCsES0GcUFhzN3ZAZRBwjLDvsfVhJ+yRDxj4NDN6m51hz518PMxLWrfc188fc6PnCsXZPIUpboxsb6Yu/lIdZx5S9PhslfP/cYnTkukTf2GpF2536RIhmhh4U+q3MVtBuvogV06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495568; c=relaxed/simple;
	bh=CdQ/0MODWdYUSHKXtV+Lt6i2lCsadJ9tnEqCFBcDAUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=on6zn9OPsHBFyFPKCpoSBpcKz3jAPwZkbV1+x07jXJX7jOaMo0wyHo+2YZKKkMKsYBXupy72YzQfKyuK3NynKmmS4ZjndfBroVIYuFv0J9FzwDGWpcUMXqmBVXG82/SIzWQ6x3i7r1LnVQaNFbYNtRFLiDtkekGpKLqfXT9kpf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=83.217.201.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1000)
	id C562134061E; Wed, 13 Nov 2024 13:52:31 +0300 (MSK)
From: Denis Kirjanov <kirjanov@gmail.com>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <kirjanov@gmail.com>
Subject: [iproute] lib: names: check calloc return value in db_names_alloc
Date: Wed, 13 Nov 2024 13:52:19 +0300
Message-ID: <20241113105219.29134-1-kirjanov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

db_names_load() may crash since it touches the
hash member. Fix it by checking the return value

Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
---
 lib/names.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/names.c b/lib/names.c
index cbfa971f..4ecae92b 100644
--- a/lib/names.c
+++ b/lib/names.c
@@ -55,6 +55,10 @@ struct db_names *db_names_alloc(void)
 
 	db->size = MAX_ENTRIES;
 	db->hash = calloc(db->size, sizeof(struct db_entry *));
+	if (!db->hash) {
+		free(db);
+		return NULL;
+	}
 
 	return db;
 }
-- 
2.43.0


