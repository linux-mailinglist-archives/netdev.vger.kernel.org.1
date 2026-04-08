Return-Path: <netdev+bounces-276753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MR5O2jq1mnkJggAu9opvQ
	(envelope-from <netdev+bounces-276753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:53:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 680FD3C4D8F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 01:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2487130214C5
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 23:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE138551B;
	Wed,  8 Apr 2026 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyEb9ng3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7337C11D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775692380; cv=pass; b=oc5Vkk60aiVEtqqiS+69bT9HRy0oFxK0WLuzxmtEB1saxDaZM6W3/gA+A5/LaBJWN71nFeWz4ArdkDQYy4QlF0vXfohx9DGmXb8cZ/giu9cXz7JyTvwO5qBwBp0wyE0vJ9jhSfYgwhv+NxTQb4vnfsinRYlo8qbpZ9MSi93/vy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775692380; c=relaxed/simple;
	bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5njqNJ6yuVmQ/A9rbL/G5DI5uZhNGyy/mzpSMt75bZpQHAlmZyLULF+k7hBwHKM2PAUZzMJHf4fSa32uMFY/69vsk99hkvkcjMvWs3Pko4qX621j5quC0b7FIRZLNuJJIZrg2mqNuNzddOdyMptCXXz5uTZmViLM9EPCutrY3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyEb9ng3; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2b383cefaso266276e87.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 16:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775692377; cv=none;
        d=google.com; s=arc-20240605;
        b=hRNtA12PUlwJ7R9AEHZhtLczjjq4z7mboGpFhK8pGXzsI7dfDWqM2KN8t9wH4Die1B
         7uO6hjNpVa1AbQiDzMF4j2OB1RrWV0oZBZrI8Y/7aPmcXlAz+T86Df0WkSmlgxP3S6ZP
         L00NukyKi2rOBhGN4LWQHMa8pF6nQ8BCNywqN4vHgAIoWuxCPR5yeGKolCOWKQu72+D+
         6eHMQCZ/dyIIVPpcwgygCKpC7QD+H63eW4k2K0MgYtAsld8SDBBTGXdnPxiNaknOSDJQ
         r8sAOJ/Jbp4ilSvBIm26F8kHn2+WWmTMBCCTAZwwn7tZkLfSJQ12Jn7WIP4noDOemzx2
         bUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        fh=E/XcbXEkJxQk0H6XmTeGTEZG31dy6X9Yqf+BsoUu+GM=;
        b=B6GZLRvqIHRxYNRi9Vcia+4+KHhhsxNz2afB6hPnSHzYOC26BcPu0Id+VAm7XWgiJi
         Rhye9y4PJYF9eviUgniKjxb9S4HLb2T7SFpYlYueJ5L5zPaaUl3Ztgi/BqEigYPZkiAU
         kT+FPa8bEekWBKWAZeEY7u5kVwfe7+yMkLG3GVk/BlOQTKS5bCgYTqAUrSDVpXXTldA/
         8s/mglSDgICq2m5N68VO3FYe1hh20tnyhO4keOQ/YL3+sYpLXM5XeewEFnuEBUakczrs
         oSs7wDd47VRCjeL8toCUl48kc0Y9wbxoTWz+Ug2leRWz5aM6z8rnt2XqOKOAQ+DVfhoP
         jMQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775692377; x=1776297177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        b=YyEb9ng3hiHb881w1ZY0vQzo9EZsm1A7L/eB+zBIUZNIcsteQqFLQ/w3ou4s4c36eY
         hL2J4oFc19fzji7l+ai9TxfwK1Gj/XUcQsQbJqn9C2xDkuWOuOrOZDJ5D56KmnoBHuTy
         b+l2+QTeeRuhpTuC3lHLtu62bxFjrNEcJJLUOe3mwOwBEp+pAa1NeulCpc2liSN3GaV3
         yndso01cICa65gfdgdGrLVA5fONvDGSFjMYLHcO4zDGXTu4OqLtZfVQ+HuG/Q6l+I9zo
         G3+VjTDBVI1PUwBiP10kLSuZ5NS2MYjmoAAA40LjBFOYFU8Crk7BxTd2osXbw32Lwh6m
         zqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775692377; x=1776297177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SJDkEMPwfGPXgzEx/lQ3RYJvGP+zSBYTYDmzQE9d42E=;
        b=smdXyy+8y+8N8pXKs9vGO6knMZm0jlYuaODQyPmDL+2NomSUPqT0+1YR0OHUptyqvG
         MtyLH0gYFmSPVZm/KwLQvJahYTI/4/babYv5GWQLIBy6g2+aBKkncAHP0A+GTg7ZFRq5
         LfCwgfbf3ZNNuif1LHOVeLuM+Ah2IOx4w6Jfy0TuAMVCtYoLoodXtMf1dr3dIzrZEjGW
         YXkd184WtvP3VkqhQOYIYNrI2n//TjvQneoPREhgc5MePXljhF5JcSc3qTMc7EJ0+god
         xjz/r7O8Jek0P1Hq21sXbhQHN+JlERDwPhhLs30GjttKy+YDqMxbUywe4UFGueDqivoA
         LHHw==
X-Forwarded-Encrypted: i=1; AJvYcCVlR5SVc1F714k2bcrmUtoIoJZyydyO8ZroKord61nga7T/h5fbvX4/Q7UZU4wt3H7s5wDzTHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIE6BVvSLpLvcc1YxjO2uprUglIpEw3HY9djK8wnzMPVHitmI
	icIjuTC0tIUuZO0m2fG1AOAl/QVuExUVDSxJHhVMekuomSBVR13X0s4T6GGccoeRZ3IBFSO0rK7
	8eQ+X4IbBlrj9TvZuY7B3M8qLJ8WJFy8=
X-Gm-Gg: AeBDiesQy+aCwkF150bQJDtjHm+4n0wvK+84+YpujUONNioyLjpTUKmN1GdVANEbk+l
	hS1BN8CMdQ0qWOR7gk20DPXYr4ohlMOtKHV8xyfPJ5RpS8Qih/wqQFgJoht7EHlP7w7sNN05L+Y
	xBG+2tn8Z/CmSd66BVB1Xk4O5dtZb23SEj2CJHKXnwSsPb/Y9VKJ+qbuNeO5Y4fABnyOUfmvUa2
	w3xHY4hARRrgZP0329S0XJNyuUdg7Z8koPjhg2hBIvkIdZMNVOWIlfNlmdxkM6aP7ntp/zl9Fx5
	uQlA428=
X-Received: by 2002:a05:6512:3da2:b0:5a2:961a:f7c6 with SMTP id
 2adb3069b0e04-5a33758bb66mr7055339e87.39.1775692376378; Wed, 08 Apr 2026
 16:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
 <20260404150452.83904-4-kerneljasonxing@gmail.com> <willemdebruijn.kernel.2ff565d2f9e7f@gmail.com>
 <CAL+tcoB94=ptFB-acU3nAK_MqW74DV0MQUVvvV3nbQ7Zc6zSZw@mail.gmail.com>
 <willemdebruijn.kernel.27ec47b22b23c@gmail.com> <CAL+tcoAvVBN7juJEBt5-FYQ4eGTe7dYrFbR3CMOwguw=_X=btA@mail.gmail.com>
 <CAL+tcoCctfs=d9zz5ei1S999S94HmUDSToriZ8NJiLT8MmpQTA@mail.gmail.com>
 <willemdebruijn.kernel.1b49845d3acc7@gmail.com> <CAL+tcoBt1A5GYFvimkcRFUtmy298y13AiF-XFF8b8E8Y6fg8Xw@mail.gmail.com>
 <willemdebruijn.kernel.257654f9a3f23@gmail.com> <20264818422.Ya8u.martin.lau@linux.dev>
In-Reply-To: <20264818422.Ya8u.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 9 Apr 2026 07:52:19 +0800
X-Gm-Features: AQROBzBBag-aH8HRoy4mgE7UVgABT65YEnZ-i8qy9YgEHaGArFJoFmroKaqGPJQ
Message-ID: <CAL+tcoCSSBQYqj1+er2qMk_rCRJJ6qvKn9AQ4zcVj5hQjSCd0g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when
 wait_for_space occurs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, willemb@google.com, martin.lau@kernel.org, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Yushan Zhou <katrinzhou@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276753-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 680FD3C4D8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 2:13=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On Wed, Apr 08, 2026 at 11:15:09AM -0400, Willem de Bruijn wrote:
> > > Avoiding adding a new one makes the whole work extremely hard. I'm
> > > wondering since we have hwtstamp in shared info, why not add a
> > > software one for timestamping use? Then, we would support more
> > > different protocols in more different stages in a finer grain, which
> > > is a big coarse picture in my mind.
> >
> > I don't understand the need to store more data in the skb for BPF.

My take is that it's not for BPF only. BPF is an approach that achieves
network observability safely. The ultimate goal is to serve the
network area.

>
> Adding a field specific to bpf timestamping is not scalable.
> There will always be other bpf use cases that need to store
> something in a skb.
>
> There have been discussions about storing metadata for a skb which should
> solve the general bpf use cases.
>
> https://msgid.link/20260226-skb-local-storage-v1-0-4ca44f0dd9d1@cloudflar=
e.com/
> https://msgid.link/20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-10=
47878ed1b0@cloudflare.com/

I've been tracing this feature continuously since Jakub gave a talk in
netdev 0x19. We've discussed a bit there with the overall plan. Yes, in
theory, it works. But if we put it into practice, I totally have no idea.

In terms of the latest patchset, it doesn't meet my requirement:
1. in the stages below TCP stack, we're unable to read the timestamp
recorded in the orig skb.
2. it only serves the low rate flow, which is definitely not what I
expect. Please see the original verification from the cover letter:

"Rounding up to ~500 nsec per packet:

- at 100k pps, that's 5% of the 10 usec per-packet budget, but
- at 1 Mpps, that's already 50% of the budget, which is not acceptable.

While definitely not suitable for high-pps flows, the naive skb local
storage implementation is arguably acceptable at low rates, for example
when you need to attach metadata only to the first packet of a TCP/QUIC
connection or sample packets at very low rates for tracing."

As I replied to Willem, the look-up process is also very
time-consuming. It can be a temporary tool but not a always-on plan in
production.

Thanks,
Jason

