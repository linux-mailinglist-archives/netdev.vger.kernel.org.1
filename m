Return-Path: <netdev+bounces-266511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOstNvMksWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D47625ECA9
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82420336F059
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 07:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C74B3B8D5F;
	Wed, 11 Mar 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep5ux/fP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672D3B776D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215790; cv=none; b=WYB65ZUJxzXD3fY1qWB+sAsffUIUU1fxwV3ML0enHubau4eLo5XaXPBp1sQ9J5Uv5bW82BkHCd072LX7zhN8t5GEQz0YstAHbHuDLQD4Ulmz5xKjcYnSgYrJ9cgra39HxOm7Z4TCCT/KTtJVUIo85mSWefa8O9vW0OZGyqyB16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215790; c=relaxed/simple;
	bh=FDmpie23sScGP+OdflWzKGb+2xENXEuu2nCfUaQR7H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LhYEWYXzZKLx802SwE72/hAyThwUOy7+qn8VbuLRP22RAim5gkmvQYW0asBgpdVq5ZhVhw6VAxPyQSdk0WU/Ia5vlSOEAuVNnfT8rF6jbCKGmke/9vQ6yPXm+/lrsGxVezzij65ZZuGsUV3INI/9vNW7AZ2wQkP3oA4mrlFGVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep5ux/fP; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4043b909ed4so6050639fac.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 00:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215787; x=1773820587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=Ep5ux/fPJChFYDWKlpLfuOO1GEiWepqX5YSftIEKjejsYgGZEgeFdk7VC2EWhb8sjw
         yZnAWSme2lhdMgJGZLPGlkWY87JyXHwKw4yrx4cKfk23r8vUdUGfRNsGcr3wepcvvpnX
         +ZBiNo36lnBHhItUD6h+wVdvz4jzLaBKAlOq1ct3IXYo96QCzlMTTcFLlSNkm0Gy/73m
         dbxk/35kkRGr+emMCJkLKVbfK+YxTXvDUZ1LCaE3Y2UvyHgKdd2b9BZSFfc8E3U8nK5s
         GoY5MNQo7LXXV+p5HCmzioTWpk5jhKPwayapprzlHQmD1/h79E7bvS/tQtw1ERPogvQg
         3hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215787; x=1773820587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=Q2liSCFnhYIvMNbURvS+SqyIk9nkWgZ/OB1NimhO3DPgF/M3CVX239Dat+i/Y7k0JM
         14LL95L/vNYparF343kqv7By/+YD2PGM63SaURrQUFz1G1aLPu+uT8ZZxm7qDF+xHzcB
         GdtnbCEC0Uv4J4NG8+axOBAP/GTdt2YNKNK4+74hBIdiNetbiloZS8DvhKY8eB8QNPqs
         RuviVcamuVTCZ0aOdq/opdP5XKZQjTymO9c0JFbcPNm8uTeVxfg32bal0O40e9G/VBf3
         xqnYmmcRejMoWpoLUshIYY4qjTjilWFnCQyxqs2RJBgptbtSWEcivYgHK6Dj/6xgUlwz
         g1uw==
X-Forwarded-Encrypted: i=1; AJvYcCUwmDvH9L/eIdMmjaembWDc4xRkQR1a7q0zexcru6eAnECfRWWt8axulkWE6kaC+gAUDnDwsPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydrd07tkZJbwQD2JFxH18ZebGjTmeXDDcgNtzLWcBTYETVhhKl
	WC4j2bqkMymrZLBJTs1/cC6xXRINTFvUQ0CquAGTdeYxTtPAhMCoUJXD
X-Gm-Gg: ATEYQzyEn1mAoo+sCCoa23matHI/Qip4nv4Y94PhLEAxek6BDE5w7xJNqPpcoy57Anf
	WT0udNafKvuI9YXZEOhkJ9oAPk+SGs+dOrK1J+vhrT86oRkviLPxkDptyqMK8/W2QYQtgXXj2nM
	ojhP5qggv50G8ZvvebTtXySw6hQD5rFMVG11UHOe8Vm6Z6dlaN3/s3LIJZE7jx51wGze9vpyQ6a
	VeSzBPb8Smnq6/ybYAlaDbH2v78cHXe1/URnu+uNcZ2hAaGkSv3lUOZrQeiCCxy3pgqdC/yfGAT
	vN+XD+MzhAjvf1RTWKxRhB97uc2Q6BVlraS7xHujBL8IcXWU2BzzGeWO0TrgAQ3bB/ZIWxeGVvP
	/Zn6rRoJFFOIVR+GRkI7+gpZeC42463KTVBjUTeAMSUJj11xGW1HWABSloAt8yEe1f/+qCYGey/
	4UzEiVUVp30TpmYnasI9d2ak5xO/wHGaBrPfOvnRQpAFpfKTrTDterI//169ppEUHejOvpCDKqV
	HWHIaNkacJhTsUG11OfTCLssWSQabqKw768onS5GvHIq9+Q
X-Received: by 2002:a05:6871:8a5:b0:409:6862:aba5 with SMTP id 586e51a60fabf-4177ca9e65dmr1127232fac.25.1773215786910;
        Wed, 11 Mar 2026 00:56:26 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:25 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across receive-memory decisions
Date: Wed, 11 Mar 2026 01:55:53 -0600
Message-Id: <20260311075600.948413-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D47625ECA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266511-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised.

Problem
-------

`tp->rcv_wnd` is an advertised promise to the sender, but later
receive-memory admission and clamping could reconstruct that promise
through the mutable live `scaling_ratio`. After ratio drift, the stack
could retain or advertise a receive window that no longer matched the
local hard rmem budget.

Fix
---

- store the advertise-time scaling basis alongside `tp->rcv_wnd`
- refresh that pair at the TCP and MPTCP receive-window write sites
- consume the snapshot in receive-memory admission, clamping, and the
  scaled-window quantization path
- preserve the snapshot across `TCP_REPAIR_WINDOW` restore when userspace
  provides it, and fall back safely when legacy userspace cannot
- expose the accounting in tracepoints and cover the ABI/runtime contract
  in selftests

Series layout
-------------

1. track the receive-window snapshot state and helpers
2. refresh the snapshot when TCP advertises or initializes windows
3. use the snapshot in receive-memory admission and clamping
4. extend `TCP_REPAIR_WINDOW` for exact restore plus legacy compatibility
5. refresh the TCP shadow window snapshot in MPTCP
6. expose rmem/backlog state in `rcvbuf_grow` tracepoints
7. cover legacy and extended repair-window layouts in selftests

Testing
-------

- `git diff --check origin/main..HEAD`
- `scripts/checkpatch.pl --strict --show-types` on patches 1-7
- `make -j8 headers`
- `make -j8 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make -j8 C=1 CF='-D__CHECK_ENDIAN__' W=1 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make SPHINXDIRS='networking/net_cachelines' htmldocs`
- `make -j8 vmlinux bzImage modules`
- `make -C tools/testing/selftests/net/tcp_ao -j8`
- `make -C tools/testing/selftests/net/mptcp -j8`
- `packetdrill --dry_run` for `tcp_rcv_toobig.pkt` and
  `tcp_rcv_toobig_default.pkt`
- `virtme-run` guest pass for both packetdrill tests
- feature-enabled guest pass for `restore_ipv4`, `self-connect_ipv4`, and
  `mptcp_sockopt.sh`

Thanks,
Wesley

---
base-commit: 908c344d5cfa0ee6efb3226d22ea661e078ebfa0
-- 
2.43.0


