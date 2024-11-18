Return-Path: <netdev+bounces-145906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79769D149C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FCD2835D0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7C1AA1E5;
	Mon, 18 Nov 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AUVSmCQs"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932812EBE7
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944440; cv=none; b=U+YUmFkpq1fM6SSCmfZzvJEqi/BIl8vctf/MgnbKZM0QlfVodwPHr57oNJ7ddWDecqABce4EDDt78UKGxktNfYrJCBPNXcIoVtOWeP68+xFX77rzn9iZQHCcw7O77+R+Yl2kdffGpCk3khaWv8JsZb7bufrE+ctsxC+cAoO0lmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944440; c=relaxed/simple;
	bh=/Km9YxFLkfZCEQpk5SszycM2L9NSlGTGg37GnpbUWbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAabtPp3rImJT0Dnxl23WYZHHooUuFDNTKu+PV5dnSCeEBOZe8OTRZTW/fY3WIc56VilqxP4VJ3plduZ6xI0SlaLWbw3FDhLh1eB5sA7vOgJSJUUfUwVXo9YyQwP2HK0ay8WteRILzerqoo3LYuJHg8VUH8k+CA99745n/HTa8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AUVSmCQs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=afqFc3Q9dQzZ/p9Hug2RfDnAeaQrSRGFJv/Jafb1wKw=; b=AUVSmCQsjIkXe/evRIkAgJeZEZ
	oCOgD2/OwRsmJUJ94aPxunE4lQ6A2GfLWB1dHjN4WWiELj7BTvvVYXdS5jyzRWIJYMIu5NqdpPhve
	JEvsIGYVxXQemK8Mz5pfkb5dLmPr4fgZ2OcVxbiCA4s/soAOZ2rlUAlss1U9FFyA1h4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tD3rb-00DggU-Oo; Mon, 18 Nov 2024 16:40:31 +0100
Date: Mon, 18 Nov 2024 16:40:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, alexanderduyck@fb.com,
	Sanman Pradhan <sanman.p211993@gmail.com>
Subject: Re: [PATCH net-next 4/5] eth: fbnic: add PCIe hardware statistics
Message-ID: <4a543595-672a-4554-9cef-9a863ed23ca8@lunn.ch>
References: <20241115015344.757567-1-kuba@kernel.org>
 <20241115015344.757567-5-kuba@kernel.org>
 <1ed2ba1e-b87f-4738-9d72-da7c5a7180e2@lunn.ch>
 <20241118073501.4e44d114@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118073501.4e44d114@kernel.org>

On Mon, Nov 18, 2024 at 07:35:01AM -0800, Jakub Kicinski wrote:
> On Sun, 17 Nov 2024 21:19:00 +0100 Andrew Lunn wrote:
> > > +/* PUL User Registers*/
> > > +#define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
> > > +					0x3106e		/* 0xc41b8 */  
> > 
> > Is there a comment somewhere which explains what these comments mean?
> > Otherwise they appear to be useless magic numbers.
> 
> The number on the left is the number on the right divided by 4.
> We index the registers as an array of u32s so the define is an index,
> but for grep-ability we add the absolute address in the comment.

Ah, O.K. Maybe a comment about this would be nice.

> > > +static void fbnic_hw_stat_rst64(struct fbnic_dev *fbd, u32 reg, s32 offset,
> > > +				struct fbnic_stat_counter *stat)
> > > +{
> > > +	/* Record initial counter values and compute deltas from there to ensure
> > > +	 * stats start at 0 after reboot/reset. This avoids exposing absolute
> > > +	 * hardware counter values to userspace.
> > > +	 */
> > > +	stat->u.old_reg_value_64 = fbnic_stat_rd64(fbd, reg, offset);  
> > 
> > I don't know how you use these stats, but now they are in debugfs, do
> > they actually need to be 0 after reboot/reset? For most debugging
> > performance issues with statistics, i want to know how much a counter
> > goes up per second, so userspace will be reading the values twice with
> > a sleep, and doing a subtractions anyway. So why not make the kernel
> > code simpler?
> 
> Right, there is no strong reason to reset debugfs stats. OTOH
> consistent behavior across all stats is nice (from rtnl stats 
> to debugfs). And we will need the reset helpers for other stats.
> Meta uses a lot of multi-host systems, the NIC is reset much
> less often than the machines. Starting at 0 is convenient for 
> manual debug.

If the code is being reused, then O.K.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

