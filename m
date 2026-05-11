Return-Path: <netdev+bounces-286769-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KIHIyEcAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286769-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:12:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE4514254
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E104E310FE0D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438846AF1E;
	Mon, 11 May 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk8yatzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71546AF0A;
	Mon, 11 May 2026 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521767; cv=none; b=SrroXjNYfGjiv4tSk+7xS78SZgkCh6vMYrJDF76VoKZUtXeJznRtmgzufOh96YjuCN/YqYrEcZ/bFuLjROOgv4zSqD8+19UL4KXa0Gwm7apfayG9htQLMAD0PJqtzaYbLy8Rvfg8bp7F9GxrwcgJUlTf6rq754ianTFxfXbp93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521767; c=relaxed/simple;
	bh=9sYb4Fav9FiKNBRehNsBBD8EUkrn3WVoZsCuQZPMCek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lt3RQ7Pe9Bwyu3G2DmYfZNV2TBslWQnXlyDJKtsZ8eevhYvT3It788Ko2HH0AssB6IUybLR+ELKv23/EUVHuK7yhklfEqw4ROrb5sRwnnfynCA3/pJ1OSUffI08Qz5utPM4zA9klRuodaUWytVCCHYOUygZcpSFJsorwZslwk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk8yatzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F1EC2BCF5;
	Mon, 11 May 2026 17:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778521767;
	bh=9sYb4Fav9FiKNBRehNsBBD8EUkrn3WVoZsCuQZPMCek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hk8yatzFb2FIHfklyvobJ/q0cgq6ePeI7Z5uk8wB/NByIpNAIDLnJodCSwvRGVsRU
	 uPzjy89qNj2L/kW/DAL3nROezL245/va1rSo9ErOzTbTUhj3oPQ7v4FOoLTFELAQ28
	 zWE2aVmxEhEc2ZIwmuXD/HGiG0jaF7aObuTJDJ+AKvISJO0pXwySqX2OhJX+BI6ig6
	 b/7nxXtaD54CUS4lWjZOCpn+r1QVxT+2GoSXHvVoLYIMe4A9cISFaYw18/6LZJGpvG
	 iBug0vlGmhEFMvXaNbysLfdFOv+3zdoF8Mwo4H7KAjPtJ/wiNmjuYV9hLTdx1huf6c
	 7qaMLZQGqJ7yQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?=E9=92=B1=E4=B8=80=E9=93=AD?= <yimingqian591@gmail.com>,
	daniel@iogearbox.net,
	jonathan.lemon@gmail.com
Subject: [PATCH net v2 1/4] net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring
Date: Mon, 11 May 2026 10:49:17 -0700
Message-ID: <20260511174920.433155-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511174920.433155-1-kuba@kernel.org>
References: <20260511174920.433155-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00EE4514254
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286769-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,queasysnail.net,gmail.com,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Action: no action

When an sk_msg scatterlist ring wraps (sg.end < sg.start),
tls_push_record() chains the tail portion of the ring to the head
using sg_chain(). An extra entry in the sg array is reserved for
this:

  struct sk_msg_sg {
        [...]
        /* The extra two elements:
         * 1) used for chaining the front and sections when the list becomes
         *    partitioned (e.g. end < start). The crypto APIs require the
         *    chaining;
         * 2) to chain tailer SG entries after the message.
         */
        struct scatterlist              data[MAX_MSG_FRAGS + 2];

The current code uses MAX_SKB_FRAGS + 1 as the ring size:

    sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
             MAX_SKB_FRAGS - msg_pl->sg.start + 1,
             msg_pl->sg.data);

This places the chain pointer at

  sg_chain(data[start], (MAX_SKB_FRAGS - msg_start + 1) .. =
  &data[start] + (MAX_SKB_FRAGS - msg_start + 1) - 1 =
  data[start + (MAX_SKB_FRAGS - start + 1) - 1] =
  data[MAX_SKB_FRAGS]

instead of the true last entry. This is likely due to a "race" of
the commit under Fixes landing close to
commit 031097d9e079 ("bpf: sk_msg, zap ingress queue on psock down")

Convert to ARRAY_SIZE and drop the data[start] / - start (as suggested
by Sabrina).

Reported-by: 钱一铭 <yimingqian591@gmail.com>
Fixes: 9aaaa56845a0 ("bpf: Sockmap/tls, skmsg can have wrapped skmsg that needs extra chaining")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: daniel@iogearbox.net
CC: jonathan.lemon@gmail.com
CC: bpf@vger.kernel.org
---
 net/tls/tls_sw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2590e855f6a5..2608b0c01849 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -800,11 +800,9 @@ static int tls_push_record(struct sock *sk, int flags,
 		sg_mark_end(sk_msg_elem(msg_pl, i));
 	}
 
-	if (msg_pl->sg.end < msg_pl->sg.start) {
-		sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
-			 MAX_SKB_FRAGS - msg_pl->sg.start + 1,
+	if (msg_pl->sg.end < msg_pl->sg.start)
+		sg_chain(msg_pl->sg.data, ARRAY_SIZE(msg_pl->sg.data),
 			 msg_pl->sg.data);
-	}
 
 	i = msg_pl->sg.start;
 	sg_chain(rec->sg_aead_in, 2, &msg_pl->sg.data[i]);
-- 
2.54.0


