Return-Path: <netdev+bounces-72176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8529856D34
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1781C2387A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E461386C5;
	Thu, 15 Feb 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMANnlTF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F34F3D6D;
	Thu, 15 Feb 2024 18:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023529; cv=none; b=n1ZCfgD5JQuX0a+P60XUuY8uzsjuCkSI6rKVt1hQ5VYrQX4rLl2BEk5o9w+CbRQVJkMLzuGv1wgqH3fznepSlTGG/fdKegaYZvWjrSHGA74GYhpJv286YMYaZrTfZoKMLIVhGYlHhAspyiHIpqLhDbFJMVdkakUJTO9HaI02mh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023529; c=relaxed/simple;
	bh=hMviSDR7IR+GwWkZCHnOzDa9PpoRzyHBelNBMVSD3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F0wkBC+puKrsYf2kzVzQPW5u7DrX9SsJJSY88dgDzRbJgdtjthHNwHS+2FHFXftGy5c/r6y63i7p7oSFMBajuScBSM/aiBLnfnvTquSRmF3ZOtZdhsrS0AAqsCLpn3gduCDcvNkWyqT7QzRnNmIc7MV4Rc072WMhL5CTfoR00JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMANnlTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E038DC433C7;
	Thu, 15 Feb 2024 18:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708023528;
	bh=hMviSDR7IR+GwWkZCHnOzDa9PpoRzyHBelNBMVSD3GE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gMANnlTFcL5eM9hIehGB9iWbnA1rJKQPb+9d96/PIXlWWoV6wF4rmRpq0orkAN2Xr
	 wZjpnbehEbi8PkSdguJBOlvaI1N+vkUtYCMxi9EELVmX6MQpyVPC9IKs8loS/i72B0
	 xIagK6XErn2h0FDOyEVgts7zHDQeEY5i8ZMyKDh8eH+vWO7ROgU4zd4LTnCZ0HatOp
	 tNxPhAeesMa+KhkZb1q2l8Xl2YLXxeSzcy8VZd/wfKgGM18gPhUwDJRdHA1T73LbGU
	 Y4zWCpsQ4Lf80Bo7COn+NllJxbI1B//IDnGGZJgjamum1n60BijBeujtS9ZHsnrEIT
	 kpZO2fztcNrSg==
Date: Thu, 15 Feb 2024 10:58:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20240215105846.6dd48886@kernel.org>
In-Reply-To: <20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 17:02:46 +0100 Kory Maincent wrote:
> Introduce an enumeration to define PSE types (C33 or PoDL),
> utilizing a bitfield for potential future support of both types.
> Include 'pse_get_types' helper for external access to PSE type info.

I haven't read the series, just noticed this breaks the build:

error: ../include/uapi/linux/pse.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier

but why the separate header? Is it going to be used in other parts of
uAPI than just in ethtool?

> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>

side-note: no objections to the line but for accounting purposes
(i.e. when we generate development stats) we use the Author / From
line exclusively. So it'd be easier to compute stats of things funded
by Dent if you used:

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

but that's entirely up to you :)

