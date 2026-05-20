Return-Path: <netdev+bounces-289764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C1aKoo/DWoxvAUAu9opvQ
	(envelope-from <netdev+bounces-289764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:58:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14554587A79
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21B83045A88
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7541A8F7B;
	Wed, 20 May 2026 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGzUfnH4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E781624D5
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253126; cv=none; b=R3Z1wPuxPoRqzJhV1h1mkgRHxxIx/lb7myqTWyUhq7iaeuPjdEeXeQhtUIOddAhJCwYKOtML+zqlh66lwMsBz1EFAsoXhAZ8g4WTckFRRuPBMCGJZAVwYqrymwJpIvMYWYfLdjGyIP8Ix9Sadbj6h8cCK/JlQluXnAQt4Y1eQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253126; c=relaxed/simple;
	bh=XUSMYp4M20HINuGxpU42OOWWOj0UJ3oN4Zs7jdBvuNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwKj203Ddt9pz2k85ixEHZ3pIZtZO6cg7PqJdJndn88erZ+3HQSm95YnbcKVfg6iB1TdK+tn9GtOrLodspiudyJ4zUk7o09oXrrW1DNlcryUI0FZKMkZ3xbhV456XvFkAMUZINCdSWrEvwsNLrxTvnWrL5R3EmKkzMz5EB6GWa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGzUfnH4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso45697125ad.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779253124; x=1779857924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6qQDxteP5DKPD6F1tvEYOWss8S5fYFMu8G8cmEQyncE=;
        b=RGzUfnH4sNGfnw6XA2x3iLOc2v1IAthl3f6BCqx4SUgW2S6/IsfqLNjGYY2niuv0HY
         VOFvzK4073ZelIsJhxdtWbAemj23eRlqzD0+O2dntiOHSs0QHdHEerUO2/lp9wvzTTo5
         RpSNyy1u6oAS7EsNH/mTEUrZdUzx3HTXD5ES6eHFqWgMOiYPfzo9lmjIvRaFja413v1q
         OnTDTlZVV4zmiiNOQw/L94Evq++V7OJ57tBrEwByVFbPWpgrwmKzwsaC+Pu2oLyhfS8C
         G+Amjarijia0e7Cy+S6/jY0tKZRZqrfPY1HdDTVV47F+Vo+QHWrN+pS3MqTS246ZfjEF
         e5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253124; x=1779857924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qQDxteP5DKPD6F1tvEYOWss8S5fYFMu8G8cmEQyncE=;
        b=rNHg4ujYkZQAo38ZdWMpQUrfwqNugUbwZ71Qr//PYtMoPro5cYBv0rHV7huOMD4pBw
         TaICdN1SUdN9rIubdKozsYMShVjekhWmqH+EuiWbFMQeeqyij+u/V6ev+D6yFJXTHFU5
         blnW1TmYvnGZib4k0dwDktspJHiewBKwb8QUSCtXgROONDDP+lr5vvbr5FB+Af5PwVN/
         ysXM9pLLBrAV+lZmR2Ec0YHkZGglAKJYfp/s+iL+88WVWp7JsP5w50Vkkh7yZisk5vxf
         xxtpALQZZVnAkBDW9XujVVZ7rGPMVSnFrTt8sLdzcw9vOL00+HZ5lCORspnAdQONdqFh
         N0OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6FxoIpOr5g/PRWtSNSZpKviGOnsbHucshEwut/DKsoUV1HR18kMhimS5bLNNBiPchvRwqCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkImekjDVUw4vt9sQ2CFHF8+93HPBwtiDqoEJLuquyf4Qq6slU
	nPMjMBnO9Fk4dDxVplMuVvxbOjYcgR37LePYzNwWWK7yNr8v9OMf3d1I
X-Gm-Gg: Acq92OFL7I2bwfZgEXU0wnIYTRJYpz65g54YQT8S+nd2OnDG2Dij4JmNa4saP6gsMUl
	flSjqGUeu3+czetOZ4IwV9hkxetVjK9EBsV6FtJlpY6IhI8pnS7yJExtWHrNudmV0O7V9GctZP9
	94qF8W7eLM+qAsIbh4f6UJ0l9zHBOYFOC+1132N9Bt2u50JT8K/wU7j3wsF/kadphrGYPs8gTb3
	q0RYJkAV27UOqpdODAy5Tkcofjkt2DQ78gFTz/l7gyYvq6FmSwBiKU6LcmtPq95CAk3hqZ4Pu1J
	0TuJNi6nBiaAeO4yB/OowM43PmgLLpI1yo6mprEH0J4zglkBwEmi6iQBRVRF0lmmkqQEbh4C7tK
	T6jNKQ0ySYw9PfXraDGV0GXHRnSVLQ/sVdeR82y8F9lBjIp4BGZV5BDpDqQcoSrD83+/cpy3+dk
	SOAUS30ULcQePHQl35lURUMgKC5aH2wBYR/Bdtv94=
X-Received: by 2002:a17:903:950:b0:2ba:6ca2:bca with SMTP id d9443c01a7336-2bd7e8c2c39mr234099755ad.26.1779253124290;
        Tue, 19 May 2026 21:58:44 -0700 (PDT)
Received: from fedora ([2001:ee0:4fc8:5b0:526c:3adf:8a0d:13a8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d235e04sm210308165ad.80.2026.05.19.21.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 21:58:43 -0700 (PDT)
From: lazyming <minhnguyen.080505@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: security@kernel.org,
	netdev@vger.kernel.org,
	lazyming <minhnguyen.080505@gmail.com>
Subject: [SECURITY] net/core/skbuff: pskb_carve_inside_nonlinear missing net_zcopy_get on MSG_ZEROCOPY skb -- UAF / LPE
Date: Wed, 20 May 2026 11:58:29 +0700
Message-ID: <20260520045829.134435-1-minhnguyen.080505@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289764-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhnguyen080505@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14554587A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

== Summary ==

pskb_carve_inside_nonlinear() in net/core/skbuff.c copies the
destructor_arg pointer (a ubuf_info / uarg for MSG_ZEROCOPY skbs)
into a freshly-allocated skb_shared_info via memcpy without calling
net_zcopy_get() first. This creates a refcount-less alias that
causes spurious refcount_dec_and_test() calls when the aliased
shinfo is freed, driving uarg->refcnt to zero prematurely and
freeing the ubuf_info_msgzc object while other skbs still hold
live destructor_arg pointers to it. The result is a use-after-free
exploitable for local privilege escalation to root.

I have a working exploit demonstrated on Oracle Linux 10 UEK
(kernel 6.12.0-202.76.4.2.el10uek.x86_64, default install,
unprivileged user) and have confirmed the vulnerable code is
present unchanged in current mainline net/core/skbuff.c.


== Affected Versions ==

All kernel versions that include pskb_carve_inside_nonlinear()
with MSG_ZEROCOPY support. This covers approximately kernel 4.14
onwards. The vulnerable code is present in current mainline.


== Root Cause ==

File:     net/core/skbuff.c
Function: pskb_carve_inside_nonlinear()

The function allocates a new head buffer and copies the old
skb_shared_info header into it:

    memcpy((struct skb_shared_info *)(data + size),
           skb_shinfo(skb),
           offsetof(struct skb_shared_info, frags[0]));

This copies destructor_arg = uarg into the new shinfo without
calling net_zcopy_get(uarg). The new shinfo now holds a pointer
to uarg with no backing refcount.

The correct pattern, as used in skb_clone() and
skb_zerocopy_clone(), is:

    if (skb_zcopy(skb))
        net_zcopy_get(skb_zcopy(skb));

The intended safety net skb_orphan_frags() immediately after
the memcpy is permanently disabled for MSG_ZEROCOPY skbs
because msg_zerocopy_alloc() always sets SKBFL_DONT_ORPHAN.


== Trigger Path ==

The only in-tree path reaching pskb_carve_inside_nonlinear()
from unprivileged userspace:

    rds_tcp_data_recv()        net/rds/tcp_recv.c
      pskb_extract(head, off, to_copy, gfp)
        skb_clone(head)
        pskb_carve(clone, off)
          pskb_carve_inside_nonlinear(clone, off)  <- BUG

When GRO builds a frag_list (triggered when
nr_frags(head) + nr_frags(incoming_skb) > MAX_SKB_FRAGS = 17),
pskb_carve_inside_nonlinear() is called twice per pskb_extract()
call: once on the head clone (alias #1) and once on an
entry_clone created by pskb_carve_frag_list() (alias #2). Both
aliases fire spurious decrements when the carved skb is freed
at recvmsg time.

The frag_list overflow is made deterministic by setting:
  - tcp_rmem with a large default window so each TX skb
    carries 16 frags (16+16=32 > MAX_SKB_FRAGS=17)
  - GRO enabled on the veth interface (ETHTOOL_SGRO)
  - NAPI threaded mode on veth (threaded=1) to batch GRO

All three settings are reachable from an unprivileged
user namespace.


== Preconditions ==

  CONFIG_RDS=m  (default in major distributions)
  CONFIG_RDS_TCP=m
  SO_ZEROCOPY socket option support

On Oracle Linux 10 UEK the rds_tcp module auto-loads via
socket(AF_RDS, SOCK_SEQPACKET, 0) without any privilege.
On Fedora and Debian the module is blacklisted by default
but compiled as =m and exploitable if the blacklist is absent.


== Proof of Concept ==

I have a video demonstration showing full privilege escalation
from an unprivileged user to root on a fresh default Oracle
Linux 10 UEK installation (minimal install, fully updated,
no configuration changes). Available on request.

Working exploit source code also available on request.


lazyming
minhnguyen.080505@gmail.com

