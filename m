Return-Path: <netdev+bounces-300097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GysHSxsMmrfzgUAu9opvQ
	(envelope-from <netdev+bounces-300097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:43:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D7302698038
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 11:43:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HQZXW6Qk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300097-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300097-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1347031D0C0E
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 09:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81413D904D;
	Wed, 17 Jun 2026 09:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF93CFF65
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:36:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781688985; cv=none; b=UtKzVIdsSK0vClyqf3/Gge9Mqfhnrb3tBKkm66lCECXPo04jgFoUwErX/QPw7RQpynj3ZSt51rTGHvlv+kn+lMQ2oziEVXJqlwwPDECCQYaH2GDaGuChQrhtd6c0J/pxHrfyxYmvj932YZq1EN53d8zNrzzKQkQnUWGuiK+P7Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781688985; c=relaxed/simple;
	bh=GWPzChxssxZOZZc16sSu79iLhuD8mO4BYO8UX0Bsfzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtDtOiNYgKrtkgvCBaOeiQAH4NZll5oRMuTEm5AyieGHEOGmSKeaTym4MDbIHajuicvnAUyjshd/nxBU4eMFfXKee7ZKWMsf5v4ghvOzL0LB6UDCFrVKJ9ZtcBr70iLJBihg89uCkeY8eYnhY+sl6IYx/+U6RsBIjPU+2lw2Koc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQZXW6Qk; arc=none smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8422f395a4aso557889b3a.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781688983; x=1782293783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qntz5nm5yQBkXOVak+SMgSBWDeLqTSwFLoQFss37lnc=;
        b=HQZXW6QkEni9oUS2HrmMWKAVOqywvv4fc05+eN1VjACgPlPM+21udefw+vlzxwWadS
         JpZUeJH6GYNm2iI0ZxKZT8Z0H/mB6uYleZmNJZ8s1hubC5fQHkHFmXmJEqHA+5K7y0T1
         1XGxrRkV3XgaZ79DJDUmieBoLzw1tqwjaoS7E/ALD3bQVDbSQBu1Sl8ssu63TM9qcEo1
         H9NOJ6VUzNP4Vuz8E4QW35NnEkKpuJdK+aqLaUIIyXnElDYAR90r8DiONIf7cfVr63Yi
         tQVrgQa++6TJyEAzJg+LFh23XcTy0tkVFEvptdaI3g66v5bsudelKRFWcP0oYSW9LfvO
         YtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781688983; x=1782293783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qntz5nm5yQBkXOVak+SMgSBWDeLqTSwFLoQFss37lnc=;
        b=c1woFOX9/eAMr4/ERShhnYxIeZv+dgTtqn0n9yr4PiFLySdCbHG0bNXWf1wQpq31VE
         xyJ5cw6dBbGjZv1+evievqq8eD5tdDVrrpUoh/GQGbUqghhchF1xJKTEoTxgUaqGuc5j
         pIzVM7DmehkbyS4Q9rWrZey/cALM/aKcTjDHGgtVS09jnxbpmEY6wVLJBTE+jw3R0ZyW
         /INeU8/jP6HCw4Dvqsgap2q/hxMrxxVpki0joKd0ag/GqLONFp4Cuowqv/nln0x+Q3L1
         Lb7qwQ/AvPjaiQxaXpK3sZWWMkmf9dz079jVHPeQKbxF/oeD8D83afOXodFG9dqY4PRT
         8hXA==
X-Gm-Message-State: AOJu0YwJiqi4nlANGJGM6/vLvD04qeaRSx0125/c8hBxspRi+OZDijhc
	dUjSOFtM8NhD1kY6cR2cSRdNEscPd4+yCliL63064knyL/gka+wpmIa0
X-Gm-Gg: Acq92OEaa7FUVILgLzrZ2cyH3fWY++nkYsy5lNPAZDo7m1RMQ/d+ZsDff0xw6Drpvxd
	AyhlMt9Wd1V9dKfcjKfMkCDgpukaa0plT1Ua/eDuViT/skPgUuYmX/kCZEXN6ugukkquICTM2Jf
	YYkRooYOjs9A9cASDFYFpojbfba9vQ1qMMQ0EFZox9C5V2whInxuIlr5cgYMvbgzPGzoefqKGyI
	aGmEjhLHsQCO9MYZMMmVXrwwWv8vkvlGxS47+2rpOxVLhASuan/UicdlQgpvS9kcsieThmQQbQ5
	s44XbfLO6QzvxRE6w/+n1LomR1VWyiJCY177pCo6fWq4NZMiMwOl83OID8g19ecAfqiuK+vXVaa
	2/2ibEjJtAyv0AGZvU4lXX23IjSa5zQn1zakBzGD1YXdTpSEUoN5+8du+zrt4Jic7GFmj0EaR3D
	9MLeTX6/WP3S1QXaUYSNCdOcCfPyOX3dmuHlimubY7OHHvHVK6OLfm
X-Received: by 2002:a05:6a00:a809:b0:837:735b:826f with SMTP id d2e1a72fcca58-84526b9c3cfmr2072767b3a.32.1781688983521;
        Wed, 17 Jun 2026 02:36:23 -0700 (PDT)
Received: from localhost.localdomain ([2a12:a304:100::206b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0226acsm15521653b3a.48.2026.06.17.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 02:36:23 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	toke@redhat.com,
	lorenzo@kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 0/2] Fix partial copy of non-linear test_run output
Date: Wed, 17 Jun 2026 17:35:55 +0800
Message-ID: <20260617093557.63880-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-300097-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paul.chaignon@gmail.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7302698038

When BPF_PROG_TEST_RUN returns non-linear output and userspace provides a
short data_out buffer, bpf_test_finish() can return -ENOSPC before copying
the packet prefix or updating data_size_out.

Fix this by deriving the linear copy length from the packet layout rather
than from the already-clamped copy_size. Add selftest coverage for both
non-linear skb and XDP frags paths.

Changes in v3:

* Keep the fix patch minimal by leaving the existing offset declaration
  unchanged.
* Drop unnecessary memset() calls from the new selftests.
* Keep the pass-through TC program and larger test packet for the skb
  case. pkt_v4 is too small once the short IPv4 input check is accounted
  for, and the existing packet-access program fails before reaching the
  partial copy-out path with such a short linear area.

Changes in v2:

* Fix the Fixes tag to point to the commit that introduced the shared
  non-linear copy-out logic.
* Drop skb-specific wording from the fix commit.
* Move the selftest from skb_load_bytes.c to prog_run_opts.c.
* Add XDP frags coverage in addition to non-linear skb coverage.

v2:
https://lore.kernel.org/bpf/20260616093103.471444-1-sun.jian.kdev@gmail.com/

v1:
https://lore.kernel.org/bpf/20260615073856.152479-1-sun.jian.kdev@gmail.com/

Tested with:
  ./test_progs -t prog_run_opts -v
  ./test_progs -t skb_load_bytes -v
  ./test_progs -t xdp_pull_data -v

Sun Jian (2):
  bpf: Fix partial copy of non-linear test_run output
  selftests/bpf: Cover partial copy of non-linear test_run output

 net/bpf/test_run.c                            |  8 +--
 .../selftests/bpf/prog_tests/prog_run_opts.c  | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_pkt_access.c     | 12 ++++
 3 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.43.0


