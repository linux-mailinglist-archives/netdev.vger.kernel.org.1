Return-Path: <netdev+bounces-279418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDKIAeWh4mmv8QAAu9opvQ
	(envelope-from <netdev+bounces-279418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 899D641E9DC
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45D5F30398A2
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C0332909;
	Fri, 17 Apr 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMyqQ1xy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87632BEFFF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460184; cv=none; b=j/Or0FudyLqQ8n2ocdux5E9YlVjOjFv796wvNgzuZwCNCDIvE5haLzj2rng/pxcDzNPbBd55tlY5WtWUFLpodGJihJr6XHT1eqSyonXMH0/YBBP81ma76shs+05fOciiLSzckm+ap0EUy4GMTRBzmQ+KJwFdL2aju/unkeH5R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460184; c=relaxed/simple;
	bh=Ojb9tsYidH7+XlNxOvXN5yHkq9jgOnNphzNBOPjr5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkuwl0Bly7lT8VrP//lrAStR6A9fFRJ9jc21TkmkYhwHzgQSKrMwd6UJ6+zZGbEBA24UL3seZxg/+afmlTFhEMDEyPlxauudhPJZWmghWRhap19ntIK0l7INu85G/iPgICAvaYUaKOS9EUKqlNSdGVBfiAFBWjFOWOHtWdRxqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMyqQ1xy; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a068db9989so20175686d6.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776460182; x=1777064982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/ceKS4zZANLPnvM8/t1TovHGT4+al4Wc8t9XoY5Y70=;
        b=lMyqQ1xyBiiBwVz/jLChmAAAu746gjNC7YXUltblMKgdUMfNedQz0PMc3am6cmykLH
         xFeHmQR8ZUTn8jyiM3GxnHe80mVgVRx9fasP9GQBgZPhINmWv+Jh13MRxS1Nah3+/fpi
         XSysG5/vs7VOqLg/zWfGUsrWnu5X3YZlJHzzr3CyumkRP2oBh7EwDFPqmchasOBMNbrE
         7p1ULqgdKSsePj8Ts+EbEi2emC3a9Puqvr2tjp2qOU62h84qpyeTb/XB8sjpk/Xqkm9q
         11U9sSN1SXPO/uby8vOKYEeFqjpAWhdfNcV5otzP2oh16hCbK8elLCS4f/prHz8LILrR
         jXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776460182; x=1777064982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/ceKS4zZANLPnvM8/t1TovHGT4+al4Wc8t9XoY5Y70=;
        b=nEfe6BDIc3W1kOk1QdskqC+Tg60KMSHA/6lxCWQPx6yBYjCEJoFC/NeuPWKol9ISm2
         kB+senDmOg+BQKYIsb2HRFmdbJdpGMmxeH202BKF9zYqLCqRV4o446l9J6Q3/2Lw2Gg8
         fNWf8WAdWvPjxWML2GjLnv5Bm0d+ZMvih0ds21OQdRuUP+tshbG1RAhGUMOoLXjTqCeB
         VFl6L2fdFKWx2Evj8v6LuhGpIqZugSYHTKMYLg+oJQjhnKUBbWiXO0A7L8CVxMu7uKK9
         jFTdlKreW7e5wmFUe2qj1qEpU7rj3fXl+4mqlm0jwOG+JdBEWn4ZWG3vypJF9WnQMQu1
         nrig==
X-Gm-Message-State: AOJu0YwEnjZvEKwoPkJGvt1BZ6sbrxg4WMrutx2fru9NP5sJTWZLe/K9
	P9ANYblHmKWbFeyAGbc4/TsdpffY6Lens669wdxLAbDTeN2Frm5NTYOflgO4OQ==
X-Gm-Gg: AeBDieu/uuf9wrdgXme/Ao/2VGZyJf7y5jfPQzSnsJtZX2ICD/7vxXoYIMQf7iV1vw6
	9c+FIrpm8ujPtfh2J1Wbd2Ai/wAiZtFmBosdsfuqQ/hXcPlZPKywhHLf/1ULp1Hw5JuEr4kMz8M
	sOrMLu4ANo6/Qoz5sAAXXRNoSJ0qzfM7H2tRnBnAB5fwm0VBawQ2y3aigAzQcnNOsHc5u1cjB3V
	H/h6d42SnstPu8YHMKeW+gZE6Yc/2Yl9V8/+kFvs3sA/WwnS+y9CHVGZmA6dDI/EjrYvRrJQsPs
	XRxspkj0XiMdUquoh1B97KkIIj4TTXS4TRLTgM7ymXloFNsmlqcv4638fCP3JHsQWXkQfPMbIM/
	TtrwiiZMubIP4Ekk7pTutvkmTxmW3L6E9OGU8Eii6QJqcbY8/0FpAd7EVVfTfGoq8OEwc+FZh4i
	hiozRNJFCecLbDcgEz32UnO2TTR1Bxw1VLM1cdREk41ia1pQfWn+JZOey9VnBd/NLUZQN73rsbb
	pBCFLVy5WVjtDjgpCyt7+eKHg1TZPNU1if42ouP8DBy4O7JMwG0JcO4q+vOHMr/H847hwxa9nzG
	pKwxsMLSyZI=
X-Received: by 2002:ad4:576b:0:b0:8ac:b0d8:65f3 with SMTP id 6a1803df08f44-8b0287779f3mr62616686d6.21.1776460182211;
        Fri, 17 Apr 2026 14:09:42 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm19087246d6.4.2026.04.17.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:09:41 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net] sctp: fix sockets_allocated imbalance after sk_clone()
Date: Fri, 17 Apr 2026 17:09:40 -0400
Message-ID: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279418-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 899D641E9DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_clone() increments sockets_allocated and sets the socket refcount to 2.
SCTP performs additional accounting in sctp_clone_sock(), so the clone-time
increment must be undone to avoid double counting.

Note we cannot simply remove the SCTP-side increment, because the SCTP
destroy path in sctp_destroy_sock() only decrements sockets_allocated when
sp->ep is set, which may not be true for all failure paths in
sctp_clone_sock().

Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d2665bbd41a2..d0e7048230c0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4855,8 +4855,9 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 	if (!newsk)
 		return ERR_PTR(err);
 
-	/* sk_clone() sets refcnt to 2 */
+	/* sk_clone() sets refcnt to 2 and increments sockets_allocated */
 	sock_put(newsk);
+	sk_sockets_allocated_dec(newsk);
 
 	newinet = inet_sk(newsk);
 	newsp = sctp_sk(newsk);
-- 
2.47.1


