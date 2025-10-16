Return-Path: <netdev+bounces-229856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C53BE1671
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 06:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CB0D34F4FD
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 04:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0316DC28;
	Thu, 16 Oct 2025 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c9t5lDJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF71C01
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760587324; cv=none; b=HPEB0hA3xW3OfWTpbZqZX75sLA/8LH4F5WINytjvSWoTJ9yfNWfUMq31bKNH6FHfeXr6wdgmJAN5HJcADK/DWeWrhE+N8UrgMj5Dr5sDFOnu4yG1cPRfh4MwO5J8f8h1FoU2lDyeYpD7bkI7mvD6pDa04KOcAYOuRWmKM5Ssd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760587324; c=relaxed/simple;
	bh=/d9sSBFsj3H5KcnkYjBFXu7Pna4DXgOmL6sFUITWcB0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PWYV8wMLHIh5drfKliU0i/pcZ9fjxI3J/CKJGhcZQNRQLEAsu+hoaTVqcRanSCDaFptjdWE+xFb4qmiAp7lFQnG9GY2hs7lxVbLSFxefhHNFSA5OXkdL6Y+L5pitcI/uYR1xFbycIY9es+bibvmd2PSCM/DAtmMaZIML3Q+QY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c9t5lDJm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-26983c4d708so2918195ad.3
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760587322; x=1761192122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7BkGn7F8+gaNF4XWSirxAClhK+XCQFJt1IL3oWqL3i0=;
        b=c9t5lDJmOYltHcouJdnjlIyI+hqhns/UqcIgSR2XR2CEOLQErXDEC5MfAfQcFz9PiQ
         VYG3Okfy+cPKvld675fn/wZRmHlF5+iW/3eLo20f93RpLb9Zdf9VNZc+c2Jd10E3Ruoj
         nkCTUkrWWnhCkrG4Dnyl/NmKmiCRGdRiNFvoHKiggb9I2tOBoVF3jl06FZB2oiRei9G9
         X6AV6//EEKSNqAq2Fet6x+nlw4tQvFTAeXhuZsYT2/wUxOl9Ty87V4OpmrKt/wI/7Jwc
         qyIiHazeMd4vgxu98xH1shun5quwBbJNDznzJbQp2zAao1Xao59WRogjc35jJUdTiq7L
         c6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760587322; x=1761192122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7BkGn7F8+gaNF4XWSirxAClhK+XCQFJt1IL3oWqL3i0=;
        b=Cpef6sFsnk57LcPaAj9IAnLnDzdCL+7ykr5c1SI86zTGc13himPqmq64haUmAOKdq0
         Jhwo1iIhaOXXENYdvLdhvuHSC+iWe90FN6Lm825/i2CO8IQvRTiThYS6IxP7FkZmB+W/
         3I8j1B6zk/g4p9IRhP7L0mYHQ7SCxUgk8Hud4ZXSMieKA+WcN3HO2EDRDe5QCKQd/WbA
         NonG1S9kBbv0atkCcXlrIm1P7qRmQGsEKnqykUij8iJmU/pBTRd+zTzp9e8+wDgQUxet
         b+H6bcQm1aN8/qXPY03hKyrG7u6DEhXe42/YXs7x2NcLPMLtwkCNXct0zpV7tr3AV1HU
         V1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ6BD/8NFwpyRtWFyulMu5aBpAaqqmdrhFmwzySfQ6Dxmun2e7Scwtc43ddt3dsE491A9J73k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh3P3kaKq3NcjiOOw/6dWMsIi9ct8vVWqmh2Plax2ZXrDrh9PH
	0cH/dUU5pA3sn8/aijQBHlkTm/7vVqVvvWkn69nTGMYsFoseC3d8jvHHCLqIiIuIdZ+h7WOJ4rt
	Org6iYw==
X-Google-Smtp-Source: AGHT+IEK9+bW8eekMpYS/+D/hQX9kjqdGramNtl/oRCJ97lFj33Vr7RtEAdRNOvICw7HXAvRUjhl6/0vu/o=
X-Received: from plhw15.prod.google.com ([2002:a17:903:2f4f:b0:266:d686:956a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2a8d:b0:262:661d:eb1d
 with SMTP id d9443c01a7336-290272901e1mr396244075ad.1.1760587321763; Wed, 15
 Oct 2025 21:02:01 -0700 (PDT)
Date: Thu, 16 Oct 2025 04:00:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <20251016040159.3534435-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/4] tcp: Refine TFO client fallback behaviour.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Yuchung Cheng <ycheng@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 & 3 refine weird TFO fallback behaviours that
I found while importing TFO client packetdrill tests from
google/packetdrill on GitHub.

Patch 2 & 4 import packetdrill tests to cover Patch 1 & 3
scenarios respectively.

For the imported tests, these common changes are applied:

  * Add SPDX header
  * Adjust path to default.sh
  * Adjust sysctl w/ set_sysctls.py
  * Use SOCK_NONBLOCK for socket() instead of fcntl()
  * Remove unnecessary delay (e.g. +.17 socket(...), etc)


Kuniyuki Iwashima (4):
  tcp: Make TFO client fallback behaviour consistent.
  selftest: packetdrill: Import TFO sendto tests.
  tcp: Don't acknowledge SYN+ACK payload to TFO fallback client.
  selftest: packetdrill: Import client_synack-data.pkt.

 net/ipv4/tcp_input.c                          |  17 +-
 net/ipv4/tcp_output.c                         |  39 ++---
 ...en_client_nonblocking-sendto-empty-buf.pkt |  45 ++++++
 ...topen_client_nonblocking-sendto-errnos.pkt | 125 +++++++++++++++
 .../tcp_fastopen_client_synack-data.pkt       | 150 ++++++++++++++++++
 5 files changed, 350 insertions(+), 26 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-empty-buf.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_nonblocking-sendto-errnos.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fastopen_client_synack-data.pkt

-- 
2.51.0.788.g6d19910ace-goog


