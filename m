Return-Path: <netdev+bounces-173000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF99BA56CD5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46406177AF5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730EE2206A9;
	Fri,  7 Mar 2025 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkEjw4i9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1A22068E;
	Fri,  7 Mar 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363066; cv=none; b=DiVWGmXb+1vqxR1EYr5qqYMKr2ZQkhf+Kwrx6+Q7PH65g1g5x+CEavApxy0jQ0uDMbD7v2kMGRLAq4M2o8CS+IuJhzI8j+Ekzq8UJy+PEIgG16oK/SwxvbXQuWSCZMnAvpgk/80KJgRPx/5YMZEKbmiqtSeEh9B2vwADOlaBEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363066; c=relaxed/simple;
	bh=06EmkVXGLJLHmRuapma/2b4a3kb19YXKwlswLZ6GShM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FlvHW6nqhK/QUn7XPPegD2kY+qVutT/MoSs+FsAAuh29BBwQDZnUO1rqRuHqUm90+V+fhmh9ovgARz12mBDq8ERU8jP251Xx3egGdiRkCfJUeMltEWewz8Y4ygBYc24LryoM6wqlisKEHyIihumi/nCIlwoUFBrowUI5zGSIsdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkEjw4i9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fb83e137so12011006d6.0;
        Fri, 07 Mar 2025 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741363063; x=1741967863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l1m42Ib0dQvSDfkyIRddhXepvHretUXUApqQN5p9aIs=;
        b=FkEjw4i9BRPZN4sRZSRxiPLXyduiGdA8LNyTGdUZXmnbmZskKXQMLzCooBgCDjn5D0
         N+/bWQWT+t4XfsP4JrT4uf9YGwDBRhaNFhj9qZTc3xu737nIAxB4l58t3jnsuWg5NDRd
         DE77zLB+Mgm+TpQCzXuMDe1sLFIcZSJl/kYsgI0Usvxve/JlZanfPe1ttDJlGRuG/eFa
         XfRKazmkO+qq/jO9aEJVtVdOvuEMFXbVMWklLrJ76vkmi8r2lqCJPFtqSPSvhz97mv/A
         RvFC54IjtZP9g6yLBFjV2z2QMuZxqup6DRT/BSkCyP/wLbKwKAxjVZjJa8YMvkspY72U
         Gebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363063; x=1741967863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1m42Ib0dQvSDfkyIRddhXepvHretUXUApqQN5p9aIs=;
        b=AcnRZq7slVNHWoNR4tk9gsyh38C/ewk3jUjD0dTGnOcxkdIwgjDKHb0a2mLlnir3Rt
         9uar/8zTQXiphG7OjuBg/OpnUjQRBb/XsYy7x+uhXYYbE4/n+LAFv8GmFtPIjnzPrwbm
         GAx4v5KMjRdLHGTjTP+g1bng/bN+fR9/LvriKGFSThCaqa91XaUkxRaiEo32Dcu5Ugg5
         eCVv4m67g/2vxgSr1c0yew75tU8EySLQi/X6icMeGd+6uYDmid0X90VC50O41kpP6731
         /kKhefdNjOsGI+omFIFWEqNg276tOsfbkUCpmCxXqhP5fudkPZQztbhXTNb8ttt+6jiQ
         Ogmg==
X-Forwarded-Encrypted: i=1; AJvYcCUf9Nky8Ef8iMwPxsEUD7fAH5yOx9og37ke/jyXSU6hb6KlNZP9Zx6cBxQ6v/+1IxEjqV/WM6vRo6bDAgY=@vger.kernel.org, AJvYcCUsaSGO8h5UT34lZjNfTTkeCzFmrK7QqvH3fHdZq2XAmAGqy3WsiZ3l5/b1oShYN7jfLg2si0R2@vger.kernel.org
X-Gm-Message-State: AOJu0YzUWizCrUFLZrO4DksWiyri/Xzlw8Qa0kd2YyMx5hVcVq/NEysh
	YhKGfiSG7dQcp1bf9Hd5pWskjfpgwOUU8WFT1xtg19TwCktYkbGofU8yrA==
X-Gm-Gg: ASbGncsUI/QNogaAodh8OV+7x2yqA80Y64Q6mn5Qj7KXhwQ/1RqIEPn1oxxKfVhO+7U
	D0ncWJAsFPqjOO24hIsjTrl8vkyuw/7ZPxXnJY76OShLEGev0trnLNValcZgnfrsd1GdXGsPVrU
	UTZAcKFo8Xe4tzypI4ruyIDuX7MIajD+9PTPIcRDnubNcb+N4fi6RB+G5bjRcXl+5IHoBOwaWid
	w9B6nbrUVN+dTwLD28xkFKe1g6y/+/y/Xw7RPrTMqp6/90adYEMLA/DVOUojWo8dm5tICeXRgUI
	VEnNuAuFbGiuFDj0Pj2KV7xzICsiXbtwYbRTzx1LJ3uRvRK+7KRiMYk4uWwQHaamx1qnoytZW1X
	02XRPAM41UdjneRbCQbFHEYItWYBOcyZMZ88=
X-Google-Smtp-Source: AGHT+IHxTWaP1km+uLRK7PcZc1sksBOrjLR8UDLfj2Ah0o+FIfnBjp//LRP8KQHhuUmPKC1maVS6Zg==
X-Received: by 2002:a05:6214:e84:b0:6e4:4484:f35b with SMTP id 6a1803df08f44-6e90066bb37mr44321006d6.30.1741363063525;
        Fri, 07 Mar 2025 07:57:43 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f708ffc6sm21079506d6.27.2025.03.07.07.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:43 -0800 (PST)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id B9A63120007C;
	Fri,  7 Mar 2025 10:57:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Mar 2025 10:57:42 -0500
X-ME-Sender: <xms:dhfLZ-n-OcVLc-PZW50dfpLrEidu8dhaM5QM6qhOubEsBZXMBTyZ2Q>
    <xme:dhfLZ137eGlxTQcab7Vngg4THwkf356KUSzSsCXQBVT5p2Mwu0RGr63LxuoLGz-Pi
    yOdchUXAv70fe0MCA>
X-ME-Received: <xmr:dhfLZ8rsdPFTeX6DMXIWUxbWdzlhNj3-z-r5jS_047W5Z6mGKsxseJ2wtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddutdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhg
    uceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dvfefggfeijeelteeutedtieeigeeltdevvdegvdejfeeiveegteehtdevleeuffenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeek
    heehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrg
    hmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehrhihothhkkhhrleeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghpsegrlhhivg
    hnkedruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgt
    phhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorh
    hmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dhfLZym6oZYrv-VpFAeLiMJKu1O-AWEFSSGkd3MuCRGjadqRFI_Biw>
    <xmx:dhfLZ83dLNhbTeMpadRkz2eiHQU-f7t-GvIvJExxpqIxDWz1OM3T3Q>
    <xmx:dhfLZ5s6QxpGZW8eYkT6mWAx8VfhZ-TlgTQEp_r87lCN2iN09Rw76Q>
    <xmx:dhfLZ4XHyHhIrVjvQ7UssT8W0CPlZAWL2jW4etYaPqJ32fg5axFl8Q>
    <xmx:dhfLZ30-Cx7K-1L0RVEisXbUJc0UNRBWQjdJ2gcKr3rW47dmTeRbAX89>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 10:57:42 -0500 (EST)
Date: Fri, 7 Mar 2025 07:57:40 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: bp@alien8.de, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, peterz@infradead.org, x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Message-ID: <Z8sXdDFJTjYbpAcq@tardis>
References: <20250307131319.GBZ8rw74dL4xQXxW-O@fat_crate.local>
 <20250307133946.64685-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250307133946.64685-1-ryotkkr98@gmail.com>

On Fri, Mar 07, 2025 at 10:39:46PM +0900, Ryo Takakura wrote:
> Hi Boris,
>=20
> On Fri, 7 Mar 2025 14:13:19 +0100, Borislav Petkov wrote:
> >On Fri, Mar 07, 2025 at 09:58:51PM +0900, Ryo Takakura wrote:
> >> I'm so sorry that the commit caused this problem...
> >> Please let me know if there is anything that I should do.
> >
> >It is gone from the tip tree so you can take your time and try to do it =
right.
> >
> >Peter and/or I could help you reproduce the issue and try to figure out =
what
> >needs to change there.
> >
> >HTH.
>=20
> Thank you so much for this. I really appreciate it.
> I'll once again take a look and try to fix the problem.
>=20

Looks like we missed cases where

acquire the lock:

	netif_addr_lock_bh():
	  local_bh_disable();
	  spin_lock_nested();

release the lock:

	netif_addr_unlock_bh():
	  spin_unlock_bh(); // <- calling __local_bh_disable_ip() directly

means we should do the following on top of your changes.

Regards,
Boqun

------------------->8
diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index 0640a147becd..7553309cbed4 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -22,7 +22,6 @@ extern struct lockdep_map bh_lock_map;
=20
 static inline void local_bh_disable(void)
 {
-	lock_map_acquire_read(&bh_lock_map);
 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
=20
@@ -31,13 +30,11 @@ extern void __local_bh_enable_ip(unsigned long ip, unsi=
gned int cnt);
=20
 static inline void local_bh_enable_ip(unsigned long ip)
 {
-	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
 }
=20
 static inline void local_bh_enable(void)
 {
-	lock_map_release(&bh_lock_map);
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
=20
diff --git a/kernel/softirq.c b/kernel/softirq.c
index e864f9ce1dfe..782d5e9753f6 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -175,6 +175,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned i=
nt cnt)
 		lockdep_softirqs_off(ip);
 		raw_local_irq_restore(flags);
 	}
+
+	lock_map_acquire_read(&bh_lock_map);
 }
 EXPORT_SYMBOL(__local_bh_disable_ip);
=20
@@ -183,6 +185,8 @@ static void __local_bh_enable(unsigned int cnt, bool un=
lock)
 	unsigned long flags;
 	int newcnt;
=20
+	lock_map_release(&bh_lock_map);
+
 	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=3D
 			    this_cpu_read(softirq_ctrl.cnt));
=20
@@ -208,6 +212,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned in=
t cnt)
 	u32 pending;
 	int curcnt;
=20
+	lock_map_release(&bh_lock_map);
+
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
=20

