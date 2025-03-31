Return-Path: <netdev+bounces-178367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF484A76C22
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C668D188ED82
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B468A214815;
	Mon, 31 Mar 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCFBnY8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35378F4F;
	Mon, 31 Mar 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743439227; cv=none; b=NUtR1otSAYnrku9WF7qlI+7LCAdAlhZdwUuvlqoKyxw2lOm81KAxXWZYNNHw8ZvWBOo9dC5tzSfKYsEb9430wgtl90kwIkDfMNDO0PkoJuq07KdQBS5Wi+08t1V9ePZ3MdaRNpAdoU1lR4ODEZ+IRH9+mVW2CchSfGN4vNwcdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743439227; c=relaxed/simple;
	bh=AYFUramL9FR2hoJVHPU1NGGSkE1T1sbmog92XXloJv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hy8FmaOqc05XPwW01Gjgwya7xUhYAz7DOqT8i4eqrmFm1IDZK8ANSatTVUjzRN+Iy/zTRz1ZaT3i8q18wID18Afi6AaSd81BQ01Fr01mzV2RuPOMSyBCQ95uqqHhm2XHp3BDA5UT6Oa+F4iAfHhUoxae/bJg0ao9ZkiE2UOrEjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCFBnY8W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-223fd89d036so98768755ad.1;
        Mon, 31 Mar 2025 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743439225; x=1744044025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dz9N0KZHNJSKflVhOQJGTKP9fs9EvMvsQxUyQyH/M1c=;
        b=QCFBnY8W161YLbYvU6ITYXKaBQIVoRufgmUQaoPjCBb4+MnHqdw4CNKJ5F9LiJNiQZ
         Gcm2wXXYIPh3oe8vpSroVqw5JLI9HxR8LAgZIgzMSo/OPYO8XkyzL/el+/JC3dkgNzFW
         PwhfSfXBKceYZctkwz02EjSdH/E2B6pHCpdxw7I9l/AXRwTYfW6qWWU1tNGfe9R1aYQz
         JIQv6dup8LtuRT/W22PSL26ZTnltgfUt0h3EPLq6CAk7ZXuvR8DPhhtOygkFcrdIBck0
         vC2duj5t8ARB67sKl3VVWLkYYYxtZpiqXHGKRSGU7v41DafnZfKuCtNswwN2psd7i7IJ
         ofVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743439225; x=1744044025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dz9N0KZHNJSKflVhOQJGTKP9fs9EvMvsQxUyQyH/M1c=;
        b=HNartIfoNOGCzVzYxck1Y5huybxHuv9v51RC4liSoAj/vV+a16cXZWmNatX6Ikqplr
         QmkKIo6KwsPEyY4R1ZTckRvCWeZ56+S7d006IEFQE4k5/dcv7xUIpiq9cugEX0MNvBq+
         x0BFACEtsHsk8QQyqrf04b4gu6rF7JdVzrFKFdbNt3emYsZcZ053+Y0L0O+T9o7/sI4j
         oYo5qu0yZYs9pouaEe/lAzbPIdtAq6lvxsFCWOmYv6m55o+aQx+zuBEdfr2halC/WmwR
         6EfVmwRzU9n1q6+AhAX4L7luuuoUUs4wdWxolrZTqfPuX5qJ5KL786dG10Rh+VbKpivx
         eMnA==
X-Forwarded-Encrypted: i=1; AJvYcCUIfdlSSxwvXVj+yWO1YJ8kyDcOT0T0R78klOBPQa011WEq6itxywCeG7tO4Qrv3NhUzdr+OiarfoJdB9I=@vger.kernel.org, AJvYcCWSd9SUaY51I6XJsPYltElyvcKdo+p4Ek8lQV+HLE8Pl6HQeOjXucyqHqBJIXYcd//DIlV6mCAl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywms6N5z2DNlOF1yvwPdYCRCx44nc1U1GH/RCj2M0G7eyncoXCs
	hk4NIQ4XrSo+FAFuB1c1iY4VDykAneR/uH92wxaUjb5w5BK7mTV6
X-Gm-Gg: ASbGncvGk3Q32GzVGDtWTkm/qt2ZJNdpVlF6UQkZtU9jZtde6B0X0kiFJRTMTAJMSDt
	9Wiav8FXcvYXFxey82rgoMG71n0jPx8+77gfXthWNzmlrMVa6s+8uDDbhz9T4IePEi7+9FPkJ5c
	gB2QJ5TyWqEkEpb8WdCMUUuRLes0tenJ0V6kM84k5PCzJArrsY8OisfHX7CSz22ick8CAxNtqAq
	zx8NHOEsEVwe4AoMaJuiYVzHOIgXjctpQhruDHheiGVCFRMQm8TFNNo3hpcK6nVKDsN0pDcHYB6
	F4zpGowCqji40v3Dke77AlfNnQHjokPd9/ocMnkBXYbqT+jdYxp3ig==
X-Google-Smtp-Source: AGHT+IFrMCP1PBKqC7tae7DS45440GgX8X4vbPNHIkLinUfhelvAilP1Pp5/T9e0yqtatcKWxgMYfA==
X-Received: by 2002:a17:902:cec3:b0:215:b473:1dc9 with SMTP id d9443c01a7336-2292f9fc071mr159229405ad.46.1743439225283;
        Mon, 31 Mar 2025 09:40:25 -0700 (PDT)
Received: from mythos-cloud ([125.138.201.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0941sm9802525a91.13.2025.03.31.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:40:24 -0700 (PDT)
Date: Tue, 1 Apr 2025 01:40:19 +0900
From: Moon Yeounsu <yyyynoom@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5] net: dlink: add support for reporting stats
 via `ethtool -S` and `ip -s -s link show`
Message-ID: <Z-rFcxj7XeiMHsz7@mythos-cloud>
References: <20241209092828.56082-2-yyyynoom@gmail.com>
 <20241210191519.67a91a50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210191519.67a91a50@kernel.org>

First of all, I apologize for my late reply.
To be honest, I didn't fully understand the code I wrote.

The reason I initially decided to use `spin_lock_irqsave()` was that
most of the other stat-related code was using it.
So when I received your reply, I didn't understand why `spin_lock_bh()`
should be used. That's why I started reviewing interrupts and locks again.

As a result, my response got delayed. However, I believe I should take
full responsibility for the code I wrote.

I still don't fully understand interrupts and locks,
as the IRQ subsystem is vast and complex.

On Tue, Dec 10, 2024 at 07:15:19PM -0800, Jakub Kicinski wrote:
> On Mon,  9 Dec 2024 18:28:27 +0900 Moon Yeounsu wrote:
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&np->stats_lock, flags);
> 
> I believe spin_lock_bh() is sufficient here, no need to save IRQ flags.
>

Anyway, base on what I have learned, I believe `spin_lock_irq()`
should be used in this context instead of `spin_lock_bh()`.

The reason is that the `get_stats()` function can be called from
an interrupt context (in the top-half).

If my understanding is correct, calling `spin_lock_bh()` in the
top-half may lead to a deadlock.

The calling sequence is as follows:
	1. `rio_interrupt()` (registered via `request_irq()`)
	2. `rio_error()`
	3. `get_stats()`

> > +	u64 collisions = np->single_collisions + np->multi_collisions;
> > +	u64 tx_frames_abort = np->tx_frames_abort;
> > +	u64 tx_carrier_errors = np->tx_carrier_sense_errors;
> 
> Please don't mix code and variable declarations.

I'll fix it as well.
Thank you for pointing that out.

> -- 
> pw-bot: cr

If I am mistaken, please let me know.

Thank you for reviewing my patch!

