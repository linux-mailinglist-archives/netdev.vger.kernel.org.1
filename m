Return-Path: <netdev+bounces-297520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 26lZKd4dKWrHQwMAu9opvQ
	(envelope-from <netdev+bounces-297520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:18:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3C667100
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:18:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Pr+8qgk9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297520-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297520-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 288073047408
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830063A2E25;
	Wed, 10 Jun 2026 08:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076839FCBC
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:12:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079166; cv=none; b=G3sDeNmsV2zL9+SWFfjF6eLPszS0rgBzC1f9rqzr01EjYeyWkB2ll5RD5pm5dq0ATzhygDYUTVH820S+IAeYednNOVyCWUhpuuzsfB4H/JPV3XLU7Sd2LDthL6Q8sxrHJSg2h+Aw4Qezbv3fQMRks7b1oDCOC9stS2i3D5oOLlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079166; c=relaxed/simple;
	bh=3mIefPDB43KmMDQcWcDMAg6qpJoLh01xoGq7lr55mDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YukYBbOF5J9OGTeAuMl/6QArZ6U9NT8ymK2VEOvOxPl+7i2HEqWfj0z5F6QgFftNri8PKg8xeiqaiNfU52ge0bzpQwK29Lp3n1dFaNw5myQzuNR0VMyUZmxbIYJSW4YpQsT2uR8LB64us4Gv4rlm3f72BKWiHlKllgLnJmhPeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr+8qgk9; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36b903567fdso6524763a91.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079164; x=1781683964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAJrDclWsxoQPkhKhcELIufNlH0kXnHvmBTgSWCpEJs=;
        b=Pr+8qgk9P2LjQVCxEYVY3GSKVntPOK/KO8w124W+5BFy63WUMqWnXYMmtEuLwotfYh
         mr8ugKBJ9i/q6t4QjdeO83V/FdVSpkccgZnSWkMVQw5YqToz04TT0n9hrT+CBpZRbnQR
         iTq6OVBucQuEN05DgHBTBlNAqDfYjK5H5rtybVP5FZqfL4A8FGGq5ikthI6v40NCsfix
         2R0DWgWpuArEtXPnWOhn8vPWkOuRdXvvY+Eqvib7Q4gfYgENR1quZXiDDfPYNTqhUNQ2
         6Ev++qkdSu9bb99MTn1FGTclvVQHoG+zC99wnBqG53EYKHp+4lMJUOCdH97OQu+fUszK
         hrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079164; x=1781683964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAJrDclWsxoQPkhKhcELIufNlH0kXnHvmBTgSWCpEJs=;
        b=HQrxnmRMiiC+t/7a6eBXvTFOZ7rLOGmgYJd5IUToIhNgOPlCeDHmb6ufqideIyd5ho
         eM972MAGbWQ/jpF5vmz2zh6MfXJLGK2nyuBB/UHG5dRj6RadXuoscTMnYOqmPRoqa6fd
         xeSHCXJUERyYB/mEVtGu6RtGTrIsJW4jFYee++sCCcQAd7A5flh9Z73CDeD3iONeeA5u
         oNSSSf6K3f4lM4qQJKin7Mrn+Frz4/h3kc/gFUMkdI1M2kJuqwMav/vdYHzEJjhV1Zps
         4ccuCWWhnhWXOUNJmBcbFJtfxjqIdquxtEku640wT1JFfDdNvqUvjPePF0XXPo7bsRfm
         NwaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+S7L2F02vI+Jaxh82rk7zq7fnVbN31iIRC+kXCXRJLzd4Xhm+QqhN5Gnm0dgEzjYpxkcFwgeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPWmqLkHaxabfLIL+YCA26OVO9Axf+mYZASXdogmyrXm7YpY8
	Eis9QeTFKxyhMxMsqeqUy5EwmUziXc/Avwe9e6SRYP7qGm6BUjSaG08s
X-Gm-Gg: Acq92OEbZRFola1UdTfb43h3t3+H5KfJa89TeIsmg3opllBWyTk4m4UYOibEG4Elof1
	P8y6ME3ouFJQF9ddsakAwLpsXjwqnMTY4kBdGTF+e7atbS/NAd6gBoEYuMMaQRrqSHohaphvkLn
	RFYQcixMScXymnlUeQiUe1iLw5sGMVD/+HYry0AFnPnpaE3c1tVXuI1Qzy575SmX2rp4ffs8oc8
	/QriFLVMG4lS+Mhrz3ve2rDvjZR892FTVtJh6RhpuUekZfzhEq3unkCtzrOCpoEW8qiAGTop42w
	aAa/w69vOsGnYv8pqOnwhKf/82d26qMQO2exPpLBDXXVdt6msVR5snMexHAr/n/U9IA9vR4zSK9
	a2W7cY2VOKy7bxeNdMEL2rY3oRrzNCS3hb2hSUpytltIab3RFunNs0m2Ajo0cABz4Bf4Gwrc4+N
	anOUnxAHZ7YNZZNb06I5uDSzo3TLNdODCEoj11FkPwCXB7622FZMh3bDJQqT7OOC0F67BbcrhH
X-Received: by 2002:a17:90a:d40f:b0:36a:a16b:5f65 with SMTP id 98e67ed59e1d1-370ef1f3d01mr25989391a91.11.1781079164425;
        Wed, 10 Jun 2026 01:12:44 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:12:43 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 0/2] bpf, sockmap: fix bpf_msg_pop_data() integer overflow
Date: Wed, 10 Jun 2026 08:11:52 +0000
Message-ID: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297520-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cwang@multikernel.io,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,multikernel.io,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36E3C667100

bpf_msg_pop_data() computes "u64 last = start + len" with u32 operands,
so a len close to U32_MAX wraps the sum and passes the bounds check. The
pop loop then walks off the end of the sk_msg scatterlist and
sk_msg_shift_left() calls put_page() on the empty msg->sg.end slot.

v2:
 - add selftest (Cong Wang)
 - change pop to u32 (Emil Tsalapatis)

v1:
 - https://lore.kernel.org/all/20260609183927.4021802-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
  selftests/bpf: add test for bpf_msg_pop_data() overflow

 net/core/filter.c                             |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

-- 
2.43.0


