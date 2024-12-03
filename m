Return-Path: <netdev+bounces-148316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629F89E119F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273062831DD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73E13B2B8;
	Tue,  3 Dec 2024 03:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyN3rK+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436E1FC3;
	Tue,  3 Dec 2024 03:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195594; cv=none; b=hpmk9Ujpl/Gb/BBszI2SQ/NLEujFsie5r0LulcIef63o0oeg2RoS7TqepCjYJaxTMhdqa8KV82bwep1yhD86DRMZ2EOqTU//wQlhRQXYakEXps9bWFRyh/ZD/bIXRSNmW9wCYHKJOiGryXkQDn5d0qwnk9shmae2FbpdtbJDRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195594; c=relaxed/simple;
	bh=78Tab4+mpq6BoITVR3l1EwI0OlPjtwzE/QCEpdO8Bw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iihrRRe7146ydHsuu0dqTCqdmsyxW7nFUWfm5PjcoIZBydEnO6CgAV1ym1lz8dkcNCxDUu5Undj+aZuua5rAhGDlskAOI0oP/D6OisHttP5D8jOdlJCr69juWgUwMOBtE3Fz7qE/aX5v3vzGePC94icxzz9vDdzfW02LKNYTNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyN3rK+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B5C4CED1;
	Tue,  3 Dec 2024 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733195593;
	bh=78Tab4+mpq6BoITVR3l1EwI0OlPjtwzE/QCEpdO8Bw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iyN3rK+ibZD6v+7v5XVNwYeVKrDTwQs1TLtrSV0bQOtcOlvnR6yLWZrWqrERuabUK
	 qsZQxxtCUYhryR8xlYT+r0Oevf2eW3P/nGzNO6HtEZiGUJ2+83Ur6W/nYIKrLWLxKM
	 mzcRth2ytoBj+JLYHsGWRthA84H4v54FN/F7I6e97bG5DEbXvgnw1hTXfreYH/mTmg
	 lpyMnAiHTg44nGiNPtEPU85c5FmycYUzNCYIWB+M17R7wBMGXdmLfdHCvnLtWlOxeQ
	 pTnpEB9Fqk5x9VgPOs+SGDFMVOgHwzv/slKR1cWLINpcEVFGujb0gQv421kCpvTke2
	 2qaSW34jI3+Ew==
Date: Mon, 2 Dec 2024 19:13:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Ottens <martin.ottens@fau.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: netem: account for backlog updates from
 child qdisc
Message-ID: <20241202191312.3d3c8097@kernel.org>
In-Reply-To: <20241125231825.2586179-1-martin.ottens@fau.de>
References: <20241125231825.2586179-1-martin.ottens@fau.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Nov 2024 00:18:25 +0100 Martin Ottens wrote:
> @@ -702,8 +706,8 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
>  tfifo_dequeue:
>  	skb = __qdisc_dequeue_head(&sch->q);
>  	if (skb) {
> -		qdisc_qstats_backlog_dec(sch, skb);
>  deliver:
> +		qdisc_qstats_backlog_dec(sch, skb);
>  		qdisc_bstats_update(sch, skb);
>  		return skb;
>  	}

Isn't this sort of a change all we need?
I don't understand why we need to perform packet accounting 
in a separate new member (t_len). You seem to fix qlen accounting,
anyway, and I think sch->limit should apply to the qdisc and all
its children. Not just qdisc directly (since most classful qdiscs
don't hold packets).

I'm not a qdisc expert, so if you feel confident about this code you
need to explain the thinking in the commit message..
-- 
pw-bot: cr

