Return-Path: <netdev+bounces-288925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FrpKYbQCmob8gQAu9opvQ
	(envelope-from <netdev+bounces-288925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:40:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE1569045
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B131530B5754
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23E63E4C80;
	Mon, 18 May 2026 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPvJWtHd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E483E4C76
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092649; cv=none; b=WawO62OGzGy7vD8TiK710gW5rNTi1oNx9l0xPNVzvPh3M+iH4iHJS3mPQ4H2RpXPlKFIK7iUMVEX+uExTQ8ZDiwxl7Ly5V0RgdQt1sf5l4iYJ1cHkWyuVKK3gX+V08hhxk0tcDMnfHF+1CB6Ju86HeNSFOFXxm+ruRQKiQHfnfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092649; c=relaxed/simple;
	bh=Pm0SSXQemv2uh3B1C/YKpI9VqnSeLwbthTiy2vHdUlM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnXfYWoYeRSuTt6aaE0VT9Tws5cHlQm2kCKucwTXUVVBoLxqLQRIRGbkom4cPi1AtyTNMS+TStsZ+NpaoakjuoAaYVcvz3SnSd6j36w/Ji6aZBfZabz67cH6FDftVOgpJUeAiF7jvbMZoKeSI54w0b7zwi4nVTJt0B1xj2PBvG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPvJWtHd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-366330b6751so1627532a91.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092648; x=1779697448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DoCMEHbqsmQR26KKm6FMm5fGobBSkxtUUIymvUejsM=;
        b=LPvJWtHdXp2vS3XHhC6maCHb/AwPvzyNCNQ6JVWLV/cZhex+3W6j/xmtc8Czotn3SK
         3OkPgf6xPVpbFSPO+EL1PVVBCWABisuSAfSzM2+4w1FyVwlcA6xuPm14J6xJOcTucQHk
         wQZehM8J7u6SfmPaSwTTVvU5fTB4XLTqe3WLjQyKkQuBNGeVHZzxPsomrx4wiex53QEn
         GUVMdwwjwD6N2K8dFxKmnEv1gCXNjDAOZ2aZfPEkt/A8mS2VkC/AzwMNjBkNbWaT8D0L
         qbV83uC2KtonkJCvh5bxJhrPsBuShOuCN2Pt7FMMurVE59QuiQCMMBwDdcHbhAzxnktJ
         CtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092648; x=1779697448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DoCMEHbqsmQR26KKm6FMm5fGobBSkxtUUIymvUejsM=;
        b=pgtJsvj9nRReon6Esczh8scl9fxhjGoQ9VgoRWh90xVoJSMmTGwkzrqWi8kzob6Lnp
         LJTWq6XYk7P2NUA6Lz1wSYBo4RuN6Pt05hUvfPVl9mWnYR8FUcpK/ByxdTTjpY3mDfo6
         E3FrEWm/pwacVJyKLO0W6XmHCPqGwHiiMBS64Gv3Yhb6NZHln+JjlpMKTw6fbk4DdA+6
         Icj2huktkET1pG57NGzPy5riSE9nacyi0tvIJx3iesN4pMD43t5X1buDcZUKusDzT+cC
         DiHNuIQyCKqDPJ65pWoNF6C4xhr+q93xWt97/bMX0m5z9MV+KZdgKfT20QjEiYTd9Ppw
         IBLw==
X-Gm-Message-State: AOJu0Yz0pzUDYiZrCE2zAMYpehZFwjxVNEUUwSrzrr/5lBjTpL7Xs3xn
	SzQYyV0ZcsroiXDZhHe6O7BuAv8zaSoCKjJdSG9T+6rD/+ue+Kj2LkcN
X-Gm-Gg: Acq92OECYnxLGN+Exu1sQOmuq0f7yizjq2Sc12cqyRo5azmwVy3buZYg/CCk8pvsZBf
	yOSBDqeiPhy7LOA5HZJEeaHCAxSGfThkTt4iaItsGT7TgV33lKediSTz6lHivgG8P4J6SqRqwtM
	ViKowIbLEftymFDQQvneHpSf7T0nT9FmUMsj582ZM+JUwFUN1dNVEqojsJqM7Wov3M50+9PidxM
	NIlkRu7TpFznFefVGeAb4wxKr5mqfn+IGX9b88Rpau3/XdUIG/NlSer9ZJIFlIwOJ5XKmqGB32V
	s4jZyiUVAmpta2w9uNsbU6e3mInm0Q1hHBB8A8kyCIe/Qx1E8e+ShlFFOqzulCuUfUta1ER60u9
	TFrbe+PDBDXzbuhilTEIvwOta9lSOY4cTRXNhbFvx/N2vXvdCLDimYGSDlHTaovX7AQAQGD+7Aa
	+kgUAaK0wIS4oId5vnOJneOGOiYCNc9o/h+pv4qKbJShvPbDq7rZ/KeNdTzjoNmAv4dymCS9tPr
	tPAstEBVj+WdDtA5wZJ4mclhtpa4Q==
X-Received: by 2002:a17:90b:3c87:b0:369:b957:1d84 with SMTP id 98e67ed59e1d1-369b9571f47mr3798456a91.14.1779092647645;
        Mon, 18 May 2026 01:24:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517ed182sm10382060a91.15.2026.05.18.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:24:06 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	kuniyu@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/6] bpf-timetamp: support rx side
Date: Mon, 18 May 2026 16:23:38 +0800
Message-Id: <20260518082344.96647-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8EE1569045
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288925-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Jason Xing <kernelxing@tencent.com>

Previously the series[1] has already supported tx side for BPF
timestamping, now it's time to support rx side.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=68b92ac494eb

Jason Xing (6):
  bpf: Add bpf_ktime_get_real_ns() kfunc
  net: export sock_disable_timestamp() declaration
  bpf: support bpf_setsockopt for bpf timestamping rx feature
  bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback
  bpf: enable bpf timestamping rx in TCP layer
  selftests/bpf: Add RX latency tests for bpf timestamping

 include/net/sock.h                            | 12 +++-
 include/uapi/linux/bpf.h                      | 10 ++-
 kernel/bpf/helpers.c                          |  6 ++
 net/core/filter.c                             |  8 +++
 net/core/sock.c                               | 20 +++++-
 net/ipv4/tcp.c                                | 14 +++-
 tools/include/uapi/linux/bpf.h                |  5 ++
 .../bpf/prog_tests/net_timestamping.c         | 69 ++++++++++++++++++-
 .../selftests/bpf/progs/net_timestamping.c    | 35 ++++++++++
 9 files changed, 172 insertions(+), 7 deletions(-)

-- 
2.43.7


