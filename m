Return-Path: <netdev+bounces-305985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0bhAy+1TmofSwIAu9opvQ
	(envelope-from <netdev+bounces-305985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:38:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4A72A443
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:38:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=hHBJMgu1;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305985-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305985-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37B2830BBD5E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC03E5ED6;
	Wed,  8 Jul 2026 20:35:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2005i-snip4-11.eps.apple.com [57.103.86.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33735E1B6
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:35:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542916; cv=none; b=dFOqUHcm6o8w5WcnRO9QRZCwDDt5RARCjRNRrvH5KypTvUJ1JjrhWXpcrqlTUmRBY7feGqRVqnj8vseL9Kkcvz5eBF9HaAbQo7+7wYoZ+MrGv2ONFpeyuJiBLR2o/60WTmxHNFLfHazMXKZ/wgv8ZIbAhdG4jHzB9ZPsI8ekpuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542916; c=relaxed/simple;
	bh=Q+/any6DcHinqwZLRkuj5dOQIBbBwaCx9zs4CHO5bu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwbrrAcEwtulICMWgyg+n5CO5+drt1RKH8AlCvDKv9R0kt0ZwWI/queZFBU4wOX40skkAVUOe4WS7JRW6xb3KeLadZYVrmmIJwpCP1JGUX18K673T5fZNYyszgn8mYZAsnJD1AJyjTv/vZ4RToMfFDaBiKIw0L3xh45fC01RKi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=hHBJMgu1; arc=none smtp.client-ip=57.103.86.221
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id 45D8130000A7;
	Wed, 08 Jul 2026 20:35:10 +0000 (UTC)
X-ICL-RepId: 019f4371-0cf5-78ee-8741-84716a342eec
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGl0fFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542914; x=1786134914; bh=P9yZ3D+W7OaCzN5HlpP15te0niQUHg9N2Yn3fSLJwKQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=hHBJMgu1UR7ZtQu0GfIWLTdpVm2+dzVDzTl/t6MkzU9GA3r6DYqXxrxQzuFQwJ39U3ccofZXAtg11ktElYbW1ov5btl/kyWawZxHu05tV3lkD7n2vBpwHYR8j0mYQ96tWilKgUi2Anth2GkgEh9/+ShVlTGG5Cz7+plQo9dPYhQs10LTxB8aGf0NYpcHkxkMhgxcy2ige5NfvZ52XSMz7+J+EtyBkQjbPfkRiJGG5KCkqa4olTSL4/+n1ZBARbA+998L5sb7ZWsbMJjhWNcExFWnCWB19N0tTOvnO0vRHMPdsFSF685WtXLpsYkk+hpOAjx7NYWeDXJhETZFrBnT1w==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id 8DEF93001131;
	Wed, 08 Jul 2026 20:35:04 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 5/6] selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
Date: Wed,  8 Jul 2026 23:34:09 +0300
Message-ID: <20260708203410.45121-6-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260708203410.45121-1-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KC7sGlHzL50hsQ8zFZqYikrF1tSlvV3G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX/6Cgds3nmqO8
 FB6Wpi6p9x20KF9UFCxwVZax5liF9ajdkn7i+4tU/5aN/n62zmZpfRd6WFt5iUAKt46H1j7q35w
 SHo9AMH3gENRRM+salepGNeCbjH8dOzJjul5JalHT/uQ4QnZ8WN9AS+FMOtNa2CDCGUVouCppus
 O9bCuViIfCs+mHi1rqzjIZvzMwha+X7bq224VUwAREPulqIa2Iox47Vshv8p5MJD0klwpsFjbUp
 LhD1X/P634jxGMaeOQg0zHqLtf2KRgYB5ESc2Oe4TdpQfFVFfBc55vYXr/g2ezMHPiu9JT8KN0K
 R0/EC5A97Cx8JJ0lnd0
X-Proofpoint-ORIG-GUID: KC7sGlHzL50hsQ8zFZqYikrF1tSlvV3G
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305985-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:deliran@verdict.gg,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verdict.gg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,verdict.gg:from_mime,verdict.gg:email,verdict.gg:mid,verdict.gg:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5E4A72A443

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce the capability to dump HW rx checksum in xdp_hw_metadata
program via bpf_xdp_metadata_rx_checksum() kfunc.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
---
 .../selftests/bpf/progs/xdp_hw_metadata.c     |  7 +++++
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 31 +++++++++++++++++++
 tools/testing/selftests/bpf/xdp_metadata.h    | 12 ++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
index 330ece2eabdb..5eeadb7e27cf 100644
--- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
@@ -110,6 +110,13 @@ int rx(struct xdp_md *ctx)
 	else
 		meta->hint_valid |= XDP_META_FIELD_VLAN_TAG;
 
+	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
+					   &meta->cksum, &meta->cksum_level);
+	if (err)
+		meta->rx_cksum_err = err;
+	else
+		meta->hint_valid |= XDP_META_FIELD_CHECKSUM;
+
 	__sync_add_and_fetch(&pkts_redir, 1);
 	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
 }
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 6db3b5555a22..c63a70a54075 100644
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
@@ -219,6 +220,30 @@ static void print_vlan_tci(__u16 tag)
 	printf("PCP=%u, DEI=%d, VID=0x%X\n", pcp, dei, vlan_id);
 }
 
+static void print_rx_cksum(__u8 ip_summed, __u32 cksum, __u8 cksum_level)
+{
+	const char *cksum_str;
+
+	switch (ip_summed) {
+	case XDP_CHECKSUM_COMPLETE | XDP_CHECKSUM_UNNECESSARY:
+		cksum_str = "CHECKSUM_COMPLETE,CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_UNNECESSARY:
+		cksum_str = "CHECKSUM_UNNECESSARY";
+		break;
+	case XDP_CHECKSUM_COMPLETE:
+		cksum_str = "CHECKSUM_COMPLETE";
+		break;
+	case XDP_CHECKSUM_NONE:
+	default:
+		cksum_str = "CHECKSUM_NONE";
+		break;
+	}
+
+	printf("rx-cksum: %s, csum=0x%x, cksum_level=0x%x\n",
+	       cksum_str, cksum, cksum_level);
+}
+
 static void verify_xdp_metadata(void *data, clockid_t clock_id)
 {
 	struct xdp_meta *meta;
@@ -254,6 +279,12 @@ static void verify_xdp_metadata(void *data, clockid_t clock_id)
 		printf("No rx_vlan_tci or rx_vlan_proto, err=%d\n",
 		       meta->rx_vlan_tag_err);
 	}
+
+	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
+		print_rx_cksum(meta->ip_summed, meta->cksum,
+			       meta->cksum_level);
+	else
+		printf("No rx_cksum, err=%d\n", meta->rx_cksum_err);
 }
 
 static void verify_skb_metadata(int fd)
diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
index bca09b94af26..f864d4a8bd8c 100644
--- a/tools/testing/selftests/bpf/xdp_metadata.h
+++ b/tools/testing/selftests/bpf/xdp_metadata.h
@@ -28,6 +28,7 @@ enum xdp_meta_field {
 	XDP_META_FIELD_TS	= BIT(0),
 	XDP_META_FIELD_RSS	= BIT(1),
 	XDP_META_FIELD_VLAN_TAG	= BIT(2),
+	XDP_META_FIELD_CHECKSUM = BIT(3),
 };
 
 #define XDP_CHECKSUM_NONE		BIT(0)
@@ -52,10 +53,13 @@ struct xdp_meta {
 		};
 		__s32 rx_vlan_tag_err;
 	};
-	struct {
-		__u32 ip_summed;
-		__u32 cksum;
-		__u8 cksum_level;
+	union {
+		struct {
+			__u32 ip_summed;
+			__u32 cksum;
+			__u8 cksum_level;
+		};
+		__s32 rx_cksum_err;
 	};
 	enum xdp_meta_field hint_valid;
 };
-- 
2.47.0


