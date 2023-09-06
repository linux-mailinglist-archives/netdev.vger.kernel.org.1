Return-Path: <netdev+bounces-32278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CAA793D46
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5754E1C20B42
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8BCDF6D;
	Wed,  6 Sep 2023 12:59:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCD81368
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 12:59:46 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA4ACE2
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=msIioonhUKtNJR64VJl1Z7txJgXnWTAg9ktvhF//hdg=; b=s8I7esIARuBqIEADHNer8UxuCG
	Fq69iDbWtaul0bNGpOUcRk4mJkTD5NMEPzzPbyGjdjXY9agOrnXV/lHwcJS+Q722lKELKGEKzAxqS
	Uh+YNz/ddASHfAbveJfRftCUFm5LWV8RplbFhvlV8d7QrtkNJzny4divJ8fGCWdGtVio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qds8A-005u3c-DH; Wed, 06 Sep 2023 14:59:38 +0200
Date: Wed, 6 Sep 2023 14:59:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jijie Shao <shaojijie@huawei.com>, f.fainelli@gmail.com,
	davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <09a5d7bd-d020-47d5-9a02-fdbbca7bb62b@lunn.ch>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
 <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
 <29917acb-bd80-10e5-b1ae-c844ea0e9cbb@huawei.com>
 <ZPcxnHjDJIMe3xt5@shell.armlinux.org.uk>
 <ZPdISTBrrX345RCz@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPdISTBrrX345RCz@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Having looked deeper at this, I think there may be a solution. See
> these follow-on patches.

Hi Russell

I'm on vacation at the moment with limited time and network access.

> Move the call to phy_suspend() to the end of phy_state_machine() after
> we release the lock.

I know this is a quick RFC exploration of the problem space, but it
would be good to comment about 'Why?'. Suspend and resume has had
deadlock issues in the past, which is why they don't take the lock.

> Split out the locked and unlocked sections of phy_state_machine() into
> two separate functions which can be called inside the phydev lock and
> outside the phydev lock as appropriate.

Again, i think some mention of suspend/resume would be good, since
that is what is causing these issues. Maybe we also need to add a
comment next to struct phy_device lock about what the lock should be
protecting.

	Andrew

