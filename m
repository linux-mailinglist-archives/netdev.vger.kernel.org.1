Return-Path: <netdev+bounces-242981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17960C97BD9
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A94E161A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9C313E2B;
	Mon,  1 Dec 2025 13:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvhiwYOe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F39F312816
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764597372; cv=none; b=usX8nvUXVudQHRK+qAMrizag8NrX9ApiKAo8iItH03r8nAR4Dc1ZBshRhp+a7MD//H+5LATFP6kssbNQqmTLaVBnckRloiBQbnuRJobYa8BZrTOUuJxwvtH04RzEi4hjrocAukuAONmt7BHYlvOkITJ88rL0KcOb+LW/BlDxu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764597372; c=relaxed/simple;
	bh=A0Z3Vafv0bAi6uB0xlY0j5MJXQ4H/3TpH7xNzz91rmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy1QMf1Qh8zKps6qK0Xa+gIau0OznP3Twm27eNkLVCuiadY0zczMWzq2skhP9ualNwmeUfI2LO2ulKfCYEYyPV79g21EDj1k7wMujVmoIjkdXtNdnEHNhC2EOOq/Wny1oHErpSQNN0dpy/gkYETupRXkafxPV34xpbVbz3a6pvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvhiwYOe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34381ec9197so3592809a91.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 05:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764597370; x=1765202170; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a2Enl1wPQpF6gzSuxvAtr6YsK77ubEdlhUGNIlCPzkM=;
        b=bvhiwYOeK9Ocm+VJg1rvC/Vy9WKQrg9aTrJzcg/mgHIWO0OagY2XuMe9h8iXj7KlxG
         pYEGOkuhj4CINOU/0jmk3FSBaSlt4FMm3LOSPBsRouQfoTqSIxlbFqzAd8Th2509y9OV
         xzCJ02gbDzr4niE2/SvrqthINatATTkaiZnJsPeAMcRwtdGDW10TrauPWQ8untHvfS31
         9+sPRduHypvNou3obnqGICHWF9OqURanhYI/XMLsxPbePaNrVfyRq9WzR9ErL0UzKsRk
         o7fTVHPY2X2DEIygTbclX0Ot3x8ril1WPbRXvJbQ9rdsiZ5g6uFHuqOYSbRVjkhJcUg6
         TWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764597370; x=1765202170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2Enl1wPQpF6gzSuxvAtr6YsK77ubEdlhUGNIlCPzkM=;
        b=DePfHrznickfwTobB2QclsuyJ7vb4et4ga0vNMy7IiC9fHeItjnBJ54/KaRPQB1KzO
         IcPMUapea8S0D7SdKIAiqg+oaBkJnvV0kINNeBlkOUa4fFcNhC9DqfsymNMVtc9lVU9X
         aKqN/cAXiwzTvPrRXioCDbnwxcZluj+I7s/qm+0i/KScVm37rSp1IO3j/uIUiA0le4gu
         bkT0qzFGdLJ1VvMhfLfluWIowMFNjTqx1HtUHAWNObD4X9x4hYeZCKlT/pow2IQBAnvg
         iOj+il1yhUnBt+dPd4LLBVtg0QV4Nkravcsf3pmcnkVibb9GeQ/OlatGxKR7OATNLQxb
         sObg==
X-Gm-Message-State: AOJu0Yw/QJY5hC9Jx77TUsmydEqS9INuy3Pt1bTsNKQGJPolxPq2hXKN
	yHNPgMy6YHib1fwm6FRbffpCjBRfNkOUURGCRF/QLMe0mI+klzDRXWrtW7WDZQRL
X-Gm-Gg: ASbGncu9CSiYpQ8s9eR8gnUTx7lNkseUM9Z1nMzL09qgZHmzDcqW4DkmSyTf1SLz/jw
	S+kc7amS1rLiExfljKlPFrVYHvHbglo07Cmqi3EXBm5/azwZyCg9Q0j+VFRzIkVef6JYfiHnHbV
	7wd+xFnpAs318XRQp/zKcsNbtqb8815HYo/0RGFxAkDcMQertED+UI+O5ixCGM7ZJUOC5TrDKDs
	8rhkeoo08keSL4RF8oQHNujkl3NiiOQ/kncIQ1bCwsXtHFuAad3t72XI1dumA7lEvFjg3K18Z2A
	gDIaRT2kE7qDhAg28JRoQ7iZZZZbN7q9xOugd+PkMn3teep8Q7ChnZNMPJOs4Zy8qQgsFqj6LJu
	NJuzovHAip1APziuVwtEIGNG7w6h8BdwDfj7TvvZQjAJWNRiRB1s/KwPFDUdGOk0nwXjMpX/q4J
	j2sOu+M7//2gOUAR8=
X-Google-Smtp-Source: AGHT+IHC1wmy2ZG5D5VMtKk4CNz18DjmyrTOYSp4UP0rE+HfOuUQjsv/DToUmWIoj3Ko2HrpUikIHg==
X-Received: by 2002:a17:90b:4a08:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-34733e72342mr40901994a91.12.1764597370320;
        Mon, 01 Dec 2025 05:56:10 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm16991422a91.5.2025.12.01.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 05:56:09 -0800 (PST)
Date: Mon, 1 Dec 2025 13:56:02 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure
 peer notify updated in lacp mode
Message-ID: <aS2ecn0U6rlNHP0r@fedora>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
 <20251130074846.36787-2-tonghao@bamaicloud.com>
 <aS08d1dOC2EOvz-U@fedora>
 <AACE3A98-C0C0-4B24-BC29-B8EC3A758D90@bamaicloud.com>
 <aS1ocogQc01owxSC@fedora>
 <7FEDE75E-551D-4B29-86A2-526AA3556CDC@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7FEDE75E-551D-4B29-86A2-526AA3556CDC@bamaicloud.com>

On Mon, Dec 01, 2025 at 07:01:23PM +0800, Tonghao Zhang wrote:
> >>> I don’t see the benefit of moving NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
> >>> Is there a specific reason or scenario where this ordering change is required?
> >> No, to simplify the code, and use common peer notify reset function.
> > 
> > bond_change_active_slave() is called under RTNL lock. We can use
> > bond_peer_notify_reset() here. But I don't think there is a need to move
> > NETDEV_NOTIFY_PEERS before NETDEV_BONDING_FAILOVER.
> Is there a dependency relationship between NETDEV_NOTIFY_PEERS and NETDEV_BONDING_FAILOVER?
> In vlan, macvlan, ipvlan netdev, NETDEV_NOTIFY_PEERS and NETDEV_BONDING_FAILOVER use the same action.
> net/8021q/vlan.c
> drivers/net/macvlan.c
> drivers/net/ipvlan/ipvlan_main.c

Quote from ad246c992bea ("ipv4, ipv6, bonding: Restore control over number of peer notifications")

"""
    For backward compatibility, we should retain the module parameters and
    sysfs attributes to control the number of peer notifications
    (gratuitous ARPs and unsolicited NAs) sent after bonding failover.
"""

In theory we should send notify after failover. The infiniband driver also
has specific functions to handle NETDEV_BONDING_FAILOVER. I'm not sure if the
miss-order affect it. Maybe Jay knows more.

Thanks
Hangbin

