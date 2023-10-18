Return-Path: <netdev+bounces-42391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1237CE8CA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 22:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69CA6B213A6
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44679CA5E;
	Wed, 18 Oct 2023 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qZGE9oGR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C5141239;
	Wed, 18 Oct 2023 20:28:06 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2EC181;
	Wed, 18 Oct 2023 13:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VQrRoW7ZlmvVE170KvxfRR5Cepjeim2B8tpAKqrXoX8=; b=qZGE9oGR42Ra+oyT6hxWIJGghN
	k0Z4ynEr+8oOBlBVnJSZwW4uf2cZJ6ECj3tL5qChRN6QtDEs9a3k2c56rowlOP7GqMGJraFnUi3aC
	feRrwqmCEl1wNoc0Vrl/fB4YK2CIEN3ddtNY8oCdXdPEfytKSm3kr2+rrcMdkx1/6kwc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qtD91-002cX7-Ih; Wed, 18 Oct 2023 22:27:55 +0200
Date: Wed, 18 Oct 2023 22:27:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu,
	boqun.feng@gmail.com, wedsonaf@gmail.com, benno.lossin@proton.me,
	greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <de9d1b30-ab19-44f9-99a3-073c6d2b36e1@lunn.ch>
References: <20231017113014.3492773-1-fujita.tomonori@gmail.com>
 <20231017113014.3492773-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017113014.3492773-2-fujita.tomonori@gmail.com>

> +    /// Reads a given C22 PHY register.
> +    pub fn read(&mut self, regnum: u16) -> Result<u16> {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        let ret = unsafe {
> +            bindings::mdiobus_read((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into())

If i've understood the discussion about &mut, it is not needed here,
and for write. Performing a read/write does not change anything in
phydev. There was mention of statistics, but they are in the mii_bus
structure, which is pointed to by this structure, but is not part of
this structure.

> +        };
> +        if ret < 0 {
> +            Err(Error::from_errno(ret))
> +        } else {
> +            Ok(ret as u16)
> +        }
> +    }
> +
> +    /// Writes a given C22 PHY register.
> +    pub fn write(&mut self, regnum: u16, val: u16) -> Result {
> +        let phydev = self.0.get();
> +        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
> +        // So an FFI call with a valid pointer.
> +        to_result(unsafe {
> +            bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, regnum.into(), val)
> +        })
> +    }
> +
> +    /// Reads a paged register.
> +    pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {

From my reading of the code, read_paged also does not modify phydev.

     Andrew

