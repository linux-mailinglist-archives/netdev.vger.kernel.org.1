Return-Path: <netdev+bounces-186328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73685A9E606
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 04:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0742173C15
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 02:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7E17DA9C;
	Mon, 28 Apr 2025 02:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhjBQR7B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416855684;
	Mon, 28 Apr 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805769; cv=none; b=p4RR00gIVNZ4DSy3KjPUlzTRWirDpZoY6lIyTgV12EbVO2nqdyUAhsXtNltawMvym0vF5tLoUGlP9tAFvAogS+Zt4e19eGv6ykbMHBaIipQs0eI/GKkNAQ7DBDajMf8aG/2J09QHa2VsVTx/q1VwvZI1lLplQbpZHlLi/Q5BizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805769; c=relaxed/simple;
	bh=DCMxUV6dX20mSSL3i2v8r0AeC9taHPlfwabBfcmx5+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsJ/8xhfrfdnBa3Qhk8pLeOHJfqeVJqqjUCoL4QlGGyfZP6xxSXPgbQpjrtnQIf6WOMdwWf+4fki6O7j9hmpFKgEGIyvZqVbmLo2cVDXNVh2OLH4kREUQsoOxwe2BxbU/Ehe3hrrmL8gdoIEJ5PBPx/PUb5d9831J05LNSUJ+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhjBQR7B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so42928055ad.2;
        Sun, 27 Apr 2025 19:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745805767; x=1746410567; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7CvA9rPJDY9mWPFla5C2Yb++zkc3I+YZAklp33A2++s=;
        b=fhjBQR7BbTg0GtBLdiPWQR1DkpC0ElXTZnRIpsZoEwFVT0b9boudewslqfOuHdbt6X
         0wMHOz+SAAiYDN1Je8oB56aVio04LVTM2kUmc6sFd3KErnjpmR3USUWSyfvroM486GJ3
         TINkQNVaDLdmVNOFvvxXUZOL2dqEoINGYS7IFJBIjeAVirzqR0WmA3/Ab4sDTS1kKEus
         nVi4IuROZ1z3s5Z4R+yXoeQj4KJOO/JpQ5xweyOoaOHoQhVEhNaXlCVn5OpAUQCnqXJ/
         c+9ORUs27JLuuj+QM4uAFKOyEXpmIEGTqxpodf+dxMg7uXFNkKs7rKefX2qWYgay42xC
         R3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745805767; x=1746410567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7CvA9rPJDY9mWPFla5C2Yb++zkc3I+YZAklp33A2++s=;
        b=lTZBuz9I1jbwj8v8RD9ouDO30WRXAoA5J7MP7CKHWKM77D5MO2f53fw2N+fIpxBwJr
         0Eb/rUx7OQjklgphkPvWRn1fa+96JYBrg0oHLPv1QjxBYL4EwYzblX1mykGoLPh3pvgy
         +CNbbiZNPxnwEROT66wqMVQCJZ4S0fy5/5o2eSzy8+0SmlJen3ydUaaWlS/Ootve7cEo
         177gLNNVIRYQ4HtT3R/l0J7PnL63CBa8SOsbmbdd1254Q90eXnd4ioaVBBpOhFJ2ZwSF
         zvcc4LS0puSXs7XLVW6SSHk2hxkUaRuqRXQz8CTOkExastcoAI+l0dukE/LaVX3pzUq3
         +/sw==
X-Forwarded-Encrypted: i=1; AJvYcCU2dZpOeuANI0Rf4HzEP5QWNZwh0VWSNpN7t6zvsLCDwCU60we6M6eW86ELtxPd2bEtKbZWL0tkWl1jQec=@vger.kernel.org, AJvYcCVpsoQyc6alVqXaYPhE+UTGk+mQDgNkGtD2mFwL6RkozVZnnrtU2ZOSLW+fibGilS/tTOPETbc/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjl9jVnodhNrVGLcvaG0lTHL43mkNqf4TbklCLyOfkaRFMUwa
	PH6J/Van3GtznbdLFuHVJ6sIKvRJEB49NJJwkF1smlZdbTqdAJbw
X-Gm-Gg: ASbGncuSXu9GDHHjOctz5pwuwnlz6Zb3GtXwI8qSA2F28J4YEQoeeZjFVF6VddAfn2k
	FpcPYGw/wSqurmKT96huNiBhRyF3jvN0SWHFfX1zrZI3YH4nrz/7D1n6/Rc1Dz5CfrktWe2Dy17
	uTqe/76DVzbuX0R+jBmLpX7IlldUXzHaIcMCfXLCHBUFMdcdtls20QthR3rhqBqAW5UOn9cKuRz
	QAd3POe/Cg3NI+GyX/WjR9lV6xzOJyRoakRva1UZLXTY3ZY6RZw9i2ZafEQwWfmF8T60BnY44zY
	ay0wslO1e85Kor2BgZjXYOtOoAGTMZx798sZn2REcu/YVg==
X-Google-Smtp-Source: AGHT+IE8pdSnJtrq62dkbclKPqe2AcUe+Xlxu8UQ+JJDlx6obZtvFZLPYXgn2MEq1NvIBWYqRr4b/A==
X-Received: by 2002:a17:902:c945:b0:224:194c:694c with SMTP id d9443c01a7336-22dc6a0f2ebmr117743375ad.28.1745805767371;
        Sun, 27 Apr 2025 19:02:47 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22dd9530465sm8887785ad.10.2025.04.27.19.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 19:02:46 -0700 (PDT)
Date: Mon, 28 Apr 2025 02:02:40 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jv@jvosburgh.net, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] bonding: hold ops lock around get_link
Message-ID: <aA7hwMhd3kyKpvUu@fedora>
References: <20250410161117.3519250-1-sdf@fomichev.me>
 <11fb538b-0007-4fe7-96b2-6ddb255b496e@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11fb538b-0007-4fe7-96b2-6ddb255b496e@huawei.com>

On Sun, Apr 27, 2025 at 11:06:32AM +0800, Wang Liang wrote:
> 
> 在 2025/4/11 0:11, Stanislav Fomichev 写道:
> > syzbot reports a case of ethtool_ops->get_link being called without
> > ops lock:
> > 
> >   ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:63
> >   bond_check_dev_link+0x1fb/0x4b0 drivers/net/bonding/bond_main.c:864
> >   bond_miimon_inspect drivers/net/bonding/bond_main.c:2734 [inline]
> >   bond_mii_monitor+0x49d/0x3170 drivers/net/bonding/bond_main.c:2956
> >   process_one_work kernel/workqueue.c:3238 [inline]
> >   process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
> >   worker_thread+0x870/0xd50 kernel/workqueue.c:3400
> >   kthread+0x7b7/0x940 kernel/kthread.c:464
> >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > 
> > Commit 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> > changed to lockless __linkwatch_sync_dev in ethtool_op_get_link.
> > All paths except bonding are coming via locked ioctl. Add necessary
> > locking to bonding.
> > 
> > Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> > Reported-by: syzbot+48c14f61594bdfadb086@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086
> > Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> > v2:
> > - move 'BMSR_LSTATUS : 0' part out (Jakub)
> > ---
> >   drivers/net/bonding/bond_main.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> > index 950d8e4d86f8..8ea183da8d53 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -850,8 +850,9 @@ static int bond_check_dev_link(struct bonding *bond,
> >   			       struct net_device *slave_dev, int reporting)
> >   {
> >   	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
> > -	struct ifreq ifr;
> >   	struct mii_ioctl_data *mii;
> > +	struct ifreq ifr;
> > +	int ret;
> >   	if (!reporting && !netif_running(slave_dev))
> >   		return 0;
> > @@ -860,9 +861,13 @@ static int bond_check_dev_link(struct bonding *bond,
> >   		return netif_carrier_ok(slave_dev) ? BMSR_LSTATUS : 0;
> >   	/* Try to get link status using Ethtool first. */
> > -	if (slave_dev->ethtool_ops->get_link)
> > -		return slave_dev->ethtool_ops->get_link(slave_dev) ?
> > -			BMSR_LSTATUS : 0;
> > +	if (slave_dev->ethtool_ops->get_link) {
> > +		netdev_lock_ops(slave_dev);
> > +		ret = slave_dev->ethtool_ops->get_link(slave_dev);
> > +		netdev_unlock_ops(slave_dev);
> > +
> > +		return ret ? BMSR_LSTATUS : 0;
> > +	}
> >   	/* Ethtool can't be used, fallback to MII ioctls. */
> >   	if (slave_ops->ndo_eth_ioctl) {
> 
> 
> Hello, I find that a WARNING still exists:
> 
>   RTNL: assertion failed at ./include/net/netdev_lock.h (56)
>   WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56
> netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
>   WARNING: CPU: 1 PID: 3020 at ./include/net/netdev_lock.h:56
> __linkwatch_sync_dev+0x30d/0x360 net/core/link_watch.c:279
>   Modules linked in:
>   CPU: 1 UID: 0 PID: 3020 Comm: kworker/u8:10 Not tainted
> 6.15.0-rc2-syzkaller-00257-gb5c6891b2c5b #0 PREEMPT(full)
>   Hardware name: Google Compute Engine, BIOS Google 02/12/2025
>   Workqueue: bond0 bond_mii_monitor
>   RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:56 [inline]
> 
> It is report by syzbot (link:
> https://syzkaller.appspot.com/bug?extid=48c14f61594bdfadb086).
> 
> Because ASSERT_RTNL() failed in netdev_ops_assert_locked().
> 
> I wonder if should add rtnl lock in bond_check_dev_link()?
> 
> Like this:
> 
>   +++ b/drivers/net/bonding/bond_main.c
>   @@ -862,10 +862,12 @@  static int bond_check_dev_link(struct bonding
> *bond,
> 
>        /* Try to get link status using Ethtool first. */
>        if (slave_dev->ethtool_ops->get_link) {
>   -        netdev_lock_ops(slave_dev);
>   -        ret = slave_dev->ethtool_ops->get_link(slave_dev);
>   -        netdev_unlock_ops(slave_dev);
>   -
>   +        if (rtnl_trylock()) {
>   +            netdev_lock_ops(slave_dev);
>   +            ret = slave_dev->ethtool_ops->get_link(slave_dev);
>   +            netdev_unlock_ops(slave_dev);
>   +            rtnl_unlock();
>   +        }
>            return ret ? BMSR_LSTATUS : 0;
>        }
> 

What if rtnl_trylock() failed? This will return ret directly.
Maybe
	if (slave_dev->ethtool_ops->get_link && rtnl_trylock()) {
		netdev_lock_ops(slave_dev);
		ret = slave_dev->ethtool_ops->get_link(slave_dev);
		netdev_unlock_ops(slave_dev);
		rtnl_unlock();
		return ret ? BMSR_LSTATUS : 0;
	}

Thanks
Hangbin

