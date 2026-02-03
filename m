Return-Path: <netdev+bounces-256449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEKiGMBLgmnNRwMAu9opvQ
	(envelope-from <netdev+bounces-256449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:25:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6378DE252
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 20:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48CC3059F39
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 19:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275C533D6C6;
	Tue,  3 Feb 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHdH63yy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0E9223DC9
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770146722; cv=none; b=LkH5NJgZeXppYILc4ZqWzBrBuLZryLyRQ+rbgnccXNl0duvecdWSQKYrzRUQodtzHX8iTkD8rltks5TtAxFC2zwd6zCsVgPbdboqLxFv4pd+PdnH2UpEVE/9w/NI6ByEvEX0S6Zr73ZpqsjYsUayfYea8hizxqT+Tzoa4axQSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770146722; c=relaxed/simple;
	bh=hV6IpuTq60UsuNUK+hBdjF6e1GIpLkkKLoHUeCAxvqY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sTw/njI/nzvi7OUno9xjGV11wGwAXbv9jLs2KeEWlMrktf7WnLnNNSvovBefcMejMvIo7S6yUZJlYHJPnrN8vr9glhFEpmeqFnsQrbm6v8Tp87PtAUHg1wAqe9WIJTr685tUxWo4KUUg0GFmTkjjo/NL0dqJ2PcXWt9Hdpz4zWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHdH63yy; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c71500f274so617255385a.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 11:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770146719; x=1770751519; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PHDULDP+pMIpVfexc5OnAEgzV+j0zVE8B14qavBS8IQ=;
        b=xHdH63yy+PRociYqQfinb8KZGWKo+rhuMZubF/1tgeYqqw1GVIlZoMTlAHeJsbR2rl
         /YXFNl8/WFMCEm5mm3EpFGaTn1Nu6m+2KKH1maaZmOJiYeA8Sz1ePp69Ai56kkI6MU9B
         bu13iRLwFn4jwlFIWf4xAAmvBYQcmoSxM5Q1/R74KJ0NJZqv/CX52iYP23a9DDkw092B
         Nr4iKymlhqXl6OVrDioBetpSUAJH0ZkJguDgDXTkJ732g5inUQxyLf8g8bkAJP5aWquf
         zhOgSPfSXWOlnYVcUPrLUej1lb9BG8xUn0fIbGQs4uaTdZVw/vDKUjGJddweGtH5Z+w7
         YEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770146719; x=1770751519;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHDULDP+pMIpVfexc5OnAEgzV+j0zVE8B14qavBS8IQ=;
        b=ad7HsRqmoLj7Mc5M4qs3614w065Yo/qVd8fNV3tOiBoGYx40bi6RE0LJfkvEAB3khg
         HezcbQXvnqKVnO3+BVq59jPr2+CYw4nCkNNdow/OfVaYkQuf8CT3OviW7YDfgQ1tbDJi
         Ow80fzd7xc+hAOT+5q95K2kEmSxsAI3+gcjr5qpTIy6W1WTHasKHEKMODBUlilqbddYL
         4WH2w0nqXgsaX8yU/dYtoOJyXoKymHtf2txoMvUu2yFR9/GG1U/JZYhb9UxmhrSXDZUd
         vOiT31kT3o6aBVyZnfhS0iEPIDm5BQKQURs66z3byaOaVGouoD2uOkjB12KiSOWv9a3Y
         kJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCX7kE7P0XgHlyaolTvb3Y0DowbUpBf8f6eMVGkFbk4TIqjMQOXRoesHZWfyzKLjkoHzYOwV2HA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQWUxngmrfIQsaOWe3+z8K9ILnmUdd4gyMr7sJfj5Sw3Vkfh35
	TrfjiQghTLbegcxpUwT3ve+SuhcQkwBKwPP5QFAGlw1JOxeaJmo0zb64zgqXCVSs012TeFol0sn
	SKRwyI70YjLs1QQ==
X-Received: from qkss10.prod.google.com ([2002:a05:620a:80a:b0:8b7:652:aeec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:bc2:b0:8c5:3881:da8b with SMTP id af79cd13be357-8ca2f9ce8d0mr86452285a.59.1770146719197;
 Tue, 03 Feb 2026 11:25:19 -0800 (PST)
Date: Tue,  3 Feb 2026 19:25:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203192509.682208-1-edumazet@google.com>
Subject: [PATCH net] inet: RAW sockets using IPPROTO_RAW MUST drop incoming ICMP
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,mails.tsinghua.edu.cn,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256449-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email]
X-Rspamd-Queue-Id: B6378DE252
X-Rspamd-Action: no action

Yizhou Zhao reported that simply having one RAW socket on protocol
IPPROTO_RAW (255) was dangerous.

  socket(AF_INET, SOCK_RAW, 255);

A malicious incoming ICMP packet can set the protocol field to 255
and match this socket, leading to FNHE cache changes.

inner = IP(src="192.168.2.1", dst="8.8.8.8", proto=255)/Raw("TEST")
pkt = IP(src="192.168.1.1", dst="192.168.2.1")/ICMP(type=3, code=4, nexthopmtu=576)/inner

"man 7 raw" states:

  A protocol of IPPROTO_RAW implies enabled IP_HDRINCL and is able
  to send any IP protocol that is specified in the passed header.
  Receiving of all IP protocols via IPPROTO_RAW is not possible
  using raw sockets.

Make sure we drop these malicious packets.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Link: https://lore.kernel.org/netdev/20251109134600.292125-1-zhaoyz24@mails.tsinghua.edu.cn/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: David Ahern <dsahern@kernel.org>
---
 net/ipv4/icmp.c | 14 ++++++++++----
 net/ipv6/icmp.c |  6 ++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4abbec2f47ef58242b686f411109494e40c8d752..4acbbc703e79807ba847a53954952f85dc325499 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -1031,16 +1031,22 @@ static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
 	/* Checkin full IP header plus 8 bytes of protocol to
 	 * avoid additional coding at protocol handlers.
 	 */
-	if (!pskb_may_pull(skb, iph->ihl * 4 + 8)) {
-		__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
-		return;
-	}
+	if (!pskb_may_pull(skb, iph->ihl * 4 + 8))
+		goto out;
+
+	/* IPPROTO_RAW sockets are not supposed to receive anything. */
+	if (protocol == IPPROTO_RAW)
+		goto out;
 
 	raw_icmp_error(skb, protocol, info);
 
 	ipprot = rcu_dereference(inet_protos[protocol]);
 	if (ipprot && ipprot->err_handler)
 		ipprot->err_handler(skb, info);
+	return;
+
+out:
+	__ICMP_INC_STATS(dev_net_rcu(skb->dev), ICMP_MIB_INERRORS);
 }
 
 static bool icmp_tag_validation(int proto)
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 9d37e7711bc2b8f12c5c2e24b76378c4f3bf401b..a77f3113ef23b6e42743600e7dab5b2e088cd5dd 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1066,6 +1066,12 @@ enum skb_drop_reason icmpv6_notify(struct sk_buff *skb, u8 type,
 	if (reason != SKB_NOT_DROPPED_YET)
 		goto out;
 
+	if (nexthdr == IPPROTO_RAW) {
+		/* Add a more specific reason later ? */
+		reason = SKB_DROP_REASON_NOT_SPECIFIED;
+		goto out;
+	}
+
 	/* BUGGG_FUTURE: we should try to parse exthdrs in this packet.
 	   Without this we will not able f.e. to make source routed
 	   pmtu discovery.
-- 
2.53.0.rc2.204.g2597b5adb4-goog


