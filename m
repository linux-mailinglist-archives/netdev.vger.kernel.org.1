Return-Path: <netdev+bounces-253842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DhUGcuxeGkksQEAu9opvQ
	(envelope-from <netdev+bounces-253842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:38:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C894644
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 890DA301E23D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B3354AF7;
	Tue, 27 Jan 2026 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ap8PHKzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510CE346E7D
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769517512; cv=none; b=BBZGaewlsjyswzVAcwj/YhWCaPTng3mbisAjOp5gXOZ0Qa+wyIyzaXJFL921DcZL96HK3EnvRg/bg28VZIB4elcxpzEZh2Iq2jNGHt6egIjQ0qCuTiiXhSuyo8ow0nyCA2iam+7FwvQOt3EUOh7OkR5PrbEOppCQMX/IBdPR9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769517512; c=relaxed/simple;
	bh=aY3o+iFnnJA2UL+XZVV83ITKFA3lqF0Q+eVkLbg54AY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=e7GfmN4zi+bfQlYsFQT8ZouVPSzCsEngdP0QTEyjyGrFghlvvHiLGkX6qrvVgwaUYERQ8pxRXzuDOt+af6R7qmA4d2ewUrr4cssxbcdvavWTXPiMzlSxhoB4OpnnN5i67eiNCAmUZGiBZmN7JL8WXElZwyUkDtu2yAl4C1lfOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ap8PHKzz; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70a62ca32so209420385a.2
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769517510; x=1770122310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rg5Z71QjKnaSUP2TEkyRH9SzaaIwaz4czfXWMb6hoeQ=;
        b=Ap8PHKzzOTZ6cHybE53ueYGS9qi4ZIYPBMs/Bn5D+AZRoJE0Ah6Lp/zZHVJe6ixKJR
         LTBj5ZpyhhmLfxBE0c4zNn0+eBeTqha8iUKkIfqudjd6c1Iazg/XDBCBnlitLwGWSOMU
         hBwqlzqq5ccBH68rQK3G02LZpV4wVgncJ6JO1le4aglzbXfPZcRg7BgpXtk9C4A1lX3P
         WENKYk5l4UGciBT7sWj9XPA/0UfjW5cEKM/5zJibfQt6b6uyo7v4pM38sVQc4rAmuMwO
         Jf7/AzndVYLL2epkb95q5kQOzZPP/QDLg26UhgOf8YDUQsQ6HFRqrwXAE6YhQq16FuwI
         GVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769517510; x=1770122310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rg5Z71QjKnaSUP2TEkyRH9SzaaIwaz4czfXWMb6hoeQ=;
        b=pqt5zGdPCmxfyDDfdh+7xHZtGQ45zzraEsgQOcIPMfl5Zl4mXre8L1W/AwGZHLwxyr
         CUKH3cneGLDGUDMm324s6KQ6TiShMGSwzWoro5lEIeUHvVCofnjgvKGikwJGJ/0zzjCO
         S7cM9vDlpwM5GNFPpNNpi9Cphn0bOxX+fXB8fLAa2mLPxESRHfUwZ9GLM9SJf31zcA3e
         HWfz9KtA3hydo7rVU+h1BhtjK67kL9419ayyB7oo5oh9LwaASGgyf6LTqqIdbVnvj6lB
         0Sl/QidGLYJpSx6fNXARQLoAmkgmH+MvU/4944JvsE4HFo0edRsNjDHB0CoyBVRDYxdC
         w8jg==
X-Forwarded-Encrypted: i=1; AJvYcCVEhYKfUVVK+2McXAqO6PH11JgHDISMEEYNRF4oCDlHlCbXKiQuoeYNLYUUY+OQBy1rGjduPNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQXm+LyG1zbi/koQ0eFo/dn08nvIJbkQFhdEc3BNGwYgjbchpY
	fEbiI65SVIZ8q3pKoZktsnIIK2iEJ+n22FXGr4pe5qq8PtT+JDcbk1GAgjhTQgDdG2f+nwsjAOp
	Yoi8icmAzd6jGpw==
X-Received: from qkpr6.prod.google.com ([2002:a05:620a:2986:b0:8c3:87db:d7eb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3184:b0:8b2:e179:feb7 with SMTP id af79cd13be357-8c70b8ebc3dmr167860585a.49.1769517510115;
 Tue, 27 Jan 2026 04:38:30 -0800 (PST)
Date: Tue, 27 Jan 2026 12:38:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127123828.4098577-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: tcp_tx_timestamp() fix
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253842-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D82C894644
X-Rspamd-Action: no action

Fix an old bug in tcp_tx_timestamp().

Add one corresponding packetdrill test.

Eric Dumazet (2):
  tcp: tcp_tx_timestamp() must look at the rtx queue
  selftest: packetdrill: add tcp_timestamping_tcp_tx_timestamp_bug.pkt

 net/ipv4/tcp.c                                |  3 +
 .../tcp_timestamping_tcp_tx_timestamp_bug.pkt | 70 +++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_timestamping_tcp_tx_timestamp_bug.pkt

-- 
2.53.0.rc1.217.geba53bf80e-goog


