Return-Path: <netdev+bounces-234095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88779C1CA72
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F89A564255
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B80734F473;
	Wed, 29 Oct 2025 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1BGEFtaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67692FB97A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759229; cv=none; b=cLCka6ieDgCh+62EEYbyIWVe5moyGYD7ouWC7D6IjDaEdkMTM2d/jAvDFoysMwGTvkeaFFQp0XoTRwD3damY01FJR6NykoXavFG3+IC9AM+1QhRZFM8asFI+pfWYzUUfASpmQmjjFNCjXeLbO74nbJA1yp6rhw+hPkkKaseSztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759229; c=relaxed/simple;
	bh=6TyZJzEGWbfZkYSzH+7DPf3VAM4yfoNxsiZ6ppwZBiU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XKi7ekDyTAefFY974dClBU5ljA66ib18hzYglfz8/q9w2Lgy29zYr4CmHJrC042IOURQmPzgl1EAvGgbGwif7TMXHGRx2ZGgkryh+iSs/bb3D8vucnkIDKY3izL+6+RhMENEF4vrfU12ef+fIV3m3e05xneBlmhI8IZM8XeVm9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1BGEFtaA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-26985173d8eso1496605ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759227; x=1762364027; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYU5dxSnTKSDV1Md0U87PMWzt46gpSLSubEjq6KjhbA=;
        b=1BGEFtaAKQD7aoaUBpIWO+NjRjtViljfo7wMSa+kf4Weib7xBTx3Dh89YGk20f6lK7
         dSeliMZPQB7kxFGme3Qjlnulzci9pWMrN4qb/oo72gaomDDTrzS7z9je0WivmiVkKR+j
         H/Z3WVW6eo3wUlbPJKdweo+5ckDcBLnK/ZLrP6gJWbh5uzsimSAcikfpR+Y4ISSkJ7xa
         vpGy9Pqv1diCth52UOerbwMz4hydMaNs5kbQ4OEAy/Luc0d86LKO2XcpOUA+dgTUuowL
         tW+NEXcx0Y/QVePy6jsuK17mlgKryWUK2Rmg94ICCJquRByeu/R+vJtU4Olex1+3rYJO
         taNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759227; x=1762364027;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYU5dxSnTKSDV1Md0U87PMWzt46gpSLSubEjq6KjhbA=;
        b=Bcx12TgVo7mQa4ed9q6eICS3ukf0lXg1ZtLM8HWKWIKgZFek9jDyTRhUJjC0renTQ0
         zUTl0dJxSmET0FjQ4Odncv8xN+U7bSe/BQnpmdFsHuPCRyvt3bZJbvqz4m6YGNqSsQ23
         f5pLws3I11DNLrSa6j3VzhgTc8eMxWJsTmByArghoL1psYotEFeGGdfZ0LzWQfwUfdIN
         pHfen1YyNOZnFTak69UWVfSQW71n9v7dMpAcNgXhpnwD2ueT/kaj0OgtUpqYjVTdM4Vm
         3x8W/YJuoN9yI5OuAKp6ZWne21cu9c9VE7TQDl4IQF5aLOugzHA9f3Q/jvWDDD0McNlu
         iKlw==
X-Forwarded-Encrypted: i=1; AJvYcCXa0RKewBZrhJqFsAbVuZ81gXUkQ7BLfc7I0XHVwEYYtgr0BiIj60MhkNO63vpaZk/J/nG3s90=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHtG7QVHL9vMV6DEGyNKjJeI0GZIgx8oArpPCv5e9as0/GWaW
	4/ZvO0BLgnsXMiTFMd09cT1P9VHmZSqYytpZFsBh5FOdnDsF5MsFDgpqskipL7+PqKtJ5jZ2Bi2
	+2VleyQ==
X-Google-Smtp-Source: AGHT+IEdeEBgZ2PmmjAljcKwmt0iO9x0P8LFxg0whDv2wDTlQ44xfcNOVA6RPFbqTvO3ZABqwlyOyw7t0tE=
X-Received: from pltj3.prod.google.com ([2002:a17:902:76c3:b0:294:8e58:7348])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c402:b0:294:e8a0:382b
 with SMTP id d9443c01a7336-294ee477f04mr784105ad.54.1761759227055; Wed, 29
 Oct 2025 10:33:47 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 00/13] mpls: Remove RTNL dependency.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MPLS uses RTNL

  1) to guarantee the lifetime of struct mpls_nh.nh_dev
  2) to protect net->mpls.platform_label

, but neither actually requires RTNL.

If struct mpls_nh holds a refcnt for nh_dev, we do not need RTNL,
and it can be replaced with a dedicated mutex.

The series removes RTNL from net/mpls/.

Overview:

  Patch 1 is misc cleanup.

  Patch 2 - 9 are prep to drop RTNL for RTM_{NEW,DEL,GET}ROUTE
  handlers.

  Patch 10 & 11 converts mpls_dump_routes() and RTM_GETNETCONF to RCU.

  Patch 12 replaces RTNL with a new per-netns mutex.

  Patch 13 drops RTNL from RTM_{NEW,DEL,GET}ROUTE.


Changes:
  v2:
    * Patch 10 : Removed dup entry of RTM_GETROUTE in
        mpls_rtnl_msg_handlers[] (Guillaume Nault)

  v1: https://lore.kernel.org/netdev/20251028033812.2043964-1-kuniyu@google.com/


Kuniyuki Iwashima (13):
  mpls: Return early in mpls_label_ok().
  mpls: Hold dev refcnt for mpls_nh.
  mpls: Unify return paths in mpls_dev_notify().
  ipv6: Add in6_dev_rcu().
  mpls: Use in6_dev_rcu() and dev_net_rcu() in mpls_forward() and
    mpls_xmit().
  mpls: Add mpls_dev_rcu().
  mpls: Pass net to mpls_dev_get().
  mpls: Add mpls_route_input().
  mpls: Use mpls_route_input() where appropriate.
  mpls: Convert mpls_dump_routes() to RCU.
  mpls: Convert RTM_GETNETCONF to RCU.
  mpls: Protect net->mpls.platform_label with a per-netns mutex.
  mpls: Drop RTNL for RTM_NEWROUTE, RTM_DELROUTE, and RTM_GETROUTE.

 include/net/addrconf.h   |   5 +
 include/net/netns/mpls.h |   1 +
 net/mpls/af_mpls.c       | 321 ++++++++++++++++++++++++---------------
 net/mpls/internal.h      |  19 ++-
 net/mpls/mpls_iptunnel.c |   6 +-
 5 files changed, 224 insertions(+), 128 deletions(-)

-- 
2.51.1.851.g4ebd6896fd-goog


