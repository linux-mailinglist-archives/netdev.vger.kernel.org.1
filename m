Return-Path: <netdev+bounces-178179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B31A753BB
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 01:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F41D1892700
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA18F77;
	Sat, 29 Mar 2025 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZVYP+6d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389636FBF
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743208434; cv=none; b=HVQg5ka2T9uATi6GrjLW7TNBZEPxBImhz2aRQK+TplxFUSN23Tbmc+u6Fola2SGAE9jnXxg3spMgKv2D1ACaGEBGsGxOr8xOHA2V1bZUwY/T/c/LGZzOHq9fnVgvCOt+QxDapjBhBHIPe7UPfZEX6OcMErTqSn8uu+A5cgDVkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743208434; c=relaxed/simple;
	bh=tBavXW3W1qYFgtjWZ4/Hxj/KCIDHiJNuqr1vC05iqss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SLaZ2roAWqCV/onm/KYY9T1T1p+ZO1OVof5RszjSqSA6rx4VIvlwQ/iWezboHnXS4jEBOeXGXCZq24x790hUNkPV02LEX46QFgODR2oSMmgxLGoRPptMk80DYQys+wg9mKThau1sltnZgpEgrb067kL3W5NhJ3AtG7aiq0gFVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZVYP+6d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743208432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Uo50sWXOSJizEdiktsorSdkq3F5t9pZ6OWVGuL0Oe+0=;
	b=BZVYP+6dfqh+Z9e/wtkPCjNllcs02D2nnqoRgaLJG4HFXXpkYwAJuvzfvn6+Gv9qMxTLre
	LPLmKDLXhrkVWH46/dDUrx1TzAibVKmrvNR0VbUu14PT90DVJXKDM1IBNNghsUqGp3moTA
	2bnrJpO2kWo18BeAJfsJiyJVK1vhxUA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-QKSX6yo0OGmf9APlusfrpA-1; Fri, 28 Mar 2025 20:33:50 -0400
X-MC-Unique: QKSX6yo0OGmf9APlusfrpA-1
X-Mimecast-MFC-AGG-ID: QKSX6yo0OGmf9APlusfrpA_1743208429
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so1094356f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 17:33:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743208429; x=1743813229;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uo50sWXOSJizEdiktsorSdkq3F5t9pZ6OWVGuL0Oe+0=;
        b=qsOhEU6Cs3Dqj3fSkICRFxUfqZzJ9P7TSmImOiuQWDpj1F5E0+RqufyRFJrTEAsHjA
         I7ufbyEKhVkD+QBjBmIwoEDCdoJSghMsRh4KgOarCmlpp7Xwcxfkp9j+IcW3dsjasbBM
         o2w77hfJcRrTyJwtB4X7JUrnh8BN4HMBc9IdWq2s1JEym2TCA3jONZKuLoAUlckr0jaN
         X6jNj9EWWoO5ue8Q+DxGxcKQolEnrQPctfNtx38Lnn5J7wWLLvt5LA7lh1YZkZ/7xt1S
         2AAy0mYFpdfUdEi1tRB/9438nBe5rgAurGsaPRwCpEdh4L6TcaSAlpIPAoC516Wc3nkj
         E6zw==
X-Gm-Message-State: AOJu0YxM8M6ItPRw2oaFYYqJNQNCM6F+s55WK45eizRwMEy8Onu9Aiqk
	Z/6tagoYfEqfsXINesWUkm7bfSVCdzwRC+2k+wV98l4SiSwZ7bw4eRKQ2wHejz5yddBdZVd12Wu
	cXwC5pfBRsTXboQ7no/ZvVWydUbL9k4XlFJFt1vO0dENf2jpgK4/5Dw==
X-Gm-Gg: ASbGnctpysDRmzxoVNdJRUTnwN0HEw3JwQovyW9XQY+mXi9RFeSygi3cPgTMlwMsH0L
	07PJVftz4s5A+tIXbi+Z0iegLLDV4o1Ii4lpfJctPsYGFkAm5wqmiq7a8fS+623HJUXgK875gLl
	+Y+8gDmWViQC/RNwkqeA42Q/oRTYm0JPWGdZtXN2BhrKp0CJjzxxzGKlA0CpI10BmHxLZBmrxZw
	XCkZTTR7Tx2P+0RaykvBdhdfpeU1ZmvuDcZtWTzSEHY+nL/c0uG72iRzyTbFHV38gsF9B53xvUQ
	nsvPXE0XByTPlzjo+Sy5lwjk6C+/O6h7tqPxrWOXose/NJxYtNUECfvbzWB5HDsg4ux0tmI=
X-Received: by 2002:a05:6000:1fae:b0:39a:c9fe:f43a with SMTP id ffacd0b85a97d-39c120ca348mr911481f8f.2.1743208429239;
        Fri, 28 Mar 2025 17:33:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEoY9JbUavhjPVwsV5uKDRdhp3q4Y8sqD9sGbiMsTNPWLrcQVtAamGoqCTLyJQPWwQ/fLY7g==
X-Received: by 2002:a05:6000:1fae:b0:39a:c9fe:f43a with SMTP id ffacd0b85a97d-39c120ca348mr911459f8f.2.1743208428731;
        Fri, 28 Mar 2025 17:33:48 -0700 (PDT)
Received: from debian (2a01cb058d23d600d0487be0e698eb88.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:d048:7be0:e698:eb88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6627bfsm4047261f8f.25.2025.03.28.17.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 17:33:47 -0700 (PDT)
Date: Sat, 29 Mar 2025 01:33:44 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>, Pravin B Shelar <pshelar@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Stefano Brivio <sbrivio@redhat.com>, dev@openvswitch.org
Subject: [PATCH net] tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu().
Message-ID: <eac941652b86fddf8909df9b3bf0d97bc9444793.1743208264.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Because skb_tunnel_check_pmtu() doesn't handle PACKET_HOST packets,
commit 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper
pmtud support.") forced skb->pkt_type to PACKET_OUTGOING for
openvswitch packets that are sent using the OVS_ACTION_ATTR_OUTPUT
action. This allowed such packets to invoke the
iptunnel_pmtud_check_icmp() or iptunnel_pmtud_check_icmpv6() helpers
and thus trigger PMTU update on the input device.

However, this also broke other parts of PMTU discovery. Since these
packets don't have the PACKET_HOST type anymore, they won't trigger the
sending of ICMP Fragmentation Needed or Packet Too Big messages to
remote hosts when oversized (see the skb_in->pkt_type condition in
__icmp_send() for example).

These two skb->pkt_type checks are therefore incompatible as one
requires skb->pkt_type to be PACKET_HOST, while the other requires it
to be anything but PACKET_HOST.

It makes sense to not trigger ICMP messages for non-PACKET_HOST packets
as these messages should be generated only for incoming l2-unicast
packets. However there doesn't seem to be any reason for
skb_tunnel_check_pmtu() to ignore PACKET_HOST packets.

Allow both cases to work by allowing skb_tunnel_check_pmtu() to work on
PACKET_HOST packets and not overriding skb->pkt_type in openvswitch
anymore.

Fixes: 30a92c9e3d6b ("openvswitch: Set the skbuff pkt_type for proper pmtud support.")
Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv4/ip_tunnel_core.c | 2 +-
 net/openvswitch/actions.c | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index a3676155be78..364ea798511e 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -416,7 +416,7 @@ int skb_tunnel_check_pmtu(struct sk_buff *skb, struct dst_entry *encap_dst,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (!reply || skb->pkt_type == PACKET_HOST)
+	if (!reply)
 		return 0;
 
 	if (skb->protocol == htons(ETH_P_IP))
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 704c858cf209..61fea7baae5d 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -947,12 +947,6 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
-		/* Need to set the pkt_type to involve the routing layer.  The
-		 * packet movement through the OVS datapath doesn't generally
-		 * use routing, but this is needed for tunnel cases.
-		 */
-		skb->pkt_type = PACKET_OUTGOING;
-
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.39.2


