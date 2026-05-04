Return-Path: <netdev+bounces-283918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NE7KP66+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:27:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A44C0AC9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46B973014C1A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A66C3E0250;
	Mon,  4 May 2026 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC1pNmR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550E3E0241
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908453; cv=none; b=MH+Uil82YCmb+eeti8/mGTz9X1tiS3IndJvsJ/zS1YNn+ZMxJZFEZsfO2fm2QeynloULyt7n/YMdz004OFD94IZBSkZ6lzXfZcvetAZIcJ+SHOjioTKmd2pKLOqI23OIbAFJA/KU1Iapbrz+F3C26bt5NsbIyazb39Pe70z8AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908453; c=relaxed/simple;
	bh=hO+zym3mTv4R/jUftjLR4dlYFUKwiMbLkRn34MxFFe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMKbrLsqIaO/GQs1PfcDnz7R0UP3yt99zWmiX5kaHu1YVsoBSAb5JBIsiqVrgRwMFbmXhcil3uLlrKFIExqPNwv1OEOkOyz4SceezefLtXkrASTNEHnzV6+wBFtseMOUvpWZPtZaYAC8SUJ5ty6EB14hKiHDefSyRqenY9H/cmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WC1pNmR9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so534285b3a.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777908450; x=1778513250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZjvTocBotG8D32T0Fa7dku0HsteTt04rb/ig51a7Kg=;
        b=WC1pNmR9RX5SB5Z3qgYn452e62E+X9OcyDvBz9IWVAGK5znktMG5PUVVOs2Sx4GPjS
         qDdrudwDdUTu4sck6bRobYEwXp1gehgnajwnY5x6F72Vm6rfhqWpq+xG7HWw4Bgjs1XE
         Nh9k8AbvfgUeacEx+VcYPk7eq3jli+lZPvj0iUUFESVe5QAyStk47ku7pgvjTNDjVGi1
         kVvvVJeiL3OM9bEj0E8X+UKrRVfXkSGkXFM65sxGyAOYM1c5CLBqcbn8YiFR6ivO8XQi
         XW9O4nvU312o7Dh5djOWluPDyU515L7S04fIDdOKlNO++t6SeLSFD/cyCXzCgxyZVWrs
         Vi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908450; x=1778513250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZjvTocBotG8D32T0Fa7dku0HsteTt04rb/ig51a7Kg=;
        b=fZ19eeVZRkrVhlaUa80DqG5n40jR7F3UbSPOBqLnbhR59c/p1+BVctk7+87GYsYtQa
         +5VJs8sMvcxoleEoMoPFpM/EYD89dz+e931rX/XP0pp84mz8/pyPZzk97RLzTTxL5Rz7
         pQqU/ovDuwWgX75QDRCAevk79UP9/FnG9a04inb0A7oQkKMUiUecMrs7c4els89N4crc
         QympgaPQUx7xYnuUbcz86qNzDf+v6pssBjBqE7750MKgKsZkxcPI8smRH4K5gTdRtL1D
         Ai4UarnGeguiveNKTY+WyLSsA6rvMjvSi4jrI4aWKjlTkf28lLqpCHaiKgZrXIFhRBjA
         PqNg==
X-Gm-Message-State: AOJu0YzSKua4/rOqqjRKSkpH3yym9RPequgSABq4R+NZjTpeCTALwuA1
	rMu1soEm28pGXCFQYXZFS3uM3+f76kz29P2pYABmzbC1plxEXGWMPyJ6vB675PBE
X-Gm-Gg: AeBDieuRpGqzcuD/JRpMmbL7TjBlLF3nRXQcXxmVlw1hBMs2ohu4k1O4n/RpEugpLAm
	ATjSr//DnhW50sqLuOb+06BbBuEoclYnbVMDA5fVU/xlgQwYbdiijPRGV8xj3pqyzmyWqAUT+Lt
	Y2CFkSL7TJHVxJNEAXa4x0IonIZDLyX0kH6cBYDcT0ydlQQ8VPsDPAC2ZmSHw7X/XFMFUaFm0Wl
	0lS+R9iTSEM9QDjz33gadZZG8HUh0FOvBe7MhJnvyp2DsyI+4/+ZReLJvJk8ijGimesNsbtLfAT
	AZga3ZG7DuvejqF5WWtrqKqK2VYVSfT/iv2VudGEFVvNGluOkfJVouwy5sCzcV+0TWOffOHIGLE
	OFws1p1gQEC+Yee2ZLIv1dnBpcYk1gxyJFwm+nq0SGqAhaCdZBwFCZ83LNKV3tRQWIkFJnUAap/
	qllBj+BpA2ALy7WUrj3fgs9oOM33rbmVWOEQSaYzqkX9d+eSlqvKyeakuZM69j2qpmkzzJzbQav
	yFgmUpS6DkJmSdgZUGjPVOwV6v4
X-Received: by 2002:a05:6300:48:b0:3a3:c6df:7239 with SMTP id adf61e73a8af0-3a7f1ad0724mr10192618637.10.1777908450288;
        Mon, 04 May 2026 08:27:30 -0700 (PDT)
Received: from localhost.localdomain (114-45-143-162.dynamic-ip.hinet.net. [114.45.143.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbd313sm9924766a12.12.2026.05.04.08.27.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 08:27:29 -0700 (PDT)
From: HexRabbit <h3xrabbit@gmail.com>
To: netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kuan-Ting Chen <h3xrabbit@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb frags
Date: Mon,  4 May 2026 23:27:12 +0800
Message-ID: <20260504152712.76305-1-h3xrabbit@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 681A44C0AC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[secunet.com,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-283918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[h3xrabbit@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Kuan-Ting Chen <h3xrabbit@gmail.com>

MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
so later paths that may modify packet data can first make a private
copy. The IPv4/IPv6 datagram append paths did not set this flag when
splicing pages into UDP skbs.

That leaves an ESP-in-UDP packet made from shared pipe pages looking
like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
fast path for uncloned skbs without a frag_list and decrypts in place
over data that is not owned privately by the skb.

Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
TCP. Also make ESP input fall back to skb_cow_data() when the flag is
present, so ESP does not decrypt externally backed frags in place.
Private nonlinear skb frags still use the existing fast path.

This intentionally does not change ESP output. In esp_output_head(),
the path that appends the ESP trailer to existing skb tailroom without
calling skb_cow_data() is not reachable for nonlinear skbs:
skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
tailen is positive. Thus ESP output will either use the separate
destination-frag path or fall back to skb_cow_data().

Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
Fixes: 7da0dde68486 ("ip, udp: Support MSG_SPLICE_PAGES")
Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Reported-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
---
v2:
- Add Fixes tags
- Add stable Cc and Reported-by trailers.

 net/ipv4/esp4.c       | 3 ++-
 net/ipv4/ip_output.c  | 2 ++
 net/ipv6/esp6.c       | 3 ++-
 net/ipv6/ip6_output.c | 2 ++
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6dfc0bcde..6a5febbdb 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -873,7 +873,8 @@ static int esp_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index e4790cc7b..5bcd73cbd 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1233,6 +1233,8 @@ static int __ip_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9f7531373..9c06c5a14 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -915,7 +915,8 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
 			nfrags = 1;
 
 			goto skip_cow;
-		} else if (!skb_has_frag_list(skb)) {
+		} else if (!skb_has_frag_list(skb) &&
+			   !skb_has_shared_frag(skb)) {
 			nfrags = skb_shinfo(skb)->nr_frags;
 			nfrags++;
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7e92909ab..1f2a33fbe 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1794,6 +1794,8 @@ static int __ip6_append_data(struct sock *sk,
 			if (err < 0)
 				goto error;
 			copy = err;
+			if (!(flags & MSG_NO_SHARED_FRAGS))
+				skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
-- 
2.43.0

