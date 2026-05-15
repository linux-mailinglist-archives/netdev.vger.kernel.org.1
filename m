Return-Path: <netdev+bounces-288202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANSJBh7IBmrjnwIAu9opvQ
	(envelope-from <netdev+bounces-288202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB3A54A67C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42A3C300D68E
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E257D3E4C99;
	Fri, 15 May 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KMhiRBKB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8BE3E4C79
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829312; cv=none; b=Fl2iwrhLzoVHtBVFAJzaIVflMa24MG5xbWQmYuogyJQq0hvZ3SSQ4LKvmbGSty5mcirU8Usx5UMoHQQWWxUJ8zkqZeawOtj7RErkRy9T08kNgiLGtb+LPtz2Px/qfD2SXDGs+/H/P4OlM4tirkt+Y6iy//6MZavIjWRslUg8XBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829312; c=relaxed/simple;
	bh=Axb/0pbJ/VyfIOcxWuDbeeOEwg2vW6Bh+JuU1OIKTHY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HbZOG3aasvX8KiPbtxrLwunn9gkqkinWTpYoi50UU8MkoApA2N6dzPVAG//jDovawk7rEwmVrn2ZdHPnyMrqSMEMo8A6qtst1hAxYr3Idi6HH17HLiFU482isxxhq8fciQY8bnNOVML/bAv3ijQRm+HbotlWKhpyHSNdrnFJc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KMhiRBKB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa5ecd760so4706096b3a.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778829310; x=1779434110; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b60C8WdQQr2ioruztJqeYk2pAgOPDbQ8o/5tZldjQqs=;
        b=KMhiRBKBuCsaUIrMFo9FpT82Q6PLHFoa0GAcDSwXqvcIhV83SpMgaI24TLAXe94FqJ
         ZtRw3nnNuzDrwU5uq6G6LNwiY2lkdvsBsG7ND5hBCtQpqfVIqv7khruS8b4DWgOVuVdm
         ThwyyrvNCrxGa+SkLFv+7uEty1kiG3FcHz5KanBduR6lYLiMv4JGyG26zqSD/2l2UjCt
         aRHSebOSeX48UBX/KdpG7/8t4ufdB5wSchfRy9Qfp8S70oifdiqjZa7K1+1K6WqVTAbG
         SoSV49I0KNkZgaJxul014XBBGNzN2K5IwRlLiXDqpr5oDVEOxI1erOxZbR8LTrDKs8uZ
         Yq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829310; x=1779434110;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b60C8WdQQr2ioruztJqeYk2pAgOPDbQ8o/5tZldjQqs=;
        b=Vj4sAXI9mBSTH89bTNsW4g0AVz8lUtUwLOqCePTYXaGJSvUXn2cLvqeJ4Rqtpx3Ye3
         3I88GiIaUr74WZv3PWnrDQo+Afb83q7u5qjb/MU9IrqYb7xnAkVsvtkXhpYvPv/2N4xS
         lg3Xc89lz5ZZwvH+eGmikvmd7czO3/K8i3JjGvIj2Pb968dGrVZd0Mh9GvOD7PlZobr/
         xzCp3iGiBGHrRpZ8dI6yiYYezPVMkH0QHell3CxX8ox16Y1LF7uSe6m82tdnFzqfFQLG
         6kh69aWhYvpN/fg8tdpsO9xa0CVMnMNVyjtl1tiID5bRWTp/wG8CtjtZDIGJHbQ+vK0T
         7rsg==
X-Forwarded-Encrypted: i=1; AFNElJ9/MIBiKP9NHF+nMImIs1kGCf+O2EcbPPvoj7UI15MA/JwWuuJyJj1goFTcT1QVIUAP8XB6cb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWWXcnmRAoz8KU7aaKpVpqL9r4X2AuwXVOLC12oN1fNwiM/0K
	qUygOb+dZY0dkGpQ8uqeBfR8DwKDJ4w3724NC6ztVDO1/fd8byoiqOtlOiBJmyTptF6kDVRMmt/
	u1FmGbW3CRvpSC+RjugWAIt2v1w==
X-Received: from pfay22.prod.google.com ([2002:a05:6a00:1816:b0:82f:7ce1:182])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a01:b0:838:c01a:7a46 with SMTP id d2e1a72fcca58-83f33d8cd6bmr3035462b3a.26.1778829309681;
 Fri, 15 May 2026 00:15:09 -0700 (PDT)
Date: Fri, 15 May 2026 16:15:02 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515071504.2054786-1-yuyanghuang@google.com>
Subject: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7DB3A54A67C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288202-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, but
several commands write outputs back to userspace unconditionally. If the
caller passes a short buffer, this can lead to out-of-bounds writes,
potentially overwriting adjacent userspace memory.

This series addresses this by introducing size-gating based on field type:

1) Mandatory fields (original ABI): Return -EINVAL in __sys_bpf() if the
   user-provided buffer size is smaller than the minimum size required to
   cover these fields. This hardens the syscall entry point for several
   commands.
2) Optional fields (later revisions): Skip writeback if the user-provided
   buffer size is too small to cover them. This is applied to
   'query.revision' in BPF_PROG_QUERY.

The first patch implements the plumbing and enforcement in the kernel.
The second patch adds a selftest to verify the behavior.

Yuyang Huang (2):
  bpf: align syscall writeback behavior with caller-declared size
  selftests/bpf: Add verification for BPF_PROG_QUERY attr size
    boundaries

 drivers/net/netkit.c                          |  5 +-
 include/linux/bpf-cgroup.h                    |  5 +-
 include/linux/bpf_mprog.h                     |  4 +-
 include/net/netkit.h                          |  6 +-
 include/net/tcx.h                             |  5 +-
 kernel/bpf/cgroup.c                           | 13 +--
 kernel/bpf/mprog.c                            |  5 +-
 kernel/bpf/syscall.c                          | 34 ++++++--
 kernel/bpf/tcx.c                              |  5 +-
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 84 +++++++++++++++++++
 10 files changed, 141 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

-- 
2.54.0.563.g4f69b47b94-goog


