Return-Path: <netdev+bounces-166913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF7EA37D9F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEB118879F2
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D601A5BB1;
	Mon, 17 Feb 2025 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yo0pUhoV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246821A5BAD;
	Mon, 17 Feb 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782546; cv=none; b=HBQBgXRkQ9ylWTUkg7qCI3h4M9W1OJiPq6D2SDbg8UHKj26LbW3/3kr844grvhXZbAAqw2xOmNSvWX40YEImWd9zcZUB0G2adGAmEpGSqT3WAXR/rAnqGY+XfKz8DAHE9m+Sz68O7/ESSF/uf/1QBcvHX7ukMQOWIijdkzfgQPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782546; c=relaxed/simple;
	bh=EFEkJhwmsl3bE4JjyU5jJiAhM1TmuoUEGGWs/FNGWnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqZbDmjGREEKMk5rUOwVn58bRWVkSUeAPczOLbOrJ3KqslDvKT1kr6IalzHnVfNjIPvl5Y5CrPKCsAmv8hHWkVcb4HXePLRKzRMy9F8aFonMxc7tCB3eIhbjAj/1fBygzcd94awmG4W0RG+x3KsvWk46bQ0mttd67Vh9TNDGkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yo0pUhoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9EBC4CED1;
	Mon, 17 Feb 2025 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739782545;
	bh=EFEkJhwmsl3bE4JjyU5jJiAhM1TmuoUEGGWs/FNGWnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yo0pUhoVFd0aJzWxdHo4ZXreXR6IglCbU7SJLVBMqq/pEZjzyKTx0UeF1sCQ+S3Og
	 kDg+yxTY63/5tpJ/RPLud90voPYhYnyCzKCpPzl31brSYScbr2ivzccyvxIwQIKe8b
	 d29cH5pvYTpB3Fn6jGnLFPPkvfSDFqEMtYD3Aj/Y=
Date: Mon, 17 Feb 2025 09:55:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs
 isoc_alt
Message-ID: <2025021705-speckled-ooze-c4d0@gregkh>
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021425-surgical-wackiness-0940@gregkh>
 <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFd3H0DLV-WX8jTB1VGyOZYEzchP99QvYxWmg1XCOo1ttg@mail.gmail.com>

On Mon, Feb 17, 2025 at 04:44:35PM +0800, Hsin-chen Chuang wrote:
> On Fri, Feb 14, 2025 at 7:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 14, 2025 at 07:16:17PM +0800, Hsin-chen Chuang wrote:
> > > From: Hsin-chen Chuang <chharry@chromium.org>
> > >
> > > Expose the isoc_alt attr with device group to avoid the racing.
> > >
> > > Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> > > it also becomes the parent device of hci dev.
> > >
> > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control USB alt setting")
> >
> > Wait, step back, why is this commit needed if you can change the alt
> > setting already today through usbfs/libusb without needing to mess with
> > the bluetooth stack at all?
> 
> In short: We want to configure the alternate settings without
> detaching the btusb driver, while detaching seems necessary for
> libusb_set_interface_alt_setting to work (Please correct me if I'm
> wrong!)
> 
> Background:
> The Bluetooth Core Specification defines a protocol for the operating
> system to communicate with a Bluetooth chipset, called HCI (Host
> Controller Interface) (Host=OS, Controller=chipset).
> We could say the main purpose of the Linux Bluetooth drivers is to set
> up and get the HCI ready for the "upper layer" to use.
> 
> Who could be the "upper layer" then? There are mainly 2: "Control" and
> "User" channels.
> Linux has its default Bluetooth stack, BlueZ, which is splitted into 2
> parts: the kernel space and the user space. The kernel space part
> provides an abstracted Bluetooth API called MGMT, and is exposed
> through the Bluetooth HCI socket "Control" channel.
> On the other hand Linux also exposes the Bluetooth HCI socket "User"
> channel, allowing the user space APPs to send/receive the HCI packets
> directly to/from the chipset. Google's products (Android, ChromeOS,
> etc) use this channel.
> 
> Now why this patch?
> It's because the Bluetooth spec defines something specific to USB
> transport: A USB Bluetooth chipset must/should support these alternate
> settings; When transferring this type of the Audio data this alt must
> be used, bla bla bla...
> The Control channel handles this in the kernel part. However, the
> applications built on top of the User channel are unable to configure
> the alt setting, and I'd like to add the support through sysfs.

So the "problem" is that Google doesn't want to use BlueZ, which is
fine, you do you :)

But how does BlueZ handle this same problem today?  What api to the
kernel does it use to change the interface that you can't also do with
your "BlueZ replacement"?

Surely this isn't a new issue suddenly, but if it is, it needs to be
solved so BOTH userspace stacks can handle it.

thanks,

greg k-h

