Return-Path: <netdev+bounces-285871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC5TGk75/WlilQAAu9opvQ
	(envelope-from <netdev+bounces-285871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729B4F828F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 809C9302DF9C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 14:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8373F65EC;
	Fri,  8 May 2026 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOLkqDc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEE43EE1CC
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252040; cv=none; b=rFuJ9MNiqg7DAGk0Rgnz6drETVs8fTTJS3q2a9Zv0e9TTzp7a3KEiYoM8D8YyvY7RBegl1TYSt/RnwFASZBxwQPUeOdOoP2nmi6LhwerOff/HF/87na/fRiwm5FxUae+7GEMpex5C7xhzUOcNLs5Lx/Y+ulaXCYWFDd+7+nCYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252040; c=relaxed/simple;
	bh=nXs/4DWqryu4+JAyntBAhrhB85pWzV+OLPNXFOFy1zk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NPzzbtYfoivRCoXCgX0yKurCPSN0g+VA4kRZWwVYm1AUNqY9WD1wpqZAKGAFQWRju28XheNdKDjS5GjFvB5eG8lNoYkyhfmBuT+hwfnuvPUUC9bCrpMvQgWAJJGRv8sU2yP2FXz9PQFaqOCcXYYcnLuwtwTAa4S+urdt7XPKMQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOLkqDc3; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-435153d9b68so1255639fac.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252037; x=1778856837; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oW0JV5YHJoHP9APafUOMSje4n7Yn/urY8p671I1K7jg=;
        b=bOLkqDc3i6nzmGJryQ+RzogDgJSw0Ou6E/nWeI4KreAZ5OrJZpcDwsS1JHeGucWbMT
         q0pvvVvvHHjcZMcMhinaIxhsE6Va4GiIsa5Odi4qD8SQFnEH1JddeNet5G+79G1eXXbc
         o1qyOgtL3gqTp81NClm7tOpyM8m+fEZGnCEztZwc2gPN7+bASFU0aRZWowvRwENioKgu
         HBJgHxX6ltaV88mD0Eu2KSAF40XPP6YFugHiS05snQZJ4LRLBc/OzZy51LaIS6s6j5qW
         M1h3XEorq4rgC1NERmOgJsimmYmfe5t8T9TYf6fXJUMyphapdqI5G5F5vf7cKrZ5iY77
         HN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252037; x=1778856837;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW0JV5YHJoHP9APafUOMSje4n7Yn/urY8p671I1K7jg=;
        b=itay2gMDb1enRKrNbiBMerlBaOu7fUq3ItxBBEgUu89iszOOVKUkRenUC+k9232bYC
         fo9nGBjChDm2e4ettL2gXk2jbe4NUt/Ta/LPDvGcTfrQ3JS/TKVS9BDLiMXH1WCAdZIL
         5i2c0UW764ZjynRd40qLn8kXzhMM1O1SGZe5Yv67K71YLxqDb4H5rSg0ej46RtYbfknV
         +T4mCRW1f8eKjhoEGlTuwaLjQUoAdqZb7m39IO6ZurKsR3NHei7+nCIU/914yBY9QkL6
         aCRcdnVwQJhwnpvk0VDC/I8JPm/G6EKQpJR1KT7Uxm/liGZg3n5jxOUx6Vfjsj1lTK95
         z/mQ==
X-Gm-Message-State: AOJu0Yy+sUTEz6VSBaeqvHZNRV8UI2GUDkj5gdMdZGgvQ+abt7j8rupY
	ae3HKSLbVf7rb/2BiJsOQATV4rhMCX/HU6WAXkIHuljdDXgifUCkJRjB3yQEaA==
X-Gm-Gg: AeBDiesM4nlvRQ1f2lxBf3h1OdaAcexrc2EstfBBwnNK8WVB+FoQ2v3EofDeh9Kuv9n
	XA4suMJPPlFwDbtM2c2xwJyrj1hdRC0zvC2Xp8MAB0T6eDOIFRDVTV28q2SJ0cEGpnZRgBQgObG
	u6+IKlKaWWh6mFgFFlIRmfQKb8/b6PXHzbumyJOZsKvn72uNW2hpt6EYSRZvafVdXaR8VPTu9Hi
	osTi9BtE65tlIcC0U3HvZSG4sXaCvwYYsGbixv0DIB0UxmTzPi+YquPq01nMvBA3/vPQz8MPT4e
	5IYtxOqCW7jY274VSnLW4JtiVFiX0X6gGcQbcSNam1A0UV9Zo8GexCWYCGSQZVzyAoQAeR7bH5Q
	3F9mtMFqs+XXGZwMBFk0yUFUSEyzyKPWk3AKZWgIhXLVR1lhZU0BPNm7S9kiO6UaUy4Q0+xsRgf
	Sq2oavXEcQEQr2+b72RkPYJIhDS9zBedn67tqCcpbRQKO0w+86rWvEzoPCGuCiBw==
X-Received: by 2002:a05:6870:9a1c:b0:42f:ee6c:35fb with SMTP id 586e51a60fabf-434f64e9150mr7554864fac.20.1778252037459;
        Fri, 08 May 2026 07:53:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e94edsm1993038fac.13.2026.05.08.07.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 07:53:57 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net-next 0/6] netdevsim: psp: implement real crypto
 operations from the PSP spec
Date: Fri, 08 May 2026 07:53:43 -0700
Message-Id: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPf4/WkC/x3MwQqDMAyA4VeRnA2k7RjMVxEP4tIth6WlKaIU3
 92y43f4/wbGRdhgGhoU3sUkaYcbB9i+q34Y5d0NnvyTHoFQTX6YLeNWzlwTUnCOYvSvEB30Khe
 OcvyPMyhXVD4qLNd1A6Qs1BdrAAAA
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 0729B4F828F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285871-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,psp.py:url]
X-Rspamd-Action: no action

My motivation for this series is to enable packetdrill [1] testing to work
with netdevsim the same way it would work against a real NIC + driver
stack. That means being able to write already enapsulated and
encrypted packets from userspace into a packet socket (skips normal
psp tx path), yet still trigger the psp rx path (decapsulation and
metadata creation) just based on parsing the bytes "on the wire".

I will add that I believe this also has the benefit of making the
netdevsim code higher fidelity by removing the fake authentication
hack used by data_send_bad_key testcase in psp.py, and replacing with
true authentication from aes-gcm.

The header parsing in nsim_poll() may have some side effects on
non-psp paths from the pskb_may_pull'ing in nsim_psp_handle_rx(), but
that can be avoided by not configuring psp.

As for the code, I believe it is fairly straightforward. It implements
what is described in the psp spec. It preserves passing behavior of
the psp.py tests, and I have tested the crypto interoperability with
an nvidia cx7 card.

[1]: https://github.com/google/packetdrill/pull/100

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (6):
      netdevsim: psp: reset spi on key rotation and check for exhaustion on alloc
      netdevsim: psp: remove unnecessary UDP checksum computation
      netdevsim: psp: move rx processing into nsim_poll()
      netdevsim: psp: implement kdf from psp spec
      netdevsim: psp: add real aes-gcm encryption and decryption
      netdevsim: psp: count rx authentication and length errors

 drivers/net/Kconfig               |   2 +
 drivers/net/netdevsim/netdev.c    |  18 +--
 drivers/net/netdevsim/netdevsim.h |  19 ++-
 drivers/net/netdevsim/psp.c       | 333 ++++++++++++++++++++++++++++----------
 4 files changed, 272 insertions(+), 100 deletions(-)
---
base-commit: 6a4c4656b0d2d4056a1f0c35442db4e8a5cf8021
change-id: 20260430-nsim-psp-crypto-03110ff293f1

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


