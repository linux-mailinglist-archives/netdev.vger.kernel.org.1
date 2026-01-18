Return-Path: <netdev+bounces-250807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A810D392FA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAF0B30031AC
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52D8273F9;
	Sun, 18 Jan 2026 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VK/8gfYU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BD50095E
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716958; cv=none; b=rqVEBul9o6UgpkaubIK5TIr3GTVXAJsIpNEZuXMVky7bCLQfUbjr5gQMOnNEhwFQ1eeZZH5+XsJIv0zbxQMp0FqHQpji6HQ3J6MICgqq9IBbjAluYEPxxbOVyC2Gv4nAfRUuPK1SRP/g/qT3J5zsFVd4EesR3C+Lx5GwbyzP01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716958; c=relaxed/simple;
	bh=QSyuon2B4/TAdoqeNEpPbaS1E/l+1/MC1WQZIeO5sKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ehmOxYRI3iPrM1iOziDiK2bf4+XSEkPY5LOpmt2/VBmi7YBmfS7aL450MqsGYK5Rr/bT/fXXZMJPqiEmWq+EjKMccUTURqVu2IgZ9mJLlxXEZeTxGuJN/YvT0dRD8sgnQPg7FsAOiNvCCcS/H4gMiWkjuVOJa+F+31psMTfkqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VK/8gfYU; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso7385049eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716956; x=1769321756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1X1/qIhWFaeUe6JclpO6lKlk3N1A2CehLNh8m3d0BM=;
        b=VK/8gfYUd6vZeWBheI9jY1Bx+hh6BC9chO1dT4leawVpJVGAJhmmVKjvLdmRUEuMxS
         rDLRB8SjSBszqlbPXL7bSqI77eVubW9rqPdt8o3A9m2Dp6zROUyiKVmubMsK0f+P53Wu
         /4au06+EHtSsRcDmE5gzkkzKN89HshQy7WchWsds0hxsTwaEA7QJ6325UBhPkYCE1Qcr
         Dt8RtbUCfrBkJTOQP4pNEAtCxDPLRiksDvDRUZQTNboBijxqInhTkK9WcIpXjwWdxZmb
         WUhdcHoL20xgfk8Yghey/bSD0sNCFEBPJseNh0LGdLshV3+wRSScN9LZNhL1YWq5K3Gu
         0T5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716956; x=1769321756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1X1/qIhWFaeUe6JclpO6lKlk3N1A2CehLNh8m3d0BM=;
        b=Juwe6H8XDRnuQBYUXf6mA18RWfoZBaYer+1VcNQrBpFOewddjpRn4NRrAQwJdvz287
         4Ig52bpA3o6tMdeAAEELWCCpOeKAKq/qb9WLPm9jhZBUKrqBP6F+mw2OWTkl5IhGRdgb
         zoUjKCangs26XlgtEMapWDfuEM4q5wi0IdhUZ9HMLemNbd4JshOn49citdWoYUgtZg0X
         Q+NnNIDIMg9tiQYnwdV9Jb07CCyrKHpKQ1nzZekRkAJHXJdjdkZZzjLlalptHOwovAYz
         zuxHolnfhufaIjpayaUBWwr2LsJ0QFOz78BnQmktEMUHfRFU/8Rn5eR4jXyGmWPncsl7
         fvmg==
X-Gm-Message-State: AOJu0Yw7JoJa8pQHqvK81PD+oJJj2i27YH6chujdTw13ZsHJloTjbQQX
	misj0YYfglOluApVPoZlcRu/CoxZEsJyK1oW6zhaUYIgQxarrABB4CHOVBZUIQ==
X-Gm-Gg: AY/fxX7CJb95MAplP8GuK3T8NewqjGwi4oQqPFgcMe29PR2ipUPjhUzzL+Wr1nrqrUC
	e3FwJiXtJYpjq5Vhsm69LJXBzCo8ddjGNX8sph25yKWRyXNTZFFWkWq7L/B0XkSSto1vS0oLYut
	GQil7lsU1P63MDKnlNH9d4QfzqwPODLWRdiwAJXnNcfzAdrElVuAC8v2op9VqwwRK+huQy7l/NL
	koxO0Yshc84BRbOhLlwY6rd9ooSKRvrb9oiZv9rJ1J1b3YSGi3EDrHvLMuFEds2OioLGZdfBo9M
	hOekkpTV4oC5WlDGHvIqyNAyAdtwLyThKy5jcIsVLokgzXu7KRQuozX/314Di66Ik8tD5ob46tE
	Jvvf+quhQoo+FrP3Vi15WmrPVGpLc7Tz+wkrDWmAKQiHBzWvrGzeqvaKnq0MjlVRWFLZspcdcCZ
	lsdojVF255ZO54NEhpxK7ra+Ia78Y=
X-Received: by 2002:a05:7301:1286:b0:2ae:5dc2:3b08 with SMTP id 5a478bee46e88-2b6b402fff5mr6714288eec.18.1768716955560;
        Sat, 17 Jan 2026 22:15:55 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:15:54 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent infinite loops
Date: Sat, 17 Jan 2026 22:15:06 -0800
Message-Id: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset fixes the infinite loops due to duplication in netem, the
real root cause of this problem is enqueuing to the root qdisc, which is
now changed to enqueuing to the same qdisc. This is more reasonable,
more intuitive from users' perspective, less error-prone and more elegant
from kernel developers' perspective.

Please see more details in patch 4/9 which contains two pages of detailed
explanation including why it is safe and better.

This reverts the offending commits from William which clearly broke
mq+netem use cases, as reported by two users.

All the TC test cases pass with this patchset.

---
v8: Fixed test 7c3b

v7: Fixed a typo in subject
    Fixed a missing qdisc_tree_reduce_backlog()
    Added a new selftest for backlog validation

v6: Dropped the init_user_ns check patch
    Reordered the qfq patch
    Rebased to the latest -net branch

v5: Reverted the offending commits
    Added a init_user_ns check (4/9)
    Rebased to the latest -net branch

v4: Added a fix for qfq qdisc (2/6)
    Updated 1/6 patch description
    Added a patch to update the enqueue reentrant behaviour tests

v3: Fixed the root cause of enqueuing to root
    Switched back to netem_skb_cb safely
    Added two more test cases

v2: Fixed a typo
    Improved tdc selftest to check sent bytes

Cong Wang (9):
  net_sched: Check the return value of qfq_choose_next_agg()
  Revert "net/sched: Restrict conditions for adding duplicating netems
    to qdisc tree"
  Revert "selftests/tc-testing: Add tests for restrictions on netem
    duplication"
  net_sched: Implement the right netem duplication behavior
  selftests/tc-testing: Add a nested netem duplicate test
  selftests/tc-testing: Add a test case for prio with netem duplicate
  selftests/tc-testing: Add a test case for mq with netem duplicate
  selftests/tc-testing: Update test cases with netem duplicate
  selftests/tc-testing: Add a test case for HTB with netem

 net/sched/sch_netem.c                         |  67 +++-----
 net/sched/sch_qfq.c                           |   2 +
 .../tc-testing/tc-tests/infra/qdiscs.json     | 144 ++++++++++++++----
 .../tc-testing/tc-tests/qdiscs/netem.json     |  90 +++--------
 4 files changed, 153 insertions(+), 150 deletions(-)

-- 
2.34.1


