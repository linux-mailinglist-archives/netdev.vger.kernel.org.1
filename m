Return-Path: <netdev+bounces-258628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCbNMFVDj2k5OgEAu9opvQ
	(envelope-from <netdev+bounces-258628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:29:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67074137906
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 16:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 311F130ED2CB
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BE363C69;
	Fri, 13 Feb 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwHh1NLb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C85F36073C;
	Fri, 13 Feb 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996426; cv=none; b=cMMRTPNcRFmli90VCqUpoYTSemFEMFbe8lqg2rrP7bnklbCuH7Ny74V/aY/1ylKc+vt1aXl86vWBh2PDZJrqH9MPr1BXqJJrDJC1bBT2YaEV2Hcpk3LP43tDRzgozr5ibyYWm5UfvIAUrbg0gdACKaTDpy4zG/Q87/xcImgrjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996426; c=relaxed/simple;
	bh=jzwrIvlfZk6MWSMCC0apFup4Q/S1x/hMT1Pen21jYHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luFXN61RXhcQ0a3aWin415cHJGUZwOjm4CJSDgoMNniXV4KXmnzEW9RDQZtFJOalYy9d+E+n3/UH2o+uWymyzOaHjWoXQVdgN8edpBPFRqMavm/0kJQtJLUPMlfku3l1xg664CDfd3hFEU4ThO3yWtyifwDYRYJJZ/SGNIDCaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwHh1NLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D50C116C6;
	Fri, 13 Feb 2026 15:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770996425;
	bh=jzwrIvlfZk6MWSMCC0apFup4Q/S1x/hMT1Pen21jYHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rwHh1NLb4cG2OfEAbgLg+lNi1i07uP/G2ZALst8A7GRIvdEeMBzHaYrqp+JSreA2f
	 5RHuF//UI8ycWM5gv6G90axt6O2QpAY5gxUW8hqKZtCjxnI5zqfb0V2TnBneeeyOu8
	 7SdQjxpWmxn6ZL8SjCF316eb7HoYCft5uSRPawYvMjh4GdsSIBQLs8JM4rFpamDBWS
	 rJ+0nhibZbNspaG23PA96Jug9e0xuBCElYZUbGa84YgI1imSUQFLB6JIJ5NgfUOtYV
	 fLMViBBC385xwUaXIft0UR/RpuhHuvR9ftNd4ghfzLjL1hWlaeL+fU6fHFuCe5Iao6
	 Yt9FgcroU0Ztg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 13 Feb 2026 16:26:21 +0100
Subject: [PATCH bpf-next v2 2/5] net: veth: Add xmo_rx_checksum callback to
 veth driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-bpf-xdp-meta-rxcksum-v2-2-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org>
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
 linux-kselftest@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258628-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67074137906
X-Rspamd-Action: no action

Implement xmo_rx_checksum callback in veth driver to report RX checksum
result to the eBPF program bounded to the veth device.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/veth.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 9982412fd7f238e996ccdff24342974cb25094bf..3ec77599299ae0bbb7df88e5820793065911e88e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1697,6 +1697,35 @@ static int veth_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 	return err;
 }
 
+static int veth_xdp_rx_checksum(const struct xdp_md *ctx,
+				enum xdp_checksum *ip_summed,
+				u32 *cksum_meta)
+{
+	const struct veth_xdp_buff *_ctx = (void *)ctx;
+	const struct sk_buff *skb = _ctx->skb;
+
+	if (!skb)
+		return -ENODATA;
+
+	*ip_summed = skb->ip_summed;
+	switch (skb->ip_summed) {
+	case CHECKSUM_COMPLETE:
+		*ip_summed = XDP_CHECKSUM_COMPLETE;
+		*cksum_meta = skb->csum;
+		break;
+	case CHECKSUM_UNNECESSARY:
+		*ip_summed = XDP_CHECKSUM_UNNECESSARY;
+		*cksum_meta = skb->csum_level;
+		break;
+	default:
+		*ip_summed = XDP_CHECKSUM_NONE;
+		*cksum_meta = 0;
+		break;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1722,6 +1751,7 @@ static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
 	.xmo_rx_vlan_tag		= veth_xdp_rx_vlan_tag,
+	.xmo_rx_checksum		= veth_xdp_rx_checksum,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \

-- 
2.53.0


