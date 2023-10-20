Return-Path: <netdev+bounces-43101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7507B7D16B2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D8A1C20FBB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB274225B1;
	Fri, 20 Oct 2023 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t9CEwxCg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38B1DDC9;
	Fri, 20 Oct 2023 19:59:07 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A6D70;
	Fri, 20 Oct 2023 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=e11CzQk0LU1vWCLNBl1IXYbmMnAwJUC+7PsHlalWQkY=; b=t9CEwxCgPcde9IqLVFLQhFRsHb
	xaolJ9Z2MnQf9vMaSQepE9PKTYp/5YYQkHepMGNhk6X+BIAx7bU12pKh1OCN8VpoBjE+uswd1s7sJ
	QX819igOkns3JNzO6N5gYL3iCB25wRbPoVcDZK/fztVxQJVQhg8ALl4EhmdRMywA7MJk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qtveA-002oYC-Uv; Fri, 20 Oct 2023 21:59:02 +0200
Date: Fri, 20 Oct 2023 21:59:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	tmgross@umich.edu, boqun.feng@gmail.com, wedsonaf@gmail.com,
	benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <e5109b0f-5fd5-4ae7-91e2-3975e3371ebb@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
 <87sf65gpi0.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf65gpi0.fsf@metaspace.dk>

On Fri, Oct 20, 2023 at 07:26:50PM +0200, Andreas Hindborg (Samsung) wrote:
> 
> Hi,
> 
> FUJITA Tomonori <fujita.tomonori@gmail.com> writes:
> 
> <cut>
> 
> > +
> > +    /// Returns true if the link is up.
> > +    pub fn get_link(&self) -> bool {
> > +        const LINK_IS_UP: u32 = 1;
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        let phydev = unsafe { *self.0.get() };
> > +        phydev.link() == LINK_IS_UP
> > +    }
> 
> I would prefer `is_link_up` or `link_is_up`.

Hi Andreas

Have you read the comment on the previous versions of this patch. It
seems like everybody wants a different name for this, and we are going
round and round and round. Please could you spend the time to read all
the previous comments and then see if you still want this name, and
explain why. Otherwise i doubt we are going to reach consensus.

> If this function is called with `u32::MAX` `(*phydev).speed` will become -1. Is that OK?

Have you ever seen a Copper Ethernet interface which can do u32:MAX
Mbps? Do you think such a thing will ever be possible?

> > +    /// Callback for notification of link change.
> > +    fn link_change_notify(_dev: &mut Device) {}
> 
> It is probably an error if these functions are called, and so BUG() would be
> appropriate? See the discussion in [1].

Do you really want to kill the machine dead, no syncing of the disk,
loose everything not yet written to the disk, maybe corrupt the disk
etc?

      Andrew

