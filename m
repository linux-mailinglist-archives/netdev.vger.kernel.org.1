Return-Path: <netdev+bounces-111707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A31F932251
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 10:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995AA1C20FE3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402919538D;
	Tue, 16 Jul 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6FvAl93"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9017B419
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120277; cv=none; b=CI5EjgUNjQq/bEvPfBt5p1GT+ZLVADKIoRh9VFxl4ay2UxgSoNLP7rylfn4OtFdvIj0+QfsD+H5WcqqtyifCN4jHWPP7wz/YzIy65WgmlhnVJZ6Ne9IhNXRFhv+vPCFhWTsE2HbCaeILFomFQ6mmxE8O7IAAbG8LGrICZEH2Hh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120277; c=relaxed/simple;
	bh=444k9hPSF3E/PZXH96H6dIB4wwHCAtgQq+tuCvRiuos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMsGulJHgIlQvCFNK7LiPN2GQqRVj/z76lZNTbafKvLA6xRIG9B1MdDZikD+qVgJa07y392VLTBG6z0t7ipzWA6891sNSLVNgVqRUZBRfsvSGaM6w2wX5qa3AgUiXuK2SeYr0R0AmXCwrhUfT7nc0z7/ggcuTMYWq8ZXMMPcRZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6FvAl93; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721120274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N25BXcznMb0EShnG7fU1a/5xcMTDDanVAYNV9H7ONVc=;
	b=W6FvAl93RIQUCR999RQ1O4T0DBhwWiGYFeZ8Kilu75EcKj/7eu6JDjSfBgY9Dbk20o6NRU
	eHKv9x6RHxhD7KCAsGOz+bzgg9aXsjaXS3rIHje9OOKmbnpuwjknVNCwKVROEFC+NYp5kz
	gXYJyuLTZZabCKGKMYxGnoN6PX8pBt8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-ueNuGEYVNcOYCm29jWdjog-1; Tue,
 16 Jul 2024 04:57:50 -0400
X-MC-Unique: ueNuGEYVNcOYCm29jWdjog-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0312C1955D53;
	Tue, 16 Jul 2024 08:57:49 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.170])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D81461955D42;
	Tue, 16 Jul 2024 08:57:45 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
Cc: David Ahern <dsahern@kernel.org>,
	aclaudi@redhat.com,
	Ilya Maximets <i.maximets@ovn.org>,
	echaudro@redhat.com,
	netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	stephen@networkplumber.org
Subject: [PATCH iproute2-next v3 1/2] uapi: add support for dissecting tunnel metadata with TC flower
Date: Tue, 16 Jul 2024 10:57:19 +0200
Message-ID: <e3927dcdaca1e9d23abd7dd2bf35e57df4e8ddb3.1721119088.git.dcaratti@redhat.com>
In-Reply-To: <cover.1721119088.git.dcaratti@redhat.com>
References: <cover.1721119088.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Update uAPI headers to allow dissecting tunnel metadata with TC flower.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/uapi/linux/pkt_cls.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 229fc925ec3a..30767cc99896 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -554,6 +554,9 @@ enum {
 	TCA_FLOWER_KEY_SPI,		/* be32 */
 	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
 
+	TCA_FLOWER_KEY_ENC_FLAGS,       /* be32 */
+	TCA_FLOWER_KEY_ENC_FLAGS_MASK,  /* be32 */
+
 	__TCA_FLOWER_MAX,
 };
 
@@ -674,6 +677,10 @@ enum {
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CSUM = (1 << 2),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_DONT_FRAGMENT = (1 << 3),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_OAM = (1 << 4),
+	TCA_FLOWER_KEY_FLAGS_TUNNEL_CRIT_OPT = (1 << 5),
 };
 
 enum {
-- 
2.45.2


