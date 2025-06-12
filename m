Return-Path: <netdev+bounces-196967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39594AD7270
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E3168621
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29FC247DEA;
	Thu, 12 Jun 2025 13:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948A2AEED;
	Thu, 12 Jun 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735987; cv=none; b=YYSpTgZso2krTKur74WoyJGhdfuwZfDrG7iTsMt9XIo8VCxxRTzSscx7FWT7y4excIv0AxffNcFuDSCwUBAuvSg5gMXKuD/WM/re3HiVAMOQ+muu9zn6jo7YPm/k2hCeOM+MQ/lpxORn7U1D7hSyiHwC12UuVBmrDurfJFEBFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735987; c=relaxed/simple;
	bh=ynUZwpv0LBlzaUspg0SsHNS5dRCcMW5Kf7O4Iaw8l5o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cg6IHKi6/n1fzdG3wSnMJrHlyBBRu9RYnQKtfnmdkggxFjuN5rZqxCiC5EZEJ9CtVvzkozlvRizlc2QhJxnv9TFeXVa0zM/SFOQaf9MGN8dfNilOz6pAoYlALoBK9ci/6w4wFl0U2f/AptTOENFBrBlqeXNkM6pi8xaZkcekQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 58942100C3E;
	Thu, 12 Jun 2025 13:46:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 6335E30;
	Thu, 12 Jun 2025 13:46:16 +0000 (UTC)
Date: Thu, 12 Jun 2025 09:46:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, netdev@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Eric Dumazet <edumazet@google.com>, Neal
 Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH] net/tcp_ao: tracing: Hide tcp_ao events under CONFIG_TCP_AO
Message-ID: <20250612094616.4222daf0@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6335E30
X-Stat-Signature: 7y6jrrodeaqdincwbm4ks16c8s8mep8k
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Q3W6llJvLwbjK3ADzrmeycf7ZFPSp9Xg=
X-HE-Tag: 1749735976-138990
X-HE-Meta: U2FsdGVkX1+1xXBpq6pG4SxWvRgVynsXgeL23sLYLZfNLLnbRtjDD26172GO4kFcM0fe75cBqTZLugVDvn+QXX+8C99upFENsVgFbWcTzSK9UWLG3KjqxdFssJk963r86YzcikTYEksUdpWtzNCeG6ZqubTVfMWhyszMkyVQHBYYDXbDh4wVcNOXQ72+YhwDdXx8mJqnz5JzTg25m/JmVpD1oD73Tb3nWAoRIQu9aj+RNivZWCetwt22PVayDk9W4lQ/ZDzMB1jlkrZNPzAzJooh2PxnwvST4ZfoVHSF39oxLHY7FtGEoaeC1uMQLsHALK1DyaEKUFtJbcQIkX8b2Da3VnP69hY/UOwa7GFXSqUmqSKrDzFYQ2aHtrwHBZUJ

From: Steven Rostedt <rostedt@goodmis.org>

Several of the tcp_ao events are only called when CONFIG_TCP_AO is
defined. As each event can take up to 5K regardless if they are used or
not, it's best not to define them when they are not used. Add #ifdef
around these events when they are not used.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Note, I will be adding code soon that will make unused event cause a warning.

 include/trace/events/tcp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 95f59c1a6f57..54e60c6009e3 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -692,6 +692,7 @@ DEFINE_EVENT(tcp_ao_event, tcp_ao_handshake_failure,
 	TP_ARGS(sk, skb, keyid, rnext, maclen)
 );
 
+#ifdef CONFIG_TCP_AO
 DEFINE_EVENT(tcp_ao_event, tcp_ao_wrong_maclen,
 	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
 		 const __u8 keyid, const __u8 rnext, const __u8 maclen),
@@ -830,6 +831,7 @@ DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_rcv_sne_update,
 	TP_PROTO(const struct sock *sk, __u32 new_sne),
 	TP_ARGS(sk, new_sne)
 );
+#endif /* CONFIG_TCP_AO */
 
 #endif /* _TRACE_TCP_H */
 
-- 
2.47.2


