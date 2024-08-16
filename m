Return-Path: <netdev+bounces-119226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CC2954D92
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07C9281961
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F8B1BC9E6;
	Fri, 16 Aug 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m097T4pp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0B1E4AF
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821596; cv=none; b=D8JVRPpdTI3zKQ2KMFnDOMngUMoTPULksXk2dIOq8x6m6kx/+aX3E8xtT+UGIltTmyo/rw8BRG/7DdCMAyD1+Vp5ryVZxSmOTUOLH6cf8heU7ZPCeVMANmLDjJQqgbTPwufClr0cXYuzwItU6KZH3KNXsPiz8XbGeTyLYcqrID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821596; c=relaxed/simple;
	bh=tJm4t9tHmU6Rq43pkVX9Iu3p00xuv+5ciF1vsLYVEe4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsoiJ/Lcy5BuMlHziVIMZS4XDSLKs9bAUDuBtKYtcqZ6W9sU1eOpU0e7XAGVYotp5FQgpoKhjQCVhhC0gJz0LVY5zBho/o7Ba8Sw0+edOarx3knqJcIK2wY+GgepTr4+Vy7khZQaX4JYAidJGQfIsHip58/Jkh5JbKfCoxFfXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m097T4pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB09C32782;
	Fri, 16 Aug 2024 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723821596;
	bh=tJm4t9tHmU6Rq43pkVX9Iu3p00xuv+5ciF1vsLYVEe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m097T4ppFuuKJahdqKkxRQGPMWP5dD3Vv1w69UTXEOPDz8ozFwlgHSwdNSLxvNgH1
	 +dcU2TQseP2jCoT9PGN6zZMufTMSQpkr0mKamB09UxhVEXPM8Y2w0lh8UJ7nbfbkKS
	 62mhYTftc+uC8k2nYdQXnMysETqLMI77UT+kWNtmQV3BsktwOJY4r4dsAM8U2VJmZ6
	 OP5H2lCDdTO5NH4N+p2YIvfepaxE9xyjyX6zrTNbRaGqBS1SA9JLf2ObJXA0GOzedG
	 zR9xNoFsH0yiAzI6ACS7ziAbd9u15mNBEh9xbGqHPy/H//ZZ9VnceYFjfiiTu5MN4Q
	 t8mXJp4W/OZCw==
Date: Fri, 16 Aug 2024 08:19:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
Message-ID: <20240816081955.671aca4f@kernel.org>
In-Reply-To: <BE3FAE32-CA6E-4F00-996A-738B9AF07E8C@net-swift.com>
References: <E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com>
	<f7fdecaf-c3c4-4770-9e03-d1f15fd093fa@redhat.com>
	<BE3FAE32-CA6E-4F00-996A-738B9AF07E8C@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Aug 2024 14:11:27 +0800 mengyuanlou@net-swift.com wrote:
> > Does not apply cleanly to net since:
> >=20
> > commit bc2426d74aa35cd8ec9c97a253ef57c2c5cd730c
> > Author: Jiawen Wu <jiawenwu@trustnetic.com>
> > Date:   Wed Jan 3 10:08:49 2024 +0800
> >=20
> >    net: ngbe: convert phylib to phylink
> >=20
> > Please rebase =20
>=20
> I Know there has something changed in this commit.
>=20
> If I want to send this patch to fix the code between this two commits.
> > commit: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.") =20
>=20
> > commit: bc2426d74aa3 (=E2=80=9Cnet: ngbe: convert phylib to phylink") =
=20
>=20
> Should I add the stable tag flag like 6.6 or do something else.

If I understand the question correctly the answer is: don't worry about
stable right now.

Add the CC: stable@.. tag, and fix the code as it is in net/main.
Once the commit reaches Linus you will get a notification from=20
the stable team that the patch has reached them and either does=20
or does not apply. At which point you can provide them with a patch
adjusted to what's needed in LTS kernels.

