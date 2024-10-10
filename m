Return-Path: <netdev+bounces-134325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA46998DD2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD028B26A40
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885801CCEE3;
	Thu, 10 Oct 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GsTrJMkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808E1CC140
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576463; cv=none; b=rBW9UVm/0/LtWDlCOXZIDujMK6r1wEHwVfm185yZkuzcJvxVgl8MzKi1S0CU69XNPBBMPuqVPfvOYfxhMoNM4UOK+5Re43LOUfBvSeBmNAHRLlEshVsf5ccCbLnKm0sHle8snaG/gJouerrxqDtqnR1LwgGkyZqVfYTV4AlfrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576463; c=relaxed/simple;
	bh=gMJJQSlsn8Yh8reIJdg3CtduncAlSvBM+SH5wCCRMpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i//tgWfJwCoCOpvaKiAcJRLyZcGs9aeSjWxwWdregUarwg92sjWRj79gVtXfZ5PxlJ8YHzfYAfbfykAp2JdtZWq0iHgdyJpYOjTrSWJKMIwFJXUR79Lnc++cwxbK0r34DkBtR6shGHpsBVbN2sG9WT1uQFUwjXSVZ0S6/rA6aDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GsTrJMkU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20bc2970df5so8316445ad.3
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728576461; x=1729181261; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLDmBuPbqdFWywlMJb7s5WtOj7TP+t2aXk4dAI9ZYPM=;
        b=GsTrJMkU25PTamlCMwj87VBDSg08a9TYsWC/cOPWfuVOfRvnrParif5IpeDbCg4MKw
         wHJ/vAKC1dIdXOs1HCvL9FNUt+WJhcZnLPmPOdzXcizhVnHsxxDZcOn2FrwYYfbJa/X2
         3aNilAGkKW3DcnVXRiG8wt/fKZJLJDwx9hdW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728576461; x=1729181261;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLDmBuPbqdFWywlMJb7s5WtOj7TP+t2aXk4dAI9ZYPM=;
        b=Z60t8xklonor90F9grh6nPYSp8DCM7bhTRAASfz5LbhLa5tSh9l8wA5Cl8tH5JByCF
         11ELn7cIxlvMsejWCp+M7z176qqMrQUbZ0lqTXtpThPsmlVoMe7T2+nNUyDY55+NTTUc
         jcf4e79/VKz6GsHYZg5S37hNJLq6uH/sVHivH2aOwJ4g9NtUoJpbUEeJzu6vQIo6Z9ih
         a2fzFGQE2Fn762bwgD9BKmkSkAePt+2ZNLYWg/yJJYHpydo78u3g7rzQHtsU9jA4hxpT
         Zxo1U7A+R+AQYdpsfg4jYsa5YmxIuAuiiCBhfk8le2Ltz36Vg8hp3RVFZNQme6drJI7x
         JuQA==
X-Gm-Message-State: AOJu0YwInlhabMjBeblpdX82J8LW9cdb5DtAfZprEYHWQ3vQZYSL/wS3
	UF9EgeD87HMBUqwUWHkJoc5NheV7owgmhCR92VbFpvw/lanhYz5aIeHqdO4AIOk=
X-Google-Smtp-Source: AGHT+IG0fUbGFEzJUGz4lr95LVIQt209ymVKDCNv+HN/QpGQnTewWumSlw9CcDSQqGqrSbXg5wKhWw==
X-Received: by 2002:a17:903:32c9:b0:20b:43f8:d764 with SMTP id d9443c01a7336-20c6375c6e4mr98324265ad.8.1728576461240;
        Thu, 10 Oct 2024 09:07:41 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33ce22sm10984635ad.256.2024.10.10.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:07:40 -0700 (PDT)
Date: Thu, 10 Oct 2024 09:07:37 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [net-next v5 9/9] mlx4: Add support for persistent NAPI config
 to RX CQs
Message-ID: <Zwf7ydIettFJ6p2K@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20241009005525.13651-1-jdamato@fastly.com>
 <20241009005525.13651-10-jdamato@fastly.com>
 <CANn89i+187Yht9K-Vkg6j_qj9sFiK0jaGSxMDdYCAUZUtBgMOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+187Yht9K-Vkg6j_qj9sFiK0jaGSxMDdYCAUZUtBgMOw@mail.gmail.com>

On Thu, Oct 10, 2024 at 06:28:59AM +0200, Eric Dumazet wrote:
> On Wed, Oct 9, 2024 at 2:56 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use netif_napi_add_config to assign persistent per-NAPI config when
> > initializing RX CQ NAPIs.
> >
> > Presently, struct napi_config only has support for two fields used for
> > RX, so there is no need to support them with TX CQs, yet.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> 
> nit: technically, the napi_defer_hard_irqs could benefit TX completions as well.

That's true - I think I missed updating this commit message when I
realized it. I can correct the commit message while retaining your
Reviewed-by for the v6.

Note: This adds to the confusion I have around the support for
allocating max(rxqs, txqs) config structs; it would seem we'll be
missing config structure for some queues if the system is configured
to use the maximum number of each? Perhaps that configuration is
uncommon enough that it doesn't matter?
 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

