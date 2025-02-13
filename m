Return-Path: <netdev+bounces-166013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDEA33ED2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510C6188E334
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B011215059;
	Thu, 13 Feb 2025 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ixSxsLst"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BEB227EBD;
	Thu, 13 Feb 2025 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739448615; cv=none; b=djLfzIp12WCLxKmB8RjAK7rhwWtjlvRsffCQdt9fXvI4wlslDvRvhGNS14J4giypsv3PZNswCQ6xdq9Dh04HDvrN5QcHbQhRFmKNRhaY3r0GIFZFQTv0LYl5Jda/UM/ZFmNf8AjnsmwgcTXUX9Whb2fwTk4WDJ0yGc9XFRd+frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739448615; c=relaxed/simple;
	bh=0K3K8Ve6Nf+QbJw4fodrmcsL0YTbcamOy8gUjErmc2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldWnFFj+1B6/mI7q9lDpuyI4IXycda7KaxTxgj3344SAsaPjanXd+ECdAmrls15nVJpi4PHsIQLnq0tCH1KtiEZWnwKJ8LANYjMcTaVVnRwB39tyg7myR+wgg5nB3phAGWSEqWfQG5hfdkLD1D6bjr+HJ/B/svJh8nxzW3k6h6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ixSxsLst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C0ACC4CED1;
	Thu, 13 Feb 2025 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739448614;
	bh=0K3K8Ve6Nf+QbJw4fodrmcsL0YTbcamOy8gUjErmc2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ixSxsLstbWTuePxMz3K5LBIMEBN5+UAXB9TpGsYtjORULLl23r3uXZScfa6jCdtAW
	 eJPFPf29GJ07aFQ7mOOM+Bc4S8DPhswkESUeWlXrHZVLfGcbAUMsWsD4UpxbwAWTQP
	 2pIvoBZgGl270Q6ixbbAn2sTFd/sTkXqjf+y85Zw=
Date: Thu, 13 Feb 2025 13:10:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
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
Subject: Re: [PATCH v4 1/3] Bluetooth: Fix possible race with userspace of
 sysfs isoc_alt
Message-ID: <2025021347-washboard-slashed-5d08@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <2025021352-dairy-whomever-f8bd@gregkh>
 <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADg1FFdez0OdNDPRFPFxNHL_JcKmHE6KNxnYvt4sK7i+Uw6opA@mail.gmail.com>

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Feb 13, 2025 at 07:57:15PM +0800, Hsin-chen Chuang wrote:
> The btusb driver data is allocated by devm_kzalloc and is
> automatically freed on driver detach, so I guess we don't have
> anything to do here.

What?  A struct device should NEVER be allocated with devm_kzalloc.
That's just not going to work at all.

> Or perhaps we should move btusb_disconnect's content here? Luiz, what
> do you think?

I think something is really wrong here.  Why are you adding a new struct
device to the system?  What requires that?  What is this new device
going to be used for?

confused,


greg k-h

