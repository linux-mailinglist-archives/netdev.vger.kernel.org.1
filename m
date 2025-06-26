Return-Path: <netdev+bounces-201625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D2AEA201
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20A76A5DDA
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF85B2ECD2D;
	Thu, 26 Jun 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN9TiVZg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399972E6D22
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949619; cv=none; b=kEELtbpuCiAUmhKNGEvdKPAuwcgeaNHytHcTyRSzctlAQt1IglCVQ9twdq+oZovBDTDYUzxjVGigEI/6XdqVFCpcL0hpWLSh4opwZmUWke27cLOVtoY5cVWWXE8yE6dlWIR60994RInqwk2H8UAHS4ueg7N2AdTSuAE/ilGnlVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949619; c=relaxed/simple;
	bh=Oc4fXNyPe/vN5iq+rcEfa0vwKmQVQUxSX7yrff7fqzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDSwbPwG65JZR1e8G79llcgD67HQfdX0v8Cxf8HGiGSSBgXciIUGYVGDMUVMDoH/0ia0niwPEBLgoFgmzMORZCPbV/uIpIonYeGil5WXGdlb5cR+HPabRKH2wfuv121wkdhzkxpsPtmgYxgE0+H5tf41D/klyIKoDsjcrKZs690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bN9TiVZg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750949617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4rz0Zt077dNvqdQ7U1ycMz0yX9GnbmIpct4VisfhqA=;
	b=bN9TiVZgCM+a6nueNLE3TnCjjLbIs4OPIHOT4kmmHFAC2qSLU13gOlynCdT09FSQLTKYNY
	9y+MBrpnce0eU70BSudFH//xCcpyrL7kQKeLi8ZjpeHkXaLLvrsJkziGsG+0GDtc6BZfZU
	xJRkGy1vfc6ltDxGObniXyk/ImroOiE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-RLe8LLNQO7-qp5DeuTyeMA-1; Thu,
 26 Jun 2025 10:53:33 -0400
X-MC-Unique: RLe8LLNQO7-qp5DeuTyeMA-1
X-Mimecast-MFC-AGG-ID: RLe8LLNQO7-qp5DeuTyeMA_1750949611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20AED18DA5CF;
	Thu, 26 Jun 2025 14:53:31 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C9FF19AC0FE;
	Thu, 26 Jun 2025 14:53:26 +0000 (UTC)
Date: Thu, 26 Jun 2025 16:53:23 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher Hall <christopher.s.hall@intel.com>,
	John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
Message-ID: <aF1e40rkAO5mOFBZ@localhost>
References: <20250626124327.667087805@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626124327.667087805@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jun 26, 2025 at 03:27:28PM +0200, Thomas Gleixner wrote:
> This is obviously incomplete as the user space steering daemon needs to be
> able to correlate timestamps from these auxiliary clocks with the
> associated PTP device timestamp. The PTP_SYS_OFFSET_EXTENDED IOCTL command
> already supports to select clock IDs for pre and post hardware timestamps,
> so the first step for correlation is to extend that IOCTL to allow
> selecting auxiliary clocks.

> Miroslav: This branch should enable you to test the actual steering via a
> 	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.

Nice! I ran few quick tests and it seems to be working great. The
observed delay and stability with an AUX clock synchronized to a PHC
seems to be the same as with CLOCK_REALTIME.

Are there any plans to enable software timestamping of packets by
AUX clocks? That would allow an NTP/PTP instance using SW timestamps
to be fully isolated from the adjustments of the CLOCK_REALTIME clock,
e.g. to run an independent NTP/PTP server in a container. This might
be tricky as the skb would likely need to contain the MONOTONIC_RAW
timestamp to be converted later when it gets to a socket, so some
history of adjustments of each clock would need to be saved and
reapplied to the raw timestamp.

-- 
Miroslav Lichvar


