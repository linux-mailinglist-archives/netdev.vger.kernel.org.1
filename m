Return-Path: <netdev+bounces-289601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNauG1zEDGo+lwUAu9opvQ
	(envelope-from <netdev+bounces-289601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:13:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EF75848B5
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CA93048172
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FFF3AFAFF;
	Tue, 19 May 2026 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BheK859w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D983B47F4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 20:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221320; cv=none; b=eFqMYkb2E1MT9KPFw8l+L/ZJER/hUDS1MOXpCbbK0hqAZNaMOYi4/+zZEF/6ymO+1zWGi3+Czl8c0HGxKbu/JfEmhbRhLXN8sXS/hEcanCqz5ZrMUa4EDBnCEc6+t1ahX4NuLuERCJCe0VCoQ/bM6e+7pvNi42TqLn6p5XiJHQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221320; c=relaxed/simple;
	bh=OEoGbaIXiCQ1gvPrCaf8Ru7y/mRFjEIohdQAOoqQSaE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iVeGfxrDCHMPY4x2Gc28PUBHx+EL+GbpXiGc/GTbx8JBX2SXHNGLk5RNqgyrF17v3+H52wbyFlQ+SV17C/Rq8H+M/ZbMDpQ4Ayc3nzffkiVRcpBlmtybth8Poej+ddkBJhS7i8v70zjcbr2gTx0Uch9jAgIOFycEeBZpk3E/uuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BheK859w; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-516458449d4so3843991cf.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779221318; x=1779826118; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y6wrZN/TrhuGiLfr2S736tmmvrzrXt7DdrRJRrcS8NQ=;
        b=BheK859wDRY6VpRr+04FdIC/WaTjJKw+ADa48d7X7irZJhLmHl/MTIWeU9MACrwZ4S
         b3GKKP8lGgLbaUIh77MByLAHXlQjvt54nrvgfgBnVGMB87LvkEAyI11jEjPgdyM4tSqL
         M8fQ0Do8HETgSv9lPK/cynWdLHswVUbBJGYCHR0URJooOwc28Zp2pSuk814qAakT95Xm
         /rbM89dirk+7CnUSn9Kpo7KSYzNKE8vmeiqkahZFpkJhWFkl1dYcjLl4UEf34UBzWrrO
         RNsFXNBzzBasnm2BBkw7cgyd5OBz09JbB/dn1jtNmX5wJNe1riPN1HB0prLQW8ZosTJk
         bnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779221318; x=1779826118;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y6wrZN/TrhuGiLfr2S736tmmvrzrXt7DdrRJRrcS8NQ=;
        b=l5NAPOcwA8+8ULFhnMrqJ9/KYaNmbSBn7RiD4Mwna813bAZDr2Exdo42sCKB7a+O55
         hCzhVPR9FX2GylqEkj+RLOZfMdpUfbIMkzvAiRd7H3kO58yhJYJWGbLISEiJ3nRGm1Jh
         y9EshpnQBquFBwZmm311mfQpEYnsFEY0XVvVg5sK+lDCnpgPXsRjRVBecaOQ3+lkpH2T
         GUEha9laluOLQEvk3yt8VIOCc5IBbuDio0VfefykRttWSDqswgMpBZJh4VvXZmTOjH2p
         kfjngMx2oA8FK6NHXhd48ILLOGXbT8WwzdA4/mYubLeHhoLyZVsczSPFzfw+K/kx58jO
         GLbw==
X-Forwarded-Encrypted: i=1; AFNElJ+VR7k122EwTPx1HOCZB3VcaSv2GW2sR/Pu9YrKMxY0J2f0hbatyihLVzg2PkE9Iv7zDEYuUpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfzFi4hj7db7jL5Y0RZPAG+R7tGXWDOFnQ3TN6xDd0SxyMPtAv
	49jfLeqslAitcwMLcd7cYTkMuT7h9olB5MBBQntmk9DN//Nl57GEHjBvSUEsneKKqHvYnpa0pkt
	eB4NZDqT3mkGHCg==
X-Received: from qtee6.prod.google.com ([2002:ac8:5986:0:b0:50f:bcfa:ef43])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:148:b0:509:26f4:64f5 with SMTP id d75a77b69052e-5165a205837mr315162831cf.48.1779221317289;
 Tue, 19 May 2026 13:08:37 -0700 (PDT)
Date: Tue, 19 May 2026 20:08:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519200836.4141061-1-edumazet@google.com>
Subject: [PATCH net] ipv4: icmp: reject broadcast/multicast routes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com,google.com,syzkaller.appspotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289601-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,c13a57c2639c2c0d03a6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A3EF75848B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot was able to trigger ip_rt_bug() in a loop, using an IPv4 packet
with a crafted IPOPT_SSRR option:

  options: ipv4_options {
    options: array[ipv4_option] {
      union ipv4_option {
        ssrr: ipv4_option_route[IPOPT_SSRR] {
         type: const = 0x89 (1 bytes)
         length: len = 0x7 (1 bytes)
         pointer: int8 = 0xa2 (1 bytes)
         data: array[ipv4_addr] {
           union ipv4_addr {
             broadcast: const = 0xffffffff (4 bytes)
           }
         }
       }
     }

Change __icmp_send() to not send ICMP to broadcast/multicast destinations.

Fixes: c378a9c019cf ("ipv4: Give backtrace in ip_rt_bug().")
Reported-by: syzbot+c13a57c2639c2c0d03a6@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a0cc169.170a0220.1f6c2d.0004.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 7eeff658b467aac6a10d7890aaa807b37d6ac3b9..23e921d313b36b00d8ae5e14846527220c9db32b 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -961,6 +961,9 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (IS_ERR(rt))
 		goto out_unlock;
 
+	if (rt->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
+		goto ende;
+
 	/* peer icmp_ratelimit */
 	if (!icmpv4_xrlim_allow(net, rt, &fl4, type, code, apply_ratelimit))
 		goto ende;
-- 
2.54.0.631.ge1b05301d1-goog


