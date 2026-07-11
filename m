Return-Path: <netdev+bounces-306822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sYN8LKQfUmrnMAMAu9opvQ
	(envelope-from <netdev+bounces-306822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB337414D3
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:49:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fpqyhHz+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306822-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306822-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287D8301A1EE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B43B42ED;
	Sat, 11 Jul 2026 10:49:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D93A962E
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766944; cv=none; b=i9fe0neaFKZZtsjIsjZEol88j+E0W0EOf+vW27zrDrRbaU0/ECFMf5JcO9UbyUp/K6EN8K40ZPqfNg2gq7d3RA2xbh8Z5ZolWh5lJYssem81/xcJMuQW1HERFAH1v2e0EwXmJ0WcBqcyp3i9WDOnUk3MlhEOSOSgvlsUjJWue1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766944; c=relaxed/simple;
	bh=4QcSpgEoF0nWn5Y9kPAa7ADc4/e/LpiGpOgPc2Snb3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FT+YeCvLS+F6N6ZuAGrzekCFsaDvJ6367gCJoVzV8G+smJQ/PWC/6iw99jmtlk8bqxdcHTNkbmEllLKGTBhsqq/uCUXwOoikzAfg2peBpBO/2kcwsCkwwwfpKtDBcF5rsRmppGVbCbK6kfIvIlb8Cj6hZuxGUY/hjcBvNfj2XHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpqyhHz+; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so209859266b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766939; x=1784371739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=au7GYuxpuvO8X+mfStKR1O+GhXnwrR6hrIqMke5JJ3A=;
        b=fpqyhHz+5fwFFDiAJcoEAe2aSJy5DExqZiF4yZYLqGjX30yiJO3JuYREi0QNuhRcfV
         4I8u2KYD+1+6NFJUkM2a44W3qrWEr2GFZXtd3Xpv5rS6PGIq80kK9ur/xEUl1aNt6eAc
         MPH1FlBadhNwR7tvshSNx88BLAtR3KKlITVHdIIDFvulfQWgUqJoZGDoaXgDMAIwWv2A
         Wmc6JtBt0tXEob5KIx2278z/TLiArxocpZg4KLqMB2CQGrobo7IRJLcsJV7ZujDLIEON
         4qCmDFbDbvcDneedrp/H3twbx+G81p7xcZ9MwFX9O8qALAi17VNM1qxPQEc1D1j4usJP
         cdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766939; x=1784371739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=au7GYuxpuvO8X+mfStKR1O+GhXnwrR6hrIqMke5JJ3A=;
        b=dKT4Xen0IQVnzZyT1bhvz2bWczUWgF7DR0pm9nqo4UuFhWYWMWYajSf8ZfeCug8Adm
         O7wn3zb96iGNbEadtMxVgEOg9RItx8lRs746atbkcxrkt3UqZqaO+rW6Lf58Ow5FrO4d
         lYs2ONFWn0M7hgcxFI4Ej7WED8Q/4pYKEnwvJFsb+V1zt/eM4TPbKmSTclaPiDe1AsWH
         qZ4cQMbJ5c5v4IJnsOYEcCdFcHAM8RMRvQBHUmi2pN32n3QWx+kFd4WVcjkt8muqwCMl
         INKhgEoel3m8YkgSSknJXHw1VCuBvXeSHCGPCDt/XjRUsWdRFfdQgl5Pf8XHrlmkqhUJ
         jJsg==
X-Gm-Message-State: AOJu0YyLIb0rS3lcmTGJ5ZMLiuXbjI/zLmIyXtya86P3PKvryepUykUv
	vwRvD8MZ4DQeA7BcJEBtChjiR9sF7niUHtodpHEfGra1GP60sqpUb4cq08d1Yw==
X-Gm-Gg: AfdE7cnJL2+J4Kt6Z2O0JARZO8KwcifeSQzkkV/5EH8e9Y5G0TEtJGL0q8UNJG1wBUl
	ERcWI7VCzPgv8OllLN59NL05MqWk6oFVTwkemtDEiaooLuGPDoPTw+h6o9jQibLgo41sDR55Wd2
	WWroIM5m6ny7DXHpb3/527flEE0JUNd7VH+aEaSK5WiDMweYmNiyAT50hiPy4dYUtuk8RH+rdKn
	5mbDI0ESn+xS3pGOGOvgf3PwhjD/otvS8wHhwdn4aGI1+LqNYEHE8gF46+fvjBvcm2uROinuTuH
	CdwO4OaQIjpxr2mwVQ9OUVmfT4ilStcD98hzvkKUEP0S10sJV532TXGWxgorKg4oBy0YWV4+sW0
	IZLSAEAXc5hNXxaZP77absOfII2biqXlVdr04lJxhG4PB/Ia8TUQRAwwMb1QvBV7DxPznBk8Byk
	YXaCJrF3d8wKSyGIb7vbwV1armUd81k2n7NA8Z4Zegk9pS9YF+lhbu9Fj2V+se6YRmU3FbPK0SO
	0s2HktLNNBtYdVvh7EZYUvAIMlXhRYpUQGom3TOAgSUVXZfNA==
X-Received: by 2002:a17:907:cf87:b0:c15:c638:d03c with SMTP id a640c23a62f3a-c161e9fbce2mr86442466b.47.1783766939215;
        Sat, 11 Jul 2026 03:48:59 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15beb53b86sm609123166b.25.2026.07.11.03.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:48:58 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	io-uring@vger.kernel.org,
	asml.silence@gmail.com
Subject: [RFC 00/10] io_uring: prototype for device memory tx
Date: Sat, 11 Jul 2026 11:48:29 +0100
Message-ID: <cover.1783614400.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-306822-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DB337414D3

People were asking about io_uring tx with device memory, this is a quick
and dirty enablement for io_uring's IORING_OP_SEND[MSG]_ZC. It's more of
a testing prototype than to show the design as I'm not happy with uapi
and how it relies on zcrx, and will be redoing it.

It's piggy backed on top of a zcrx instance and relies on it managing
the rx queue and talking to the device. It also uses memory and mappings
from zcrx area. Since there is no proper iter type to pass  netmems,
io_uring gives an ubuf/iovec iterator and relies on a new sg_from_iter
to setup skbs in the right way. Just as devmem TCP, it implmements
{get,put}_netmem by referencing, and verifies in
validate_xmit_unreadable_skb() that skbs go to the right device.

Pavel Begunkov (10):
  net: pass ubuf to custom sg_from_iter callbacks
  net: reject zcrx skbs to not registered devices
  io_uring/zcrx: switch to pcpu refcounting
  io_uring/zcrx: prepare areas to be exported for tx
  io_uring/rsrc: introduce buf registration structure
  io_uring/rsrc: extend buffer update
  io_uring/rsrc: add uncloneable regbuf flag
  io_uring/rsrc: add regbuf import flags
  io_uring/rsrc: add zcrx backed registered buffers
  io_uring/net: implement device memory send

 include/linux/io_uring/net.h  |  10 ++
 include/linux/socket.h        |   2 +-
 include/net/netmem.h          |   1 +
 include/uapi/linux/io_uring.h |  28 ++++-
 io_uring/net.c                |  37 ++++--
 io_uring/notif.h              |   5 +-
 io_uring/rsrc.c               | 204 +++++++++++++++++++++++++++-------
 io_uring/rsrc.h               |  32 +++++-
 io_uring/zcrx.c               | 104 +++++++++++++++--
 io_uring/zcrx.h               |  14 ++-
 net/core/datagram.c           |   2 +-
 net/core/dev.c                |  10 +-
 net/core/skbuff.c             |   3 +
 13 files changed, 381 insertions(+), 71 deletions(-)

-- 
2.54.0


