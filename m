Return-Path: <netdev+bounces-206050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC102B0129E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A47629FD
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADFD1B0F19;
	Fri, 11 Jul 2025 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elDTEEWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D051022;
	Fri, 11 Jul 2025 05:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211170; cv=none; b=rUCdc83VcMgamlIrbMc4IqueDW753wS0GARohblcKinMdz4LuhMgs8ula30ApXCOG9Ha/1dJ9S9ElO7meE8LAGz6sHwfzKBRUrQpYxkliBiqQKUHoDef5aXsIx453duaAlHrNYIzGEBBa/q6oNofCeV2YGup0d3MqKZK/0KabHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211170; c=relaxed/simple;
	bh=ExzT0bejSjcEKYPVbRUrKqX5CPBpy8ZC50Hl/KaxFHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhCt0g8GmsocDlTjItpaSitkfcgliKy5KKF4o87VXjDokiWAp2OXFvbCo3UCA0AWnHiRmJ3Dq7vXDB7/QIrwqznd80KMQPeMZ/eo9Xc8/Kd5wpw0QtIIRqK01HzlAOc10XahCexNupknOycraBIyM93iUlkI0pvUdFs5DyYdeRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elDTEEWQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23c8f179e1bso19695465ad.1;
        Thu, 10 Jul 2025 22:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752211168; x=1752815968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Ekbe5FEWshdukQ3fwsHTQK/ZvTeyG0cxRu5+RyWZFU=;
        b=elDTEEWQvv0li8DKpV88UdGvjMGC30gfcdEhzbMg37QpwOIKY2l9UM1Q8r7jNPBiWj
         D+JCcPhMHnIVSaFCamHWEvUaWr1MJcG5iRjw7EgqisGU4JrbjAJT13F6ZY96OAapvS+n
         9qwIkNovypVEw9/HEzl2/uW2tkF5wuvPyCIEw8Ehyg6I1PJwb/LEzjO085bNtYlIJCjv
         6H3SDzrOVbtejiw5TPHNshRi1z30HBT48lnWHPbUOd97/PkwvA0r1HmsCMhf7DQva5Zh
         WER/wOLJ92OxgY356MQQA1y/NOmPGGuKXYLczd0zbX+AwsZQJHrLhgnjW/Q9P2tnnFTL
         lNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211168; x=1752815968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ekbe5FEWshdukQ3fwsHTQK/ZvTeyG0cxRu5+RyWZFU=;
        b=p2qUrlZ8sezk01/Gcxmx2Tr9QJ3qO9EzVHyZajB1sLaivOZ3Enp0S5UlLSK0M6rcw+
         zzyPIqUnXI8cPd+zpPbJQtb+qS40dju+kv3hhN8n75+luJol7lK/CJdvh8E6wMo+OvvD
         uPUAyOUn+U7aNa4ERFXQO0lPE5LC+qcoVHVP+JdtKvmHX6vtK6q1hZQ4JXEcE+nuiVVm
         GGwbROoUIME3g6ZzY70NOOl6MVO0phzX2loWX9+hFDqkfcZ955KKbiaeijv3N4PjuLKM
         I0m4fs1QAWamyMKeTZK3JZJ+Zlai/LA28echVV+3ESSjpc4frGJH4uZyDSrm6apftoA1
         FqwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW89v6kKRb6n8nJKdMb1YadGa/HFzl9rrua+HBJsW+tRX1qFlFfHYOPjn2Q4VUkZoR8yi5uMl8CHU2pm1w=@vger.kernel.org, AJvYcCXZogLsSnrXh5vZz69KlNmqd14o+7Li736bkcXK/i7U6a6lLZR9lnbXN0OhCloE5LCvzsFZjmdt@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3KUmCODjAPDF0LEBj5h311dgAt27qd3ePPx3UdsN2Af3OY+Z
	O1T3V5WkXjJp3MAvRi+0vmb+yfN8TWtVZuV1jTM8QfI15H2hOl0nSi5y
X-Gm-Gg: ASbGncvWNPXQ9/BIOxIqyn86KQDNBvurJCeqJ94GBQyFjxig5Ji0uu4TawcYV4Em7mt
	WZdjyEnXM4RIv6i/PvPGgKw0xauSfcO4Hdthn9U1XwuIzJwlk5SrD+cyiqtfa302JyIObbrpvA1
	iPy7iGR1CyMIvgzObd33M8t3W2NYkJ8b/zr1+mT4BC9en4/X/KOPNNLT66Bsz/9mUaQI0EDARAB
	+hJOjXSY4Xv+8/enaccGUTeGrWXOnhdt8p9Khjup9mgxbuvFRXrOqL6wiM1Kuj5PFgDLbQwvcwn
	xv8w7EhrI3QMakyrWFG644aGOoInRTp2eKY9QMxRf2oZ9CyOj4+POQfqaUbbRkUQHWJmoCRjBZb
	FztBgaMJtZCoNN9aq2EWfcQufCaIiP7q4Or8BOw==
X-Google-Smtp-Source: AGHT+IGbEAcPvJEE/FhJY+qB8gAdP9EGmHxP+DAAY2p1AVPh/SE1+ZUDO1lCXZ38d/HS99fVtntiuQ==
X-Received: by 2002:a17:902:d509:b0:234:c549:da10 with SMTP id d9443c01a7336-23dee2844damr27992985ad.47.1752211168048;
        Thu, 10 Jul 2025 22:19:28 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:86b6:8b81:3098:418])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad948sm41688755ad.61.2025.07.10.22.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 22:19:27 -0700 (PDT)
Date: Thu, 10 Jul 2025 22:19:26 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: This breaks netem use cases
Message-ID: <aHCe3nznEtF/1MHq@pop-os.localdomain>
References: <20250708164141.875402-1-will@willsroot.io>
 <aG10rqwjX6elG1Gx@pop-os.localdomain>
 <CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>
 <aG2OUoDD2m5MqdSz@pop-os.localdomain>
 <CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmuL7-pOqQZMA6Y0WW_zDzpbyRsw0HRHzn0RV=An9gsRw@mail.gmail.com>

On Tue, Jul 08, 2025 at 06:26:28PM -0400, Jamal Hadi Salim wrote:
> On Tue, Jul 8, 2025 at 5:32 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > (Cc Linus Torvalds)
> >
> > On Tue, Jul 08, 2025 at 04:35:37PM -0400, Jamal Hadi Salim wrote:
> > > On Tue, Jul 8, 2025 at 3:42 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > >
> > > > (Cc LKML for more audience, since this clearly breaks potentially useful
> > > > use cases)
> > > >
> > > > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> > > > > netem_enqueue's duplication prevention logic breaks when a netem
> > > > > resides in a qdisc tree with other netems - this can lead to a
> > > > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > > > Ensure that a duplicating netem cannot exist in a tree with other
> > > > > netems.
> > > >
> > > > As I already warned in your previous patchset, this breaks the following
> > > > potentially useful use case:
> > > >
> > > > sudo tc qdisc add dev eth0 root handle 1: mq
> > > > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> > > > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> > > >
> > > > I don't see any logical problem of such use case, therefore we should
> > > > consider it as valid, we can't break it.
> > > >
> > >
> > > I thought we are trying to provide an intermediate solution to plug an
> > > existing hole and come up with a longer term solution.
> >
> > Breaking valid use cases even for a short period is still no way to go.
> > Sorry, Jamal. Since I can't convince you, please ask Linus.
> >
> > Also, I don't see you have proposed any long term solution. If you
> > really have one, please state it clearly and provide a clear timeline to
> > users.
> >
> 
> I explained my approach a few times: We need to come up with a long
> term solution that looks at the sanity of hierarchies.

I interpret as you have no long term solution, so without any long term
solution, how do you convince users you will unbreak them after breaking
them? This looks more and more concerning.


> Equivalent to init/change()
> Today we only look at netlink requests for a specific qdisc. The new
> approach (possibly an ops) will also look at the sanity of configs in
> relation to hierarchies.
> You can work on it or come with an alternative proposal.

You misunderstood this. It is never about me, mentioning me is not even
relevant. I defend users, please think for users, not me (or youself).

If you think from users' perspective, you wouldn't even suggest breaking
any of their use cases for any time. All what you said here is from your
own perspective, surely you understand all the TC details, but users
don't.

> That is not the scope of this discussion though
> 
> > > If there are users of such a "potential setup" you show above we are
> > > going to find out very quickly.
> >
> > Please read the above specific example. It is more than just valid, it
> > is very reasonable, installing netem for each queue is the right way of
> > using netem duplication to avoid the global root spinlock in a multiqueue
> > setup.
> >
> 
> In all my years working on tc I have never seen _anyone_ using
> duplication where netem is _not the root qdisc_. And i have done a lot
> of "support" in this area.
> You can craft any example you want but it needs to be practical - I
> dont see the practicality in your example.

The example I provide is real and practical, in fact, it is _the only_
reasonable way to use netem duplication directly on multiqueue NIC.

I bet you don't have another way (unless you don't care about the global
spinlock) in such setup.


> Just because we allow arbitrary crafting of hierarchies doesnt mean
> they are correct.

Can we let users decide? Why do we have the priviledge to decide
everything for users? Users are usually more correct us, this is why so
many bugs actually became features, it is just simply not up to us.

We serve users, not vice versa, apparently. Let's be humble.

> The choice is between complicating things to fix a "potential" corner
> use case vs simplicity (especially of a short term approach that is
> intended to be obsoleted in the long term).

I don't see any simplicity from your patch, it is not maintainable at
all (I already explained why and suggested a better way). 40-LOC vs
4+/4-,  you call the 40LOC simplicity?

And this case is not corner, nor potential, it is valid and reasonable.
Downplaying use cases only hurts users.

> 
> 
> > Breaking users and letting them complain is not a good strategy either.
> >
> > On the other hand, thanks for acknowledging it breaks users, which
> > confirms my point.
> >
> > I will wait for Linus' response.
> >
> > > We are working against security people who are finding all sorts of
> > > "potential use cases" to create CVEs.
> >
> > I seriouly doubt the urgency of those CVE's, because none of them can be
> > triggered without root. Please don't get me wrong, I already fixed many of
> > them, but I believe they can wait, false urgency does not help anything.
> >
> 
> All tc rules require root including your example  - afaik, bounties
> are being given for unprivileged user namespaces

Sure, many CVE's have bounties. This does not mean all of them are
urgent. They are important, but just not urgent. Creating false urgency
is harmful for decision making.

> > >
> > > > >
> > > > > Previous approaches suggested in discussions in chronological order:
> > > > >
> > > > > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > > > > too specific a use case to extend such a struct, though this would
> > > > > be a resilient fix and address other previous and potential future
> > > > > DOS bugs like the one described in loopy fun [2].
> > > >
> > > > The link you provid is from 8 years ago, since then the redirection
> > > > logic has been improved. I am not sure why it helps to justify your
> > > > refusal of this approach.
> > > >
> > > > I also strongly disagree with "too specific a use case to extend such
> > > > a struct", we simply have so many use-case-specific fields within
> > > > sk_buff->cb. For example, the tc_skb_cb->zone is very specific
> > > > for act_ct.
> > > >
> > > > skb->cb is precisely designed to be use-case-specific and layer-specific.
> > > >
> > > > None of the above points stands.
> > > >
> > >
> > > I doubt you have looked at the code based on how you keep coming back
> > > with the same points.
> >
> > Please avoid personal attacks. It helps nothing to your argument here,
> > in fact, it will only weaken your arguments.
> >
> 
> How is this a personal attack? You posted a patch that breaks things further.
> I pointed it to you _multiple times_. You still posted it as a solution!

Maybe you are not helping at all? You kept mentioning "issues" without
even explaining what issues are.

Here, you keep mentioning I didn't look at the code base without saying
anything helpful. The fact is I looked at all the qdisc_skb_cb and
tc_skb_cb use cases, I tried to place a new field/bit in at least 3
different locations with multiple failures.

Maybe you need to be helpful and respectful?

Thanks.

