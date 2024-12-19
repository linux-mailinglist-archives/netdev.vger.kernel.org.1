Return-Path: <netdev+bounces-153272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B836E9F7821
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA787A1972
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B022147E;
	Thu, 19 Dec 2024 09:15:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313B21D593;
	Thu, 19 Dec 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599705; cv=none; b=kZPCQ8oT2+woTa5saZ8iKU0kZsBXIIkPEgwLlEqVX4B+HrKhbkWzsqHhL0PT+TRUChsj8jdao40tcE33egM5K8l21FTSRLtUL7nnyQ7E835melb1vmTrKsfr4A9NXgOUkSRdAkG2gaoLrP+csnReZRPOqJDZK5MXYGDOoB3T+CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599705; c=relaxed/simple;
	bh=s2/SqV512fk3LXCx8kmk3gcU0ovg+4CqFledRIuPIaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1MN5CTBBXdIlftTKAWTquALtfc2k/pMCp8n7Qfbmi9rswPx+huZpWqTTTBWJ3hURbYItP+YOewJ3xijB1QYltlpKEZ+ar7TIvWbs8ZUiDcwZzLdq4lrpokAa0oHPKTgU5NUKmHHuxedbVQKiGkxKundAo49MTVopkIGMp64YTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YDPyT302tz6K72S;
	Thu, 19 Dec 2024 17:14:57 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 876C7140133;
	Thu, 19 Dec 2024 17:15:00 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Dec
 2024 10:14:50 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <cai.huoqing@linux.dev>, <corbet@lwn.net>,
	<davem@davemloft.net>, <edumazet@google.com>, <gongfan1@huawei.com>,
	<guoxin09@huawei.com>, <gur.stavi@huawei.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <meny.yossefi@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shenchenyang1@hisilicon.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>
Subject: Re: [RFC net-next v02 1/3] net: hinic3: module initialization and tx/rx logic
Date: Thu, 19 Dec 2024 11:28:23 +0200
Message-ID: <20241219092823.2518558-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <03fa6e84-65a9-4563-b289-bd75508234a2@lunn.ch>
References: <03fa6e84-65a9-4563-b289-bd75508234a2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

> > > > +static int hinic3_sw_init(struct net_device *netdev)
> > > > +{
> > > > +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> > > > +	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
> > > > +	int err;
> > > > +
> > > > +	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
> > > > +	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> > > > +
> > > > +	hinic3_try_to_enable_rss(netdev);
> > > > +
> > > > +	eth_hw_addr_random(netdev);
> > >
> > > Is using a random MAC just a temporary thing until more code is added
> > > to access an OTP?
> > >
> >
> > No, using a random MAC is not a temporary solution.
> > This device is designed for cloud environments. VFs are expected to be
> > used by VMs that may migrate from device to device. Therefore the HW does
> > not provide a MAC address to VFs, but rather the VF driver selects a
> > random MAC address and configures it into the (current) device.
>
> If you look at MAC drivers in general, this is unusual. So it would be
> good to add a comment why this unusual behaviour is used.

Ack. Just posted PATCH v1. Will add comment for v2.

