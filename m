Return-Path: <netdev+bounces-201023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530DAE7E0B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6781A162BE8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7D285CB5;
	Wed, 25 Jun 2025 09:52:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F238827D779
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845148; cv=none; b=MR91H5pEE+d+jOYkoUl0IPvT1WmcmoEeyMpdeVploxjJikUOfeGEzC+NArZqRKmRNxrwCgfBhw1TdJW9OhYvRYehkSC8ap34IhEU/wFxjfW4uFRGvcKffoxhr1wXS5OlJBTvkUl/o7JlDQIqgFCI3zkgRRaBh7ESD8UdAgTzF/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845148; c=relaxed/simple;
	bh=Dg7rP526mhbsW4xGK04fjM+g5qqxoZi+NKzZCw92uew=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ST7H1UjHdFpO49N1/Apod3RhqcwP9DMbI8erM6Cut7n2jm1aBu4VadJ+xEt6zre/Oo12KGK5RnTyxH1BDlqEzky4zl3i13Vsgp5RAkmBBVD0OyfJIMN3exwZnu7dYhDstN+d472c1pK7bZ7ytNbeGz41sZawywG/zZlkONVd3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1750845085t867t19722
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [60.186.80.242])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 15320235388309782380
To: "'Simon Horman'" <horms@kernel.org>
Cc: <netdev@vger.kernel.org>,
	<andrew+netdev@lunn.ch>,
	<davem@davemloft.net>,
	<edumazet@google.com>,
	<kuba@kernel.org>,
	<pabeni@redhat.com>,
	<mengyuanlou@net-swift.com>
References: <9E4DB1BA09214DE5+20250624093021.273868-1-jiawenwu@trustnetic.com> <20250625093540.GK1562@horms.kernel.org>
In-Reply-To: <20250625093540.GK1562@horms.kernel.org>
Subject: RE: [PATCH net] net: txgbe: fix the issue of TX failture
Date: Wed, 25 Jun 2025 17:51:19 +0800
Message-ID: <031701dbe5b6$b3a2c880$1ae85980$@trustnetic.com>
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
Thread-Index: AQHCS47XFZmCZTnKvTrKz5tx3gLcfQIu6t2dtDVbMXA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N2kb7S4SyNd97MTpt/W54Is3RablM2+kpNJg3KB8rKkwgONRoiZxu3qM
	Vtlh46RKPW8Cx/S6RrjY3zMS+invaooxhLBYnNKpqqG7VHAwafX6P+5XKYhKvGLUyLnn4zx
	vZlC+hMKE7UUzDgyF2x6/JQYQklPOMEUIjTxX28WMvR7gyVn4+jWNLrJdNsKUHIiMFW46BN
	TR4YsrxXxk1sdS0mIt8kWxd7UHcR2glJIGOXxPDpbuj9K5TJ+ttHsuaqmriqX2M2rVRbvyX
	9qWz/LWva/RBV9X1FQfk13i4tidfHEaVmwFwLe0cT9exz7ipYCofKydFMrz0gP1SGzJcnTy
	V/bLPIs49AX+jNM6yxvFTnAMoN1cFfnq5tgIcjtSKrNkMNf+PMcLdDZbsTp4VuKIVLlgRh7
	CwrXG4kCKK3L+BMZVc9Ot/oZ9JGrFX4kEZHNxKonAhgJCoa9+yXQztvf5B+XpqYDla3Doo8
	YSF+CCcTjWRPHEHEl8iJVE++mNkaVX3WrTbD0qPCSnceJ7HQFYw69u2v94KCHZSKcpK66Ys
	92shLipzlyxugmKiIjoStxxy+t0t3YD9O1yWi71dL6yMJkJajYy0mHl/zEGmmSKJKhu/1oF
	YKiWXtdze95iNQZR8KwwJn7XGQb+FyxBbGuWOT+FqXNeVi7CswKhmL1pm0tTqB50FSesnYB
	XO5fmvUoUmXphMFf34jlIVkhEYcbu9SupPZlBDACV58/vM9BvQKRSJL86RAOVmFLobTX/0K
	/BhmV+6nwr9Fq1Y46H631ixotN1xTAaJmo3I05NOu7m8jc/7e5nyfLL+2rU6pJbKsqgzSNm
	RxD7/UOlqaglya5/DkJnCno6t7Z7D0Zv9WbJ8q7pBgO2mlIsCYzYkeXthBgVQinODJUPmOH
	zJtc4GNoAFbB4vXlfhobTDeGJzeFQbXjdMxlTm5i5deY0jZ+SfauYDZtsngz7ipZFONg/He
	+7TbJkPMv9YcNhGoM4WKBICap3L2YH4fqvq7+yfxt4xlieHljKAd7S+/vaG04r4iKOF9yLX
	gvgDvStn+ec2A0oW1CEp5zvg47rzg=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

On Wed, Jun 25, 2025 5:36 PM, Simon Horman wrote:
> On Tue, Jun 24, 2025 at 05:30:21PM +0800, Jiawen Wu wrote:
> > There is a occasional problem that ping is failed between AML devices.
> > That is because the manual enablement of the security Tx path on the
> > hardware is missing, no matter what its previous state was.
> >
> > Fixes: 6f8b4c01a8cd ("net: txgbe: Implement PHYLINK for AML 25G/10G devices")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> nit: failure is misspelt in the subject

Thanks. :)

> 
> > ---
> >  drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > index 7dbcf41750c1..dc87ccad9652 100644
> > --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_aml.c
> > @@ -294,6 +294,7 @@ static void txgbe_mac_link_up_aml(struct phylink_config *config,
> >  	wx_fc_enable(wx, tx_pause, rx_pause);
> >
> >  	txgbe_reconfig_mac(wx);
> > +	txgbe_enable_sec_tx_path(wx);
> >
> >  	txcfg = rd32(wx, TXGBE_AML_MAC_TX_CFG);
> >  	txcfg &= ~TXGBE_AML_MAC_TX_CFG_SPEED_MASK;
> 
> Hi Jiawen,
> 
> I am unsure if it is important, but I notice that:
> 
> * txgbe_mac_link_up_aml is the mac_link_up callback for txgbe_aml
> 
> * Whereas for txgbe_phy txgbe_enable_sec_tx_path() is called in
>   txgbe_mac_finish(), which is the mac_finish callback
> 
> Could you comment on this asymmetry?

For txgbe_sp, the configuration of PCS is completed in the driver.
Disable sec_tx_path -> configure PCS -> enable sec_tx_path, it is
the necessary sequence. So these MAC operations were added in
txgbe_mac_prepare() and txgbe_mac_finish().

For txgbe_aml, the configuration of PCS is completed in the firmware.
So I didn't implement .mac_prepare and .mac_finish.



