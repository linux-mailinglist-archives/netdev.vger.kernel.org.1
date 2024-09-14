Return-Path: <netdev+bounces-128282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED46978D25
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 05:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C542887A8
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 03:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03214C8FE;
	Sat, 14 Sep 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3yB5Gc3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35E1754B
	for <netdev@vger.kernel.org>; Sat, 14 Sep 2024 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726284738; cv=none; b=Z2vzSgWufGfhfOVHIq7UW1zpe65JtN0FybHahATwCbW2Frb2TsdASg14+0nTfve6xrRh5l4fUujm1mQeYdPgElIrUIt+us0uR6DTEBCZv5//JGUw06cHRqHcYvVPhT/6LpExhKtunORyyZCPpL2puupnFBDyoArFQESs7ubtD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726284738; c=relaxed/simple;
	bh=6W+MLFi6eqiY8sT35jA+4WdlvrgD2U+L2KeE2nbQynw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H16HEKiP4yWhRcxlzDz560pvQbcRmhGCilsaAnNcyUbEnumfELjyvqJcvidUP0WNKCS9LmCCf2JY55xRq/mJh/ELcSPPK82UrR0JWv2/2g2bjco0jl/Hq/VzIbxy2zlEIKXr+Q9Jr5Ce06eFIWzR11Gy4Es228XmjFT+S+sCeOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3yB5Gc3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d87196ec9fso1179665a91.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 20:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726284737; x=1726889537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlWFYLM48t7KOqXSmcYwG/JubhZlg/V1eboJr8XmRhA=;
        b=Z3yB5Gc348piELAKaq3BnkD1iDqSFkypw6ndPfDzhfeWS1r4A4PHpcFHmvUAwhcfNq
         8UNfUvilFc0b39DD7Zji/St6McXL20US0c9bz7ILyy4oBchV9xB4oWztpvycCv4vA1Mq
         2b43Il5rJRAG65J8zZ5cbposR7kH8qoza3j9PKFyVeytDdrQ8LkFtNhH8b+3YRus5bRx
         UkvqKimM3GzKGuUWAdDFvZMlTe1trKJS8Z41XTSKURQpGFespZwrbhYjmyC//yFi1dnx
         ArIvwmu6VYDhzAVD78++j7k0rQaicMtfTPYxiOyce08HhDu3JXbdZWkf6bAwKmGBY11k
         F2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726284737; x=1726889537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlWFYLM48t7KOqXSmcYwG/JubhZlg/V1eboJr8XmRhA=;
        b=OR+iwcFUzG3OPwD1MqwhDac2jBgOyt22bi+rIYG+iLkX8/Hik33Fsy49ydTFEheMUi
         BoqD7huyegyOnFNX9Iii8qon7M5T/nvEYPhqCTyXt2ACPi0owEh7y4oMt7hXwkTfbLqB
         5OoOncJ4GeaBxvE4lDGZXdxDxm9+UKWIkoGdlas3HhcsmeZuX6GZiOqAuCk66ELYjIuw
         DVXdg8DwXxw5qtdElBVVbCwrLBfYPy11Tk7yzeqSef7Byg42cL/d1ht7xvFIFI7xNLY5
         m7dECDlE21xHAQmmlsSPHEdrBKWSKYc5JhnqrpDSkdKjOJ++QR4fTjwfodb03FZtxjQt
         kVeA==
X-Gm-Message-State: AOJu0Yy52GGCzhe7g1PRB1HVZltHMK7cJrEvueFxCBbd+WDQAfOReD/u
	Wwb4TAaJ+zl8yAF0L6DO35XjY65SOcVxGwb73b0A/grvPENzZad6siY+rM+K
X-Google-Smtp-Source: AGHT+IE/sh/Hjagcv5Iq4e7p5b19F7Sk/1B+g57IZ1n5oJFH+V0yHyj/U15wsnIy1oKoPJ6S4uIy1Q==
X-Received: by 2002:a17:90b:4c05:b0:2d3:cf20:80bd with SMTP id 98e67ed59e1d1-2dbb9e1cf4amr5812716a91.17.1726284736795;
        Fri, 13 Sep 2024 20:32:16 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:adf1:6893:266:7583])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9cadb0bsm2602243a91.27.2024.09.13.20.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 20:32:16 -0700 (PDT)
Date: Fri, 13 Sep 2024 20:32:15 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
	syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>
Subject: Re: [Patch net] smc: use RCU version of lower netdev searching
Message-ID: <ZuUDv8PLR4FHg+oC@pop-os.localdomain>
References: <20240912000446.1025844-1-xiyou.wangcong@gmail.com>
 <a054f2ef-c72f-4679-a123-003e0cf7839d@linux.alibaba.com>
 <ZuTehlEoyi4PPmQA@pop-os.localdomain>
 <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0842025-5e21-4755-8e60-1832e9cfe672@linux.alibaba.com>

On Sat, Sep 14, 2024 at 10:28:15AM +0800, D. Wythe wrote:
> 
> 
> On 9/14/24 8:53 AM, Cong Wang wrote:
> > On Thu, Sep 12, 2024 at 02:20:47PM +0800, D. Wythe wrote:
> > > 
> > > 
> > > On 9/12/24 8:04 AM, Cong Wang wrote:
> > > > From: Cong Wang <cong.wang@bytedance.com>
> > > > 
> > > > Both netdev_walk_all_lower_dev() and netdev_lower_get_next() have a
> > > > RCU version, which are netdev_walk_all_lower_dev_rcu() and
> > > > netdev_next_lower_dev_rcu(). Switching to the RCU version would
> > > > eliminate the need for RTL lock, thus could amend the deadlock
> > > > complaints from syzbot. And it could also potentially speed up its
> > > > callers like smc_connect().
> > > > 
> > > > Reported-by: syzbot+c75d1de73d3b8b76272f@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
> > > > Cc: Wenjia Zhang <wenjia@linux.ibm.com>
> > > > Cc: Jan Karcher <jaka@linux.ibm.com>
> > > > Cc: "D. Wythe" <alibuda@linux.alibaba.com>
> > > > Cc: Tony Lu <tonylu@linux.alibaba.com>
> > > > Cc: Wen Gu <guwen@linux.alibaba.com>
> > > > Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> > > 
> > > 
> > > Haven't looked at your code yet, but the issue you fixed doesn't exist.
> > > The real reason is that we lacks some lockdep annotations for
> > > IPPROTO_SMC.
> > 
> > If you look at the code, it is not about sock lock annotations, it is
> > about RTNL lock which of course has annotations.
> > 
> 
> If so, please explain the deadlock issue mentioned in sysbot and
> how it triggers deadlocks.

Sure, but what questions do you have here? To me, the lockdep output is
self-explained. Please kindly let me know if you have any troubles
understanding it, I am always happy to help.

Thanks.

