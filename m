Return-Path: <netdev+bounces-150802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5847D9EB95F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C14F18830F7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB384155757;
	Tue, 10 Dec 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lAq/hyaq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388A8634A
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855636; cv=none; b=TtQqloVwn4k0IaZcnANaekl4k0rZCXa7R7cOeBmSqqZIZBoPMT0Dt2glVy6e0LGkfpKN+M/eG+refDGF0jzsnuRTs8hJuPCnaouEEtozXoECbubEVqUO5NMd/Ti8KIuv1PezP4KPNbcldqc8iPf37xMSIma0T4ytK3SSvWGf5gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855636; c=relaxed/simple;
	bh=AoqAgdMr2pLEnWbPhJNYMeRCXZQFVjrR2Q3QTfIAh+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=W8xx7qd5BBGMNqyLLDU465/76BoM0esOytzxftJAnRcwnG3Uui9XnF3Xb1wm1PBztR2ziD/hZABDEEOaIInerdFnGYj+r2uVEWYSJ/RJJePK7TVENgoDjIyrRjzogY8TQImTPc32dvRMdip8NpPdq0hDMja4o3eg0LQ/Ef+H65o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lAq/hyaq; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4675c482d6cso47653881cf.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 10:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733855634; x=1734460434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wfQwR8hrRLAZhNoTgiSp+Y5DFUM57JOPWwbP76zFj7I=;
        b=lAq/hyaqwrW5xgp95AZHTDw/zZECapBivDjbpEtP1RVvjFY0AGCs3uJxYWWidI9Dnm
         4yrf4kv8YepIG2ftF9bMIf9rzV9c5QgasRLcvznwIMT7xK4xkKAv2XQ2YzEOJeVNbbcz
         ifsdITAeOH6n0jORhFG0wRmu1RQaatFrAM546kZ2H/5hp74kWTnVQi/2L4l1ebZ63Wbu
         Wfr5rLnSsUWMJbpsrLnDycnK6drrx0uq4NPE/C1SHV0atmZsCOoIbFGSbIn0/iklMELp
         Ej7XA9SHey/hOCjixGu61Bey0OvfrZ7KLue/zwJUGQMWHtVtLW2Tq/OuDyRj+iavUkpu
         bHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855634; x=1734460434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfQwR8hrRLAZhNoTgiSp+Y5DFUM57JOPWwbP76zFj7I=;
        b=Ijd1iVo6S+B66I+E+itTb03foz8tDhihq17FNeVooLj6PWPjRFJndavsY0eISvRdIY
         L8XeXj7yZger8bFBw/eJKlPjOdlCeLS5CXIn0aUdSYapbhXS34o6mKhjWwRizg5eXsIX
         cRuHuw4tckuOBrPL0tOYw+n0ib+MD/oMG62KbXdvrj5aTlIC8t3yJdGmmvMkA6sIaaUA
         9GhJR+OkTDwLkUKJaVu5ul1825A6bc8W5wEkTH62rKc6lOTv/ufYj/0k+Bbwu10gwOqe
         +FJ83FmwjTfNrIQmrxFcynwzMy8A/BkaaS9VedEGX3Fi5pf07Ev84lEUypLMuzxQmaIb
         tK2A==
X-Gm-Message-State: AOJu0Yy5LI14o3cqtLJqqexGSiJwlgBJL1CqDdhmnhbXqodO+RXdICLL
	wWWvE1rxrobMzySu+zY9c4L7MUF8lQB4qS6kMlkXY9XILXm95Ki7ol5mxZuC9IZwhq1aAaTTyMY
	bn9nz8M9jsw==
X-Google-Smtp-Source: AGHT+IFs5yhcyZSgfZIzPWMy/lC/k1kVW4/WrP88MbGJhytReQBk5G+ycqrc+7YuWXW4P4UtDR5cnJfACsVsIA==
X-Received: from qtyf10.prod.google.com ([2002:a05:622a:114a:b0:467:84ce:5e8e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c44:0:b0:467:8783:e48b with SMTP id d75a77b69052e-4678783e63dmr11522311cf.35.1733855634144;
 Tue, 10 Dec 2024 10:33:54 -0800 (PST)
Date: Tue, 10 Dec 2024 18:33:49 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.545.g3c1d2e2a6a-goog
Message-ID: <20241210183352.86530-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] ipv6: mcast: add data-race annotations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

ipv6_chk_mcast_addr() and igmp6_mcf_seq_show() are reading
fields under RCU. Add missing annotations.

Eric Dumazet (3):
  ipv6: mcast: reduce ipv6_chk_mcast_addr() indentation
  ipv6: mcast: annotate data-races around mc->mca_sfcount[MCAST_EXCLUDE]
  ipv6: mcast: annotate data-race around psf->sf_count[MCAST_XXX]

 net/ipv6/mcast.c | 59 ++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


