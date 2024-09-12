Return-Path: <netdev+bounces-127737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3C1976419
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD401C23672
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F5118FDDB;
	Thu, 12 Sep 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiTcdWCc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D218F2FB
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726128792; cv=none; b=BrfGJQ0OaaHHdzrsdUBvYf44qkqMUbD0RaG/WIShB5xiPCbcPXlWNCVTgvElsYFA439pD9d5SoQOVXeMujcHBtdkYHsRgngPi0UoZ915zTEWgZjrHnjHAHIob5tyWqWEW1GoQujUZM4JNxNdJe33FHpxBjE6le07MGKf/FtwnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726128792; c=relaxed/simple;
	bh=OIzbugZ8+w82y/GQ5XlRUkvrI/8TKghHlbg88MrRrf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j968pQZQFUGalFs7CjWiYaZ9+F5hh2E0frpWYuDogu5OiOOqJ7HKnf+UnjVFYDpt9DORpw2fDxXPA3bvflLV96T0PMhrifL8cpyVs315FVPtXLVLsRkca9EPdI6t07Fn5eW98wQm9fEPBF8u5TxubWQQ8/d84AkGC+h7J9EdZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiTcdWCc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726128790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I/d1SgyYtM49Uvgf3ca5OttSFKxWT9MmZxx9vMSYJgo=;
	b=FiTcdWCcz27U6O7WMN6QWSC7Q59WdKeJ3CJGTOMLFGmBSFiWxep+epu70lhEfjpdrHqXNu
	oD0YQXU/FDz/F+9GpFN5eHzpOIuWG8vws4RFuo06Bel6HeSPU6yPuxHfWb9no3hgXlZVSS
	pEjo+H1BnBKaF+F9VbHDsqYz/CPvwZQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-8wcMhIZmPzy_R_N0RYqfeA-1; Thu,
 12 Sep 2024 04:13:06 -0400
X-MC-Unique: 8wcMhIZmPzy_R_N0RYqfeA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D47141954B2D;
	Thu, 12 Sep 2024 08:13:04 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E816F195605A;
	Thu, 12 Sep 2024 08:13:01 +0000 (UTC)
Date: Thu, 12 Sep 2024 10:12:59 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Christopher S Hall <christopher.s.hall@intel.com>
Subject: Re: [PATCH 00/21] ntp: Rework to prepare support of indenpendent PTP
 clocks
Message-ID: <ZuKii1KDGHSXElB6@localhost>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Sep 11, 2024 at 03:17:36PM +0200, Anna-Maria Behnsen wrote:
> This problem can be solved by emulating clock_gettime() via the system
> clock source e.g. TSC on x86. Such emulation requires:
> 
> 1. timekeeping mechanism similar to the existing system timekeeping
> 2. clock steering equivalent to NTP/adjtimex()

I'm trying to understand what independent PTP clocks means here. Is
the goal to provide virtual PTP clocks running on top of the system
clocksource (e.g. TSC) similarly to what is currently done for
physical PTP clocks by writing to /sys/class/ptp/ptp*/n_vclocks,
expecting the virtual clocks to be synchronized by applications like
phc2sys?

Or is this more about speeding up the reading of the PHC, where the
kernel itself would be tracking the offset using one of the PTP
driver's PTP_SYS_OFFSET operations and emulating a fast-reading PHC?

-- 
Miroslav Lichvar


