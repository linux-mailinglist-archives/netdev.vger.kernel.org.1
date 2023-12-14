Return-Path: <netdev+bounces-57631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC51813AC1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56376B219BD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97A69795;
	Thu, 14 Dec 2023 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y7Z1zQKi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1076469792
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbcec98047bso719295276.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 11:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702582181; x=1703186981; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qbpGK3WBNGqo9BEogxuYw0NknVjEaYES4Vp4+XaaBKg=;
        b=Y7Z1zQKi/k8cBEJkfss2/CeGyZF9mZxccjVklx8JKt7CXn1xNMOInwcX67DipMWKLl
         TF7KRhtQFA24YU/I4ShKu9M3IFKFxEc6feY9H0V0tP4lIBnlVFyqt0ny+O7kT7SVlUmN
         1ahsmOw9ZOWvIVaT6STrZXbqZ8Lztc8b/LtXy8kllnwLyagIPm/+b+hubUNcYSeboErL
         5A3PLjrKonjLsqIOuGT/Y5Sb9gudiSJm/RWmzLs6QfE6BzcGDlaTNHZQcTqY13LhXfGE
         1dCfg1entyfDE1MpkrbA/Bg9GBcBs0/uPtQghEmT2HerXJzisllHMWYRrfWqnNDM4qvF
         jyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702582181; x=1703186981;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbpGK3WBNGqo9BEogxuYw0NknVjEaYES4Vp4+XaaBKg=;
        b=HMKTy09d3oAg2iME3vOA0qx0PhuTAQ1V4vTxhdZMEychoNYE1pxKSCmzFE1M/PwbZf
         3dhaqsiuy8KLE7AntunOKGILiNoYCamPtTrJ69AnFY3eFMK5WDXdTEPIezSez+Z/KDnU
         DO1YRinEs8u0HvuvHUa8O/2pc8TCuvsHcyRkoZzRf/1yothp/huLfhxkvXxuGXvBo4+r
         ff1G5lsB43C+NAztam8brXY+7JPBex1AaguiIpJmHRHw/PLtXRbzyvEB2tzADYGmWSHQ
         /vJslw8Ky0nX6L+OxFU+t8weqo6Jf3oYIo1CuuSSoqtSOoQ21IlCzWyPUbMdjuZijcfC
         8+lA==
X-Gm-Message-State: AOJu0Yx1lYnShHWmeauMSNC7RTtT33Gtn60SePXIbmu7Hq6xu3bqFCRd
	XSdD+yEMI1oZDWTJtnxZ7njXWBSgatfkCg==
X-Google-Smtp-Source: AGHT+IEzsHZdJYkxDvTTN9wHnKaMR/Mpz57A4K3wr4oraZ6oLNxiZESQo0GbcGNS0PBLuZG2jNIKJraNgu856g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:98a:b0:5e4:35c2:fd37 with SMTP
 id ce10-20020a05690c098a00b005e435c2fd37mr1954ywb.6.1702582180944; Thu, 14
 Dec 2023 11:29:40 -0800 (PST)
Date: Thu, 14 Dec 2023 19:29:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214192939.1962891-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] tcp/dccp: refine source port selection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series leverages IP_LOCAL_PORT_RANGE option
to no longer favor even source port selection at connect() time.

This should lower time taken by connect() for hosts having
many active connections to the same destination.

Eric Dumazet (2):
  inet: returns a bool from inet_sk_get_local_port_range()
  tcp/dccp: change source port selection at connect() time

 include/net/ip.h                |  2 +-
 net/ipv4/inet_connection_sock.c | 21 ++++++++++++++++-----
 net/ipv4/inet_hashtables.c      | 27 ++++++++++++++++-----------
 3 files changed, 33 insertions(+), 17 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


