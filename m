Return-Path: <netdev+bounces-306350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oG9ZKJT1T2qRrAIAu9opvQ
	(envelope-from <netdev+bounces-306350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:25:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9C2734ED0
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 21:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PHrs6MxO;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306350-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306350-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8058230037F4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435AB3AE1B9;
	Thu,  9 Jul 2026 19:19:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5873AB26E
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 19:19:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624785; cv=none; b=WKmkEINpklYYmfIaICy3wiWbjVaP8R2CInYfxwE8GpWsKiWOqNWbKIVuDLcWBeCrTfuLqidGR/GAAw9blTsZStx+GO6gRZwyXqMuiv9B4M4pD2OikWOC7k25J8AiTJoKeWOzF5Q53nGZnBGMyyRazheuIM5lPAtLkrQRFHxdEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624785; c=relaxed/simple;
	bh=ag2iaJNRSatXfZcIQOXwJLWZ7MP77+wFc5guU6LKKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0CnNuJtWkqV6WXdRQyW7gcx3tmK5riFarcsr64tj1xZUh/1eNMg8AykkKSOCPzX9lBxzAdygWFgtPVx8RFOx4DmFpKsuaOuhUks9XMBs3UmMTnAVa+b8WNVWI1wl5nYnSRBFiRko2Rum4/1E9NjpgGhC1IIDLeyB08qoQkroEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHrs6MxO; arc=none smtp.client-ip=209.85.219.49
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8ff88549786so2112216d6.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624783; x=1784229583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lTAkLkaFfueQ/1V07Pbb9gud8KYPki4tliZP1BPO3s=;
        b=PHrs6MxO1ELbyBow0rxKOskrO9vH7JuuPzlu+5FRPCzFOQA65F2pza394Wetas0dTP
         7zwcIAHBmAbooaocKM1TznSzTYCEmGJKxDId3kgIwtg5UYzPPR6TIx7Lf7zgHKCvvhzf
         31lvh6xDtSyXnVvrWCQd2m3kq5V5RvV08OhRtLksDuZh36kWClGxf//OWSz+Pgx0DOHN
         DqrTd473rwe5maDyGq4bgBo96+CCf8SqWWog2ejisq6P/9d2a9VT9QzZ9ygUXyldosJK
         iSh15opyzZ9LsNxMzbOHifuSM1Ne2+O+xLuuzn5baf90zYqQ8F61TNDI6+VVP1XjVWgO
         y3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624783; x=1784229583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lTAkLkaFfueQ/1V07Pbb9gud8KYPki4tliZP1BPO3s=;
        b=rduXdYlgGROUBMY7KndvJ0gsgKejjNgpaSaW0bBdW6HI+2N/L4Zyf1/hyf03iJJwOj
         i4/2lGRPRFLkublzNKLrgKT/Sab9iw1/hpj9o2Ev6vyomXE2LWRzKX6zgXIE1yerLgHX
         xMUwMYkT5rxxxelwQ/Xlnro4RniZf9Nq0Pq3yay5nJPQx0kA+QM5uQ//VoIGeZZY1LYa
         nSv5wCJNkHK1i223BztSu5QaM+Q25Mel3nT1n7ghcEn2HLEuEQKpgy2H6OM5oUiBaPNp
         AEE8cL8ozwrAS8R1Z/jDRsP450Pl8T1jjeuWglgmja0q38P7qg5XLAjHeJ0jC3/mT30K
         SSRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOQWyaLewARNIyBatM1NtR4U9HQWnPEvEi+QucK1dZWPxID5oD3AvlLIDaOEGakgNFZ66oUNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOoUPQRhE9DXR2olgb+N9lo/GDVPEwE9ow1dB78+mlYRJL+38B
	G362lI125z5rmT6gVMwGiNHBbBRT9R1TxlDFuFJHQ4q8LoijUzW3AcFx/8SnkN6D
X-Gm-Gg: AfdE7cnp1chj8dU19jUY2puOxMNAAMbjoa1Ml0TbvZykQbDauwstV0AP0uecgfsQkWE
	TxaPJYWasI68BP13thrGXXlrIfuQnMy7Qe8+l/YKhoWHprUCGh4botqswxJyGNitqfMxO0azy7P
	BzobCMV/d/ZdNY1bC4nXbs2O8T/RcFa69D9VSupetO9XfmKtCBTIAFi3IGQaIE8HW7fO4npJUS1
	5htE6MwXjQN+JGstpgYoUrY5RNRaCQQjGxnP5KoMyu25Wr+iFGCvxRLclYdPXjjKQC/+DHmSF6f
	0Ex39AtLxIOGIVhWrJNZBMiFXHd/neXlMZEU1D7ZHDBcK9xpE6YIYU6XFXUquJ0PuV5s1U/yMUV
	UlNoX6yotL973KgbboHIE62dsv5DU65UMK1KxWwfFGHpEqwnfHQAlWWohzlbiQIKrvwfraK1rFU
	gBOBybKpzgGggFyHMjCm5j/IWKNsMLnyIu3lQ6PKLUoPDk61X74hrxSETJaFC62ZuSYbLXdzW+T
	81TGIThRTw6RZJHZMNio6udpy+Wux4o
X-Received: by 2002:a05:6214:c87:b0:8fe:49d6:fb76 with SMTP id 6a1803df08f44-8fec3810ff7mr93576996d6.57.1783624782634;
        Thu, 09 Jul 2026 12:19:42 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm25507836d6.44.2026.07.09.12.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:19:42 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Gang Yan <gang.yan@linux.dev>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is present
Date: Thu,  9 Jul 2026 15:19:25 -0400
Message-ID: <20260709191925.2811195-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306350-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gang.yan@linux.dev,m:mptcp@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF9C2734ED0

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

Move the pr_debug() that logs the parsed DSS flags below the mapping
block, so it reports the final data_fin value instead of the stale one
it would otherwise print before the assignment.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
 - Move the pr_debug() DSS flag log below the mapping block so it prints
   the final data_fin value (Gang Yan).  data_fin is now assigned only
   inside the use_map block, so logging it earlier would report a stale
   value.  No functional change to the fix.
v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fin
    at all unless a mapping is present, rather than gating the consumer in
    mptcp_incoming_options() (v1).  data_fin then defaults to the value
    mptcp_get_options() already clears it to (0) on the no-map path, so
    the uninitialized data_len/data_seq are never read.

Link to v1: https://lore.kernel.org/all/20260617215725.1116295-1-michael.bommarito@gmail.com/
Link to v2: https://lore.kernel.org/all/20260707171730.2679013-1-michael.bommarito@gmail.com/

 net/mptcp/options.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..1b74ca5b6a595 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,17 +157,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;
 
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
-			 mp_opt->data_fin, mp_opt->dsn64,
-			 mp_opt->use_map, mp_opt->ack64,
-			 mp_opt->use_ack);
-
 		expected_opsize = TCPOLEN_MPTCP_DSS_BASE;
 
 		if (mp_opt->use_ack) {
@@ -178,12 +172,18 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
 		}
 
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
 		/* Always parse any csum presence combination, we will enforce
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
-- 
2.53.0


