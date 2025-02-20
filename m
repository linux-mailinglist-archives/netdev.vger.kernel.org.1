Return-Path: <netdev+bounces-168133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3DA3DA78
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE671699DC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C61E7C27;
	Thu, 20 Feb 2025 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BqfxR5XM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wDYzNgDf"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5811F3FED
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055984; cv=none; b=W34BiGk6NvkqmvwKBb6sgAADQ534kCRZJ8GQS2sZmfx+E+eipJeBMDmtzaj+1ABlgI/ou+ZI+Evmae+IPWaCLd4ttK5OoKF2YJQ9J14KRYIeam6D0z1UF91wqSlYl0CbCU/qhmYH6ARseYJlsCwnhFk4t+PJjxyQXv9orHA0dy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055984; c=relaxed/simple;
	bh=4m0j245OaKbq3QyDzbefaDj/EEwUdLVX7ruEIIqU6is=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TWzTqodIHlyt46VG8BZTNbx+JDkfDOTFNgpe/t2HU18U6JrTlPkFayAbJQLfOCXLV5AKmlRFVDx2QYSfsV2z894sasaIgGTHIpNYE/nyZtKXi/kffZDxu49mV31fZWzzuZqNsql7Ui1L/ql7jouFsafk1xLYMb8cGZereX2BslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BqfxR5XM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wDYzNgDf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740055980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylaua+XKZd+VU5ggcu5JJtpSVxRlg/cZccxD3/3MHdU=;
	b=BqfxR5XM4KIlxGVUmirXERzOEyjCjoXPI6tnfxq8oW3bLSUORrNzP1MWslVmWhZJ21f5Pv
	NniLtlWQgVLCom0AGaLNt+P+bcwziGZLgS/Bykrh/DryaQSn099h2+lGtk4cwTHRaF4pQv
	yOdfYXRZz7b6W1bjES5lHx41ax3UkV+NTdSIERmYaQL6tl6ERY99gKV7HtL5A9FoWpOMGJ
	yJQwI73Lcj5pteRonBbhew/DNmxNzfYMZDiCbv2h6c4AZDUFd256puKERGfJFt4s7ByI1o
	Jd5ylvLznapNI72ISe4WReNe8jRRp+VL+RjSHovzrww7lxGIbMTvb8aTFXynUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740055980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ylaua+XKZd+VU5ggcu5JJtpSVxRlg/cZccxD3/3MHdU=;
	b=wDYzNgDf/2yjWjET23PjuELhSvJjaBP3nLdOs/aq8KHBhptXtMG9xmI58lGKej5Oqo94xX
	cXzp6SPnk3AuoPCA==
To: Wojtek Wasko <wwasko@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Cc: "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, "kuba@kernel.org"
 <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
 "frederic@kernel.org" <frederic@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>
Subject: RE: [PATCH net-next v3 2/3] ptp: Add file permission checks on PHCs
In-Reply-To: <DM4PR12MB855850D05B3332C4DDA0D76CBEFA2@DM4PR12MB8558.namprd12.prod.outlook.com>
References: <20250217095005.1453413-1-wwasko@nvidia.com>
 <20250217095005.1453413-3-wwasko@nvidia.com> <87cyfgjp54.ffs@tglx>
 <DM4PR12MB855850D05B3332C4DDA0D76CBEFA2@DM4PR12MB8558.namprd12.prod.outlook.com>
Date: Thu, 20 Feb 2025 13:53:00 +0100
Message-ID: <87msegixqr.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 19 2025 at 09:45, Wojtek Wasko wrote:
> On Mon, Feb 17 2025 at 21:24, Thomas Gleixner wrote:
>> > One limitation
>> > remains: querying the adjusted frequency of a PTP device (using
>> > adjtime() with an empty modes field) is not supported for chardevs
>> > opened without WRITE permissions, as the POSIX layer mandates WRITE
>> > access for any adjtime operation.
>> 
>> That's a fixable problem, no?
>
> Absolutely, but to be honest I wasn't sure about how to properly change
> the access check in adjtime given it's a "generic" API. I ended up with
> something along the lines of:
>
>    if (tx->modes & ~(ADJ_NANO | ADJ_MICRO))
>      /* require WRITE */
>
> being that ADJ_NANO and ADJ_MICRO by themselves don't mean the clock will
> be modified. So the modes field is not really "empty" per se and the check
> becomes less self-explanatory.

ADJ_NANO and ADJ_MICRO modify the internal status. A read only operation
has to have tx->modes == 0 and the result will be served in the
NANO/MICRO representation which was set by the control application which
can write.

adjtimex(2) is clearly saying:

 "The modes field determines which parameters, if any, to set."

Consequently modes != 0 requires CAP_SYS_TIME, while modes == 0 is
unpriviledged. So requiring WRITE for the FD based posix clocks is not
asked too much.

Thanks,

        tglx


