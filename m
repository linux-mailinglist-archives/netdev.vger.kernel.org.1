Return-Path: <netdev+bounces-96844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB58C8019
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 05:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12487B2103E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 03:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FB946C;
	Fri, 17 May 2024 03:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168A59441
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715915188; cv=none; b=G02Tl2q7snAou4ZP6Uct4QqXE+LEH7M680cL21J5lCdVccDGR7NxuYWhnInd2AldTjHW/cpw2Z3HppSyHqGpO3BZ/N3zraXltCzNQc3uyy+IC1SssrCvwhI7iA36SdrMk9AhYUBbVGbPXjxGJguFHDdDR1wcONDPJODTJgaSJj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715915188; c=relaxed/simple;
	bh=7LNnS62iEtEVh5Zi4JFwLggCQfak7i0qtAadIngYYA4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DeCPfyaq+Ks/vWvn+TPtwjb1G2PEl+tFGYcU/PmBPJeIkCi7iWpJwnkVsqnuU1G++KIaYxXtdnbKO7bLLzD42+KL3U6q/KhTy8PAF/xpPucXJh/HoUo/KMM0VIMFlmhVj64491DueY+8rCQlo8bLLDQU+8yA0wRM99zX1bbg9CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas56t1715915025t432t36806
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.120.144.133])
X-QQ-SSF:00400000000000F0FUF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 495622568927500276
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <davem@davemloft.net>,
	<edumazet@google.com>,
	<pabeni@redhat.com>,
	<rmk+kernel@armlinux.org.uk>,
	<andrew@lunn.ch>,
	<netdev@vger.kernel.org>,
	<mengyuanlou@net-swift.com>,
	<duanqiangwen@net-swift.com>,
	"'Sai Krishna'" <saikrishnag@marvell.com>,
	"'Simon Horman'" <horms@kernel.org>
References: <20240514072330.14340-1-jiawenwu@trustnetic.com>	<20240514072330.14340-3-jiawenwu@trustnetic.com> <20240516194544.67d9249c@kernel.org>
In-Reply-To: <20240516194544.67d9249c@kernel.org>
Subject: RE: [PATCH net v4 2/3] net: wangxun: match VLAN CTAG and STAG features
Date: Fri, 17 May 2024 11:03:44 +0800
Message-ID: <000001daa806$d4554880$7cffd980$@trustnetic.com>
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
Thread-Index: AQC9baT9Ek5P9mukLvWFnC4H3kz7dAMBvxxiAnmfhnizqVWQkA==
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1

On Fri, May 17, 2024 10:46 AM, Jakub Kicinski wrote:
> On Tue, 14 May 2024 15:23:29 +0800 Jiawen Wu wrote:
> > +#define NETIF_VLAN_STRIPPING_FEATURES	(NETIF_F_HW_VLAN_CTAG_RX | \
> > +					 NETIF_F_HW_VLAN_STAG_RX)
> 
> 
> > +	if (changed & NETIF_VLAN_STRIPPING_FEATURES) {
> > +		if (features & NETIF_F_HW_VLAN_CTAG_RX &&
> > +		    features & NETIF_F_HW_VLAN_STAG_RX) {
> > +			features |= NETIF_VLAN_STRIPPING_FEATURES;
> 
> this is a noop, right? It's like checking:
> 
> 	if (value & 1)
> 		value |= 1;
> 
> features already have both bits set ORing them in doesn't change much.
> Or am I misreading?
> 
> All I would have expected was:
> 
> 	if (features & NETIF_VLAN_STRIPPING_FEATURES != NETIF_VLAN_STRIPPING_FEATURES) {
> 		/* your "else" clause which resets both */
> 	}
> 
> > +		} else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) &&
> > +			 !(features & NETIF_F_HW_VLAN_STAG_RX)) {
> > +			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
> > +		} else {
> > +			features &= ~NETIF_VLAN_STRIPPING_FEATURES;
> > +			features |= netdev->features & NETIF_VLAN_STRIPPING_FEATURES;
> > +			wx_err(wx, "802.1Q and 802.1ad VLAN stripping must be either both on or both off.");
> > +		}
> > +	}

Right. Looks like I just need to keep the "else" part and remove others.



