Return-Path: <netdev+bounces-70157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A966284DE3B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4501F216D2
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0D56A8DD;
	Thu,  8 Feb 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9eeIUG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B36D1AE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387912; cv=none; b=pKW97vbWSMJ0EZJ/beSF04+thyr/ODWwHbmKkX9ItjRw7EU9XdARnJbebYMwK+bs4me7CSWEK8hDTgCGGlcoZme73+fKqQLKHv8ccQh3sHvrBX1ZPQOl/7jFZN5JnVd+MMj42XomQi+4F3tWfbfLxjcvcAhH/2St+7OVRQJ/zuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387912; c=relaxed/simple;
	bh=UZkesqE3Z+fphwdpGKkcZ7Dbx7DxSuZE/LQC7ct2Opk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OCXAj2mKa8yssuL3aZdb6ybqKbEI/9QAg0lObUJDcHf2fytIw13w+MyW1p/zJkS5R3HNcgwbG5275WZp0xJQjV+YbOkgTxEeDsgdeNaHsz/5MYvLngVwYV55ciVQ9nmfl8IDB5s1I/XVifaGKwAlabZEZ9tdUJ0BQPvTyJUWpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9eeIUG7; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2224065276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 02:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707387910; x=1707992710; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OT6I3LG46q3v0s6Ue0UOjiNgxiLfN7T4q8q71xmtnnk=;
        b=f9eeIUG7tAY1R7AfQCxsQbdVGNfgZjUpOrua8RPRMsomZsC4rcq83qM1fW35ZJk2bV
         Fq87zfao0cWvCg7sPeg1iGHtFtgjktQnBXQMhISvuHb2fZa91rA4+kDT7xdzUIFzKpKx
         ROEJG3Uj+pW1CYAhzi8eDf/8muL5gPokS70Err0+bpZ6o2EIxy1eSYJjlIvRvPccWQTY
         FUuuT26gZkzAQ2IKm/tBIAovncuGdbopemFdTiU/ZdHZiCYO/SxXOyCXOLCt3fnPVEtA
         0PQxbYoopk6jqLwE2jfnS26M68K+RQGNV2ramlkaekoESq6l9T3uS3ycfGUxaqHFwY/4
         uEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707387910; x=1707992710;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OT6I3LG46q3v0s6Ue0UOjiNgxiLfN7T4q8q71xmtnnk=;
        b=IBRkFExXX/YNINT0OaR7Tq+RRIcKSpW7gT8KLEfBRCgch6h9CvFyukoPe5EyzvffrA
         pstiatDGWD9m8qB0GqGeUq6RIi8c4o+d+HCZJqiBHCDi05ZG/dHiL5xMawDkHmk66XwY
         ONHfGJ9hhWtXma+6PW3dou0ysrGTDU4VT4RWT5iac/tmGslgVyrULetGvZkCWGQxcAWy
         4RcHybVbI261K2Wrw82nVMhMs2hASBinjzF8h74npSBWihbfZxvUBG6+u/5tZlX9V+PG
         dzBnrUsZOwau/Dk9aRuUk1z9rYKjGp+qtRd+1eB9MyEpfluBpBnIteWnXaSAwxSBqzWm
         J7hA==
X-Forwarded-Encrypted: i=1; AJvYcCUpwMlJhdtCL5sT8xqzYgE1GFJCEl5aQzhwCWKjIyir04cpXCtAAn9uW8Mapt+A6V3H065xdztGJCqKIeIbu6GNRj4SMq9X
X-Gm-Message-State: AOJu0YwP6/bLgeoVO8qsodslcUqB/FO0AavosBET+H5OBJwbBdwqAPWa
	IYvv2Yn64QJp9eGc4o/CLb41ebDsd5YmCKtvMc2v4mLOaMN0Bcnha1netT42n5Zmx87igtTMtUm
	1FX9Ohu2JJA==
X-Google-Smtp-Source: AGHT+IGt25fdard+2VoXZ353IDGZ5RQmMmrZLO7u2jV7rEJ90HNNE0mjPt0NdJJg0mniR7Xvi1SYTsix2sKdbg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118f:b0:dc6:c623:ce6f with SMTP
 id m15-20020a056902118f00b00dc6c623ce6fmr266132ybu.13.1707387910252; Thu, 08
 Feb 2024 02:25:10 -0800 (PST)
Date: Thu,  8 Feb 2024 10:25:06 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208102508.262907-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net/sched: act_api: speed up netns dismantles
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Adopt the new exit_batch_rtnl() method to avoid extra
rtnl_lock()//rtnl_unlock() pairs.

Eric Dumazet (2):
  net/sched: act_api: uninline tc_action_net_init() and
    tc_action_net_exit()
  net/sched: act_api: use exit_batch_rtnl() method

 include/net/act_api.h      | 34 +++-------------------------------
 net/sched/act_api.c        | 35 ++++++++++++++++++++++++++++++++---
 net/sched/act_bpf.c        |  7 ++++---
 net/sched/act_connmark.c   |  7 ++++---
 net/sched/act_csum.c       |  7 ++++---
 net/sched/act_ct.c         |  7 ++++---
 net/sched/act_ctinfo.c     |  7 ++++---
 net/sched/act_gact.c       |  7 ++++---
 net/sched/act_gate.c       |  7 ++++---
 net/sched/act_ife.c        |  7 ++++---
 net/sched/act_mirred.c     |  7 ++++---
 net/sched/act_mpls.c       |  7 ++++---
 net/sched/act_nat.c        |  7 ++++---
 net/sched/act_pedit.c      |  7 ++++---
 net/sched/act_police.c     |  7 ++++---
 net/sched/act_sample.c     |  7 ++++---
 net/sched/act_simple.c     |  7 ++++---
 net/sched/act_skbedit.c    |  7 ++++---
 net/sched/act_skbmod.c     |  7 ++++---
 net/sched/act_tunnel_key.c |  7 ++++---
 net/sched/act_vlan.c       |  7 ++++---
 21 files changed, 111 insertions(+), 91 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


