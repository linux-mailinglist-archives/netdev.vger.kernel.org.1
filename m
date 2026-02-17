Return-Path: <netdev+bounces-258985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA1QO4AolGk9AQIAu9opvQ
	(envelope-from <netdev+bounces-258985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:36:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C28414A02C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0C70303E4B4
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D602EC0BF;
	Tue, 17 Feb 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIoi3Nkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE4299A8F;
	Tue, 17 Feb 2026 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317287; cv=none; b=O0O81fQ68Y2SrsoTXNzNZmxvqNbZq3zB5ah3FZSHst2a7D1u9Q/jjaNzUj5DRYjXUNPLvy1aBAVUME8oRkAHKA7GFMuYGCG3oVUqMiDuTrBzhqUdE+z9MfMOE6/IM6Sb6AhGzhhZWPLGKWPF0wQerCVkf6SZ9lZSxP4E7TimLVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317287; c=relaxed/simple;
	bh=acetSvAvAvzBxJaNnQ3tpe8HbAc79uV5aOOQPwduvU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oADNTiQT4xkdWW9ZIZPiXc9S5cTdg3cl/VnykaU2tSkZgdH2Kc4Xv4YFgJXvXG+UY/5MIs+bSK6YOkN/TWgYTY2s+Le40azxn7HZMk29U7kfIams25zDcou4rDcYGtA7fgNiEz45JgUK7dMuLJWw0WQsXJ0Xgr7759OGJvaT3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIoi3Nkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17A9C4CEF7;
	Tue, 17 Feb 2026 08:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317287;
	bh=acetSvAvAvzBxJaNnQ3tpe8HbAc79uV5aOOQPwduvU8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pIoi3Nkwx7IMtgmDUpj+R3v4ZLPeLjk5kGi3WWzBCoIN1fYclHydLo6GKUXj/Z0lY
	 MB7o449l57dXr2At8L0E22Zsczekk2P7P3NuUmx/8FBCeiSPvu1sCGbkbtCGendSi0
	 2bqo2ER1/X46XMKBcUoHyqJdfmvMpKoUWneAlj0RHDOOpZWfu+Zx2WklHasovIlLvd
	 uKiD0oechyiIEeEi9xc1N+EU+ppvCSRNy1yzqM1VakG9fxz3zIf9bCNv75Z+p6RVLh
	 dSm4cN50FuaGQsdLyG5555S2XX6L/EncVywbiHu8SU5ECdlQrOrzdv8jL8d28Ou3ls
	 7h104UUiuMObA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 17 Feb 2026 09:34:00 +0100
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-bpf-xdp-meta-rxcksum-v3-5-30024c50ba71@kernel.org>
References: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C28414A02C
X-Rspamd-Action: no action

Introduce the capability to dump HW rx checksum in xdp_hw_metadata
program via bpf_xdp_metadata_rx_checksum() kfunc.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |  8 +++++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c      | 25 ++++++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h         | 10 ++++++---
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 330ece2eabdb454da2bb2cbd297d2b2dd6efddc0..9113288fce54bb39dbb6b38e1f6badd0a8ef4cde 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -110,6 +110,14 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
 
+	err = bpf_xdp_metadata_rx_checksum(ctx,
+			(enum xdp_checksum *)&meta->ip_summed,
+			&meta->cksum_meta);
+	if (err)
+		meta->rx_cksum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CHECKSUM;
+
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3d8de0d4c96a7afdf5f60b2fdff73c22b876ce54..f1cf8490cc497b5dd75b8d839918fb85c2a0684d 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -8,6 +8,7 @@
  * - Metadata verified:
  *   - rx_timestamp
  *   - rx_hash
+ *   - rx_checksum
  *
  * TX:
  * - UDP 9091 packets trigger TX reply
@@ -219,6 +220,25 @@ static void print_vlan_tci(__u16 tag)
 	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
 }
 
+static void print_rx_cksum(__u8 ip_summed, __u32 cksum_meta)
+{
+	const char *cksum = "CHECKSUM_NONE";
+
+	switch (ip_summed) {
+	case XDP_CHECKSUM_UNNECESSARY:
+		cksum = "CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		cksum = "CHECKSUM_COMPLETE";
+		break;
+	case XDP_CHECKSUM_NONE:
+	default:
+		break;
+	}
+
+	printf("rx-cksum: %s, csum_meta=0x%x\n", cksum, cksum_meta);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -254,6 +274,11 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
 		       meta->rx_vlan_tag_err);
 	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
+		print_rx_cksum(meta->ip_summed, meta->cksum_meta);
+	else
+		printf("No rx_cksum, err=%d\n", meta->rx_cksum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index 837cd1efe6b5aebd0f62bae4c49d5bfd77db64bc..822e34390582b3d3660a25e725c9a622edbf635c 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -28,6 +28,7 @@ enum xdp_meta_field {
 	XDP_META_FIELD_TS	= BIT(0),
 	XDP_META_FIELD_RSS	= BIT(1),
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CHECKSUM = BIT(3),
 };
 
 #define XDP_CHECKSUM_NONE		0
@@ -52,9 +53,12 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
-	struct {
-		__u8 ip_summed;
-		__u32 cksum_meta;
+	union {
+		struct {
+			__u8 ip_summed;
+			__u32 cksum_meta;
+		};
+		__s32 rx_cksum_err;
 	};
 	enum xdp_meta_field hint_valid;
 };

-- 
2.53.0


