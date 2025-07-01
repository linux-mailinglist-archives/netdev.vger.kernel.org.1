Return-Path: <netdev+bounces-203016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0910AF01E8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 19:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A965A4845D8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 17:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9432A27E048;
	Tue,  1 Jul 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsfdvi17"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E93596B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751391112; cv=none; b=Ab4E7Vq/ajQKJCpcpOntVkZdDrfcPbvC8eMVP3a3vm6ymhBlo3RAs1zvWe8DriqZX7BKjlshONPF52ThA9GnTHexpxX+BENZt5UZsDxxNPmyGFF4B9wM29MYz8QLyruakdu71R4/P/cjbRGoeatX+tPvPGuUirKffLRNCPj4jco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751391112; c=relaxed/simple;
	bh=z0qJAJTccedJWDZOLNOkB8VrEYStiQz9BDDmJ4L0HjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JaQXX7IjwH3P2+pF0iKyjcWsmhjS3JdttM5+0v8B5K0bQm65AgnaI2aKDV4MyJ8QDi8UC6bnDvNMpnhlFKK0eUGsD5gPDSPu7UBTSd/exHcLvgfRctHkCyrgtxJjO80Ucgu4GtH4mSY5nfe5akhHcz5RAlORhL9Jr3PjKK3KUAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsfdvi17; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7426c44e014so6129867b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 10:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751391110; x=1751995910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SqvOXOFTXTuq0r/rHEnhPBaD3PNsmutkD1khMXV5y5g=;
        b=Jsfdvi17trY0iO+/VsZ+YLyqOqkHD35IvbzbX+OBE5CiPQkD9FKLdYSSaz/HxBjdC+
         aU3YgKCGY4fMJUxw9AxCcJINty5j2ZGlGNNIS65NjufMmsAdCcthWunScGnSEfBFVexg
         Lm6gfvfape0EcG+kJlFulYDGN4iyEkMAAVKqTmoQOZ+8+xGYApjI1oeqJvJo4qpphCVQ
         SiE/FGxw3XmsG5StFqmDMm6WxPzIVsxfLBk0tidrFfVa8i8QBTR5uJD++P8Dci2uJMEf
         z3bhOGkatV6/dkJrYCW1xOTxWTP1eDeJBUjvXiMhFTlzq6xG+0EVbEe0D+6i1s2/gjNi
         YS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751391110; x=1751995910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqvOXOFTXTuq0r/rHEnhPBaD3PNsmutkD1khMXV5y5g=;
        b=F3i8zcQEkY8viJzR2eSDAKKfCnUs786799K+CAoGgNwqpcA3BTszXsf9oRGvEDFA+L
         QeTw8uz/uLKaa2NksWxwjsG8Ex1sytMNe6B38hu3+1bcTgx12qTDNfKucwlhpX/WomDe
         LNpMLgOKtyE9FifjAG8UMG+ErkQCQkcuqiuKknkQYkn+zaQK+Ae5xgO4Qqfcd7RkCs+q
         CRAO2RjZIVpT3O1KSLVMYXHQpjR3pFX6+WnvTzu9KzeVvmmQlK2AM8bFotBPimVoiQhK
         WNYdM3nVbpb8881sLCSI0dPm41mpLubHZdPhLNpMycqGpD2mOe5j2n/LTDn1GD4sm0pL
         3r/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBvID/nxh8taOlV5DnKQ4KKnQfMeiGWZEgo1km6K1iG7RgzPrSGGIJ2M5bztUvSrY14UU4rV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXUkbsin9OQu4GqQRZbjI89drF/OEXe+SUnPAXcWW4qqoRP07n
	IW/EaAUmJRbwmTSGYg0RSskExourIQDRnxfe8SdVcjKHOj9CJWjBWYCS
X-Gm-Gg: ASbGnctXbB7TlpMcBUq0w5hbT27KF7pAcJXfPoJf5gT+/QOG5VfEo9hrUA9xSdyrCiX
	o3F1BqPz3YalROUqwR/g8EcvsOQODSiVxSRw3FtH0PD+rU18iRZvcIA4j4aKJh4jfxDIM/KfUa5
	IspJW2b2/jrt+i+JS6txI3Hd37BUkozvdpfbBQh+F1nsf9+XNSuwU1GxQGv3Lh2mgwN/ZDt8cyq
	ls97X8yLh4O41c9UakICIbyu8pkv6OUonfGuf0s8FbmEhkoy1I39jWaPbV09tsyxVWWvR5yR8rO
	4AUa20DsENReA2Xctmadjf7NHu/z+RLVOJ16u9vFcoN2wd5ydq9gylEW3/wGoXpdIQ==
X-Google-Smtp-Source: AGHT+IHBwsPgHCuNhaf6rgsCLMt+1i8kNkXJuALIfREnG4x5WRot7XYcNtSh2VY9I8mVdzc18HEK1w==
X-Received: by 2002:a05:6a00:b8d:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-74af6f7eb53mr26131727b3a.18.1751391109940;
        Tue, 01 Jul 2025 10:31:49 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b25dsm11768616b3a.25.2025.07.01.10.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 10:31:49 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:31:47 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org
Subject: Re: [PATCH net v4 1/2] net/sched: Restrict conditions for adding
 duplicating netems to qdisc tree
Message-ID: <aGQbg6Qi/K4nWG+t@pop-os.localdomain>
References: <20250627061600.56522-1-will@willsroot.io>
 <aF80DNslZSX7XT3l@pop-os.localdomain>
 <sf650XmBNi0tyPjDgs_wVtj-7oFNDmX8diA3IzKTuTaZcLYNc5YZPLnAHd5eI2BDtxugv74Bv67017EAuIvfNbfB6y7Pr7IUZ2w1j6JEMrM=@willsroot.io>
 <CAM0EoMkUi470+z86ztEMAGfYcG8aYiC2e5pP0z1BHz82O4RCPg@mail.gmail.com>
 <aGGfLB+vlSELiEu3@pop-os.localdomain>
 <CAM0EoMnjS0kaNDttQtCZ+=hq9egOiRDANN+oQcMOBRnXLVjgRw@mail.gmail.com>
 <aGMSPCjbWsxmlFuO@pop-os.localdomain>
 <CAM0EoMkhASg-NVegj77+Gj+snmWog69ebHYEj3Rcj41hiUBf_A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkhASg-NVegj77+Gj+snmWog69ebHYEj3Rcj41hiUBf_A@mail.gmail.com>

On Tue, Jul 01, 2025 at 10:15:10AM -0400, Jamal Hadi Salim wrote:
> On Mon, Jun 30, 2025 at 6:39 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Mon, Jun 30, 2025 at 07:32:48AM -0400, Jamal Hadi Salim wrote:
> > > On Sun, Jun 29, 2025 at 4:16 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > >
> > > > On Sat, Jun 28, 2025 at 05:25:25PM -0400, Jamal Hadi Salim wrote:
> > > > > your approach was to overwrite the netem specific cb which is exposed
> > > > > via the cb ->data that can be overwritten for example by a trivial
> > > > > ebpf program attach to any level of the hierarchy. This specific
> > > > > variant from Cong is not accessible to ebpf but as i expressed my view
> > > > > in other email i feel it is not a good solution.
> > > > >
> > > > > https://lore.kernel.org/netdev/CAM0EoMk4dxOFoN_=3yOy+XrtU=yvjJXAw3fVTmN9=M=R=vtbxA@mail.gmail.com/
> > > >
> > > > Hi Jamal,
> > > >
> > > > I have two concerns regarding your/Will's proposal:
> > > >
> > > > 1) I am not sure whether disallowing such case is safe. From my
> > > > understanding this case is not obviously or logically wrong. So if we
> > > > disallow it, we may have a chance to break some application.
> > > >
> > >
> > > I dont intentionaly creating a loop-inside-a-loop as being correct.
> > > Stephen, is this a legit use case?
> > > Agreed that we need to be careful about some corner cases which may
> > > look crazy but are legit.
> >
> > Maybe I misunderstand your patch, to me duplicating packets in
> > parallel sub-hierarchy is not wrong, may be even useful.
> >
> 
> TBH, there's no real world value for that specific config/repro and
> worse that it causes the infinite loop.
> I also cant see a good reason to have multiple netem children that all
> loop back to root.
> If there is one, we are going to find out when the patch goes in and
> someone complains.

I tend to be conservative here since breaking potential users is not a
good practice. It takes a long time for regular users to realize this
get removed since many of them use long term stable releases rather than
the latest release.

Also, the patch using qdisc_skb_cb() looks smaller than this one,
which means it is easier to review.

> 
> > >
> > > > 2) Singling out this case looks not elegant to me.
> > >
> > > My thinking is to long term disallow all nonsense hierarchy use cases,
> > > such as this one, with some
> > > "feature bits". ATM, it's easy to catch the bad configs within a
> > > single qdisc in ->init() but currently not possible if it affects a
> > > hierarchy.
> >
> > The problem with this is it becomes harder to get a clear big picture,
> > today netem, tomorrow maybe hfsc etc.? We could end up with hiding such
> > bad-config-prevention code in different Qdisc's.
> >
> > With the approach I suggested, we have a central place (probably
> > sch_api.c) to have all the logics, nothing is hidden, easier to
> > understand and easier to introduce more bad-config-prevention code.
> >
> > I hope this makes sense to you.
> >
> 
> To me the most positive outcome from the bounty hunters is getting
> clarity that we not only need a per-qdisc validation as we do today,
> but per-hierarchy as well; however, that is a different discussion we
> can have after.
> 
> IIUC, we may be saying the same thing - a generic way to do hierarchy
> validation. I even had a patch which i didnt think was the right thing
> to do at the time. We can have that discussion.

Why not? It is not even necessarily more complex to have a generic
solution. With AI copilot, it is pretty quick. :)

FYI: I wrote the GSO segmentation patches with AI, they work well to fix
the UAF report by Mingi. I can post them at any time, just waiting for
Mingi's response to decide whether they are for -net or -net-next. I
hope this more complicated case could convince you to use AI to write
kernel code, if you still haven't.

> 
> But let's _please_ move forward with this patch, it fixes the
> outstanding issues then we can discuss the best path forward more
> calmly. The issue this patch fixes can be retrofitted into whatever
> new scheme that we agree on after (and we may have to undo all the
> backlog fixes as well).

Sure, I will send out a patch to use qdisc_skb_cb() to help everyone out
of this situation.

Thanks!

