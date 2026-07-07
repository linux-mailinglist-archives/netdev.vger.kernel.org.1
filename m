Return-Path: <netdev+bounces-305539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ofgnEAw1TWpjwgEAu9opvQ
	(envelope-from <netdev+bounces-305539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:19:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB80C71E37D
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:19:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kBNvimd3;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305539-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-305539-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8FB3030055BC
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD14C438462;
	Tue,  7 Jul 2026 17:17:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E3437871
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:17:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783444667; cv=none; b=NECep+aUMxinxqnRkzghrrHl1Sqoz4OXO3muE0JjPu3iMXuluWoed7pyDfGktXCdO89DpgZOdDCdazF0NU/V+sJPzQubHi8I2A5ImJU9pziPfm+JOTRjXxyD4RPv5HPulZj8oUyYiHNf0mnAlqeeTOb/NBCTQHLUE7hbDS91fv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783444667; c=relaxed/simple;
	bh=nu6ZSgb2jRk2Ndie2s2jUBHTDDESXJco+T6QJqejMAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXaIWVhhsUy388SYsjbu+Hp3kyk6n13MKGDKfMkEX41slsctlQlUiL5rT2aDAqJEAV7zMMBxxqsJJhNO/Mi7XZarxQmmmPctG4Hb7EXBkroxht1aVLtCMe0iTNl6FqtgNK/44zcEvux//vNzZtdhuUZ+4+Ja96JCfMG3xSSUJas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBNvimd3; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e51d3d83cso228036385a.2
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 10:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783444665; x=1784049465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oUCStv+mG3q24BIMvpoJICyGa6vMwC+AFAbHW03keOc=;
        b=kBNvimd3aSd9CFB7w5JUcCZIN/lBMdM18PjKPKG2PM1Fq2Q8rxKHqF3HDPy/fBqrEX
         7bX5p72uJvpzezCxXtPXQcoa3lWi3p4ZTQgcUHaNGCmEYgZ9uU3gI9k4EiLLvushiYbU
         40ftOtkRmrC5pxtxS0qABg+44xZnyxjsVWzDv+hSdWqwPWopcdpKDfStpFg3G0rARMd/
         MAGGZrU+WOlDk+bvz9lxPuAblg0RUv7IUAg4XQR4QnOX+PesTSzN84NVL5LBFy/eoGtp
         5kCaYr+qnPkkSzmnBVPAVhxEoR+mpi6BI2fSw7EHsVRXUm9R/qNHa0mhXUi5XdDrJK2k
         20QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783444665; x=1784049465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oUCStv+mG3q24BIMvpoJICyGa6vMwC+AFAbHW03keOc=;
        b=nP5+aCpX3ziNVRE+bn+r0/DRfBwIt4kO4NnLfVnIWLZKlKfEwJNRlJqmtY3yA3N9lb
         p2aOFa02qO1sBqNpG+bN5a5pkp56DFSh/UuKSW8Xec7Lera+nWENJPUElkqw2hyyX0u6
         NNq6i420qerI9mSkFqBwUzQfO68PrH5aBxYEzjZh2wRhXSNyePAXwsPeSq0AazSEG7N7
         ZbKmIvZyavjdCW773QW+DbN6JYFyeFZdPF61lcop3uz0SJpKeDPGAkRuqMi6dv398R/R
         IH65iw/ug8jwrSFjNlrWe4Gz/aZgHRfbEMO3eREKMVAZEFGfKlpeyUwsE3Gc7aLwTK/p
         BqiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/45cz4GuVA/7IcqGNT3h/T4uc5OrmN7CTW+J9bbr4jJQaNh2rDBoL0q8aj0KqAFHPexWicb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyw6CaB5lR3dreYsGtFaIuMv+IQGICVAmjvtTobuJ8IsEs+SID
	IoC402ne1hd+qxTud8yvUiSfkBEN+u1ELdW3SqAIty4Z7JksjK/BSyqm
X-Gm-Gg: AfdE7cmMjealMlg0GaKHKJ/IRbOhFBr8tKhVXxxcjFjvtntBEWbNKOgGXepoUH45PdP
	dWC66GTXPheAT5KIrQbK4rMSntCrvdxiqvNsiS+No0HyKOoE6nUcu2Kmd3nkW7i/RY286yYKIk0
	Es/7JixKHGblyFrWoPef0SJL4sH9Co8ZjFxGiBA+l5zJz2qM9ef3YndwLaijR92ULFwO2Bh6WxB
	fs+ujZc+fSbMfkQELlYYcDoPq9dNqLugt0ukcyVCRsp8IdXLwH1EhGTLRO/iWG16bG1AXjHPg0k
	8t3sitMzljtkVnimEMVqgzCYx8s8Dgo1CMiKXFnLDspxIl3PhgtR3ZMw6LsuEGXEFl678ntJmaQ
	tVtk3Ewd0oKS3Wy3izGsDlW2k5pzXG2Uz2/V6GsYNPE0txIiJyzsb2eJnbsMC/sVjrEI07ubZif
	v9TjPzWNX7ys5HpiaXkRcd9buIdI4/621dVM+8zHeGJUs1mvoeWg6qTGTzIYbPm0np4AeBcAVEs
	5vS3FpR/WRotNewks5jrlkraekI5Pag
X-Received: by 2002:a05:620a:4102:b0:92e:8a88:ab27 with SMTP id af79cd13be357-92ebb528e65mr702327185a.14.1783444665081;
        Tue, 07 Jul 2026 10:17:45 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccde4fsm1220363385a.39.2026.07.07.10.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:17:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mptcp: only set DATA_FIN when a mapping is present
Date: Tue,  7 Jul 2026 13:17:30 -0400
Message-ID: <20260707171730.2679013-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
References: <2edcb1cd-f2db-4d0c-a0e3-fd2b4dd820fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305539-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB80C71E37D

mptcp_get_options() clears only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are filled in
by mptcp_parse_option() exclusively inside the DSS mapping block, which
runs only when the DSS M (mapping present) bit is set.

A peer can send a DSS option with the DATA_FIN flag set but the mapping
bit clear. The parser then records mp_opt->data_fin while leaving
data_len and data_seq uninitialized. For a zero-length segment
mptcp_incoming_options() evaluates

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

which reads the uninitialized data_len and data_seq; KMSAN reports an
uninit-value in mptcp_incoming_options(). The stale data_seq can also be
fed into the receive-side DATA_FIN sequence tracking.

Record the DATA_FIN flag only when the DSS option carries a mapping, so
data_fin is never set without data_seq and data_len also being present.
data_fin is part of the status group that mptcp_get_options() clears up
front, so on the no-map path it stays zero and the zero-length DATA_FIN
branch is simply skipped. A DATA_FIN is always transmitted together with
a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
data_len), so legitimate DATA_FIN handling is unaffected.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fin
    at all unless a mapping is present, rather than gating the consumer in
    mptcp_incoming_options() (v1). data_fin then defaults to the value
    mptcp_get_options() already clears it to (0) on the no-map path, so
    the uninitialized data_len/data_seq are never read.

 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..6d003b24b969f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,7 +157,6 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;

 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
@@ -178,6 +177,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}

 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
--
2.53.0

