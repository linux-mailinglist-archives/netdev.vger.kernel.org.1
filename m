Return-Path: <netdev+bounces-57601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1411813952
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23C01C20A7D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03D467E73;
	Thu, 14 Dec 2023 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqUpZZVu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937224AF95
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 18:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788EFC433C7;
	Thu, 14 Dec 2023 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702576916;
	bh=SKAmToC5s8XHSo8dUorIFNkzUgh21wJnCMFZeItyzr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqUpZZVufAGCIPZ4wIyKrlBVm5bomgq9ukpVx3S/bA7iPp9GXOtLip1d+CeCJ8Ww4
	 L7hqXQ5QUp0+Ga+ZUlWLjTpJDw8tTOJyfeQHYN0b4vqSoxM1Y5obLIxOy/kzisjPiv
	 ROwVb0UqYBZQeVJ468nj9JGbJM5eHe2gUU5yDS2AIEXhO69UZLGkXZXMh7Ca0tk8SO
	 9cl4D4Jbw9OgZI28P1cdgibL4a3cjxjpkVt7tm928TpaeWMNLp8bvBygVRm6G40MrV
	 VBCzpWgykoVfob7kv3idL6u1pHPDX03GFHXvitPYvXq9BV4wlpQvE4GnrpZRrmgS6Q
	 loxNSR6EFFNbA==
Date: Thu, 14 Dec 2023 10:01:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Eric Dumazet
 <edumazet@google.com>, Victor Nogueira <victor@mojatatu.com>,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 pabeni@redhat.com, daniel@iogearbox.net, dcaratti@redhat.com,
 netdev@vger.kernel.org, kernel@mojatatu.com, Taehee Yoo
 <ap420073@gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
Message-ID: <20231214100154.2298fc8d@kernel.org>
In-Reply-To: <CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
References: <20231205205030.3119672-1-victor@mojatatu.com>
	<20231205205030.3119672-3-victor@mojatatu.com>
	<20231211182534.09392034@kernel.org>
	<CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
	<CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
	<CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
	<CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
	<20231213130807.503e1332@kernel.org>
	<CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:31:24 -0500 Jamal Hadi Salim wrote:
> > I'm still a bit confused about the cb, tho.
> >
> > struct qdisc_skb_cb is the state struct.  
> 
> Per packet state within tc though, no? Once it leaves tc whatever sits
> in that space cant be trusted to be valid.
> To answer your earlier question tcf_result is not available at the
> qdisc level (when we call free_skb_list() but cb is and thats why we
> used it)
> 
> > But we put the drop reason in struct tc_skb_cb.
> > How does that work. Qdiscs will assume they own all of
> > qdisc_skb_cb::data ?
> >  
> 
> Short answer, yes. Anyone can scribble over that. And multiple
> consumers have a food fight going on - but it is expected behavior:
> ebpf's skb->cb, cake, fq_codel etc - all use qdisc_skb_cb::data.
> Out of the 48B in skb->cb qdisc_skb_cb redefined the first 28B and
> left in qdisc_skb_cb::data as free-for-all space. I think,
> unfortunately, that is now cast in stone.
> Which still leaves us 20 bytes which is now being squatered by
> tc_skb_cb where the drop reason was placed.

Okay I got it now, for some reason I thought the new fields in
struct tc_skb_cb overlay the data[] in struct qdisc_skb_cb...

