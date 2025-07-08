Return-Path: <netdev+bounces-205152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63FFAFD9FE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7394C7B3D10
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37E321C167;
	Tue,  8 Jul 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgyhviLD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4431423D2AF;
	Tue,  8 Jul 2025 21:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010332; cv=none; b=HnFDWGlnVH7pj1P5/h/TddhMKUam5inwZvUHHe1HVKwWgg+J7IMojz1nMmJ8rssonhU7AGXkkTBWr2bib1ux5RtiVWxB3PBBgy9slpjQtyE/yW5SA43KBCqHWZaxHnoROv8g9govFdMhtQLFS0E5A850kZpnFTFFTnZ9Pmnjc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010332; c=relaxed/simple;
	bh=Pw2tangHLjfnesfQFP7eKNC/pKemmrklHF/DkQvRmgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+uRgx1y+vMThH09oJFrc/22JgX37Wc364erDJ7JuEIefnTIaY/vUD08uToIzWmGYWcJQ/ssv9JKYEB4ph62l6PMmhx2Ho0Nry+OeMhFfWMi9rfetg4nXVB4to88LfqKVaol4MPJ4kaX0M91sO2GpEFuCfiFoIKMUCaUL1xFCEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgyhviLD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3344507b3a.2;
        Tue, 08 Jul 2025 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010330; x=1752615130; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnIHAWjCQETnK+vTDXiOL7mPc4/NFBBMGyX5aZiWfnY=;
        b=cgyhviLD3bjWFTEf7JqusVZJPOPWxWtQUiPfsGlDejIpppJSBQRVjYgCSL6vc9VY5r
         ru/Cp5P7EAwfkQU3MEh0xIkPve4bOHvsSoodXplmQv3hfc/uVYvJts4H9Bo20QZPQp4U
         i1ySVPmvsrEY285dbjdD3J2I6w8+7JSe04OD+oGl8qLHwXryPIWNna65fIZCstInS2OA
         7Kw3dWrsP8XOGEDQjGDjkX9w8TtKEpuNdLEVlC4xrfMPP7JEh61lmrMFFNa9EfHGdoNs
         PJA6sycpkqYNM6p1/VIPWuiMSxfWqoLpWjBQIqeJUcExaxIAKjrYUHfbarrEuhzYOgMo
         uTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010330; x=1752615130;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnIHAWjCQETnK+vTDXiOL7mPc4/NFBBMGyX5aZiWfnY=;
        b=WwSwyQimiCEI7HVTNf8K81FiyaBJ90UrdRRhSl7F+aeWSO2sLI/y/4/CLNuc/6ZPab
         So/VIDq6dOLii/hRJJMuJDgl2KCdcYA/EURrukQPOSQUfjkAtr9F9KfZqD57noKLDeZU
         G0oMnDeKnfsnGpeNlXtHQxztfpxcKi5HJNXlymI4rcKv1cB0qV+5RkgQZ7uPbUmwztXE
         xaRbtrFPF9J0EceecSOlMNDgTOL+7ZZPeGPcXj8plgvjzZFrHBbyuDkZR3vyokBnA03v
         nd6JrUR5hGsnWFEZkYLghQTw8djjUKFklIp6/ss8i+XR/fqUj4q6GlDthkJb1kPaZVLn
         W91g==
X-Forwarded-Encrypted: i=1; AJvYcCU6g0TTE0+oskwee6N9VKbHvYXXJUDsFyXVTjfTrh8tmWIgm+whJrRi0G5/vwwtO4mzbO7M/Uu4KAJ/g7g=@vger.kernel.org, AJvYcCUfQWqxfx4yL+srur3iF6T0pwoK3ZYwg62hPcMWQlSc76JUsBYRS40DgHRFnrVmN2iGv7MWyFkk@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDVhSstiTPYyz8T3XXiWFv9fwx+YNA5m5DWsDspQmF7aAtu7y
	RNALBz1PAFBEpEm0rm5sEen0oSBbmik1i12SNPTGDt6QFwZrwucoX815
X-Gm-Gg: ASbGnctu5jwe70zp0+x0e4ZILYNxXOHliiEBFV7jpiYLyD8QrNXbyso/IGqRNw6NyJG
	xLCtqVP13ZPLPv5ROndRslWSR4StVp6U2zbO2Iwa2/oM9xUZe62DVjaxPAsRX4O1qyFdpms7n6y
	grfV6hlRFOVLX8bKr4cX2POffz13Q2G+x9FV1cU8Z59Ivadsk/00ctRZQcHrAD4bxbC07ZhEmFJ
	gW+aO5ABPw89kWNiNvGGD96EHWzNP09I3+pwX2Si6q6CcegR4iIGkxEMntJ6jlA/S55PcBpVdHZ
	BZRGGBXGXpzwmTEJfiXAE+nGQ4erAcsoEs8iAuKm/1USEJRm0sY1GYIBDlJM6YkORw==
X-Google-Smtp-Source: AGHT+IH8aKfp83IIEeO5mbMYz+adwoxxvkgbVv/nQxIP4XshTEm/+Itqydsx+GqaCUQXCGAk75Bj7Q==
X-Received: by 2002:a05:6a00:139c:b0:749:456:4082 with SMTP id d2e1a72fcca58-74ea63e6566mr242718b3a.1.1752010324394;
        Tue, 08 Jul 2025 14:32:04 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce359eeddsm12635717b3a.7.2025.07.08.14.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:32:03 -0700 (PDT)
Date: Tue, 8 Jul 2025 14:32:02 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: This breaks netem use cases
Message-ID: <aG2OUoDD2m5MqdSz@pop-os.localdomain>
References: <20250708164141.875402-1-will@willsroot.io>
 <aG10rqwjX6elG1Gx@pop-os.localdomain>
 <CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmP5SBzhoKGGxfdkfvMEZ0nFCiKNJ8hBa4L-0WTCqC5Ww@mail.gmail.com>

(Cc Linus Torvalds)

On Tue, Jul 08, 2025 at 04:35:37PM -0400, Jamal Hadi Salim wrote:
> On Tue, Jul 8, 2025 at 3:42 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > (Cc LKML for more audience, since this clearly breaks potentially useful
> > use cases)
> >
> > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> > > netem_enqueue's duplication prevention logic breaks when a netem
> > > resides in a qdisc tree with other netems - this can lead to a
> > > soft lockup and OOM loop in netem_dequeue, as seen in [1].
> > > Ensure that a duplicating netem cannot exist in a tree with other
> > > netems.
> >
> > As I already warned in your previous patchset, this breaks the following
> > potentially useful use case:
> >
> > sudo tc qdisc add dev eth0 root handle 1: mq
> > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> >
> > I don't see any logical problem of such use case, therefore we should
> > consider it as valid, we can't break it.
> >
> 
> I thought we are trying to provide an intermediate solution to plug an
> existing hole and come up with a longer term solution.

Breaking valid use cases even for a short period is still no way to go.
Sorry, Jamal. Since I can't convince you, please ask Linus.

Also, I don't see you have proposed any long term solution. If you
really have one, please state it clearly and provide a clear timeline to
users.

> If there are users of such a "potential setup" you show above we are
> going to find out very quickly.

Please read the above specific example. It is more than just valid, it
is very reasonable, installing netem for each queue is the right way of
using netem duplication to avoid the global root spinlock in a multiqueue
setup.

Breaking users and letting them complain is not a good strategy either.

On the other hand, thanks for acknowledging it breaks users, which
confirms my point.

I will wait for Linus' response.

> We are working against security people who are finding all sorts of
> "potential use cases" to create CVEs.

I seriouly doubt the urgency of those CVE's, because none of them can be
triggered without root. Please don't get me wrong, I already fixed many of
them, but I believe they can wait, false urgency does not help anything.

> 
> > >
> > > Previous approaches suggested in discussions in chronological order:
> > >
> > > 1) Track duplication status or ttl in the sk_buff struct. Considered
> > > too specific a use case to extend such a struct, though this would
> > > be a resilient fix and address other previous and potential future
> > > DOS bugs like the one described in loopy fun [2].
> >
> > The link you provid is from 8 years ago, since then the redirection
> > logic has been improved. I am not sure why it helps to justify your
> > refusal of this approach.
> >
> > I also strongly disagree with "too specific a use case to extend such
> > a struct", we simply have so many use-case-specific fields within
> > sk_buff->cb. For example, the tc_skb_cb->zone is very specific
> > for act_ct.
> >
> > skb->cb is precisely designed to be use-case-specific and layer-specific.
> >
> > None of the above points stands.
> >
> 
> I doubt you have looked at the code based on how you keep coming back
> with the same points.

Please avoid personal attacks. It helps nothing to your argument here,
in fact, it will only weaken your arguments.

> > >
> > > 2) Restrict netem_enqueue recursion depth like in act_mirred with a
> > > per cpu variable. However, netem_dequeue can call enqueue on its
> > > child, and the depth restriction could be bypassed if the child is a
> > > netem.
> > >
> > > 3) Use the same approach as in 2, but add metadata in netem_skb_cb
> > > to handle the netem_dequeue case and track a packet's involvement
> > > in duplication. This is an overly complex approach, and Jamal
> > > notes that the skb cb can be overwritten to circumvent this
> > > safeguard.
> >
> > This is not true, except qdisc_skb_cb(skb)->data, other area of
> > skb->cb is preserved within Qdisc layer.
> >
> 
> Your approach has issues as i pointed out. At minimum invest the time
> please and look at code.

Sure, no one's patch is perfect. I am open to improve any of my patch.
First, let's discard this user-breaking patch for disatractions and
start focusing other solutions (not necessarily mine).

If it could help you, I can set the author to be you. I have no interest
to take any credit out of here, the reason why I sent out a patch is only
because you asked me to help.

> I am certain you could keep changing other code outside of netem and
> fix all issues you are exposing.
> We agreed this is for a short term solution and needs to be contained

I never agreed with you on breaking users, to me it is out of table for
discussion. Just to clarify.

> on just netem, what is the point of this whole long discussion really?

To defend users, obviously.

> We have spent over a month already..

Sorry to hear that, I think you are going to a wrong direction. The
earlier you switch to a right direction, the sooner we will have a right
solution without breaking any users.

Once again, please let me know how I specifically can help you out of
this situation. I am here to solve problems, not to bring one.

(If you need a video call for help, my calendar is open.)

Thanks for your understanding!

