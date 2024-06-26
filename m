Return-Path: <netdev+bounces-107027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF519918A41
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 19:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7974D28398D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ADE19004C;
	Wed, 26 Jun 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="T2qIwe+I"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7418FDA3;
	Wed, 26 Jun 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719423787; cv=none; b=Xe1dTZIHz6w7BoQw4UZdmU6smpEz7ULQ3b6VwFtIOGHFAVJRMHkdu4dZb63jJU7zeLic+5sPY0iuJqb5ddHWKaJnz27GHTMiJpp4uQT+gll3k5e+TKs3xjGu2pqqiFUre2ezPl1F7mofgh/luJtkBmiID66wamFgG9B8MQe5YQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719423787; c=relaxed/simple;
	bh=mIa8VG3n3S+KQwTdoB7kClmabb1DhqOFZjZ2EWEw9Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7Dfy49A0V8yzUZOmgjbyrsctT+hm3V/pztmjcNk5xikY59TTgIvzYquP1l6uacmfZedbQv7xz5UV9euBVQS3MsfYouDlJPlAKpDyNZcfzegn8rZn0KjY2ju1KfdGvSctNkpisHC8U3HTtqzHZYNBFsRZz6rphrIdBXG60bJy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=T2qIwe+I; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xOwczucyEIlgXzNDAVRQED9769Cf5dVKLoEoKbrY1Gw=; b=T2
	qIwe+IQqKPzjWnkKvs//T0QeCzXLebBdDubACEIimCmodQulIbEUfka5jSCB/EOVjktGUlCy6i1sW
	QTrsUCdrUW2jCePEikVmDZmTcPaMuzLLoqunk/ym2dt7im/HPCKnI6MOY9f8N8jpOScFiIxHG8mJ5
	I6SY+Qplxu7Ty4k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMWfP-0013tv-MX; Wed, 26 Jun 2024 19:42:47 +0200
Date: Wed, 26 Jun 2024 19:42:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"sdf@google.com" <sdf@google.com>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	mlxsw <mlxsw@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next v7 7/9] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <ad5dd612-1b8d-4061-808e-2199144dc486@lunn.ch>
References: <20240624175201.130522-1-danieller@nvidia.com>
 <20240624175201.130522-8-danieller@nvidia.com>
 <003ca0dd-ea1c-4721-8c3f-d4a578662057@lunn.ch>
 <DM6PR12MB4516DD74CA5F4D52D5290E26D8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <DM6PR12MB4516907EAC007FCB05955F7CD8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
 <baf84bde-79d3-4570-a1df-e6adbe14c823@lunn.ch>
 <DM6PR12MB4516062B5684DA1F4C5F49FED8D62@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR12MB4516062B5684DA1F4C5F49FED8D62@DM6PR12MB4516.namprd12.prod.outlook.com>

> > Please could you test it.
> > 
> > 65535 jiffies is i think 655 seconds? That is probably too long to loop when
> > the module has been ejected. Maybe replace it with HZ?
> > 
> 
> Well actually it is 65535 msec which is ~65 sec and a bit over 1 minute.

I _think_ it depends on CONFIG_HZ, which can be 100, 250, 300 and
1000.

> The test you are asking for is a bit complicated since I don’t have
> a machine physically nearby, do you find it very much important?

> I mean, it is not very reasonable thing to do, burning fw on a
> module and in the exact same time eject it.

Shooting yourself in the foot is not a very reasonable thing to do,
but the Unix philosophy is to all root to do it. Do we really want 60
to 600 seconds of the kernel spamming the log when somebody does do
this?

> > Maybe netdev_err() should become netdev_dbg()? And please add a 20ms
> > delay before the continue.
> > 
> > > > > > +		}
> > > > > > +
> > > > > > +		if ((*cond_success)(rpl.state))
> > > > > > +			return 0;
> > > > > > +
> > > > > > +		if (*cond_fail && (*cond_fail)(rpl.state))
> > > > > > +			break;
> > > > > > +
> > > > > > +		msleep(20);
> > > > > > +	} while (time_before(jiffies, end));
> > > > >

> > O.K. Please evaluate the condition again after the while() just so ETIMEDOUT is
> > not returned in error.
> 
> Not sure I understood.
> Do you want to have one more polling in the end of the loop? What could return ETIMEDOUT?

Consider what happens when msleep(20) actually sleeps a lot longer.

Look at the core code which gets this correct:

#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
                                sleep_before_read, args...) \
({ \
        u64 __timeout_us = (timeout_us); \
        unsigned long __sleep_us = (sleep_us); \
        ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
        might_sleep_if((__sleep_us) != 0); \
        if (sleep_before_read && __sleep_us) \
                usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
        for (;;) { \
                (val) = op(args); \
                if (cond) \
                        break; \
                if (__timeout_us && \
                    ktime_compare(ktime_get(), __timeout) > 0) { \
                        (val) = op(args); \
                        break; \
                } \
                if (__sleep_us) \
                        usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
                cpu_relax(); \
        } \
        (cond) ? 0 : -ETIMEDOUT; \
})

So after breaking out of the for loop with a timeout, it evaluates the
condition one more time, and uses that to decide on 0 or ETIMEDOUT. So
it does not matter if usleep_range() range slept for 60 seconds, not
60ms, the exit code will be correct.

      Andrew

