Return-Path: <netdev+bounces-22410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB9476758E
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1F3282733
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE9DDB0;
	Fri, 28 Jul 2023 18:37:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A5B23B8
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE067C433C9;
	Fri, 28 Jul 2023 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690569422;
	bh=VhW9754r/xHgbkl4SQvV6/vtuAPsleX6lTRUEYDrugs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZVm/F2sKC+3bKiv6sSlhvmOWOeFLVzfOxaC7za32TVqjHs6BT/FakbhW+2b03k6V
	 v0TMa+iZJTbYVJ1pTocbmtM4rMSavZAll7Rl5XFt7mfndVYonSdwRIn4hAkdGV17qr
	 zfAJbXrAQgzKxDgejC7sfqxwmpqYOwr+Ts1zrsFGj+46XnxGpIKeu7Cjb6LyMhNcrG
	 WHHezgSUFxylFnQte7tWkl+d8jiVtPhV4Er50pwBmyREADyyNUTua1NqJ5po9RYJ8y
	 uapZqcsqj2jJ+zwyP8A8ioYj8EO2Hizfi7li7neuKK9uyve27+ALwLLzvq475j1xlV
	 IvXlg4hBsFiIg==
Date: Fri, 28 Jul 2023 20:36:59 +0200
From: Simon Horman <horms@kernel.org>
To: Mat Kowalski <mko@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net:bonding:support balance-alb with openvswitch
Message-ID: <ZMQKy7xp8+pf/Bqx@kernel.org>
References: <1a471c1b-b78c-d646-6d9b-5bbb753a2a0b@redhat.com>
 <ZMOusD1BnLXqiUEE@kernel.org>
 <1bfe95c4-80f0-4163-6717-947c37d4f569@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bfe95c4-80f0-4163-6717-947c37d4f569@redhat.com>

On Fri, Jul 28, 2023 at 02:17:03PM +0200, Mat Kowalski wrote:
> Hi Simon,
> 
> Thanks a lot for the pointers, not much experienced with contributing here
> so I really appreciate. Just a question inline regarding the net vs net-next
> 
> On 28/07/2023 14:04, Simon Horman wrote:
> > Hi Mat,
> > 
> > + Jay Vosburgh <j.vosburgh@gmail.com>
> >    Andy Gospodarek <andy@greyhouse.net>
> >    "David S. Miller" <davem@davemloft.net>
> >    Eric Dumazet <edumazet@google.com>
> >    Jakub Kicinski <kuba@kernel.org>
> >    Paolo Abeni <pabeni@redhat.com>
> >    netdev@vger.kernel.org
> > 
> >    As per the output of
> >    ./scripts/get_maintainer.pl --git-min-percent 25 this.patch
> >    which is the preferred method to determine the CC list for
> >    Networking patches. LKML can, in general, be excluded.
> > 
> > > Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
> > > vlan to bridge") introduced a support for balance-alb mode for
> > > interfaces connected to the linux bridge by fixing missing matching of
> > > MAC entry in FDB. In our testing we discovered that it still does not
> > > work when the bond is connected to the OVS bridge as show in diagram
> > > below:
> > > 
> > > eth1(mac:eth1_mac)--bond0(balance-alb,mac:eth0_mac)--eth0(mac:eth0_mac)
> > >                        |
> > >                      bond0.150(mac:eth0_mac)
> > >                                |
> > >                      ovs_bridge(ip:bridge_ip,mac:eth0_mac)
> > > 
> > > This patch fixes it by checking not only if the device is a bridge but
> > > also if it is an openvswitch.
> > > 
> > > Signed-off-by: Mateusz Kowalski <mko@redhat.com>
> > Hi,
> > 
> > unfortunately this does not seem to apply to net-next.
> > Perhaps it needs to be rebased.
> > 
> > Also.
> > 
> > 1. For Networking patches, please include the target tree, in this case
> >     net-next, as opposed to net, which is for fixes, in the subject.
> > 
> > 	Subject: [PATCH net-next] ...
> It makes me wonder as in my view this is a fix for something that doesn't
> work today, not necessarily a new feature. Is net-next still a preferred
> target?

Hi Mat,

Certainly there is a discussion to be had on if this is a fix or a feature.

I would argue that it is a feature as it makes something new work
that did not work before. As opposed to fixing something that worked
incorrectly.

But there is certainly room for interpretation.

> > 
> > 2. Perhaps 'bonding; ' is a more appropriate prefix.
> > 
> > 	Subject: [PATCH net-next] bonding: ...
> > 
> > ...
> > 
> 
> 

