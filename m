Return-Path: <netdev+bounces-205131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFECBAFD874
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 22:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075BE487F43
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B88241676;
	Tue,  8 Jul 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="omaWcSZ4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771E24166D
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006950; cv=none; b=W/gSTbVk1lmE7IwKEnV0pJSGZ/E0gLClNAaEvBsNd5Z72do9uEE7WiimgvnNPV84A0QmV8T/TFd3Q5Fphz1eliBZK9zC0z08oc6/KGTN7DVhkxgXw+mSJWntsK8aAKpbXnBDViKkkv6XG5pZ5rV7sTrLtX9QpkMYmEGEI0Kugtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006950; c=relaxed/simple;
	bh=zNJgzkdVewF1sgcn6yqbMkw49jggk50uxEN/tQQWkJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDls8jWDAsoVvUEq6B8eLZHtiEc6iOsuur/JKNmy3bhownqMcZQkJEVLAyWc/KXvwC/3ygCysvCsg7vbAHf6mVPWpwI5/H1JItqZmHqjkAmxx300PUfuGNIn34VUYda1DXGo0T/vsRL26+UEMHdrZSlmah5ng95TlC3veJ2Id3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=omaWcSZ4; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso5604907b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 13:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1752006948; x=1752611748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNJgzkdVewF1sgcn6yqbMkw49jggk50uxEN/tQQWkJU=;
        b=omaWcSZ4YnAcydnmkORCuG7hysyc8A3OWO+kfHC6kA2aeqnhR6y1Mjt4I4Lb5U1B9K
         KAVB70nQq7B/0EYSvu07WLOfHzuJefcjQEztZCJ9boChHnobBKOlYL72UJRbLkugZZv9
         5C4TzSC55FbvoQTcGd8M0EbUczhUOMv3ZVYCtxpAGFbDp+aVtD5HpRJwGHF8jMvjxW1g
         EpQftz4RbiVoov8fzkaCzIQXxlAJZ5f8FiLXe1k/UZT2R0q+nUzJ+toxwlJNbhjRtEup
         OBG7x35nfGcUlCufmgPueAP8DMsCnp5JAnPSVQiH/XpPLWNDb8qsd3Oo2PTzjmyPHjBo
         o6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752006948; x=1752611748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNJgzkdVewF1sgcn6yqbMkw49jggk50uxEN/tQQWkJU=;
        b=GsKjphF+RSLrSxp2bw31lLVI7jLBUjty9aGO5ysAXV85ujlNdAzUsiPzfPiJHjw6yp
         8fexdMNLu7wU+kDpfBxZ8N1wsCbSWjAaCfEOVWwWj7rQqXQb4p3Q/yoVPDBrutRGsW9P
         y1Ae8JqH+jLwwQfGWk8nbQDWftlsdXPdNOsLB8Mw1+BoQVeS8ZAghea6VspJ7X0ldRiO
         zAzv7bJdzSrRBelFgyV4eO+79ADFPizg/PmCP7tR6iFVzizFPZ71cVigxJ/3+By4WKD7
         PFQB5BqrYQOi9xpfgWKSEzlRjPgTASN7ExDQtfJnzd2yHkd0ufEKLU1ucskJuv9s+4L4
         RZrw==
X-Forwarded-Encrypted: i=1; AJvYcCVC1Vopxf78yoFx/5Yprcb9kSXyRyGhDNWVRIMmgVlcBoF+Af7QBseVI9I21KQxIZphCOw6O+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJyYt1449WC6naY1/5ZHF3xAoRheKfw561oUPKlLeEm1xUGvK
	dq4xnh2Vh/aVlK9GXWnUzLePGB5NKxWsI04mi57vWhuharN72nfAFwRAYkr9UQxUt++7G9Z4Cu/
	sFjSdTQhuDKyHlct840vZGIgI5zIBXbVIL9kPziKu
X-Gm-Gg: ASbGnctYiZbelRP8RorT6IVSZJElvoi/+GhcTlWD7tXNS8vp+qPqToDhZUufTPxs7hA
	n0Kenz8Lj823W/NOlelIj2Buam8T9UitvoW4/3eTyKPqjHZ6L8gx+8bKkGbr7pq883M58dppYL4
	uMihH/QfFxcXRglQQV6Zb9zfl+mwz4eTcWralNXLDSWJ3ap7KP+yLD
X-Google-Smtp-Source: AGHT+IE0+XzKROgjfzp9NPOsCpjMpjlbUPmxdId2cw1c0WEj2TGxtbssrNH2wIWQT/y1bMpsmYXPh0OC8/JbSml5218=
X-Received: by 2002:a05:6a00:124f:b0:740:9c57:3907 with SMTP id
 d2e1a72fcca58-74ce668a90cmr24704823b3a.19.1752006948032; Tue, 08 Jul 2025
 13:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708164141.875402-1-will@willsroot.io> <aG10rqwjX6elG1Gx@pop-os.localdomain>
In-Reply-To: <aG10rqwjX6elG1Gx@pop-os.localdomain>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 8 Jul 2025 16:35:37 -0400
X-Gm-Features: Ac12FXw94YBZG65uYraperz0cyEMIjR3Zlx7NpXNXAIHeIHSwb0GsSm4SbgdP2M
Message-ID: <CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>
Subject: Re: This breaks netem use cases
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org, victor@mojatatu.com, 
	pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, 
	stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 3:42=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com>=
 wrote:
>
> (Cc LKML for more audience, since this clearly breaks potentially useful
> use cases)
>
> On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> > netem_enqueue's duplication prevention logic breaks when a netem
> > resides in a qdisc tree with other netems - this can lead to a
> > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > Ensure that a duplicating netem cannot exist in a tree with other
> > netems.
>
> As I already warned in your previous patchset, this breaks the following
> potentially useful use case:
>
> sudo tc qdisc add dev eth0 root handle 1: mq
> sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
>
> I don't see any logical problem of such use case, therefore we should
> consider it as valid, we can't break it.
>

I thought we are trying to provide an intermediate solution to plug an
existing hole and come up with a longer term solution.
If there are users of such a "potential setup" you show above we are
going to find out very quickly.
We are working against security people who are finding all sorts of
"potential use cases" to create CVEs.

> >
> > Previous approaches suggested in discussions in chronological order:
> >
> > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > too specific a use case to extend such a struct, though this would
> > be a resilient fix and address other previous and potential future
> > DOS bugs like the one described in loopy fun [2].
>
> The link you provid is from 8 years ago, since then the redirection
> logic has been improved. I am not sure why it helps to justify your
> refusal of this approach.
>
> I also strongly disagree with "too specific a use case to extend such
> a struct", we simply have so many use-case-specific fields within
> sk_buff->cb. For example, the tc_skb_cb->zone is very specific
> for act_ct.
>
> skb->cb is precisely designed to be use-case-specific and layer-specific.
>
> None of the above points stands.
>

I doubt you have looked at the code based on how you keep coming back
with the same points.

> >
> > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > per cpu variable. However, netem_dequeue can call enqueue on its
> > child, and the depth restriction could be bypassed if the child is a
> > netem.
> >
> > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > to handle the netem_dequeue case and track a packet's involvement
> > in duplication. This is an overly complex approach, and Jamal
> > notes that the skb cb can be overwritten to circumvent this
> > safeguard.
>
> This is not true, except qdisc_skb_cb(skb)->data, other area of
> skb->cb is preserved within Qdisc layer.
>

Your approach has issues as i pointed out. At minimum invest the time
please and look at code.
I am certain you could keep changing other code outside of netem and
fix all issues you are exposing.
We agreed this is for a short term solution and needs to be contained
on just netem, what is the point of this whole long discussion really?
We have spent over a month already..


cheers,
jamal

> Based on the above reasoning, this is clearly no way to go:
>
> NACK-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Sorry for standing firmly for the users, we simply don't break use
> cases. This is nothing personal, just a firm principle.
>
> Please let me know if there is anything else I can help you with. I am
> always ready to help (but not in a way of breaking use cases).
>
> Thanks for your understanding!

