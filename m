Return-Path: <netdev+bounces-190325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF60AB63D9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8023BA9A7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15E204C0F;
	Wed, 14 May 2025 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVR/tEoN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD86E156C69
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206798; cv=none; b=Uz3H5+r6R0FS2iwyk1oVpE+ZIXAZIkhKfc/Cu2zLFQgGNJOAY+zUbQozs89jYeJ9lD6M6isKj89J1MIDmFMV/7oBwPr58Q+Rp8XG0j6uda1skaM1qbQqyXDmyVSu/RBihXbH+7SLMAOdOSm1t3OjWzWyzmQ09xw7MHFE1lwYqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206798; c=relaxed/simple;
	bh=2eIWOxcrNRhqnbnz2MbAjnSYx4Blh7k/OlokBmu07Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQQKyqcJ+QGvYSaXhq67lRvtSLwsq/f0ruBOB2dm+z4pIXo7H09VN81K4we9ttQZaQYHyU7ZE9qQZ2sJ8DkD1Bt/vywHsTpjDb86uFB8OmwGqoh1KX7DtMKCPtvfRuQH81rMf7yl95222/6AK2/Dd6BIR4CX8GYYvMgbY3WiCHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVR/tEoN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747206794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AUOZl6lxMjQuCh8vJjhRRDeN8hH1et3Rm9US7z/HtV0=;
	b=aVR/tEoNrOJKP6EG53ZQhc4J7EHDqHgg+DQEOM77F1SJsuhk2sUWsJH+AcEEAD3yHQrVkR
	r0yx3OJIKBReG9qML+bUnFUioksdmiKB/+sH6wUBFzPH19HO5kQXzWxBA4B+CqrGDuz0Ri
	SksTxfP0B079Y8FC/vtZNI0l1Xa7YUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-31-eYDFsvi4Nq2FH8OQdLYpoA-1; Wed,
 14 May 2025 03:13:09 -0400
X-MC-Unique: eYDFsvi4Nq2FH8OQdLYpoA-1
X-Mimecast-MFC-AGG-ID: eYDFsvi4Nq2FH8OQdLYpoA_1747206787
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F316618004A7;
	Wed, 14 May 2025 07:13:06 +0000 (UTC)
Received: from localhost (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0454A1940E95;
	Wed, 14 May 2025 07:13:01 +0000 (UTC)
Date: Wed, 14 May 2025 09:12:59 +0200
From: Miroslav Lichvar <mlichvar@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher Hall <christopher.s.hall@intel.com>,
	David Zage <david.zage@intel.com>, John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Nam Cao <namcao@linutronix.de>,
	Alex Gieringer <gieri@linutronix.de>
Subject: Re: [patch 00/26] timekeeping: Provide support for independent PTP
 timekeepers
Message-ID: <aCRCe8STiX03WcxU@localhost>
References: <20250513144615.252881431@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144615.252881431@linutronix.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, May 13, 2025 at 05:12:54PM +0200, Thomas Gleixner wrote:
> This series addresses the timekeeping part by utilizing the existing
> timekeeping and NTP infrastructure, which has been prepared for
> multi-instance in recent kernels.

This looks very interesting. I ran some quick tests and it seems to
work as expected from the user space point of view. I can enable the
clock and synchronize it to a PTP HW clock or the system REALTIME
clock. ADJ_TICK works too.

To get accuracy and stability comparable to CLOCK_REALTIME, there will
need to be some support for cross timestamping against CLOCK_REALTIME
and/or PTP HW clocks, e.g. a variant of the PTP_SYS_OFFSET_PRECISE and
PTP_SYS_OFFSET_EXTENDED ioctls where the target clock can be selected.

The "PTP" naming of these new clocks doesn't seem right to me though
and I suspect it would just create more confusion. I don't see
anything specific to PTP here. There is no timestamping of network
packets, no /dev/ptp device, no PTP ioctls. To me they look like
secondary or auxiliary system realtime clocks. I propose to rename
them from CLOCK_PTP0-7 to CLOCK_REALTIME2-9, CLOCK_AUXILIARY0-7, or
CLOCK_AUX0-7.

-- 
Miroslav Lichvar


