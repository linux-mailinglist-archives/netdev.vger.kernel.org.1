Return-Path: <netdev+bounces-192293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4045EABF464
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6801BC31D3
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 12:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F7425D8FC;
	Wed, 21 May 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ef//jObW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353923909C;
	Wed, 21 May 2025 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830864; cv=none; b=IwuvnAAOswvuM1oA5E3Q4k/nW61umAxiL7zsJCMtqqWiSM36LGPXUTAQlAsRAZvspqpbFeClrBiFbSIl9mEzxeovOAIte5tjNDaxFT4SYykt1OhsJH2Hv0gTl5aeqFL9TD4HCQlBmQ0nO128Tnz5CYfRi0zqZXbhT6MrBYesN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830864; c=relaxed/simple;
	bh=/+8NUsmoNssJxYA0RzXXY7/+dbkVqd/qvdK98c4x3UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8sT9DEnjpDDEdfto+7cBVk5VoDrxit8KxnWdAaDnPY0ZkQy6czmttF21OS3eH2KDq7iCAnSPnhXbZPCAC/JAYziFupZ/evNOhd9nD7DExbgli94LvxzGANsJkolFbr4FPOYMjInNCmYgGUK7XD9Ty7sW9RYuayr7j1tmVNxkk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ef//jObW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qEPg1tXQmSMVouRlKQXAp5F4RbrwowS/jmvNYKyuEDc=; b=ef//jObWa5RZuUnWZB/+bJUiO4
	YYfsG6SmPTzUD4W1/CLQe0QXcnJcatMoDITomTyP5fC8uzzcS8pq4BBFLNRQgpSqEmyuvE7DzKuy0
	ObcfgwpNW9+kuEALtqGJHIfQ5+dX/kYTbfBh7E477Q7P+6zAJW1Si31HfyN7onQSuZK8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uHie4-00DGkL-D2; Wed, 21 May 2025 14:34:04 +0200
Date: Wed, 21 May 2025 14:34:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3b6b9ff7b80430020c7b@syzkaller.appspotmail.com,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next] net: usb: aqc111: fix error handling of usbnet
 read calls
Message-ID: <39e2951b-6e57-4003-b1c7-c68947f579be@lunn.ch>
References: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113240.2369438-1-n.zhandarovich@fintech.ru>

On Tue, May 20, 2025 at 02:32:39PM +0300, Nikita Zhandarovich wrote:
> Syzkaller, courtesy of syzbot, identified an error (see report [1]) in
> aqc111 driver, caused by incomplete sanitation of usb read calls'
> results. This problem is quite similar to the one fixed in commit
> 920a9fa27e78 ("net: asix: add proper error handling of usb read errors").
> 
> For instance, usbnet_read_cmd() may read fewer than 'size' bytes,
> even if the caller expected the full amount, and aqc111_read_cmd()
> will not check its result properly. As [1] shows, this may lead
> to MAC address in aqc111_bind() being only partly initialized,
> triggering KMSAN warnings.

It looks like __ax88179_read_cmd() has the same issue? Please could
you have a look around and see if more of the same problem exists.

Are there any use cases where usbnet_read_cmd() can actually return
less than size and it not being an error? Maybe this check for ret !=
size can be moved inside usbnet_read_cmd()?

	Andrew

