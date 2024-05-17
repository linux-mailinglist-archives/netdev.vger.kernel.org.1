Return-Path: <netdev+bounces-96972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3A8C87BA
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774B8284B5A
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 14:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2D55787B;
	Fri, 17 May 2024 14:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OOfFO3mK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D91E507;
	Fri, 17 May 2024 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954834; cv=none; b=fFU1ahdWAr2uezDXGNkQxRyYluiiIGldZsEC3DLhIfC7AF7P3JvWGT21/StiRyk/6XaMGLATW9okL6H0XXPiK1OEiFDSqQTDHv9qKRs3L1kE9pNvfgBtJzZueeLvKNw69YNlKLc3hy2e4UGECNz4xzTSuoy/04sfvZ2VAOv7jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954834; c=relaxed/simple;
	bh=58zpZNrKH2bAbX6lE62TvJuqFc/Sa70l+BacQmg0IuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwbJAmXjLEbmvSRQcO3P9POhwuw2E7AnI1OwfQC3jHSx68OxZ26oFsedAj/gPuem3gzYPcscgBR1vXAe6NGFRwLHUcsJfeedLy13ZtOGzF2i9gXuhWl2huAwRZ1OfcYgXOXbPujUgjrXaNTtAZLo8wC+Wegn5gN4zuyncCys1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OOfFO3mK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KlplUe8Ht1enlQJkqiZ1Vrv1E6x10yAgj42W7lSPNo0=; b=OOfFO3mKJHphCnd2wpvhhgeC3a
	tf33ucAw550xP77EhoxjPIV+u5LmiBv8Fhs2OZMIW5zkfSPlvYuvNrFBF0uR3Tc7a4Ek0Ux9SCUdG
	/n9zjJcQXSSguYSperSvp+M7avM7A+45fI5Qyy/HbAhsWbtooRwbkedzuRpEYdKFGVYE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s7yEm-00FZwy-BQ; Fri, 17 May 2024 16:07:08 +0200
Date: Fri, 17 May 2024 16:07:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Leon M. Busch-George" <leon@georgemail.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] net: add option to ignore 'local-mac-address'
 property
Message-ID: <7471f037-f396-4924-8c8d-e704507de361@lunn.ch>
References: <20240517123909.680686-1-leon@georgemail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517123909.680686-1-leon@georgemail.de>

On Fri, May 17, 2024 at 02:39:07PM +0200, Leon M. Busch-George wrote:
> From: "Leon M. Busch-George" <leon@georgemail.eu>
> 
> Here is the definition of a mac that looks like its address would be
> loaded from nvmem:
> 
>   mac@0 {
>     compatible = "mediatek,eth-mac";
>     reg = <0>;
>     phy-mode = "2500base-x";
>     phy-handle = <&rtl8221b_phy>;
> 
>     nvmem-cell-names = "mac-address";
>     nvmem-cells = <&macaddr_bdinfo_de00 1>; /* this is ignored */
>   };
> 
> Because the boot program inserts a 'local-mac-address', which is preferred
> over other detection methods, the definition using nvmem is ignored.
> By itself, that is only a mild annoyance when dealing with device trees.
> After all, the 'local-mac-address' property exists primarily to pass MAC
> addresses to the kernel.
> 
> But it is also possible for this address to be randomly generated (on each
> boot), which turns an annoyance into a hindrance. In such a case, it is no
> longer possible to set the correct address from the device tree. This
> behaviour has been observed on two types of MT7981B devices from different
> vendors (Cudy M3000, Yuncore AX835).
> 
> Restore the ability to set addresses through the device tree by adding an
> option to ignore the 'local-mac-address' property.

I'm not convinced you are fixing the right thing here.

To me, this is the bootloader which is broken. You should be fixing
the bootloader.

One concession might be, does the bootloader correctly generate a
random MAC address? i.e. does it have the locally administered bit
set? If that bit is set, and there are other sources of a MAC address,
then it seems worth while checking them to see if there is a better
MAC address available, which as global scope.

    Andrew

