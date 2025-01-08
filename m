Return-Path: <netdev+bounces-156326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE0DA061B5
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B5164916
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D2F1FECA9;
	Wed,  8 Jan 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fOIi0K9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439521F9439
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353379; cv=none; b=LGUY1dmzWOu4joz4z1Rm7H6ghJYlb9cay7SN8aj6an9SHjDP9cu/4XxcyViOitfkqmDT5J5YRSg3CglPQA345BkUZHg7EPDathXehZhpxm5Yln+ifNEMJXgD73DgAJcKxhpaTgEw2WBDc0zIN1LKjoBaxF9vvOC7Dlp+IbgasJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353379; c=relaxed/simple;
	bh=6n44699VVbYV0qBnMkEhPfhFZoWPHccurZo+6+zTIg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kR2amLhX86IJJKx0dmm1c+eJyRVuuZ03lbakn6eqgMFEyG+oISGWc4RyPLGiXThm7S9uXLK/MTa9pSrrp51kyeTxh/nX41q1HPQMNSvEp/8gEZONiYzmke2JRE5bWtNlxIsaf/xLZAX+3/hIFnueQFQbBHc7d5G7xCEWM9qgUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fOIi0K9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so2558577276.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353377; x=1736958177; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n/iGFALKgh9mDkprAwrTYG1HYz+n5Zu8MWytqSV8wIU=;
        b=0fOIi0K9otPlj3ouk4QVbbKmFyN7ZL7A7PvySu+AanY4FH6kcZ/0Guv3g1QvERLv1F
         2KYnATOGH3eqzmqqj5FDq6a+GL8psUXngUl+ZrktelLlmoxecTvEtjns6AQPGxu6Da0g
         Xr2lZZilI+XRjSNqT+wiuzB3rkq3mlJtYXwkYJtPzxgjS8SeG6mKRzx8Ea7Xv1nN+nSk
         mgUf86d1/J1xJZDRA8YBn8nefrtTb9bWDZhWI/pXpXOqIq1mavMS/8Ij0a9j97+hF36i
         cTop31jMcU4Q8OstDr37Gy4Hizaw/6FYYtxRiVEHplEGiznVkIla50J6s0wJuwdif73w
         pxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353377; x=1736958177;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/iGFALKgh9mDkprAwrTYG1HYz+n5Zu8MWytqSV8wIU=;
        b=Q5i/wNFSsyM1lrxgUd/ok9ThHohHaLIYjWwAlHTK5oZ7dGb0UxWW0SjzQnftH3hpl5
         qEd1QIk24wbwyomyDjQhh5fNj+AlU1kYB2lcorhcvCJtxIdJK+dd//n4cZgRL1ny7zYi
         RbeX86nU53i7pXcOGuuqneNymXO8OuBAdL5Yhsi6SeogLgJJVUpg/oRLiCkyfGDolU3Y
         Oy+iiF06hUF/OY8WN3UOiY51QzEarNunei2jZLnOtIfgonB9FL5i2H5yWfjrSP4cNFab
         2UE2RMn9fif24Igqt8BzcYqKctNNzcKvkxRj63BXiO36BY9McyZZs6qNM37a6sIwO0L/
         bMYw==
X-Gm-Message-State: AOJu0YzX99AQZ3P/ez0FNGylnV62J4PeEiP4HEUHB3dVa9RnTA1ke7D5
	7vf9SLBAGos9MhHAveJeQG4ipWFmOGGdkBAyWowyrbLes7PT8r03uxLxCp3+H/+BDeokG/Xozr+
	dOqoC4gbqzQ==
X-Google-Smtp-Source: AGHT+IFWY8jQkYCAAyYndJG8i1ljwmSO5EXEsHbOLUBowKdC7BamqGOd4PNEmaPTQZjFKN6Nn0m+xHwe2XJrEw==
X-Received: from ywbfu6.prod.google.com ([2002:a05:690c:3686:b0:6f0:71f:b90c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:6a87:b0:6dd:b8ff:c29c with SMTP id 00721157ae682-6f5204a0600mr59209327b3.17.1736353377239;
 Wed, 08 Jan 2025 08:22:57 -0800 (PST)
Date: Wed,  8 Jan 2025 16:22:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108162255.1306392-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/4] net: reduce RTNL pressure in unregister_netdevice()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

One major source of RTNL contention resides in unregister_netdevice()

Due to RCU protection of various network structures, and
unregister_netdevice() being a synchronous function,
it is calling potentially slow functions while holding RTNL.

I think we can release RTNL in two points, so that three
slow functions are called while RTNL can be used
by other threads.

v2: Only temporarily release RTNL from cleanup_net()
v1: https://lore.kernel.org/netdev/20250107130906.098fc8d6@kernel.org/T/#m398c95f5778e1ff70938e079d3c4c43c050ad2a6

Eric Dumazet (4):
  net: expedite synchronize_net() for cleanup_net()
  net: no longer assume RTNL is held in flush_all_backlogs()
  net: no longer hold RTNL while calling flush_all_backlogs()
  net: reduce RTNL hold duration in unregister_netdevice_many_notify()

 include/net/net_namespace.h |  2 +
 net/core/dev.c              | 78 +++++++++++++++++++++++++++----------
 net/core/net_namespace.c    |  5 +++
 3 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


