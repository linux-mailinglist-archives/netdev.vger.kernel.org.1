Return-Path: <netdev+bounces-304763-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0m3AI481Smqx/QAAu9opvQ
	(envelope-from <netdev+bounces-304763-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 12:44:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC50709C52
	for <lists+netdev@lfdr.de>; Sun, 05 Jul 2026 12:44:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lRvj2cr7;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304763-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304763-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BE6300DE04
	for <lists+netdev@lfdr.de>; Sun,  5 Jul 2026 10:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174E53002DC;
	Sun,  5 Jul 2026 10:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA20D26C3B0
	for <netdev@vger.kernel.org>; Sun,  5 Jul 2026 10:44:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783248267; cv=none; b=fmOfhf1+QADWJ4f2vpOBlB8/7CfiskEHV5EqkZ+R3FNLwSzFP/iEFytkjJt5HSrqujDPS6p67Nb+pFCGYq2ykoLdlDnKRa6aw9FMhKBbjXyla7NibvJFN6A0092eU/CZ20w6zrBq9WKvlZDNkC8KMGWQ+b4XDBFxzrM3OdTdxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783248267; c=relaxed/simple;
	bh=38CR6eEZlel5ICXybLIW+wmULU4fViWqMfqm4lQcE8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfHZ/RD7mhdgUnC93yZN79sZ0XY8j381u1awpGZcnQkhPHjyFh+7amEsntitIlyn7TC3KyJbriAGlKpPqGXO7iHhYxG5605VWspMnBVZevOzZv5Ad1gsYgUx8bw5mALPT1AHHB/duLAd1pf88TTLXK/8LLxcQ5/yeGheW8jvZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRvj2cr7; arc=none smtp.client-ip=209.85.221.42
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-474303f3c72so1146346f8f.0
        for <netdev@vger.kernel.org>; Sun, 05 Jul 2026 03:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783248264; x=1783853064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uX2VFgckLdfB8tmgvyAwVGZ/Rc9I1lvW+lnjyktnm7Q=;
        b=lRvj2cr7zZKaTlthQNbnnSxOmhNnhZBi0VpGqwgJydkJyXecah2LWrZUjsahQoRbMk
         rdNEGPDqInpmiSNyO6BnbdhlhKsNo03LgQo7DcXyqCptrq8/BB1ce4NVrNXnoKswKaxS
         scAz1QRf8qSr2q85aZEKN8qfpCDy6PDLiECs3M/lwxVPBEr+J7rUChNTMVsGJrVRPuwq
         UBT0hWPJIOxTxLcGTXdulXwdXV1EQjwBg9JQLotzfKrhPp1j+KSWxndVS9ZZokCO7p5z
         ViJHIy5IKZ5q9geBs3od1imm+ISYysHaF/B5VVNNRaMQAQ2ut09G4rVG9dFvxHAh07WA
         qShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783248264; x=1783853064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uX2VFgckLdfB8tmgvyAwVGZ/Rc9I1lvW+lnjyktnm7Q=;
        b=HxXiEpDv0MsdbJYXyUgCVvV0vPeC2aCGS72dBXyII6V5FzEwNHRKscJjD2x9BG/mYF
         U4BPwPR1nhanVF93evR61uAj7sUyMjZYoM53tebS+oI5Aeusbc18TnnOJgUppe4f7bly
         EHcnKow4aYUEVWArDVp051gFc5KCpo3Z5owwXVgoU6E0VuC/VtBEok6x6zknvRyj3TMx
         bapCQ6Vb2sj6t9hHllaENSM2NzfQPr9I7pannlouNGwUDQQpV7qMHLrcY7xQdig4wH7E
         LhWL2rd5EJIDieegSEWSlsQonb/jZtCjVwt43E0Q4Ul54UtEH2tqALYaMdrCLolLHsjX
         YdNA==
X-Forwarded-Encrypted: i=1; AHgh+RrDxqpYPhfIt+leutZnKPirT3dEPtFq1hyK7fMzq1boHPPpc2tHDYACjuoD2WT3vxjLOohQuW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeijhBgRebDYaf26927POOy7O9Qo5onSeUXV6BsrJHDddA1RqJ
	952piWJAZt/+HuLUXnGlKfuhIBPCPTyRRcGyVZ1DCFGICqfMVmfOkcux
X-Gm-Gg: AfdE7cm2BMDdsR2bv2dLdoSRkyLzi8Vw+BeT7K1JK/MUDlKngzssQw1jNeLPITsCccq
	RmguvlZ8l9l4wHShVHVRvkyiHXob6+8pOv4naC0GAx64O8SNCeWYGtgI/Y50DtYHHL4Yw/7FVnA
	TBMH815avfZMxJAr2Wdw1xH8gxhLfwMZXddnBaFivq6rSAEb0PrpKtz2GhCA8Q9ohrw26oh4xU7
	cP0z552wxe2JKjqhO4UVGWHe6Hya5eQOJDXKVRNv9uopEvaFdyn7qdXcKALElv7QhpNhjdtzMQg
	MOmNHFJzehHOgzHuhZ76dtPMr8R0LeWvjj1YxDHcZ7AVJalJBUXLgFxfi3VCJ0k5ga5Bg9cqYzF
	ne83UYoXuqLzNwuX1KkQEnSqYt+kA5UzAXlKpHutaxbA/a1sJHRCRRD+nfaFFdNe3ZbHy2FfuSv
	igYRW+Eq+MHCtJcvXuXr4fTsse4Y4vFRTzbLskt6dxLkiVwuk6LeqHiRHPykdHX3STTGNiSrSmH
	L7FJDVGSwq6y7zcLRpYHgKHM/aob3U5DYN6J/O+BhF72LQ=
X-Received: by 2002:a05:6000:184a:b0:474:cd60:115a with SMTP id ffacd0b85a97d-47aa9791148mr8476675f8f.18.1783248263859;
        Sun, 05 Jul 2026 03:44:23 -0700 (PDT)
Received: from localhost.localdomain (p200300fbef0484005c11e59738f92b15.dip0.t-ipconnect.de. [2003:fb:ef04:8400:5c11:e597:38f9:2b15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e736sm16963903f8f.7.2026.07.05.03.44.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 03:44:21 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@purestorage.com
Cc: borisp@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	leon@kernel.org,
	mbloch@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	sd@queasysnail.net,
	tariqt@nvidia.com
Subject: Re: [PATCH net-next v14 0/9] tls: Add TLS 1.3 hardware offload support
Date: Sun,  5 Jul 2026 12:44:19 +0200
Message-ID: <20260705104419.4014-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260515212715.3151307-1-rjethwani@purestorage.com>
References: <20260515212715.3151307-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-304763-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@purestorage.com,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,vger.kernel.org,redhat.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAC50709C52

Hi Rishikesh, all,

Another NULL deref we hit while testing v14, on the RX resync path. Looks
pre-existing in mlx5e rather than introduced by v14. TLS 1.3 RX HW-kTLS,
mlx5/ConnectX; seen once in ~3 weeks of load:

    BUG: kernel NULL pointer dereference, address: 0000000000000030
    RIP: mlx5e_ktls_handle_rx_skb+0x10a [mlx5_core]
    Call Trace:
     <IRQ>
     mlx5e_build_rx_skb
     mlx5e_handle_rx_cqe_mpwrq
     mlx5e_poll_rx_cq
     mlx5e_napi_poll

It faults in the CQE_TLS_OFFLOAD_RESYNC branch, in resync_update_sn():

    resync_async = tls_offload_ctx_rx(tls_get_ctx(sk))->resync_async;

The NULL is tls_get_ctx(sk) itself: RAX=0 and the faulting instruction is
the priv_ctx_rx load off struct tls_context. CR2=0x30 matches
offsetof(struct tls_context, priv_ctx_rx), and [sk+0x4f8] is
icsk_ulp_data in the matching vmlinux.

So the socket returned by inet_lookup_established() no longer has a TLS
ULP context. resync_update_sn() reads tls_get_ctx(sk) twice: once in
resync_queue_get_psv() just above, which also dereferences it, and again
here, where it is NULL. This looks like icsk_ulp_data being cleared
between the two reads, i.e. RX resync racing TLS ULP teardown. In any
case, the second read is dereferenced without a NULL check.

I can send the full decoded oops or kdump specifics if that helps
narrow it down.

Thanks,
Nils Juenemann

PS: aside from this RX issue the series has been solid here. TLS 1.3
HW-kTLS TX has been running stably above 100 Gbit/s egress (~99.5% of
eligible TX traffic HW-offloaded) on AMD EPYC (Zen2) from a Go server
using a small in-house kTLS library and sendfile(). On this workload the
main win is not just AES offload, but avoiding ciphertext writes back
into DRAM: our measured DRAM-bytes/egress-bytes amplification drops from
~5.4x to ~2.2x. Thanks for the work on this.

