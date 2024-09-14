Return-Path: <netdev+bounces-128261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE58978C49
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 02:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D4E2814CF
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DD646BA;
	Sat, 14 Sep 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+by+I4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD354C8E
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726275210; cv=none; b=kf4f7yG76HuLEtXldU9k6kVsgWI+jYL+97tq19I4/L+fLR3m6Vecv/YBplQn41jbUXm9gRhMkd2ZilxiL9bquVzo5+iJdWEnPloLI7kd4QuXazSfeKIfjOwiTqOVVJ0B/Y5Bg0CSrlVuvLRxR5PcTc3MLYt+eNZ/zMYnR9r1P+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726275210; c=relaxed/simple;
	bh=5SEHn6C90YfxDgg0/azqwx/m1HdFFCrvViucL9wVxSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7+5aw5t7TC215VGaEvmj6XMn5DYtEeDSNQuZ9Ek/E3y++20bSopox6Fr98C46z411wtL9UWyYLddvVl/ix885GKSgMLVKtLbwtHj5XTH+Xx1qJ+ElJcVgHuXR5gFOYd7geoqgBxYGgoJ4I8taNr4Htrd/rVANqFecKWQbdwdj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+by+I4J; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8881850d9so2256999a91.3
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 17:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726275208; x=1726880008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gXya5W/TgWZMwzQBH0yK0R11mxbQLZ36Iap2aMKyS5g=;
        b=e+by+I4JphuKL+5KHTxKDNRKHq7tH//EqxugUJ6+lirIKbzKgjoWUxXhLB74EexexG
         K0RhiZk/NrSdfKaMvu0bipXge3qS7jmmaX96gSlnZ6csEpaTtmZGZHXNCcD8vOK4yOBl
         2MyQhV/g9R0BR/qe5wIdJeLXpIvjBus/fPm7iGSkvmZXNCInDPU4XwLWUhn6FJwqtLVG
         oFNPjpcyop/FuQZ+4Zwt9pkBmlMatnVz5bu8tDxMoCU65NyeSkoUyhIyTvsf232hzYlf
         fgm48L5xzB9143s7P3YMBD28by6FCFhT0qH1Ff7EoU61jKUK9mtkxJVU5XwXoosRWlFi
         hCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726275208; x=1726880008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXya5W/TgWZMwzQBH0yK0R11mxbQLZ36Iap2aMKyS5g=;
        b=hsU5KHrKjMUXq6UEwceNhAGjLsnxumyRchlDlOCu28fciT0pPFivlRIzpMvU4Uh0Oz
         Yfqx7ZS5mvsjmD/h5rOh8JNvWg3xMKWNQLbgGEfJHwkq44isN1OOZEkgh24AuNwtAevZ
         PMCtEHIYHc7VOhhVurJZWs25AX3cfmO4oY1GfeZNSMzW3ZGiISycOEAE6cs5bTCH5eqb
         m+nCTlWoQvNw9WnX1OQsyHh7pgINej1foBnCCcYDKllxLOHMovi0b45GRyCFExU10cFB
         0wRH7VQo9aRvR07EOA90U5pYJcb02010oXQ3OCdLPayCbAEBpSI4PJxfNeQDvvmnOTYB
         FoXg==
X-Gm-Message-State: AOJu0YzUr1jJWFcdN7n25zbzBGy2opc/PtxZ2aBuPCbwy2lMYgKYwPcJ
	ryRcR0/pxGvs12b3Lp7pVTocjRWlhr/YPRtSb8+65MvI1LNivS2u
X-Google-Smtp-Source: AGHT+IEINswoC7nfJ8LwWtowSzYDm/xYRon/V4fCEDhLWyZJvZHwDKXNJYn5oPGoUvISETBmsHBh1w==
X-Received: by 2002:a17:90a:2dc6:b0:2c9:9f50:3f9d with SMTP id 98e67ed59e1d1-2db9ffa11abmr9611069a91.5.1726275208464;
        Fri, 13 Sep 2024 17:53:28 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:97be:e4c7:7fc1:f125])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbcfd9313fsm296951a91.44.2024.09.13.17.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 17:53:28 -0700 (PDT)
Date: Fri, 13 Sep 2024 17:53:26 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
Message-ID: <ZuTehlEoyi4PPmQA@pop-os.localdomain>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>

On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
> 
> 
> On 9/12/24 8:04 AM, Cong Wang wrote:
> > From: Cong Wang <cong.wang@bytedance.com>
> > 
> > Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
> > RCU version, which are netdev_walk_all_lower_dev_rcu() and
> > netdev_next_lower_dev_rcu(). Switching to the RCU version would
> > eliminate the need for RTL lock, thus could amend the deadlock
> > complaints from syzbot. And it could also potentially speed up its
> > callers like smc_connect().
> > 
> > Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
> > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > Cc: Jan Karcher <jaka@linux.ibm.com>
> > Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> > Cc: Tony Lu <tonylu@linux.alibaba.com>
> > Cc: Wen Gu <guwen@linux.alibaba.com>
> > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> 
> 
> Haven't looked at your code yet, but the issue you fixed doesn't exist.
> The real reason is that we lacks some lockdep annotations for
> IPPROTO_SMC.

If you look at the code, it is not about sock lock annotations, it is
about RTNL lock which of course has annotations.

And you don't even need to bother sock lock annotations for this specific
case at all (I can't say any other case).

Thanks.

