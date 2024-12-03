Return-Path: <netdev+bounces-148411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740359E165D
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45497164C83
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 08:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2011D47BC;
	Tue,  3 Dec 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="nbB6Jc/p"
X-Original-To: netdev@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E58D1A4F2F
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216029; cv=none; b=Fe5Yw3rTQhPjTxuN1hEWcaDXqtS482zQNNcagMy7g5PVXr3mJGrazxEC1c+OG2HREUPqvH3aCBE3o3Nf7RS61AbI18enrl5+fD0Bjj+4OLgey31iyNB7wuR5tpgJxP008R98PABLi04CT5huIPjJj/yARlGRck7Yk/xJusqITPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216029; c=relaxed/simple;
	bh=WrPArXvpbZr9O9eZmjNxD8Ss2kNDYmAdk++CLX9L820=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pqEKx/aZrZLhId/HD0j7rgWJGTyX5+3ddifPRSN2qWPIn+WFbUjQyYiFzx3BiGh9EJo1SweBXdIgjz551rirH1u1dlAgGpSA0k6DLUKLdBXlMw5vBFpTsTGJxEZERzRvC2kJf7/P9AxowxMzYz5MiHc6ZwpEmInPNpZvKfFd2+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=nbB6Jc/p; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1733215685; bh=WrPArXvpbZr9O9eZmjNxD8Ss2kNDYmAdk++CLX9L820=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nbB6Jc/pUP9c+wE4JekMes5g4aEFpYpZ83S+7XoIrC0ZJLDGx9pc1pJQrLKHXgyDk
	 ajyfzoVv1jgBKa6L48D0YpxutJG4yMG3Mw9QyFI7am8VUZ4j29T45FR/vRc1k3lcFS
	 yILUJMUZVJmGIpt3MAQid5Ip6HDewPxOMdyMXVa8fQUdi3dDePMP3rJejo33aCuapU
	 +0HVSH/HfbHY3iQFmU+Kdc11dk9HkutrEY4Qyp1E1Xotp+AkbLyWKCwhU7u8aeCyF5
	 BW8O6m0ARk9wCc6uZ/ylSX28T+7pQ30aRSugynouIqyMzsRdS8lwlb72EOHMmAVrmK
	 bZcNkMvbOvy6w==
To: Lion Ackermann <nnamrec@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, nnamrec@gmail.com
Subject: Re: [PATCH] net: sched: fix ordering of qlen adjustment
In-Reply-To: <6c7ae1c8-8573-4f4a-96cb-0a75eab21516@gmail.com>
References: <6c7ae1c8-8573-4f4a-96cb-0a75eab21516@gmail.com>
Date: Tue, 03 Dec 2024 09:48:04 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87iks1gnjv.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Lion Ackermann <nnamrec@gmail.com> writes:

> Changes to sch->q.qlen around qdisc_tree_reduce_backlog() need to happen
> _before_ a call to said function because otherwise it may fail to notify
> parent qdiscs when the child is about to become empty.
>
> Signed-off-by: Lion Ackermann <nnamrec@gmail.com>

For sch_cake:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


