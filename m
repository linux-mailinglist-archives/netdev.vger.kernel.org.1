Return-Path: <netdev+bounces-259235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDNmNGCElWmqSAIAu9opvQ
	(envelope-from <netdev+bounces-259235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:20:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 742E2154AB4
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44DEB300952F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B7318B8F;
	Wed, 18 Feb 2026 09:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jabSSRve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496272D94BB
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406424; cv=none; b=Pv/PENccRpV9OAph/q6nK0Ivv9dO88DXUehCJUrUUGtCY9jV1+A0LFH15gY6Rqm9SzYkhyu0anrI0h939UCUbWAW0sPxJizM/z3u6oa86tYdrO/d76HSbyJIQW50u3VSbuNW0msHwwHUnXrGE7q83qpANnJYS9Mu4zTyEX5TdQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406424; c=relaxed/simple;
	bh=G8i8l1HaUJwIvvVaqfhi1fhbz840otW5i4iqXUQWS+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NcXRXI0mjeigMkDsgvfEhce6w+0ht/Fi61nLhOSIZziH0wE7KDG70jJXUE7bAi5ANnUNpjxAW3hXr8QfW0pR1pcQKkBbxokXHlNjhj8udh5WkVKMOwxJMfXCnuHd7c+NQDHzJ2plSeYuFULbvvixhjnzr0kHhjmXQEVPl8TrBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jabSSRve; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e555so50532365e9.2
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406421; x=1772011221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GT47+DDqY1qh+uutKLyaKTWw+O5qS7pkg63HL+xIqBo=;
        b=jabSSRvekg3DRCyMFsYJyuYp83OWeRHZaHI5fK7PIr/UCygBn1xAUdvA3B7EMX2Dnt
         MqmDPoW7BPIWFp0JnK5kM1dLpSWON8QGv1wVs7yEgj/+RTAhMfHGHTGgxjLErJMqEZqb
         zGjZc8CXEgMseEgVrpzhQtdPs/yk/QIcMlnh7O668DbXmK+Ulj+AJ/C2kxatZWvToGg/
         fPB76rK7QmP0T0aoHUJyRdYMhYyjfqOh342vToFR1+6oHEG8VUQClmheIdKU3zGHwfXs
         GpRALIDSXrj9SJTy3ZGWRtQW6E+J77/7vaTizLrKOybQbtmR/f4UP08RaoEH0p7rb7bI
         /Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406421; x=1772011221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GT47+DDqY1qh+uutKLyaKTWw+O5qS7pkg63HL+xIqBo=;
        b=acwE3uq+lu+jCfgxhTHIC6vR1yZHMgBuBi0in6koeUSEYHpjTo5L4BOzF76U/gbxKi
         3LBhMN2MGkjXistZf1EuG5g6AavN9lWiHQEEinYYbVoM/vu1rlzGNbpea+zk9qZc4kzD
         +0gTVJT6ICRWCO3i8X0umOj5nqFzs9s6xeSKUY0VbkIAIKoR7/pzL64eNsCpHOcgWP7A
         Y1up2tZswrc+gQJO/sB3OroUBdTOX6fQqvY3zBV7REI1lWA3A7cKxsd9CN881JjHo9TY
         K1ariqa3RdKhXL+Ypi0G/77JVAaejgBpSvnvIDXH80htuz9/rqAV1qOuvm35k3kV3AgX
         PtkA==
X-Forwarded-Encrypted: i=1; AJvYcCWZL6TUwF3BzeG4i9LsjTOgcIqsvZa24Ovrr+gEyCLsBqp4HNTUwq5aJVjcJE31dRST+Un53ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYP9G06OKDEnQ35PI6DfsuJ+yKdwGP9akRH6OiK5ae12zFsAPK
	gcMsdj82vq2TsqrJhFR69LxeM7sH9pk2pSTiOnmlVaJ6h6AuUOJDHKkq
X-Gm-Gg: AZuq6aK5symoiIPApbEN+1la3j0x67AIoMRT5REqg0zROUl7apPYj9cPTNhmFH8bJlJ
	hTtwQQwimfgn9ZbtVqKNEwnSFs/9jqPhYuCgavU0WBzHC2h7TiMcrjcdF94HC2aRV78RTBPkV7R
	TDInExFCCX+nhGDc15VIdL792BCJr2CSCL5ayGxI4ajpQwYhKWIYnQVfSCjoeRuiI89ODz9tPuE
	xGFWvV5UuwUuD2ZUNC5Fu1nr8tjxj6Q8wJMu1XxWcx0l5wQjZT4axsz9neblmqofkuW0Wbi+rSR
	JEBKRa9Di+PCuxZuR3pBDmQOeg2PBUytvrarxPCvEidTxZkouX0vlWh05uLyqZLh9Z50S8hfn3V
	D3unzjr+dMqt8/GW/KDWnfPm1RZkJ/0xD1wCVZOWe24Ls5j/jp0eo/lOsQrEBJXJqPXw0hy51Qy
	hwjDjGsVIIjAGO
X-Received: by 2002:a05:600c:154f:b0:483:3384:a873 with SMTP id 5b1f17b1804b1-48379c15d86mr228677965e9.36.1771406420254;
        Wed, 18 Feb 2026 01:20:20 -0800 (PST)
Received: from wdesk. ([86.57.23.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm41352691f8f.32.2026.02.18.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:20:19 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
X-Google-Original-From: Mahdi Faramarzpour <mahdifrmz@gmail.com>
To: bpf@vger.kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH bpf-next] bpf: fix selftest/xsk single test selection
Date: Wed, 18 Feb 2026 12:50:02 +0330
Message-Id: <20260218092002.147306-1-mahdifrmz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-259235-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,fomichev.me,kernel.org,gmail.com,iogearbox.net,linux.dev,google.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahdifrmx@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 742E2154AB4
X-Rspamd-Action: no action

From: Mahdi Faramarzpour <mahdifrmx@gmail.com>

This commit fixes the integer parsing of -t option. The cli parser
only relies on errno to detect parsing errors. The manpage for
strtol (https://man7.org/linux/man-pages/man3/strtol.3.html)
states that the said function "MAY" set errno to EINVAL in case the
conversion fails. Currently on some systems, this leads to a silent
failure with return value not being exactly documented in the
manpages (probably zero). The reliable way to validate the input is
to check whether the endptr has been bumped all the way to the end
of the string or not.

Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
v2:
  - fix style issues
v1: https://lore.kernel.org/all/20260217080326.50564-1-mahdifrmz@gmail.com/
---
 tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 05b3cebc5..5e4095fd1 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -200,6 +200,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 	struct ifobject *ifobj;
 	u32 interface_nb = 0;
 	int option_index, c;
+	char *eptr;
 
 	opterr = 0;
 
@@ -248,8 +249,8 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			break;
 		case 't':
 			errno = 0;
-			opt_run_test = strtol(optarg, NULL, 0);
-			if (errno)
+			opt_run_test = strtol(optarg, &eptr, 0);
+			if (errno || *eptr)
 				print_usage(argv);
 			break;
 		case 'h':
-- 
2.34.1


