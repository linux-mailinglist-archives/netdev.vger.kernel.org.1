Return-Path: <netdev+bounces-148761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1E9E313D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CD82865F4
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 02:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083534545;
	Wed,  4 Dec 2024 02:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQQpBxbo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739C2746C;
	Wed,  4 Dec 2024 02:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733278388; cv=none; b=VIx/u6DXN7xCBkj90QXT0pOGeOs/WRD2Eu0Il2+nPFlPn2z/ls45bxrsFbb57zNbUw3+jMVYawFUV3RQ0Nj3xQPpZjdUdM5URBjd7zCsq5e5na4aNBXauSGu6tgul1QJfDUqj6vokg8wXQxr7UzNLrnqwaOC84goGTXSnM8Bqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733278388; c=relaxed/simple;
	bh=BieFi/1tYmhR2tlh+ZQ2myChmw8grWRNWCmLWrbPN3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KICNcYLgfIIqEpXrCQNc4+W5mRovJHGbKs/13D6nfAmgQqdAvBRybeOXQEkOXKipn4yaH0bW3fewBX1XbCBoAI7O7ffDCZbPj0HKxNUdLaSw5j25xSC488NAbZSxw8l/8VhlhOsja/dEuRM1LCBbAaRz3Wc8WEsCE7ENBSM1ezc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQQpBxbo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E7C4CEE0;
	Wed,  4 Dec 2024 02:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733278386;
	bh=BieFi/1tYmhR2tlh+ZQ2myChmw8grWRNWCmLWrbPN3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQQpBxboyftOur3vQ6bBe5tUy96cwIq+WX2Td6frHW/Tstzk3CkXvkIAMpcx4pfxc
	 qkEVRcYkaP44LlO6zZs958wcxe5ipnlNoBrCgpRX8ke5/Ey42P6gRpGEWbmE3Mj4Zo
	 XP0rVqEr+9/Yh3dIHblVh7Fdwn1FU/N+vL2fnYGuV8gw1JBMqSHBGcuQOJm5akxHsg
	 DP7ybx6MPy/v0yy05RYMQbHwlHu68GKI6SOgUQXxgliCwEBEpfKY168mzA6iYoO8YG
	 EChvxOKaXYoumJ4LtA014UEE+LTTpRcUtkRXrowTOhQyGtQ2Htf+UFB1/tx7CjhMZD
	 MB/FdDwTVACMQ==
Date: Tue, 3 Dec 2024 18:13:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Oliver Neukum
 <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dominique Martinet
 <dominique.martinet@atmark-techno.com>, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
Message-ID: <20241203181304.69b701d1@kernel.org>
In-Reply-To: <5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
	<5b93b521-4cc8-47d3-844a-33cf6477a016@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 21:47:57 +0100 Andrew Lunn wrote:
> Are you saying the OTP or NVMEM has a locally administered MAC address
> stored in it? Is there a mechanism to change it? The point about
> locally administered MAC addresses is that they are locally
> administered.

You may also enjoy reading this :)

commit bfe9b9d2df669a57a95d641ed46eb018e204c6ce
Author: Kristian Evensen <kristian.evensen@gmail.com>
Date:   Thu Jul 21 11:10:06 2016 +0200

    cdc_ether: Improve ZTE MF823/831/910 handling
    
    The firmware in several ZTE devices (at least the MF823/831/910
    modems/mifis) use OS fingerprinting to determine which type of device to
    export. In addition, these devices export a REST API which can be used to
    control the type of device. So far, on Linux, the devices have been seen as
    RNDIS or CDC Ether.
    
    When CDC Ether is used, devices of the same type are, as with RNDIS,
    exported with the same, bogus random MAC address. In addition, the devices
    (at least on all firmware revisions I have found) use the bogus MAC when
    sending traffic routed from external networks. And as a final feature, the
    devices sometimes export the link state incorrectly. There are also
    references online to several other ZTE devices displaying this behavior,
    with several different PIDs and MAC addresses.


