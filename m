Return-Path: <netdev+bounces-286728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AXoL/L8AWppnAEAu9opvQ
	(envelope-from <netdev+bounces-286728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327A511B71
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68984308D746
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9D402BA8;
	Mon, 11 May 2026 15:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI8nmkR2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D022DF13F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514750; cv=none; b=S85fhHMoOxmBBB8neZ5vXw8I/yz9KMHMr+ye6ZjjAST+XDGJXfjVQLbvSXjZJaahH3W7MjayJPfHg8bQfYpLjYBX/MwVNRDlPClUDovcw6JhCuU4t5vx3UKwqZWfDAJ6VsZAMO2htmmwU1WWrVsZa+rzTTYuapb3bQLAHNvFqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514750; c=relaxed/simple;
	bh=LY8YpcvM3CXANbpB89jmDW3iNuQAInAhIYtroGvfyng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cePXtcUOrNJ4Q0WH0uQ5bZxnVNVAOjGBMBbVL9ZtNuBHC3QQLMRtU/kGR6vkaECCqA9eX+UfV6QbZWM/dBnUAXWNrqxwk+7CjE78EY/ZKkmjqv8PnMpuvEgPkZMLFDJhZF0LqCsmWlo5NLKrRU3Ox5rF939iBSLI9JAvZACjfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI8nmkR2; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2b4583f0a1aso28622655ad.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778514748; x=1779119548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QetRoHLjDkD2yyVDipEmrezVOT3nudkbaSue2EAREBo=;
        b=VI8nmkR2du8rddqvTnrujuu5pWuAe2LlEPZXvRfpXS392qVA0dEO0w8mqtZckiX4mh
         3Xbz1/PLM+H2o9ysGW4udUBMZWyr41lxhsuRyqfBajIJyziUx6n7sYFtKQr11mB9efJU
         6tg3FjPbNvWDlIBZ+jWwTYSQauG1OuvNI44W1eRIGQkYbP6MOj0h7co2fxKfAwL0TWwd
         m5i47GWZk8Nrg6w4nUet/PJfaRxBuYUYcE12y6y/vg3+OKEp4dLYwk8qtfjJAgFdmC4C
         yGrnn7eje6RG4c7MQMlWRSH8dI1J6e+2hvCtNtT+rX4HUOsznffONOMnmXjzfBD2DJUn
         B0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514748; x=1779119548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QetRoHLjDkD2yyVDipEmrezVOT3nudkbaSue2EAREBo=;
        b=DB0iZLDGaBecr/exLrhabj6ilvPho9P9c+gFKSlwMz6WwNEI8dFTfrGSTVxnkop2/6
         6Npbx+bySwaYh0cT23QRYMFm+XQg61Y3qLgxPfFz39qd3rNouhHp71llUTXS78BC6Nlr
         bAkieKUf2rRUi2cZBHyDr7m+SdVP+qd/f9NLeHBjF2cWbXh7J8vu7p0v3zLUZ/VsRzec
         bP9HyneSAjWiR0Qv2YEr942Iya3TAYGZIZ5lvDu3O9urCCPAS1uI4DSw+DHCfs9+SKns
         W5CFFXgPXjq9w85uhgFGCaXcIYlkbSWD60WrN7mBoX9DWMPdDa9xLYBUl/ihuHYo0eWZ
         XwxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GFupqXmMnyy0gW+W2dS7DxxTMy/srJw+D4cpnwasl0I5oF64Zdc9Q3QfRqFHU13x0gu3pmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJVoht7FcP4wj+HDbRSFxNiW+XsHKLdIl5yWgTfsUBUNIRfYj
	wiQVbTVggQ3EYPlV8t3T2VG1jt4PYHDsetvITlVn5edmScIp3HMYfHFt
X-Gm-Gg: Acq92OEzyjcKc0Gp0QJ/MgdtmRTxIp1XF9FBhNBFczejufWVAumgBcGFjKVl9J+/3f4
	1cMOA7Rkdgy5LB4tagBG6DrNXtAlqkOMqaZoZqbzKWFAyGYB78BFmCyDEFCH4X3hrrwKONGqPUx
	GJkNj+/jByviJAhEEif2vBA84tom5baZH6575egBACd6anxQJjkEpLg+MLZwWsfFz1UWl7Ji3r+
	OcWyrkNMl9dVGsQ+isBMbChIIrbgHsmgUkX6EI/mxwQPvVOsda/fTG9PTF5YJ/n0LtMuzL6aBJD
	uiwQ6nzYbV6Lkdb+7ZilIfrqZvSucBka/2JFDQsEJgy+IATWA+EhnsH0L9AFRUbJxgyU6k16iBo
	ONci56RHFhkVUD17Wtfth0fADUmbb/1xeqroiwdDKGOwLBO2QF7jhXVY7x1VnCr97sx9u/yr3Ni
	VZmHqCkoxPbwxtUvrwcJUuqlSyR+6fvIKgl5U=
X-Received: by 2002:a17:902:f54f:b0:2b2:4d36:7ba with SMTP id d9443c01a7336-2bc7a847f38mr103896425ad.0.1778514748205;
        Mon, 11 May 2026 08:52:28 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e78c6csm112117885ad.60.2026.05.11.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:52:27 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com
Cc: kuba@kernel.org,
	jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mrpre@163.com,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v4 1/2] net/tls: reject TLS_RX setsockopt on psock-owned sockets
Date: Tue, 12 May 2026 00:52:08 +0900
Message-ID: <20260511155210.32926-2-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
References: <20260511155210.32926-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8327A511B71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-286728-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,163.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When a TCP socket is inserted into a sockmap before TLS RX is
configured, tls_sw_strparser_arm() saves sk_psock_verdict_data_ready
as rx_ctx->saved_data_ready.  On data arrival tls_rx_msg_ready()
calls saved_data_ready(), which is sk_psock_verdict_data_ready().
That calls tcp_read_skb(), draining sk_receive_queue via
__skb_unlink() without advancing copied_seq, because SK_PASS through
sk_psock_verdict_recv() does not call tcp_eat_skb().

tls_strp_msg_load() then sees tcp_inq() >= full_len (stale), calls
tcp_recv_skb() on an empty queue, triggers WARN_ON_ONCE(!first), and
returns with rx_ctx->strp.anchor.frag_list still pointing at a
psock-owned (potentially freed) skb.  tls_decrypt_sg() subsequently
walks that frag_list, yielding a use-after-free.

The existing guard only covers the reverse order: a sockmap update
already fails with EBUSY when the socket has TLS ULP set
(tcp_bpf_check_ulp).  Add the symmetric check: if a psock is already
attached to the socket, reject setsockopt(TLS_RX) with EBUSY before
any strparser state is modified.

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 net/tls/tls_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41..46cdd38ae 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -648,6 +648,15 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 	if (sockptr_is_null(optval) || (optlen < sizeof(*crypto_info)))
 		return -EINVAL;
 
+	if (!tx) {
+		struct sk_psock *psock = sk_psock_get(sk);
+
+		if (psock) {
+			sk_psock_put(sk, psock);
+			return -EBUSY;
+		}
+	}
+
 	if (tx) {
 		crypto_ctx = &ctx->crypto_send;
 		alt_crypto_info = &ctx->crypto_recv.info;
-- 
2.54.0


