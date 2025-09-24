Return-Path: <netdev+bounces-226041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C627B9B1F9
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C074E3A30
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F733164C4;
	Wed, 24 Sep 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgnCzGBT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266973161AC
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758736273; cv=none; b=CZUKHDpGJ9Xff4vUrk7PIIVyMuEWbQ/sugUpqb/NZPwi26aBia7DMTigWEK2ely85bwmq7B1EfIDFvyfeP7xgJjL03fMJxyXlQGYfL/mlE6c3oejz+IMr0y4Exc9RTMmpC8fruh3ekQQn0pMXqIUs+OORF+Eu9AgeqZTov693HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758736273; c=relaxed/simple;
	bh=irDF2NGT01tFVGcKv8Aw+yXSxcZKqrHPtgX88XxrmqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhuXg1TammwC23niXRNcp8g71fGzggtRxUqVX20DpDzRSvlPwVQjEMB4k6KumXQrGtefZmlCX3iLGyPkoh3MZ9TDztWdeoAbDSfApJZgT8rFcQ6bceckcQYKXqht1ZW+RFqfpxqfIIa2vTlw4kDWFVG218GnTBmwCZKClVyMTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgnCzGBT; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57a59124323so40469e87.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758736270; x=1759341070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pquafnPzR8S6cEVo4ZSJasnk4ic+4rsTQNuSE4g5qVk=;
        b=CgnCzGBTMYiRzSQuPlR/SAm+ecE/5DkRsGCNRhjv5VzXZMroiPF+xV8XhF9/Xt2utA
         Oy33mz36r66ywcpgpc/+fYQ8wNQV/8beQSDK7ahgsx8/GIMHSA0Xj7DRNMrC/jXiGGPq
         OOLmGeZW87uw9A20JrLRGU9yffNA3foBoe6AokC6okFGqoegv95dK0s09+oON5kD4nqT
         j3CxD2WEoDGNEV3dHaEDa9LwHxyVx0aA5+vX3vMGSeD5LnCsOT3gi6jOc3dCiVzzp4v8
         f1sH0GdTz//2gT7konbV3QrvIBOYmA+b5IS1a8NeZZOdwwn7mVqi/FE+V9OgWukIifkS
         miMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758736270; x=1759341070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pquafnPzR8S6cEVo4ZSJasnk4ic+4rsTQNuSE4g5qVk=;
        b=Ic98Qn13krqeisdzSRCa1Qb1YCV5b7i6Ca0zNcmAZ9FxxSdPexuxD2QM+PWs1cXxWZ
         1MhHNcOIkL4uX/uRfzJ8C94ELQ/Gjyid221t2yRbaLgrsVZwM3eczpcU+gtZDao+Yz3m
         vXRDuFU4Gi2si5rKYZkcY9yyEv6vV97al+kUXTXIq3RvoPAf0mMV7Y5DOQC3BHDWpl8o
         dJj2EDSONLiHKf0XMpOOh4dnacnEJ5YuLghSfMdiMQk707u76ufWgwAcVdRwXdPRb+La
         QUj8pM7wZ6UgimugjOcsPQ8tqVfIUvYfBD3ukbvDkMwCwm4Nxa9xkYyRdGjNSMQGI0MK
         nhqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7bkxwysPWppwVapvW2/mqXm3TBA77+PX3RelAuAJ00TdCbx6pfyZILRAqZcLg7SLwPQ1PJgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUn2N4rLgddB2v6F8qz2133bzXuIdbxc8AFaGNype5HNBMbsq
	G1gZ8hMtI9P2jE89b48g6VRWz1SjeIX2S8LDD+kJzhcj11ux7z4GySJ9
X-Gm-Gg: ASbGncuWnoOTjBhF42KyjgSf8yHfPYE27DpUtUuhCnuql7zSRCtFj3a3UdLFRqLQNkr
	JZYmR5WZU59d0ZMx/Rt84uGD7AneB1/GtXxRgt5GHlCouVfspjxBIDtQhazWZTTJJKm3iUClfb1
	x7VIIberQsPDbaOcO8m3emAd0YlnSE3nDPjvd6AK/e7v4FSa760CRC/pMmVjKgkWVRr458MYKim
	5zIiwXKKuTykf07fwl8ejR8niG3w3BHPeC/hSvgC8LQMXYwkcxxi2j/fbSN7ozP6BgO7zmxywdk
	tb7D89qLAos1xR+b9uk6GYIPHAotC3qbg6jDJrIWmbrtnBxgOMYkP1rnJrXHIJfPHLtugItkv13
	zYE635ppRMwiVsu8CNYLIOl2g9gbIheXplAY=
X-Google-Smtp-Source: AGHT+IFHPEAgajKTiH7Ls3GaEiRPS2Tkaju+/hcYdJg8P1mtwrJiU+kcknlPPPv2gncoIiP6NgFWvg==
X-Received: by 2002:a05:6512:ac5:b0:55f:6d6e:1e97 with SMTP id 2adb3069b0e04-582d4257f20mr104190e87.52.1758736270018;
        Wed, 24 Sep 2025 10:51:10 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f44740sm5227645e87.14.2025.09.24.10.51.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Sep 2025 10:51:09 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:50:55 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, kuba@kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924195055.15735499.michal.pecio@gmail.com>
In-Reply-To: <20250924135814.GC5387@cabron.k.g>
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com>
	<20250924135814.GC5387@cabron.k.g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 16:58:14 +0300, Petko Manolov wrote:
> netif_[stop|wake]_queue() should have been removed from rtl8150_set_multicast()
> long time ago, but somehow it has slipped under the radar.  As far as i can tell
> this is the only change needed.

Hi,

Glad to see that you are still around.

Do you happen to remember what was the reason for padding all TX frames
to at least 60 bytes?

This was apparently added in version "v0.5.0 (2002/03/28)".

I'm yet to test the exact effect of this hack (will the HW really send
frames with trailing garbage?) and what happens if it's removed (maybe
nothing bad? or was there a HW bug?), but this part caught my attention
because I think nowadays some people could consider it "information
leak" ;) And it looks like a waste of bandwidth at least.

Regards,
Michal

