Return-Path: <netdev+bounces-271093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ67Cvyewmm3fQQAu9opvQ
	(envelope-from <netdev+bounces-271093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:26:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6CE30A1B2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9017930117B3
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2493FE364;
	Tue, 24 Mar 2026 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdNeJZkf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C79A3264EF
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 14:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362361; cv=none; b=mq7dzmNZY7NM4r19ujpTFnDUgCZEmrsBGeGtkTQ4S/ExPmgjXAsFhjchmSwkxQwYUKUgXwWI0PgbJQuPXnsF2wqC0s/m1A6jwFWT9WuwBHvr/DV2z6Mw0ua/gdccyeX8lcAmZh/zwRL5c8hM4KS4cvgklKUa97OaK+7Sv2rS27A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362361; c=relaxed/simple;
	bh=nkJRi/2RaO1u2a76idXnMHtRQAypno49EMz1ZDVNiII=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kuvxdZdFuHXOueon88yVR3Ydtlg12zVJgyTzdHMVGK8Qi04tt0VV9M0DSDB2ZeTjtWIZEv+JjIoLTx1qutk+XrhHT4IIDu5oRPP/tInkCN7X/+BwMGiBUOxTVcAKKDVx2zagDuJt/kIp+XOTVPFN60k++qa9jMQDx9ZAoWoXC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdNeJZkf; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50b4b81c632so45566171cf.1
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774362359; x=1774967159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/GbtZ3A7i3xEzpwBud3/WfNQ9mAY8HVGXdIOWD/OqsA=;
        b=RdNeJZkf3qM8iR4Ucr/4Q41AZbMiviTOwcgK1tAu2vLzvut5cNfm2Sznu9HORZVKcE
         S3D88Eoa1e95dmNTA8AOl+FaRxRkSzBoQcT5sSZ2HWiwpm0QvSvcCY1fvZXueXIBZYBz
         mhFJit9wVtWCeJPPvgTCAsYqcu8589YzFt5Nx06v1CCVzFTi0GsEdbSoce6+m0IqgWo2
         aCNQb6mkxPwLuL7PeImvboFLRbATsmd0qoZF+8mkjqrPYRcGyMXZiEmiZFmWo2/Zaz9d
         NVS0qV38fmBS6T1atTSaF16ZRwr4bLtTWIPIYeIQWPSn1LChexrk2VhsfIZBvp77jHj7
         rycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362359; x=1774967159;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/GbtZ3A7i3xEzpwBud3/WfNQ9mAY8HVGXdIOWD/OqsA=;
        b=T1cuF1vnvDzExY6ZVMyGomNVrEo7DaYf1ZVudboAAazCeP44qy6RchLYOOw5GEqZ+S
         tSebhgbJBOEWMlUDH5zc1XCccUX0WNC5Gb7BdiWpBBLp6Mpv3duoy5XmRg35hSTw6LGB
         HwVJfBzg8+tW67AjSC1R3TRyROZsHtkmJnkawrU/uP0rl5lABcftPRhiv5p4fTDDvgL2
         BkXQKlQan25mv36vxyHuJpLChO1ZI8ZvBFXXYPJjuQSFvaFU6VhVcG0pZmkgwp5uDW93
         BGkPQABGZq64hITd5Y335jiSCmGY/9UNK7CH7uhRytcmPP3TX7p6nBDcv2ljG/cMWrs0
         Btkw==
X-Forwarded-Encrypted: i=1; AJvYcCUgAAwm56PdDxmA4BGkalVBR5m0VEdIcTOaGQHlSeGTEvKPC4Pi5ilZrjBGnKnCbgdjP4RsdzE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UV3NNfqf5ac21990E0ZSG5U+AygNms1K1LVjmHNt3vpBZEbl
	tRt0EEK6cy4eJ90yQrx4a1NSE7pvDa2355C99k4FkhgbVXsiF/3xEYixrxhJixLLT+oLiSvGaoH
	Me4CmJ9zeVZuQ4w==
X-Received: from qtbdn5.prod.google.com ([2002:a05:622a:4705:b0:509:7a:945b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:590e:0:b0:509:329e:bd5 with SMTP id d75a77b69052e-50b3739f870mr244072621cf.3.1774362359126;
 Tue, 24 Mar 2026 07:25:59 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:25:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260324142556.1844523-1-edumazet@google.com>
Subject: [PATCH net-next] selftests/net: packetdrill: add CONFIG_MAX_SKB_FRAGS=17
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B6CE30A1B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Before adding tests about RWIN, enforce the default linux value
for the number of fragments per skb.

With 17 fragments, sizeof(skb_shared_info) == 320.

With 45 fragments, sizeof(skb_shared_info) == 768.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 tools/testing/selftests/net/packetdrill/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/packetdrill/config b/tools/testing/selftests/net/packetdrill/config
index c4a19a78552111df690d2c97c0f3a8abe2176ada..8c739db4752c3abaaa8862ea2aeb661a2d5f0575 100644
--- a/tools/testing/selftests/net/packetdrill/config
+++ b/tools/testing/selftests/net/packetdrill/config
@@ -1,6 +1,7 @@
 CONFIG_HZ=1000
 CONFIG_HZ_1000=y
 CONFIG_IPV6=y
+CONFIG_MAX_SKB_FRAGS=17
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_FQ=y
-- 
2.53.0.983.g0bb29b3bc5-goog


