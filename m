Return-Path: <netdev+bounces-263604-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P1PNjjTp2nEkAAAu9opvQ
	(envelope-from <netdev+bounces-263604-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:37:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9E61FB358
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 07:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 102E830131E2
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFC337F8C1;
	Wed,  4 Mar 2026 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GhSM2U/8"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD529408;
	Wed,  4 Mar 2026 06:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772606259; cv=none; b=Pvtt1oLYzh2/CS0w57cB5IoPM/zu/VvVFCMnEBtcwR6MKb+c79MU8SyeGgaEdzITki3rB6G114e82Kapn4Q7TuiFm2/KUSFSGlC+PpnG+Xb88MHD790O9DFxZptTtqW9W87Wsr33+lJvJ1V8kAslK6FQgsL21y36CoXYS0Nlpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772606259; c=relaxed/simple;
	bh=lsIWMaQL/3whKexmrcJ91u/Whymn/Pb8xcsaW7Jb11M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MkgsYLLqVnlryxW8Uy7ydSjRSZ/ejnuGEC5ALMuFRnTshxMiIKQvuOnSxXGClLNCfUOJ16ZqrIAeNMz9htFv3ZphgrolMlYc+o/gDSpRVoA61//YeumMhCfxVcgzi60gqfT6/5dQ7+WojLSXlsGpKiGNgKtU95sUI4YcFSCVCjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GhSM2U/8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772606256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VefZAyfd4lTF4RnV2A7nIRCdqG5nxtx9S7DWo98eaU=;
	b=GhSM2U/8YC96Es7pkV8cwof4OEYp+LUxYDTKPDho37h4hYPlF+IzxY2YlRhUCvJGQnuk6w
	heiudbs8dFsIptmC3EimiGBQ40Vd2s76Ts7IIN1FM7kZbfUZX5z7mjlSYfhWOj7lSYq4Py
	nOQWcshZ7LGy/9it3z5bsDgn4eK8Jmk=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Michal Luczaj <mhal@rbox.co>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 1/7] net: add splice_read to struct proto and set it in tcp_prot/tcpv6_prot
Date: Wed,  4 Mar 2026 14:33:52 +0800
Message-ID: <20260304063643.14581-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260304063643.14581-1-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: DF9E61FB358
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263604-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action

Add a splice_read function pointer to struct proto between recvmsg and
splice_eof. Set it to tcp_splice_read in both tcp_prot and tcpv6_prot.

Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 include/net/sock.h  | 3 +++
 net/ipv4/tcp_ipv4.c | 1 +
 net/ipv6/tcp_ipv6.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 6c9a83016e95..de28af168ec4 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1317,6 +1317,9 @@ struct proto {
 					   size_t len);
 	int			(*recvmsg)(struct sock *sk, struct msghdr *msg,
 					   size_t len, int flags, int *addr_len);
+	ssize_t			(*splice_read)(struct socket *sock, loff_t *ppos,
+					       struct pipe_inode_info *pipe, size_t len,
+					       unsigned int flags);
 	void			(*splice_eof)(struct socket *sock);
 	int			(*bind)(struct sock *sk,
 					struct sockaddr_unsized *addr, int addr_len);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d53d39be291a..fa445f20b427 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3433,6 +3433,7 @@ struct proto tcp_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v4_do_rcv,
 	.release_cb		= tcp_release_cb,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e46a0efae012..277b954c524d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2295,6 +2295,7 @@ struct proto tcpv6_prot = {
 	.keepalive		= tcp_set_keepalive,
 	.recvmsg		= tcp_recvmsg,
 	.sendmsg		= tcp_sendmsg,
+	.splice_read		= tcp_splice_read,
 	.splice_eof		= tcp_splice_eof,
 	.backlog_rcv		= tcp_v6_do_rcv,
 	.release_cb		= tcp_release_cb,
-- 
2.43.0


