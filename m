Return-Path: <netdev+bounces-156065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CAAA04D1E
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837DD1653BB
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FE31EF0B4;
	Tue,  7 Jan 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4dod34A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF61E5711;
	Tue,  7 Jan 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291085; cv=none; b=FXBcNYuge10xP9NVoTvwvrQLmJTWL2rEv0v5dzuTYU8XCSYZTelYCmR8EH6FTOyxrA/gXlGwUWSIXhBfClp/T61wBs04LCCqKqUNLTy5cnNQZi0R42i5c39/JX3u2z7yOCSalC1fLO9IoDGpE2mEbwN6e7ySKDYpTQUMTwyTGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291085; c=relaxed/simple;
	bh=OtnCu+M/Bbt38Jg2MW4aLc75DJf86+yR1Dp7MzXLTgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3ziJnqKZqZISQMbF7+rkRAK7+gYzeqgxJ1LHVDMhxDwvRn35jk5nD2FOkiSltPmL1Aa7TJcr1GvcGfIJ7Vz1ZmS9gkiz9idi1Vg6ZKDzZWq7CSEqGxcrWNreRQKQGpMmFLQyBJxQfBwhPHuh5ZoCom9SVBriudD+tCmd+xkJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4dod34A; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-219f8263ae0so189425005ad.0;
        Tue, 07 Jan 2025 15:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736291083; x=1736895883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nf1LfZ4qgJubCqyy9dabGr3PRYHGQFcY+zJZ/lt4blk=;
        b=J4dod34AAw9FgW3o7CIeEzNUJM43GtNjABEtLRehX10H6UXEOfNm7NljUP+uhElEnp
         V7P2KKrgS8PO1W585sFto86UQZv6fc1lY/Ow/yKrnJN9/XID/6oyEAWInnFC4+sFopwp
         KAye08tfFM5l9rD5+OaQUflZZSE/6b+IOBK5WgaskKqGKLz0cJkceRy/bHJyPwegLhXG
         n3Wz95+kqgvzpqsZ6skxNfVmqAUxtbaROxr5pYDZMK2632DEA3vlEPxyoqj+Rx5dZnaH
         w8N/q6RshJUq/2umkxbRjx/DfUGHrvB7/xE9RkFcIi9ep+Hz70xUikByiEJN+jN++hRC
         n98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736291083; x=1736895883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf1LfZ4qgJubCqyy9dabGr3PRYHGQFcY+zJZ/lt4blk=;
        b=IZQBwCdlPNWvP9xZEXfVE19XQJz20Up59Ba58Kt3dAYMEs0zRN6XjfHd/MwPt9D76Y
         QY661JrhXRjVGlCSEiMCLQVNi49+LFjx1Itbww5fOE+K3DLpmT4I2ekocTLJ3hJSDY0J
         qQISM+ljkR8vx2AjUYabRa5g7j447uhkgejIqhg5J/L/213VfgXCV+gGJVm9ULnAGrvG
         RWN+RYuDK4XyoMWD+7HOWu78XPLemIu23JpoKM52fWvv8Q7ITxfWNGyi1ashcWNo+Pff
         CxHweeRP15ybwxn8VD/8lQ7+rLt9yho6FOLktqHzmjU0BNIZ4BcXiFfwUuodlUee3AfM
         gxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX17mMV2shVYN3ibjoz3krENLbeTo+wO5YULM+DS75tMD46Pgukd230vcJ1nwCD/F49OdLTATY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkB9DtlS5M5nDRsaS+aj4ZOz6uG4y3cGOVxmlJb08LTsOB2K1y
	KN9KrmcidOlxgkYNThWSKHXelPxtFiFmTR5+yo6JzleRQZwgPVXMFq18UrJN
X-Gm-Gg: ASbGncuN3AE6xCLDbFukK6OfZ6xUZoMXz3K8CNrJaVECrIbMa2lY7J3rhVZ+qGt75c/
	Eut7StbFlDP+a7yGTPGloZMVDbOieUkdolVcTKbNbP8q4qg2S3e7V0/aPIUuLn45U/kkmVGogIo
	tYvwdd5UVVEYqmfvDScD5vkxIVzO0NXSc5DBwqGETmSfvPcpXE9gKE//Pq798k913DVllecUS/q
	4z2ZZ9Mu8CEHVQuhbJuFRhyH0mFjNMX9mQonpdAbpkLaxHvKkX4VxkA
X-Google-Smtp-Source: AGHT+IGGsnhxMdKS+XqfH46crmyd2h1FdCEGKB61+UKyA9wPDqV3ce8dnCK+ft+o6nEtGVnODyxZ2g==
X-Received: by 2002:a05:6a20:2591:b0:1e0:cfc0:df34 with SMTP id adf61e73a8af0-1e88d0e2320mr1644455637.16.1736291083069;
        Tue, 07 Jan 2025 15:04:43 -0800 (PST)
Received: from localhost ([216.228.125.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164c7sm34048123b3a.4.2025.01.07.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 15:04:42 -0800 (PST)
Date: Tue, 7 Jan 2025 15:04:40 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 03/14] ibmvnic: simplify ibmvnic_set_queue_affinity()
Message-ID: <Z32zCDd2GnFPW465@yury-ThinkPad>
References: <20241228184949.31582-1-yury.norov@gmail.com>
 <20241228184949.31582-4-yury.norov@gmail.com>
 <Z32sncx9K4iFLsJN@li-4c4c4544-0047-5210-804b-b8c04f323634.ibm.com>
 <Z32t88W3biaZa7fH@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32t88W3biaZa7fH@yury-ThinkPad>

On Tue, Jan 07, 2025 at 02:43:01PM -0800, Yury Norov wrote:
> On Tue, Jan 07, 2025 at 04:37:17PM -0600, Nick Child wrote:
> > On Sat, Dec 28, 2024 at 10:49:35AM -0800, Yury Norov wrote:
> > > A loop based on cpumask_next_wrap() opencodes the dedicated macro
> > > for_each_online_cpu_wrap(). Using the macro allows to avoid setting
> > > bits affinity mask more than once when stride >= num_online_cpus.
> > > 
> > > This also helps to drop cpumask handling code in the caller function.
> > > 
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > ---
> > >  drivers/net/ethernet/ibm/ibmvnic.c | 17 ++++++++++-------
> > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> > > index e95ae0d39948..4cfd90fb206b 100644
> > > --- a/drivers/net/ethernet/ibm/ibmvnic.c
> > > +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> > > @@ -234,11 +234,16 @@ static int ibmvnic_set_queue_affinity(struct ibmvnic_sub_crq_queue *queue,
> > >  		(*stragglers)--;
> > >  	}
> > >  	/* atomic write is safer than writing bit by bit directly */
> > > -	for (i = 0; i < stride; i++) {
> > > -		cpumask_set_cpu(*cpu, mask);
> > > -		*cpu = cpumask_next_wrap(*cpu, cpu_online_mask,
> > > -					 nr_cpu_ids, false);
> > > +	for_each_online_cpu_wrap(i, *cpu) {
> > > +		if (!stride--)
> > > +			break;
> > > +		cpumask_set_cpu(i, mask);
> > >  	}
> > > +
> > > +	/* For the next queue we start from the first unused CPU in this queue */
> > > +	if (i < nr_cpu_ids)
> > > +		*cpu = i + 1;
> > > +
> > This should read '*cpu = i'. Since the loop breaks after incrementing i.
> > Thanks!
> 
> cpumask_next_wrap() makes '+ 1' for you. The for_each_cpu_wrap() starts
> exactly where you point. So, this '+1' needs to be explicit now.
> 
> Does that make sense?

Ah, I think I see what you mean. It should be like this, right?

  for_each_online_cpu_wrap(i, *cpu) {
  	if (!stride--) {
        	*cpu = i + 1;
  		break;
        }
  	cpumask_set_cpu(i, mask);
  }

