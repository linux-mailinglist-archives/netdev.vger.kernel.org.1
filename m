Return-Path: <netdev+bounces-49032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657BC7F0749
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC5C280D73
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6D512B8B;
	Sun, 19 Nov 2023 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wfpBmUyM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5C4115;
	Sun, 19 Nov 2023 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WSZo0HiqPJC+cW7wD2ToIIgPq5GAr1sCmwoi6BPZYyk=; b=wfpBmUyMp7Y8DNzc9PHhG1vpFY
	ZWpNFp4z/+T/NJ24mYR6+FlMIKqDoC+syy4C90PcfreFMazL61hZMLYNZRqGpVzKNX3xYJNu76Ioz
	sN+jtUrSmFyvs+jD7XKro52FlYS5BqFjNLzXyMpCQ+3UwL9cTpgHvv0lDobFELdYBoa4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4kGg-000ZRv-TQ; Sun, 19 Nov 2023 17:03:30 +0100
Date: Sun, 19 Nov 2023 17:03:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 5/5] net: phy: add Rust Asix PHY driver
Message-ID: <363b810d-7d6c-48bd-879b-f97acffa70b6@lunn.ch>
References: <20231026001050.1720612-6-fujita.tomonori@gmail.com>
 <20231117093915.2515418-1-aliceryhl@google.com>
 <20231119.185736.1872000177070369059.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119.185736.1872000177070369059.fujita.tomonori@gmail.com>

> >> +            let _ = dev.init_hw();
> >> +            let _ = dev.start_aneg();
> > 
> > Just to confirm: You want to call `start_aneg` even if `init_hw` returns
> > failure? And you want to ignore both errors?
> 
> Yeah, I tried to implement the exact same behavior in the original C driver.

You probably could check the return values, and it would not make a
difference. Also, link_change_notify() is a void function, so you
cannot return the error anyway.

These low level functions basically only fail if the hardware is
`dead`. You get an -EIO or maybe -TIMEDOUT back. And there is no real
recovery. You tend to get such errors during probe and fail the
probe. Or maybe if power management is wrong and it has turned a
critical clock off. But that is unlikely in this case, we are calling
link_change_notify because the PHY has told us something changed
recently, so it probably is alive.

I would say part of not checking the return code is also that C does
not have the nice feature that Rust has of making very simple to check
the return code. That combined with it being mostly pointless for PHY
drivers.

    Andrew

