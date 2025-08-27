Return-Path: <netdev+bounces-217317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1820B38530
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E8C463662
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3565201033;
	Wed, 27 Aug 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdVUDekP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D317A31C
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305688; cv=none; b=K7MV/fFO/xS+B0WFWwmDUtjaeuaQ7Jh5DcthVCmBBXlis9fAKxp5LRPOirYibtWzrXhZMFnFgFLnhvpIhIJO2FtySNLkm3aOiIWGvhaY/OY1X2xKn9yMW2zMR7RebwdR90j/HuERiFsvN2kNqwErZhy5V/VXUHDHfW6i5J1fEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305688; c=relaxed/simple;
	bh=CKdaNBDE20G7CsorB4c2AZ2QGQ9WRtSGsu2U1VZsvjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9m4fhrwWuNXDAElDMaOWpDj/mw6CjahmNUUh9mDoPdKI0GpC5Gz72OKwcnKO4jMiDfM5MNswdkWgaB1fH6TlpXMsCIcqGYgMM7WqbGFxBWvP2rstdmZjI4ZHZHSQkt9M19f6s9lkgUuJOwktQbxX3ucgh7zz2DI7MStQ/1G5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdVUDekP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756305686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdHEF+eV56aJV+vBoHiN2XiyA3YYnRxoJ8lPFreiJp0=;
	b=LdVUDekP6pm4a1+1Kzm8x4WY9c4O5zalAV/pRALUznLppa66veSCaUWWPrPjxH4VUqrRpQ
	peBFS3X7fsVyt2ysk/YI14utqbEHS8SzWvY9NzF+gfwKbWB+kvgGB+x0mzqYcycV0EQ+kU
	p3P0pWf8DFp05zQ7uN4cluNFrckp3xA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-MEdxNHV-OeumsV0o5eWsAg-1; Wed,
 27 Aug 2025 10:41:20 -0400
X-MC-Unique: MEdxNHV-OeumsV0o5eWsAg-1
X-Mimecast-MFC-AGG-ID: MEdxNHV-OeumsV0o5eWsAg_1756305678
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7DC6D1800290;
	Wed, 27 Aug 2025 14:41:17 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB1341800447;
	Wed, 27 Aug 2025 14:41:11 +0000 (UTC)
Date: Wed, 27 Aug 2025 16:41:09 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <aK8ZBWokfWSNBW70@localhost>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de>
 <aK8OrXDsZclpSQzF@localhost>
 <20250827141047.H_n5FMzY@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827141047.H_n5FMzY@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Aug 27, 2025 at 04:10:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2025-08-27 15:57:01 [+0200], Miroslav Lichvar wrote:
> > Anyway, if anyone is still interested in finding out the cause of
> > the regression, there is a thing I forgot to mention for the
> > reproducer using ntpperf. chronyd needs to be configured with a larger
> > clientloglimit (e.g. clientloglimit 100000000), otherwise it won't be
> > able to respond to the large number of clients in interleaved mode
> > with a HW TX timestamp. The chronyc serverstats report would show
> > that. It should look like the outputs I posted here before.
> 
> How does this work with HW timestamps vs SW? I can't believe that 1k
> packets are sent and all of them receive a HW timestamp.

From the results I posted before, the machine (CPU Intel E3-1220) with
the I350 NIC can provide about 59k HW TX timestamps per second without
any of the patches, about 41k with the original patch, and about 52k
with this patch and pinned aux worker.

The difference between ptp4l and chronyd is that chronyd is
asynchronous. It saves the timestamps as they come from the error
queue and provides the best timestamp to the clients later in their
subsequent response (NTP interleaved mode). At higher rates it's
random, only some of the packets get a HW timestamp. But the clients
can see less accurate (SW) timestamps as an increase in the measured
delay and they can filter them out if their clock is sufficiently
stable and the interval between HW timestamps is not too long. 

-- 
Miroslav Lichvar


