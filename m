Return-Path: <netdev+bounces-242152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DACC8CC4E
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 04:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068323AEC53
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 03:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA02BE7AD;
	Thu, 27 Nov 2025 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Coo35Sns"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D5225416;
	Thu, 27 Nov 2025 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764215289; cv=none; b=rNjRTPBjFz5Z08rknYoNVof630GUGDYuWxMiBjKrxOHWqMFq+2WLF2BqEhnLXo3R2ZVa5+w+g8z2Es96V+cIFRSt0JX4p1Mh6fhZ/EJ9UmzY1s0uE5QuR8aF2yMWbWkd676RT+BZ8uy0I8YmQ4hdGQdzAIu9gHUPcZ+QFhqyisk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764215289; c=relaxed/simple;
	bh=ARpE24dRbbn0AGmA6audrYNoVgjKJW6i3Rl1fEyJOm4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9LvlkInrUdokYyhgv0huA6594MwGmdCStQWsXxo/IDZ+f4vZiDYFaW+uM4UvUEAJxf9qz3Cy0ns6E/rL9zBJVwUo7X8wzyMStnVUi2sswCD3OrJ4meBhGaa4ILQ18M3FmnRUd+VDlIvdwhel4yRcnolZPunELqVbff25lM3bDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Coo35Sns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2776C4CEF8;
	Thu, 27 Nov 2025 03:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764215286;
	bh=ARpE24dRbbn0AGmA6audrYNoVgjKJW6i3Rl1fEyJOm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Coo35SnsktbtAy15Xe/7Nr4jYGaiedZxsGCI5rLUuXAtKcuuVzlShQSusqoVSeq+M
	 uB/hP9v5bZCjFZrJdV6GL6wK675Acz8Bt/uTSVvt046w9U8D1Mqi63TnDwmsIS6Xzb
	 T6GTqn3Os2LdXiLoyBlHj9Ey1A+00TmFQRsjqbbtOUXuQ/0pbfyLUMhoujJCSo3i7g
	 OycRZyb/RkSEkznzhE76aK0vDbSZ1odFsUkaKXGrIH7AzQBpSvNWf+MBflD3epy9Me
	 GIS9AzYPLp0TXY+lGwjsfwCCIEw17mEZ5fV65p941aRlP/J/qtUYydFe/i4PDhL2b5
	 DuJQZHd3YSpbw==
Date: Wed, 26 Nov 2025 19:48:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "virtualization@lists.linux.dev"
 <virtualization@lists.linux.dev>
Subject: Re: [PATCH net v3] virtio-net: avoid unnecessary checksum
 calculation on guest RX
Message-ID: <20251126194804.62737172@kernel.org>
In-Reply-To: <CACGkMEt2FFSiodAN=FFT7JnV78pmVRN4VTr_XDm05J0xpSfmHA@mail.gmail.com>
References: <20251125222754.1737443-1-jon@nutanix.com>
	<CACGkMEvK1M_h783QyEXJ5jz25T-Vtkj4=-_dPLzYGwPg8NSU5Q@mail.gmail.com>
	<8FC82034-6D22-4CDC-B444-60F67A25514C@nutanix.com>
	<CACGkMEt2FFSiodAN=FFT7JnV78pmVRN4VTr_XDm05J0xpSfmHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 09:27:16 +0800 Jason Wang wrote:
> > It could, sure. This made it into 6.17 branch.
> >
> > Would you like me to send a separate patch with a Cc: stable
> > or could someone just edit the commit msg when they queue
> > this?  
> 
> I think a new version might be better.

Added.

