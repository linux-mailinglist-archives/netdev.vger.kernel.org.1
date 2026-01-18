Return-Path: <netdev+bounces-250891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2AD39759
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CB5E3003517
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5742732FA18;
	Sun, 18 Jan 2026 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="gejngjRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5C171CD
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768748871; cv=none; b=fR4AN4hBdh46SktFbwnd1daqel4u35TXwhff6dkmUD5ONJF4Edkk9kG1WmjDDUD9awhg/ZhqCh/2XPBAdrJ5XujyyeW9hJ/Ofc2cSnQZrHK0qELKvyp4gKkXEKaMJWZHss7OduSXXz5ceH1PnwqVAar8Sbjo4HMblmaLtmXqfoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768748871; c=relaxed/simple;
	bh=dpqvH7H8rUH2piOvDS/yiPzGDDDFTTSZ2G6LYOuPskI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3+LKSJcp4o8NKrl9uHpYBjVJM1KR12Mqfb+kz2SqiLQI9YyjJ/BHqYutTyltEGxnnM7Tn04ZoUKWXQQC9lJxj19NeQhevC4ua3Dh9SeHXzu1T7+09kVDh+RWglWruNuN5IuPbEDEMU4leFihSARwjYeEYRerCotCEySag9Jfbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=gejngjRB; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34b75fba315so1622863a91.3
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 07:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768748869; x=1769353669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQtO51Cmo/SxOlbLdLL2eQhvPXFAj23Z7YCB7bUk4eQ=;
        b=gejngjRBkGLRAahTNvaYOvsXFmv3biEpwSXc1Q6iX9z/X/J53IFZct61Rz3XCeo50I
         UeQQ9EgyBNOfbzASctwgHI+9tGSTt0NU6CybS+2zVGyK0nMMvGenpUR6Gw1kBWtiR1P+
         MDgRO9zr/+X0lVnJUvdl+epjn3vWjvcrS0bzd+CyelbTnmSZ4koZ0LqAC/cZauVqR78b
         PtCj49jVWZAx2X4M92dKNomTCjW65RoI6yfwC7Lp+9nfpe+/a7ntLi7jZqgupgIRf7hI
         7jyG61xHb8fmbDahZe3LdVqE7xov9GGuhMztsAjYXMfMaely69VmJqGjyMX8qOKaA7KX
         wgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768748869; x=1769353669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQtO51Cmo/SxOlbLdLL2eQhvPXFAj23Z7YCB7bUk4eQ=;
        b=nT0t5EcpKiu8hH9X/1zU9FeLnhyg5gDekymyNSmGckUC874E8PVfhum8dWwC3db4ft
         1RO50p1+bVM1vymdHP60Mypbp7OqgBG+0GsJZSWeIstSRNJnyeX0wGv8qERur/wir7fa
         tO4ssC5QQqfMm7CpiZIQbGNEx7UShS/VgO539odThNptu6VoWEmS/EGkdRt7s4/KJo3C
         SD0D8SJtYCh/OZl5AblFnemIWC5G7zXUSmq0wSoqJ3MVRBtMSWRf1r6egZtIvZKTchk1
         fJTd1uSP+twYdGwl3HPJz8xvuZdvA0gVI3E5lzPYniGDwFACwxg2aW7dS0GLlQSLJjg6
         LM3g==
X-Gm-Message-State: AOJu0YxpxpvrRgF/w4NgCjfzDvOQi3NvLXgl2K/S+vXt5YZxa8lsmzom
	n85mUCqfjgcHe+LL1LbEtvEvfXYIfg0zqpkLtktnSumBWU87NT7Cun/bALNGz1VakGltqkKUdyF
	LE5Yi6p4GSSPitfttLj5nRcY5dmfwF3ab70+5Qe2b
X-Gm-Gg: AY/fxX4Wm+3yrbwYfJMvpYFf8oSzxJ+JaPT6cKDxTmjEXq+coIXdtNofLO108FKhDo2
	74bukZwsxaH8PuLtVKIvSeIlp7Oz6zemdIQShVEaRC5koaEmkpbTmE0tAlX1hra2FGYT0TEodI1
	GArgYnvoFty+i+EEwKZQc8sQAqZMrOJ2tfiJodojga+95hdOjeLE8KQDUuTlS4kLvNjmZRg9Cri
	uwzgBkhyxVSuW6VnEBRbv5q2ln6Fjt1qQi+jqEhh8m+WgbdKpErbAMRhvDHlxpSmN/OF1Fn5YQ1
	lOM=
X-Received: by 2002:a17:90b:350e:b0:340:e529:5572 with SMTP id
 98e67ed59e1d1-35272ee0e56mr7858152a91.8.1768748868802; Sun, 18 Jan 2026
 07:07:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 18 Jan 2026 10:07:37 -0500
X-Gm-Features: AZwV_QjVPfNZLKMK_bneNC3DV8UNYY95SR3_NSTolF4ks3DTk6Ur7eeXo2s8KhM
Message-ID: <CAM0EoMn=bx-AMR0RbFmSj8MjWTxLtB_xo5419AW18paZ9r1wDQ@mail.gmail.com>
Subject: Re: [Patch net v8 0/9] netem: Fix skb duplication logic and prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Victor Nogueira <victor@mojatatu.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	William Liu <will@willsroot.io>, Savy <savy@syst3mfailure.io>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 1:16=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This patchset fixes the infinite loops due to duplication in netem, the
> real root cause of this problem is enqueuing to the root qdisc, which is
> now changed to enqueuing to the same qdisc. This is more reasonable,
> more intuitive from users' perspective, less error-prone and more elegant
> from kernel developers' perspective.
>
> Please see more details in patch 4/9 which contains two pages of detailed
> explanation including why it is safe and better.
>
> This reverts the offending commits from William which clearly broke
> mq+netem use cases, as reported by two users.
>
> All the TC test cases pass with this patchset.
>

These patches should not be considered for any review because they are
not following the rules that are set for the community. The rules,
which are well documented, state that you must cc all stakeholders.
When someone does this _on purpose_ such as Cong, some accountability
needs to be imposed. I would say totally ignoring these patches is one
option. Otherwise anyone can just throw a tantrum and decide those
rules dont apply to them. Either that or we modify the rules to state
it is ok to do this..

cheers,
jamal

> ---
> v8: Fixed test 7c3b
>
> v7: Fixed a typo in subject
>     Fixed a missing qdisc_tree_reduce_backlog()
>     Added a new selftest for backlog validation
>
> v6: Dropped the init_user_ns check patch
>     Reordered the qfq patch
>     Rebased to the latest -net branch
>
> v5: Reverted the offending commits
>     Added a init_user_ns check (4/9)
>     Rebased to the latest -net branch
>
> v4: Added a fix for qfq qdisc (2/6)
>     Updated 1/6 patch description
>     Added a patch to update the enqueue reentrant behaviour tests
>
> v3: Fixed the root cause of enqueuing to root
>     Switched back to netem_skb_cb safely
>     Added two more test cases
>
> v2: Fixed a typo
>     Improved tdc selftest to check sent bytes
>
> Cong Wang (9):
>   net_sched: Check the return value of qfq_choose_next_agg()
>   Revert "net/sched: Restrict conditions for adding duplicating netems
>     to qdisc tree"
>   Revert "selftests/tc-testing: Add tests for restrictions on netem
>     duplication"
>   net_sched: Implement the right netem duplication behavior
>   selftests/tc-testing: Add a nested netem duplicate test
>   selftests/tc-testing: Add a test case for prio with netem duplicate
>   selftests/tc-testing: Add a test case for mq with netem duplicate
>   selftests/tc-testing: Update test cases with netem duplicate
>   selftests/tc-testing: Add a test case for HTB with netem
>
>  net/sched/sch_netem.c                         |  67 +++-----
>  net/sched/sch_qfq.c                           |   2 +
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 144 ++++++++++++++----
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  90 +++--------
>  4 files changed, 153 insertions(+), 150 deletions(-)
>
> --
> 2.34.1
>
>

