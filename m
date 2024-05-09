Return-Path: <netdev+bounces-94849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7370B8C0DB1
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135F01F2166E
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E414A632;
	Thu,  9 May 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VdfY67cz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53AA14A62D;
	Thu,  9 May 2024 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715247776; cv=none; b=BxtWsndYSSd+v/KMx1P9xdLQkRVrpqScasf6nJo2f/8AVT5vUFFE4JzyUVeuECUglNP+wxHk0sJhfhJEwTViH6/p3ZbKpOcUH51k3G76HEMRV+PcO8sLzfnQsCXMVFqHDmFiRt0/Dt9xyqMVClD29HeSYJdqtTHiTNKakXZxNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715247776; c=relaxed/simple;
	bh=f0SYpwdoemCf5nkip/wAI+bWzfh+oJZhvTL4/f8DXiw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrEUHqq7vkZ7Er2Mknf6RPxHJMdzUioOj4VH8wJACcDSOCGvEfFXcXFrYQkazJ9s4DZ93Ob7th5ZCotVAN2Xj09v8TuauzGydcta42O3RH/mKxsTYup95r3Xl1bAWj+h4s3UoiJQJoCKTx4SeiDL+/deLmdjtDGRKs6Fxq6SggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=VdfY67cz; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4494fPwe022106;
	Thu, 9 May 2024 02:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=I1JDod1XMZqhnsd6n1qqwr
	NRTv97wHEp+l3xJ/+Dleg=; b=VdfY67czD6obZFxytoVJ7BblmzVbWEgkqI0E1L
	urd1+GSFN3WZBqyY9oMppkj7rUiuEQUNK/mmaB+22jGO3j6WEnrlSAHxCiOu5vRR
	sfJEglSt5dalXftKJcO82psuJpbWHkwzPp2UOwwOFLC8rAMIyVQb9YMXtPSwqcgT
	1ka9/UJ5c6vE63BPZ9Q9RdOJptU21hlr00zMwMyZB1vsj9O/NclbReYz0ng82HiG
	qL+ckX70nOyYq6N9MVmJXY0Cm0heEEOqk9wAJ5kSmkma3IXxBkgVF+AwdNMdVDWc
	DU9AjRlbH6oMI1aqBWwePLCC55MLhLYA+asOxadueNrb6hHQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y0qpbsf0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 02:42:31 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 May 2024 02:42:30 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 May 2024 02:42:30 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 6E4E53F7063;
	Thu,  9 May 2024 02:42:26 -0700 (PDT)
Date: Thu, 9 May 2024 15:12:25 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Breno
 Leitao <leitao@debian.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: Add sysfs atttribute for max_mtu
Message-ID: <20240509094225.GA1078660@maili.marvell.com>
References: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Proofpoint-GUID: 42nSExTnEKBldjj6ItdnZ2N6vzg4Kipz
X-Proofpoint-ORIG-GUID: 42nSExTnEKBldjj6ItdnZ2N6vzg4Kipz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_05,2024-05-08_01,2023-05-22_02

On 2024-05-09 at 14:41:23, Shradha Gupta (shradhagupta@linux.microsoft.com) wrote:
> For drivers like MANA, max_mtu value is populated with the value of
> maximum MTU that the underlying hardware can support.
IIUC, this reads dev->mtu. you can read the same using ifconfig, or any thing that uses
SIOCGIFMTU. why do you need to add a new sysfs ?

> Exposing this attribute as sysfs param, would be helpful in debugging
> and customization of config issues with such drivers.
>
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -114,6 +114,7 @@ NETDEVICE_SHOW_RO(addr_len, fmt_dec);
>  NETDEVICE_SHOW_RO(ifindex, fmt_dec);
>  NETDEVICE_SHOW_RO(type, fmt_dec);
>  NETDEVICE_SHOW_RO(link_mode, fmt_dec);
> +NETDEVICE_SHOW_RO(max_mtu, fmt_dec);
>
>  static ssize_t iflink_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
> @@ -660,6 +661,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
>  	&dev_attr_ifalias.attr,
>  	&dev_attr_carrier.attr,
>  	&dev_attr_mtu.attr,
> +	&dev_attr_max_mtu.attr,
>  	&dev_attr_flags.attr,
>  	&dev_attr_tx_queue_len.attr,
>  	&dev_attr_gro_flush_timeout.attr,
> --
> 2.34.1
>

