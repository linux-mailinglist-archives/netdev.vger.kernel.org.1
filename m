Return-Path: <netdev+bounces-70557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AF584F870
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB0B1F222D7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1D71B59;
	Fri,  9 Feb 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlZQ+CQq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19F6D1D2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492372; cv=none; b=SRZJYOKwPRJVfdCa8Je6uXPbIlhMiKeGXqzoMjl0HTplHXYYwLf8g5A+1+frgzl58/2WCT1VeWIDeREJas9u60YtClUqnIirR9Sr2ZtTNsC5/cy62Ghe1sM5LcAgm3xR+f3xgp/a5KAAQ91tG3KwJyt1HTFjHwejxMkkXdPP0G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492372; c=relaxed/simple;
	bh=pj5yG7U6fJdKpznXldv1xfwXL8Ug2kizB82Ncb2v2/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPI6wxbFS/TKw49u1OkQtob4G38kdrs/7F+6lfJN+w6ayFAgM+E5+DP8+jXTvwJV5fOkWzYe/VwMiqYaKP5Lvp/kc9Q3MGuFLg3LICpiacQj8YMq7HS+Eo76c9aU/NHENVzOP/qgx/vNl6SQvBINIwtDrhCPNxCNFWhDb38Odws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NlZQ+CQq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707492369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IetrbwtKaetIryPmFhN4giYVqj4lsCdy/659FsRxl7U=;
	b=NlZQ+CQqxSuXCJtbyH1SW2sSkCSze4OVE2vrNDYO0BD3GTY/BA/Ued2uyVGdOZ3Q0xaeJ8
	mAvP/D+RvZjiDi+qdc/+4Hz4zzXot7cP+F3x5riijbBujoePAGD/zARkjaM8OiPYtk8QOM
	OU/6jY0FT3Kh/2rd5fdyyxHwVrDO0ns=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-297-ED_Rxl5bMuWrE8WO-yyhsQ-1; Fri,
 09 Feb 2024 10:26:05 -0500
X-MC-Unique: ED_Rxl5bMuWrE8WO-yyhsQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CF213C025BF;
	Fri,  9 Feb 2024 15:26:05 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DBDF1103A;
	Fri,  9 Feb 2024 15:26:03 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 v2 2/2] docs, man: fix some typos
Date: Fri,  9 Feb 2024 16:25:46 +0100
Message-ID: <4db8d8fab31629d7a997e851ef8f1b71fb5b9413.1707492043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1707492043.git.aclaudi@redhat.com>
References: <cover.1707492043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Fix some typos and spelling errors in iproute2 documentation.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 man/man8/devlink-rate.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/devlink-rate.8 b/man/man8/devlink-rate.8
index bcec3c31..f09ac4ac 100644
--- a/man/man8/devlink-rate.8
+++ b/man/man8/devlink-rate.8
@@ -149,7 +149,7 @@ These parameter accept integer meaning weight or priority of a node.
 - set rate object parent to existing node with name \fINODE_NAME\fR or unset
 parent. Rate limits of the parent node applied to all it's children. Actual
 behaviour is details of driver's implementation. Setting parent to empty ("")
-name due to the kernel logic threated as parent unset.
+name due to the kernel logic treated as parent unset.
 
 .SS devlink port function rate add - create node rate object with specified parameters.
 Creates rate object of type node and sets parameters. Parameters same as for the
-- 
2.43.0


