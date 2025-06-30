Return-Path: <netdev+bounces-202626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967BAEE623
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4525A17CE2C
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E02E62B1;
	Mon, 30 Jun 2025 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOHVv1iK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5F2DBF7C;
	Mon, 30 Jun 2025 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306046; cv=none; b=o944y1rAyp66O6gCzb+W4sKzOU2M9dRWu1CsNoBEDTX1lKDr+bWinbAkkLTWaL+zmTGrlwUde2CcaqO8JoMGcf4eu185whDVHj90zJXacOhEW3bX4gEQ9Xc5RgjnT8km9C33x3hx91PAPA5RnocVoLdrToSa89FXUG5IyMizu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306046; c=relaxed/simple;
	bh=fYhsRNGbU6h5cvuC/fCJVnbVZ1LxOBkkipcwDepvRDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrmkxntCswFr9ApZsBU8wXRMKguxyK+HlEqsoQge273GJY5r4eG4eZggWwNL1peGet9AAY3vvtHP7q5S8kNMw1OupE1H78x//PpCikMgUn97Q8l7KFPdC44q/SFn0Rh87PHpObgLo1FJ0539WLyEDu6enZeKu2p2ISAYGz6sq2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOHVv1iK; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b321bd36a41so2124462a12.2;
        Mon, 30 Jun 2025 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751306044; x=1751910844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+FvQdARxOE0AE0TkBrCFtqU1k4cnh7ikYsee8BD0XuE=;
        b=LOHVv1iKUo1H6nuVLKMYWaFN70789Emt/ytPQhx1XvwKG9ZhW8jwF6ISs2olNTvefy
         F5LIMRjtBv3ovMYp6wAWSeX5WqahtTLuYoi7YwJSk6hEnTQHhjkNKffczpAmLf26S7hS
         Fk6RRt3W4fpSI5xvNM6HMednUdYUZq8+4M0V1wHxmuCSprhUuCOBqIXo1hOojfUC+N+3
         X0ZaMS5YycCqboSRX0f5qo3xO1dSCtNgbnL2KsTRq/huLLpbLrWAAI2jKA3WX29ipOWF
         +ywVekbQbFPdJm9+zwqkQlhmZtmJL3l/5UW4tYakXo9QtcnO6KJXXo3J90L8zOWyxpgX
         MNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751306044; x=1751910844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+FvQdARxOE0AE0TkBrCFtqU1k4cnh7ikYsee8BD0XuE=;
        b=EnmbqvGumYfPj6ag13aKZiSdk1r04ehCM6dWjtGcUTZURrETZ/OMUU4kFRZDG95I/6
         2LBaSYKmaWSRIZ06rJxWpOCi2phG/rgJCQfiKOeyAGTrO1K+Fr3Mj5r62zCAXt/Q+Kqj
         BmOYhGLqZAEQj+EKjOCvnheTTX+IyJLIx+TcT8GSQGmtvG5wEjfiw1A/rBSiwDt/LpeS
         +eTFz400XMn4ynX4Dwj8JoA/QDgZw0EM8t96G1sHCPw84iA28tvJ3YbIK4lOSwFcdjiH
         pApn52SiaC/N5T5e6WpvOATwavIz4RaC57JWwRzZJ4CpPJocLXtFpxP8B9zAxaZUTjzM
         Mq7w==
X-Forwarded-Encrypted: i=1; AJvYcCVCVl9FAeh6UtFkSJYerT8oBVj/7VSuc4tFlo8t05C4aQ6zrOad4l4ImeUaCI6+pWYI/fNOdyET@vger.kernel.org, AJvYcCVdoXRZw14cxE/kYxN/oc2WV2DEJDvLTc86Rg+XH8NjpPndmoALBFPIL9kg3QypAl9Qt9Nct2W5IxuJ2Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8rXhL/KYAmFW3KzBVp7OqKU8ICilL1E0n05ES5fObb0UQxMiO
	ykzXvOKTnYbexGjUNVDeAvFWZt58Xb4/wVRcPfXMQLlsOtWh5xF7Kzu8
X-Gm-Gg: ASbGnctZu1RSxMSEQouwSBikClT2120hMwi96K3Df7QbLYDakD//0YJpwQZay4k6lLP
	m/tnL8bZSw2kDsQ9TPIocsCo5xCCMhH0o8FpLFu/j9zpIOLcF1YJq+v24pljvK+Jf+vhZ7cwej5
	GH2UvOK71uUnLbnbpSR3c6JzPkR1+BUK5FFL1v6MbVmh00WN42bPAHYv29bUOddfC4bwNbRBdfP
	J6frj1LuWrpaDt4XzGlF8Y2Leiuoauuk4556Oi4i4yf35HiRP75kdYe95q7bNiQtUFRA4bIyj1f
	CypQ5Q+cu6lAIufUzX5lBHkKPicPqL1lIC26MY3IeW6TQTN1BXBTSZrOijiRPg==
X-Google-Smtp-Source: AGHT+IGsSgosU0EFvN9ZODyenvi/+IbvPw/aAApH7JP0y41FfCRiPa0g42ZE4CsDkX1cZblqgDiC/A==
X-Received: by 2002:a17:90b:4b50:b0:311:ea13:2e61 with SMTP id 98e67ed59e1d1-318c92839camr17182631a91.34.1751306044382;
        Mon, 30 Jun 2025 10:54:04 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c1392096sm9637470a91.8.2025.06.30.10.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 10:54:03 -0700 (PDT)
Date: Mon, 30 Jun 2025 13:54:01 -0400
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Message-ID: <aGLPOWUQeCxTPDix@yury>
References: <20250619145501.351951-1-yury.norov@gmail.com>
 <aGLIUZXHyBTG4zjm@zx2c4.com>
 <aGLKcbR6QmrQ7HE8@yury>
 <aGLLepPzC0kp9Ou1@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGLLepPzC0kp9Ou1@zx2c4.com>

On Mon, Jun 30, 2025 at 07:38:02PM +0200, Jason A. Donenfeld wrote:
> On Mon, Jun 30, 2025 at 01:33:37PM -0400, Yury Norov wrote:
> > On Mon, Jun 30, 2025 at 07:24:33PM +0200, Jason A. Donenfeld wrote:
> > > On Thu, Jun 19, 2025 at 10:54:59AM -0400, Yury Norov wrote:
> > > > From: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > > 
> > > > wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
> > > > function significantly simpler. While there, fix opencoded cpu_online()
> > > > too.
> > > > 
> > > > Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
> > > > ---
> > > > v1: https://lore.kernel.org/all/20250604233656.41896-1-yury.norov@gmail.com/
> > > > v2:
> > > >  - fix 'cpu' undeclared;
> > > >  - change subject (Jason);
> > > >  - keep the original function structure (Jason);
> > > > 
> > > >  drivers/net/wireguard/queueing.h | 13 ++++---------
> > > >  1 file changed, 4 insertions(+), 9 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
> > > > index 7eb76724b3ed..56314f98b6ba 100644
> > > > --- a/drivers/net/wireguard/queueing.h
> > > > +++ b/drivers/net/wireguard/queueing.h
> > > > @@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
> > > >  
> > > >  static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
> > > >  {
> > > > -	unsigned int cpu = *stored_cpu, cpu_index, i;
> > > > +	unsigned int cpu = *stored_cpu;
> > > > +
> > > > +	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
> > > > +		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
> > > 
> > > I was about to apply this but then it occurred to me: what happens if
> > > cpu_online_mask changes (shrinks) after num_online_cpus() is evaluated?
> > > cpumask_nth() will then return nr_cpu_ids?
> > 
> > It will return >= nd_cpu_ids. The original version based a for-loop
> > does the same, so I decided that the caller is safe against it.
> 
> Good point. I just checked... This goes into queue_work_on() which
> eventually hits:
> 
>         /* pwq which will be used unless @work is executing elsewhere */
>         if (req_cpu == WORK_CPU_UNBOUND) {
> 
> And it turns out WORK_CPU_UNBOUND is the same as nr_cpu_ids. So I guess
> that's a fine failure mode.

Actually, cpumask_nth_cpu may return >= nr_cpu_ids because of
small_cpumask_nbits optimization. So it's safer to relax the
condition. 

Can you consider applying the following patch for that?

Thanks,
Yury


From fbdce972342437fb12703cae0c3a4f8f9e218a1b Mon Sep 17 00:00:00 2001
From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Date: Mon, 30 Jun 2025 13:47:49 -0400
Subject: [PATCH] workqueue: relax condition in __queue_work()

Some cpumask search functions may return a number greater than
nr_cpu_ids when nothing is found. Adjust __queue_work() to it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9f9148075828..abacfe157fe6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2261,7 +2261,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	rcu_read_lock();
 retry:
 	/* pwq which will be used unless @work is executing elsewhere */
-	if (req_cpu == WORK_CPU_UNBOUND) {
+	if (req_cpu >= WORK_CPU_UNBOUND) {
 		if (wq->flags & WQ_UNBOUND)
 			cpu = wq_select_unbound_cpu(raw_smp_processor_id());
 		else
-- 
2.43.0


