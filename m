Return-Path: <netdev+bounces-105227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C20D91034B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62571F22835
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC51ABCC9;
	Thu, 20 Jun 2024 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X5herY9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DC378C9C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718884035; cv=none; b=LjXZ1YTd2/djcneXPMzIui57isLanceQ7Di8JqIxeHvNq4TdqI5PYMfyZ1ZtNATPRcAxWDM5sfWx8/I0DizmlQwpkCNsmAkmSvGYf6h7mWlv+u9ibTjDHo0ASAMWueUMwAW9Dmy9cJ3oP5T29UnoNTsa+ZbZ4WGtdxG2Hxwk3mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718884035; c=relaxed/simple;
	bh=Gd1mjG+I/8URS2d3fK9uNc/2X/dQ0P0vaMk+eQnBkVE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OuUmG/HU8L2BGWDNq8hl2ZjQKs2siTm7B96lULKKt6a+izci+vcvfmaSHKqGJo+W5Xmsj6EOn/bw1G2jlLsalESaKuhBoJy24JRi8L/RvoZNGthG73w8t7WtKvktfxUF5UApFOIaHGk6r6qirceIQVbvoCI9tsLQqWhFM1Upwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X5herY9N; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f4a731ad4so17105017b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718884033; x=1719488833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dYsCdJOUTY9/Ydg6AJl04GdqfjCkrVxhAWelcgv0+hY=;
        b=X5herY9Nlz4ba55GD0Yam4TSLz5i2Q5tYcVSQBeiwh1Ac/j2l3zH5rdPIyqXau8lgy
         Evdq78ke8VHD+n5CveBUmDixcMLDDkSij2m/daUmQXO6DIJf2eGGpfVcTTiqRf/0A3wS
         pNVuIErELYcgE0Sovj7GUiJaz792dFLelOIGMEWl0sDZuiB1W4sST8zv6dsdXq5WvbFB
         Zn4Q++BJqq0MN+3BXon3xRtQZcqCXDtztV93jWHecOrrRe27G7TKfaLyfTrGiiDK43wA
         EpcTH9RN0VISqC3gs9tTbzuBxyWQ+7eL9VNwecCFZ2JlK6q6/yPBc2A/TZs7SaMOxkKX
         /QJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718884033; x=1719488833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dYsCdJOUTY9/Ydg6AJl04GdqfjCkrVxhAWelcgv0+hY=;
        b=GjP/YMkgepivk61Psyixo0UH3eYRjPt/4QuzRVc9oBh7kdLdzGfV0bSpeJBgqL2/Qh
         S6yVpX7CV5uGTExz9yseXLLIecHg4m/XIbaA+zAH5J4LIeCMKr3mTaWRIbChjUvXr/SM
         PLBiG488g86wypli8E+rEhZDRCQdt4UbZabN/YwglEEO/zzAdzanSYcQRR6g56I88fUA
         SXPyS7R/1Pxky5D7GrSoXZk01oAp49O9jeWWOsbAzNednHX0u2Cw0BdTjVWrg+FqtfOg
         ZTnumJUssKUTvckJ1qn2Fr47mEAp86ZAhHmApHybHj8oWTg304rB/kUuR5WD/wz2f52Z
         mLdA==
X-Forwarded-Encrypted: i=1; AJvYcCXlxBqIV/RkzTHGnG2tQYoC4ntY/8NJ4fJLLmtX+XeEJuD1cdjSBNCvzzZ/bNf8/PNaCP7NFjzDn4GqesqoVtw6nGgOaHcI
X-Gm-Message-State: AOJu0YzCvcvfTX89mVBEj7ZIBPtdWMmzGseta1S8hw0rdOexNzNqXfGK
	tP0jodM+Cx02UFW5ERMcXCvEv4/9PnHhsykov1VDl1wBDaE4P0JWOprp0T35jPrcOcHFJnm3Qx1
	KO+Y+t+LLIQ==
X-Google-Smtp-Source: AGHT+IHQwy0FDyyUKsaeZOVkckT1uhtReY9VscSTBaxcZgzv3+l3hJYQANGFsPEKxb17kXZwSAMHbXh7nw9GfQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1202:b0:dfb:168d:c02e with SMTP
 id 3f1490d57ef6-e02be0f4c01mr526815276.3.1718884032981; Thu, 20 Jun 2024
 04:47:12 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:47:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240620114711.777046-1-edumazet@google.com>
Subject: [PATCH net-next 0/6] net: ethtool: reduce RTNL pressure in dev_ethtool()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ziwei Xiao <ziweixiao@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is inspired by Jakub feedback for one gve patch :

https://lore.kernel.org/lkml/20240614192721.02700256@kernel.org/

Refactor dev_ethtool() and start to implement parallel operations.

Eric Dumazet (6):
  net: ethtool: grab a netdev reference in dev_ethtool()
  net: ethtool: add dev_ethtool_cap_check()
  net: ethtool: perform pm duties outside of rtnl lock
  net: ethtool: call ethtool_get_one_feature() without RTNL
  net: ethtool: implement lockless ETHTOOL_GFLAGS
  net: ethtool: add the ability to run ethtool_[gs]et_rxnfc() without
    RTNL

 include/linux/ethtool.h |   2 +
 net/core/dev.c          |  10 +--
 net/ethtool/ioctl.c     | 159 ++++++++++++++++++++++++----------------
 3 files changed, 101 insertions(+), 70 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog


