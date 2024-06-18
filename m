Return-Path: <netdev+bounces-104430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8790C7AF
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 12:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9025C1C2088C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 10:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9743155735;
	Tue, 18 Jun 2024 09:09:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE601BE234
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701785; cv=none; b=prqjeN4DTo0kDKsCVtxfJZJh1vN8nA0p7rvpmTFnp+atDsNJ3Y7cLzUuqjoedYRFyBRl0CvV/Fymxluxf2IQbbO7tSrh5RB7Fi9zEuVWO3r9IHj0zyz8Du96J5X3KF9NfZlXarokZ6EfCCLAL856Ghhgdb3yS+CAEEsQga2ZnOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701785; c=relaxed/simple;
	bh=Ju7ToSYr5RJzzVhf7gwXwn92ybquirH4spKnLYOv7qo=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=m28YGw9SWkVKzKjO5Aa9YAPFfTbv7bAhLWHwKQzQKZVZqIp+hEEbYm2mwSyhypT2bT0rpHOwd7sLrLi1i1DTA8/iP+jWBF/Pu9tOwqc8xJUkxx338cGbp8pXTgVyIewPk2wHMk8L6KGeCYFNN5B/qgTwXk8qGzY3V+TG8QOag6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas6t1718701663t106t54981
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.97.141])
X-QQ-SSF:00400000000000F0FVF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12469069852857000503
To: "'Simon Horman'" <horms@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<linux@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>
References: <20240605020852.24144-1-jiawenwu@trustnetic.com> <20240605020852.24144-3-jiawenwu@trustnetic.com> <20240606204959.GP791188@kernel.org> <00d501dac15e$4034f530$c09edf90$@trustnetic.com>
In-Reply-To: <00d501dac15e$4034f530$c09edf90$@trustnetic.com>
Subject: RE: [PATCH net-next v2 2/3] net: txgbe: support Flow Director perfect filters
Date: Tue, 18 Jun 2024 17:07:42 +0800
Message-ID: <00d601dac15e$f9ba3e70$ed2ebb50$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQH0eqJcG+ogIoRI8v7BTXwUMbAV0QIsFs7TAUXizRgC/DBgTbFmVr3Q
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

> > > +	/* only program filters to hardware if the net device is running, as
> > > +	 * we store the filters in the Rx buffer which is not allocated when
> > > +	 * the device is down
> > > +	 */
> > > +	if (netif_running(wx->netdev)) {
> > > +		err = txgbe_fdir_write_perfect_filter(wx, &input->filter,
> > > +						      input->sw_idx, queue);
> > > +		if (err)
> > > +			goto err_unlock;
> > > +	}
> > > +
> > > +	txgbe_update_ethtool_fdir_entry(txgbe, input, input->sw_idx);
> > > +
> > > +	spin_unlock(&txgbe->fdir_perfect_lock);
> > > +
> > > +	return err;
> >
> > Hi Jiawen Wu,
> >
> > Smatch flags that err may be used uninitialised here.
> > I'm unsure if that can occur in practice, but perhaps it
> > would be nicer to simply return 0 here.

Perhaps initialize err = -EINVAL, and return 0 here.

> >
> > > +err_unlock:
> > > +	spin_unlock(&txgbe->fdir_perfect_lock);
> > > +err_out:
> > > +	kfree(input);
> > > +	return -EINVAL;
> >
> > And conversely, perhaps it would be nicer to return err here - ensuring is
> > it always set.  F.e. this would propagate the error code returned by
> > txgbe_fdir_write_perfect_filter().
> 
> I think it can be changed to initialize err = 0, and return err in these two places.

Then return err here.



