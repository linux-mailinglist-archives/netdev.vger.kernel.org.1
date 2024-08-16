Return-Path: <netdev+bounces-119032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A4953E52
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0391B216FD
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 00:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDFA20E3;
	Fri, 16 Aug 2024 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PUa8VOVQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807C46BF;
	Fri, 16 Aug 2024 00:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723768817; cv=none; b=cBu0pxoajx4HHuRF25/ooFAUdv43/NxaM5wZDOHHZzk3DBL1XWaciFAnN4z4fSLW6WUUEXmTu1NDYGiTuD/bU2vwJFPUUdwDefyD79gw/2Sv4Fr2ciTGeRmkytt1L0zM76O+fLsR/TkIccaZefM/DCQyJxizTTU5MPElgCg86+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723768817; c=relaxed/simple;
	bh=f2l9U8EQ4LM34eDavDCHTQM88Vw9bnHs9zu6W36i2lM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLVeH23TLjUBHdzZbH81yOcq9YX0/eGP+0SFoShb5/yow7Mjjzh96MgYLaVQnh9GX1u8yNGyRy0lsFgiQJ1KvvVGw4nAhpvy9Kh5Lnt7bP7WRRSjtNNePL5F3UJhwLb5HSn2fkNRBXE0Uh+j0xQvCv5u8mbDdvB59q0voEu31n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PUa8VOVQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BSuOCDs7BeRAC/bl6Z2xLvHcLue2swJaovKZ/tsESUE=; b=PUa8VOVQl/UAVEmDSIp/rY4Gsi
	EJiVOJGixE2mBeUG/XSLTAGa4zR180KbWgAq6TeeBW2CWbLeR9VflwDs2+0Z7y1/3MAGG3D+VTHl1
	/UVqRJflIcaH8QA3C6mWWipPwBKL4pFDGGesZ5IFE/kG/sDpKpjIgiiAmTBAjbK3N9H4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sel0m-004sod-8K; Fri, 16 Aug 2024 02:40:12 +0200
Date: Fri, 16 Aug 2024 02:40:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 2/6] rust: net::phy support probe callback
Message-ID: <b0a0438d-e088-44f0-8f63-f3632a4c6b90@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
 <20240804233835.223460-3-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-3-fujita.tomonori@gmail.com>

> +    /// # Safety
> +    ///
> +    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
> +    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
> +        from_result(|| {
> +            // SAFETY: This callback is called only in contexts
> +            // where we can exclusively access to `phy_device` because
> +            // it's not published yet, so the accessors on `Device` are okay
> +            // to call.

Minor English nitpick. Its is normally 'have access to'. Or you can
drop the 'to'.

Otherwise

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

