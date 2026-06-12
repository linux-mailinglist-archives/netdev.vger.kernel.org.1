Return-Path: <netdev+bounces-298720-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UrITBpU0LGqdNgQAu9opvQ
	(envelope-from <netdev+bounces-298720-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:32:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35767AF33
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:32:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=OyF+i7mX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298720-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298720-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2525A31A3FDE
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445E386C25;
	Fri, 12 Jun 2026 16:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BA13839AC
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:25:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281527; cv=none; b=MMOU6D0ImVk1kHdxhFl8XMuKQtFgxHWV7iB04QLyUDnF1jCyKIiqobs0NSkQeyI3EFrfoDuXSH4G3UCwBpmZunezhsbdRUuURyciLj/VMVlfGv0qcRPo10yzSj/RD8ostVy1YOwTuDcXE6oWjfkQlL0XM8fGeFs0QoMsPTIWuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281527; c=relaxed/simple;
	bh=7sa23XcBXRmV1fEE+scXbd8x0oqWmX0t3sKz0UXhB/s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QYLQ0hzALIFR5gKDiBqwD6U/krxOr6b9CPLkzBgvIHYewOD9cQcqgQ/O7q0qEwi2PxGkHDnS/qXAYwDPPTqPr56mIkw8qswTI8qSFlsF6+QqKxo4hNqPnwUr4fmFhZD6Lw5veQ8ulWSsQgmiIuf4j9HW1kpsCHpUi/3yTSRRNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OyF+i7mX; arc=none smtp.client-ip=209.85.160.202
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-5178fc89b2aso17208851cf.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781281525; x=1781886325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uZ8pYSQmEjOXaXBpG8sKS7NyeIMRKIW+zuP+wNgkLAE=;
        b=OyF+i7mXyJiGfBaMMLF8HA2niydnXVwv3VSlgyaIUMp8Oy11wXKpP0Y22cr3uofbwT
         +rMIj1gHc/M0/FCxWn54FMgp2Zg09WK5zpI/ZUqSXenR9/jZyHkKCYpQWL5Ptlk/1aj7
         TkClLy8o04ADoK06RQkEFy5J+VJo1U89q/HaWOHLfw0dkILVi0ZWPWeLqtc949ZXdOZo
         13I8EEtPtmpTn0LBTlaxgc37yktIJmd5SmlklSaW8yXtRgiuWVG/WJuoEkHazExjuV13
         1+mrbn6UJHlMuk9WWKRoL2OxxJVr4xjLdJ4MBef1kNdCwiHZmzF5rS10TN4ehzNi6HWH
         rL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281525; x=1781886325;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZ8pYSQmEjOXaXBpG8sKS7NyeIMRKIW+zuP+wNgkLAE=;
        b=bTx//t1069ldp4HNH/C662uoaeKFmAMC/DNcmMVgQiyeai6afDDWcBi8ME2wi5ZPg5
         dcq1G2Eh3ApGn30HW4OBQqKlLsS3faxm/0R1b6vcJxolmhfU48sRXlJYu1MzVKuIZpn8
         CvA1eKBS8+DzQUd/LgrUXLlsIpIH3eje3uEgNLiwXfyrHHc+s46Fry8ozgKgRwa43MLf
         nBtBziH1XlKWb/NRpFp/wJvhpyVG3NdwKJgG667NzFndkNakIqidaTEedIVevb4jS7OE
         5HoRw//30aXnmVgOWPwUDXIF62OnivURIdgJnWtGSMFcQTAULqADu8d1WcOFkrSUR44u
         +55Q==
X-Forwarded-Encrypted: i=1; AFNElJ95MH6S4cD5x21IuYAEe29T9ZNJj4o+WfAb9MVW1MJWWOUJbhW9tpCbSWvbVKV9ItvZ2J+Rooc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyRrg9b4iE5zu+sTyHkWk7iBP3XoETq/xbMkH1ri2A3NpbTqt3
	IBuS8bvHUKzduEy/bxffMVK5zRBWl8YJEYNjJfqA52EIIEwVKvGqjKcfIDjqdIT3W5QgJ3xcXTr
	D2FMb/wVQFzZ+TA==
X-Received: from qtkf5.prod.google.com ([2002:ac8:7f05:0:b0:517:5809:505d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7e8c:0:b0:517:8fb6:56b1 with SMTP id d75a77b69052e-519533847b9mr4976211cf.17.1781281524686;
 Fri, 12 Jun 2026 09:25:24 -0700 (PDT)
Date: Fri, 12 Jun 2026 16:25:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612162517.83394-1-edumazet@google.com>
Subject: [PATCH net] tcp: ipv6: clamp default adverting MSS to avoid
 GSO_BY_FRAGS (0xFFFF)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298720-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ebdb22d461c904fc3cb2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E35767AF33

When MTU is large, ip6_default_advmss() can return IPV6_MAXPLEN (65535).
This is interpreted by TCP as mss_clamp, allowing the MSS to reach 65535.

However, 0xFFFF is also used as a magic value GSO_BY_FRAGS in the kernel.
If a TCP packet with gso_size=0xFFFF is passed to skb_segment(), it will
be mistakenly treated as GSO_BY_FRAGS, leading to a NULL pointer
dereference because local TCP packets do not use frag_list.

Fix this by returning min(IPV6_MAXPLEN, GSO_BY_FRAGS - 1) (65534) from
ip6_default_advmss() when MTU is large.

Also update the stale comment in ip6_default_advmss() which suggested
that IPV6_MAXPLEN is returned to mean "any MSS".

Fixes: 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes")
Reported-by: syzbot+ebdb22d461c904fc3cb2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a2c3193.8812e0fc.3c3fa4.0001.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/ipv6/route.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 636f0120d7e38d6d7f07b43ee6673c56e77471aa..3c97ba01297aa85da64f797096bc35abb0a00ac8 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3275,11 +3275,11 @@ static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 	/*
 	 * Maximal non-jumbo IPv6 payload is IPV6_MAXPLEN and
 	 * corresponding MSS is IPV6_MAXPLEN - tcp_header_size.
-	 * IPV6_MAXPLEN is also valid and means: "any MSS,
-	 * rely only on pmtu discovery"
+	 * Limit the default MSS to GSO_BY_FRAGS - 1 to avoid
+	 * collision with the GSO_BY_FRAGS magic value (0xFFFF).
 	 */
 	if (mtu > IPV6_MAXPLEN - sizeof(struct tcphdr))
-		mtu = IPV6_MAXPLEN;
+		mtu = min_t(unsigned int, IPV6_MAXPLEN, GSO_BY_FRAGS - 1);
 	return mtu;
 }
 
-- 
2.54.0.1136.gdb2ca164c4-goog


