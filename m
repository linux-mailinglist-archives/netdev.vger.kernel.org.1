Return-Path: <netdev+bounces-282917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBqPLD1782nc4QEAu9opvQ
	(envelope-from <netdev+bounces-282917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:54:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B54A5318
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BE9F3039DFD
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994CE331A76;
	Thu, 30 Apr 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkmxXSXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A533D4E9
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563711; cv=none; b=Mi4lI+1G3b+jopAWeKdm3HDfu+zeakxzdwcHHBhCtdntI9gnySqjoM2lrlEGqNaKQIJ+vUNthosCW4/H+O9v/HkQ7pe/vy5CkdpY2Bqz5kx4kLISMnTlA9r7fH4ybn9Fo01FyLAFTtko91oLn2NB15f1lJ8iWHzSsocPUoCx/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563711; c=relaxed/simple;
	bh=z0DYBvb+LZUpxretZCjDv+k9yn01sF1apvq6+r/SDyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZwsxbp59DeBRXRmgdPfrpbG88ClZg3B/QrChcKoxakU7vAzoOQBrhq7cQzIqy8MLr6zEo6RVohIQvvs7t5O3ycU1SLZ+JWaNySpIiEvXfxyJKItfTz8PgcRM1EHHpHQoyz8sk91ElGbxf+k+0VDsCF6cdaxAsnU6yrAWhsKh5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkmxXSXu; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f60944so769151f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777563708; x=1778168508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=TkmxXSXu+XYTyV11z+SNTS4rOiC4ZBzszwaHLhyZoTCWBlZXex94X8gXqiQImNqbWp
         UQ1yCdi4Nxf0PZS2YOFhu/mnH9bs3IjkKHzhOCMeXkMqKlq3Ekuhl+l/QRZWRpf1IMGK
         baUYLi4FwlrQ48MF943hGL5w+B1SWsmrILJtfVMp94y/UFNbFjgETcDwvDex+D19qR4i
         Cdc7CfguGOtgvg7D8STowTlJsfRo26wnq5R4q7B5cS4LeJ0gBZSznd3Giz3rweZBp2hM
         FYoJahpMvPI0aIazx1127YRN733Z0ZIGvoXtpt+XGJp2y0NaCmrhlj+VxY60Vte/4ygg
         fNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777563708; x=1778168508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1jOo4LrB4QdOIsyappS3L/Lh2AU+Kgh3i+w/0anQdk=;
        b=p/KmVHoqqKS0mYK5dTo6SU6evAv2AEwbrrlcr+xl43R1X5m/OEwUstguF2/c3gSFHQ
         KDaWgm5wZYlw8K6kR8cftglR1MJM1bS8hhvZuJxVPQ0dTjmtg6y8up1XzQgmOL4QWS1o
         dXNwYf4H9DP+WOrKG6njhdOmmGH4gHZIXN0A1JslHFOwIeC8vazz6wHzX+rvY15Y3DIr
         XgATdoS7IrC4fB43rb99Ac2rTYtwnvu/bjPIp7y2tTePGcpd58QK/2QoT1iuPFwdokxa
         lsPHtANe0kQuT5j/nWllRo8TbHDZCiPXDSszYFIpRUZNkdNmpbJGLGtxXl8VOZUkoiEV
         jHjA==
X-Gm-Message-State: AOJu0YzQMgX5ocFTpp19vD1A8PLdeQcHHLOygcnQpsl8LE06g/Itbvus
	AqRa1o7lPUmp7ng2r6EYcN9oS3ToImoEdokdKz1qjQitBhAUWCj0yA2o2OikIDC3p2gXSw==
X-Gm-Gg: AeBDiesj85Q3xjbSKealsgWh1tAo+BZDHpf6K8jrEksxY4CqRleqs+QaDzFXhhewZTd
	0PtO+4RHchMvoIWEa6/aouDAMOeqSgqPzSTWA1BPH6LIg2yvgW+Pka2ivmqWuV/DzOTmhIZ51ry
	jl0M91K4m+edcYgFWq4U/Y5StG26j8yEL9Aw4i9NoTThA1nEBn+k/rIsSlegIJH9UewEDePjXiW
	097SK7P6OlirzsntAaNlaQgaEoenGJkxjqInXFjwjRW6d5bDNzmvfwhTVUGCoj/7bxhdkEwSnlF
	AL/e+Vi/F5bpMwNXkYHFmjcH22rXzh9Y+kaoUOVbg0cxfMsrUZgo5iN/DRgPqeCywlIp/LJ4R5/
	FyNrVKEESzpa3Mtzmz2adQhlJEpuTK1sy/1U1kVscMpjpdKyKIIz0EOrmawKlJlBSWL5Y+2qABe
	1CeY16MNM6FMuD01hXc2pcYV++Yb2WOz1++loRWWK7Z6jN/p27witF+oAr/CbdUQja6ZKmw81A2
	b1EEx/38lXV68HeuhsU/cJjj3A9/Ok+dvXfyg==
X-Received: by 2002:a05:6000:184e:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-4493e5a7a64mr6025860f8f.22.1777563707827;
        Thu, 30 Apr 2026 08:41:47 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a0c9:1d35:8283:f96b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-449c576d0a2sm3596521f8f.31.2026.04.30.08.41.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Apr 2026 08:41:47 -0700 (PDT)
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
Date: Thu, 30 Apr 2026 18:41:35 +0300
Message-ID: <3c506e8f936e52b57620269b55c348af05d413a2.1777557228.git.kai.aizen.dev@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
References: <CALynFi54eQj7SOmF6QNG0eqhLw7AuURzo6tSYQavvM3ZP74ikw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D52B54A5318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-282917-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


