Return-Path: <netdev+bounces-303262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uBY8DTHaQ2rzkAoAu9opvQ
	(envelope-from <netdev+bounces-303262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE676E5AC7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:01:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zo5H2nrT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303262-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303262-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C1E3041AA8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D0D44A71C;
	Tue, 30 Jun 2026 14:54:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD543D4E3
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:54:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831266; cv=none; b=fUWxdxn5vbzd2rTB7I7v9oH0s4RSZVoA6Jh7L8ukZOc68FuibEH6mUtQko+Qq69Diba6YwHmUMAoqeWqb30onX12eenA7D8yCwT8gdFeey78N4q+x+YrOXcB5p4qNW84iTr6JSTa9Dpvy/WdJxNqgacpUU9DRDt1me3Mx/Xt3aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831266; c=relaxed/simple;
	bh=mvMluMulz8TsazPI0k8zL2aMZtsqN5Gi7GN9fqtNkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DrIomC7hnagJxNa28ffwFT9kMVAuIfuv4gSiQ4YW0Z54miJfXkCfpa4kZ+T5xWCE2FwOx6yNHqISSAi23hEB3K7XNc/XhLZAlTNTziodmkNvgB4iE873DnxNZzrIeJnyfg/2u2xFEetFAEPX2QW/mhQP70Wdbfq30oGlGDN3z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo5H2nrT; arc=none smtp.client-ip=209.85.216.52
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-37fcae0ecb3so1622803a91.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782831264; x=1783436064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=px0Wcp6VhD6xZWRvmlTtSAYT6tdeg+tqH+zTVPz9ZEg=;
        b=Zo5H2nrTXqjMYGMdJPP50uZUExrQFXD75XRkt7ocVE6oac4J4tN2zkkf9h8s5ty3oK
         xcKO3yH5g6VpqT92aZgPdQ81KxtbW4Mc86s9h75HzFqRZkmIgX7HZLdyqWf9kaDI+QRy
         kslQlRdZIQY3AKaPbViHeYasYakmEJEpXzy+LAFPMXfLVgDphgMbu53cncAWEbPLiV6p
         3zBglHAqZA9vq2XSUBos1c+YGOixmSDBe6USxnDxmsq99x4wOSbjTrCXvBdMxnUF4zyg
         B8W8uXwQN+YJoMIW65UdV8fZQ39SMHU16WOSJW8apPnUwg1YxFLg0ePJLOOZBYNjUsMp
         CzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782831264; x=1783436064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=px0Wcp6VhD6xZWRvmlTtSAYT6tdeg+tqH+zTVPz9ZEg=;
        b=PoI4BS0bDgaFKxSksReLCcahdHNcc5+SmN3a98KwOsT1JKlhu8qTn7/i8bg6ZgOZct
         Cm6KUsAVfBBaYDEA+U3rPRP5yx471CegbZZ9FP9e+3Am8Y0tuQqGtsFjjKEaZtlVSMns
         +TojzDt706CNTBvkViYBOA3p55HEdnpmhvBCv6bTouKZzX3eXAHU1CZethZYSNF/HU3o
         ufEsLuGC4MBDg8dkfGwcG9SgvNtEolQb5U+b2IHGyucMwiSXCSgfNPbgPReU6Z8kY081
         XkzFfupoyVPyUcCbr/5ZF/fXp3mTioLQzllAijJmM/3vUrtxEp1YK1ygI3Bb8l+ijq6I
         7GxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoeDpdNIKkQQ3vGUT3wNFuYgivbTuHBgHhXwZG1sPgJwlSU7vTHvCxGQjkeUYS46O97ToIgUDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/J1MP9is7n9gGj6Wc05K+2hrvx7V69drbuTyUAMPIj78D/BfP
	o11b9Qoq+pTj4rCdytzET9bF7ZKKXoaffrJ3fCjHrtRoMTHeM+XryFJp
X-Gm-Gg: AfdE7cnb41CtVZUNppHmLkGBWSMsOJRs7l6GtCGZcOIX3cs3t6zJVkAUYpDQO+6qmac
	9ogqSwiCtFHFEyJy+G9piLi3L47/FaQsH11q0bwg5OmAfR5tVnwKT56KJ+DAa+sH+lDYA+INqFl
	S9LFgTtVfooCHyQ1u7J0M7AL8qD/T+NFrVcUWsDDYBwrY2pFSnQfK88IeC2kC5h/5V/i08sH+h+
	FW902JJNbpEcGkv6NMunAIQtWpuajRJgzQMdKbSYkUlaLJ/+5r1BiBFGiJv1oCkbSNFyxB8LN8B
	XuYTEyuZai9qjdMQIG5Kz3eIc4jOKutveutwFNTmfzt8t6JwKAPPZ7w2MCN0x4qrHwoxqFhBmOd
	c0F/ISYxHEJ/e0+tak59EJJm4t2Bmf8TAJz7T+Sk29tgmyOQSf8oy2xVzOD8y4x6lF+97JNbRVd
	n7pe5EXJwGRPxsGsQwNt0Mxf+JxjFO/7ixYBDKXDg5fphsIs15fi7V6StdfdI5IA==
X-Received: by 2002:a17:90b:3c08:b0:368:78da:803 with SMTP id 98e67ed59e1d1-38052583a4emr2912925a91.12.1782831264127;
        Tue, 30 Jun 2026 07:54:24 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095b684basm20122a91.1.2026.06.30.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:54:23 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Varun R Mallya <varunrmallya@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/2] bpf, sockmap: disallow sockmap mutation from tc, xdp, socket_filter and flow_dissector
Date: Tue, 30 Jun 2026 14:54:04 +0000
Message-ID: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303262-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:john.fastabend@gmail.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:shuah@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:sdf@fomichev.me,m:jiayuan.chen@linux.dev,m:varunrmallya@gmail.com,m:ihor.solodrai@linux.dev,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,fomichev.me,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3FE676E5AC7

A tc, xdp, socket_filter or flow_dissector program updating or deleting
a sockmap deadlocks on stab->lock vs sk_callback_lock and has no reason
to. Patch 1 disallows it in may_update_sockmap(); patch 2 drops the
selftests that exercised it.

v4:
 - also drop BPF_PROG_TYPE_SOCKET_FILTER (John Fastabend)

v3:
 - https://lore.kernel.org/all/20260629172704.1302218-1-rhkrqnwk98@gmail.com/

v2:
 - https://lore.kernel.org/all/20260620034632.2308-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260616091153.2966617-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: disallow update and delete from tc, xdp, socket_filter
    and flow_dissector
  selftests/bpf: drop tc/xdp/flow_dissector/socket_filter sockmap
    mutation tests

 kernel/bpf/verifier.c                         |  5 --
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 13 -----
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 -------------------
 .../bpf/progs/freplace_cls_redirect.c         | 34 ------------
 .../selftests/bpf/progs/test_sockmap_update.c | 48 -----------------
 .../bpf/progs/verifier_sockmap_mutate.c       | 12 ++---
 6 files changed, 6 insertions(+), 158 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/freplace_cls_redirect.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

-- 
2.43.0


