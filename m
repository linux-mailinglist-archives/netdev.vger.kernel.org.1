Return-Path: <netdev+bounces-257791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHirMa7Fh2lldAQAu9opvQ
	(envelope-from <netdev+bounces-257791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61810761F
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 00:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B209B300B450
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 23:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090EE30BB88;
	Sat,  7 Feb 2026 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxRhVR9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93DA20010C
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 23:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770505643; cv=none; b=u5Df9Vq8Fw4n1K+HBNw3RYg4x/CofmqNgUSjHGsmLbc82hsfM1XS53vW3bDMM1NdKsIAkca72E4RI3uCJk0DabkfAAOwAJ/8h+sOt1OVpqsmOWJHR1M+dca0VfWW6LOUFzyqN/k9HBtJLfniYka6jnrIvh29kA7RR5U8ccYhWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770505643; c=relaxed/simple;
	bh=g4zUcjL+IMNxQOGpDOB0zSkgb5eh8GvCHkyo5lc/iBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V82iZvnHnpMwAcBXnEr3x7AbjN3nihBv/7uhJ7VKZrWFNZiCHae24qdND0QIpE8eVWGcDtC/B4rjPJks4ruZ4TmUqfpFZhp0+t9aBsQrxLoxLc8kCn49hnFc1r4m39dVK347J827NPAhO7kgqxU+Qkym2RsZaXdX9jleFtmn5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxRhVR9c; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-354bee18a62so1010842a91.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 15:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770505643; x=1771110443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bxowFVDQC2tzIlz/ZNwwGyDypNBFzJ7/DmR6pBnv9eM=;
        b=jxRhVR9cQrkc6d35dV6+RS0LOj7sGtFGbNgn+H8jBNWXXCkhrNUhK6o56BMKSqbtKK
         KEKBR2xO58p+W5ieh6r56XV1OlqsPTSxyj0kb4m3WKHKMIIBopsRkizf7LGuKdwbX671
         3STY49fpPq+8xtXGy8WKsFY8gx17DXWp0DPZunaYAIpTkgZB1Gz5alshLxxB2pDZC0w9
         fMAK+Gxj/hjwUqsGNsYQJAJKEvj0EFvQ4EMXwu4ovITmLBK6x7aYQKFzpTEg2cNdu6/2
         PM0ihs2WVoOh7GvXriC1j0vRlGXZQX/uWOvzdF2jbSwjSuP8V25r0RNkVLL/OUCzKZWF
         bIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770505643; x=1771110443;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxowFVDQC2tzIlz/ZNwwGyDypNBFzJ7/DmR6pBnv9eM=;
        b=BT36Wpt0ZrBiQ3AB786aeRILOcwtn0ZCoN6lbniK+A62zTHBC5TiyurzPyVcwVd+Do
         OtIlYEbC87XXgpHLWRSj8XfyDncxsrXqIxGb+TdnpfX2OGOaHb8YnqoPd35BR2FITjS/
         BJ6ndC5u4MnD4pdgKaUJRX31nA8VuTOYLsSA9FeI3OowWsipM2ELOasY1ZIAHqC8pdZO
         fyN0Mj3LuQqOJCeGntY7PNxIinYIOGJ4fcYeF35eBXt01zsSMFFC+kxPXniAplvp1YdH
         nqf45jLBivfjRbvHZGCl75VOgpkT5F8NlE6rjZybfk/57y6w379QxeVqXcI/V2pc33Zr
         PsCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdF3zvbsGS8PxJQ7w/twbWwvPX6x8+vI8VtYIs1PXQIyTefet51/csIDfApuF53LyCtwcBX/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMelc+8hfQI4Q2SfYVCghif5u1Z5b6GJ7VMkyaWXEP5TvGMg6
	xwOfg4ctrOLW/7A95/dj05idIquFAVllBcyD9d5N1uYiwM34H0kSyXa9VBC47wODCeWizyqrLu7
	ZShNjDw==
X-Received: from pjbfz3.prod.google.com ([2002:a17:90b:243:b0:356:1edc:b2a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d8c:b0:356:22ef:57b9
 with SMTP id 98e67ed59e1d1-35622ef5e30mr1233745a91.3.1770505643077; Sat, 07
 Feb 2026 15:07:23 -0800 (PST)
Date: Sat,  7 Feb 2026 23:07:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260207230720.2542943-1-kuniyu@google.com>
Subject: [PATCH v1 bpf 0/2] bpf: Reject access to unix_sk(sk)->{peer,listener}.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.dev,fomichev.me,google.com,rbox.co,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A61810761F
X-Rspamd-Action: no action

Accessing unix_sk(sk)->{peer,listener} is only safe under
unix_state_lock().

There are many functions where bpf prog can access the fields
locklessly via fentry/fexit or bpf iter.

unix_sk(sk)->{peer,listener} could go away during such lockless
access by bpf.

This seires marks the fields with PTR_UNTRUSTED to prevent
such use-after-free.


Kuniyuki Iwashima (2):
  bpf: Reject access to unix_sk(sk)->peer.
  bpf: Reject access to unix_sk(sk)->listener.

 kernel/bpf/verifier.c                         | 19 +++++++
 .../selftests/bpf/progs/verifier_sock.c       | 49 +++++++++++++++++++
 2 files changed, 68 insertions(+)

-- 
2.53.0.rc2.204.g2597b5adb4-goog


