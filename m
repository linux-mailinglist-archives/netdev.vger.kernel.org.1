Return-Path: <netdev+bounces-137638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE299A916F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A96C1C2333B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C61FDF85;
	Mon, 21 Oct 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Hl7X7F1C"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB01FDFAD;
	Mon, 21 Oct 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543466; cv=none; b=rFe4zG5gsmeZ3P3+x4QLBeybchhbZQr95qZo6hKHXmDtlKlV85BV9tksHW+cuvO7ja7nJo208oFmPTK0zLDHvdI9gOeKr9MQ0EAp+py7X+1c3Z/zvhS5GoEnHjgkrJrXqhNytPTlv9V5gI6W3bJ4hf+twNIbqgYvSgck++P3Dz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543466; c=relaxed/simple;
	bh=Vc/62rHZlgnbb6nr4BcJAdJ8aceL/E+lYtvbA9WT0js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQRskyCRztbsUSmavwj1TZ8othQyZ69WfVgCZsVjIL3vd2dAtnjG4S2PBsgS/t9I4rWDLa9fzm/6C7o01M+l8DHqBRjPzURGddOajIPTZ7kD8H2yY5MDVVfiRBhXrTw/Xzcd61LwjtaGyUT9lTnl0pPgtOGU+Y8Re5OF0/H4kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Hl7X7F1C; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LaFy/AKP/LLiFFshor6bfHvjvfOdSoy5BbdGuqUN/Dg=; b=Hl
	7X7F1CXsThOB/zoFat18huu37ADDc0ROaz0bfq1H923Vk/jTCt9Gh/RoI6AbuT/CDG/2Mi36JTdAD
	3FY4ZXAK4vhLZsKGvMJcO9z/0NB3SUk5MVXfTUoq/TKmWSDiVrhcLlAQPOre/FYwVe7tdfB/vj/nO
	FRmA2ITHeV/WjfA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t2zGB-00AlcB-GZ; Mon, 21 Oct 2024 22:44:15 +0200
Date: Mon, 21 Oct 2024 22:44:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
	netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mv88e6xxx: use ethtool_puts
Message-ID: <61c72b95-7e54-4534-9ac4-f108e8a0dabd@lunn.ch>
References: <20241021010652.4944-1-rosenp@gmail.com>
 <CAH-L+nN0W_BffMR6s6Je9LufSs5ZtSHm13_O1aGhDnTjPNqouw@mail.gmail.com>
 <CAKxU2N9JGwfg37Qoj=gLj0_f+cd1dN_ek+GT402xOe-Y2M0xtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9JGwfg37Qoj=gLj0_f+cd1dN_ek+GT402xOe-Y2M0xtg@mail.gmail.com>

On Mon, Oct 21, 2024 at 11:56:47AM -0700, Rosen Penev wrote:
> On Mon, Oct 21, 2024 at 9:27 AM Kalesh Anakkur Purayil
> <kalesh-anakkur.purayil@broadcom.com> wrote:
> >
> > On Mon, Oct 21, 2024 at 6:37 AM Rosen Penev <rosenp@gmail.com> wrote:
> > >
> > > Allows simplifying get_strings and avoids manual pointer manipulation.
> Looking more at these files, I see further pointer manipulation later
> on. Specifically I have this change locally:

So lets mark this as change-requested.

    Andrew

---
pw-bot: cr

