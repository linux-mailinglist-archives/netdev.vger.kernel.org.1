Return-Path: <netdev+bounces-306870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S4uiJBBfUmq/OwMAu9opvQ
	(envelope-from <netdev+bounces-306870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:19:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E20741F0C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 17:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UPkla6AE;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306870-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306870-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F27530107E7
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D112BE621;
	Sat, 11 Jul 2026 15:19:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7A1E5B63
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 15:19:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783783181; cv=none; b=FkdHQf2IcEyYXzHz1Xs3lodT8Y8U8bAT7Fox0L2phlMptl+vvbzedkZ1sVCvLlOZvnLS1nUN6bCGjvYmaNiv4E/xNyYhhGJZP48om9Kvq/MEep1lXUg6JfquLX5vhr0koN/klM52KJKvbgeliotkWsrYskDA1rUOBdgx8f9m1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783783181; c=relaxed/simple;
	bh=V9QY9B83n2ns5XLKm+CT6FF3+FW0tnJa9JzNf3Cpemg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peHdAdzfwvDNY9NHkDpFILZdozQ08hFdlZDvz9lMmR1GCfzFdsQZjZjVQ/ODYb9zcSXalnOhIHRLR2kXjKlkYOwV0afuYAzJj2j+HbcRQg/3dYAwuYKYceS9pvKtMS6EHNHRmx/zgNgCrEfM11A0BcUxnCqes14EkYLlK7Xwypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPkla6AE; arc=none smtp.client-ip=209.85.222.182
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e622cc874so95017885a.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783783179; x=1784387979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5KFGJjE53tGgSqBXE7Viow932nL7gBRVx1kgI380Z0c=;
        b=UPkla6AEyHrlk/s/pt2B6UtTbwe0E+Y88NSUF4xp+3YyhaqYP/ACUyy1TwXBAWhzdo
         ApT1iIcrsgVPdDJPJaT3na7lf+s+04M1x7bEzfP74IbVhnzSD/ofLd4OgK5wz+hpGObY
         +WSPmhTTTGA4SWg6OmmPy+bcYrrrK6ZnZUpzWjzFzdNGwkVyKsKXrO+69vmVUk0lGU0k
         qZCkwV2lYTzE1sFYmiAJzadJk64miZU5zyzArVaBs+KV1EQEJmN8qLj6MIFFjAIHAGsT
         BbFZrfrJF3w3W0N8d925SeD8YkTK7ANy8RcfpKpPKTBBbQ3YOZbc3qCNVvSOxtLqSALN
         2qfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783783179; x=1784387979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5KFGJjE53tGgSqBXE7Viow932nL7gBRVx1kgI380Z0c=;
        b=tAibQ0oAoXIv5Dw4BG6fMCBlK11TTAYE0+BbOquZ/BkMkKbPdNcOuoOKQb367C10Qm
         MdUuJdgKgl+5qIR/QYjLj/uV/tFsLjcDi+4k4f5o9a+Na5b8xyY/QWIZV6Mt5fs36E8x
         0IYdYiUD0Oyp1Eajq+aQbPDOplgI4Wxz9dMBbscoPTgzS/S+IrYawT4c6wAt65Ixh0dt
         7QuS5gMXmr3ulZtfx9sp7B3KkW8IiE0i1v4zFdwEQT7SpOKuNs6RZEoHbaLRLk6yGQl/
         CSISVbxEpBBx9YouYQ2X51vJv0ZEP9ibW9hpAgBikHUmaW4f6y+E+5Dav0qlO47hYYix
         lR/A==
X-Gm-Message-State: AOJu0Yxu/wZlhr+MY4D6rfr41y1PHddttouISROEvhsw7R8LDsY8aa+e
	tqnqxE27e288pE3Mq85002AHfNBaxBNPcFTEjXL2fX9Q7zLvjpqc2Dy1
X-Gm-Gg: AfdE7cnbze9wx0XTBKI9WSa6KONmISGijmp6FSUu3NsajY43V0KOPS2HC5R+ZNMAD3M
	d9pNIx0gGMVVpYm0JzETUa45lUwHrNDmaZM8Sj3Xe/HH5FHYC39ACZYIttoTbKY2dMvTjRH7U27
	YdBMQDP1AaydBmqHMFacUyKNkcAzyWcA9Wox/84Viap3SMBun53NrD64th832Az9iJ764n7ufWm
	m2QP5kSl8WIdV1lIT7NGWCic8G+xpoUDsMqZYr823MiAOvh6WLp8pgbk7ZXy3kJ4BXUVvUq/9wd
	Xv+udlF3Eq/Sozx/v8OAUczaefXaTSQkOt9YP9HtfIqmlyBOJG7BCX1x1a+KOP+EnEt9kNyos7Y
	i0A7Hpzl7c/V/0hdXo+EdK7/8JLYWcK56TKkBM5T+0rohXlNXfMt2nxGfKch/1OkLCYZzE/xSYq
	oTG3xBIRX44b5GrPRDWPth6KkmnocjKyFjsdTd6+DsSPYqjSA7zAokhnsNvyPhYCLIVhAsoQWky
	qoSi/nBsg==
X-Received: by 2002:a05:620a:448c:b0:92e:61f7:5689 with SMTP id af79cd13be357-92ef2c37c37mr328933485a.58.1783783179099;
        Sat, 11 Jul 2026 08:19:39 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4a082sm467704685a.7.2026.07.11.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:19:38 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 0/2] amt: fix use-after-free of the skb head across pulls
Date: Sat, 11 Jul 2026 11:19:32 -0400
Message-ID: <20260711151934.2955226-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306870-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7E20741F0C

Several AMT receive and transmit paths cache a pointer into the skb head
and then call a helper that can reallocate that head before the cached
pointer is used again, so the later access reads or writes freed memory.

Patch 1 walks every AMT path and, for each pointer used after a
reallocating call, either snapshots the value before the first pull or
re-derives the pointer after the last one.

Patch 2 is a smaller, separable hardening change: the three handlers
that rewrite the ethernet header do so in place without making the head
private, which corrupts a cloned skb (for example one held by a packet
tap).  It adds skb_cow_head() before the rewrite, split out so the
use-after-free fix is not held up by discussion of the clone case.

Both patches build cleanly (x86_64, CONFIG_AMT, W=1) and are
checkpatch --strict clean.

Changes since v4:
 - amt_update_handler(): also snapshot amtmu->nonce and
   amtmu->response_mac before iptunnel_pull_header(), which can
   reallocate the head for a GSO cloned skb; the tunnel-match loop read
   both fields through the stale amtmu.  This is the same class as the
   query handler's response_mac snapshot and was the one remaining site
   the v4 fix missed.
 - Remove the explanatory comments added in v4; the reason for each
   snapshot/re-derive is described in the commit message instead.
 - Order the local variable declarations longest-to-shortest in the
   handlers that gained locals (amt_membership_query_handler and
   amt_update_handler).

v4: https://lore.kernel.org/all/20260707193243.3448201-1-michael.bommarito@gmail.com/
v3: https://lore.kernel.org/all/20260626111917.802243-1-michael.bommarito@gmail.com/
v2: https://lore.kernel.org/all/20260617123443.3586930-1-michael.bommarito@gmail.com/

Michael Bommarito (2):
  amt: re-read skb header pointers after every pull
  amt: make the head writable before rewriting the L2 header

 drivers/net/amt.c | 87 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 24 deletions(-)


base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
--
2.53.0

