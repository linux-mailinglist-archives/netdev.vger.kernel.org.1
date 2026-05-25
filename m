Return-Path: <netdev+bounces-291448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKtaLgKtFGpbPQcAu9opvQ
	(envelope-from <netdev+bounces-291448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:11:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A44935CE390
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 22:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1D2F30078B3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C78E39478F;
	Mon, 25 May 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+O0xYY/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80469146588
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779739903; cv=none; b=Li97yxOUwGeCYlvMdCdxp5ixa2PgACLCE7hXHypYhMppHdX1rfbH44TYzxLXAlhGn6ajoUDrlvHy7iJWnX5wCVKATu27WyQnryZQXh2kh5jLNlMvCwxr14aF0N9S89cvIMozw3Km3TvEsZteiGUXv1/ltiSRKg4i3lnayMXi93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779739903; c=relaxed/simple;
	bh=iPocNdP11IWJ84RYgMwB6ikmsitLUIqeZWoQumVliOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZ2bn4ZPj29Sbr/jqJ2+CC0oj6o7pXB3uffnGpZmNilVFwzSqyk6IUCIVRnxnbkB+ncgnjC+2ZsS/HjUaDBugXZRHxQaz/g1nr7HC4uit0CEM9JgRs+GBpH2MvQmbVBMgZk3P7uiDAP0Dd68UzX1D1ZdoAkMuuwVguiVp3kVbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+O0xYY/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso61453185e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779739900; x=1780344700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9LV2RF28IqA2a7V3wy5JIzlW5lVMgYSXDFk9zTWJsOk=;
        b=R+O0xYY/juqjTUygtm8Yinnir6cnO/VKNSlOMRnlzX3BtHcCzZNcMLtvNjEp4pC7dq
         Cjg4zBbHgyPln8AQO8zs6/9pPSO+dTieFG5OghW/10wImDswnKuzJODhx3Y+SCCtJREQ
         T0wzWyOqjK9iedmENI088h9JVGEzXI6NkKyJ3Q1KWCQ/W+yHkbuOCqexJIhoXoRiLAqr
         HGiEIwJyYe8veI6tUpXm6M7Rz7Uw5MAFKTXdQ1qjYtRarROy0PtdtlO+8qW9g8KCxOWv
         LAZTkDrPi3etxAvU50eE2L4Vy3+e73EOsXH+VHB75oaFtmR0P1xnO/RGHQ65Z0iMyTjA
         K7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779739900; x=1780344700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9LV2RF28IqA2a7V3wy5JIzlW5lVMgYSXDFk9zTWJsOk=;
        b=iaDAOFeOjBlcwZU5ZpZozSyb0qIslg4v93Ch/aspO1uKGgYKw4UClbF70O+2Eu6EaY
         8/EdgIcu1ogKpwN+4x/BhUe1JtqHUnGnTRo3L+u9ii9AxDBzXQV0wcS+LGajJlGrfByj
         EiygcIA2qTqGPAVHCjxbErjq8hK5JX6vudeI34DBDhkxaUZpyd6+HGvfyG4gFM5IUEGd
         3LvWE3wVZIshpZFTg1zoLNcOh7GBSxHBjsxWjFME4Mm+yQUIjDGKBg0+F+WjzV5XO2Ay
         J5/z0EjtNWwJ1nrVVIuJkPGKxtywNJkJyO4BB9hnUghXGT/LVauFGY2OstCMNQ60+O4i
         NLow==
X-Forwarded-Encrypted: i=1; AFNElJ+IWG5YXd4XKZDr2Uy1I64uO1pto7Ao1RZsOLcdbpW3pN55tZuql59L0ao5CFZv/45zg0gtf0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ1GqKlznExCrhxLonAZqnI5luyU6gjAqjYrn9koxWK+297/2e
	seQvocEfU/S+gp9wyiSkW8P3cRPI6pfphhu6VAHjq3GZxkiAIXWAoXcr
X-Gm-Gg: Acq92OHiUF6yXpo9wlUGX+fdu7OFP2pqyBLG/HCE1tlL3wwrHFfKRcheuIUPxtagdWt
	pe4eFhmUA+TsLQmAPTzqxH2Y3e8kjdXNzODGZRjSD7+o8SRpHVN5f2DXSyWMNbWecMsYqTabrWC
	zu/dYw2M8uxI58svkN9XQ/ACb42ZCHuQwkV0IgtVRMdvmCx8hU+uJZa4en3NJHIbZ8H8lmUaXw/
	xFb3nulgj14ZvT3Rml+jHOW+LT3Ze0z0u7cq4H46249erkpce9J9TfzV3/OvRzyOXKxZUIwX5Ux
	r+qVPUDy0gDZ18FLr2wEmb/eaON1VY3F4TXym3645ajqqoyZhOVbxMN9kl4Y+0WPfULKQzG1yYa
	LDV9ZZsv1g/5xMhjR7TsPJDBrZwJJxg2urUWj0GrrdIjgD3gF+fL7PL43X7l95/6LUyYhOc3iK7
	3CIIEWLunKXU+xXmquthQiUP2hpOHfpm/OzKxEh/WJEs+qM7pvqG3ba1Pl6q0NpsdcDVc6xW1I8
	BIua0LaBaAFFsqK6ZthQYk8hvK/ZCwFi/hg6PROUDE=
X-Received: by 2002:a05:600c:4688:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-49042ae99afmr256122915e9.33.1779739899702;
        Mon, 25 May 2026 13:11:39 -0700 (PDT)
Received: from britney-pc.tail2180da.ts.net (host217-46-89-96.range217-46.btcentralplus.com. [217.46.89.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49059cc9a91sm52673055e9.1.2026.05.25.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:11:39 -0700 (PDT)
From: Kacper Kokot <kacper.kokot.44@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Kacper Kokot <kacper.kokot.44@gmail.com>
Subject: [PATCH] netfilter: TCPMSS: fix dropped packets when MSS option is unaligned
Date: Mon, 25 May 2026 21:11:16 +0100
Message-ID: <20260525201116.407338-2-kacper.kokot.44@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291448-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kacperkokot44@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A44935CE390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Padding TCP options with NOPs is optional, so it is legal to send an
MSS option that is not aligned to a word boundary and therefore not
aligned for checksum calculation. The current TCPMSS target is not
robust to this: when the MSS option is unaligned it produces an
invalid checksum, and the packet is dropped.

When the changed word is not aligned, the modified bytes straddle two
checksum words, and using the standard incremental update helper
(which assumes alignment) produces an invalid checksum:

    | w1     | w2     |
OLD |  a  b  |  c  d  |
NEW |  a  b' |  c' d  |

Since b' and c' sit across w1 and w2, we could compute the incremental
checksum in two operations by recalculating w1 and then w2:

    C' = C - w1 + w1' - w2 + w2'

But working it out:

    C' = C - w1 - w2 + w1' + w2'
       = C - (a * 2^8 + b)  - (c * 2^8 + d)
           + (a * 2^8 + b') + (c' * 2^8 + d)
       = C + 2^8 * (a - a + c' - c) + (b' - b + d - d)
       = C + 2^8 * (c' - c) + (b' - b)
       = C - (2^8 * c + b) + (2^8 * c' + b')

So an unaligned incremental checksum can be done in a single operation
by byteswapping the changed bytes before passing them to the helper.
This patch implements that trick for unaligned MSS option updates.

Signed-off-by: Kacper Kokot <kacper.kokot.44@gmail.com>
---
Reproduction script

  #!/usr/bin/env python3
  import argparse
  from scapy.all import *
  
  parser = argparse.ArgumentParser()
  parser.add_argument("target_ip")
  parser.add_argument("target_port", type=int)
  args = parser.parse_args()
  
  def try_handshake(options):
    sport = RandShort()
    ip = IP(dst=args.target_ip)
  
    syn = TCP(
      sport=sport,
      dport=args.target_port,
      flags="S",
      seq=1000,
      options=options
    )
  
    synack = sr1(ip/syn, timeout=2)
  
    print("SYNACK", synack)
    if synack and synack.haslayer(TCP) and synack[TCP].flags == 0x12:
      ack = TCP(
          sport=sport,
          dport=args.target_port,
          flags="R",
          seq=syn.seq + 1,
          ack=synack.seq + 1,
      )
  
      send(ip/ack)
      print("SYN-ACK received")
    else:
      print("No SYN-ACK received")
  
  print("\n>>> MSS Aligned")
  try_handshake([
      ('MSS', 1460),
      ("NOP", None),
      ("NOP", None),
      ('SAckOK', b''),
      ('Timestamp', (12345, 0)),
      ('WScale', 7)
  ])
  
  print("\n>>> MSS Misaligned")
  try_handshake([
      ("NOP", None),
      ('MSS', 1460),
      ("NOP", None),
      ('SAckOK', b''),
      ('Timestamp', (12345, 0)),
      ('WScale', 7)
  ])

A script to reproduce:

  #!/usr/bin/env python3
  import argparse
  from scapy.all import *

  parser = argparse.ArgumentParser()
  parser.add_argument("target_ip")
  parser.add_argument("target_port", type=int)
  args = parser.parse_args()

  mss_aligned_tcp_options = [
      ('MSS', 1460),
      ("NOP", None),
      ("NOP", None),
      ('SAckOK', b''),
      ('Timestamp', (12345, 0)),
      ('WScale', 7)
  ]

  mss_misaligned_tcp_options = [
      ("NOP", None),
      ('MSS', 1460),
      ("NOP", None),
      ('SAckOK', b''),
      ('Timestamp', (12345, 0)),
      ('WScale', 7)
  ]

  def try_handshake(options):
    sport = RandShort()
    ip = IP(dst=args.target_ip)

    syn = TCP(
      sport=sport,
      dport=args.target_port,
      flags="S",
      seq=1000,
      options=options
    )

    synack = sr1(ip/syn, timeout=2)

    print("SYNACK", synack)

    if synack and synack.haslayer(TCP) and synack[TCP].flags == 0x12:
      ack = TCP(
          sport=sport,
          dport=args.target_port,
          flags="R",
          seq=syn.seq + 1,
          ack=synack.seq + 1,
      )

      send(ip/ack)
      print("SYN-ACK response")
    else:
      print("No SYN-ACK received")

  print("\n>>> MSS Aligned")
  try_handshake(mss_aligned_tcp_options)
  print("\n>>> MSS Misaligned")
  try_handshake(mss_misaligned_tcp_options)

 net/netfilter/xt_TCPMSS.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 80e1634bc51f..8e409858505d 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -117,6 +117,7 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
 		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
 			u_int16_t oldmss;
+			u16 csum_oldmss, csum_newmss;
 
 			oldmss = (opt[i+2] << 8) | opt[i+3];
 
@@ -130,8 +131,19 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 			opt[i+2] = (newmss & 0xff00) >> 8;
 			opt[i+3] = newmss & 0x00ff;
 
+			csum_oldmss = htons(oldmss);
+			csum_newmss = htons(newmss);
+
+			/* MSS may be unaligned; fix up the incremental checksum
+			 * to avoid an invalid checksum and a dropped packet.
+			 */
+			if (((char *)&opt[i + 2] - (char *)tcph) & 0x1 != 0) {
+				csum_oldmss = swab16(csum_oldmss);
+				csum_newmss = swab16(csum_newmss);
+			}
+
 			inet_proto_csum_replace2(&tcph->check, skb,
-						 htons(oldmss), htons(newmss),
+						 csum_oldmss, csum_newmss,
 						 false);
 			return 0;
 		}
-- 
2.43.0


