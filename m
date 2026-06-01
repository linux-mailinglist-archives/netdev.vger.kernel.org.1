Return-Path: <netdev+bounces-293548-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOOVN1kYHWrFVgkAu9opvQ
	(envelope-from <netdev+bounces-293548-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1959619ABB
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59B96300A5B6
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A17343885;
	Mon,  1 Jun 2026 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXKPFkNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD31346A10;
	Mon,  1 Jun 2026 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291508; cv=none; b=UBMHsL/6DsTPpU1stowpaUafqhSjmiWzTD1zS/dRhY64cRt00emHBz29EzHz8yCbV092NkOFgZTnmNypzAOrTTidqdXJPgu9Eb2wuNWGc6vEHEUZX8EoM6ApbxySquaUsZiwTfLWDCEXVRlJ4/74MkQGIP4FeHcKmP9pW71QspY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291508; c=relaxed/simple;
	bh=EmowSBH54A3lVGBONcXKlB6WYxai741FbuaiQIC2kMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQYdOgZyUDJs4ANbD2ni/Z4oacf3VIYobCtnygSuNwOcQXfo+rbrN96EaIo+bkpUFh9XE4INxpi7sW96Ircep0eRNjQAjOnboKVWwHREgYSskqXsIZoKzsAMSMY1Uj3RhmTOhar02WISrlB/kO6ynRst8PbOgp+CgnzZkjo5Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXKPFkNv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82D11F00898;
	Mon,  1 Jun 2026 05:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780291507;
	bh=Yo7OUBnC2aMnLRL/6vn1cMxMzsD37D3D9Em4mFt7BaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KXKPFkNvduXTAAm2WCYz4rdzpzXngSq3d69Ecvjzg2B8ROXvF0w6tnq7uiqSIIDm6
	 +bYLNGw8l0KHBiHXg5s4oFhUsx/lHkH1KG9Ya852xn12F13AaP2HvMq7iFuchM3ja8
	 dBFb38NyGBfECQ6cTJz+n69s+u4kIj9fkp3RkvcSraknohEBrGfCDRP0OXvBfNJADn
	 VGzaQ44aqT7DAWa4MOXaLvo+9DbCJxBXEVtm8bdnuBklmn+rTs7CYduh3j9grmcEDS
	 T1kavUoAmpp+RmGVXE6BNLv7et9/opQOynnxZIev9sFjMoCSn1tTm4H9ymlmrAu+AR
	 JM9ShqH6pSvUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Jun 2026 15:22:13 +1000
Subject: [PATCH net-next 06/11] mptcp: pm: drop TCP TS with ADD_ADDRv6 +
 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-net-next-mptcp-add-addr6-port-ts-v1-6-4fc25dfef62e@kernel.org>
References: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
In-Reply-To: <20260601-net-next-mptcp-add-addr6-port-ts-v1-0-4fc25dfef62e@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4860; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EmowSBH54A3lVGBONcXKlB6WYxai741FbuaiQIC2kMQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqHReS7FJPRNlmEeZUzXxmo8cHI088+EW0cmVOM
 9hT9hf0Y6eJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCah0XkgAKCRD2t4JPQmmg
 c8X+D/9rr1ye5nQOAJ8hwgi9IeyAzet/oqwWFJU6AM7RrNZvm0OxP40Ry69/6wIGdrvCfMsBnZx
 WF9NdrmnpOeDJQB/CGla1ACs+hx9m9IwU9Ff9PvnC8E8jxZPDdA3kLvvKq3xgJBYryjPtroapow
 kmAludHGTSTSNiX53Fph7Ak82kFtdIrIRY6Rw37VCdLW5dwcdiYeupohZa7gRdmeSFlCw4BA7bT
 DsIu/OqY/46Lw2xTAipcK8GtbNQudzjxx6tquACucudYiUdqIjZXx/dkq+a+NEEuWGxEVXPXXDo
 WPNQMsz8dtVh0OdJiLCnAsIOhG7mzUaBVyBOCYc5Ek47OvgX5zn1Rumj1Frpyv/Uk6P345dO1Vi
 IlvsymoglxP4GMewnW1wtX45c/phhgZRhi6IcasCu71+M5s0RFiJR36j/idgbCEdNqLHVrzjhSg
 gcZqL9upMuSM+Yrqi8BNTw7MlfofKZZ4cE0fKBV18JtDc0KP3oeY6TRHiy24EfnVPGxvgQuqyRN
 /XEr7naThOOz0BvQsumPcOkKPQzRKqDNyfwTRzWOVjQGOi5p5zpjnEgC3KoIVcAZFNtqmc2lzeP
 zxo2YdgTROx7BYcSIK/3MecZcSFzYtsA34tu/Da46eJsmsYIFGCV0MMtCW1H/OHllk8sFQiFBkx
 DJ85sct/P7U5Y9Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293548-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E1959619ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With TCP-timestamps (padded) taking 12 bytes and ADD_ADDR IPv6 + port
taking 30 bytes, the 40-byte limit for the TCP options is reached. In
this case, it is then not possible to send the signal.

To be able to send this ADD_ADDR, the TCP timestamps option can now be
dropped. This is done, when needed by setting the *drop_ts parameter
from mptcp_established_options. This feature is controlled by a new
net.mptcp.add_addr_v6_port_drop_ts sysctl knob, enabled by default.

It is important to keep in mind that dropping the TCP timestamps option
for one packet of the connection could eventually disrupt some
middleboxes: even if it should be unlikely, they could drop the packet
or even block the connection. That's why this new feature can be
controlled by a sysctl knob.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/448
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c  |  8 ++++++--
 net/mptcp/pm.c       | 12 +++++++++++-
 net/mptcp/protocol.h |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ccb5ac0aa729..02336d1c1550 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -652,6 +652,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,
 static bool mptcp_established_options_add_addr(struct sock *sk,
 					       struct sk_buff *skb, int *size,
 					       unsigned int remaining,
+					       bool *drop_ts,
 					       struct mptcp_out_options *opts)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -666,7 +667,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk,
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
 	    !mptcp_pm_add_addr_signal(msk, skb, size, remaining, &addr, &echo,
-				      &drop_other_suboptions))
+				      &drop_other_suboptions, drop_ts))
 		return false;
 
 	/*
@@ -819,6 +820,7 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
+	bool add_addr_drop_ts = *drop_ts;
 	bool snd_data_fin;
 	bool ret = false;
 	int opt_size = 0;
@@ -869,10 +871,12 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
-	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
+	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining,
+					       &add_addr_drop_ts, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
+		*drop_ts = add_addr_drop_ts;
 	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 6a2cbe8616d3..b1b3f7482f7c 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -905,7 +905,7 @@ static int mptcp_add_addr_len(int family, bool echo, bool port)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions)
+			      bool *drop_other_suboptions, bool *drop_ts)
 {
 	bool skip_add_addr = false;
 	bool ret = false;
@@ -949,6 +949,13 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		if (!*drop_other_suboptions)
 			goto out_unlock;
 
+		if (*drop_ts && mptcp_add_addr_v6_port_drop_ts(net)) {
+			/* OK without TCP Timestamps? */
+			len -= TCPOLEN_TSTAMP_ALIGNED;
+			if (len <= remaining)
+				goto enough_space;
+		}
+
 		if (*echo) {
 			MPTCP_INC_STATS(net, MPTCP_MIB_ECHOADDTXDROP);
 		} else {
@@ -958,6 +965,9 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 		goto drop_signal_mark;
 	}
 
+	*drop_ts = false;
+
+enough_space:
 	ret = true;
 	*size = len;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index f4276980d78a..50c3205cab46 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1210,7 +1210,7 @@ static inline bool mptcp_pm_is_kernel(const struct mptcp_sock *msk)
 bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, const struct sk_buff *skb,
 			      int *size, int remaining,
 			      struct mptcp_addr_info *addr, bool *echo,
-			      bool *drop_other_suboptions);
+			      bool *drop_other_suboptions, bool *drop_ts);
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list, int *len);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);

-- 
2.53.0


