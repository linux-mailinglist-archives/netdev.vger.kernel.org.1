Return-Path: <netdev+bounces-208618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C3B0C5BD
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 16:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83E57AA750
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06620292B22;
	Mon, 21 Jul 2025 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="Zck/jrfk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087D02D8DD3
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 14:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106445; cv=none; b=tOJpXusYnnI2IZ9L+yAmPeAdPe4NKDqVy+vQuaf0nfeOmXN1jGAFYWEjwshv0bL8qYw3S7jromStGO14RjUuXdmrHVXi3RHm8Smkiq7ArAKPYdq1Hsm4U68n+IOeygZK+g5xzNIHZBuzNUg/h53DmY2dZMDiEjL38idOJ1P6lDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106445; c=relaxed/simple;
	bh=CVFw3AqSlMQse0OCqHcs9dEkdqwr21L709+v/1Vf+mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZ/O4UzJLNhBlP3qLf4jXeVKSTf3t80+Lqb26aDPPwiRbGMX5/QfIhmIkXrnQI9mOqui2nZbHwhAJbkTOjTG2IUZjlQo+c0Is2DBjQigjkBP3RNScZkBsUkOgMfK3puA78N87BQDFUhXZrWLzRc77S4NuqpZ8pIwlUz19N1jjvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=Zck/jrfk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-75ce8f8a3cdso613886b3a.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 07:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1753106442; x=1753711242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ0B1fOi2L2LdOyzqnNzbBRpa/CTmeuTS236TqE+k9I=;
        b=Zck/jrfkC8HsvgTw2PNGLnqk6O1gI8afgTx/5oIE1cKupZ0cadRmYjltbZ3e2BMjJz
         Xdi8/rGrUSqKUpaRy6MkqdSaWCb5fwVbwlRzEDy70qLaTmVOZcIYHXRF3moM5w6hOUPc
         ZY2ANv84S4/zNLwIpNuPMq7Ci5GQGqc4oEyKcR1c2FGXwa78rGYO+V+q2MaXemPJfhMY
         LRwq92yPfRmfhdmASvkAo7n7VH+/x2LVii/wErRtNy++Ofs3aG/NiXmsAk3U2UgCwkwG
         Zt+UFPoRTfS2U4/8+1OcXOIiV2czJm3zSbT37TscRujnCmofgBNQxL3pu5ePUsvidciW
         6auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106442; x=1753711242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ0B1fOi2L2LdOyzqnNzbBRpa/CTmeuTS236TqE+k9I=;
        b=EM/xEDXL8g6pjkDtIKHk4ZZYWCCRGxKs4aHxfC1um1+KMQatIatmrpu4GPezTVbnjy
         F87Uu1wZqQ24MP7jXXArEy/OF1GWHuSa1rfZyEkobgHqQ8qGbjL/5AbWC9I4pTJ2OIKA
         IDbPfcAC7veSWu/LMp9E08o3DpfCQa/xDQArggf01UaMIy+ffMju8X6d0mKkyB+/VuRS
         0S0r4V7tGbHlfd/TqH9kG9P0+rm5P8q55126QIaYYugu1QCw9jkoBgdkDrGDdM8ylFjB
         RC/4d8FxA2MnqJekAFFE9OvVpc3JUvYL2mV47QEVsJTEg175uZbPJ3lBh1kGqnBQZJDP
         PXVg==
X-Gm-Message-State: AOJu0YwqZwC77bRgQ9aOzYJvwWHzslf+w8uZSD7CH8Mj6vfMXON7nvZe
	4O8GGs0CseyWPVFay1L+upJPebPCLkWbAAkkV7xllCoWU5IDixPMcuchi00AOJP1dL5aDjJOnEO
	3HveXGwVlA/lgW2wOHtCd2pyRlj+pdZyt9pQINZOsgbUoywBOoLYnKg==
X-Gm-Gg: ASbGncvjyuii6PtNrS8m6iyW9WtErBKuVtXhlh9WLUJ0zJ0dLmrl+W0GTP1lJ4qVRVc
	bxmPs8GF7BQNEdtCQjM4CmLBlKeQ0KmOx27r26SJdQU+cca0tkQSgUz34gHSuQfk0a+6DJaWKAu
	nx6ayQhJJbOyEfNM36hvzO9MUCxiSy8aqREBm3DKMJgDrUJNqlvbfOhpMumoP1g5Zd2/rVHCuJs
	mJZjf8K9XWZaAk=
X-Google-Smtp-Source: AGHT+IFqiU9ZPrZ3IDAcgDXYBlKh80slBb06/5ipPnImCzLsypVih2U5rZcDzH0zUZ2RrEAI0oFKHbGiNMl9ubZe/x4=
X-Received: by 2002:a05:6a00:1412:b0:742:3fb4:f992 with SMTP id
 d2e1a72fcca58-756e8b5795emr26197270b3a.10.1753106441796; Mon, 21 Jul 2025
 07:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 21 Jul 2025 10:00:30 -0400
X-Gm-Features: Ac12FXwxwtqrC6Ee08_buNjsB77mIVP8ZEiFpxtj2qacL2RmCiX2iFQuG2Y5Wz4
Message-ID: <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
Subject: Re: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent
 infinite loops
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 6:04=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This patchset fixes the infinite loops due to duplication in netem, the
> real root cause of this problem is enqueuing to the root qdisc, which is
> now changed to enqueuing to the same qdisc. This is more reasonable,
> more predictable from users' perspective, less error-proone and more eleg=
ant.
>
> Please see more details in patch 1/6 which contains two pages of detailed
> explanation including why it is safe and better.
>
> This replaces the patches from William, with much less code and without
> any workaround. More importantly, this does not break any use case.
>

Cong, you are changing user expected behavior.
So instead of sending to the root qdisc, you are looping on the same
qdisc. I dont recall what the history is for the decision to go back
to the root qdisc - but one reason that sounds sensible is we want to
iterate through the tree hierarchy again. Stephen may remember.
The fact that the qfq issue is hit indicates the change has
consequences - and given the check a few lines above, more than likely
you are affecting the qlen by what you did.

cheers,
jamal
> All the test cases pass with this patchset.
>
> ---
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
>
> Cong Wang (6):
>   net_sched: Implement the right netem duplication behavior
>   net_sched: Check the return value of qfq_choose_next_agg()
>   selftests/tc-testing: Add a nested netem duplicate test
>   selftests/tc-testing: Add a test case for piro with netem duplicate
>   selftests/tc-testing: Add a test case for mq with netem duplicate
>   selftests/tc-testing: Update test cases with netem duplicate
>
>  net/sched/sch_netem.c                         |  26 ++--
>  net/sched/sch_qfq.c                           |   2 +
>  .../tc-testing/tc-tests/infra/qdiscs.json     | 114 +++++++++++++-----
>  .../tc-testing/tc-tests/qdiscs/netem.json     |  25 ++++
>  4 files changed, 127 insertions(+), 40 deletions(-)
>
> --
> 2.34.1
>

