Return-Path: <netdev+bounces-261915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP9BG+/GoWkVwQQAu9opvQ
	(envelope-from <netdev+bounces-261915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:31:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6781BAD20
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C791300B861
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A572D44CACC;
	Fri, 27 Feb 2026 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXPeikX4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D405736CE00
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209813; cv=none; b=TgudDxfGSHad6zAYwMD0tLWeaO/Jb7fp/d+Alg6Tcpma6BvsW659yiol9CFrrwfNgGpqw5+BysbeosuPhQ7W5+jvFp1PlXHlolD0l6nmqThxSY+4t1Naxj3ygUrEwwDak2e8oWyaSnb0vD7NE+N1F+7pxwnO0vMaN/sZlaO2bHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209813; c=relaxed/simple;
	bh=gRRzJAYut20vuX+uLpiXEe4mAnxSpcr+TglGWaXxAvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AgG2VOJDOUO/Vsc3EAZyW0YHRS2RMokh35lNhFH+TB8LYchZWZ1wzlj9icFXV8nXaUFBXZ3jnVr5wg4jNCc6W1KYhjKSeh4dgI1CHq6VPCFC2m6tFqwXu2Dhpjd62p4zdRzPgyIKqhcuWrygghaIEm1jTBrre/Ial9tYW/yzFZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXPeikX4; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65bf302471dso2607489a12.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772209807; x=1772814607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+l62BqL9NmRegeedzc1yCU+VeOAMH0TTIRf5fPEPPLc=;
        b=aXPeikX40VflgBP1DAiWyua+9n4XyyqmLqs+Ueqnty9fQJLNdw5jwl4cR5nuYeP8eM
         35zJz9Oeo1c6DWREO9eVZNrnvgmjH55i5axVNcq7Al1rmZw9Psr8YyOUUYc/DA923+5r
         4SZ783P/HKcsHAyOXUpdQOY3BEfA1VQfSKWZk54nKaF+gZ9H1nh4koI+Msco3iUB5+jD
         IKQ0nH42pH1PnsJIBIDnDxnD57DGzEZfPnQsdiZe8KbDcldA7+LiBcY1S3gIFzdv7QDc
         OcQ0ULI9rfH6y99fyGJvElaEKjsljhffrmpCv16sduwd731DDDvMhfqAAgh9yuro69IP
         z9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772209807; x=1772814607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+l62BqL9NmRegeedzc1yCU+VeOAMH0TTIRf5fPEPPLc=;
        b=RFGmoZcHNmL06uTz1Oq9OaYcNspwH4bNrBAAKZnnJsnJErBJpV/98CeXYNZuu+kqdb
         X/HZZsQqfbDrOJ9/9UtMVBH/r/DWGcMgS8gloC65Xgof80QhzHfILPdvQDT1N/OZ2tD0
         vq02u2FedjTqZSp4/JWEM0VNwtzvTELuh8xIkemw4gp66PvHHGg0UEMKPQtzQ9KjARzL
         06VxZO5Ni6iJZyqZmE042B1fuz33DmsXWe79vCM8XZf42O/Z9triGfvjHWaQUyEj3xUj
         SNQftqxGwq33SfH5jcOWJZUel//Ol8MXZLhPN8IylW1H/4u8kZdRgzFpa4W0O1ZLt28U
         0WzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAVf5foKjcRCDXFknCy84FOL6GrY+63OfvhW/E54SwUVtA5Fh3MQsdAfj8hS+PyHHNbswhWts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/H3KB8fxZOrZrAaaWdJWIQkxdUsY22S8H71H8HKWQB+0I0qFO
	qLfR26CzFGxGYJiF7fMaozpUVmHM6Yu/MM1c1q7PYjuLOhBcyD7oCUru
X-Gm-Gg: ATEYQzyBjYlrVxg9nH0/3mCfS6oN8PMbDeDV+kVwlF9krhKCrbrCa/ANw94acPpGfDJ
	f/9bnyBArYSKpcUVJ7wzJHw3rewmaZBRZZtudxf0iViBYJtlGM1end6+rBi8oQigj9P1YfeDnQ+
	oeJb8W2Noa358Fx97M2UPMnkPL+5DtThULYLs4yzP6p7m9Y5r8X2GllHFsOunK2G+j8ZNrBuXff
	/Vb4OgFS4VGiechn1SwPQ2BS3wtsbTIhQmvLdUSpQgHUe1vwcWi+zYt+bfOI/DMdCaQlNcvivRw
	C+a8lfBHiMA8DW5/Tw0NSb6GD9qRdiiwBE+o9tO5x+A1jYQLmBWKEloNrS6/TGWWAclIzVoxDFS
	zXX70FHIgPjPPSUa8uFxeybxxyTwOf8Qfuv/K96OpKf+aWEdKwmvkr7yG+MqjV1xnxLYeLHjfHv
	/8cMv2ONBjNrYqDFCkS5fpQ0mqeusipqIkis3ZhChJD/h5IdR7lj1q1EICJqZaoXBe6awgsSNMR
	RQBOrb+qhvfWm/sEOSVw/HeQ35g/SrFXh9P0fZ98PZDVj0zYsPHzEs=
X-Received: by 2002:a05:6402:2803:b0:65f:aecc:4f17 with SMTP id 4fb4d7f45d1cf-65fddaf6ce1mr1828410a12.21.1772209806611;
        Fri, 27 Feb 2026 08:30:06 -0800 (PST)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fac07c06csm1380458a12.33.2026.02.27.08.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:30:06 -0800 (PST)
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
Subject: [PATCH v2 nf] netfilter: nf_flow_table_ip: Introduce nf_flow_vlan_push()
Date: Fri, 27 Feb 2026 17:29:55 +0100
Message-ID: <20260227162955.122471-1-ericwouds@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-261915-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC6781BAD20
X-Rspamd-Action: no action

With double vlan tagged packets in the fastpath, getting the error:

skb_vlan_push got skb with skb->data not at mac header (offset 18)

Introduce nf_flow_vlan_push(), that can correctly push the inner vlan
in the fastpath. It is closedly modelled on existing nf_flow_pppoe_push()

Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

---

Changes in v2:

- Targetting nf.git
- Amended commit message

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


