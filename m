Return-Path: <netdev+bounces-177824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E097A71E98
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 19:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2AD3BA577
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B4324EAA8;
	Wed, 26 Mar 2025 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePdhNtZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4AA219E8F;
	Wed, 26 Mar 2025 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743014562; cv=none; b=ZEmtJI7iGwng6KpUvPNDXLsI1DDwR48IrkNnl3/l1EJ5vUr+ApVx4ytjysKDSZZ02io39dq5pVDJED6gYImydI3um9BVs3K3013d4KP12GyEeFGfEKM15wTXhpSihcSr6vInyLMlRIHnLBYPwFbrs1RvgnreWWtAdJfKvkFZySA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743014562; c=relaxed/simple;
	bh=Kw1mBjQvq/WMJg0JHXd52WG5cBZfrJfIlS4Ge5VP5+Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csdD6Iss++ureSRFMc/8t2xAOAB2T+XqQcGAyKdwIHukZbQkxFDmxwfpMWu378H+LL6+ukJK/kvwJZvoIL8cKGXuugBk3pNIegtZhAg72BIhxaMJ4LQu13Ezo6TXC0LnaITiesbttNwfy/jIy1o8SV1l0URtkDTTYdil2HWBdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePdhNtZs; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c546334bdeso16521185a.2;
        Wed, 26 Mar 2025 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743014560; x=1743619360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wchWtqlJhU/anP6uKBZ5Hv4xUmcv9yGixZXhZigZfuU=;
        b=ePdhNtZsrlSyzveOuitckHuetNBZ7Gz2+PUa7vJBkoMcaaUZlU1yXGQW+M9ca8S98U
         Ix00vwi8mu6mY2TV6n3QTumk+JgKYdakxu+jdGZAxAq8hkJsE+7BEnfevlrSU3Bea+6j
         VnVX1uBLSb3/yDVnNU+0h8Q7OhLuTBY9eJXiGsBRuV9X01gn7XdmyrY9hWa9R5vMSAZi
         hus4J/p03v9I2Ym8qSkvRtfFFJ67X05JdykzEdjkeIqgyYcolsAPSGR7/ltAaLw6D5ow
         FBFeAMEJ2QChG6fgnnwSAthjIhtv41f45JzeI+toqAWmLab91DEHTQKeUYcNo1vBeukv
         8XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743014560; x=1743619360;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wchWtqlJhU/anP6uKBZ5Hv4xUmcv9yGixZXhZigZfuU=;
        b=IxrN6d1f5tg9Arc+5Vq9FkCgNBLNiLYkxN+Mgdn6UgRNz5TcE2HhCJOSjScIpjs+Ho
         mv0d8VEUVhTB8ZoPD1APuW+9t9l4nE1vkZx+kIyZYqa3iPpq00h8hFOY4wj+V9CMqfOK
         vJpuwatFTVTl9V82SLLnc+nYh6S/zHxdvz42I7pqeKwRhjEMKoTYpSXUGnPaiBLi6Nzg
         Kc5gWFyW7CO2VsMPBpJfBpJEL7F4DjgXaoXtY/BXYR/ZuXBXAUx1aaBUIGIUr/Ny39FL
         yr8pul5H00Knw0iHdOv5dzbFulxHnnubcbEG5LS26Vncj0R4ZmRfW+GC9ezOYXqC94oe
         5mqw==
X-Forwarded-Encrypted: i=1; AJvYcCVDA25+kt/GMjJxySTGszQIiLIAKUzoSaFhgOyDa0+GI2ezI75u+k+mD1brQKrPPVn0D0BMJcbK@vger.kernel.org, AJvYcCWb/tKG0AH7rlYZqbtcPsJj8qNncMDcfEFCeRnaAvPYFZ2xQ/139lQBcGtyx6fqbCqPGstTJDmgNmXo+KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwRaWuzjWwA3zR1cq9Mzr6RPHkOXzTi26v0dAHa1MqEfNnB1b
	OKFaxuH12JgftbIrpcXOLCH3sMZMsTOiVJSWJ1TIF4J3vmc0uST2
X-Gm-Gg: ASbGncsU/Ah/xoTZJJc7iXBskgkoCMce8NrZlYQ5vbFjuzggCskhRXgKTesPRCH4B9p
	i/5Jpd1WEQoamW5qx+OsFG4T3rdbE9Boqu4mMS59w9c3owQ8XnNzA/IK9vyEzZ05N3fOplgZEW7
	CXBLFYK1jpL5ePqqyddsSRWqGE5CEm5vYjt4M7vk1Gfu2HaafMcinXXZzFjZJyeMkBsWhhs7wg2
	6L7WcKCj4Z4zH6D2YHU0+JTnpnsdp6ze4+JMut3FhnmbwKuDGDyYu+xqnk6ViSWB+4kUJ6MmNu+
	uk+yl3YIYljkEO0CrLKDK/GiIpzuxXjbF1ydEJ9wXRIiTOElDBjgsUSs4A5s6d04CD+Wph+6AK0
	YhFhQonXKDRueVCW8bRvTT4nrpp4S/wzz9Hw=
X-Google-Smtp-Source: AGHT+IF+695Q3VmjBdovzgPMaSiBZelyXGNLjhM2iA3U2XbQ8lbhJY/rxwzkBVSiAJwzsiOYMqKeDg==
X-Received: by 2002:a05:620a:4588:b0:7c5:5d83:2ea8 with SMTP id af79cd13be357-7c5eda13fe2mr98413485a.34.1743014560067;
        Wed, 26 Mar 2025 11:42:40 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b934844asm787390185a.85.2025.03.26.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:42:39 -0700 (PDT)
Message-ID: <67e44a9f.050a0220.31c403.3ad3@mx.google.com>
X-Google-Original-Message-ID: <Z-RKneOLw0d0tyeh@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 457A61200043;
	Wed, 26 Mar 2025 14:42:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 26 Mar 2025 14:42:39 -0400
X-ME-Sender: <xms:n0rkZ5w6th9uik9NjWrDUqP6zkRv9M-dmcyZs4roqpJeFzFNvX-VhA>
    <xme:n0rkZ5Q4BdH8cejE9hwl2bCS24QOqTlUNxwSa9DzygyIq0WA6Mk2zaT9pD3UwN8qH
    fFv6evF0ZYeQ8BS_g>
X-ME-Received: <xmr:n0rkZzVn3idIeBpYZjSetSMZjWaL0436FVmQZU2hzVV4AKwE0xcuH77Zzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeivdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhr
    ghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifih
    hllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggvhhesmhgvthgrrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:n0rkZ7j7KiqKxMGCI93hdCaleq8n5H7EQ_ZMlC5IUIdEtgdZ5DrnzQ>
    <xmx:n0rkZ7BBWGwgxd4o2VQwtxI6FZjXEPKWITDU07Pw2B65gwJ4ffURHw>
    <xmx:n0rkZ0K0vhsxeRCX3fKI7foQpu91wWsMaMwgPlnqXogpuJOEyov0WQ>
    <xmx:n0rkZ6CdmwFXZers6_342GY16ohWC9U7pfkvd0xsO9otkVaFFXevhA>
    <xmx:n0rkZ_ypEJeHTQupArmcAK0F_3p6CWalROzjBXNigxT4qc4xooOvvrZU>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 14:42:38 -0400 (EDT)
Date: Wed, 26 Mar 2025 11:42:37 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Waiman Long <llong@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
References: <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
 <Z-QvvzFORBDESCgP@Mac.home>
 <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
 <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>

On Wed, Mar 26, 2025 at 10:10:28AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 26, 2025 at 01:02:12PM -0400, Waiman Long wrote:
[...]
> > > > > Thinking about it more, doing it in a lockless way is probably a good
> > > > > idea.
> > > > > 
> > > > If we are using hazard pointer for synchronization, should we also take off
> > > > "_rcu" from the list iteration/insertion/deletion macros to avoid the
> > > > confusion that RCU is being used?
> > > > 
> > > We can, but we probably want to introduce a new set of API with suffix
> > > "_lockless" or something because they will still need a lockless fashion
> > > similar to RCU list iteration/insertion/deletion.
> > 
> > The lockless part is just the iteration of the list. Insertion and deletion
> > is protected by lockdep_lock().
> > 
> > The current hlist_*_rcu() macros are doing the right things for lockless use
> > case too. We can either document that RCU is not being used or have some
> > _lockless helpers that just call the _rcu equivalent.
> 
> We used to have _lockless helper, but we got rid of them.  Not necessarily
> meaning that we should not add them back in, but...  ;-)
> 

I will probably go with using *_rcu() first with some comments, if this
"hazard pointers for hash table" is a good idea in other places, we can
add *_hazptr() or pick a better name then.

Regards,
Boqun

> 							Thanx, Paul


