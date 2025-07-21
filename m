Return-Path: <netdev+bounces-208614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB78B0C585
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCF3B3B82
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FEF2D978C;
	Mon, 21 Jul 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v+exzbA8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F320299957;
	Mon, 21 Jul 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105879; cv=none; b=LIV+NXgJpyCPfTVWoEtEKAp1HlcJ5wFhJ0t231mVKRkcQkuDevXNtn60aIQH0THKVTP5l3aDTeTSh8HD+hzfJ84Pgx3ZFItXZnB5dC9V/bWbDEbvuUH1vr510bAdecsD7TcWWBAE0/sYKWalRSwqtvkDFY73uX3kInXv1VMkY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105879; c=relaxed/simple;
	bh=y5/o5KPwHYjdYOYn2qJEYE/7ehq/IGpGsTgAYEn1xZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEACQGW8sWs6oVvAOJfWFRxb8EAw5IbtIxukAfMYpT2X+2uhs0a/mWRib0uSSRnMpfPiHrZhh4Ib7tbR6ZSYnzO3KFLoSFFJTgjdlio0ODjO+PbyvCG0MSgoRakk5ddaE5fWyLQXtJG/KbTb7h8mWUI1Y7J8Qi9wtb9WM2CIL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v+exzbA8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jhmYoiRkgg7u9xv+OUfysFT+GWk/FxDqw425ItZ1dp4=; b=v+exzbA8xokg7ZQmcOPc8s6YHt
	ySHlbIWRH9WG/7XO+LKuJhtCMk2qlx+Q8nC0Rbe+jIdsNzmQjUlVFHktlCKsdPjaEa1kMqYlv91+w
	OlUPStBOJY4hN6BpAvb7kREOc0AySFyo+K/uDFeGskM3djBdyACAs75pbxp/c1k/7Ug0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1udqv5-002MUU-9C; Mon, 21 Jul 2025 15:51:07 +0200
Date: Mon, 21 Jul 2025 15:51:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>
Subject: Re: [PATCH] usbnet: Set duplex status to unknown in the absence of
 MII
Message-ID: <496e1153-acac-468a-b39c-9ea138b2cf04@lunn.ch>
References: <20250721071022.1062495-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721071022.1062495-1-yicongsrfy@163.com>

On Mon, Jul 21, 2025 at 03:10:22PM +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> CDC device don't use mdio to get link status, duplex is set
> half as default.
> 
> Now cdc_ncm can't get duplex, set it UNKNOWN instead of half
> which might actually be in an error state.

It appears that CDC has a transfer to report the link status:
usbnet_cdc_status(). There is a u32 which contains the link speed. Is
the duplex also included in this transfer?

What does the standard say about duplex? Are 1/2 duplex modes are
supported? Is it clear stated they are not supported? 1G/half not be
supported depending on the MAC/PHY pair?

	Andrew

