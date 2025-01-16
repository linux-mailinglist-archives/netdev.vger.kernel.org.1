Return-Path: <netdev+bounces-158776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56551A13310
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 07:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A3E188ADD1
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851818C035;
	Thu, 16 Jan 2025 06:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF06D155743
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 06:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737008670; cv=none; b=NQNY3kjFw9yctk2Xbqo7hZz+QruWYLRaisZxfyHWHyLJK1UB4dqVgRJkXoN0aK/SUdveQcw+bBcqr9YWuQ4SimHZQtnQMuUoCMa3o/4fMNgmyzdCRyKfqe8IoinLmskmXtXMRvqWsxmbknZXRvw9+K2+B9/cSch/kNb3Ab8shK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737008670; c=relaxed/simple;
	bh=YqS28taoe2QcEA39yaojYaAoCyeLdse6trded9GWEs4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrWXEYTYYC2znlbENb8b8yOzZtnlAyzt/F6yjnSiW1mgTsbBQj5X81e4s5//fdU3D+5EVvO3ISdKHFU64UsoEZ6+Dhi0Jl+RTvaD7qdrdY89uALYBJD+z46+fN1KZcUShSJkGnRqVnC9ysImPQ2s3RBY0OHPkEF0ICJeHwCNEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas9t1737008653t472t44704
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.187.167])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14527688114952598449
To: "'Richard Cochran'" <richardcochran@gmail.com>
Cc: <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<horms@kernel.org>,
	<jacob.e.keller@intel.com>,
	<netdev@vger.kernel.org>,
	<vadim.fedorenko@linux.dev>,
	<mengyuanlou@net-swift.com>
References: <20250114084425.2203428-1-jiawenwu@trustnetic.com> <20250114084425.2203428-5-jiawenwu@trustnetic.com> <Z4aPzfa_ngf98t3F@hoboy.vegasvil.org>
In-Reply-To: <Z4aPzfa_ngf98t3F@hoboy.vegasvil.org>
Subject: RE: [PATCH net-next v4 4/4] net: ngbe: Add support for 1PPS and TOD
Date: Thu, 16 Jan 2025 14:24:12 +0800
Message-ID: <067101db67df$422cecd0$c686c670$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQKnw1dDjg88W28lNwlExgbrf+Wj9wGGMHfHAhFqqr2xY3f9wA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4ZILu3POr3ONuM24q5/JVDcf+ULkevHSQmX+7sznIeh5coNIXkUlq4A
	p9EIE6u1Vx8kjdbdDLJR6D9cK4+GmXgkxUoSnwr2YW3SxSQGbSeo3smofe5QcEnESG1vnm7
	j+QQO3m3L22/tkqA0eiuWVouY9j3r0sxYLiY5Mqe3SbdJ7T5Tn1kE59Z12tbot1n13Le0+O
	eppPd3bWFOvKiFz3rLerK6IlvQ7i7p0hY3zY57HsXiyKCWZHAbz7QOGIPPwBPRpZFuho0Ja
	rNFSj+gDAJW4I6Jr0rUt6m/utqL2h8qWCT5UdCQbZ9aEHP9mJ/8JJRqkwX5WFXnCfuoL5pg
	sUyJEjLifz9CudQ8hbs+21Vv6L+LhDGsWDJeNfY3S4IToYrXyjVsfZESfIOvIomrbZNz2cI
	Wut76AXE0GfIWImHElk/TkN8o0wkLkkcdyDWbLBe2KAt4NTO/QF7EJ17S0awAIsGOYMHRfk
	b5IHUZjzKLy0DX4kTGXBBdcgGwLC+OUf+mQ5Qbbvgf6gzbaPCnvIb3YiVihGGyvt2r4rtjX
	lwPNg/XZpjIq92ga26cvCyuegRlxsHU32EqmckAwLrEF3lyO6SIomOBu+Cip6GKL4PxrXzn
	awexSPlCZY8z/AzKfsiyXkU80eJth3eh5FdOC8FymJO9/dfvfmenbt9S0mnzi2EmdP8928Z
	FnckopNYhUM4hz23qlU7XIFmqTz81StM2zYmcjJJV4rxFuwFn+HTxEjfprWQB3fkWA5Iz/R
	8w18FsRVU7U7GVKR196klfi8c3XJ8PB/AZ75z85nElYzY8gv0SDoV4Fd41JGeiuDJx1H5iB
	RNdwcZ7UsMJOeuK4qUckXcPM+W2mSA5aE7Qu0bV7WBkVaxI/g5ryltxh+E62VoQrJ1hZ0hI
	4q22PsdxnB1HQGu96LEr+TEGEOBeQ2CDUjeDtanwnoEXsPT/LO9f4/Y0dwzpvvIMKjhCBMC
	mF+caieCsf8QHOZfOsZTz1GqFpMYn0FjEj+RzA2HkxIfxUTotHoqnF/SMLD80c5IBg98=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Jan 15, 2025 12:25 AM, Richard Cochran wrote:
> On Tue, Jan 14, 2025 at 04:44:25PM +0800, Jiawen Wu wrote:
> > +static int wx_ptp_feature_enable(struct ptp_clock_info *ptp,
> > +				 struct ptp_clock_request *rq, int on)
> > +{
> > +	struct wx *wx = container_of(ptp, struct wx, ptp_caps);
> > +
> > +	/**
> > +	 * When PPS is enabled, unmask the interrupt for the ClockOut
> > +	 * feature, so that the interrupt handler can send the PPS
> > +	 * event when the clock SDP triggers. Clear mask when PPS is
> > +	 * disabled
> > +	 */
> > +	if (rq->type != PTP_CLK_REQ_PEROUT || !wx->ptp_setup_sdp)
> > +		return -EOPNOTSUPP;
> > +
> > +	/* Reject requests with unsupported flags */
> > +	if (rq->perout.flags & ~PTP_PEROUT_PHASE)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (rq->perout.phase.sec || rq->perout.phase.nsec) {
> > +		wx_err(wx, "Absolute start time not supported.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (on)
> > +		set_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> > +	else
> > +		clear_bit(WX_FLAG_PTP_PPS_ENABLED, wx->flags);
> > +
> > +	wx->pps_width = rq->perout.period.nsec;
> 
> This is still wrong.
> 
> perout.period specifies the *period* not the pulse width.

Thanks for the guidance. But what I'm really confused about is how
do I get the duty cycle ("on" in struct ptp_perout_request).
I try this:
	echo "0 0 0 1 0" > /sys/class/ptp/ptp0/period
to pass the period 1s for 1pps. Then where should the duty cycle
values put? Seems "rq->perout.flags & PTP_PEROUT_DUTY_CYCLE"
always be false.

+       /* Reject requests with unsupported flags */
+       if (rq->perout.flags & ~(PTP_PEROUT_DUTY_CYCLE |
+                                PTP_PEROUT_PHASE))
+               return -EOPNOTSUPP;
+
+       if (rq->perout.phase.sec || rq->perout.phase.nsec) {
+               wx_err(wx, "Absolute start time not supported.\n");
+               return -EINVAL;
+       }
+
+       if (rq->perout.period.sec != 1 || rq->perout.period.nsec) {
+               wx_err(wx, "Only 1pps is supported.\n");
+               return -EINVAL;
+       }
+
+       if (rq->perout.flags & PTP_PEROUT_DUTY_CYCLE) {
+               struct timespec64 ts_on;
+
+               ts_on.tv_sec = rq->perout.on.sec;
+               ts_on.tv_nsec = rq->perout.on.nsec;
+               wx->pps_width = timespec64_to_ns(&ts_on);
+       } else {
+               wx->pps_width = 120000000;
+       }



