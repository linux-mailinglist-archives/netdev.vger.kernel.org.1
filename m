Return-Path: <netdev+bounces-259884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id InZrK1wmm2nGtwMAu9opvQ
	(envelope-from <netdev+bounces-259884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:53:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FD16F91E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 879843008C2D
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A504261B96;
	Sun, 22 Feb 2026 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9klw3P+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3413D51C
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771775578; cv=none; b=t22x4/swfXtMDP9oFBmGLI3qiKK9/BE5FNAZ5/liQ5f158h62jLjSys2M9emiIhqnEXJQy55NE3NYOwQf3zlB7zx7P0SeGTWRSTji+ayA7dAfOTPMr0jlsJaXy7JW73vuPDp075SV6FnlgO/NeNIGpinhujaVT/+MWs2/+zOlkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771775578; c=relaxed/simple;
	bh=A3FVTaY3gTdk4/I4tDNDGEa2Hhq6PqSLRqaRlb/FPlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojyXQToXLXwyHmJZk08hKJRVTRI87lwGJOjQg6UA4uB0C4Ev/xxbB3xK9D5yc9yppJ1m2lTAeSrQ75aIN1wEQ27khjSsylIeP7dCtMBzAfTqUO6vMmxxFuJlPI0hR84YjLQcZBiGhvdT7w5qPLIQ28BgTt7+fkpZ9+pwepWwnsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9klw3P+; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b885a18f620so630956266b.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771775575; x=1772380375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1NVM2G3MvWYR9rREQPgIPKKWATWW6NZZLQEjl5ilZu8=;
        b=Q9klw3P+qB6Wp5NKJatrfhBOT+pCQLkrV8HCbvghP/xTICLWpJoxmduqSTX5yDFXTp
         8EvvVf0w4MFYhInE8L0C8t0INb1i1gkS19ITOKyrCpKVywLIjsmk7i/k1GIMrfMfjts/
         evSx8hUMwlwjRLrLHD2ouD3NhOi5YT8BJd9MN4GKmrRD/rGDEeqN7hvlQRP/1jsqmk5s
         h7O8O1uqKGWedjNVDJBLRy+YVP0a8AEIZ7IaPPVw2uYz1B3baR5YIgvF5bkcgW2liRtw
         fkwsMyHi9RvnjQRGQOLfzv7Pb8T6FFOyiX0NnADGzW5dWi6LCFWnPxsw/ebyqNVYTvET
         kZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771775575; x=1772380375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NVM2G3MvWYR9rREQPgIPKKWATWW6NZZLQEjl5ilZu8=;
        b=mLqK7dHVBLC8pot07njtX2WBODTwRPlZwjO+7QMyzMiFyDT54g43BlgP5jIe9seht2
         CiIoAUutGFjJNYVR4FmkhNZHox5iddEfSYqbhswLwMl/GykFURpJJ32+F6A4jU6n6lmk
         r9iUNM80PFROLTUA6xpdFUa2hZ4fTUii+sfW+zIv71/4/aUsEPIgFjM+Ju5xaL+ZgscM
         LwrlNrES4U7dpd/kKFA/QBiLdxm/7CVPgDfNAXs2ImNqN6e/Xo+Bm+HKcFOR6egDxIE3
         9VnndYKx++6ZA/485Iwc3q07XI8Jja8ZJzCUoGZ+2E5sxiyGqfBSFHZzBU0g90PvFAB6
         2rBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuW+Um7jMJSIEtQ/ZXUpCv8Hyf/2wMrA0JQMhxmDzMSA+byZVjd2pnUVbv8gBGpoTttaSrwUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR1xI3dr+ZGeVsK78ZQAxp5p7rKCstEtTWfOSdFvVW+llJcZc8
	x1UwDzMlTADjE5pS0NJ4xUhDM9tlsIGfO+Ad4VqTcsFmlAVzoUbHuMdg
X-Gm-Gg: AZuq6aIoSLwTwAfOxokMYbm/2vbFmSt4DnirxTClN9utq1pPk45WNa9Dq3G61rBglyt
	rgTdpqr0y7jTjimnS4VKuHzSxh0EF0E3MAv/V9fhMDKIt8GhwVAC7xDQK4f+xSZpLCdxdAcZK+x
	BQhQU3jdR/Oy4oZe0TU4dOKkNUKkJ/1aKcpm2ykS4INd0xp/Myb+I5vyl5Cp8crM1fyZhKGKgak
	Lsbeef85blFY6g17bQmzZg/uCWTPwilatE6Fcho0/JdXGmymPihEF7VFSGSPlPUNSJfQkjy2UZ4
	Bmsx6ml6vNTRvOquyK1MgH2TCMOFYOqCs56d2twmbl414CLiiLUD04GNtCPoycFWQbdCN3QsYSm
	ROlkY5pa8th2wReONHonZl65hQFLnn6JY50fg2fvgFBvixykYZg9PCnq2GyxtqH4zPu12UF+FFO
	UFulcoLrt4d6uWD0WgAYTRoaO9fjvf7j5IPQIKo4i8T+6GHiZn1u/nWHi4ygtnc37O55BL5Zbkh
	NToPaPss8uzxzx7L2zEk4C6UlYNi847J0ZTt34nNAPUTKwOSKSGTFE=
X-Received: by 2002:a17:906:c10f:b0:b86:fa17:4cf5 with SMTP id a640c23a62f3a-b9081994619mr406955466b.13.1771775575119;
        Sun, 22 Feb 2026 07:52:55 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f028a3sm235371666b.64.2026.02.22.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 07:52:54 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC v1 nf-next] netfilter: nf_flow_table_ip: Introduce nf_flow_vlan_push()
Date: Sun, 22 Feb 2026 16:52:51 +0100
Message-ID: <20260222155251.76886-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259884-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 339FD16F91E
X-Rspamd-Action: no action

With double vlan tagged packets in the fastpath, getting the error:

skb_vlan_push got skb with skb->data not at mac header (offset 18)

Introduce nf_flow_vlan_push, that can push the inner vlan in the
fastpath.

Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nf_flow_table_ip.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 3fdb10d9bf7f..e65c8148688e 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -544,6 +544,27 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
 	return 1;
 }
 
+static int nf_flow_vlan_push(struct sk_buff *skb, __be16 proto, u16 id)
+{
+	if (skb_vlan_tag_present(skb)) {
+		struct vlan_hdr *vhdr;
+
+		if (skb_cow_head(skb, VLAN_HLEN))
+			return -1;
+
+		__skb_push(skb, VLAN_HLEN);
+		skb_reset_network_header(skb);
+
+		vhdr = (struct vlan_hdr *)(skb->data);
+		vhdr->h_vlan_TCI = htons(id);
+		vhdr->h_vlan_encapsulated_proto = skb->protocol;
+		skb->protocol = proto;
+	} else {
+		__vlan_hwaccel_put_tag(skb, proto, id);
+	}
+	return 0;
+}
+
 static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
 {
 	int data_len = skb->len + sizeof(__be16);
@@ -738,8 +759,8 @@ static int nf_flow_encap_push(struct sk_buff *skb,
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
 		case htons(ETH_P_8021AD):
-			if (skb_vlan_push(skb, tuple->encap[i].proto,
-					  tuple->encap[i].id) < 0)
+			if (nf_flow_vlan_push(skb, tuple->encap[i].proto,
+					      tuple->encap[i].id) < 0)
 				return -1;
 			break;
 		case htons(ETH_P_PPP_SES):
-- 
2.53.0


