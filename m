Return-Path: <netdev+bounces-155985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE9A04868
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D3166CF1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB718BC1D;
	Tue,  7 Jan 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fGWEshQN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDD78F4B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271523; cv=none; b=E4BUrq88Tt/+vQ3b3z7JtjpXb4mJrOGpt7m4NRPbzZjKdBHX2hSunhLuOIG97zkhe4z2RWll1ZwIvK0p5vndF7xwcCf8DCu3klyz+EJTGZChWnzlIKoDUlS29PLFD6VDf8w+l4c646CVBCZcSW3rsB1OOSJGlfobBwONSukQpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271523; c=relaxed/simple;
	bh=32oNeG0DT+qcqOv8hW4o+QYcDoTHJs2Ur2W6rI5oPss=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=C9z0r2yDdoDmwt1CXgkFdQiweSI8yq/DpxVKaoNT/6ivQrgiBNHwvaxgmhw/EsE6W3pJhHB64OcRwTBXoPsQXWnvYaRiU0IG2FJPRs5+aeesmGAaRs2LSrqh3z0mDveqZyfpzBHa8B8A3/XiK5wbmIkkQbzRWqfbgRHAP0w1R+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fGWEshQN; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467bb8aad28so173625621cf.1
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736271520; x=1736876320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eGfMdahV8DwezLY1hW+Nv78VZ0XT2aj+UzNGErSVsdg=;
        b=fGWEshQN+Jgw7WZYPk79r31w0IIDi6cG/P3gcV71LU+ySwabTqoKsJbciI6S0xMPHY
         j8ybM+9V5lbi4cR6h4DnNREEJiFebWiyegn9oEoHb5aM23zfdMdHrx0ga6hu8I114+Ik
         LQJ/EGsATp18bApHhZEohT3ACghT/7SG6/GuSNy8Pb9kQbjpAO83To1+3/cz0ONEWXDX
         ezvtmPXBshCjoDOli/MBGrEQ4AU2jODR0YPLqUsUHnG0f5Qs2kIEN5H+DO4P/EvLCJzJ
         o4K+mhKNDspsmqvLCGZJbKGKHSBhTEsKRfCQpR11q+JZ95LiwHxQ/Brn5pMn97RaazlU
         91FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271520; x=1736876320;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGfMdahV8DwezLY1hW+Nv78VZ0XT2aj+UzNGErSVsdg=;
        b=ZQuPTm07j5rHONmIN6IfFEFzX8T+jJCpAHm1aLK1hcOPoYjAp2yVEsKlRMuYTzl+5n
         4zYrVO7lyx+ee0N3nNXd3cYcZY0vjLmuH2mZ6Icaaf2pI2Tuqu1/zqJR6rBGCSxFlSRT
         bIz1PNAucYFbhNApay6oqWrqvUxEUWBxwUJhfnQ2v3t9+ViEJ9vHkVMhwovdTWBpcuN0
         xicDL5+KmeLaiOSyKaH6MYHq6zjZbCeIRl5CGFZOy22LfZMvKUaTYTGnwhJw2iCyRVCF
         mxEiYaWY57pF9JjKEb/BovC6LWAjPeDFcxeF+A2a1pz9WNaF8pwoVS2EUw4T8EIf4q28
         //Ig==
X-Gm-Message-State: AOJu0Yzz6Y9uR/ycTWpiGlWjMG0gRf0hzEBWIjDfzQu97gWBDaI1Al1I
	D0xxn0oeyWVl0RSdi5l1r5nRdy86jjk2sghp0XBM1H6Q5MpR4VboCXaHyc8Av4rs7utmVmvetxY
	w7IIjEfG9Aw==
X-Google-Smtp-Source: AGHT+IGf+hFPlo+MirDDg1X6XrAB7rg1w0/WBZ5fa1zL78JknROxh0PUzff9w+icctyHo43MshEpD0I1fnok1Q==
X-Received: from qtyd5.prod.google.com ([2002:a05:622a:15c5:b0:467:5609:e14b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a09:0:b0:467:73bf:e2ca with SMTP id d75a77b69052e-46a4a9b49f9mr1018347021cf.46.1736271520585;
 Tue, 07 Jan 2025 09:38:40 -0800 (PST)
Date: Tue,  7 Jan 2025 17:38:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107173838.1130187-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net: reduce RTNL pressure in unregister_netdevice()
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

Eric Dumazet (4):
  net: no longer assume RTNL is held in flush_all_backlogs()
  net: no longer hold RTNL while calling flush_all_backlogs()
  net: expedite synchronize_net() for cleanup_net()
  net: reduce RTNL hold duration in unregister_netdevice_many_notify()

 include/net/net_namespace.h |  2 ++
 net/core/dev.c              | 61 +++++++++++++++++++++++++------------
 net/core/net_namespace.c    |  5 +++
 3 files changed, 48 insertions(+), 20 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog


