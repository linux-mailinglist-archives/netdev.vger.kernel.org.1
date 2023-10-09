Return-Path: <netdev+bounces-39080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F4D7BDD05
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3092815D3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 13:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE827168BF;
	Mon,  9 Oct 2023 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gQhO9tdv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345223D1;
	Mon,  9 Oct 2023 13:02:36 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5FB93;
	Mon,  9 Oct 2023 06:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/5E9rk86SkBzj7gGnWXgvIfDu+9xk0bucuVGeHyZeZQ=; b=gQhO9tdvdQmNLUqqGHkEU/Chdc
	dFXjgXu0tGUdbbLWC0Wtj8yO/yBk6IuNsF0DA5T0GZJHtXU7m6FHC42DNiqHhpjyya5tqTJ9URK9i
	xHv/7niQ0QdcoRWuV1CkQqmntDO1q0e2gX4Xm5Keo2S6oS/3QZLy29Agbwh2zwCtZksA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qppu3-000scv-Pb; Mon, 09 Oct 2023 15:02:31 +0200
Date: Mon, 9 Oct 2023 15:02:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benno Lossin <benno.lossin@proton.me>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	greg@kroah.com, tmgross@umich.edu
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY
 drivers
Message-ID: <4ced711a-009c-4e57-a758-1d13d97e18d2@lunn.ch>
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-2-fujita.tomonori@gmail.com>
 <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aea7ddb-73b7-8228-161e-e2e4ff5bc98d@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 12:19:54PM +0000, Benno Lossin wrote:
> > +impl Device {
> > +    /// Creates a new [`Device`] instance from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// For the duration of the lifetime 'a, the pointer must be valid for writing and nobody else
> > +    /// may read or write to the `phy_device` object.
> > +    pub unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
> > +        unsafe { &mut *ptr.cast() }
> 
> Missing `SAFETY` comment.

Hi Benno

It is normal on Linux kernel mailing lists to trim the text to what is
just relevant to the reply. Comments don't get lost that way.

> > +    /// Returns true if the link is up.
> > +    pub fn get_link(&mut self) -> bool {
> 
> I would call this function `is_link_up`.

Please read the discussion on the previous versions of this patch. If
you still want to change the name, please give a justification.

> > +    /// Reads a given C22 PHY register.
> > +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> > +        let phydev = self.0.get();
> > +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> > +        // So an FFI call with a valid pointer.
> > +        let ret = unsafe {
> > +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())
> > +        };
> 
> Just a general question, all of these unsafe calls do not have
> additional requirements? So aside from the pointers being
> valid, there are no timing/locking/other safety requirements
> for calling the functions?

Locking has been discussed a number of times already. What do you mean
by timing?

> > +// SAFETY: `Registration` does not expose any of its state across threads.
> > +unsafe impl Send for Registration {}
> 
> Question: is it ok for two different threads to call `phy_drivers_register`
> and `phy_drivers_unregister`? If no, then `Send` must not be implemented.

The core phy_drivers_register() is thread safe. It boils down to a
driver_register() which gets hammered every kernel boot, so locking
issues would soon be found there.

> > +macro_rules! module_phy_driver {
> > +    (@replace_expr $_t:tt $sub:expr) => {$sub};
> > +
> > +    (@count_devices $($x:expr),*) => {
> > +        0usize $(+ $crate::module_phy_driver!(@replace_expr $x 1usize))*
> > +    };
> > +
> > +    (@device_table [$($dev:expr),+]) => {
> > +        #[no_mangle]
> > +        static __mod_mdio__phydev_device_table: [
> 
> Shouldn't this have a unique name? If we define two different
> phy drivers with this macro we would have a symbol collision?

I assume these are the equivalent of C static. It is not visible
outside the scope of this object file. The kernel has lots of tables
and they are mostly of very limited visibility scope, because only the
method registering/unregistering the table needs to see it.

       Andrew

