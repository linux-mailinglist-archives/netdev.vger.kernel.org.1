Return-Path: <netdev+bounces-179792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D198A7E866
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CE33BB293
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA12192E5;
	Mon,  7 Apr 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWpXzhSA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED217739
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047125; cv=none; b=iUws8hl6lhWlFt5/cXahcd2XCywnwcLB0cFtKQyb46AmqWipsGpmuLtYd2Wjx0p4fhfda4AESZAY5+sZjfJ1QxTvQ3K+uj9FwuLFlWsp49xgKncmVlNplU+tjvTH3Cb55klbHrTXeEZZc0i1N+Y+PRydCV39B8/BxqFHkHpbTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047125; c=relaxed/simple;
	bh=WEcD/AXqDi/lML5ocoRfoM1M6Q3z5GDI2jHwFmoZKWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co09XXvI3lmdnb2m3CZf1XMHpuZNw9uzo1FHgUCXJHq/8ealOUcRQC0sVFHIwPftCXqI8BEgEoYjzUU8Crrewk1IvyX9dOdrYGSRiCBcfY8MJdyt/PrCkNhmgQYQdnuGjqmvu6kb9xpLVLPLsf3/TjVEcZZN0F+pEWmtBaGIA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWpXzhSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6e5YEd4i8Igzt8FZC6HGuBFALFj9tH6sGb59/Wh5h4=;
	b=JWpXzhSAAOEsd83evUkk5J50+8ORXmr/rrw8jIFQKtD2y6Fjq0mUmjG+4Nszk7/zHgslqb
	D2mfCKOEkjy2nugehLytR3cfjADVGpvZ/RbYXrAukjLl6/73euluOFPpIa6epX8vw6Vc3M
	eOBeOCWPfdGihyVQ+ehyL6oAD2i+fuA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-cNQUs-B1PqudVnQAh9X6bA-1; Mon,
 07 Apr 2025 13:31:58 -0400
X-MC-Unique: cNQUs-B1PqudVnQAh9X6bA-1
X-Mimecast-MFC-AGG-ID: cNQUs-B1PqudVnQAh9X6bA_1744047116
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E2419560BE;
	Mon,  7 Apr 2025 17:31:56 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D877F1956094;
	Mon,  7 Apr 2025 17:31:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 10/28] lib: Allow modules to use strnchrnul
Date: Mon,  7 Apr 2025 19:31:40 +0200
Message-ID: <20250407173149.1010216-1-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit 0bee0cece2a6a ("lib/string: add strnchrnul()") added the
mentioned function but did not export it so it cannot be used by
modules.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 lib/string.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/string.c b/lib/string.c
index eb4486ed40d25..824b3aac86de0 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -363,6 +363,7 @@ char *strnchrnul(const char *s, size_t count, int c)
 		s++;
 	return (char *)s;
 }
+EXPORT_SYMBOL(strnchrnul);
 
 #ifndef __HAVE_ARCH_STRRCHR
 /**
-- 
2.48.1


