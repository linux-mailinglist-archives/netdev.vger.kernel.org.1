Return-Path: <netdev+bounces-195609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236CAD16AC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D63B188ABAD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D819D8BE;
	Mon,  9 Jun 2025 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wQF2FcFk"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8217A306
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 02:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749434999; cv=none; b=s24ln/FQtHsVCTGNBMqY5j7rI+u8hGuBW8XtEhiC57prvFzidnZtZEKVr9p4+I5S8ur2ng/MdVi88rFCIlgG/4cVPzLsDaufKdsHVO5dENAtnLouvFpzOZ4bTQXjNsdJye/z1YXL4n6QqxfIOSJxx7yCYEone5N/bbOl4gNZGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749434999; c=relaxed/simple;
	bh=nRsCnCRLiwqLjDwWyrro57XGoUWgUmDNq1dKoWvg30w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dihhPNfolHkFEdMm8eE/nFXcIxKGshBmbq+14fdfNlwe+XUkNgghfCu8nLSdMLudP43Jbu+tDNCf1ocNdYFJFLexcH0ouZkK/elsWE7Zd+Yi/xRs1qBR9+oUbhydlw27quemF7GXB7PK1dGH0P5YdWP0bJ8Oxi67VGCQQUOTF2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wQF2FcFk; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749434993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eH5xtoEPtJbeyPY7kvr8xlbx6AhkEMjg/GVm+YZpk8=;
	b=wQF2FcFkGMrA4GW+UQftcdm21aZLjRqAgQO0p58y9DiHKgPaHNgjuheDejzbzTKd2V9Vvj
	cCHqbXyGXvU/3tTDCWiZ7JnRm0Vq6xEzyYBIM+o//+eHIr3MoXQLdmm4DUItL/LPVUrFlQ
	xHrieJ7fhKbwrn10GETFuY2esc2LvM8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Ihor Solodrai <isolodrai@meta.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf,ktls: Fix data corruption when using bpf_msg_pop_data() in ktls
Date: Mon,  9 Jun 2025 10:08:52 +0800
Message-ID: <20250609020910.397930-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250609020910.397930-1-jiayuan.chen@linux.dev>
References: <20250609020910.397930-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When sending plaintext data, we initially calculated the corresponding
ciphertext length. However, if we later reduced the plaintext data length
via socket policy, we failed to recalculate the ciphertext length.

This results in transmitting buffers containing uninitialized data during
ciphertext transmission.

This causes uninitialized bytes to be appended after a complete
"Application Data" packet, leading to errors on the receiving end when
parsing TLS record.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: John Fastabend <john.fastabend@gmail.com>
---
 net/tls/tls_sw.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index fc88e34b7f33..549d1ea01a72 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -872,6 +872,19 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 		delta = msg->sg.size;
 		psock->eval = sk_psock_msg_verdict(sk, psock, msg);
 		delta -= msg->sg.size;
+
+		if ((s32)delta > 0) {
+			/* It indicates that we executed bpf_msg_pop_data(),
+			 * causing the plaintext data size to decrease.
+			 * Therefore the encrypted data size also needs to
+			 * correspondingly decrease. We only need to subtract
+			 * delta to calculate the new ciphertext length since
+			 * ktls does not support block encryption.
+			 */
+			struct sk_msg *enc = &ctx->open_rec->msg_encrypted;
+
+			sk_msg_trim(sk, enc, enc->sg.size - delta);
+		}
 	}
 	if (msg->cork_bytes && msg->cork_bytes > msg->sg.size &&
 	    !enospc && !full_record) {
-- 
2.47.1


