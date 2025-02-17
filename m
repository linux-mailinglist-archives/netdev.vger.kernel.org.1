Return-Path: <netdev+bounces-166902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BCAA37D8B
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 09:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E401B1890E49
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850001A76BB;
	Mon, 17 Feb 2025 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o1ihM3c0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395491A3148;
	Mon, 17 Feb 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782418; cv=none; b=EAep0mrL5a7LtqF4pRQRwOkSoVszNk5HXcTkG4jSHC/7RWyfNkPo4FgGncb7eesZBXZbFYW9061GFsg9Vk5xApo1/DLchAJkEOCYsY+Gt5ZKm7tzEUtViE8zoYbzDmbPHJjBlmyasL3/zNd4deQP04GKranyLYwG0PNDfRMSWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782418; c=relaxed/simple;
	bh=NQAGRszoXd7XKuzprwEoRex28p+4g9ymhtAUqgJpjSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT2Q7Bt9EOLRssVeVJSYaHh/O4P+Nl79iiCxSqsu4nmRUOpbD5ulHdcFq/PsF0Um5Th++S7DvI4mOfbW6JdlJ2xjwCHWnrLUQwc4FHC0pMKlcNO5oqh1MpRNoRuhJG62ta5TB3E4nCcBG5e4Lk1LL72zRPhBjr9d80TRWRQAxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o1ihM3c0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D3C4CED1;
	Mon, 17 Feb 2025 08:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739782417;
	bh=NQAGRszoXd7XKuzprwEoRex28p+4g9ymhtAUqgJpjSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o1ihM3c0k1Gi4V7VTw/MQnoWlbhwT8JF4wRDuwszLncV0NtqTgKBVUV5ct6geo/uO
	 dFKMdvYrpnR/raXgPeWQh8w4mgoAUsR7UFNn5zifb4NSrC0s1+4GQbIs/ku9LLYwsy
	 5F103MI4sPs5o4axCUmlCpdlvku/cfCjAlZbV5GA=
Date: Mon, 17 Feb 2025 09:53:34 +0100
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
Message-ID: <2025021717-prepay-sharpener-37fb@gregkh>
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

I think changing the alternate setting should work using usbfs as you
would send that command to the device, not the interface, so the driver
bound to the existing interface would not need to be removed.

Try it out and see yourself to verify this before you continue down any
of this.  There's no need to use libfs for just a single usbfs command,
right?

thanks,

greg k-h

