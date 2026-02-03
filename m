Return-Path: <netdev+bounces-256455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TEt2CmpUgmmuSQMAu9opvQ
	(envelope-from <netdev+bounces-256455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:02:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB21DE559
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E3430A2903
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 20:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82EC34D934;
	Tue,  3 Feb 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USF4va27"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809152FDC29
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770148965; cv=none; b=KcNmWeP7MJCeXEVP5Kvg30Zo1QbE3lUtGddPs6ae0hONSWd/yhAGlcCjhSwzYixfixnjqG0B5KZZZkiAPoI/JwAy/ISlvaYpQ0OQppBxlDVLIR5F12q4nmagDLFA9hvixX9OEtcgUTg9/O4LrBlxmbsBDc1tYe35x2F9pdpL0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770148965; c=relaxed/simple;
	bh=M02wuj7dQBeNDh5EnBEnzH9wOuvFcVq5LO80sKSrTIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AhW0eV09x33X6BQ+909FMglwukoUzXJijQuOfsiXbl6PlDLXSWkSUXjXMs2DBfZVyuu21jOmSw52eCsmoY5ZK7eXk7LkThEptjL8uW3lNCXJAW4OpNY/6YjMN181S/sYIi8CbXz0pNPhncJxZ5z5Dq5AuCXon47ChrQWzQQ9ddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USF4va27; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-352e6fcd72dso10585307a91.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 12:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770148964; x=1770753764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=58vpAXhIDs5lQirqOw7wql3Y51LdDMCZyU1M/Hgn72A=;
        b=USF4va27vFuU5gTD2E3+9XjcgZJNHEz3xPOnQEgHp9F+L+gt6Qa+fzSq9ewU1UyaF7
         h3EiLHWq110TT9QWohP1aUIIhp+YsU8SYa2Lk5CXI/3TOoxNHSclu5zqT3zIQuwkJgnN
         VTSqjl35zZw5gwmk/qeaZhtj30uggJc0ccTB2km7LyffBd79xx+4qTxy2Gbue7BF/gdx
         qN80uCrFmIr78MqfGVWQ57WV7z401S9iu8HFlA9OxrQLBfgd8HEu6DZ3B2ygO9FWQnLY
         qtv4kWjWiQlj/12arz4mWS12xjb8exbbz1EuWFMfUP8firxnh8s+r1HxA9P1ze29otBR
         sfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770148964; x=1770753764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58vpAXhIDs5lQirqOw7wql3Y51LdDMCZyU1M/Hgn72A=;
        b=XTieKNMiTwmcGnVpeR1kr/Yflj8oT5FURBvgx0G79bodHmrwIFytBNc0jqnhLLXLAE
         EXRZYyeFevRRmcq+OgDcqhGVTqLozmLqXrO/jjaQbW/VmZFu7CiwVgyrs92gb6EjLWja
         M06gA7eD6XiTWwaGsFIf/K/zcdM1MWGIKY8YyGIscpH8rZUHfi63K9D7jzxInFzUPjys
         6drsOXr9+zKmuGznetycau3rhnZdqTrpWYbxDcNhrmk8DfLji//PDhnbnZv0OMbe2ElK
         urJ8xviPmNt6pqd5E2KZHMgD4szihpNft3od8LoUKIS3FrOMvEd4jQ3sUs4z/UdCs6N9
         pj4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfcfVkgWxqNE+2HZESmdc8mzVxKvWrDk1u6cSbY/U0U0jheIZUH9YwLz7r8W8i5vae6xBOajM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKMxyCJ3vokEi8qCusb3HsNLslK19inJQwx4q2//E5XpLA+Hlk
	d0EkQKQxScJeIqJOsTO8qTofqCCrJ0bBCcFPqPYoM0kfXIuAWkxKg+YjTRnFajh/Atv9kkJ/Xq/
	F+IY5zQ==
X-Received: from pjbgq23.prod.google.com ([2002:a17:90b:1057:b0:352:f2a4:7e27])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:548c:b0:340:ca7d:936a
 with SMTP id 98e67ed59e1d1-354871ad6dcmr487515a91.18.1770148963801; Tue, 03
 Feb 2026 12:02:43 -0800 (PST)
Date: Tue,  3 Feb 2026 19:47:50 +0000
In-Reply-To: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203200242.404131-1-kuniyu@google.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
From: Kuniyuki Iwashima <kuniyu@google.com>
To: mhal@rbox.co
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	john.fastabend@gmail.com, kuba@kernel.org, kuniyu@google.com, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,iogearbox.net,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,linux.dev,redhat.com];
	TAGGED_FROM(0.00)[bounces-256455-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 8EB21DE559
X-Rspamd-Action: no action

From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 3 Feb 2026 10:57:46 +0100
> On 2/3/26 04:53, Martin KaFai Lau wrote:
> > On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >> In related news, looks like bpf_iter_unix_seq_show() is missing
> >> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). E.g.
> >> bpf iterator can grab unix_sock::peer as it is being released.
> > 
> > If the concern is the bpf iterator prog may use a released unix_peer(sk) 
> > pointer, it should be fine. The unix_peer(sk) pointer is not a trusted 
> > pointer to the bpf prog, so nothing bad will happen other than 
> > potentially reading incorrect values.
> 
> But if the prog passes a released peer pointer to a bpf helper:
> 
> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> Read of size 1 at addr ffff888110654c92 by task test_progs/1936

Can you cook a patch for this ? probably like below

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 02ebad6afac7..9c7e9fbde362 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 		return 0;
 
 	slow = lock_sock_fast(sk);
+	unix_state_lock(sk);
 
-	if (unlikely(sk_unhashed(sk))) {
+	if (unlikely(sock_flag(other, SOCK_DEAD))) {
 		ret = SEQ_SKIP;
 		goto unlock;
 	}
@@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
 	prog = bpf_iter_get_info(&meta, false);
 	ret = unix_prog_seq_show(prog, &meta, v, uid);
 unlock:
+	unix_staet_unlock(sk);
 	unlock_sock_fast(sk, slow);
 	return ret;
 }
---8<---

Thanks!

