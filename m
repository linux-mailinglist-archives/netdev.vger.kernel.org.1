Return-Path: <netdev+bounces-258977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP0dEWchlGmqAAIAu9opvQ
	(envelope-from <netdev+bounces-258977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:05:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9271149A21
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955E9303BB03
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743F2DBF78;
	Tue, 17 Feb 2026 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5IJXhWe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2A2DA74C
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315447; cv=none; b=JyKE1JIKzi8vekn3uYnwwqMn0ard0RXjyLd+DkxZ9pXsAVyyoCtB59X6ZUlsL4MlnR9ojTzfQdhadg1fwkferTt1C5IEh8X3SiXiWlXWHdvDpMVpY1NvOs45xx69LFgpAkE86HH0JtfNGhYzxzcNeJ7rwRxHBrjtrS6L2kPi5Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315447; c=relaxed/simple;
	bh=Yweqh5Ie4qKFEMSdJJSbslC8AC9nlGFb9nntTg3vI9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tb+yoC87/Rmz7ZLBqAH/TA7TsU+uEKC0PN0RgcEZGGJr+Y9dRQm4NI4+2ny2MiVK+nPcUr/4p3aHaQt1kwGtcIOe+emq1uSBPCNpze/PpKRZ0/Sxz9HganI3SO4GFvf1MQ+oU0SeBd8VI76g+aRsFygXJyXP+U8chpE7ASrcoKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5IJXhWe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4837907f535so26118495e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315445; x=1771920245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwu0RtjJnSjfYWXl8NymM6GUAIv3FYMND1I3ZXXKY24=;
        b=h5IJXhWeXPgNXBaJqsmQEZad1xmCvDSjgV/fe7sHT8JajF7LsbPVsZld2vFsIe9GkH
         elKXbnygIo+o8PPR0myZIaJx9w0ybb5J9KhJ8EN/FDOp1+sjp3mDjf6R0RzxgIrooRTf
         iBcnfJxv09kWEr9w0vgNsSLbpDmtO6Bay59o7CX3gA7gpbCqyfYJGnLXPzZ4SKtCGaJU
         KF86HmTULY288/ZSJz7blkXGQ168Q2wEzATv9EdDqKDyA/B46ILMRNCEyOZj0TK6QcQA
         W7Vn9UcS+SIWJDtnVFKjSfmpdUWNFTXEldr9FhpgaIcUZ6EjQyzVjEQyIlymN24PA85D
         3V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315445; x=1771920245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwu0RtjJnSjfYWXl8NymM6GUAIv3FYMND1I3ZXXKY24=;
        b=oPJp82rjckY+/TJrkZFyZqvt6JFBzwBEpcVsG7iSSTK8M/VK0rqt3VtjMJmgAgotuU
         oP0kxD/YA/88szP2e14jJV6+abjnThZGOAblAIixCaWEikTqs/JxtBQDrRQ6fzvV9+za
         UctD2BN9TBYL7+MUVmh5r6LNt7z6ykymGGGNP3rcqPEGX2r/eU3gtNCytqxOq84eahJ0
         5mCzHf9hhCTzeeiC9lzhhoQkmz0LoGuLKpFB1K/kUGaLQng0Rn479fYmw4XI4Paj6Iqc
         Saia8Wdf3yRTP4pHGpkwIuT9nta1OH6Xfn5H4Q68+p0kJmXBkoTwjihuRV3Ax7MeUshy
         4Ong==
X-Forwarded-Encrypted: i=1; AJvYcCUFeBlN+Zdsqlkhb3PAYmzwfFmjkh5pQbtT1IXQNjEUqe9c2DBCVZC7mW1lmYWYjJVq9LfugZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHoXzAyDrtWwagWeH9nd/fhBb6qqsS69ek8NQs99Edvd8xsjAJ
	57UhUatHjAGPhjN4uaejydamIielqmk/bLYsZlmzxUSKLiyA0XBRFP93
X-Gm-Gg: AZuq6aLhETakfmkzKkmQB4ZsuaSDlMP0j1XKDe4wAS7JIWUGdJwNUMPeKioOVE6PBbH
	G6a5FK47S6Nu+n7iEIK0L/T2MkmaYOSudbHMfVSdEq6lhOdEZixBlUDQ8L5J665wkj5K8tyPp93
	rrdwhckjdhyUn1st72i7/gsLJnz4Me9QO9qi6degW41YRZtzFFRJ3zFB+y6zUY/SMdtRZU69RvW
	EOs2f5r2ZggP1ldoPVNDhKKcok39UvAMWRxW73kQgHxHAbcRW5gZpgKKftIkJ3O4He5fHn7uTxz
	L4QgLV0q4rXWtG/en2/qA+zT5kKO1lWZssqobtx9QeewjHweTk/ex7zJ1DVOCHPgu0Z50UjbP3Y
	UPI9RlUjqZZKivd7AhPPYceTGprtwRN+B+BBbKF2jbpg+ds9FuxwXSGPVGYUeWUeBh72tZqrhIE
	sFfN1Q0f9j5gduljGzq0iUDWQwxb4mvYM13cq7V3wgU5zXpZ43IfU+QDtvJsOb
X-Received: by 2002:a05:600c:3496:b0:47e:e779:36d with SMTP id 5b1f17b1804b1-48379bd72a9mr155342395e9.23.1771315444665;
        Tue, 17 Feb 2026 00:04:04 -0800 (PST)
Received: from wdesk. (static.169.76.13.49.clients.your-server.de. [49.13.76.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48370a3f077sm102996985e9.2.2026.02.17.00.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:04:04 -0800 (PST)
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
Subject: [PATCH bpf] bpf: fix selftest/xsk single test selection
Date: Tue, 17 Feb 2026 11:33:26 +0330
Message-Id: <20260217080326.50564-1-mahdifrmz@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-258977-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,man7.org:url]
X-Rspamd-Queue-Id: A9271149A21
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

Signd-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Fixes: 146e30554a53 ("selftests/xsk: add option to run single test")
---
 tools/testing/selftests/bpf/xskxceiver.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 05b3cebc5..f2d5c4dd2 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -247,9 +247,10 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
 			opt_print_tests = true;
 			break;
 		case 't':
+			char *eptr;
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


