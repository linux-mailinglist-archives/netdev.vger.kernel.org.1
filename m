Return-Path: <netdev+bounces-208203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B433B0A92D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 19:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CA23BEB8D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4DD2E7193;
	Fri, 18 Jul 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gxa0+WBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091FC2E7189
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858773; cv=none; b=ZDicJIvPHknMM1QbbjD+dRFEJwLVsE699h+hghpJVuu8UftN3Pcsj5+oQNDNfc3zpjYKYiE9TTFAyKzznPmXdc6xDI1rzEDs39M2q6yY33ysva3+ngYhQRTqztKUID7Oq7M4iaX9ZOid056rCwwlEGig3wjuvhWOlzoOYeZRFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858773; c=relaxed/simple;
	bh=6ykzAuGED9ez887LK7fcihZHQiZzSyWUYYkHvEM2+34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHbGb4kiANs7hL4U6MbkOfrs30bJDTBNKuc5xhh0CW93JtI12RWAIrBqPNBL6yHgwp26J+P/2ShQIHiPQ9/ei1R3oQnfcllsKr5jWE1Rk5mrVxsAHtsAsEjbPnFWVjKQCbMHvPbz9qL8+pk0m3u0CXCAFh1vJIf7mk7fenUIf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gxa0+WBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498C0C4CEEB;
	Fri, 18 Jul 2025 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752858772;
	bh=6ykzAuGED9ez887LK7fcihZHQiZzSyWUYYkHvEM2+34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gxa0+WBnK60QELBbSqKq24UE/9/JflSsRp+648iD/+FzKC5q8xFi3AElixa3fuFn7
	 oC9fOvjaIRgdYSUely5SY2/FBTS753nxUMT3tV626o2z5YmAZQjhsKazENJnyc6jVS
	 pyhgZ4hZ4lTWzx5etpYsADLIALthb/1Jwd+fgWYkV2kZn0dd3551aK2c42LpdaHhsT
	 tYP53zJbbO0TajNop3A3AoLKJSDwDdVwb0w/DJjxA5JFHbwt991fN+7MonPJQDl8qU
	 eiHbsLAbq2eOX7CV7MmO1ww+2xk8yL2ElgVyaLntR7NwvAfaU84uZjAtXmjP12un8Y
	 orMgq8emxFC+g==
Date: Fri, 18 Jul 2025 10:12:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Anthoine Bourgeois <anthoine.bourgeois@vates.tech>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Wei Liu <wei.liu@kernel.org>, Paul Durrant
 <paul@xen.org>, xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
 Elliott Mitchell <ehem+xen@m5p.com>
Subject: Re: [PATCH v2] xen/netfront: Fix TX response spurious interrupts
Message-ID: <20250718101251.0e67772a@kernel.org>
In-Reply-To: <4f54ed1a-e265-43db-b4f2-f3c0d3b3dd00@suse.com>
References: <20250715160902.578844-2-anthoine.bourgeois@vates.tech>
	<20250717072951.3bc2122c@kernel.org>
	<4f54ed1a-e265-43db-b4f2-f3c0d3b3dd00@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 18 Jul 2025 09:19:17 +0200 J=C3=BCrgen Gro=C3=9F wrote:
> On 17.07.25 16:29, Jakub Kicinski wrote:
> > On Tue, 15 Jul 2025 16:11:29 +0000 Anthoine Bourgeois wrote: =20
> >> Fixes: b27d47950e48 ("xen/netfront: harden netfront against event chan=
nel storms") =20
> >=20
> > Not entirely sure who you expect to apply this patch, but if networking
> > then I wouldn't classify this is a fix. The "regression" happened 4
> > years ago. And this patch doesn't seem to be tuning the logic added by
> > the cited commit. I think this is an optimization, -next material, and
> > therefore there should be no Fixes tag here. You can refer to the commit
> > without the tag. =20
>=20
> I think in the end it is a fix of the initial xen-netfront.c contribution
> (commit 0d160211965b).
>=20
> I'm fine to change the Fixes: tag and apply the patch via the Xen tree.

SGTM, FWIW. But I'd like to reiterate my humble recommendation to treat
this as an optimization, and not add the Fixes tag.

