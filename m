Return-Path: <netdev+bounces-283689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AO3Lgrp92lAnwIAu9opvQ
	(envelope-from <netdev+bounces-283689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 02:32:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D9B4B7D32
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 02:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7557130078D5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B867C13959D;
	Mon,  4 May 2026 00:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWfE2qwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12B3C2E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777854727; cv=none; b=dCUoK5FwJmz2qwBY/4p7ohZs3zqo59grqtSu88Vt5BpQez8tkjxfNrgauD9RiJxItdOI0EufaDtfg8QrwR/ESU+gKIahs9/14+uPeNw3vgslFtMDYdwFmdJ31wR1OE/vX0k4Ncm849J6/NtqFRyp86N1b8QsI5L6WQUDTox4z5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777854727; c=relaxed/simple;
	bh=DkKf5P7owZwGHRKNxWOZCOpj6+PbLTY6bfRueH4E/m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XsGLUmt59ncxXYufYQ84+eeJ8Mn86dtiLgAH/bnNIetOitCYeLjc0VQiY/jb2/mlC9N9n3lBtn49RX/HhztQdJdn9ft6yrCklGPdKl7G0IulaQkqgFdUd13w+RfCoUKah1WbAnipsG2nELu+b/ysEnPqn9tgEkxNslkN1nhBwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWfE2qwM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3652546e41aso541837a91.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777854726; x=1778459526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30xzRrisRUtDzb+utNuSh6AP3gr20JX6s24mf4UpaRw=;
        b=dWfE2qwMlJ/zzaKhAZhn/5N/TYtAyAQdeHJYnPiO+qHSyGZRndzKZT+9fw4tSZ/yAl
         9ktKf3hcuw+otgGOQR0/dUwvU50KKk7otZ0G0K3LhG1Xu/1LN3ct87l6RJ41aYB0pSyf
         f75vwC1gHRpNU0opP2ye9SusRT0hDexYLMDhiAvwZGUYyz5OoTIlYIkKTG/hkjKHahbw
         GGyiNK4qsdHK70mFWiXwf3fpNww/Ohl71uPSNqkeyJYAZKep/e1Xq89eYemzWrAMsJUI
         XeYB7gDv7+P819JfC55e8cX9w7wmr7oNOc14vw/hOTA4fjgRCoXWclFndyGvPht0csBF
         rfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777854726; x=1778459526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30xzRrisRUtDzb+utNuSh6AP3gr20JX6s24mf4UpaRw=;
        b=BtE5E+cK4GLdS1X26Fki25aJkFdWBI1g1WI36OD09DB0gJT6pU8pmcVHceMiSOwGod
         91NDIM/gWclMQ6/6fka9aIknVmi0aZJD9AZjCodk5johIZz9+NVGtFjDPbMl5YM/bLBS
         raqIRZfGRLoQdZiFVRLZmpbSDyI2zC0Veud5j3F0PC3qNDOSrQsl4DTC2gWGxiPqDv4b
         PIAZUFKV/1Z/fsT8GXrgKhuB6Ds+Yu8XkbdiEEZIhIjxx6UQagMtKMvNmr+dm8ACVNHY
         Ocn988uixw1z+QCtrEF+XGbrUagIlUnrbKHXZm58oMKq7XT5hBq3IYBfRBC1pVHWcZHq
         v2xQ==
X-Forwarded-Encrypted: i=1; AFNElJ/VRSCpOlrh4qCLsbn+/eCbO2L9drntsWyoC115OYs5cGeVTaVOpHydRiPVCwIib6l8d/4zQRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyNqqBn3k+RiJLlMXC3W5uoUlpkVsbm++ZjO2hpJECPy23czfF
	Ff0ObUCPuWNTsZWxprrU93yTnEc5Yjasl6aFcqAiIpUeYAcIFGP20w2z
X-Gm-Gg: AeBDieuOpvJXgsg7+A0kX3b0/e1CpykFlhzv4WxSWPDCBzaWbQqmoDdO7tC+YWcPvQb
	r4p94287DKMbrtALDtngm9gGSo5FqAAXSOieMH8+JNxakiv33/a2pURIlFpUW7pudc259eN+9A8
	VmvMxvDE9t5zQ87rCxfIR218FiTDYMFHQf0F+FQnxC6TQo0zaQPysnkP22x+vpUETevJbruUfA3
	bEf4jmj4MN9jPwL9xbWBK5qorMRmn2Ye+f2tuKGrbGQusC9BM2yj1ZkmspJBhUgqtEnjppFQ7G5
	aG67xgX3gxQIr4yGg4OEMzmRyiC+Bnqk6ToPDja/jgS/7YT/UbfQupnxBr8+9H4YwTeXBH5PcVl
	Eo7fI4uR+pxnA76d4uB6KzDeJgbpGKiCllkAIofhr91s86WvAsWvXUiJtGS4QSoLtcACkm7uCWO
	NsY0fUxSqLtTIGvR+JVcJaS/VtCrdJscwNRMDDuBBSfcP+w59nuSMnZcL5SyNPSg76x6lC2og8p
	TqBPSxtMYJw8lR9wKl8+VIbeuex
X-Received: by 2002:a17:90b:5546:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-3650cdd37camr7699905a91.3.1777854725595;
        Sun, 03 May 2026 17:32:05 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5d62:8570:2345:8a42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be00b175sm11838194a91.9.2026.05.03.17.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 17:32:04 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: cpaasch@apple.com,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Subject: [PATCH] mptcp: zero opts->ext_copy in mptcp_established_options_dss()
Date: Mon,  4 May 2026 06:01:56 +0530
Message-ID: <20260504003156.11125-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 20D9B4B7D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[apple.com,vger.kernel.org,lists.linux.dev,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-283689-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,ff020673c5e3d94d9478];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]

syzbot reported a KMSAN uninit-value in mptcp_write_data_fin() reached
via tcp_send_ack() from the subflow shutdown path:

  BUG: KMSAN: uninit-value in mptcp_write_data_fin net/mptcp/options.c:542
   mptcp_established_options_dss net/mptcp/options.c:590
   mptcp_established_options net/mptcp/options.c:874
   tcp_established_options net/ipv4/tcp_output.c:1192
   __tcp_transmit_skb net/ipv4/tcp_output.c:1575
   __tcp_send_ack net/ipv4/tcp_output.c:4499
   tcp_send_ack net/ipv4/tcp_output.c:4505
   mptcp_subflow_shutdown net/mptcp/protocol.c:3137
   mptcp_check_send_data_fin net/mptcp/protocol.c:3218
   __mptcp_wr_shutdown net/mptcp/protocol.c:3234
   __mptcp_close net/mptcp/protocol.c:3313

  Local variable opts created at:
   __tcp_transmit_skb net/ipv4/tcp_output.c:1536

__tcp_transmit_skb() partially clears its on-stack tcp_out_options via
"memset(&opts.cleared, ...)" which does not cover opts.mptcp, so MPTCP
is responsible for initializing opts->ext_copy before use.

mptcp_established_options_dss() only writes opts->ext_copy when an
MPTCP extension is attached to the skb ("opts->ext_copy = *mpext").
When tcp_send_ack() builds a fresh pure-ACK skb during subflow
shutdown, the skb has no extension and that assignment is skipped, but
the function still calls mptcp_write_data_fin(&opts->ext_copy) because
snd_data_fin_enable is set. mptcp_write_data_fin() then reads
ext->use_map to choose between writing a synthetic DATA_FIN mapping or
extending an existing one, and that read hits uninitialized stack
memory.

Zero opts->ext_copy at the top of mptcp_established_options_dss() so
mptcp_write_data_fin() takes its synthetic-mapping branch on clean
memory.

Fixes: 9c29e3615274 ("mptcp: fix DSS map generation on fin retransmission")
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..3fb914196987 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -572,6 +572,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	bool ret = false;
 	u64 ack_seq;
 
+	memset(&opts->ext_copy, 0, sizeof(opts->ext_copy));
 	opts->csum_reqd = READ_ONCE(msk->csum_enabled);
 	mpext = skb ? mptcp_get_ext(skb) : NULL;
 
-- 
2.43.0


