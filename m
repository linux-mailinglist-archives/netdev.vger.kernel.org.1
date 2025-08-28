Return-Path: <netdev+bounces-217698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B90D6B39940
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F603168162
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D463090D7;
	Thu, 28 Aug 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvV7cpB3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BB13090E5
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375920; cv=none; b=Qqcv2Q5nremtEWDY8Sq0ZAXfq0KPsnN0y52ONPx5RNJPIY6fqNIvfLumec7/cPUbKv+9XKwHbuT0rOCs4bH9/oQ7pj8sVuXAsACh0n99GG5hQWtvmzlZ4OCmZBv2jBxpQbsenv53JqjUlmr3SuVr1s7uP0mpGIF0+HHQjB7XpNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375920; c=relaxed/simple;
	bh=VbNEku4Tnssfygf2im1Mm5nS1uoVc6ry8cQso1aNxoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo5WpqxiG/cU74E3QD5PRTfcdp3BuxW6ELr0i8yCaTMXslPy1AYI2vhB6zKLug+pgFtSimAdLlxKxiti77L5Q1hA9o7sYEfuArg8ZgsfbMOwjxzeCtI3vRT6mmw9NnZmkeIhmrmSnUdFz/+pl1dlirUL8KnuFicMFSh/PisEOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IvV7cpB3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756375917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LebI/sztpWCwrov95WsSE/6NigzFhH6ySTmwoHd0X5k=;
	b=IvV7cpB3rVlutZr628sl/X2hDhdYFTX906zQUlUdxwUpaNltNHWLcUsa0PwS8TbzYESwRB
	OJn4dZAr1qQhQZ5wXJs5w1R2zG5ERQOm3ySommMq7yR0maJHVhc8dSOAGr94cQgrYi8nrN
	8wDTZJxWEe6hoJn2x1e3yNAMM2mFVa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-WM-4akCwOTq0yceF6t_Wog-1; Thu,
 28 Aug 2025 06:11:54 -0400
X-MC-Unique: WM-4akCwOTq0yceF6t_Wog-1
X-Mimecast-MFC-AGG-ID: WM-4akCwOTq0yceF6t_Wog_1756375913
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FBF195C27B;
	Thu, 28 Aug 2025 10:11:53 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6292E1800447;
	Thu, 28 Aug 2025 10:11:51 +0000 (UTC)
Date: Thu, 28 Aug 2025 12:11:48 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND net-next] ptp: Limit time setting of PTP clocks
Message-ID: <aLArZFRxZ0AjKoRk@localhost>
References: <20250825111117.3846097-1-mlichvar@redhat.com>
 <20250827173708.398bdb99@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827173708.398bdb99@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Aug 27, 2025 at 05:37:08PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Aug 2025 13:11:13 +0200 Miroslav Lichvar wrote:
> > -		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
> > +		/* Make sure the offset is valid */
> > +		err = ptp_clock_gettime(pc, &ts2);
> > +		if (err)
> > +			return err;
> > +		ts2 = timespec64_add(ts2, ts);
> > +
> > +		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC ||
> > +		    !timespec64_valid_settod(&ts2))
> >  			return -EINVAL;
> 
> Please leave the input validation (tv_nsec >= NSEC_PER_SEC)
> separate and before we call gettime. It's easy to miss that
> on part of the condition is checking ts and the other ts2.

Ok, I'll send a v2.

> Do we not need to apply the same treatment to adjphase?

No, those phase adjustments are very small (sub-second) and slow. They
don't cause a step in time, only the frequency. The value is already
checked against the maximum provided by the driver.

Thanks,

-- 
Miroslav Lichvar


