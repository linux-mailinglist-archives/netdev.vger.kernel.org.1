Return-Path: <netdev+bounces-304454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oYGVCQN6R2rQYwAAu9opvQ
	(envelope-from <netdev+bounces-304454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:59:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 213D67005E5
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:59:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fkr5j0Jw;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304454-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-304454-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 691DB30AE0D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C77376BF4;
	Fri,  3 Jul 2026 08:43:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17B376A1C
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:43:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068208; cv=none; b=ABgXGUeJULYZ51k1HbBNsrFf6K6IWqm/JWWPssOLJs8qLbsD8M4VrgNUREbgDI0ymE+ctFgn/jkkBFYLqz9wqbG9PdcjP/uXHMj/pxCpGgHtNlZa2BaMPO+4RUTR1I0Ivc4CkuYAdhuRrJ5uy+CezRPPEIEmBdhSU6eszalSXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068208; c=relaxed/simple;
	bh=vHupzGcfiJvpM/I9iEn7dBod4dqnm3lOVYkDwrDCc3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GyMmEDFNtnA+PTE4siGdzYErErQrVECuT0zw6IaHy6fFyZLsFut8UIPj6rVfoJkFHdWPbYBoGGPe3/B2ZvzZ1W8SLcsr1maXT7pAKviREsbbinvzynXsqPTQgEazMwSIvlzc5uvTFhHklQydLWpsLDDmkDj46x2Kckj0ZO2+fIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkr5j0Jw; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c9ed0c7fc7so4441785ad.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783068206; x=1783673006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VXURkCEYViaWPT/JzQ/mNL6thE51vnZMEoFTaUOdy0=;
        b=fkr5j0Jw4bAqLFQ4oevXfjtRffjV6JhbCix3WnFQgM33EtEgcMZzg6pAnUWnLf7gqV
         MggvdpzAf8lBHCzSCB/Vvh1fcuJdXigTJnPTXsL0CQFURfcHsmrTK8gMEMpblyKwLDX6
         T3nhFN4SJj3ycetVejclRtK2oph54cmMsuYyQ8LhGsZBzoGcooLUq41OG0GKNt866Lak
         gO8ep66BOTxZ4semVOTvob7COkPYxG8o8A84wB5OlGA5iA7if+bEn7l0Ka0OcwGabVuI
         3iX/LW5FLPCd4+n8iBayLTuREBaq4d2LwapdVEBNHkr+TqaYjZ28xcGnNnO75l4Xl1cY
         Rzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068206; x=1783673006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VXURkCEYViaWPT/JzQ/mNL6thE51vnZMEoFTaUOdy0=;
        b=Y2HdYVudW+t6bDeh7vLkwZqBybGohbdPvUVSifxDXKJ2RDtGxzVPGuCrykNEQUWApt
         hhegJBaU0svT1VqjG1Vv8XdxpziHTBvN8fmK/+jW0aAT4g+NWMiUERk/8d+G5D0GA6wY
         VVj9oaBZHbpaYdj7Ld92jAW11roWICuQ3or83lYBM/r63Ms0mcK0qDO2TtXb/vvcgGaB
         yTzKv02jliUe5rRhJwI2J/RT0zypGCWOjunapUcB4cjj1oGJ4OUayQEdasDjQYFT+qIz
         y+vrPiyiesxErgH3Of949gvI5aMoREmomb9xPI37PkRYNxNH0XAWstBGb79ZadVZBaqt
         85nA==
X-Forwarded-Encrypted: i=1; AHgh+RpmJDz1qFNPz2nYEaIBmamB+l+6oBQLZR6gsMfgc9blT24qvFs41Hk/m/UwLWRcaEV4YQ4pDRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp541DQ/d9qZxJt4EIktmW9IH/CottSVDLytFnUVXvB0ACaGos
	DY45+03pF7Bo7TwW30GS42iFIgAj6U3TcBxnX5a54tyga7nUBEHINgKR
X-Gm-Gg: AfdE7cnVtqSDNmjTmhJsyyN4/eSop/n4cdzSND+TC9D9lf1u35E6zcVVQ5kUDhyE5DJ
	BiOtPiAtiLQj4xXWt2PZdL0kGT2ncZfMyC3c1JgSy8bE7DIxPn/m7Ab9ZZOXQlPbjBispzeCPVr
	gDd2O9XhHfBF95LNRO0W4GmtRpzMx+aGtGWnl6WJwDolRL+P0aCvfB9UvCp8H7ao1ZE8MxqAF5S
	VFHNZHiuqfxvfLWtDNP6NWRz4NljI/xu0neq97WIJ8vv8N4W+eogoKqKwdzSHo2iqSnWOXTKgVB
	OHouHBj9IsSSZakTjaMdNcH8z2xmJyaMVTYxgfTMd+/8eVp4bVOLEtM1XP3apPjOqKoxc55Kz54
	ZWY2iTUfbIej2cflLSO835cRLZ1+TJGOp+ONT6YUtqwT2tfXuB9iub+HZ6SvNSk8JETMlBoUtEw
	PzilrNkPsZqOWdQWoEYsD1
X-Received: by 2002:a17:902:f684:b0:2be:1c3c:72ba with SMTP id d9443c01a7336-2ca7e8728f5mr102068555ad.32.1783068206275;
        Fri, 03 Jul 2026 01:43:26 -0700 (PDT)
Received: from c79ofce.localdomain ([204.3.140.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad71270e5sm6115575ad.23.2026.07.03.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:43:25 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net] gtp: parse extension headers before reading inner protocol
Date: Fri,  3 Jul 2026 16:42:44 +0800
Message-Id: <20260703084244.59077-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.osmocom.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:laforge@gnumonks.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:osmocom-net-gprs@lists.osmocom.org,m:netdev@vger.kernel.org,m:running910@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304454-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[running910@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gtp_nsroot_recv.py:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 213D67005E5

GTPv1-U packets may carry a chain of extension headers before the inner
IP packet. The receive path already parses and skips these extension
headers, but it currently reads the inner protocol before doing so.

As a result, the first extension header byte is interpreted as the inner
IP version. Packets with extension headers are then dropped before PDP
lookup.

Parse the extension header chain before calling gtp_inner_proto(), so the
inner protocol is read from the actual inner IP header.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

I noticed this while running a few GTP tunnel tests with a veth pair and a
peer network namespace.

The commands below only set up a small GTPv1-U demo and verify that the
plain tunnel works as expected:

  ip link add vroot type veth peer name vpeer
  ip a a 172.0.0.1/24 dev vroot
  ip link set vroot up
  ip a a 172.99.0.1/32 dev lo
  gtp-link add gtp0 ip 172.0.0.1 &
  gtp-tunnel add gtp0 v1 200 100 172.99.0.2 172.0.0.2
  ip r a 172.99.0.2/32 dev gtp0
  ip link set gtp0 mtu 1500

  ip netns add nspeer
  ip link set vpeer netns nspeer
  ip netns exec nspeer ip a a 172.0.0.2/24 dev vpeer
  ip netns exec nspeer ip link set vpeer up
  ip netns exec nspeer ip a a 172.99.0.2/32 dev lo
  ip netns exec nspeer ip link set lo up

  ip netns exec nspeer gtp-link add gtp1 ip 172.0.0.2 &
  ip netns exec nspeer gtp-tunnel add gtp1 v1 100 200 172.99.0.1 172.0.0.1
  ip netns exec nspeer ip r a 172.99.0.1/32 dev gtp1
  ip netns exec nspeer ip link set gtp1 mtu 1500

With this setup, plain traffic between 172.99.0.1 and 172.99.0.2 goes
through the GTP tunnel.

After that, I used a small sender in the peer namespace to build two
UDP/2152 packets for the root namespace GTP endpoint. Both packets use TEID
200 and carry an inner UDP packet from 172.99.0.2:12345 to
172.99.0.1:9999. The first packet is a plain GTPv1-U T-PDU. The second
packet carries the same inner UDP packet after a GTP extension header.

Before this fix, a receiver bound to 172.99.0.1:9999 only receives the
plain packet:

  root@vm:/# python gtp_nsroot_recv.py
  listening on 172.99.0.1:9999
  received #1 from ('172.99.0.2', 12345): b'plain'

After this fix, it receives both packets:

  root@vm:/# python gtp_nsroot_recv.py
  listening on 172.99.0.1:9999
  received #1 from ('172.99.0.2', 12345): b'plain'
  received #2 from ('172.99.0.2', 12345): b'extension'

---
 drivers/net/gtp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index a60ef32b35b8..4a8b00548673 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -826,6 +826,10 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (!pskb_may_pull(skb, hdrlen))
 		return -1;
 
+	if (gtp1->flags & GTP1_F_EXTHDR &&
+	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
+		return -1;
+
 	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
 		netdev_dbg(gtp->dev, "GTP packet does not encapsulate an IP packet\n");
 		return -1;
@@ -840,10 +844,6 @@ static int gtp1u_udp_encap_recv(struct gtp_dev *gtp, struct sk_buff *skb)
 		return 1;
 	}
 
-	if (gtp1->flags & GTP1_F_EXTHDR &&
-	    gtp_parse_exthdrs(skb, &hdrlen) < 0)
-		return -1;
-
 	return gtp_rx(pctx, skb, hdrlen, gtp->role, inner_proto);
 }
 
-- 
2.34.1


