Return-Path: <netdev+bounces-130952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292F98C351
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19D271F22593
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845DB1CB335;
	Tue,  1 Oct 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tLiDJ2lg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF211C9EBF
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799725; cv=none; b=Kgv8vDC032xi849K+IWXZNUmjw+rPFiWCqZL33cwcH/nq69gu1bgiXL6wgDHzhVjxkhPcjfKKzqMhZypUHiRWSUMoF5D9c5Y81QC44LpxhZj/KJmQuJTemyUm1TP8bhjcxgTsDcU/QmAhJYVFGSCvfhGZsquOsZfwF9zbWAFIf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799725; c=relaxed/simple;
	bh=gcCzIJZeIGcl46n0fjBqKeojKcYmVfWPrJBsCMkQDSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ws4gQ+04tfejNlLLQ3C8A+1UUZw2pvA6jZKVJuPsPEkCD5te5W00lRyxZ06nVM5Rq48VsE7nvK+/n5/nwFrZ/xwuW0Clh5PUmENEStICcaD8IbpduZXoYHqzS31ue2NGaXwdp4ey2A8GOl2mSUyxi/yjQwe2iv4UZsySIVTV21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tLiDJ2lg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71781f42f75so5370453b3a.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727799723; x=1728404523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6534ybpju9tDRdwijk3ltMgmd/6M6CgfXK45W6fp1TE=;
        b=tLiDJ2lgKq9AtFJSubmzDpsuMGkkF7a4dhyw6YrlxWu2YGOhApFI6qtwfw4O8w2JPR
         R+UslGUj2aeGf83SlWHlTD/ywKK++ZRKhWBt6kaK1SwhqZDAjiOxQNnBbP65zHGuUftu
         vtNrW9/aDzknipI8dbLpZot+YVdi3C9XVQF/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727799723; x=1728404523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6534ybpju9tDRdwijk3ltMgmd/6M6CgfXK45W6fp1TE=;
        b=kKTfm51OMInN2GiR4THJQK7WHVJOnekquLS3B1HpO2RAPZuILKWBj4LxNxK5HWhpW3
         Ld2J4yEYKgcAvx814k8ecjG7UQps/9NARM3FRl2sxaJsxjW40aflPkDolLd7GjRQo+yg
         aAVhIhfu8XSj1viKaeAByQjUI2a87zDPkDdgYEiJorpuJpPsMLF9+dnTLCaXfKQAznSq
         YoOk+trjFBErEnnwAClU2p8+vUsX8vkhzeirutV00fpZljhuqP/lE2g157PKcGNkGo+2
         6AEjPoq6IT3fFyYk/HSg2zt7uCQ//ZkofuJu3xUgsXrbsrDfCTphuXgYwePH/Ca8t1Dx
         zkfg==
X-Gm-Message-State: AOJu0YzLMCnLKKk64irgqaCaLWdUFGwZPVFn9tcz1iuUnga6guj1Nyjv
	FBA3ruZkpwNTciLaJdwoZHO4QKDeA170qVwN2lfrb3I+G4X3SOwxar9UcrCGvrI=
X-Google-Smtp-Source: AGHT+IGbIXhLey/YycH7vBeplAcObPrFchkQi7j5m2H+tlso+i2zeMqCaMByDHr8IXyYtQI2JYHGWg==
X-Received: by 2002:a05:6a00:198b:b0:717:950e:b589 with SMTP id d2e1a72fcca58-71dc5d429f1mr348713b3a.19.1727799723153;
        Tue, 01 Oct 2024 09:22:03 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536c0fsm8249488b3a.199.2024.10.01.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:22:02 -0700 (PDT)
Date: Tue, 1 Oct 2024 09:21:59 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <Zvwhp94ZIf665N6A@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
 <eb828dd9f65847a49eb64763740c84ff@amazon.com>
 <ZvwHC6VLihXevnPo@LQ3V64L9R2>
 <26bda21325814a8cb11f997b80bf5262@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26bda21325814a8cb11f997b80bf5262@amazon.com>

On Tue, Oct 01, 2024 at 03:50:24PM +0000, Arinzon, David wrote:

[...]

> > >
> > > Thank you for uploading this patch.
> > 
> > Can you please let me know (explicitly) if you want me to send a second
> > revision (when net-next allows for it) to remove the 'struct napi_struct' and
> > add a comment as described above?
> 
> Yes, I would appreciate that.
> I guess the `struct napi_struct` is OK, this way both functions will look the same.
> Regarding the comment, yes please, something like /* This API is supported for non-XDP queues only */ in both places.
> I also added a small request to preserve reverse christmas tree order on patch 1/2 in the series.

Thanks for mentioning the nit about reverse christmas tree order; I
missed that.

I will:
  - Fix the ordering of the variables in 1/2
  - Add 2 comments in 2/2

I'll have to wait the ~48hr timeout before I can post the v2, but
I'll be sure to CC you on the next revision.

> Thank you again for the patches in the driver.

No worries, thanks for the review.

BTW: Since neither of the changes you've asked me to make are
functional changes, would you mind testing the driver changes on
your side just to make sure? I tested them myself on an ec2 instance
with an ENA driver, but I am not an expert on ENA :)

- Joe

