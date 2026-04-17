Return-Path: <netdev+bounces-279234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIIKOYDO4Wm0yQAAu9opvQ
	(envelope-from <netdev+bounces-279234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:09:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D3D417409
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D17230712D3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D431ED81;
	Fri, 17 Apr 2026 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/nqmesR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2B1B4F0A
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776406138; cv=none; b=rQSIPGanvPa99yB2yI1LlOVQCRXpzH+6oPRjDGxvZLBH9dwsurb87OzW0P2/3X73ZWNkMGU3T0DWulfi7IdKQSfEuL0okJYkWTIiF8qSGMlwlnC0Dy4uRj+FJIItePdNeKV/xd+rd8Wiwuwy7v1q9K9tT1Fj4uUs2kJbsa782HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776406138; c=relaxed/simple;
	bh=n8VcySRPi3otOxN5Z3OK4RIuxBZogcJUJwv/1q/Dv68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuTfo+g/3T7bHFCWxpPu/p6rapYlTi0SzWWVYcWxEo+oDhhrxe1IQYuc2ApeNyhnEMUS6G6iwWBehpPF1XoZ1QHQdeMIFLabAMZ0H6I/c3RjOWY2nG+bbM7a17VNmrqSL0Myl8hPUKZcP0VaWQlZZrBKixz04skREQ0ElAYd210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/nqmesR; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1279eced0b9so419922c88.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776406136; x=1777010936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+VZdm1UQLTigiNd5q9OXvWNDFTdH4218cOiyPZf7o4=;
        b=J/nqmesRH0ZYvUrW7LRBfvYOI4NNVm8lWuoZF4oTVYcXwUknj9GGQIy2xCpXwSpd3a
         1xQqeF2YHr2w/uo/ahTjEX8aeniKUm/v0m/EnvCDcJpX0ifJhx8RSMySkGUWdhQdpJaA
         PWGtG5LUpt+6iOP5lgNn/syubK3oMpUD2byuySpVQ9Bt3ZTgOi0D2DJzE4RmIImF9ku/
         MV6U9hv9e1bOLqEzzuVd8B0MdtJGbBnZ7i5T+MLN906fG3J3VOUdpSBHC+EPzhviTAq9
         yld96GP3I9NoDD3v+4LFhuJVFL8J3gHfUiMLlsm5BqoN40znUtGYmtS1DLkrIF6vCFsV
         dBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776406136; x=1777010936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+VZdm1UQLTigiNd5q9OXvWNDFTdH4218cOiyPZf7o4=;
        b=iFjJ193iLiePP1D3B3RtcR4Qwzu6K8TXHCB2oIBjqKEMKiAhxhxF/Gp9GOjW4FCP3E
         uZbp7duDCunfiXvoXbxEUTgG0OLE2KM1jj9qEqf2NO2zC+ZRx9X/V8OGhLl0OhQvk3LL
         LPaS8zX69aFvSyt2+uLxf1/crM6UrNsK1Ohxa2IWCSk2qxhaC7W8XFT9B2OcJwn4rtBu
         1hFqao8thSfKIZS5sg7Rj3iYukuRhx3lI9xeRZz4Tz5YRNS2K1afg2/lsyLaZhJaRrkM
         aGLYm9DxHrgtJh5m1bMWZNZ/+z1cU+vJFqkJ2z5p56Woax5btt5BujpyR9qUCFPiQvyz
         hflA==
X-Forwarded-Encrypted: i=1; AFNElJ8AI6Uf6ybZpVVuOeuB6GmAmqyPfTbNDT5u2VKXDfj7cUa2FnJu3nDoIEsbUXuSLca3ORZ/bBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBDk5MhCk34jBquAozVOkRIvh8DrBS4fZ6a/0Rv6A7TYrX2X9
	Cmcvh8WI7FVYiQHCJR9Vif9vlZFnk4NXfKSwkdxcEmuy7emGzDSi4101
X-Gm-Gg: AeBDies25a9v2N3+hwyuvxthYjiCfzbxu/tlG1B0+7KQjUm07FVE8XGIhaMGSn2OvcE
	porgxqxrXaNY4pxKwgTTaZhIEFXHanWVuvNgOcIi/wSNaAIVazPCQr8yRQdPdIMS0ID48AbKUPs
	1BK+Iflk/BFn909PP9s72Nz83CJDb5FJ6PN3ATF++FIhte6kXU9YrDgiZ8P5kz/T/JAJJV2dMHi
	D8rD5sLU+fG9uKyNbLc9fCsX58htEevbV8ugERfKDkWRm0Kq0V1EyPnBYI4BAZiecgMneU7TYvs
	KZVPCtnwrwdfClKQTSFaiPxImsBTgS6ft35llYPi5ZMMjiR5sdO8kHpeIdY6wZorFEL1dOFcnor
	fEdMMuQ9dFIQakb8FM7qpDpnsFpefWRmkc3GIr6BRWaJXysYGsLTOvUH+abxOV6JnAZcpzC4qZM
	aGjbuohGJQWq3f5/u2XDyan2oH6nKjw0Xz41CmpCFnX6QaSrTrRWhcEplYiGn5oYO3CoHZxzvrh
	2v/CXf//T8/mxOdo6lgUEnQqqrQd3Tz
X-Received: by 2002:a05:7022:3d0f:b0:127:9e95:a2f with SMTP id a92af1059eb24-12c73f6d5b7mr531726c88.2.1776406136386;
        Thu, 16 Apr 2026 23:08:56 -0700 (PDT)
Received: from localhost.localdomain ([156.59.4.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749c46c8sm904315c88.1.2026.04.16.23.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:08:55 -0700 (PDT)
From: Zero Mark <patzilla007@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: security@kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Zero Mark <patzilla007@gmail.com>
Subject: [PATCH] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
Date: Fri, 17 Apr 2026 14:07:14 +0800
Message-ID: <20260417060714.35488-1-patzilla007@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAHOBGNBvZOXGzzMDuHWw1RrRvbg4TZVH34jVDhc1nkHbW_URXA@mail.gmail.com>
References: <CAHOBGNBvZOXGzzMDuHWw1RrRvbg4TZVH34jVDhc1nkHbW_URXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279234-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[patzilla007@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86D3D417409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
directly into the mmap'd TX ring buffer shared with userspace. The
kernel validates the header via __packet_snd_vnet_parse() but then
re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
userspace thread can modify the vnet_hdr fields (gso_type, gso_size,
flags, csum_start, csum_offset) between validation and use, bypassing
all safety checks.

This can lead to:
 - Out-of-bounds checksum writes via crafted csum_start/csum_offset
 - Malicious GSO segmentation parameters
 - Kernel memory corruption and potential local privilege escalation

The non-TPACKET path (packet_snd()) already correctly copies vnet_hdr
to a stack-local variable. All other vnet_hdr consumers in the kernel
(tun.c, tap.c, virtio_net.c) also use stack copies. The TPACKET TX
path is the only caller of virtio_net_hdr_to_skb() that reads directly
from user-controlled shared memory.

Fix this by copying vnet_hdr from the mmap'd ring buffer to a
stack-local variable before validation and use, consistent with the
approach used in packet_snd() and all other callers.

Exploitation requires CAP_NET_RAW, which can be obtained without
special privileges via user namespaces.

Confirmed with a PoC on Linux 6.8.0 (Ubuntu): kprobe tracing on
skb_partial_csum_set captured 77 race wins in 500,000 iterations.

Affects all kernels since PACKET_VNET_HDR support was added to the
TPACKET TX path (~v3.14).

Fixes: 9ed988e5 ("packet: add vnet_hdr support for tpacket_snd")
Signed-off-by: Zero Mark <patzilla007@gmail.com>
---
 net/packet/af_packet.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index abcdef012345..fedcba654321 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2725,7 +2725,8 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 {
 	struct sk_buff *skb = NULL;
 	struct net_device *dev;
-	struct virtio_net_hdr *vnet_hdr = NULL;
+	struct virtio_net_hdr vnet_hdr;
+	bool has_vnet_hdr = false;
 	struct sockcm_cookie sockc;
 	__be16 proto;
 	int err, reserve = 0;
@@ -2828,16 +2829,17 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		if (po->has_vnet_hdr) {
-			vnet_hdr = data;
-			data += sizeof(*vnet_hdr);
-			tp_len -= sizeof(*vnet_hdr);
+			memcpy(&vnet_hdr, data, sizeof(vnet_hdr));
+			data += sizeof(vnet_hdr);
+			tp_len -= sizeof(vnet_hdr);
 			if (tp_len < 0 ||
-			    __packet_snd_vnet_parse(vnet_hdr, tp_len)) {
+			    __packet_snd_vnet_parse(&vnet_hdr, tp_len)) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
 			copylen = __virtio16_to_cpu(vio_le(),
-						    vnet_hdr->hdr_len);
+						    vnet_hdr.hdr_len);
+			has_vnet_hdr = true;
 		}
 		copylen = max_t(int, copylen, dev->hard_header_len);
 		skb = sock_alloc_send_skb(&po->sk,
@@ -2875,11 +2877,11 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
 		}

-		if (po->has_vnet_hdr) {
-			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
+		if (has_vnet_hdr) {
+			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
 				tp_len = -EINVAL;
 				goto tpacket_error;
 			}
-			virtio_net_hdr_set_proto(skb, vnet_hdr);
+			virtio_net_hdr_set_proto(skb, &vnet_hdr);
 		}

 		skb->destructor = tpacket_destruct_skb;
--
2.43.0


