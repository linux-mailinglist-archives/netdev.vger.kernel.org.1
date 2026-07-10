Return-Path: <netdev+bounces-306400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6pyxLtJFUGqnvwIAu9opvQ
	(envelope-from <netdev+bounces-306400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:07:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C8F736785
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:07:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JVNB8gSy;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306400-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306400-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF3F8300B9EC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 01:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F261C84BB;
	Fri, 10 Jul 2026 01:07:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A021D3F5
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 01:07:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783645645; cv=none; b=Q38df4H6Q3kbqhuG5WpmdrDS8CNypyw0F3H/P3KnEerv1/8bxHue+Y5EJQ1s8AOBcppDo3gY/8LdD0PSyErIaTsDhF4rf2lZTzTAvdzyYYYOi34DXQMLdpTl75iXZNUW4TclV52d4wwyrYmXxkg0ND4Z4zpaACZZLNtz/UX1K2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783645645; c=relaxed/simple;
	bh=/80AeMdn4kk8+3llG/Z1EZupQkn+3RUdjZp2bGBYLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHKRYTI5k6qOQfVJ5c01H05Ym1hjSmKsp/GPB1WKTKdbvM/lvaGzLdSPY3qvoEV6SOBL3uOq67HQBdnp51dqu/rsaMxz8N80sEhH3ENKnCmB7wAuiFkPBDrjM3rVbro3+f8viLxCLyAOJptwxfyUfOIvmMikVr3m8UDIxxNBykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVNB8gSy; arc=none smtp.client-ip=209.85.210.174
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso307814b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783645643; x=1784250443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eLuU5HyvYLKGf+ae1L1IKeF030+aNKovcX3x67WIV9M=;
        b=JVNB8gSy6q4K1SlOdB0PF6OM3Bq3B1p5+x3WpZex0JfboMU8Dr5s2tiDKlyXl5ZSFO
         oTRw16bzhNKJDltm4iHqk3QXmFB+AhyKA0qDj8klKbz/+pKWlHA3bMwmk2S8mTSj+Y6l
         UZnyyJj+Ze3alkvB7XfPTEu56lM/RmCFs6IGiE1jFQOXcpGI3MPNOyZySeilf+WJmmoo
         jA8xR70zpjPMwy8ykQx4wyqiuWtpjQXRIGCcNl7kFqT7N8+B+cye3EVGZG/PzqV1D2xO
         o5pU4ndfxmR5QlYq6sk6EtqYCdiyl+EkP47AkgtxO1ISTkRKays8Q/DkBP6H75BQD07v
         z3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783645643; x=1784250443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eLuU5HyvYLKGf+ae1L1IKeF030+aNKovcX3x67WIV9M=;
        b=XZmcbj+IqADkxPyYG3Bgb19wq7Vbq0+EUB5m7U+m1A6Ba4R/QGgkgaUg/jBfnk8/e1
         tjqHmo4DC/Xfw18NOzpEWNfaxvEOuPAnx4GOro2xUgTINeHW1r5N1Na3VbS6WV9PzlEA
         uuEnlyi+uQKItFGCO1hxJSOlnf25G1HM+FbP7J37HQLWmna/fNXnYBzK5hKExRhcyJH1
         azhZt6W+hNE6dTnmF2hyX++39xNwaad7IU7+X29lmRh7LyDYfIYnYyttdOcmnLax1hcT
         MNpqQvlfGqqwJzKMD0I7DMRCULLTPpRamS6AB6HAdEaIgOxUotXX3sNKB2SAbl7bQ5U0
         upxg==
X-Forwarded-Encrypted: i=1; AHgh+RodJLbigW9+TI5oHkw1OLObTyQiDj9otdKuohGW1ZsezC6oHhfcLGbj3kxIvylcpF7bChMnl2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSo/dhtDKpWFQuXHBGjJlmHV/dPph3152uPB9twqI3xKLGILL
	cyCRdisMEao9MVUrfFYbyq5yOVmw3FUv6elthXJKTcNVKYNbYpEx2+od
X-Gm-Gg: AfdE7ckwRRf8uzHbQYxBxP3CAMjsH2u1T0QwC9FYiGEr6yNsepbpCpfY30Cvq4mpKiU
	U5VFx8K7gKNwFLikrLmu9UKorBbO0Fzi96LYcCL30d0/aySDoTB9Yud6jyNWtIcYgloP1wtS+en
	/XxyeKd5hoZAlQB6izDP9qb2e7jfXdLgy+JFSjkfjijRWa26HtsjbnK4G2ODta+IfP6VwGTkSME
	AOvWPDIfIEjMV31wVzpgQa7nvKM2wBqTeOS6qQJ/m4L9ROGLO+qxLEqIF14hh1DiwZl2DdFMmSX
	Gf3SWaBLzPABtI52YP2Fpl6MiEIapLLgZO94QaGv7uT1c3Oto7CQktwlroOqjcWCiKAlUTx/iq1
	Y1TjurlM4zJzUckelP4vqVbboaRilM+VIDBWBoK4coJi9C96jvz14/4OumWrbq8shZNKb9rNmCA
	CPik6O7J3I7iNU570otV+EiQgg1KYhgA==
X-Received: by 2002:a05:6a00:8c4:b0:848:2f6e:e537 with SMTP id d2e1a72fcca58-8484324633bmr8250058b3a.75.1783645642610;
        Thu, 09 Jul 2026 18:07:22 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8486768c89dsm1197847b3a.17.2026.07.09.18.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 18:07:22 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] sctp: validate stream count in sctp_process_strreset_inreq()
Date: Thu,  9 Jul 2026 21:07:18 -0400
Message-ID: <20260710010718.20318-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,microsoft.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-306400-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:blbllhy@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[blbllhy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9C8F736785

When processing a RESET_IN_REQUEST from a peer,
sctp_process_strreset_inreq() derives the stream count from the
parameter length but does not check whether the resulting
RESET_OUT_REQUEST would exceed SCTP_MAX_CHUNK_LEN.

The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes
larger than the IN request header (sctp_strreset_inreq, 8 bytes).
Generally, the IP payload is bounded to 65535 bytes, so the stream
list cannot be large enough to trigger the overflow. However, on
interfaces with MTU > 65535 (e.g., loopback with IPv6 jumbograms), a
stream list that fits within the incoming IN parameter can cause a
__u16 overflow in sctp_make_strreset_req() when computing the OUT
request size, leading to an undersized skb allocation and a kernel
BUG:

  net/core/skbuff.c:207         skb_panic
  net/core/skbuff.c:2625        skb_put
  net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
  net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
  net/sctp/stream.c:655         sctp_process_strreset_inreq

The local setsockopt path validates the generated reset request size.
However, for an incoming-only reset, it accounts for the smaller IN
request even though the peer must generate an OUT request with the same
stream list. Such a request cannot be completed successfully by the
peer.

Reject peer IN requests whose corresponding OUT request would exceed
SCTP_MAX_CHUNK_LEN. Also tighten the local check so it does not send an
IN request that would require an oversized OUT request from the peer.

Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Reset Request Parameter")
Reported-by: AutonomousCodeSecurity@microsoft.com
Closes: https://lore.kernel.org/all/20260707203215.2752-1-blbllhy@gmail.com/
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2: Add the OUT request length check to the send path, as suggested by Xin Long.

 net/sctp/stream.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 5c2fdedea088..34ffe6c945a4 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association *asoc,
 					goto out;
 
 			param_len += str_nums * sizeof(__u16) +
-				     sizeof(struct sctp_strreset_inreq);
+				     (out ? sizeof(struct sctp_strreset_inreq)
+					  : sizeof(struct sctp_strreset_outreq));
 		}
 
 		if (param_len > SCTP_MAX_CHUNK_LEN -
@@ -639,6 +640,9 @@ struct sctp_chunk *sctp_process_strreset_inreq(
 
 	nums = (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16);
 	str_p = inreq->list_of_streams;
+	if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
+	    SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
+		goto out;
 	for (i = 0; i < nums; i++) {
 		if (ntohs(str_p[i]) >= stream->outcnt) {
 			result = SCTP_STRRESET_ERR_WRONG_SSN;
-- 
2.53.0


