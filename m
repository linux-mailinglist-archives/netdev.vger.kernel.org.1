Return-Path: <netdev+bounces-96013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C08C3FCD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F2A1C22B0D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA5014C5A0;
	Mon, 13 May 2024 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/2OZPed"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0514C595
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715599629; cv=none; b=a0rH/P/TtbFmBBG3dmeRqD4QHljqx+zEaGtOgLuljYVaQXnJo7YlYShx8OWZ5WpfEZoAxHAClaBN2qJD28ppNNiS/tr4iOBYjghisPm9iVirxtHF748Wwvg58rwnAl5VEUQVIDo60TJkxCs75/gyNonhOY/vyuyLQ9Fnn6zK7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715599629; c=relaxed/simple;
	bh=0k5DBiev6Hez4iRlP0Z+hV0EZ/1rw9D59hE5bmw14XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NldrjMyk2F52SmHQoYs8dutAnTcXUm2DU+lrVDh5C6zpaq2TlKl5Rt4y8mU5jryYIpXJBhMiKZYRyoDbTaxK9GK2gmw/LmN09sAN/+2iqwZ0PVnEivt1kjqTjLgVo4Qoc+k106GpA+nqINj+EfbQBLvGgdxq5NlLcW9R68wLhGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a/2OZPed; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715599627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=54evBAuhpnIbgDCbHAgBJwdKwEdND6gn70BNk2pLCuo=;
	b=a/2OZPedn/UJH2dJnDCOXjJvbn8+Ig1S06MlpCkgHePcDHoZbioHdcgwFIgHtqDgdHpqis
	L6cNxq8m5ljDGb9dh00hZvkAg9n87ciostMYN4AqfOmdViIKYpaARqDwELL5hUZSoO3Pi+
	jpZOB3sDjF11mHPeOsFAqKpjlEotN4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-b22GMANPMli0g95TKxwUrg-1; Mon, 13 May 2024 07:27:02 -0400
X-MC-Unique: b22GMANPMli0g95TKxwUrg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A3D328025F9;
	Mon, 13 May 2024 11:27:01 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6AC691C00A90;
	Mon, 13 May 2024 11:27:00 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>,
	Jan Stancek <jstancek@redhat.com>
Subject: [PATCH bpf-next] bpftool: fix make dependencies for vmlinux.h
Date: Mon, 13 May 2024 13:26:58 +0200
Message-ID: <20240513112658.43691-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

With pre-generated vmlinux.h there is no dependency on neither vmlinux
nor bootstrap bpftool. Define dependencies separately for both modes.
This avoids needless rebuilds in some corner cases.

Suggested-by: Jan Stancek <jstancek@redhat.com>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/bpf/bpftool/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index dfa4f1bebbb31..ba927379eb201 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -204,10 +204,11 @@ ifeq ($(feature-clang-bpf-co-re),1)
 
 BUILD_BPF_SKELS := 1
 
-$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 ifeq ($(VMLINUX_H),)
+$(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
 	$(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
 else
+$(OUTPUT)vmlinux.h: $(VMLINUX_H)
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
-- 
2.44.0


