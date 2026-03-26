Return-Path: <netdev+bounces-272234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNmaKWyWxWmq/gQAu9opvQ
	(envelope-from <netdev+bounces-272234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:26:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A0C33B693
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24F15300BE29
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E79834D922;
	Thu, 26 Mar 2026 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UySPh/0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9330E82E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556773; cv=none; b=FF06um5RscSU+CNnaaRUfDGxfqPIYESXUU2qvghq37E58XN25uN8UrNjPlcZCL6fbnDP2ptV/V7wK183CJWGI6rcP7bLhJARtrk0Y/qa+ScgoFQWo3c3GR3EOO0yYOosRPwL6+7JjermrWsOsrwxKcMtaOcR9nzrteX8KBPnTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556773; c=relaxed/simple;
	bh=brT1jnCxHzpt2EI98A03voCoE8led6NrpAgfwfua/nI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aDi1w2wvg4+7ozhnhulfTDqnndtVNycrP7QkzBlOkYST4gghBmAYoTvUYC6Al71tnuzTmk0rEU4ULfF7vYmLoqeiMMFnJU2Fpyrg9DQ2V3hf/KatgPhO47pCOVliKH+Fv7/lHhn4hcVinNLxJvmbrruyaMjhvyn7clUul/BwhHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UySPh/0U; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64eb1476bbfso3359717d50.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774556770; x=1775161570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3NQAGWLxDfY4xBPdfzQtvOtmrZKI1cWq7nIQAUm/3eU=;
        b=UySPh/0UsGFlgz6RYADIDV1zR8O7J6jYcvY2w/hg8t9RZLVQzQT7RHOk1ku8SWC8AI
         BZJY7SR3No98SOgFJpIoTFCm5PI6ca9BqDXh/Jkw0IOhOIGajS4SfZPb7ezjWHbfDFSy
         xFGLiaWtnWeC9tWq5xg8tnha6NWovEZnzHxcAiGhcKYlyU+OakvTbjgJ5VyQG1ycLNyS
         gvS0zmeSDXPkWPCtu67BM+I50SUr9L/bk11MQo/3GqdTO5OM1+0xhanvMrdW9gAt5Mwp
         Q6lHZtTTGvwx7iBD7HcI5xoGT84zscMl9aXoMuPKwirC+OLYuIBOvIhF3UTP/9LP2oGF
         mW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556770; x=1775161570;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NQAGWLxDfY4xBPdfzQtvOtmrZKI1cWq7nIQAUm/3eU=;
        b=MjqHr94mpSOIxS/3s1Guw0e+I9uyF1gSmx7zV4bNyOOB74FqfL9+OMTm33qxrb22QU
         cHH145iliojQw6lMBQQMSxdE5BjvH4tznaZP/t2NxXBS/xBb3dJt8bf5AIUV7TPUGVqT
         ieJ7ZedCSm/lvXRiIxuqHdefEcEzj1MBzQZl0qoADg2kRJbSZNtVEl/UiWxEzySyv1R+
         xVbmrfi7rKKOpasJB4856Ymuv1ozv7tPP4+S5xbpcsmQwxXCvyxFZA63vw9SJPearE/r
         Zdu0BeQW+wnot2xg/vZ1HGlnbyfnvyYinAFISb7+c2HFmZqWjXwbzq9gHa94pBQfKh9y
         zXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN58888AvsbehzL8G2ZM+eGUGRtk+DZK4rfBr7N5Wp21jncTHY5K6FBW4Ij5AQ65hGFb1XGQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOC+8baJXYpS/UYFvxF96bQiE3xIdk4FQehbDVbyQQrlnABj97
	m0WwEDRW7fmgAfjzD0a3PsqVUi57flCytJqrggM0qa0JUBlNr106ANlNr6V9JuxT28V6ABH3a4h
	G5SWXAVJ3TzoI/w==
X-Received: from yxbq15.prod.google.com ([2002:a05:690e:43cf:b0:649:d455:4ae1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4847:b0:649:f002:582b with SMTP id 956f58d0204a3-64ff7199764mr88458d50.7.1774556770298;
 Thu, 26 Mar 2026 13:26:10 -0700 (PDT)
Date: Thu, 26 Mar 2026 20:26:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326202608.2976021-1-edumazet@google.com>
Subject: [PATCH net] ipv6: icmp: clear skb2->cb[] in ip6_err_gen_icmpv6_unreach()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Oskar Kjos <oskar.kjos@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com,nvidia.com,hotmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272234-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 32A0C33B693
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko AI-review observed:

  In ip6_err_gen_icmpv6_unreach(), the skb is an outer IPv4 ICMP error packet
  where its cb contains an IPv4 inet_skb_parm. When skb is cloned into skb2
  and passed to icmp6_send(), it uses IP6CB(skb2).

  IP6CB interprets the IPv4 inet_skb_parm as an inet6_skb_parm. The cipso
  offset in inet_skb_parm.opt directly overlaps with dsthao in inet6_skb_parm
  at offset 18.

  If an attacker sends a forged ICMPv4 error with a CIPSO IP option, dsthao
  would be a non-zero offset. Inside icmp6_send(), mip6_addr_swap() is called
  and uses ipv6_find_tlv(skb, opt->dsthao, IPV6_TLV_HAO).

  This would scan the inner, attacker-controlled IPv6 packet starting at that
  offset, potentially returning a fake TLV without checking if the remaining
  packet length can hold the full 18-byte struct ipv6_destopt_hao.

  Could mip6_addr_swap() then perform a 16-byte swap that extends past the end
  of the packet data into skb_shared_info?

  Should the cb array also be cleared in ip6_err_gen_icmpv6_unreach() and
  ip6ip6_err() to prevent this?

This patch implements the first suggestion.

I am not sure if ip6ip6_err() needs to be changed.
A separate patch would be better anyway.

Fixes: ca15a078bd90 ("sit: generate icmpv6 error when receiving icmpv4 error")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Closes: https://sashiko.dev/#/patchset/20260326155138.2429480-1-edumazet%40google.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Cc: Oskar Kjos <oskar.kjos@hotmail.com>
---
 net/ipv6/icmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 813d2e9edb8bed7c1649e279cea9229806af4132..d5d23a9296eac86a4a7ae8ea0240314653170035 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -875,6 +875,9 @@ int ip6_err_gen_icmpv6_unreach(struct sk_buff *skb, int nhs, int type,
 	if (!skb2)
 		return 1;
 
+	/* Remove debris left by IPv4 stack. */
+	memset(IP6CB(skb2), 0, sizeof(*IP6CB(skb2)));
+
 	skb_dst_drop(skb2);
 	skb_pull(skb2, nhs);
 	skb_reset_network_header(skb2);
-- 
2.53.0.1018.g2bb0e51243-goog


