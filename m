Return-Path: <netdev+bounces-250274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F061D26A01
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 18:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B5F030EB8E9
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11E3BFE35;
	Thu, 15 Jan 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ml/xKkfV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96943AE701
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497938; cv=none; b=J+WOK2chhbA0IBwwskFAVhpUmU2rQ2PC7zgU7eGUZfL/xrSylBAIWptJc6nzfXhN9tqlwWPO974aNiMv09xDytZvKqhRjfjB/HAiVqV6MOAd+gzZaQks2C8QLT+XNnqEGtExiqxYyCU60dt95jFTDmbMmr7bm1UFmdlcVbJExHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497938; c=relaxed/simple;
	bh=sdqndQkOw7pkj391Xo/h0K9rm4sWOqDPCE8XGyjfWjU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=U5BNnyDnEi84tjlXPL//VfxWjIX+Js9S8xi9oJikOvj9g+eYk9Ii5ko0U6vrpcSvK5NJhnZBVfFJftoXBHrS/jDbMjWWtnt7aQe2g04KMtIPbDQJY3o4yS3n7pw5K5ZAZ+ovQCZBzcznLjoHvuf1PYmkdNfVlwFw9vBRIBS4I8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ml/xKkfV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-81dd077ca65so893766b3a.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768497936; x=1769102736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8csUjF01ZCz05JfEPNndpxt18GhkXZ2SlIhYo7GPkqk=;
        b=Ml/xKkfVEzJ8mw2Vzt61V6jZBUUmV5gns2/mA/mTz2pV6pmVEVqqi17jX8vNSRgVgi
         kDyg0F/S5yyw24cQZy7Dlm4a3gYxeDbUa2KnZkHma89C2nGs/v01Z4Q5F6fGoVvdIrVv
         ZYOW+kwJr51k32WI5y3y9FyhKVqIHJHftKfZwlvelIOGZkFzyMCPp4N1OSY6AtBkK7rQ
         pQUkvLo8yiWvw9GxAb1sR7EpBtflvVRCN9Io1+43UpAIOShfLnDBK/CVIcxg5+8EDQn1
         7KGVgqes12qb6KCtFEXVNl7UpPAGSrl5enDPeE9A6xIcOXSROe5xUPbfao74K3NW8TLL
         tclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497936; x=1769102736;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8csUjF01ZCz05JfEPNndpxt18GhkXZ2SlIhYo7GPkqk=;
        b=uYA1VOIi40MwUa0VFZyDP8hAveUkg4FuQ38qi3V9KxTtsqi+brns+twuYJWearL2DE
         Fv33B4qV2Bhs1UdD2odcND1Ko7BjucaQxD7q1Bow9aNAcuFfN9Pn9Jc8YW0Im/p67oH+
         V1M/oSgo7AI52s/yQ/f8WSUzlpLEeva2pVE7QQxo3yYGorfF/9UxNpdIGijKHs+bTAa8
         9ly4NlI2MRoWw4/76zp4NaYTeSdqXnq/SlRhSM9qMiOfMrm5oPJy4jb9z+/S3ZVVLo/W
         aAYVr/NHsSyD1xhX2mRZICEL38oNQnd96FstjntUcqZXHDoVAib5oIwyA2xf0eSa0bbP
         RMXg==
X-Forwarded-Encrypted: i=1; AJvYcCWrg2A6KnW3njJdjM+1cy/n9x7KWWEYf4xGHGl61aApkkm2eYVtgghbzzHvKgPvtdDuU3cz5Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnLjUbZhQQOOalSW8UV75nAylIAWs4+JUFDON5QSAxHifAn29H
	zGYMYINPKlloCvnjlg1i6OA9iGmm4rPbhjhmp0muikasIq95z91gt77weWYIIbTjQbMCn/438nr
	DRmQeCw==
X-Received: from pgkz4.prod.google.com ([2002:a63:a44:0:b0:c5e:2c78:a114])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3288:b0:38b:d93f:b467
 with SMTP id adf61e73a8af0-38dfe59d36emr483282637.6.1768497936149; Thu, 15
 Jan 2026 09:25:36 -0800 (PST)
Date: Thu, 15 Jan 2026 17:24:45 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115172533.693652-1-kuniyu@google.com>
Subject: [PATCH v2 net 0/3] fou/gue: Fix skb memleak with inner protocol 0.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot reported memleak for a GUE packet with its inner
protocol number 0.

Patch 1 fixes the issue, and patch 3 fixes the same issue
in FOU.


Changes:
  v2:
    * Add patch 2 for ynl-regen.sh (Jakub)
    * Patch 3
      * Updated ynl spec and regenerated fou_nl.c (Jakub)

  v1: https://lore.kernel.org/netdev/20260112200736.1884171-1-kuniyu@google.com/


Kuniyuki Iwashima (3):
  gue: Fix skb memleak with inner IP protocol 0.
  tools: ynl: Specify --no-line-number in ynl-regen.sh.
  fou: Don't allow 0 for FOU_ATTR_IPPROTO.

 Documentation/netlink/specs/fou.yaml | 2 ++
 net/ipv4/fou_core.c                  | 3 +++
 net/ipv4/fou_nl.c                    | 2 +-
 tools/net/ynl/ynl-regen.sh           | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


