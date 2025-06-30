Return-Path: <netdev+bounces-202631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BDEAEE695
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75886189EB4B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99341DF970;
	Mon, 30 Jun 2025 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFDKDUk5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE001CDFCA;
	Mon, 30 Jun 2025 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751307312; cv=none; b=MSrPAmO8V4V8bINVDwVOO39lwggwmcuLuuiT+CpAmpKfqeHAukTEGEqkrXPLhaPAByfTOsi32gYJUS74aA6Ahtr7FeAIlTzCBmRG/VzcKRTgHz7pb1+3U8dTptj9LTJi2t+OTAAWHoUmGKP1JIxKTVsi8Y26BuBt8NbsrsnAFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751307312; c=relaxed/simple;
	bh=LDrdIDPKEff84B12ukoJJ5LXoAz2VrNgfonQmGr/YIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZleiNYngceQID/V6E50bc8V2DT3NjZT8KtWisV7rZUyul7wS+h5gnfe3WtscuQFCZaTr/Okb4BZrdwy6tIcZI9jTgme9yujASxtLgZ2VCe1l6yyjVOpFWaRoPaLBBMnSsm26U5rvZYSpCL90hjZSieOf6/0GraxNc3Ggoj+gs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFDKDUk5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4940748b3a.3;
        Mon, 30 Jun 2025 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751307310; x=1751912110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H37e64s3170mpDSPHrCrQe6P7F5mto+begqdDnm3dHc=;
        b=jFDKDUk5DGKmpSS8n6/lDvGe55f7DHW8KoB0iIQKjAtniZZLekGEFBA2ugguNctPfN
         oAdKzbfCevpFfTzHL0qRIWsM1ZFTLrtInCU86SDOu/xzOQi+lS94QQf6nCxhZdBQvXLC
         FA7wZrXz822taUEBsL8KwSe3Aj4E2Ln2PgQN/8g+01cbrku97/L/2OWZ8eEKbDeOTorg
         EkUjzEhzcJKQC7iZWfcBl69v3hupJ5LrG7TZJ981CPJvsbB9jGZaoP2pT2ad+TRk9sIK
         +v7syq10DdWYBvS4XRr2BVAjXI/szphFYOGMVOuNpw7CqmnomXCP9iyA8ZPJuwVp2Jnm
         qP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751307310; x=1751912110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H37e64s3170mpDSPHrCrQe6P7F5mto+begqdDnm3dHc=;
        b=Y69Rka1A+QLPHfdxXRSg++9Jvf+a5pPtsdvyUAzRZdQKt/hQloK/nXfq7UHIr/zuEw
         4r9fIiELorxjCKuZvqeQeqJmLkEzAOhP2HbP50thy647xEHPLtnLcHNT8a8ZvdT217CJ
         38WfBzFK9hbH0JMyJP2R1XILhFxLfGYPLF3RFsRSxfwVmOYvDglXBWqPyzR54jXWdtvy
         zYE5xLlG+IdYS2wcU/Qi32Ew5nEbQxTeX3n6TX2MmqCatnY5mhWydfWHoaqWNcHcFqGL
         6JRy7Y6bojWvJVOKAeBv+ZTeRNwlQI1t5s3K3Uwx+mSZsGyHTi1GeB99q32kxLdzrDRe
         9plQ==
X-Forwarded-Encrypted: i=1; AJvYcCU46X9XIycdTyhLgg/HgflvIiWAnlbiktXcugxLFNMz0h8293nFNVpnwOtverVDZ48Fy5vhgSMy@vger.kernel.org, AJvYcCXYDDSla78c8yMTO6PdjI7RAj91WFOFpxjY4fOVcMdwlNtW3i4ycz4Cf75Hm4IKFxDjjNoGum12eKlANZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoWsBiqo0RAN4ua7Ex8m3TfBcBKmcgxjv1o0M/eBFlyeXttKu
	FtICHkT8xVb2nk45s0oWeXkz+mnqcZdjOgMDP/v2A70SOn8WCj409tjD
X-Gm-Gg: ASbGncs8YN89V9tGhuNm3ggMOkIorzY3E/k3MnH8EFH9kLIKhTAJYU/4yTENQXES7+j
	CD4uarfAajzo2QA6S/9GMPhbzTuZIMj2WR6gXu7GTQ0yUu13i79YNjL66VIzjz2gPtZUowkZCyY
	u9C7LrHn+sKfupDLwImxjwoUtDw270YWDkFHSCnFpB1wjfTL7vkN43rSrdrnWtJwtR3orGLVPVx
	k1VSPVRXcCWvYL+iZyrm2vImNW2Ta3qeqJUIeZkWUtKFHVZBUEbEgcCyMqzJwGva4KGpKlQmgj3
	yKTH9bWeW4zEH4l4PVEDTXZSFKXCsFZbgWSihn0ztcwHXCQnCeh9YX7evFVDdA==
X-Google-Smtp-Source: AGHT+IGihescccQMP7vCe8xp0GzvZMGE5zbzUaAE5sBZpMnQ9pL1PuoCEq7KCoGc6qCy0cXZODYCfA==
X-Received: by 2002:a05:6a20:d486:b0:201:2834:6c62 with SMTP id adf61e73a8af0-220a16b359bmr21990420637.25.1751307310226;
        Mon, 30 Jun 2025 11:15:10 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af55c5837sm9756966b3a.116.2025.06.30.11.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:15:08 -0700 (PDT)
Date: Mon, 30 Jun 2025 14:15:06 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLUKg8uNvNtimW0@yury>
References: <20250619145501.351951-1-yury.norov@gmail.com>
 <aGLIUZXHyBTG4zjm@zx2c4.com>
 <aGLKcbR6QmrQ7HE8@yury>
 <aGLLepPzC0kp9Ou1@zx2c4.com>
 <aGLPOWUQeCxTPDix@yury>
 <CAHmME9rjm3k1hw4yMd8Fe9WHxC48ruqFOGJp68Hm6keuondzuQ@mail.gmail.com>
 <aGLQc5JGGpMdfbln@yury>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLQc5JGGpMdfbln@yury>

> > > From fbdce972342437fb12703cae0c3a4f8f9e218a1b Mon Sep 17 00:00:00 2001
> > > From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > Date: Mon, 30 Jun 2025 13:47:49 -0400
> > > Subject: [PATCH] workqueue: relax condition in __queue_work()
> > >
> > > Some cpumask search functions may return a number greater than
> > > nr_cpu_ids when nothing is found. Adjust __queue_work() to it.
> > >
> > > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > > ---
> > >  kernel/workqueue.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > > index 9f9148075828..abacfe157fe6 100644
> > > --- a/kernel/workqueue.c
> > > +++ b/kernel/workqueue.c
> > > @@ -2261,7 +2261,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
> > >         rcu_read_lock();
> > >  retry:
> > >         /* pwq which will be used unless @work is executing elsewhere */
> > > -       if (req_cpu == WORK_CPU_UNBOUND) {
> > > +       if (req_cpu >= WORK_CPU_UNBOUND) {
> > >                 if (wq->flags & WQ_UNBOUND)
> > >                         cpu = wq_select_unbound_cpu(raw_smp_processor_id());
> > >                 else
> > >
> > 
> > Seems reasonable to me... Maybe submit this to Tejun and CC me?
> 
> Sure, no problem.

Hmm... So, actually WORK_CPU_UNBOUND is NR_CPUS, which is not the same
as nr_cpu_ids. For example, on my Ubuntu machine, the CONFIG_NR_CPUS
is 8192, and nr_cpu_ids is 8.

So, for the wg_cpumask_next_online() to work properly, we need to
return the WORK_CPU_UNBOUND in case of nothing is found.

I think I need to send a v3...

Thanks,
Yury


