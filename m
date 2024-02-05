Return-Path: <netdev+bounces-69117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C41849AF2
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E312281B63
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96021CA9A;
	Mon,  5 Feb 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci4KHYjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEC22EF0
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137185; cv=none; b=C0KE6Av2MR6TAsuBBnt2qXPqQ7MyU1zQGkrb4Bv28FRDx3fRQ7vUcDrNPJEaab/+hnbjbgf7skoa2/mlzREy90dzhDszGLIlpan0mRMvQHkt2fRHLyGUZDpgo6vYggM+JxKlz4v+6PYpExH8kgVkLP0WgpO0Gy91gDDgQzAyqUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137185; c=relaxed/simple;
	bh=E/bEA1+Rn7qyzjtzaIUP0SMxr2Z2UjJDe7OEHUFAEVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TltpmVqr34iPZuA9rruei4ixBtWIEeiqSlnqsEddmiWjXbsFT/GKnQuYNzE4qwPAL8lYoRwktymqTUN9cBCTXZZBcXrnfVUtP2K8H12hIFoz6TIQy6fq1oNhe2VlJgBFPvKCf4VovhfN5Iryhyhg8hZx7hBFzTcq57ej6VHJJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci4KHYjf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7881b1843so38073795ad.3
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707137183; x=1707741983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJvpkLQhagvUr7dsuuWA9qAQjm4qcVzi0lOGzeS2Alc=;
        b=Ci4KHYjfZUeURX8e0IoJ0mnqotJBdfceBrTDBbfFPrJpAoHfN8FLwYElenfbY2bzYs
         HukZ+Cj1/OQLgmEpwOJqNZjEJceaR0V+u+Y2it+CxTVtRB5FZzEXGTJAgdYIausO6IUQ
         Y7ys3+Q7Toabljr6AF97HwXGbhJ9ne7+XYnGGKOz7uG+ywW61u3BKH7rP0DYGl2kC/bo
         l0kVujvnE6eT9/Pt5lgYhI8qek5rsAfRqujjrJ5I7/tFKvRBN1TItzC9ufAJLZRVE1L2
         1GYQq+oAsUEc8muNrTuxjlRU0v3oJyZDEgPg8oRTKcEqn4/Ner5qdbDzTEI2xiQdVLzW
         Q9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137183; x=1707741983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJvpkLQhagvUr7dsuuWA9qAQjm4qcVzi0lOGzeS2Alc=;
        b=mc9kDt1Z6yMJkPb+pssiatr3r9P9X3KM1AlrGbeeM5SJDAnfPEsdZjMfayvzwx1a/I
         11+oBABkU2AjAwb40VYc+qm8m1cIPizFTHYsNtUt8jt6dx1M+hR3TX/qIaiLgVsCojBs
         ifw1/BvY7eOcruetLuBkKo5r81Kqfi8D1QRgLxuJC/EUJpA6E2VImjFco7p69V4ZtYuq
         BAf8x3KjozwWkz8Q85AuOaWx9K7X9JXkEbtRADiQ1WK6RTm2tnUPQ1dssg3Od7sZStk2
         ZOeozTAfrAVWhjILYhxcTu0MfMQk1ReDShXWsK1VkE3+i6TxnuilE+Lp0XyGKDSLih9K
         cyng==
X-Gm-Message-State: AOJu0YxLXKNZK1S5FGVieT3BOclsakzej096jRZPStgWz2BGmnJr/egZ
	taD4nwRVUaRUyOoTGryk6qe1QDoC56bfRxCGIvCvHaOpNGL5Ddi3
X-Google-Smtp-Source: AGHT+IGT8nL2E0jbjT93dgnoxXTihuHJMJmOGoXJqYC5+uyRXQBoZn2jLHjhWk6Iq9USG10WlKHnFg==
X-Received: by 2002:a17:902:9a44:b0:1d9:7095:7e4e with SMTP id x4-20020a1709029a4400b001d970957e4emr10353409plv.27.1707137183501;
        Mon, 05 Feb 2024 04:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGoWip/yYt6Rz9ETFRAwA8olltLoP6rwTCHldl4d02i4NBSyenztikdkMoHyY5t6/coClEUtpoAhD+BIniM+4jthZQyq3kg4Ls7p6UhISIVktyPCzc4qHeHEXfjMkABSighKZEbfVqi5fWdHWh8HoSwzAGnNOD6I5FTu3zfzYjpUaJxNLXwUBMU7Xw+Uhk+/gIz18sjXMNrlBCq7WVFXWmjgVhdUL9G23EMEERW7Syr2c=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e6-20020a170902d38600b001d94df1f859sm6155819pld.186.2024.02.05.04.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 04:46:22 -0800 (PST)
Date: Mon, 5 Feb 2024 20:46:18 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Liang Li <liali@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCHv4 net-next 4/4] selftests: bonding: use slowwait instead
 of hard code sleep
Message-ID: <ZcDYmgoqkYTARCWf@Laptop-X1>
References: <20240204085128.1512341-1-liuhangbin@gmail.com>
 <20240204085128.1512341-5-liuhangbin@gmail.com>
 <20240204082858.2d823ef5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204082858.2d823ef5@kernel.org>

On Sun, Feb 04, 2024 at 08:28:58AM -0800, Jakub Kicinski wrote:
> On Sun,  4 Feb 2024 16:51:28 +0800 Hangbin Liu wrote:
> > Use slowwait instead of hard code sleep for bonding tests.
> > 
> > In function setup_prepare(), the client_create() will be called after
> > server_create(). So I think there is no need to sleep in server_create()
> > and remove it.
> > 
> > For lab_lib.sh, remove bonding module may affect other running bonding tests.
> > And some test env may buildin bond which can't be removed. The bonding
> > link should be removed by lag_reset_network() or netns delete.
> 
> Unfortunately still fails here 4/10 runs :(
> Did you try to repro with virtme-ng, --disable-kvm and many CPUs?

Yes, I use a CPU with 40 Processors. But I didn't `--disable-kvm` as I'm using
microvm. After `--disable-microvm` I can reproduce 2/10 runs.

It looks that the slowwait makes the setup too quick, which makes ping failed.
To avoid this, either we force using the previous `sleep 2`. Or wait more
interval in check_connection(), which will consume more testing time.

I tried to extend the `ping -i 0.1` to `0.2` and run the test 20 times, all
passed. But this may extend the total test time, which is contrary with the
current path's purpose. So I'm going to drop the change for bond_macvlan.

Thanks
Hangbin

