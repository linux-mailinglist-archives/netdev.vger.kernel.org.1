Return-Path: <netdev+bounces-181635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170CA85E69
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BBD1B64E39
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 13:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472C2AEFB;
	Fri, 11 Apr 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjrSMRRs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEZpPoP2"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CEF2367B2
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377156; cv=none; b=aCl/6ocG4Y6mt6DZQaQj//P/PU/bBvz8p1lLL/8vFq7zv+VjfNoDpUKeilfcaH0n/4NxMSQ2w6FG/D+vwNE2q1jzgba+n6vIOvnJfJ7cqpUH0LfK5divBn7cvW4vujv5DV8997rdRnqQVScK9pC612kqOr8fdAnNH+MtJT2UrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377156; c=relaxed/simple;
	bh=4YP1XQ6IPyOe1vy/B3rhLSW91fEOZJFL8Oqay3GwNQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQf0eZubLgNA2IY8RW3EtVv1jH/7ZFUXGnZ1pespUSZBlYMAOwzsC/rTMktPtPahruhVyaAmNskCvH/8b8D56b9eDjQsPDHlddxKjzgimc0tAlplM4UyjnftRjOGpVXgyc8Uhx5SAl5zXC/1v+fQpZ4PoOY+x2I5z8Mk9JRxtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjrSMRRs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEZpPoP2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 15:12:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744377152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xl6pjqyQnrwcBkuqqJQwT94m+WOd7q6TSPXu61MjdI0=;
	b=sjrSMRRsAWSvMHHovaGREdgbc4qxew8Pdbvn/TvRMmVO0qOM2JCN3qcsQXM7n6M2VzUcvO
	r7sQrjM+gsXjLhXUE+F641e+RHsszEmRbAqursmnCNQD93MsnDN+xtJ63s7wendKwxHtG0
	EVnkt03w6J1LjAQr0vECN6Ys4Yi7QL03W9JHtF77mCNMorYXHYUvV7zpeV4DLdx0yrhQEN
	+8fH2IkXiXD+UZSTdvq6oseO4IA+DLSCRf8SbxZHfVhUJlXqFBQ6pRXp7FBAcj/6dt60aO
	1Z3vv5J3zIijLj20glxqfqHqCya/WoAdP2iwA3j4R3Qzks2UaJg5OWLBd1YNkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744377152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xl6pjqyQnrwcBkuqqJQwT94m+WOd7q6TSPXu61MjdI0=;
	b=fEZpPoP2GFk2kVIDhRhgjWnz+ZeZc7X4qyFCF4LlzN9D8KCeNzehb/1+pnRCeNQE8oCvcO
	jlnaEq9MugHpA+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 13/18] net/sched: act_mirred: Move the recursion
 counter struct netdev_xmit.
Message-ID: <20250411131230.Wm6eVlkb@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-14-bigeasy@linutronix.de>
 <CAKa-r6s69JbQX7ZuGiz37bbfQYWs+r6odhVB7Ygct8DYN=ApJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKa-r6s69JbQX7ZuGiz37bbfQYWs+r6odhVB7Ygct8DYN=ApJQ@mail.gmail.com>

On 2025-03-21 18:14:50 [+0100], Davide Caratti wrote:
> hi,
Hi,

> > index 5b38143659249..8d8cfac6cc6af 100644
> > --- a/net/sched/act_mirred.c
> > +++ b/net/sched/act_mirred.c
> > @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
=E2=80=A6
> > +#else
> > +static u8 tcf_mirred_nest_level_inc_return(void)
> > +{
> > +       return current->net_xmit.nf_dup_skb_recursion++;
> > +}
> > +
> > +static void tcf_mirred_nest_level_dec(void)
> > +{
> > +       current->net_xmit.nf_dup_skb_recursion--;
> > +}
> > +#endif
>=20
> sorry for reviewing this late - but shouldn't we use sched_mirred_nest
> instead of nf_dup_skb_recursion in case CONFIG_PREEMPT_RT is set?

you are correct, thank you.

> thanks,

Sebastian

