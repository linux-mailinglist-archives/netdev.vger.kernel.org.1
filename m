Return-Path: <netdev+bounces-153370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F6A9F7C8A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F5C188D607
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3781114A630;
	Thu, 19 Dec 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ox+HkDp8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80274200A3
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734615674; cv=none; b=peKh2oxABob/PrpJvKGTLMG7GGrTVMcBoK1JwjJ0NsDKn+Z+nbImLvALdMvbaJZqAuu5wBrc7MZIqDup99cXxDAnlmlD7VFoiP3/AB5FcUBARbgN1VyHLvz6+vfCWELhB2K9e1ImwizfX95naid2cTIr1zrN4pvZBD4oaUl1c8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734615674; c=relaxed/simple;
	bh=TxTzBCyEfX2uTDpZAmGUyoa/x6yYQl5Uge7aNIkyjjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbS0/uCRVgVm1OuBwkcWPWE2msk40U0saEq2gyvTR+zo9lkDZeCW8UjkCY+SX9xRdiXVhfrfBYo48Sn25Qvh28brAIZVJhSjZH+GwuYesq9Bryj87UPa76EgPyeHL9wYjGhw05RH9BGh2gQzh6aLl0e1FbCTi3bFxmVv/eMJOzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ox+HkDp8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MmAfgAmuw+WpG3P2hY3USJpWLqUcqmKn69QN0+rCk48=; b=Ox+HkDp8NvCsU4OORcb65IyZaT
	AJdGwooQXU3gRF0fqwxWLZUiocRxUxReDBEfN32NtH/jsp+NtpR3mFCwEl0ZJ4IfOsxVbG2QEK29M
	BIXnUmB4u5MAhvrOHpTQ4OtnDjQ8GI+uCSq4SR/vI1E86ev1k/h1hiBvy0oQDuYg+LNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOGly-001dCY-Bn; Thu, 19 Dec 2024 14:41:02 +0100
Date: Thu, 19 Dec 2024 14:41:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 1/4] net: dsa: mv88e6xxx: Improve I/O related
 error logging
Message-ID: <ef1ad39a-3f21-43b5-97d9-790cf53499c6@lunn.ch>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-2-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:40PM +0100, Tobias Waldekranz wrote:
> In the rare event of an I/O error - e.g. a broken bus controller,
> frozen chip, etc. - make sure to log all available information, so
> that there is some hope of determining _where_ the error; not just
> _that_ an error occurred.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

