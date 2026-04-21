Return-Path: <netdev+bounces-280169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMpfBsaX52mp+AEAu9opvQ
	(envelope-from <netdev+bounces-280169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:29:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFD943CBD6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 17:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F39B30067B7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603593D75D3;
	Tue, 21 Apr 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lekm6NdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0323E1CAA6C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784944; cv=none; b=HBE2lOcVIdluDGeCX44ICVN4NK46xmrWQMSdUuUkfLPVKz4MWAzeXgBWtw6U4UH/l2CJ+jIx/3sN8FleXfTYMWbNkg03DX1aEhQoxknBtvMI0TdDvC1/I37TpvbJlIXVo07NsydYxlQJPyJvnSScoNurAya7ofVbl/OU3R4SeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784944; c=relaxed/simple;
	bh=ONNuuXNmYreZdsSkPA82yNoEEKq06J/t0dBvR50GDeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0VpS23Ty0LhxNdHH/kRT4fN4JgUtHX+k1txA/pce45fKz/EyEFOfRkYxXkY7D52nnQd4S5V3kXSCzV727+KPB7rax+Zs58idfpTyDr2onRA2f9pcWzeNr6RVRxosz00p8lHO++/C/st6nr5XRylGDTCkQSjirkv23Mzjv9T23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lekm6NdQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso34303305e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784941; x=1777389741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtgPgZ4HlQnl8j98LJ7hw96CMdHc/eqoj0ut28JAbyc=;
        b=lekm6NdQsvdJOwhU6mmGtdIS12QvIXUN74PdvIm2/Y8UAmSvfEyWG0WxhBw7yXE4/4
         vKZ+TW0Fg4Lll/3jAofwNiyIyCl4d2yZfgYZn3ReoCJ/6M5zofegzfJnGRhHTf+MNXXp
         MEgATZLI7w1+6BeWDXmFbDVa+gJ0DLKaK4Y3MSsLFsw8W/wD6ZYMTDVnES9V62CT+R3F
         L9vKsVYvfcW64S2w+v8SBj7gg2VuBHPSVYCyk01Rz0eBsErDn4f/HwP+l724xTYlOKUR
         f9T5B5M5rsMw06xv49FMhW5jnPMl8oMQSSHs9+4Jf0Vsw04hvpv02leq2TzFfueopwcV
         PMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784941; x=1777389741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtgPgZ4HlQnl8j98LJ7hw96CMdHc/eqoj0ut28JAbyc=;
        b=RHbOf1wVRlM3u9FzwiRd3zYt9AjylDhUkYG3Q1FiR31qP+el9cPfMZt7wCITDDQhNX
         o3980svWcGFWha3ciLccjL1P/jUG9qvijc8f2PNdnaj/g8BYzsDT2BGWEYr2TejQ592w
         rGxUF9KW+kUB9AYPwJqwGTlFnJa1p+iqkGc4CONxrXJk9nVQHSUWqnt/oSxwOkwPqKAv
         p37VLpYtFQn1nohL6iYdeIgW97UsqQJET9cssuZyjJHhVnEYi1ddutqox/QsqQe+xbQV
         m39IS79+4Ak42e0tE2fiI6WmXh2wx4y9+QReOSqjYnvPKrccqLQ9r7CkKYD6agksekcP
         6wkg==
X-Gm-Message-State: AOJu0YxdGrPhSSFk/V0LOEJwonBTo20HHSY5Si2ScGmKRywsDs37Gwuy
	MPJjGNA/6zfIflRMGd4U4N5h+5IaIf+DINxXzy2QjCB2ByVQvaSyDwf7v8G1gudL
X-Gm-Gg: AeBDieufd1m4sXCJD1GvtV0/Z7UVtBWs2iCDUVeYcVqPTitQLpdPXnkUv4Xo2xQtjYX
	m/WuDA2OE91NB6QXwA11np6DdIA/xndsnJ3kqB3i8BNpVR8cQmsbUcYJUDC2nlME3p7BzyQ8ZXc
	s/a1gSkwdbKsIz5sqTj/4xoP8xlPq7WigdkXPRpFoTiUWnMw8VuUIM3EKotxWLGC0mtGFeKVRzu
	XueCOoz17OfjOEgwtbSNf04Vt8XYFc2re8ZRNm0aN5OIZEfNBvoLTaVE4oWJjClPvO2sVo2fyyF
	X8wXSzLoRucIpOOQppklN+eHVJXFCG91YLyIc6GrQGrjQTEgHmsaxNuG7nHWXa2QNFQev7i0SMC
	HvVB3ew5ALzkezksAyFWXWGwUd463OOYHyng4i9aLF5sHFebeyslzINHqxR3WoFSvm7qZgbPq6x
	AxqD+DSvPYiH34PxrOFkMiRdBh3wLT2/9KMAa+c+WdoUnnVtQYC7z6MiveS/7im+qQo1yVRb+vo
	XWL7fEof+8Cn21Z6UhAXg==
X-Received: by 2002:a05:600c:3150:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-488fb7930famr275235665e9.24.1776784940756;
        Tue, 21 Apr 2026 08:22:20 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4411c9f4f03sm8975225f8f.1.2026.04.21.08.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:22:20 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 0/3] mptcp: add RECVERR and MSG_ERRQUEUE support
Date: Tue, 21 Apr 2026 16:22:08 +0100
Message-ID: <20260421152216.38127-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-280169-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BFD943CBD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MPTCP already advertises IP_RECVERR/IPV6_RECVERR as supported, but the
parent socket does not currently provide usable MSG_ERRQUEUE handling.

This series wires the MPTCP socket up to the IPv4/IPv6 error queue
paths. It propagates RECVERR-related sockopts to existing and future
subflows, makes poll() report pending errqueue activity through the
parent socket, and allows recvmsg(MSG_ERRQUEUE) on the MPTCP socket to
consume queued errors with the parent socket ABI.

The series also handles mixed-family subflows by applying the matching
sockopt according to each subflow family, and avoids silently losing an
error skb if requeueing to the parent socket fails under rmem pressure.

Patch 1 propagates the RECVERR sockopts to subflows.
Patch 2 implements parent-socket MSG_ERRQUEUE handling and poll()
reporting.
Patch 3 adds selftest coverage for RECVERR sockopt round-trips and
timestamping-driven MSG_ERRQUEUE delivery on the MPTCP parent socket.

Testing:
- make -C tools/testing/selftests/net/mptcp mptcp_sockopt
- git diff --check

David Carlier (3):
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover RECVERR and MSG_ERRQUEUE

 net/mptcp/protocol.c                          | 121 +++++++++++---
 net/mptcp/sockopt.c                           | 125 ++++++++++++++
 .../selftests/net/mptcp/mptcp_sockopt.c       | 152 ++++++++++++++++++
 3 files changed, 380 insertions(+), 18 deletions(-)

-- 
2.53.0

