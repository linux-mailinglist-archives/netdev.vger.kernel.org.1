Return-Path: <netdev+bounces-73802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A059C85E72F
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 20:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B6FB27D85
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 19:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004AC85C69;
	Wed, 21 Feb 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GEFO73QZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB628592D
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543422; cv=none; b=iKVIO2Uz6BhZQ8rC9pEOmeOuOFtmv8/B4zlRAI4Vi/seDSjCnydHxl5H4Dyn23N4Zs3KOHOyIxrNO/Ql2guteddg1KM0p2dJbSCgId3BK+PRBSa2LJ1SAQq6Qum2mi/HcRZExQeN5+FKtbZUpFumFKMQ5BsXZMtEi9WYhShBn54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543422; c=relaxed/simple;
	bh=1ceNKUywwCEoAqCs1ASSbIdgfL2B77nkwU+nLKa9FBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E53qlmtKhnhlluTZDBxqCrfaCzUMY5Ovy8ociVWiGG+c0VIw8TqLRTc/5hwmsOi9lUGy+HL3E3zG5pZrTRqpG4LHClNlB547lj60d5AVmSoKAtiP4ehCl2cf639qdEyGvo6lDHINlzc+ru6rI61W6QDDRG19uvyVkjvkdZg3WSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GEFO73QZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4913425a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 11:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543420; x=1709148220; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eWG5ZMRmXnPGWZYW1R10w1wWwVcifrPihQ/oY2ui5Q=;
        b=GEFO73QZY6UwyX4Gcf9+dOe5T0maPpXWfdFCZITqpupCtbIewdi5CI9jfcQBm7RORA
         2dkFSwiosa+Gn55u3s9fj26HnMMO1OQjq7brhF4psUejeFRDS+fZOeVWlulJ4TSbcdLL
         6AW/MTu9Tl0XAHkf3zdI4vqRu89m2rKFGdQZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543420; x=1709148220;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eWG5ZMRmXnPGWZYW1R10w1wWwVcifrPihQ/oY2ui5Q=;
        b=t9FEcbfU3ziXHpXElbsnxfcGwnNlfGeEOI9e6zFzxT3kpnkwcYNBcltCg90+JCqclz
         gRq5CNPa9+Il+5wniCCspJrGDevhDyQ3DQ+a1zAQmMWSia+CNBkTgYSJVNB1q0TA4LaW
         FLcOEyO3R3/XWKLAMMQAFSnButrEnIjlwKjRgfp27gqS+6ttm9N22epAfpQok/DalHum
         io7i9Hs6dW2X17oXzWCwNegZp1eZyYv7IyhmDG11TlJ/Oh55LfEmzJcNJmMs0ol/l7Mg
         vpT+kqgA8QoUy4oQrPx2ux3gDZH/tdFphKwy4Q+XeItPgP52m0Q4q5mbnoivbsnEFBAb
         z5Bg==
X-Gm-Message-State: AOJu0YzrglOxiQV7tyLo/S714OeXRCDWLDpe/pqOR6gUY0VqDKdMFIA1
	VKrC1jvshr9kIOR4fecBlxOW1Lwv7oXt8eG4hMa1j4fxau86ZdoPQ+IxHusttNXV6p1fMFAuT/J
	v
X-Google-Smtp-Source: AGHT+IFRBTBr2Nf5+Nb9OU1XMkahZmLQrWTBmw/aLdiyeOF/4U4aisnbQYV7zcbzrKpLjaYDswP/CA==
X-Received: by 2002:a17:90a:2c07:b0:29a:7a6:40fd with SMTP id m7-20020a17090a2c0700b0029a07a640fdmr3334391pjd.49.1708543420235;
        Wed, 21 Feb 2024 11:23:40 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id ns13-20020a17090b250d00b0029a3da37123sm225751pjb.23.2024.02.21.11.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:23:39 -0800 (PST)
Date: Wed, 21 Feb 2024 11:23:37 -0800
From: Joe Damato <jdamato@fastly.com>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <20240221192336.GC68788@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <1708531057-67392-2-git-send-email-jdamato@fastly.com>
 <8d34d621-421b-40bd-98ab-c93783408d74@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d34d621-421b-40bd-98ab-c93783408d74@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:12:47AM -0800, Nambiar, Amritha wrote:
> On 2/21/2024 7:57 AM, Joe Damato wrote:
> >Expose the netdevice name when queue and NAPI netdev-genl APIs are used
> >
> >Signed-off-by: Joe Damato <jdamato@fastly.com>
> >---
> >  include/uapi/linux/netdev.h |  2 ++
> >  net/core/netdev-genl.c      | 22 +++++++++++++++++-----
> >  2 files changed, 19 insertions(+), 5 deletions(-)
> >
> >diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> >index 93cb411..80762bc 100644
> >--- a/include/uapi/linux/netdev.h
> >+++ b/include/uapi/linux/netdev.h
> >@@ -117,6 +117,7 @@ enum {
> >  	NETDEV_A_NAPI_ID,
> >  	NETDEV_A_NAPI_IRQ,
> >  	NETDEV_A_NAPI_PID,
> >+	NETDEV_A_NAPI_IFNAME,
> >  	__NETDEV_A_NAPI_MAX,
> >  	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
> >@@ -127,6 +128,7 @@ enum {
> >  	NETDEV_A_QUEUE_IFINDEX,
> >  	NETDEV_A_QUEUE_TYPE,
> >  	NETDEV_A_QUEUE_NAPI_ID,
> >+	NETDEV_A_QUEUE_IFNAME,
> >  	__NETDEV_A_QUEUE_MAX,
> >  	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
> >diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> >index fd98936..a886e6a 100644
> >--- a/net/core/netdev-genl.c
> >+++ b/net/core/netdev-genl.c
> >@@ -181,6 +181,9 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
> >  	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
> >  		goto nla_put_failure;
> >+	if (nla_put_string(rsp, NETDEV_A_NAPI_IFNAME, napi->dev->name))
> >+		goto nla_put_failure;
> >+
> >  	if (napi->irq >= 0 && nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq))
> >  		goto nla_put_failure;
> >@@ -307,7 +310,8 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
> >  	if (nla_put_u32(rsp, NETDEV_A_QUEUE_ID, q_idx) ||
> >  	    nla_put_u32(rsp, NETDEV_A_QUEUE_TYPE, q_type) ||
> >-	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex))
> >+	    nla_put_u32(rsp, NETDEV_A_QUEUE_IFINDEX, netdev->ifindex) ||
> >+	    nla_put_string(rsp, NETDEV_A_QUEUE_IFNAME, netdev->name))
> >  		goto nla_put_failure;
> >  	switch (q_type) {
> >@@ -369,16 +373,19 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
> >  	u32 q_id, q_type, ifindex;
> >  	struct net_device *netdev;
> >  	struct sk_buff *rsp;
> >+	char *ifname;
> >  	int err;
> >  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
> >  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> >-	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> >+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> >+	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
> >  		return -EINVAL;
> >  	q_id = nla_get_u32(info->attrs[NETDEV_A_QUEUE_ID]);
> >  	q_type = nla_get_u32(info->attrs[NETDEV_A_QUEUE_TYPE]);
> >  	ifindex = nla_get_u32(info->attrs[NETDEV_A_QUEUE_IFINDEX]);
> >+	nla_strscpy(ifname, info->attrs[NETDEV_A_QUEUE_IFNAME], IFNAMSIZ);
> >  	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> >  	if (!rsp)
> >@@ -387,10 +394,15 @@ int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
> >  	rtnl_lock();
> >  	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
> >-	if (netdev)
> >-		err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> >-	else
> >+
> >+	if (strcmp(netdev->name, ifname)) {
> >  		err = -ENODEV;
> >+	} else {
> >+		if (netdev)
> >+			err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> >+		else
> >+			err = -ENODEV;
> >+	}
> 
> This looks bit incorrect to me that the netdev is checked after netdev->name
> is accessed. Shouldn't this be something like:
> 
> if (netdev && !strcmp(netdev->name, ifname))
> 	err = netdev_nl_queue_fill(rsp, netdev, q_id, q_type, info);
> else
> 	err = -ENODEV;

Yes, you are right. Thanks.

Based on Jakub's comment re exposing names, though, it seems that perhaps
this change is not desirable overall.

