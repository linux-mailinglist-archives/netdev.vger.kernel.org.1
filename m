Return-Path: <netdev+bounces-96892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2BC8C81E1
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6571C2096D
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 07:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864762BCE8;
	Fri, 17 May 2024 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6An5BeS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CF02260A
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932628; cv=none; b=RBtXmNkbRVLF5eLSLMzVoKHdMMpQyNHwpY243hSxj8A0mmZPMhkCqUSIdEbUgeh/0F7If4rRqdXci/f99YEBhTCN6dQPU7T75wShnnSM2wW3zMPjr/z6SCYx0DOWmpKWYFET8VTLx/F4DncMRzW9LmIixVRItblWd+ut0Y1A+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932628; c=relaxed/simple;
	bh=0Zhpfwr2bblfm7k3g5cvVUI3dQpNdm2TqtvTSVzfgYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vxt+SSNXPy+rRU99gbLrxj39F/4OEqdNQbDAX1F5i4dVT4u+41g1doSV6G+MviOyaBsDxKWEe3nZugBmH+O6zHbCvzyETAu0OQNRG7Q7glRUEBynIZS4E1rkuqorffu11dTna5NZr/usrB6dRcUC6XyPwfrtQSLqK52eCfVWI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B6An5BeS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715932625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CsmDbbLDOx1vnhJg69VuCy0uaob3Dg5hNF61pmV/Vg=;
	b=B6An5BeSavxRjIBc/p/AvsGtjkUW1p5uvPO33ROCQrJfIpWLY6ia57aH7Ts40bVQZKne5X
	MXNO0kzhxrIpRtfkx5HXpcBcREkFcuIeD9AAUAR/vYqutIiybaECpP0xV3OygYDW65Gj2S
	TAnq/Mv9IyTeOydkOpvvRaw8IWK1t6g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-HFKoaS62NtCAXc51ApmXvA-1; Fri, 17 May 2024 03:57:01 -0400
X-MC-Unique: HFKoaS62NtCAXc51ApmXvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAEC5802079;
	Fri, 17 May 2024 07:57:00 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.36])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4E28F740F;
	Fri, 17 May 2024 07:56:59 +0000 (UTC)
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
Subject: [PATCH 2/5] powerpc64/bpf: jit support for unconditional byte swap
Date: Fri, 17 May 2024 09:56:47 +0200
Message-ID: <20240517075650.248801-3-asavkov@redhat.com>
In-Reply-To: <20240517075650.248801-1-asavkov@redhat.com>
References: <20240517075650.248801-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add jit support for unconditional byte swap. Tested using BSWAP tests
from test_bpf module.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 3071205782b15..97191cf091bbf 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -699,11 +699,12 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 */
 		case BPF_ALU | BPF_END | BPF_FROM_LE:
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 #ifdef __BIG_ENDIAN__
 			if (BPF_SRC(code) == BPF_FROM_BE)
 				goto emit_clear;
 #else /* !__BIG_ENDIAN__ */
-			if (BPF_SRC(code) == BPF_FROM_LE)
+			if (BPF_CLASS(code) == BPF_ALU && BPF_SRC(code) == BPF_FROM_LE)
 				goto emit_clear;
 #endif
 			switch (imm) {
-- 
2.45.0


