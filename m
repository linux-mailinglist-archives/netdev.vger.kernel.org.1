Return-Path: <netdev+bounces-157178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F9FA0938C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6353A9F09
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 14:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7354211282;
	Fri, 10 Jan 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D10OmjCs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AD21127E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519599; cv=none; b=SnXw3v9aMfx8F5YTqqQLsAMLP1xif4q+NfkuyCYcdybRr8cFmYPC2jamJGMJwVry8taywNfx0+ndB3RR5AQiMNOuKTQfzdTKbANRJh+LBtvw0kANDiUAI9tlk2jKM8+ln5XpPLNFB4dTxT1L72HrZ8RY5B0fvzm7Cw2tWxnlhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519599; c=relaxed/simple;
	bh=JyF9mHiBtQoL8ibs+cl5XSPnjbiEpq4Keqesxhl1mJo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r/hBJM4Tq38CyuVfMAY2vTwMtsKKjZLxzeN0Egig9AkUpwyQGsdAWCPMC4NPjDrwTit+5+PNwtxagdw5nsUnH/Ve/Sj8RzAyvvlVrItjMv5R4prYccmWM1eqmIg3NlvubzFQuhi+KRvr2ztbv8YJt1U9ufoLcOJux2BCH5I7Y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D10OmjCs; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b9f0bc7123so333753485a.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736519597; x=1737124397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xJs3b/c2tRNEu0ES+lMHyagxl1lYdfrVssJzNuGfIis=;
        b=D10OmjCs05N6xtsJIYof9n+qubu1TmnpiRyjzDTiDVX2MPIrMOfdaKL2TvIdG2mI6I
         XbHc6x94FGYmZXtqdVIdkXGV04BJ0W5syzIGYs1bN3JHapWBrEMsP5cojReACr1ACA+3
         P+51fo1iZiFbGgffLav2t76+LeAxrXWgXSU6jl+VYXefcJYaKOAfi7KeyKx/Ox19P5ft
         o5gbec8sH9UtGRlLCahb/ZLIgR8ADhWzGItx8SChBTjGjoD0WPdN9gpb5CEizHmk3gMg
         QXipkKHPrCQtYhVmKLYA/3ZcomHYcfv1UqqDyhrQeFDyaazXU1E4WOspSb4oYWokU1ko
         FMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519597; x=1737124397;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJs3b/c2tRNEu0ES+lMHyagxl1lYdfrVssJzNuGfIis=;
        b=IMg/QEOt8GbOTqenMHrtGl4hktvzEvrgYQkPrbij9O+LfYcyGHYMCDMhXbEQceNMy3
         5OvxOGGqb0PUaqpQGphiGdGbNfkjwJ+AlaNxyWOkhMbPvkGkTmuyb8/tJWaUXBpba3ND
         wRfsngIKQWbk2mDC3ityWs66rKzVAu+g9Sl11PZkViXzJ1DkIQAd9oaXSEsvW7PGUfC/
         D1g5GrY69U9Wr5cdDpUsXLBS1VkQEiiwAbbxUbApWWtjLG1AqA4ndMeAFZ3JXnja+SmA
         C0ce3w5cYWdNCwwUwlLA3obPqHcUDk2uBS6ZsDOdjTyvGsiP68/fbL5PudT3k2cgOkbM
         LUeA==
X-Gm-Message-State: AOJu0YyQgHjfQOjTsAgDKA9QMXLYPRillQJlUKkiznOMpPUDQfUsNC6Y
	+fQ0rvOwP2JoMj24B2fSl1mOejmHdXbzz3IgYBRUlTJFKbxJnFBHUT5GWDrF9LBUuUi8gALOeEm
	29IsdEOIw8A==
X-Google-Smtp-Source: AGHT+IFR9g6Aqm25KQTj2cZQMlx2C5IEFVWRHi/hn3LJsjEY65NB8qIVlL7b6wx8yDSvqFEbd1j0cTdjP0ljcQ==
X-Received: from qknvw15.prod.google.com ([2002:a05:620a:564f:b0:7bc:f199:7005])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4014:b0:7b6:ce6e:2294 with SMTP id af79cd13be357-7bcd97d7ac1mr1756718085a.56.1736519597001;
 Fri, 10 Jan 2025 06:33:17 -0800 (PST)
Date: Fri, 10 Jan 2025 14:33:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250110143315.571872-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp: add a new PAWS_ACK drop reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Current TCP_RFC7323_PAWS drop reason is too generic and can
cause confusion.

One common source for these drops are ACK packets coming too late.

A prior packet with payload already changed tp->rcv_nxt.

Add TCP_RFC7323_PAWS_ACK new drop reason, and do not
generate a DUPACK for such old ACK.

Eric Dumazet (2):
  tcp: add drop_reason support to tcp_disordered_ack()
  tcp: add TCP_RFC7323_PAWS_ACK drop reason

 include/net/dropreason-core.h |  5 +++
 net/ipv4/tcp_input.c          | 85 +++++++++++++++++++++--------------
 2 files changed, 56 insertions(+), 34 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


