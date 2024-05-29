Return-Path: <netdev+bounces-98836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 785318D29B3
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02725B22F1A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B65A15A870;
	Wed, 29 May 2024 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P30Ti1Zl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63C15A4B0;
	Wed, 29 May 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716944271; cv=none; b=AwJafN4TxBpPsqOvzyBY6/oBYM8m5LYiVzDvFlM91aKyOXpQu7L62sbsD/oV0US9aNwbD3geJ9gmckXrvxucuTGSQX2VkPJ7lnrGcRh6/oDE2lpgmI/5LfwzTVzGp12h2WHGuiqsjzi1e6Vvo3ZlkV9lvLlqFMealnxYtjRCyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716944271; c=relaxed/simple;
	bh=AraHFqx4I0Qj3E8eWDPfD85mAXFWlrNgrS4CLt0j9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJeI0ACiyZ90dHgwKqJsXpennUt97P7JT01JQUpb1nJdM7JHVtlM0WlG0+po2QbeSJhYfD5O59kp5kigbiyM5Mefh8pb51yfy8vzjNiQS+nxCMNXN7uNoGPgp/I5Mx+eKW5FdNuI80Cj9jDEuBXduL3rsqv5jTmNbu9Oogb6F90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=P30Ti1Zl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Uc9wbdSCjB4aRQaMQK3vAbL5GRmBcqg8D+vgFNE/IIo=; b=P30Ti1ZluiSyOk4p3JxX6rPt2u
	/tmdHiWPoKok8CAOrXsZx+k98mQSzCZi/iOjBLnm097GVh0YiFH6xhQ4VMfHjGIIa6wTrzboxGOXO
	mdt5FZkuH3elryg7WPX3nPKwold6yyP4n8GJW7aPSQPv+0UqyFZNXeZckVPiIaOfhgGI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sC7d9-00GChD-6g; Wed, 29 May 2024 02:57:27 +0200
Date: Wed, 29 May 2024 02:57:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: xiaolei wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN
 when link down
Message-ID: <98e6266f-805c-4da2-b2dc-b25297c53742@lunn.ch>
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
 <775f3274-69b4-4beb-84f3-a796343fc095@lunn.ch>
 <b499cbcd-a3c9-4f38-a69a-ad465e7f8d5a@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b499cbcd-a3c9-4f38-a69a-ad465e7f8d5a@windriver.com>

On Wed, May 29, 2024 at 08:22:01AM +0800, xiaolei wang wrote:
> 
> On 5/28/24 21:20, Andrew Lunn wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
> > > The CBS parameter can still be configured when the port is
> > > currently disconnected and link down. This is unreasonable.
> > This sounds like a generic problem. Can the core check the carrier
> > status and error out there? Maybe return a useful extack message.
> > 
> > If you do need to return an error code, ENETDOWN seems more
> 
> Currently cbs does not check link status. If ops->ndo_setup_tc() returns
> failure, there will only be an output of "Specified device failed to setup
> cbs hardware offload".

So it sounds like we should catch this in the core then, not the
driver. And cbs_enable_offload() takes an extack, so you can report a
user friendly reason for failing, the at the carrier is off.

    Andrew

---
pw-bot: cr

