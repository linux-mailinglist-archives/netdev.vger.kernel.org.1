Return-Path: <netdev+bounces-157597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3657BA0AF53
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6A71882C08
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530C191F99;
	Mon, 13 Jan 2025 06:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1E231C87
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750022; cv=none; b=jT6VcFh8SrVKwPp5AZAmZpNALGRoKVBonP9NSYeuYzuSPzD9qx8wfr3TL3zEE4fMXQmuA8oDXFr/oZEuWIFRvbQMzXNR4IieBAgbl2ZMJn5PSRswF5O+s2qx1i8jwuMbFHlIVNSJ2Ww+W2eV4AsjN9QW4BoLYNGtIAJwA2CtvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750022; c=relaxed/simple;
	bh=x9smgKVqAYh2y8P63mcNURtLx1yHuQbec9dJArr4ds0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=RMreWEesf8xTX5lvZjfTf5EySvVGwwF/9uXN47C8vfDMzBD41sp8D+4tUOQ4pcISVHu9jjKD3Ye9tG3THtCJe6lISats9gtP3LyacoNaOhky6vQ+puXou9RR2/tJ/Vc7BBomzGnR+JFpxjWOaqoCQD8KiNfzwjINhaZsQCGdjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas1t1736749826t140t11739
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.58.48])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15171270368929639658
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
References: <20250110031716.2120642-1-jiawenwu@trustnetic.com> <20250110031716.2120642-5-jiawenwu@trustnetic.com> <Z4KnPlCtlhHjFI6z@hoboy.vegasvil.org>
In-Reply-To: <Z4KnPlCtlhHjFI6z@hoboy.vegasvil.org>
Subject: RE: [PATCH net-next v3 4/4] net: ngbe: Add support for 1PPS and TOD
Date: Mon, 13 Jan 2025 14:30:24 +0800
Message-ID: <057b01db6584$a13a69d0$e3af3d70$@trustnetic.com>
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
Thread-Index: AQIn7G+o1Szt10K74NpdpmE6uZiDNwH01nhwA2bf3ayyUFApIA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4WhQbLQyIqS3p1meRUnJy365UkE+Xli06R4QH68GK/g+WY6HOWqgLmd
	n8ez7THFZOwGnmh1tK5QVslCa3EtUBdnC0re5+j8p62StczJLiq8j1XtasBw7tQTqJwiCtO
	Qi1/IKzV0R0+pQDxDdXqnnugip9DBrvq7mHJxT1OOF9KIbCHHn3TI9qNpXqGKFL0nGvDKkK
	uS7xlU1UM0NQU/dTXW/n9QwfQ9OBF7+Fs9X/kQJDg1bTGK/osEWZRWnptYHeFFwuwW1FGgb
	xlkDEuiq2EIICEdRJqZqzUQqkyqHmYCE/RXxFPmKZMQeECFYhzEqSDvYPNB9YnNG3+9iUau
	WXKKZtfIwP6X4saV8OhqfjHnH21KzdkdBpLfWPmabci28iGeyWcR4aj2CFGcMF9VZwOMDBE
	pyVAeAhWTmxymsUW/nA3JHmxMOvBOXw8aK/SD2CjOSq7eKZajLWsOTY6rXTu42AJx+t9t8s
	4+Un9OyR3G8XwcwIdHZzC+Dgj+skpEvzey3FCPoV9/PDjC7v/RNt5KbwkX4n5b3KzCVLpur
	I9xAR8t/BscFzVwzYHASGu8MEMHsxkL5o6e5Cn26scJOdBLuGL91mF7WaYQ33TgAxjGVvT2
	yRiUpX3DoS3SDZwh/tY9j7jQko6HB9uEFMHbK6jWzff/ex0AJIAUcGAiltKUgoWr2PQFQzi
	OgGajXTNsnT6QivSScAmeRugAfd0AW5r5gzJnWORKWHBv2mA/MjAGBmc66/SltDdtsKod8g
	+HlIbrRgvoKKqUmPmPtPvY45yPbRT2lnlXUJqZJpezkDiUqXRKMbivPFOk/Ou4KH4BbB+CD
	K3LEhvlLhzvpS4L7yiFWOKzzoiBPERmeUNh34VBgWbZC8KFgpsCqphATIywhqKeF/noLrEM
	QJsWBd66sUYen2dtcntc0c3orgOi17GiAaeEbd5vtGuLk/eDuQRal6ZtVErH6VcYZZw8eDK
	MfmkYQA9toB4/AiFsShnL8nhlfBMp5p8HW3LxBzk7Y+Jmog==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Sun, Jan 12, 2025 1:16 AM, Richard Cochran wrote:
> On Fri, Jan 10, 2025 at 11:17:16AM +0800, Jiawen Wu wrote:
> 
> When I quickly scan the logic here...
> 
> > +	/* Figure out how far past the next second we are */
> > +	div_u64_rem(ns, WX_NS_PER_SEC, &rem);
> > +
> > +	/* Figure out how many nanoseconds to add to round the clock edge up
> > +	 * to the next full second
> > +	 */
> > +	rem = (WX_NS_PER_SEC - rem);
> > +
> > +	/* Adjust the clock edge to align with the next full second. */
> > +	wx->pps_edge_start += div_u64(((u64)rem << cc->shift), cc->mult);
> > +	trgttiml0 = (u32)wx->pps_edge_start;
> > +	trgttimh0 = (u32)(wx->pps_edge_start >> 32);
> > +
> > +	wx_set_pps(wx, wx->pps_enabled, ns + rem, wx->pps_edge_start);
> > +
> > +	rem += wx->pps_width;
> > +	wx->pps_edge_end += div_u64(((u64)rem << cc->shift), cc->mult);
> > +	trgttiml1 = (u32)wx->pps_edge_end;
> > +	trgttimh1 = (u32)(wx->pps_edge_end >> 32);
> > +
> > +	wr32ptp(wx, WX_TSC_1588_TRGT_L(0), trgttiml0);
> > +	wr32ptp(wx, WX_TSC_1588_TRGT_H(0), trgttimh0);
> > +	wr32ptp(wx, WX_TSC_1588_TRGT_L(1), trgttiml1);
> > +	wr32ptp(wx, WX_TSC_1588_TRGT_H(1), trgttimh1);
> > +	wr32ptp(wx, WX_TSC_1588_SDP(0), tssdp);
> > +	wr32ptp(wx, WX_TSC_1588_SDP(1), tssdp1);
> > +	wr32ptp(wx, WX_TSC_1588_AUX_CTL, tsauxc);
> > +	wr32ptp(wx, WX_TSC_1588_INT_EN, WX_TSC_1588_INT_EN_TT1);
> > +	WX_WRITE_FLUSH(wx);
> > +
> > +	rem = WX_NS_PER_SEC;
> > +	/* Adjust the clock edge to align with the next full second. */
> > +	wx->sec_to_cc = div_u64(((u64)rem << cc->shift), cc->mult);
> 
> ... that appears to be hard coding a period of one second?

Yes. We only want to support 1pps functionality.

> 
> > +	wx->pps_width = rq->perout.period.nsec;
> > +	wx->ptp_setup_sdp(wx);
> 
> And this ^^^ is taking the dialed period and turning into the duty
> cycle?

We try to use "width",  which means the time from the rising edge to the falling edge.



