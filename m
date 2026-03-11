Return-Path: <netdev+bounces-266513-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG8SBBglsWmvrQIAu9opvQ
	(envelope-from <netdev+bounces-266513-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:17:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 937F625ED23
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C3B033762AB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DFC3BC66A;
	Wed, 11 Mar 2026 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1CsQpNo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA43B7751
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215796; cv=none; b=KFhDeeG1plKxf7kw0akIWvCuRj4O9mWWvsZDBciQSiBIwslk8qC3DRpjcAccrRK3HFTDoSa/1wMPRNxHa5VohohZgl9Z79q3BM28NKANPGfLG2YIhEwEEVnqDqLXHUSeecMHEScDcd1i4hCsWcsPPviUgSGXxAyS8N/f/BylZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215796; c=relaxed/simple;
	bh=jPhrqcmDRhUMlM7YZP0Vfe8I9hineTPoN8bOhKWBAv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2VCKlbWtzqy1krMQ+23CP/CAkzcduvmDHUvndy8PNc0lNPxKoXVH6zQJBH00+2cPswZiS42bpgTdgYwldxCz2oECaSxPy9THmKHXnLFEGfagghNIpEU4Inm++he+xEVHZpHi+Z3jPFCjMOKIzJbpNXgmIAdPo/v5N5dzCQwmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1CsQpNo; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f387a688dso6998446fac.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215791; x=1773820591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wacSMrdd6YBSycXcvfypm/nD64eKKUdf2M/29BZscYc=;
        b=S1CsQpNohQf8dC1hcEbbvhhBIN0GGWYdx7VS/SnXvB6+7d4ONkyBsj1dWWoinKVXlz
         diWGDrpkVpvYnWp/QVF0lVnF8qLNRFIjIXx/aaltrDAwz/ypULZjOh09j78TUEX/NuEr
         QyyT29asTIHqmd1JGj/Ja3eRRxvZKIbICFOFa2oRna5Ra/BBh9LKWuFakqVC53uDINgr
         WJs//TuoM2pjPTtGaPia/aOcf1pNXF9CAFNg9UcMH7H8buLuRxV5jLMKCdZRnBMyfrsb
         lgrTVtRkAx+oOROD0aiFAWM9Y3iNMLjNbGrKKAMJwdduuYz8iRq4yimGwMsI8f4/qgXh
         bNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215791; x=1773820591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wacSMrdd6YBSycXcvfypm/nD64eKKUdf2M/29BZscYc=;
        b=jOutRyl7bUr1oAoG9S4UZCQK1OurPifZgGnyktIegk0K6bZXhnRNeT7WHPDosRhP6S
         F3HizrSlmEK9YljN7R01DDpzqQYlHlt07GGYdMR3TD2CPbd7pWWyiVq5v8deoSZSf0La
         TtbHgOnk0Yr3JbWVC6Cg4udO2wCf4tGHv3i8oKnUheo0xZCMkgzDksLyctPLPYV5D0+7
         7lZ6bkLyHTStLvoUwLyWiAZ0PDbI+ju4BJV01dzW5eqV5hfSMx5CFApvNkxZ7ky1Q4AD
         GsQ4Rq4pXLTctpArqMi4gKi3elxS19oy1Z31GTYgESzeJJdclUsMBz+tD105mQw4y8gy
         jElw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ84Y37E16S2lJ0jH33EJQ3SW0w7Klc8KIxNa0eRz5SbN3hbTFxkY/s/qCx22hWwhZ/NO/4/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrE372stlYdEdwAzI8BlArnYNH5QdWzZpS0TML1fau169KcEIa
	CmLZasIsiae4BbHpx9zI5ZrO/74VKED1UHGkiHSWavZxLtNJjsAEwTWd
X-Gm-Gg: ATEYQzyjMd0vLjqs0TxSzyLkXuwUhJlr9ICNZt+SrwBM4KCCulJ266CIgoGIGve/hz9
	DmiktMfmY8OPTrtFzjx+au20cH50Xrv4XIDfHCU5PoLxRNHPL395YXWcx9+Uj1BfiVg43gR6c0C
	PiatLNrdK7SawgSq8ows9lrLsJkqgglpquUqarICOBzi80Z+cuWBtTIpV3iDPyphI8RTDtW897U
	9XW/dicm7Q94OJqjWVuzgU8iXT16wh2POil3e/HrPSdtEMUoSTxyScog3roAk59TgsUM3Cd5Tb9
	tOKOtCSNZeB7fTGt0PKvHPea0KKXdtkmv1AiGm7gVt/V1lu4PX2B1mTzGJrE0ZBkKykOzkvyR5X
	hvmIFp9qhmXe1nbyzZYH20Z4f4eMn71xQo37Ar5DkSGTjL/fo7SqXi4YDYKzrWtWZYgtByxuXRl
	ZuEIAEhhSpL0khGLqiotxpyQrMuggU6ogOykIOEOWK0Z/NbdVE3aLPM4Z0PKvZ9kNdsr49XA8fC
	DCsGgpn3GLuIE5RyRZJMcCuZHVB69tsJ/2F9NUlcrvWCHX2
X-Received: by 2002:a05:6870:91cb:b0:3e8:8e56:674b with SMTP id 586e51a60fabf-4177ca09363mr1118957fac.53.1773215791030;
        Wed, 11 Mar 2026 00:56:31 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:30 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 2/7] tcp: preserve rcv_wnd snapshot when updating advertised windows
Date: Wed, 11 Mar 2026 01:55:55 -0600
Message-Id: <20260311075600.948413-3-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311075600.948413-1-atwellwea@gmail.com>
References: <20260311075600.948413-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 937F625ED23
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266513-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Once tp->rcv_wnd carries paired snapshot semantics, every write of the
advertised window has to refresh the snapshot at the same time.

Convert the active-open, passive-open, and normal advertised-window
update sites to use tcp_set_rcv_wnd(). This keeps new sockets and later
window advertisements initialized with a valid advertise-time basis
before the receive-memory logic starts consuming it.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index dafb63b923d0..ae8a466b5298 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -603,7 +603,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	newtp->rx_opt.sack_ok = ireq->sack_ok;
 	newtp->window_clamp = req->rsk_window_clamp;
 	newtp->rcv_ssthresh = req->rsk_rcv_wnd;
-	newtp->rcv_wnd = req->rsk_rcv_wnd;
+	tcp_set_rcv_wnd(newtp, req->rsk_rcv_wnd);
 	newtp->rx_opt.wscale_ok = ireq->wscale_ok;
 	if (newtp->rx_opt.wscale_ok) {
 		newtp->rx_opt.snd_wscale = ireq->snd_wscale;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 326b58ff1118..c1b94d67d8fe 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -291,7 +291,7 @@ static u16 tcp_select_window(struct sock *sk)
 	 */
 	if (unlikely(inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM)) {
 		tp->pred_flags = 0;
-		tp->rcv_wnd = 0;
+		tcp_set_rcv_wnd(tp, 0);
 		tp->rcv_wup = tp->rcv_nxt;
 		return 0;
 	}
@@ -314,7 +314,7 @@ static u16 tcp_select_window(struct sock *sk)
 		}
 	}
 
-	tp->rcv_wnd = new_win;
+	tcp_set_rcv_wnd(tp, new_win);
 	tp->rcv_wup = tp->rcv_nxt;
 
 	/* Make sure we do not exceed the maximum possible
@@ -4150,6 +4150,10 @@ static void tcp_connect_init(struct sock *sk)
 				  READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_window_scaling),
 				  &rcv_wscale,
 				  rcv_wnd);
+	/* tcp_select_initial_window() filled tp->rcv_wnd through its out-param,
+	 * so snapshot the scaling_ratio we will use for that initial rwnd.
+	 */
+	tcp_set_rcv_wnd(tp, tp->rcv_wnd);
 
 	tp->rx_opt.rcv_wscale = rcv_wscale;
 	tp->rcv_ssthresh = tp->rcv_wnd;
-- 
2.34.1


