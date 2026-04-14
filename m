Return-Path: <netdev+bounces-278393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +N3kFy4d3mk1ngkAu9opvQ
	(envelope-from <netdev+bounces-278393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C3E3F8FCE
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20533083FE8
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497A63D6691;
	Tue, 14 Apr 2026 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7iBFd94"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE673D564B
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163752; cv=none; b=mOjWoG8J3UyIFLUZcDEZLhLmsDn3R9K7aIOh0/j2NBrI3qb2f8rYSx+JA6EABhi3oQ2yROFx4PRQk8RpZQ8bDENzQpN6OdZrUOOIY3tgbn5m6ZvIoPhfYNe7oiGjjQ4W8NMoIDEYC4c7f3cgt+gjZ7qmfqUMA+foJedeiR+sfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163752; c=relaxed/simple;
	bh=ii6RV1ygzwacH0zsmbOvUdY7N1HLtKusBUxFfTTs880=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXi1ihApNMxVjSccPJOFAwdRsrnlqLREDPyQbKzT17ChgmCR/AIWxFnjwc6x9ZW7y/QD0SCO/BH/6tW3o0QCsgFp01Fzh9XcDj+aR82BznnSdCf0u9x/p+75sKdDsXQmKpnWxHEClNiM6Q4NQuuJDdKk6WwTGOLLgRZpzUymbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7iBFd94; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c76af7b0f94so3700292a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163749; x=1776768549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdNNcNCom14+hME7vkl9Ojg8yeM3zI8TCPW0A6x3yd0=;
        b=d7iBFd94OtA2PzD9vTFRILEHBlV/R1ybwhL84mjC1XMApTIkreP5T/mCDAELWdEBFh
         ZYyT+6f16P3f9qJLrBiFVWYWoL7yjGJXMHV8odKotPllfdbWFhaaxnG82AxqHl6pdD7I
         pwbMg2zxHyJYtTLKXOqLd8FSNZEhZm2473tPRvG89BLFPva+LOWUdiyZ0Zml/ffoCEcZ
         aui90YfrvYLQ4UzT//BvGbLS7xzAz3ljGKu5B/J7srUoAHjf0nv2bUkLz6qJh0qauyHt
         w0XtadPNTh9F10XanRnwVySwUsaanDue4CB5YDbBPGQKPtAX9thEahPs8+fOvsSclxMg
         rjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163749; x=1776768549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdNNcNCom14+hME7vkl9Ojg8yeM3zI8TCPW0A6x3yd0=;
        b=rFxqrNV6LNegp8s+P7OaRk9LZKL+ShCvw1iy6y84nKL3seQjzrq9Mix4GZApF36fuQ
         a4AmnETT9GBJgd5W+QxVOErDy3t1zJX2tIgZEN04u1rUij8mgCBQ2Yvmq3I1FoeMqX2/
         v5llnrxcghGEwa2GXwSeUTtdJ39pkMT4/4kXgfWVws2Ihu/4EStiIlefLVg1bIrETdWw
         V1l53dS5tX8irE6bZy8ERQyqB1vrLAFadWCtbstB3MaKRpJarp9j5vFNGZABF0DA+ocL
         ehRM1DfRSw0VKSOkeSnhIwDtTODLO2uGchloRmfcgwWGXnhTOJJtBIg33+4PAFu4fq8F
         Yt6w==
X-Forwarded-Encrypted: i=1; AFNElJ+o1kHmvSvaDUgCeRYuDhJ0lyAkKgmNDrscst4bs7wBdi4Sme5Qy2dwGYDJZaFdIg9/UJ4pk3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw6Tdm6ORnz0lUrlunjkNWIKl/Eed6QKcWKPnHP9eRoAwpn3/P
	WH7REENfjSBUqvHGAUeX65iWIVYAtZBkoxOWMI6SeTvkUV/tTqpgwLNb
X-Gm-Gg: AeBDietHAxtTm/nfmvtgjJ0lLTZCzLs5pgyjRpVf3K/SWqXXfd4GJ9KFQudfMBF650W
	o8GQTs2JfkNBY2PS3ce2B6BVfXqU9Gpl/UNjzNL9uGIjBzjrO/TN5N7ENMtuS8Qqil3Vp/2pCrZ
	Vj2F/mL9C3yCQgEqv7JaHf+G8mQCBhtIkeiAcD6uuLwqZZW+UVrkLfBghj9g8yFLjrjdnwHWPTv
	Ou/o8IMVALpwtT2UgOO2GYHQf8/yxRH3NSkK8JsJd8peQ+73Pn63p22Sodsy1bcJ1ZwY9zZU8cN
	5cXnQjHqCfcXpcDI0tehk7ax2ZxSiSUakEzQEv1/xYZaC0E4gPCC9DsngPXC4G+vCXsOc37Dbeh
	qRlqP+ADLF52RqFOH1laK5wjW0sNlYKdgKakdJLtrz7Gktyo9+Fez8pFB6PZ3a7di6F56ctLJc8
	nvCAdzmbVX6WKOo4ARP/CLJ+a1YR+LPex8
X-Received: by 2002:a05:6a00:bd85:b0:82c:9c90:54cf with SMTP id d2e1a72fcca58-82f0c2c3c43mr16170482b3a.43.1776163748735;
        Tue, 14 Apr 2026 03:49:08 -0700 (PDT)
Received: from localhost.localdomain ([180.167.178.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm14570388b3a.7.2026.04.14.03.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:49:08 -0700 (PDT)
From: "Kito Xu (veritas501)" <hxzene@gmail.com>
To: pablo@netfilter.org
Cc: coreteam@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	ffmancera@riseup.net,
	fw@strlen.de,
	horms@kernel.org,
	hxzene@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	phil@nwl.cc
Subject: [PATCH v2] netfilter: nfnetlink_osf: fix null-ptr-deref in nf_osf_ttl
Date: Tue, 14 Apr 2026 18:49:00 +0800
Message-ID: <20260414104900.2617863-1-hxzene@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414074556.2512750-1-hxzene@gmail.com>
References: <20260414074556.2512750-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278393-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,davemloft.net,google.com,riseup.net,strlen.de,kernel.org,gmail.com,vger.kernel.org,redhat.com,nwl.cc];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[hxzene@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2C3E3F8FCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nf_osf_ttl() calls __in_dev_get_rcu(skb->dev) and passes the result
to in_dev_for_each_ifa_rcu() without checking for NULL. When the
receiving device has no IPv4 configuration (ip_ptr is NULL),
__in_dev_get_rcu() returns NULL and in_dev_for_each_ifa_rcu()
dereferences it unconditionally, causing a kernel crash.

This can happen when a packet arrives on a device that has had its
IPv4 configuration removed (e.g., MTU set below IPV4_MIN_MTU causing
inetdev_destroy) or on a device that was never assigned an IPv4
address, while an xt_osf or nft_osf rule with TTL_LESS mode is
active and the packet TTL exceeds the fingerprint TTL.

Add a NULL check for in_dev before using it. When in_dev is NULL,
return 0 (no match) since source-address locality cannot be
determined without IPv4 addresses on the device.

KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
RIP: 0010:nf_osf_match_one+0x204/0xa70
Call Trace:
 <IRQ>
 nf_osf_match+0x2f8/0x780
 xt_osf_match_packet+0x11c/0x1f0
 ipt_do_table+0x7fe/0x12b0
 nf_hook_slow+0xac/0x1e0
 ip_rcv+0x123/0x370
 __netif_receive_skb_one_core+0x166/0x1b0
 process_backlog+0x197/0x590
 __napi_poll+0xa1/0x540
 net_rx_action+0x401/0xd80
 handle_softirqs+0x19f/0x610
 </IRQ>

Fixes: a218dc82f0b5 ("netfilter: nft_osf: Add ttl option support")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Kito Xu (veritas501) <hxzene@gmail.com>
---
 net/netfilter/nfnetlink_osf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index d64ce21c7b55..dd2cbbd449e7 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -36,6 +36,9 @@ static inline int nf_osf_ttl(const struct sk_buff *skb,
 	const struct in_ifaddr *ifa;
 	int ret = 0;
 
+	if (!in_dev)
+		return 0;
+
 	if (ttl_check == NF_OSF_TTL_TRUE)
 		return ip->ttl == f_ttl;
 	if (ttl_check == NF_OSF_TTL_NOCHECK)
-- 
2.43.0


