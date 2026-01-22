Return-Path: <netdev+bounces-252209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHmgE2OvcWlmLQAAu9opvQ
	(envelope-from <netdev+bounces-252209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:02:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E35C61E07
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 06:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18C7F525B39
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188264657C9;
	Thu, 22 Jan 2026 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDJQcbO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF0C286D5D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769057844; cv=none; b=YCZEZObhZ3lNmSiMuWPdAR3KUDiKoUDebxvG5X8hmNO8o3ePjKbMEXUoGxXBk4uwkT2UMzHuNj2tDiqbVTQkCYqiBhhSsPLWCMcDmyx+17ZMOUOwLW/+LQQZyJszQFKZJLXY1DwcfXYEuST9G+yAwo2VOs2s+5uBltqH9cu7SyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769057844; c=relaxed/simple;
	bh=DgvICJKgWiisoMClD8Fuzbc/Hq5h1k+9PBUaIpBVkLE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m3JJwUL2T4cse5Mqd9J5eHJiAN0aAeOu2FK1+UJcnSNpJhwFXAjIhoMinVdVjuReXSFu4eX0zcXVV66QBPrvBkqNJpWF0HUSox7dtNJJEGXypY9UZgwZ3Q7HvfKf8egxwTW0B4imZ9qairMsgM98B3tj08W+BsEGiIu96p7YnTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDJQcbO6; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-6493c3adfe4so796299d50.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 20:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769057841; x=1769662641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9r7HPah9wMoZjdjeKZ6qMjpYirclKPYqk3rD7FbTy5s=;
        b=LDJQcbO6xFJlk3gn8tFY+9tA0dT/CZ3lBRJlagrhDE2wWM6VnLrMB4IA0BOo3vTg1F
         hccFI/79zGClaS/nq96iXpr7+lEkZjaXMuw7ab03jFI6tcsxV7zS7ZDn+zQZFvphKpYM
         LhkjeQhJngXFQ+B/77KYgXlZCxrZNCfLHn+/Ug0VGHx7LYGvUheCFDsn5nHD84HqHB0E
         P/3/uCoJyMk9aYRoXb6sCbbWwejhy5058j9dmWoSqA3Ots/yZVjxGhuocblpvqwQEnoX
         dgDHYT8wSpaz4Xc91SASTvgtNNlNrbCY48mfr6AwXMvNgERIisG9Po5X+SlSKq/Febn5
         a5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769057841; x=1769662641;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9r7HPah9wMoZjdjeKZ6qMjpYirclKPYqk3rD7FbTy5s=;
        b=n7TvTKOeT15if6pniWLwN9ThRgaktzSq/AArSlS10ROv0AK8sxw2n90FUYNQqOUuMq
         CnUZofw9KFmjF0i06ypu4rTnTPa/oIOMy2sArvElsnj3i8vJQ/veEOr2pnXvMq6bWnqK
         OeS1Q1v5LKpSBgOXF7Mha9l/0avWpBltdbGuS1fSsilj2RRIWytOAX0Cf42+eERNMgmK
         nWiWK9+KwUqAmoz13RCwRG5hgiXjpraZdTqB+1xpsrRd3dzVFjiAKARTbaUlOHLdBovj
         ynnVWnWpHasY4syXug1rK7YZb26nGPxziqR0a0/gNy/i65saeFuF4cF/cZbXN8VxV5vI
         bQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP63vBLHOmKvaGdWUsThhHIKz0FkbS/vvrzW0fobpOhPGDo7pJCPWLD+UO96cZYs/0mTMmNv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysxAt0T1OAKZz3/oyVWIuBFL120vYxuMpu6sbk/oTsJr+0k+IV
	OHJHPz1AR4BJTYnedTiJ226A/Kpi0nEcZw3Sed5RX9DT2SatV0XxjiR1/gxfW7DmF8r5SwjSAts
	jjqLqubkpBSliKw==
X-Received: from yxpq18.prod.google.com ([2002:a53:e8d2:0:b0:63f:2d9a:64fe])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1c07:b0:649:4e26:bf40 with SMTP id 956f58d0204a3-6494e26c3b4mr2073288d50.25.1769057841373;
 Wed, 21 Jan 2026 20:57:21 -0800 (PST)
Date: Thu, 22 Jan 2026 04:57:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122045720.1221017-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: few critical helpers are inlined again
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252209-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E35C61E07
X-Rspamd-Action: no action

Recent devmem additions increased stack depth. Some helpers
that were inlined in the past are now out-of-line.

Eric Dumazet (4):
  net: always inline skb_frag_unref() and __skb_frag_unref()
  gro: change the BUG_ON() in gro_pull_from_frag0()
  net: inline net_is_devmem_iov()
  net: inline get_netmem() and put_netmem()

 include/linux/skbuff_ref.h | 10 +++++-----
 include/net/netmem.h       | 32 ++++++++++++++++++++++++++++++--
 net/core/devmem.c          |  5 -----
 net/core/devmem.h          |  7 +------
 net/core/gro.c             |  2 +-
 net/core/skbuff.c          | 31 ++++++++++---------------------
 6 files changed, 47 insertions(+), 40 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


