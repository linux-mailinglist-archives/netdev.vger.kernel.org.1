Return-Path: <netdev+bounces-95131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956958C1769
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E227286790
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A38880631;
	Thu,  9 May 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zX+KV5aA"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D380043;
	Thu,  9 May 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285843; cv=none; b=Tk4mGnTjrbeh8qvmyffjzQ7jwwRTDywDmXOi1p+8FckUBZTMiG6kE2W6We/Gk1mDdxiFjEFZTEYek92s0CJ7X1GLQjg1WGr2t9vhm8ugW+ksoRKdteLBjxchMus4tO3RinumiKiDFbc92pHxEPAJLzYuRMQ0VeeNbbEnJno+834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285843; c=relaxed/simple;
	bh=lICYDaRSn8HsmeXAurxSzsp+d+rM5QiHyZnsXPzU7TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esmp/TfaDpoE2reeQ8svcNTcSDQhSm/uv7SSc8N+JDxzqNKgPAIjBtyFamcHhGA3k/KyWNSVKIlsEhblIMcv+9zksBhJhd2xN+lNqsRIuRU5biM7TxwxXPLSS7LOeaV37vY8j0H4y1k/D+rYy+fsCoBNWI18C65f3Q7EcpQex7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zX+KV5aA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2Ct/oG04cz4M7nY829u2Qio1z6a5TPRCIdyjKCqCtGg=; b=zX+KV5aAAuuYlSsD4j+xGKxI28
	oF0zirnqHjWj16/AD3Vti5CjmatTU9V4UD60sQq2VOrTUQzEuXR2j2XM+e9zwjJlrV9AHTM5errXT
	nHEbTs5DN4clan/cfjriWrxGljuiFMl7gcoMIFZm9iyz8+sPYfkBPLu7NaSv9qHxGpzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s5ACH-00F4pk-L3; Thu, 09 May 2024 22:16:57 +0200
Date: Thu, 9 May 2024 22:16:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v3] net: Add sysfs atttribute for max_mtu
Message-ID: <6203153e-780c-4570-9c4e-a053cfbc3290@lunn.ch>
References: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240509094225.GA1078660@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509094225.GA1078660@maili.marvell.com>

On Thu, May 09, 2024 at 03:12:25PM +0530, Ratheesh Kannoth wrote:
> On 2024-05-09 at 14:41:23, Shradha Gupta (shradhagupta@linux.microsoft.com) wrote:
> > For drivers like MANA, max_mtu value is populated with the value of
> > maximum MTU that the underlying hardware can support.
> IIUC, this reads dev->mtu.

I think you are misunderstanding the code.

> > +NETDEVICE_SHOW_RO(max_mtu, fmt_dec);

/* generate a show function for simple field */
#define NETDEVICE_SHOW(field, format_string)				\
static ssize_t format_##field(const struct net_device *dev, char *buf)	\
{									\
	return sysfs_emit(buf, format_string, dev->field);		\
}									\
static ssize_t field##_show(struct device *dev,				\
			    struct device_attribute *attr, char *buf)	\
{									\
	return netdev_show(dev, attr, buf, format_##field);		\
}									\

#define NETDEVICE_SHOW_RO(field, format_string)				\
NETDEVICE_SHOW(field, format_string);					\
static DEVICE_ATTR_RO(field)

So field is max_mtu, so that dev->field gets expanded to dev->max_mtu.

> you can read the same using ifconfig

We stopped using ifconfig years ago. You actually mean "ip link show"

> or any thing that uses SIOCGIFMTU. why do you need to add a new sysfs ?

SIOCGIFMTU is still implemented, but obsolete, replaced by netlink, as
Eric pointed out.

	Andrew

