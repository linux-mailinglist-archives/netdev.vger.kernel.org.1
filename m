Return-Path: <netdev+bounces-111544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9109317FE
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BA01F21D99
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC238E556;
	Mon, 15 Jul 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5DCvw1c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A918B1A
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059144; cv=none; b=Ih7oOYyPe8cazElAuMHRMA/QLgXul2EmStoBmmNnEF9I2lDpRJJx/Ip415MQ7KtSw+hO20zxAitGDGofndwpSZbe5BojVLP/tcrdgzMV+BX3F13wNzlIzBlL196vkhxFthFiJXk0h6+HMzJ8HS2FOEnE3BbW30oRH05kz9zISIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059144; c=relaxed/simple;
	bh=NDiSe8ilM/IWTqqwtwNubRpgYij+jXCcYBqxS9aUaG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoM1iLeHBbravLNnBYX9YIk5Ha5so7LAbrQkdrEHMuFx9YXNI+mlFkCuxF7kBhR9ArvgKjaIGFA7tTZQpRw8E0Om8jnLrcK8mq7O6RMPhKo3zTo46KpZaNBJtJAhw988WITK+iDtvJM4SL5RO49Xcjolu1+ydQhL0BTc9nI6v9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5DCvw1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B50C32782;
	Mon, 15 Jul 2024 15:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059144;
	bh=NDiSe8ilM/IWTqqwtwNubRpgYij+jXCcYBqxS9aUaG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5DCvw1clZvgR6GKznYjUdfb/NCe2ns6JyzJqKIl9dsdYkYEE0jPvA/Q0K9sK+nkd
	 oXrvo0+ZPdnYbsqro/1tM/rPj2jV/saNFlUZSCK++tAafoGERbaWIrAh08FItT9bN4
	 UVno+MlazXj8NS5i922tAeM5Zk68NY2kgtCGi3BnceMFqyxnQyIE8ECbISFQOHhgjI
	 PEtjjynErD5FUGW6igRqMiJQchgDDuEMMPecpjNzlgjgalEdsGoAdh9ta43Ouu2dWi
	 FU/hZIzQtY7m1mWOr0WtbTMRGNWT1EwLkvH3iXslg1nG5YE/qmO2949Mc2+xeP0qwz
	 avkI5XtXK/5Fw==
Date: Mon, 15 Jul 2024 08:59:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, Simon Horman
 <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Mina Almasry
 <almasrymina@google.com>, Abhishek Chauhan <quic_abchauha@quicinc.com>,
 David Howells <dhowells@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Ilya Lifshits <ilya.lifshits@broadcom.com>
Subject: Re: [PATCH net-next 0/2] tc: adjust network header after second
 vlan push
Message-ID: <20240715085901.28ddaf4f@kernel.org>
In-Reply-To: <20240711070828.2741351-1-boris.sukholitko@broadcom.com>
References: <20240711070828.2741351-1-boris.sukholitko@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 10:08:26 +0300 Boris Sukholitko wrote:
> skb network header of the single-tagged vlan packet continues to point the
> vlan payload (e.g. IP) after second vlan tag is pushed by tc act_vlan. This
> causes problem at the dissector which expects double-tagged packet network
> header to point to the inner vlan.
> 
> The fix is to adjust network header in tcf_act_vlan.c but requires minor
> changes to the generic skb_vlan_push function.

This requires more careful analysis than I can afford right now since
the merge window has started, sorry :( Please repost once net-next
reopens: https://netdev.bots.linux.dev/net-next.html
-- 
pw-bot: defer

