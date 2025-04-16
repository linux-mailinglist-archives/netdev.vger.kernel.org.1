Return-Path: <netdev+bounces-183347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348B9A9074E
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466DE189CFA6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBAB1FDA8D;
	Wed, 16 Apr 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Msbb5A/8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832611FCF7C;
	Wed, 16 Apr 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815880; cv=none; b=J7REHj/VA+ND+OMKjDopn4dV4XdEqS8wCNZHf1+W+BBfmLwRiIBOgkDWsgOrJ/kl9Or8E2cKC7aFezavDbNO7YVLgD9UohmrvFNrScdC3RH76vSdl6mcYGc57MJort8vLl/I6VBAWXeg6/OL6sxi0MW6ziwWbva+ak2JPsi4FdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815880; c=relaxed/simple;
	bh=U+MEQ0NJyN29e2hatoEg0pd9WT6SIc00si1vlhfXOuI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfVGWGJnswM2w4J9PIC76L3n6u1tri4T8tlepsP48w42Q64Ew+ddvN+W2QXs3Wg8JBioKouczeWunjPvaCvIPwh36VfngbJJ0N6SSy9h/bUSZ4Q1ECQDJTCzFNOKSEx9fEuA/xlx04RsfJkIF4dh9aT9GBbJ5XjJq3Zp7/WEwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Msbb5A/8; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54954fa61c9so8363268e87.1;
        Wed, 16 Apr 2025 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744815876; x=1745420676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7pT35+V8RBeV9Mc9LqTDuhSOlu7PteaZppAzx6rau6g=;
        b=Msbb5A/884WtCLTuxapRHbOV9WbH6BQNES85FJTdsN4wWn9THDyhlb2ZpFBfCujGSn
         inhmFLBbVsbIHlk2S3BDU9drhRsAG9ZR855Nxe9o8MgSZStWinjYZ00ibFJbZe3M0CZG
         UdYH6kWp7pQnPuCxI15KjAXKNdDwaoH5MjIfoe24go8Q7Tp9ZrZS+FutWYPLZaWl8YX0
         LLE7yQzS5c3TWMtRzq7essg5XQk3auoTTJRbvgEZUzCHBEsjvx7PTlQSBpoCa5452d8A
         juc3poZtSDgyxl/LlLrq3atd+stsUQUA4W6dqg7QOF0ocS2hK1wP675/p17QU1MMG/2V
         6b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744815876; x=1745420676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pT35+V8RBeV9Mc9LqTDuhSOlu7PteaZppAzx6rau6g=;
        b=hahwps0lo6QnXAS+vDbU2ZlqhpoyMt16qlkIKGU3kiiPsTf5656Dmj5EchZuC2Xubt
         RSOsszsIwDFuqNv3rmUDENPGHDCCYNs68UteupCahqmpmNQ2QkdaKLIKcivgLi0qnwmJ
         l+gC3E+PS0X7tBhMefxPeFAHZ3G7ku4sOzNtSzKvQGXNC4ZUbGmSkMSBnlWPoKRNs04L
         nmnAWtD+rcHulYxDNZELAlk+fnjlW81B2dXlIv3GUiSbSe5HUA7yGR+utcIMH8crxxfz
         djpUiYw4p7plrOVK1uB9P/Rp7+oq4EZ/awkTIoDrptbL+1CWWISYDi+/EXZFm4SGqFhU
         5SOg==
X-Forwarded-Encrypted: i=1; AJvYcCVvaBBTm2O8GSGxBQOX7g/dMx2pdqnNEq+yslC4e7L/1mbrZYPXKN3awFBlwX3/jgqUO2pD3PVI@vger.kernel.org, AJvYcCX6WF6g9qcWWPIB+3TrnCaMYfMTWf2K7/Sz0V6SxRJ2s+OZNpvayVuqHSzGqMF/HR6Dk/Fs@vger.kernel.org, AJvYcCXAb8OP8qURNQvPaq5fv5q+YANTyhGaNEUBFMoe+IUWFXa8zk+5Y2Ij/1gK1LXTeRQH3h4L7CBXibSTfLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYtisKBCUbTJIjx796YmeYQRJs/iknduahMKlp5RBTCG8g6G1c
	+MkMmZ8044ycWB7mDEaSCmMQ2ZPqzmP8FHbM++CkCQvYqUIRvzFC
X-Gm-Gg: ASbGncvU5YwPyDTC5xcjuVf0I/9WyCk+xn6EaDlBttJKoKwkXRR78JU82PJpwoCoyZS
	kmJnRP8mKmEJWEmtDp3/SYCzhi5av9sXxjYv13zHUYbRxPhwypz15Nvhxyv84w9ijICPkywK4dp
	xvNBff5u6RYTRYc10RyeaGHkX0wi3ANxzzP8bRQ8DF7WozGRT4anZ5NphYxfP2FW5WczUn7r5gu
	ZnA7fqHg/XmPaEntvFgjbh2WsaDkrVUfimfO5K8J4DVZJdKKRkl0WOGqnGIi33QrbBtbssgw74O
	sR+vKtiGiBMjxsl+mbqZuF4hXBgidOhQ820zS+QU/3o8M2bmQmjqq3ob2geVS5wL57itPlpBgum
	uPXs=
X-Google-Smtp-Source: AGHT+IFe70dbGyjGUfP6DKrUnE2JPkJFtUOdZH/9mOEmn3TQ1RWJF0i3Mbzb/Dsr/0bYDlDLorlv5w==
X-Received: by 2002:a05:6512:3c85:b0:545:8c5:44cb with SMTP id 2adb3069b0e04-54d64aab466mr898300e87.31.1744815875881;
        Wed, 16 Apr 2025 08:04:35 -0700 (PDT)
Received: from pc636 (host-90-233-217-52.mobileonline.telia.com. [90.233.217.52])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d5104c6sm1695748e87.195.2025.04.16.08.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 08:04:34 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 16 Apr 2025 17:04:31 +0200
To: Breno Leitao <leitao@debian.org>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <Z__G_8VNrgUpfpuk@pc636>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <Z/+7LMnQqtV+mnJ+@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z/+7LMnQqtV+mnJ+@gmail.com>

On Wed, Apr 16, 2025 at 07:14:04AM -0700, Breno Leitao wrote:
> Hi Boqun,
> 
> On Sun, Apr 13, 2025 at 11:00:47PM -0700, Boqun Feng wrote:
> 
> > Overall it looks promising to me, but I would like to see how it
> > performs in the environment of Breno. Also as Paul always reminds me:
> > buggy code usually run faster, so please take a look in case I'm missing
> > something ;-) Thanks!
> 
> Thanks for the patchset. I've confirmed that the wins are large on my
> environment, but, at the same magnitute of synchronize_rcu_expedited().
> 
> Here are the numbers I got:
> 
> 	6.15-rc1 (upstream)
> 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 		real	0m3.986s
> 		user	0m0.001s
> 		sys	0m0.093s
> 
> 	Your patchset on top of 6.15-rc1
> 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 		real	0m0.072s
> 		user	0m0.001s
> 		sys	0m0.070s
> 
> 
> 	My original proposal of using synchronize_rcu_expedited()[1]
> 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 		real	0m0.074s
> 		user	0m0.001s
> 		sys	0m0.061s
> 
> Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
> 
Could you please also do the test of fist scenario with a regular
synchronize_rcu() but switch to its faster variant:

echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp

and run the test. If you have a time.

Thank you!

--
Vlad Rezki

