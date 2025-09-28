Return-Path: <netdev+bounces-226978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D579BA6BCF
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 10:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7FAA7A6764
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD50B28D836;
	Sun, 28 Sep 2025 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SDGlqR5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C286329
	for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049378; cv=none; b=K9sj+e3DPUwmo+qji61Pf1gEzzZrz0ok3ETItYFGKxtTFhXRdzQ2ShxCvmmnZrMp2tJhnXzRc+UP0zGsoJ9ae/56HIoUAqQIMsmEKVL5SgswuVxAj1Ipoyg8qZX8w8l2BOQ63jlPov82B3YIJqTZymQm5B9GGm+SAhUkRJm/QSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049378; c=relaxed/simple;
	bh=XOxCMksVgtpz1Ymo74FxVEFZpbqFkadIBTLCXQ5Oh00=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K/5S80h0hRAq+TdP5eKILF7ZmkGURGBWRgbr5BjxZGKMhfxlukeollLwKS0pKb8nkBQ24Dre4ikm+238AUcLn9xQjs/PhKysBYnpPmsEcRN1nenu3nWTtefnSyQZd6j/blMvyXjxkSnqhVgDN6PntfTF4IkO40Z1fsIIWsvTyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SDGlqR5F; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-89021b256a1so4735717241.1
        for <netdev@vger.kernel.org>; Sun, 28 Sep 2025 01:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759049376; x=1759654176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b9w9yUfejgSPNrlzIy5UVuq3ZMK19SzOHRCxe6sz9Rw=;
        b=SDGlqR5FdJhB/31b3RtUj0W234E4svwqAMXMG47u8zsZZqW2czo9mGWz2HlMbNc2TD
         6pwi9riBnOwkOWC8YVKdK71NP7bCTDlNAa8eh0ouyLPJGn2WqYsNZybqh2TAOOhp9ewH
         F2u4uCP9W5b1FPb9X+xwjqR1osTEySV7ejQM2NFPr2hVwO4j2vI1KclUvuEWCrxgTjXP
         upv+G313M0dvy0UX6uYcYGQU/hEP8/7fyqUhEeN7C0QcQmLaZ0a+0qwZI6+IVFsQwwjI
         qZnmJoFD4+IOZa3HIgyeK/Sm2uUB3J09WS1iGQJkDLcrgC/XrrrqFH9Ri0PuzsgYrRjL
         3mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759049376; x=1759654176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9w9yUfejgSPNrlzIy5UVuq3ZMK19SzOHRCxe6sz9Rw=;
        b=UEu0jdEGtRWIcQXlBRC+xmdaZHrOu1E62uoDWQSukWvvznt7QZfTEPtODpFk12PF08
         HrJHYce2Wb5a82Js2p8V64huB7mLK+ldnWBqnhyAoeAodlBnC/MNfDi3qIhVwKOSNL0u
         PMdtbW1KOecKlJR7P+sxb1h7SBycn8I3CiOyWWP9cqMmqnFhRE3cqfEwZWwBCCFgSLfx
         5qqZi3VDLwTkRrgUNCvSB6iNiyaaipc2NRpsfu/YetX68TjFLZTHnJa8NfvxDRjghpkm
         piAucfihmJr23uvkE8Ot5nKLRhvzy9TD+d313+/GhQcPWF98YNjNXlNXlgcMvBUUHCAs
         R88A==
X-Forwarded-Encrypted: i=1; AJvYcCV5KplrUe325pZ7cOm0UMCddMGtdXEXHKo2R59Y1gygp44hJP973pcTKZBqnmFrx3wn0Ad6koY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzELiNSRWwDyBjhNhaMCGl7zYoDRd0lhDyApVsAik9vwcSFAr7F
	eKZS76wBOfBoVHDAPCYbjyUbDsjYp6MiiPEYBGr/vpRlrXwaX5rs9eeA6SK2f+CdeV7iH0uemeN
	00G+U2JeGnWV5oA==
X-Google-Smtp-Source: AGHT+IF0FfN2CJDCzlg6LKQJOSpiLvAircph3PosyaE8a69hbYEo8McQWujt9lI8udTuCfgPUlm86XBY2jgGFA==
X-Received: from vsvo35.prod.google.com ([2002:a05:6102:3fa3:b0:523:1545:8945])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:2907:b0:523:d0d7:b963 with SMTP id ada2fe7eead31-5accfbb9a41mr2901605137.22.1759049376115;
 Sun, 28 Sep 2025 01:49:36 -0700 (PDT)
Date: Sun, 28 Sep 2025 08:49:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250928084934.3266948-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/3] net: lockless skb_attempt_defer_free()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Platforms with many cpus and relatively slow inter connect show
a significant spinlock contention in skb_attempt_defer_free().

This series refactors this infrastructure to be NUMA aware,
and lockless.

Tested on various platforms, including AMD Zen 2/3/4
and Intel Granite Rapids, showing significant cost reductions
under network stress (more than 20 Mpps).

Eric Dumazet (3):
  net: make softnet_data.defer_count an atomic
  net: use llist for sd->defer_list
  net: add NUMA awareness to skb_attempt_defer_free()

 include/linux/netdevice.h |  6 +-----
 include/net/hotdata.h     |  7 +++++++
 net/core/dev.c            | 41 ++++++++++++++++++++++-----------------
 net/core/dev.h            |  2 +-
 net/core/skbuff.c         | 24 +++++++++++------------
 5 files changed, 43 insertions(+), 37 deletions(-)

-- 
2.51.0.536.g15c5d4f767-goog


