Return-Path: <netdev+bounces-96889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C458C81D9
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885C81F21738
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6AA17C8D;
	Fri, 17 May 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8Lp0Slx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCE717BCA
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932624; cv=none; b=VnA51sycxNl3TapT8ihkY5A8xtNmkFXi0Q0ovKOj1JiOF3Tx7/UB5BGCoV1uzT24zf3lmE6OzXWFr3xdoVXdVqVtYwXuHdT5fkeErvtrvNZc3XZH4NoQjYEI2+JLF8/QbY45FDoVyDv7b1PXqm+27GTpfooZZj125DzIsqtggB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932624; c=relaxed/simple;
	bh=9avGdIlGtkZAGVzBwd2BMqnvGgEnWpUrqWA8fO7+YJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NaDPWEMHeDx894FlEG37BvgCcmaE0kiq6coejksLPwg2wWyrryQdbRAS2Km9B0xmBbjTkl0NRIP0oH/zTo/jd2Ejwbh0/7nWoxLEzA81RzxbquPpTUV3nQklvyBnmXkEBoDTFb02Oh+Gziy4fKR/setah2ImiZCdKcYsIKLIFmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8Lp0Slx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z28RdGIa/jW2W1Epz9g0bmIp4vT2NvFeG3FHmL5nW28=;
	b=M8Lp0Slxr+ZtcbtGWnRAa7igdhqp0WNlOmGziHZA09DRlyhmJX3xaaCsVMa9AhFEfNYUr3
	f/CMIeDeBZEQuoWC4MCHTm52DXFvHIugdJpm9DviQfRir8iymhuKCPY+3PWYXKE3N5j4uO
	aYRWJR26cMDCYN+LPDS2n++7q6HE78c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-QBvbkxxENZiprvS6x8DnGQ-1; Fri, 17 May 2024 03:56:57 -0400
X-MC-Unique: QBvbkxxENZiprvS6x8DnGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D06F101A525;
	Fri, 17 May 2024 07:56:57 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52D6F51BF;
	Fri, 17 May 2024 07:56:55 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH 0/5] powerpc64/bpf: jit support for cpuv4 instructions
Date: Fri, 17 May 2024 09:56:45 +0200
Message-ID: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add support for recently added cpuv4 instructions fixing test_bpf module
failures. This is mostly based on 8ecf3c1dab1c6 (powerpc/bpf/32: Fix
failing test_bpf tests, 2024-03-05)

Artem Savkov (5):
  powerpc64/bpf: jit support for 32bit offset jmp instruction
  powerpc64/bpf: jit support for unconditional byte swap
  powerpc64/bpf: jit support for sign extended load
  powerpc64/bpf: jit support for sign extended mov
  powerpc64/bpf: jit support for signed division and modulo

 arch/powerpc/include/asm/ppc-opcode.h |   2 +
 arch/powerpc/net/bpf_jit_comp64.c     | 118 +++++++++++++++++++-------
 2 files changed, 90 insertions(+), 30 deletions(-)

--
2.45.0


