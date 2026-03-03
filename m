Return-Path: <netdev+bounces-263064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNu/C5STpmnxRAAAu9opvQ
	(envelope-from <netdev+bounces-263064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:53:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EAC1EA691
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 08:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BF3D3034E19
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248CA3859D9;
	Tue,  3 Mar 2026 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV4mZsgC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB03803D9
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524142; cv=none; b=XKR9iagSqMVLz2jRI8zPrJ0q/5jx0HpChwsMhhtsEASSj2iNTk4DdBI1jvQAKzPqVVFLhq4qXNBPl5pOCR0zXU7sSWwUee1AIZ56+rn+XWg6mP9qIBbcTdBsJQftij0ZAAf8/HMFrEAb1qIZmjs/2e4lyZue79nrx9sz54NX0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524142; c=relaxed/simple;
	bh=/EwBHS+MulbJHdk14Rvjdo5dRfJFU8A5WHKgAg3MG3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HofzkASYmDrDOu/razONx/KPTVG/4zrLM8vdbe+kVp5KWmEmo/3F9ALN7ysZrP1U3PXcKPLpiZHNienck72bAc8mDDmOnsex9RX8tnz6kySVA4RzZxhEtaKCqEa5bTfHslbCE/IiFiWYdwyf8muXnXNSST4+a31NXaCAfqAYzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV4mZsgC; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70f191313cso2099730a12.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772524140; x=1773128940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NB1o9BGlkqLq/oNw4ApXQsql6klhqpWH7aXO0uKuMWk=;
        b=QV4mZsgCQdV46iKkv1BlcLaK/yjp4NrlUHot2tFGC6OorwWR9zecipTBUVSx/K3aut
         NpUo27OwOOgCsy+G/C8/Z9KzOe3bUAGPEQhVDY4epzN/ZGoOY70wdnFsQomDgmVW3ZjF
         BfP4mg9xloQ5lWEMJW0jnYNIntEs18GWyoZm79T6BdtWHfVnLnaS3K3JJ5XzpOIuhCT4
         FymccYK1GOpjbgHHa/iiP+T009Vp/lOjDEbpAkVibvoxbHzUfp1CH9csotTUL2tN48k8
         mJVskD2y6o6DcfyzjgT1lMX/oob2lyCgAvJUvOCThGffBSCyBeIAjzA1KaeCLYrdaGTT
         VIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524140; x=1773128940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NB1o9BGlkqLq/oNw4ApXQsql6klhqpWH7aXO0uKuMWk=;
        b=rSxRMsSTsDMVd2YUUCKmH0TGc56T5lXi+EWKEaXi4SP70WRkPmwusmLvUN18Jl3Rkw
         GiaKfU8t9wraHas8ZXsOSxv8Mz4EQMeAcKeDmUBOXu+isNBMxBnmYWZDcAPFmX80uIHt
         0ZMe/ildwm1ZNfb4pVlO8iSajL952mSw9Pbt6tvZMA878J1q6QGs/Jl+TDTitfg0eXwO
         vR9xjKWco+67If7Bx8dKBc/vZi1o3rcFbpoR0zGs/Y27ebHnUaZ7sq0sn8tgweu9Zo1U
         s2V8nuHOIGfXQPwhGrMLEj8+NWu3paOMJVpJWPZLeJcFOMXgJzFKpyNQOI62WMbIi4t1
         3F7g==
X-Forwarded-Encrypted: i=1; AJvYcCUGW7bXc3upnE8eXXFcs5fLSy+eLvg/3BsmeW5OzIbLG/JhhGAyM6W17xdXSEuxaKcq6UM/36Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxme+UfHycxZmNX6eXSusOh8UjSNwisrog5I04RXhvpDpVMxloQ
	06p1aD0bBR1yj4B39cSLkp0cS3xcaYI9xBJ8QE6bnHeGQUVEe979FVPS
X-Gm-Gg: ATEYQzw7c6VEFasTzvNKlg2D+gBAY+huXHMiYLTfd6o/F4WDgZ/xHO/dgKEgElgRbcu
	h6ekx32jR6aaZLcuxd9+h0RkViaxWh/VTB3pe96dE0f3DNMv2d9N4trECcc1j2loXpE9iUZXnyD
	+9YXgg3nQKE5TowTF4vVLNZao2kD7WEUSZD9c/X69hPTorxnBprpuPGHqiDE9YH7OgioRs71p2j
	zwV83yXX2N/LYFr0wlU0G1F4LeTJ4b2I3dSKrQ1aJe0wG+lb+T1Doi9IY8Z9UArmNA4VELZR854
	rdRKWUgqVp+1MgX0hdFEBVaw6cKGCCYGPn4xCvNmyomrxozefTF8hSkxTKe3yaGOJ52/1xNtpmE
	lBgL4tFaDKvHXG8Jf6fegSqPpjJntbufb1oCBDqJ686Yo+4r+JcGCr+EWhtc2KeyYR7dotAqPZL
	gZGr6wy7ZYtIeKodKE4cxzG8VTDzERned2OeiBZ3CAxBOcyddg/d49YBcYR8QU8pJe8jvpmAvX4
	JxdHaBZwdXO
X-Received: by 2002:a05:6a21:1bc3:b0:38d:efcb:2e99 with SMTP id adf61e73a8af0-395c3a4a2a8mr14271672637.22.1772524140121;
        Mon, 02 Mar 2026 23:49:00 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm13731037a12.16.2026.03.02.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:48:59 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Keita Morisaki <kmta1236@gmail.com>
Subject: [PATCH net-next] tcp: replace per-packet memset in __tcp_transmit_skb()
Date: Tue,  3 Mar 2026 16:48:47 +0900
Message-Id: <20260303074847.2814835-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 83EAC1EA691
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263064-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Replace memset(&opts, 0, sizeof(opts)) with targeted initialization of
only the three fields read unconditionally by tcp_options_write() and
bpf_skops_write_hdr_opt(): mss, num_sack_blocks, and bpf_opt_len.

struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
CONFIG_MPTCP=y (typical distro config). Every remaining field is either
assigned before first use by tcp_established_options()/tcp_syn_options(),
or gated behind its OPTION_* flag in tcp_options_write(). This memset
runs on every transmitted TCP packet, so removing it reduces per-packet
overhead on the hot path.

Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=n):

  Before: 5 store instructions zeroing 40 bytes
  After:  3 store instructions zeroing 4 bytes

With CONFIG_MPTCP=y the savings are larger: 12 stores (96 bytes) become
3 stores (4 bytes).

A BUILD_BUG_ON guards against future field additions: if the struct size
changes, the assertion fires and forces the developer to audit whether
the new field needs explicit zeroing.

Also add opts->options = 0 at the top of tcp_syn_options(), which
already used |= without a prior clear. tcp_established_options() already
clears opts->options at its top.

Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
---
 net/ipv4/tcp_output.c | 16 ++++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118d..ae04c697dbacc 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -965,6 +965,8 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	struct tcp_fastopen_request *fastopen = tp->fastopen_req;
 	bool timestamps;

+	opts->options = 0;
+
 	/* Better than switch (key.type) as it has static branches */
 	if (tcp_key_is_md5(key)) {
 		timestamps = false;
@@ -1549,7 +1551,20 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,

 	inet = inet_sk(sk);
 	tcb = TCP_SKB_CB(skb);
-	memset(&opts, 0, sizeof(opts));
+	/* Only zero fields read unconditionally by tcp_options_write()
+	 * or bpf_skops_write_hdr_opt(). Other fields are set by
+	 * tcp_established_options()/tcp_syn_options() before use, or
+	 * gated behind their OPTION_* flag.
+	 *
+	 * If you add a field to tcp_out_options, this will fire —
+	 * audit whether the new field needs zeroing here.
+	 */
+	BUILD_BUG_ON(sizeof(opts) !=
+		     sizeof(struct mptcp_out_options) + 40);
+	opts.mss = 0;
+	opts.num_sack_blocks = 0;
+	opts.bpf_opt_len = 0;

 	tcp_get_current_key(sk, &key);
 	if (unlikely(tcb->tcp_flags & TCPHDR_SYN)) {


base-commit: 7dff99b354601e04378b4490e1b1b5765a3c3a88
--
2.43.0

