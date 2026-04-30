Return-Path: <netdev+bounces-282913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INU/EZh482mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:43:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF2F4A5047
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77EE8302A2C9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28D2FE066;
	Thu, 30 Apr 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJJuuIUT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233D33C513
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563657; cv=none; b=DVJglCC6dLod7dQmQ5GRsnB/wibNyIYlSn82ccAZCMmzidS89+2dSoi9RPywwSl5/E6bccO/pnF1bxUkDNeDM3upPyIxjXdh5ImVn7659mI4vpPuaeVaGPjf8LL92nZwVQncKY7Ej5U8yvIFANWnJIAj5r3FLEx0FwMNVDu9Fkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563657; c=relaxed/simple;
	bh=z0DYBvb+LZUpxretZCjDv+k9yn01sF1apvq6+r/SDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rXFy08IjFnNuUEuw3qyPLR3oTD5tKf8wI8ltUtIU6mWDY/jyl8uka5ec+aGpWs49O86CZArA0+6G9kGYy7HQ5grGogWH4nEtQu0h8Wu5DfMnBWeRKzcFvQtakzCvWXMM08unF7DV5QCNN7W4fJNr+ymkP6763ZqufNECn4C6oX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJJuuIUT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488d2079582so11435975e9.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563654; x=1778168454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=dJJuuIUT+cTodLhKdLcHNOczbeJHwb0K63slp0RTXkUY6t3dlXd/UOl/jbx/yKOmRS
         fr1QjWcBacT3xIr+9W16NyM69ACtUunD3r3PfJceojrqmblCGmuPvntIahKhNValqesw
         tGO6QYp1LBiYOKvEsacq7ISgKs4JNYmafY7GeVHcrZvBVndeKq8CpAM2/ch4G3kqSFaF
         Xd2n/8XC1ZDKXKSj/VSD8sMVOx5ttAjYRrRCNNPZmhrJSl9PxYirKrDyAzWbFPzYNOqu
         D/rKls+pDfn+L8QcFO7bCYQ7FhvHxGKA9uytJZBu9VVeQ/QSMU63Dz9p0B2/vVGnxSr4
         q4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563654; x=1778168454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=kEWuUjEZNyiJ4FZnL7X07yZMHGoF7FtLdZ4pUGKL7xBzdWIPWf7Jjg04W0qgolld0w
         A+Kq2cCEyntjvd7nNqjwhS70cFGrwKWWoxtm7soKEd9WGdRDiYpbbUizDFvP7xQFejxw
         cdgFsRFv7iY2zPcVSlkMC/xLgWX2laBeUx8kuYEZ5ezWanaQMigLmAEswN4RnGUEX8RD
         LCQcRfY5N+2/fWzScuKG259AXGNc5RgU3c2229TxCEbFQVmrJjXz0ufW3obrDgDcAqVu
         NqiilOLIYU7RwvshgSoLEAJd1UQdssNE1MM9cH6gcftwPl3hJS/4DcZIFD4vhwiZHi/v
         dVwA==
X-Gm-Message-State: AOJu0Ywfcy8t65/xTQPkUa7CaH1YmuuVUC7fmj0Dk0CFZAKX8snE8B9J
	LsVKIZ9JBXdfR7U64mzNqVist6iwDJuQB7Sh7R5J2dZljiy1Y3a+dOvUYcn7egWMN8CPJQ==
X-Gm-Gg: AeBDievblAbC9Jm4FR8QpTkNGqslDqfcDgHetyW+PDUmNTuIzMnIvbbXAybgs3kwqMo
	etTJNXcVWPlIrii1UcKKEx2POnimZPON7tLYLUIZfj9tAQAid0+MGWpEXq8dVCjWFYDcyGvpdAS
	DTAdBSsz1DLKLqoyN//ywcRIVmtMx3JSDH6npDmW2NaRcvq6faYyf+JhZKOFkYsHkjBQkHbn2n1
	j0biimr2Bwjg+XWJ8H/U30WedvhzzZJ02Xe2g+FrA8UdLRnrUpAXLYZq4seKbDtnZ4WIRMEYy0A
	1TMhed3SyUDd8uNuFGoLqXdDfNzoTeQxVab3ZEsv03dI3D34TLGltXnoGSd5Y3yhmdtTjpWoqkb
	rZpAFtp4teL2tD51z36HgEfMiAFjzIIsMCnOFMrOpGHL5g8e8woW2tTIcWsevByRVwbkZFyqcqM
	ZJ9t57CgW1wik5qKkV/HwssqYLNbdxRPraG1xvrEau/BMXMlt/FqkL+IM9QYaCff7Fqp7XvmTYa
	8B25hNLo0vo7EaKMiN6myr2mTXJBO8bbp+TZg==
X-Received: by 2002:a05:600c:190f:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48a83d6ebe5mr57909705e9.8.1777563653525;
        Thu, 30 Apr 2026 08:40:53 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b901a15sm96960055e9.1.2026.04.30.08.40.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:40:53 -0700 (PDT)
From: Kai Zen <kai.aizen.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH net v3] net: rtnetlink: zero ifla_vf_broadcast to avoid stack infoleak in rtnl_fill_vfinfo
Date: Thu, 30 Apr 2026 18:40:44 +0300
Message-ID: <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
References: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCF2F4A5047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-282913-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

rtnl_fill_vfinfo() declares struct ifla_vf_broadcast on the stack
without initialisation:

	struct ifla_vf_broadcast vf_broadcast;

The struct contains a single fixed 32-byte field:

	/* include/uapi/linux/if_link.h */
	struct ifla_vf_broadcast {
		__u8 broadcast[32];
	};

The function then copies dev->broadcast into it using dev->addr_len
as the length:

	memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);

On Ethernet devices (the overwhelming majority of SR-IOV NICs)
dev->addr_len is 6, so only the first 6 bytes of broadcast[] are
written. The remaining 26 bytes retain whatever was previously on
the kernel stack. The full struct is then handed to userspace via:

	nla_put(skb, IFLA_VF_BROADCAST,
		sizeof(vf_broadcast), &vf_broadcast)

leaking up to 26 bytes of uninitialised kernel stack per VF per
RTM_GETLINK request, repeatable.

The other vf_* structs in the same function are explicitly zeroed
for exactly this reason - see the memset() calls for ivi,
vf_vlan_info, node_guid and port_guid a few lines above.
vf_broadcast was simply missed when it was added.

Reachability: any unprivileged local process can open AF_NETLINK /
NETLINK_ROUTE without capabilities and send RTM_GETLINK with an
IFLA_EXT_MASK attribute carrying RTEXT_FILTER_VF. The kernel walks
each VF and emits IFLA_VF_BROADCAST, leaking 26 bytes of stack per
VF per request. Stack residue at this call site can include return
addresses and transient sensitive data; KASAN with stack
instrumentation, or KMSAN, will flag the nla_put() when reproduced.

Zero the on-stack struct before the partial memcpy, matching the
existing pattern used for the other vf_* structs in the same
function.

Fixes: 75345f888f70 ("ipoib: show VF broadcast address")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Zen <kai.aizen.dev@gmail.com>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b613bb6e0..df042da42 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1572,6 +1572,7 @@ static noinline_for_stack int rtnl_fill_vfinfo(struct sk_buff *skb,
 		port_guid.vf = ivi.vf;
 
 	memcpy(vf_mac.mac, ivi.mac, sizeof(ivi.mac));
+	memset(&vf_broadcast, 0, sizeof(vf_broadcast));
 	memcpy(vf_broadcast.broadcast, dev->broadcast, dev->addr_len);
 	vf_vlan.vlan = ivi.vlan;
 	vf_vlan.qos = ivi.qos;
-- 
2.43.0


