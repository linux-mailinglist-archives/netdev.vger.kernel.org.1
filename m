Return-Path: <netdev+bounces-204280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F44AF9E57
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD511C27BA2
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 05:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC51946DF;
	Sat,  5 Jul 2025 05:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/7MlPnF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083B520330;
	Sat,  5 Jul 2025 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751692058; cv=none; b=p2TfUDTDqclv/IltBICk5pbtYohfVhY2gyXVVq3/dSIba9n3y9SDsAJdI25aCIi9938RKaAzERHHpdXNqRZUnq+CqK8vDt8aCTxGb5+/ntX/+79MH8qAEYC6Rvu3/paZuldKW5ElvPP6M7PIhxWzE0YWzxyD9bHGoVE7RupXvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751692058; c=relaxed/simple;
	bh=ZCh1Z/9IBsRPKRwZSKQnkU4l/vD//9dhXGv2tucMw+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha3j080bdgRbbYI4zcOS6G1DK0Zf4kiSw/pnAHjzhDN5TOa1ce4zw/iXaoSr6Qvx9m8pBob8gI0fbT7DzIqnEVBNxvFBduFsSq2aFAcTlxEc+FiInFEz0wvjqtoej7gEKbi4yg1VNjot0garrP+TMr83egpUq+jtFkzmnfSoA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/7MlPnF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so1911288a12.0;
        Fri, 04 Jul 2025 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751692056; x=1752296856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJof5mhNhWys0vTPjrJo1lwyk2akFY2XmfI5Oa0Y5QM=;
        b=K/7MlPnFjnOsadG7N75pW783RPUkeRSB5THMzbBNZVAleTkMUG+5HF2jBlkGwH+lW+
         NQguItQ6mref0XbFzsJQ3kBV4Z0NDbRGjV3e8nyrvflCGAtVUmp3QkI1mZAM0NCnuzxv
         Nf+U0cKdc+Xk4Fc1IuMUCWl3GyfPNtC5D9aDm2lHRSFo06eXFO+swMGOC+WQWPPxeNtI
         tSlhyUjpFPB35j/ec7KfJHhbXmUKc6Uu9SZS7S+belIQlBAAQL0CbwelG1dpTxdFpZwN
         Ds3xOI6VDY+XM8qJWfA43tjCm8Tz4OZ1Weity/3cJuScNhK63Gai3xe6yj1GGb1zGg41
         WdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751692056; x=1752296856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJof5mhNhWys0vTPjrJo1lwyk2akFY2XmfI5Oa0Y5QM=;
        b=dpRz+2atOBck1FZbNjw6dHVgxECESRKs3zmEXKvQHwCMs0Q5d6BvKWsElE54jru01r
         X+5OiUGC0azo6pBeFRvGY4OVOBXNWt1Pj72zEjqa3qnFBwVWhmGNLsxVetvtJ+M9+SK9
         Dap72+7tffiZY+kyoUpcHuiwMKLpGGTHONF2tBtvx0K93whWzKimFIrF+eV8bwJsRb0m
         uQPuBA+PdQdMnGSudBy0tT5lT+BzrWXpQFGnfYNgMxDboPOjh5/jmGyUeRGnlnFC1FO0
         Vk00IOx23SLzwSX335a07YfhkZcn6l8pt0bHFFhDzaPYR38bHW62u6ULez/q2a3u4E6S
         DpEA==
X-Forwarded-Encrypted: i=1; AJvYcCUI21mflvKGK8pDcE2lKfqLTrSaiNPVx7aZjO4mCLYdoT7ZU/xYQxU4vH/ynVDslQrHyAgNMvIE@vger.kernel.org, AJvYcCWvUBOUCuqas5iFGfJyaaBLkv1Wqk7hG7IaYGZFoIprrYUKeoyLBBDGb4K2PSq05iPMLEhkChtjlN2XOmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTkWIc6+nN2tNPegcLpjfQ1njrPdQt4C52USY/NVUZ37d8RrS
	uQPivkcP1Q2oWfXK4ffTW9y9/+o1ixW61ac8ubSkz0a+6BvUOiNle5Oy
X-Gm-Gg: ASbGncv0RA0sCVJuHX2PY9ENJaeX1BJ81LpWWnuMifRq2wk/uWPsWXuu8G4r6adwUgs
	Pz/N3lP0Y0BCgZMt91w20qPxtlsFx8TAIhUR85Nk+c5owN5j9Pa26Y/XZxC2vegloglG5bNv5gk
	loOklHyQdXSVnRvZjrpTXlLDDqfFPyIk+puAMger56n1myTRQHtv1v++GcyYiSuseFsfky6Wj+N
	YFeV9MJTtoJRRSP0ad6w4abhbCd7lPEedTCwwGfyzHyOrYapvknUYJONqniTAPApgBPoD+ivEfx
	NJgas+opCux5cbgK2EezJvz17PuXHQaKbOqPRYmo60TJBp1UH36g3HGMYgvbSavIT3Me
X-Google-Smtp-Source: AGHT+IHzFj2sNLlVlawNH0SaI7hYGGQLuLt+m1fm+NAe+jaUcrflvlbZrbgolrD42aIK+Km2IwtwyQ==
X-Received: by 2002:a17:90b:578f:b0:310:cea4:e3b9 with SMTP id 98e67ed59e1d1-31aac5511a1mr5791725a91.34.1751692056136;
        Fri, 04 Jul 2025 22:07:36 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:af97:2acd:2917:c229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31aaae60f2fsm3558844a91.16.2025.07.04.22.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 22:07:35 -0700 (PDT)
Date: Fri, 4 Jul 2025 22:07:34 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] net/sched: Prevent notify to parent who unsupport
 class ops
Message-ID: <aGizFhZwnPo98Bj/@pop-os.localdomain>
References: <aGhr2R3vkwBT/uiv@pop-os.localdomain>
 <20250705011823.1443446-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705011823.1443446-1-lizhi.xu@windriver.com>

Hi Lizhi,

On Sat, Jul 05, 2025 at 09:18:22AM +0800, Lizhi Xu wrote:
> If the parent qdisc does not support class operations then exit notify.
> 
> In addition, the validity of the cl value is judged before executing the
> notify. Similarly, the notify is exited when the address represented by
> its value is invalid.
> 
> Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06

Maybe I didn't make it clear, I think Victor's patch also fixes this
bug.

https://lore.kernel.org/netdev/20250704163422.160424-1-victor@mojatatu.com/

Can you check if you still see the crash with his fix?

The reason why I am asking is because his fix addresses a problem
earlier on the code path, which possibly makes your fix unnecessary.
Hence, his fix is closer to the root cause.

Please test and confirm.

Thanks!

