Return-Path: <netdev+bounces-248538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0DFD0AD43
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20C7C3017368
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 15:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B2E32A3C3;
	Fri,  9 Jan 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVRm6U7V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0CC2236F0
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767971750; cv=pass; b=E+pxxSapuf4EhYcgUmx52SVDBxbtcBsyeMeMwoiNdv7j1vWTakR86xFhfKXFljtEnyEs9MPXDgK7ZQebusUklnLPbUnSI+0QTpE6GeFWe68O3wt4laAlRUJiwCcPhSI0eZ3kmPJlKxs8SeEiF5Yy0JmvjRRFIJZGpzSW+/QYYlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767971750; c=relaxed/simple;
	bh=0c/JeIlrwGnij0vvRsvEQK2R/vrTyXuzmj0DHjRYsrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UT7mvTEujKp3GzLEzCdUju7YrVb6t8SNzfM9J561acqajaXGXNxylXpsztMskjZnsIT5+rUBv5vdgQhaYvcQanUNo2sit62HS1sCkkd4cHd4wkto5ItLuzVSr0HTagjQjsu3DvkMp8fSodty8Q5C36gZePMPGkfS7k3OkZgtFdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVRm6U7V; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4edb8d6e98aso552231cf.0
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 07:15:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767971748; cv=none;
        d=google.com; s=arc-20240605;
        b=WXjD2zJubexMgsDQMWwsqqSjGf/GkKG3nE4PcdUfiQQ7pCYVmMfeo5X6um4RDvD/FR
         aGaTrlhrQyiSSEd+igcsCcZ3F6uMI1hvoC1RVq4wPYKYqnUwoUos3I0z8ozSZ5LOS4AN
         a07G7jsjM5qlupgR1U2cjNZzFlkRmy+506X6Obi9zR6U979aMX/mRml25I+59SIlR3mX
         hQ9OFfm7n1mvcAnW4cLPmuBWCfzbhEBJ1oED6CpcyIbadqi/4j25RL3MZRuTs2CJkVZN
         MKHqH3tmN/WuoQrqkwjK7nnPfXOQQvncoujh0EjSY/YdypZNkRuTreHeKx7buxU4Rkpn
         R0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E9UcsRQnJZQYEutQbmTLUSne9T27ZhNwJW4zXUwj6Sw=;
        fh=5LaS2rs6yzJsTMAd7+2pxC1VMsVJjZZLlQRl4CXigik=;
        b=bJ3H4EMEAvjHn5bhZr/fF/tnE7bBGWBu5Vxntb+lSEMJvYml4qmm9QVR4dsCy52wQa
         jLRVU/evfYpvIx+sGMockCbabi8Dk1W9PyEY2vISvCyjl1ScsYhP+X5o3s+xsNvaBsnb
         N527cCVWd3SwFw3iB0DaoujEHiMuogYnwTIRk0Uoi9MZ476CISAvCQ3Ui39SDjDRfX/a
         kyrWrPiWiN5NpFY2Gw7kKoW640D03fIWGjEEQqIY87QEJMoE+Td1CrOUyNhHKLnM+R45
         P7ONecsgrTzbz9002AOWSkMt6mNOio3h81AnsHFjTr5/CH4fcxfti5dwnyPXvA313R8T
         zY5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767971748; x=1768576548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9UcsRQnJZQYEutQbmTLUSne9T27ZhNwJW4zXUwj6Sw=;
        b=vVRm6U7VlGyxx4blCbGbnnFyFW5Oo2L1gsLNEWBZETI/mXPgfLJED3yK8RlPCI05Zy
         TxgWeYBkhs/j3AjAVqeClelaTOoRU7wy5iOERvkE4DTJktOMnIh4eWxPTEWjoErImzE+
         B0ULdTHhEyZYAOoq5qigqvWTbEv42bQ5at2LkEkpObWbZY72aeiLkO09oS2kkkCc/3b3
         lxtys1gKbtR7P1dGypVg8ssrUyVHHPpPe+bXz70OrieE8cHZm4jx8ZaEkaMLE4mYvzB+
         6rlzx1jStZLEIR56Uav7rERzDtfH19kFP2o+IQP1iBc3gyvs9cUtPHGqvdAS+8rCTO3H
         8nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767971748; x=1768576548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9UcsRQnJZQYEutQbmTLUSne9T27ZhNwJW4zXUwj6Sw=;
        b=UurwPfpJmEtayCtCKgYODs+MIwHIxWrpgok1om6RdgTq2cXqb8mVDZtmR+k8+j45lq
         7gDQE5amcIZ81pfgKo/f13lxYkK3u3o4idre950c8X40Pt3CpblWJWmM+T3UVwthbJBI
         dPxZZn2DzDJEw3gSeZDrq7Xtd7nYtVa2YNpuEVUeouBqO7F/iuxEwUPkBvbEo72rES3n
         72xygNWqyTbUYrLC/b1kxLItDgmFYEZNcnU9CyS98wrDMOC+V7Gq3yPvWOlGP33yI80j
         WA7qvZsF4dZTbuM+o+WiRAPGZrfJ2f8dej+VFg9AVncnCTXCZ2W3yjws8BsD9hLvclbx
         vNog==
X-Forwarded-Encrypted: i=1; AJvYcCWWQ65uGY/xSajl6j/QytJVTzcfZq0UUO0R+/JM0ObXvBili/tBgCBwy0Pz7gcXMOaSF5AElyI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu4aOe+zZ0L32r0W6SvGLVPxZiH409JZ8AEQRg1TAaBqsqN5DZ
	GxZbtjoNarJ8cnQqKFf8kA50RwpPuWAQVvswiJQeSMIi/eYwUkUNIhyUnOTWqoBvjxUtzJpVwSG
	IHe2KRmHfhjJLVikXd+MMAKE85GKaQSGaJFvieeBi
X-Gm-Gg: AY/fxX7FaKEaPOpHezhtN9ABhLQMP1MnC5js2f9tYjL8YlpZXBll9sd6yTzq5+W6KBh
	pYNAqHwtWIPscQXr8KFmIHxDf57nGmNuQAbhGlvouSyckcl+NcQjMgHxS728dsr2KTIHJBAdyEm
	ZG31IupLjG+Nr1Fd0kU6dFYVhJPljVAi9M6mucsDd/fbTLNquYwzocq8C6++VRVa3Rl0SZFIrv+
	wOT+hvV7+zDc8P1k8SVkz8jR0/7IVK/95LwgSyP5+aP2J3DwrGJwg3TpE5tGj3npuKc5D4KQ/2l
	4Px1UGZgudZNxrozAJ8bhwd09B85axNuAYb7AqoP/K4NEGGz4iM8FGaYkeBFsmpYS6AD90w=
X-Received: by 2002:ac8:5d8d:0:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-4ffca3899e0mr11575111cf.10.1767971747439; Fri, 09 Jan 2026
 07:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107104159.3669285-1-edumazet@google.com>
In-Reply-To: <20260107104159.3669285-1-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 9 Jan 2026 10:15:30 -0500
X-Gm-Features: AQt7F2rv8sY_DszTaOBq6jb3X3A0A7Qn9fKYTozQdnD3Cn6HYXRWuxr479zH16U
Message-ID: <CADVnQy=A-SDhGKVrWPWAsXm-tRjdZSD046o6MGfKxT5x_8ymKA@mail.gmail.com>
Subject: Re: [PATCH net] net: add net.core.qdisc_max_burst
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 5:42=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> In blamed commit, I added a check against the temporary queue
> built in __dev_xmit_skb(). Idea was to drop packets early,
> before any spinlock was acquired.
>
> if (unlikely(defer_count > READ_ONCE(q->limit))) {
>         kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);
>         return NET_XMIT_DROP;
> }
>
> It turned out that HTB Qdisc has a zero q->limit.
> HTB limits packets on a per-class basis.
> Some of our tests became flaky.
>
> Add a new sysctl : net.core.qdisc_max_burst to control
> how many packets can be stored in the temporary lockless queue.
>
> Also add a new QDISC_BURST_DROP drop reason to better diagnose
> future issues.
>
> Thanks Neal !
>
> Fixes: 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")
> Reported-and-bisected-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric! I really like this solution.

On Thu, Jan 8, 2026 at 12:25=E2=80=AFAM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
> Hm, if q->limit is the problem here, why not introduce a new Qdisc
> option for this?

Adding a new Qdisc option for this would be more complicated and
error-prone than having a single global limit with a robust,
well-chosen default like this.

Having this separate burst limit for each qdisc would make qdiscs even
more complex to understand and use correctly, particularly given that
some qdiscs (like htb) already have attributes with "burst" in the
names ("cburst" and "burst" for htb). Having a third htb limit with
"burst" in the name or description would make things even more
difficult for users.

The value that is needed for good performance is a function of the
number of CPUs on the system and the networking transmit workload. I'm
having trouble thinking of a good reason why we'd want to be able to
customize this on a per-qdisc basis. Making this a per-qdisc limit
would incorrectly imply that there's some reason we can imagine
wanting a different value for different qdiscs, and would incorrectly
imply that we believe qdisc developers and system administrators
deploying qdiscs should spend time thinking about how to tune this
parameter.

Eric wrote:
> An alternative would be to set q->limit to 1000 in HTB only.

There are at least 11 different qdiscs that currently have no way to
set the q->limit, so the q->limit ends up staying 0, and suffering
this problem. So with that alternative approach we'd have to change
all 11 of those qdiscs, and make sure that in the future new qdiscs
that enqueue skbs in children instead of the root qdisc remembered to
set q->limit to some big number as well.

So Eric's patch seems like the best approach by far among those
discussed in this thread.

Thanks!
neal

