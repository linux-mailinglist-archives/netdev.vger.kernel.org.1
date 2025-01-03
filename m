Return-Path: <netdev+bounces-155015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81630A00A94
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DFF18842BE
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165191E0087;
	Fri,  3 Jan 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qc77pxJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55ED17BA3
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735914871; cv=none; b=RtdxxKFcVftBYlFoe6o7v7zOESx4JqEuWG/L8aoPAcRHV2YU0AtD0G8Tlz4qcxrGcvo2WkL5pGpBPKFl/muvImGlVP/426a4vezJdZTPHatrcYyyn+PW+sWbQKh4MdnlveBhxhyxSMEoF1tm1qzp/4ssEJabumsSOoWQVU33HMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735914871; c=relaxed/simple;
	bh=anQ+oc/BKz46CiB4lbkqC9SLYoCVPmMAJMtc4h1MNp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JX3SeYoqF12T5GAGqB9tfeNJGswT7xFYEym7D2nvvzLQ5F6VzzRg8CGRVtlaQjfXVi3U91fkdClh37S+53KkulJAd83H0XKBxMk7P+R2N5NvRiKmPX7H3IVQgX+eyda7162C+Xstp+0ZayuKDUat7KBPJrMuv0MEDqwXPmzp86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qc77pxJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E481C4CECE;
	Fri,  3 Jan 2025 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735914870;
	bh=anQ+oc/BKz46CiB4lbkqC9SLYoCVPmMAJMtc4h1MNp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qc77pxJ8UKBgIoidnOcRimExzGJTxrjqf1josnBMP4GK0bML7tunujTwbnmNtAqkR
	 p1DgWEFlfrNIq1WvD6VaWTH+SXTHAWEHEalpGl/gLO2mqmLvZGMiPmkLyxBiX8RLCC
	 wcm7uUsY+tiXdTe2mqALcl0NK9IS9JH2kduLM3J6Dfv9k8lSzl1ckYEtbVdSKID6VM
	 ynz9gGPcX7YcFoQYIs8CUZ7KG9c4s8XbuSTu+UpfgnypnmIVBKKWF325MfH6oNjUo1
	 JsbboHStfl9Vy9dj9fZXwYfl8FsL5SomTuc8K5Q3bY8HwA0MpN+8Q3GlOAfZZZbuVh
	 MOE0TCWMYDwXA==
Date: Fri, 3 Jan 2025 15:34:26 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Francesco Valla <francesco@valla.it>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	Anand Moon <linux.amoon@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] net: phy: don't issue a module request if a driver is
 available
Message-ID: <Z3f1coRBcuKd1Eao@ryzen>
References: <20250101235122.704012-1-francesco@valla.it>
 <Z3ZzJ3aUN5zrtqcx@shell.armlinux.org.uk>
 <7103704.9J7NaK4W3v@fedora.fritz.box>
 <d5bbf98e-7dff-436e-9759-0d809072202f@lunn.ch>
 <Z3fJQEVV4ACpvP3L@ryzen>
 <Z3fTS5hOGawu18aH@shell.armlinux.org.uk>
 <Z3fc2jiJJDzbCHLu@ryzen>
 <cff14918-0143-4309-9317-675c18ad3a8f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cff14918-0143-4309-9317-675c18ad3a8f@lunn.ch>

On Fri, Jan 03, 2025 at 03:12:14PM +0100, Andrew Lunn wrote:
> > FWIW, the patch in $subject does make the splat go away for me.
> > (I have the PHY driver built as built-in).
> > 
> > The patch in $subject does "Add a list of registered drivers and check
> > if one is already available before resorting to call request_module();
> > in this way, if the PHY driver is already there, the MDIO bus can perform
> > the async probe."
> 
> Lets take a step backwards.
> 
> How in general should module loading work with async probe? Lets
> understand that first.
> 
> Then we can think about what is special about PHYs, and how we can fit
> into the existing framework.

I agree that it might be a good idea, if possible, for request_module()
itself to see if the requested module is already registered, and then do
nothing.

Adding Luis (modules maintainer) to CC.

Luis, phylib calls request_module() unconditionally, regardless if there
is a driver registered already (phy driver built as built-in).

This causes the splat described here to be printed:
https://lore.kernel.org/netdev/7103704.9J7NaK4W3v@fedora.fritz.box/T/#u

But as far as I can tell, this is a false positive, since the call cannot
possibly load any module (since the driver is built as built-in and not
as a module).


Kind regards,
Niklas

