Return-Path: <netdev+bounces-113882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D36940410
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 04:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266001F21873
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14FA9450;
	Tue, 30 Jul 2024 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5Bus02t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DABA10E9
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 02:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305075; cv=none; b=BzdjGd8L/Bvw3JJYqUjsTUO+OPJ+akYger1alBo1P9jBET5c66G3DKQoiK2lHwD4PuzNeV29mhfEJo+N+Y/Y3tTwoNuSEqZ5jSgeGkoFCV8B/3RXkWDjgq1fQvybYeg9YF0D7s08NtMYLoQtRKwzK/YbSa1WkfOxOi3zaWo9j08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305075; c=relaxed/simple;
	bh=X9kNr9GNZUj4JqOuiUzBhyyb8fTQwT3fV7SI34y4JSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG6IZsb87IIqEFG5CGEGaR/SBOzJhg6j49DzgXLTD8/RUPDvhlzvQVNVryIwQCg3y2I29ak6YicBpqTnH3hv4dVRwuPHQHdTgW/+PieZzZnHHFM6uaBNPw3a1Lq4sUPdb6J/aoH1iYJQh4Jr+Ad3ahvInYEOs05qwZRX61ZZiqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5Bus02t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91AC32786;
	Tue, 30 Jul 2024 02:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305075;
	bh=X9kNr9GNZUj4JqOuiUzBhyyb8fTQwT3fV7SI34y4JSA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5Bus02tiCXZa7j1RDkMxPD7FqIXlQCislkU4Xra/fIfuWqOlYbT2gQ6RrYZ03mOD
	 uJ8qkPu6Ac+8FJI57hM/NJJ3MHNnutxYozKhpQYCYq7xH9EgzrcBJLItBitpWicZFL
	 Up/BWfhSQ6C7+o7ZJxplM5dInZANWTccmhpt6cY0je9Cm3vbTli6EptLceoFfVenbI
	 r1iiyqYLa7VoSLBWl1qomedGbdQ15RgISlrFidm1gYBPyR2zfIElfb0je4GOaUofnB
	 fUVirfIdHXDnNrICc7s5QFlkSgdWqBzGt6/s/k8prwR39U5BwRWB9Vtfy6NWqGqGEE
	 a/W/QeBUpUQDQ==
Date: Mon, 29 Jul 2024 19:04:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?67Cx6rSR66Gd?= <zester926@gmail.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, ahmed.zaki@intel.com,
 ecree@solarflare.com
Subject: Re: [PATCH net] ethtool: fix argument check in do_srxfh function to
 prevent segmentation fault
Message-ID: <20240729190433.06e1bb9f@kernel.org>
In-Reply-To: <CAHcxVNNRRCMtT0AyNk4OTcqBn6wWTk37SJw9eWChKhxGRCjUCQ@mail.gmail.com>
References: <CAHcxVNNRRCMtT0AyNk4OTcqBn6wWTk37SJw9eWChKhxGRCjUCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jul 2024 22:39:46 +0900 =EB=B0=B1=EA=B4=91=EB=A1=9D wrote:
> Subject: [PATCH net] ethtool: fix argument check in do_srxfh function to =
 prevent segmentation fault

Patch makes sense, but two nit picks:

 1) please repost with subject:

    [PATCH ethtool v2] ethtool: fix argument check in do_srxfh function to =
prevent segmentation fault

   this is a user space CLI patch, not a kernel patch hence ethtool not
   net in the brackets.

> Ensure that do_srxfh function in ethtool.c checks for the presence of
> additional arguments when context or xfrm parameter is provided before
> performing strcmp. This prevents segmentation faults caused by missing
> arguments.
>=20
> Without this patch, running 'ethtool -X DEVNAME [ context | xfrm ]' witho=
ut
> additional arguments results in a segmentation fault due to an invalid
> strcmp operation.
>=20
> Fixes: f5d55b967e0c ("ethtool: add support for extra RSS contexts and
> RSS steering filters")

 2) Please prevent line wrapping of Fixes tags

