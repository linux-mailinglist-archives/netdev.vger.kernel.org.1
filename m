Return-Path: <netdev+bounces-205961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E8AB00EE8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0591F1CA7F73
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D7A242D77;
	Thu, 10 Jul 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Y7E979Qo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DB62980DB
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187504; cv=none; b=VYh1khzEU5UGQELe7Ct7TPFMUQ/ZUpd2TTxmAGi01F9xVOgbbKsd63CCVX8RBNao9jC3Rtn5y1qUbPbVb0KJ27wefPURxS/lee6jXbng6+YbvMs6hCYHNxTVGOVGE7xBC9tSTtpqbz6IkeJgJ+ZCtkqyFsPWqxk4jw+PhPLPUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187504; c=relaxed/simple;
	bh=Ore9hSjB3VYYoGjxl/UMj4pm2gzutzgOVEwT7AcWxpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3KdaIW/efqVBuuZu50vCWAAENISfkRMLC0Ml+zWBbGEglqruVQan6wvyt31cLqfikLo2IrHG/CnmkKRkXuFLPttHYtF8oWwpccyXZb+uwYlkZ1owy7fisdM+b7R1pBiEp3WWO+lgR5YXC3XXyoQdHZpGQ/Yw8CYiFACMThsnFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Y7E979Qo; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-315cd33fa79so1194503a91.3
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752187503; x=1752792303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xB5SrrEtDI48EpA39wusl5bCMI7x5UNVDdGJswsj15I=;
        b=Y7E979QoCjSH8/p0Uh0CeMYtspynaZUJGdBHhw6O8vjF+TKTDO1ivM5CkhD+4agojd
         bPnQCNh15kXiKjGVsMGah5OUhVFxXa0xaySghAKBGopb3ZfSJmlZ9ibrTzT9Ylxl/eQx
         Q6R8HaEJ21H1wpLfnTr87EMC3Fj2hxzTDIqPDLSW3STz5lZ88dZykHK2cY6nYBp9rEaI
         xaMmB0cMM+qKuKXXKEewYOkG/moE7HipD4LuV11zOsOe/KNe04HXfe7/c93esDucNamN
         2AXV2mwQt/4GELyYkugnmhdLqqA7xpQbf++b3j3mJbHBEoXPxVqB5MafgK0YkPbkNrBO
         r5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187503; x=1752792303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xB5SrrEtDI48EpA39wusl5bCMI7x5UNVDdGJswsj15I=;
        b=FK1NlZE5HJH7ne1gOFAmcgavKatG359cKjV+yZrOR625dE6mEy35U2ftWk13UUnmDz
         F+t01QNwDN7NpTvLrWtHJSeuDsBLtHZ9u3F12BoFJ/LbifuAq7Td7IVxFkCJqLRwsSKn
         GgfMkj0Fc4lOKUfj+LL991YOHMqf4O28GSAEJHos4p6MWbdAdplloptiVCCtvKl0yuRI
         L6NGYsGcCl0KPHd3h9qEDe579wTDYX6GpVVJFa2KUO7YmObTkPZP/xGYTM/0XVq57Np1
         J66LcVhETKbdF5OsCVSOkUIMKDsQZL6WhM0eibUS3nR3emSVBH88y0HjKr76gAtnmaSA
         GBsw==
X-Forwarded-Encrypted: i=1; AJvYcCUKqiDx5GdU0C1BZIR/vgc5REzSsGODiaDv18Qy+efhb5/3JmiYDI1axWwo6mawhDSEXjV+YoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSkFvYs+y1Uy3zzfpPPnhjqt32/EGtoNyk5rarlrCy0G0TDy4
	nupS6/bff5Spe26tr5CfyaIHNFShVaUwuSUrNqVxPvJBo4uP/chu2OJSjVSM/mceYg==
X-Gm-Gg: ASbGncsMMX+nCa6wY1Kn2CL+WDqIPqtdDvSZL1hQEiNdBFeWq0fb8Ra/6EiGSk/HLiq
	cm0pNp01CTSN4Bl3yQSSVjd3kvIcvK8K7FmOszuT/jklPuk/Y/mp7Z0z3Ljv6M2Uea29sQ4dh8C
	i5OUWK4rZrCji+9kNcZAypHvXoI4Z8ZvI0RWc0Gno5X7FOs30psFnXq/SQFgaGWeXQHJt19z5TS
	6RU4h6jj2lSWXUBdG+mNymhJf9xILlpn2HB18+Xlg2ZHm4nKXvx+wOCcekEPTkxtX6X0gXrzN/S
	Hhf/JHaVM1ESPj564be+Y2L8ZZ/+RW8LBdlovgsw1EOycYGChucIq0IeWRtQbZ+/z1EwrTQe
X-Google-Smtp-Source: AGHT+IHq9ksF9uC3B9jBC6qqYz11U6SIkFmuJ1BG3UqK90kbsrWHtN/PLJsAE4QN8fMdi0uGvUFHVw==
X-Received: by 2002:a17:90b:2d88:b0:311:b3e7:fb3c with SMTP id 98e67ed59e1d1-31c50e4664bmr16654a91.31.1752187502714;
        Thu, 10 Jul 2025 15:45:02 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300689aasm6282850a91.13.2025.07.10.15.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:45:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:45:00 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHBCbIJgUnTNgRpE@xps>
References: <aGwMBj5BBRuITOlA@pop-os.localdomain>
 <20250709180622.757423-1-xmei5@asu.edu>
 <20250709131920.7ce33c83@kernel.org>
 <aG7iCRECnB3VdT_2@xps>
 <aHAuLCWpBNC5hUwV@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHAuLCWpBNC5hUwV@pop-os.localdomain>

On Thu, Jul 10, 2025 at 02:18:36PM -0700, Cong Wang wrote:
> On Wed, Jul 09, 2025 at 02:41:29PM -0700, Xiang Mei wrote:
> > On Wed, Jul 09, 2025 at 01:19:20PM -0700, Jakub Kicinski wrote:
> > > On Wed,  9 Jul 2025 11:06:22 -0700 Xiang Mei wrote:
> > > > Reported-by: Xiang Mei <xmei5@asu.edu>
> > > > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > > > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > > 
> > > Reported-by is for cases where the bug is reported by someone else than
> > 
> > This bug's fixing is a little special since I am both the person who reported 
> > it and the patch author. I may need a "Reported-by" tag mentioning me since I 
> > exploited this bug in Google's bug bounty program (kerneCTF) and they will 
> > verify the Reported-by tag to make sure I am the person found the bug.
> 
> Like others explained, "Reported-by" is for giving credits to the
> reporter. Since you are both the author and reporter in this case, you already
> have all the credits. They should understand this and credit you
> properly. (Please do let us know if they don't, I am happy to help.)
> 
> Thanks for keeping updating your patch!

Thank you, Jakub, and Willy for for the detailed explanations and patience.
I'll let my future bug reports smoother.

Cheers!

