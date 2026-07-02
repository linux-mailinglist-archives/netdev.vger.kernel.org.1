Return-Path: <netdev+bounces-304290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t3HhIAzqRmrRfQsAu9opvQ
	(envelope-from <netdev+bounces-304290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:45:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D966FD47C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:45:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=IyiuWIvl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304290-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDD5830038F7
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ACD3CF970;
	Thu,  2 Jul 2026 22:45:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF43C3450
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:45:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032328; cv=none; b=tRcwPF81pQLlk7rjnWBeu9fKGrGqG6m+tHVif4l+R/bHmIunqPyDEn9Q3VoKaxoOviM8MrxJslQcK/NLjnt24GnYfEVCHyAedNgDbVEBMdFM4CwkLtWK+PKH68D6pOFbhYPEQYDoqxXA4+h4l+dIWOHFYa9w1t2UI/JyaadyLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032328; c=relaxed/simple;
	bh=+M1GzHyW7gJgudBBznLhu6y63r1NCucH+dqtSspIMXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jef4MIR1me9msGp2bUkMzPlS9V5YS35AjBrvAa02ILxndReooCP/kj15f8XMeNgCbgIHvtnCUxzAcYMXsR2pxsVQoCZYB6lVmFnc+RQffBlStcrOjDW7I73uH6ybFxzdCbZu72auMtGWyMXz4wjrpC1hdEUmGzohGHHC1H8vNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=IyiuWIvl; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso2041614a91.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783032325; x=1783637125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDtU2YibaniqMnLc/xn/Zbnq7zTtWrI58XmXirUM2qw=;
        b=IyiuWIvlgi2oTGMxssP4AG0+Rh1ESl1+U9ePSqhCf2zLSPR8tSqz3sK5KudbbBHXBl
         /FG0pJuVGTRD0s8PB389UIL086Y+8B4i/7oYuVALq5xS8uOqqeVPH4ERMKfkKY/OszzU
         dJZfPj71fW/RR85eMTvk/awF0TjiQnOIdyDLbs0MrjAvquX3g5lHUHWnJL3aQIMsJ2A8
         5iDj1g20c5zrMw3eHmj7lk1EMH3nIQxZtkbU/HgFoyD8bcA/ZYLqK/MIekHNPDys+HZZ
         AfNX8xBrrjuMXsaWJ8o5SDVHThAY7to5/qNvvuZp7HsOGdYVKxrrQtkZc2u7H0F1c+MT
         GDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032325; x=1783637125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDtU2YibaniqMnLc/xn/Zbnq7zTtWrI58XmXirUM2qw=;
        b=qKh0CS7SMJrnKihupuJxzph4c3ydMXIQKHCs9l1awyrxuU+zMMHHk5KYTRXzWcIuLU
         fm4ejv+MK2GHJhwsJrn69Ji9QGONOMTV8jvv0Xy8SfQwEqpiJMH7BeTVxJlEtSJ9ZAcY
         kOowr45K9l0pJrRVjzWFc/BQqDNMsCpnEap/S7QBU5GWLY9McIQcBtILTatkq2a/PPl9
         EZBLWS/ZcyAptO8EmNfsWnf3ZgO97HBqL75wmhpFyyGw93iz4yResjPODG4JShBjDOMU
         mbI9i1HlQOnSLGDLQV0VLtTFqjBW7kgaJBs7xRDTf5pMF5R751+dquZOGefENQVuDMxx
         ksEA==
X-Gm-Message-State: AOJu0YzEdwAyLsDZH69W0mKhUI324P89hfdtR0Y9fCnd9YD3dn9bORRt
	YAybd4+GyVgt5FOthsSQq1Kf4z8TcTgjShblQfLU5DcNyyGMfL6n4BAElhjZTZW4pg==
X-Gm-Gg: AfdE7cmsN4UaeYAehD3U9k/UsObjC6znDmaxjou9XCzwl5S2ntcVKN6vhnKcsATrxOt
	BecImXUMoedJB+sJ8vf+DFBkW375b8lXQywlmi7qCIrilAFVcRD6Qu6l17DONH3DkYlQfLtjQMr
	jRAcH4oX3Y7XoT6gb5T2Acubns9qvwLY2yagsCxxF6lestsNg1cfUI/TjbDzsoEfYPwgEq4RFk8
	pTWf3zXMzSuYfurPx6pgztzJBOvQoXf3+giRjNSfNA76iQRZYWtEVK2BTQH9d3buSSSYWjUW565
	aQBdGYUW4+3ME0gm9t35CIA8rYZJY0W41s9d6toTXQ72oj0xXNbp7Xz7BmY/lfqd6BEOA8N2mmO
	a0PgY4d9vfKptFr2WmlNcdF1xie5lAjSiDFwC5B5w2jBc2INnPXc72qRXeltebpASbFC6hlpDHI
	8HvWdgx1OMhwCAyvJuvg==
X-Received: by 2002:a17:90b:3502:b0:36b:944b:fd81 with SMTP id 98e67ed59e1d1-380ba80ebf3mr7702968a91.4.1783032324591;
        Thu, 02 Jul 2026 15:45:24 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1595e912sm10649247eec.31.2026.07.02.15.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:45:23 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	aditi.ghag@isovalent.com,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
Date: Thu,  2 Jul 2026 22:45:19 +0000
Message-ID: <20260702224519.800135-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304290-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,kernel.org,etsalapatis.com,gmail.com,fomichev.me,isovalent.com,microsoft.com,linux.microsoft.com,asu.edu];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:aditi.ghag@isovalent.com,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9D966FD47C

bpf_sock_destroy() casts its struct sock_common * argument to a full
struct sock and reads sk->sk_protocol. The BPF tcp iterator can pass a
TIME_WAIT or NEW_SYN_RECV mini-socket, which only embeds a sock_common
prefix. Unlike sk_prot (which aliases skc_prot inside sock_common),
sk_protocol lives beyond that prefix, so the read goes out of bounds of
the small tw_sock_TCP object (type confusion).

Reject non-full sockets with sk_fullsock() before touching any
full-sock field. sk_fullsock() only reads sk_state (in sock_common),
and these mini-sockets have no ->diag_destroy(), This matches the other
sock_common consumers in this file, e.g. bpf_skc_to_tcp_sock(), which 
already sk_fullsock() before reading sk_protocol.

  BUG: KASAN: slab-out-of-bounds in bpf_sock_destroy (net/core/filter.c:12673)
  Read of size 2 at addr ffff888013ffc71c by task exploit/143
  Call Trace:
   kasan_report (mm/kasan/report.c:595)
   bpf_sock_destroy (net/core/filter.c:12673)
   bpf_prog_8b5bd55c189cabc9_sock_destroy_tw+0x31/0x3e
   bpf_iter_run_prog (kernel/bpf/bpf_iter.c:697)
   bpf_iter_tcp_seq_show (net/ipv4/tcp_ipv4.c:3247)
   bpf_seq_read (kernel/bpf/bpf_iter.c:184)
   vfs_read (fs/read_write.c:572)
   ksys_read (fs/read_write.c:716)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  ...
  The buggy address belongs to the object at ffff888013ffc640
   which belongs to the cache tw_sock_TCP of size 256
  The buggy address is located 220 bytes inside of
   allocated 256-byte region [ffff888013ffc640, ffff888013ffc740)

Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 69ec1a4c0f9d..a0fcafb08b96 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
 {
 	struct sock *sk = (struct sock *)sock;
 
+	if (!sk_fullsock(sk))
+		return -EOPNOTSUPP;
+
 	/* The locking semantics that allow for synchronous execution of the
 	 * destroy handlers are only supported for TCP and UDP.
 	 * Supporting protocols will need to acquire sock lock in the BPF context
-- 
2.43.0


