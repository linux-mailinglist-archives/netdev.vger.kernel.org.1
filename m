Return-Path: <netdev+bounces-185710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 911F5A9B80B
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 21:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8200188621D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE8528F50A;
	Thu, 24 Apr 2025 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XMs9inTw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF828A1D5;
	Thu, 24 Apr 2025 19:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521850; cv=none; b=LIzwhEHof2iz/wzQIds+q5v89T/Kdf++BqQDUSas+CGsEDURYxVdBOTSeUY4nLOv0X/OUuVJxrVnV782OyYgUwoQ2HY5odEF8URUGWO/uG59PSOor9yta54Uoe1f5kTZbwkni0dt+4NHfwlg/J93Ydta3pgMn2vdmxh2UzAvTUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521850; c=relaxed/simple;
	bh=zjZGmkNGmVx6n9NCm1AAvtiC+dGjo2oHGosb2SRKtNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlz0cbLoKMFq95e+LnBxPE/hPzMWMUB7qe3yUlh5K9mmrY5Eiq3gNVd548ZCuXoiTsGncxCB0V+zkXyELniVn7USRSy1l7wZ2m6n/X+VL+I0d0EvEz0sfLXHkIa/5Rw33VvalzvgyRNOPytBQjw5XheD9DDT9eJo3bqPA9ghUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XMs9inTw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1HEngV8H+adMANThMLFm2yWWuH7aQ7Ckddb5hLkgTK0=; b=XMs9inTwIvMKgKHxsnRWAA2AEt
	uuzi+3OYLiyqGinITG1iTeR/8B3hSm2mL8/ULsqC3nIZoQBL6jRFgVil3axcaVrleyHl3nQ3BwX8i
	kEzYIOLCtsodCwpVrSJZnTiruOzJ9CjQqS9OHd2S7mVVBU2MQ10eqiLzN5jWD8azgekk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u81xq-00AVDl-BL; Thu, 24 Apr 2025 21:10:26 +0200
Date: Thu, 24 Apr 2025 21:10:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with
 register mailboxes
Message-ID: <d36c34f8-f67a-40ac-a317-3b4e717724ce@lunn.ch>
References: <20250424154722.534284-1-ivecera@redhat.com>
 <20250424154722.534284-6-ivecera@redhat.com>
 <5094e051-5504-48a5-b411-ed1a0d949eeb@lunn.ch>
 <bd645425-b9cb-454d-8971-646501704697@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd645425-b9cb-454d-8971-646501704697@redhat.com>

> Each sequence has to be protected by some lock and this lock needs to be
> placed in MFD. Yes the routines for MB access can be for example in DPLL
> driver but still the locks have to be inside MFD. So they have to be
> exposed to sub-devices.

The point of using MFD was gpio? Does the gpio driver need access to
the mailboxes? Does any other sub driver other than DPLL need to
access mailboxes?

The mutex needs to be shared, but that could be in the common data
structure.

	Andrew


