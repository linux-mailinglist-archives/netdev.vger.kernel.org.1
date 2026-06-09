Return-Path: <netdev+bounces-296966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S8UYI5/MJ2qz2QIAu9opvQ
	(envelope-from <netdev+bounces-296966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:19:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892E65DABC
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z05p4Bkq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296966-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296966-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 048A830B76DE
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD8B3E9C11;
	Tue,  9 Jun 2026 08:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC693E7BC7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992681; cv=none; b=eUNwVCUbTXt5BxXl8HOPBrMjQ3Y9w5saji71zxxdzM3XRcFI9wusSTF9SUqB0zowR/HOWCPIJqLl7VFO3YYaQ3AFAaI7yRL0vAlUGQn/bgPHPfJsIlFsgeub6QigNZFAFeMsotVGB1B7OkXbHUZVDioTDRndXAwuVZmz5AZjmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992681; c=relaxed/simple;
	bh=nDAEblNECeLYOzQXtYUbTnrNGNppaHCB957MlN8Dj9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOZZbtD7AiidLbCV2MwFeP3/ShEtyoqFILXRncBkfQ+evu3g4u51m6gmBgt6I/VnZh7qXaHvYCJHTzghjfSswHd30ooKnrc8y8CXCe3w2rCrgyEv8Gh/O4bJ6dRZKdl34OZfBV+bmuVunbMrwEVXzsFyk95uv/7zlB5KblWu4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z05p4Bkq; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bf2247e38eso54099565ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780992679; x=1781597479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmy57QBAaJOTaVawJbwu4x8hsJik0XMjMAkufYZP+5k=;
        b=Z05p4BkqLDbXPjQX8WDZwizk7mrHhchQ+2uzB4qFXKvO7nIocS45kldxiK8T4IdBP7
         zD2L9Mr6edR0qExh3lDo+8KWc32JC6KgfDt/KvUZZWtHBzompcY5RD/CjexCnq49EKu7
         SiNrloBsaFSd+fpCh2bH8Uh/UfvCE63VcwWgP8QI2fZkXC48lc8ntvkhq7JjLZwlK8gh
         rqwvWkAyu4m5ryTMAxbbiIrkCGBijgMF2gC4iSSXltfvCy31K9sCloMpe+NkcgL/q4LT
         jEnoiQ1qIs2IQ5/BdgdVc9ZVGS5gv4OWjQpE2zqLrlQuXK2IPQ8mwzaal5sywB+PsC+w
         +NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992679; x=1781597479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bmy57QBAaJOTaVawJbwu4x8hsJik0XMjMAkufYZP+5k=;
        b=H5c8gqKjn/COSxl6L3Cs19xhy//43HInqOaeqKZphj1ypM+98fouLNRJGzAPxZDLcR
         e55fDW3rZP0IrBWdSEt+/Qalr1lrdSmL96ih5NAAN7+qnN28qfg4HqdjIIgav2P+wJAH
         rnRHR3KR5WBifzozCGbJjl6hjxPJLqCuiOCtdAKioz0inO7mRWkIUBTfSJVrN2FzLj5O
         S+la7sQs3YMXyPmD6fnfoCXqsmkDTtBJctd7Ras6aSVFSnzfu00eeh6gC7P2me9oQlP3
         dNYO5cK0q6D/XBOV/vUtG72ftt2p3/8RiQMVLC7l99XbqutmRWlEicjQzJS9BKSiUNCZ
         svlw==
X-Forwarded-Encrypted: i=1; AFNElJ/QwhpUTAC8+2T7ikxnD8+YuDB+lt91vXlRakPl8LaAU0dUJEYmD/1nfu6hiCx0CwAaBZYpkZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEQdJ1YJDkmYo5fa6ajkhpr5SCJTzUog0zpBGyTSXYPZ2o6PD
	dt0TJ0DF8IQqLz3ICinQlB13oUBbnCDtNJVhdhb+fQz62irhlrQ72DCu
X-Gm-Gg: Acq92OHYesf0wtxlFGsUNDhq3hW/Ro4ylnpXQ4tIsqMt0750YRfOj/V0lonCGUmSgYX
	hX+oLc/TfCu/5y0e5ZpYlBcvYBt3nArlFlThxBNE20dD07YUQaD8gXyxe0TlplGhUUNMCkWzrXW
	dfROcoUzo5BVV4XuYJ0F+KrOgO/XVkSFITgd8J/yhzJR3WDgJKhuBZkveVMTFziwHqQF7h3baml
	Z9m3At9v8nnH+GbK0iZ+UuNfw9jPucRoZwQrPf5WYcRkpWKFXquHm3YEtd4j2f5sWs+xIXKs0Sk
	nsQTNeTDvJjHE6SQdaZXHH/EqIvxM/i0eHJ+xQyASwxxYMtLGV8AybrO6ZWRCKL5PhmhiQyuMWm
	2mCiUdJFklKzPWLlHuOPbQWw6V17yyjjE008BHgTUGEfk/BkUNAkoCXaEj5mAzLl8SXJ85tnQqp
	hqkAax6VltBlFrOt9ViY0YqdFwqSO1kYXPv1tdKvwMBVV8GraWq4M=
X-Received: by 2002:a17:902:f70a:b0:2c1:42d2:40a with SMTP id d9443c01a7336-2c1e810fff2mr253819285ad.9.1780992679264;
        Tue, 09 Jun 2026 01:11:19 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:2853:d025:c3b5:3342])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm263000845ad.65.2026.06.09.01.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:11:17 -0700 (PDT)
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/2] ipv6: mcast: annotate data races in /proc/net/igmp6
Date: Tue,  9 Jun 2026 17:11:11 +0900
Message-ID: <20260609081113.7613-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-296966-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sigefriedhyy@gmail.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2892E65DABC

/proc/net/igmp6 walks IPv6 multicast memberships under RCU without
holding idev->mc_lock, taking a lockless snapshot of two fields that
writers update under the lock: mca_flags and mca_work.timer.expires.

Patch 1 adds WRITE_ONCE() to all mca_flags update sites and READ_ONCE()
to the procfs reader.  Patch 2 does the same for the timer.expires read
in the procfs path.

Changes in v2:
- patch 2: read mca_flags before timer.expires to match write-side
  ordering and avoid printing a garbage timer value.

Yuyang Huang (2):
  ipv6: mcast: annotate data-races around mca_flags
  ipv6: mcast: annotate igmp6 timer expiry race

 net/ipv6/mcast.c | 55 ++++++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 21 deletions(-)

-- 
2.43.0


