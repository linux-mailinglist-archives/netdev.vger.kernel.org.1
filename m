Return-Path: <netdev+bounces-76356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E59486D5F6
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 22:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35E41F22B48
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C5314A4D4;
	Thu, 29 Feb 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk3iQqIV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679C0145668
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241034; cv=none; b=ROxpBM2pjrSb2xYO2lJdP8yVF+S99qXJeTH7GkA5HbMAyW5m1lbCxvIo0iqjJ86Mku/rO+bnUNuFLBHJx3npsNT/VJ7I4LnxPUHYzybWBIEp6OtGrjb9/uAug9E1xOMML6/ccgrdQcu1rSu7aoQIoMMh+RCsOuupxdFxSgiNNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241034; c=relaxed/simple;
	bh=Q7uaQSQ6mdoJpIwmYe9uJ8CsJA1D0tYqKIkkulp30Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzWhk1oWryPhcJWaP1grwZ+uNq39MQwZq0Tv3URscSlyfziBD/QvtAdLF/8pKlJ32uTM9O5/5Rti5qdSTTZoR/hezLB6Yux20D9HqJAig1CG63bIsX9w593FgqzK8j/eDW1DMQejPFvxkGvsj/xjmeiU+XD48kNJpYo6oOWlbSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3iQqIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D75FC433C7;
	Thu, 29 Feb 2024 21:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709241033;
	bh=Q7uaQSQ6mdoJpIwmYe9uJ8CsJA1D0tYqKIkkulp30Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dk3iQqIVLSdt24BsTO981Uwi9SXEiA1LpgdWzd/G7W95IbUNks7mhIXQHAvqSNvYK
	 SHxJHw3jmoSpRy7aDY785kW1kw36rSp1fSZcGQandFdSYHq9yxCDP1a1uqi5bOZ1+K
	 tZ4rhfne6/OPsBUUdt/KdpBwb+OnB9nMp9L/mNXn++yC5KHfEO25EjuF2OOi4U1whq
	 dBFK+X6jjT0FtHzlDvA9J8d3OPstl7eHUV8PW3LSpiDVKBPJYOb1PUTErc98oBCEIH
	 kGp8WPV+2YUKe6w/EbFXsaNpwt/0GWi9DQRTKx84ZHkLqMRplk7SwU/XditWpv4CPZ
	 /rNsNyu8Fqs2w==
Date: Thu, 29 Feb 2024 13:10:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Tasmiya
 Nalatwad <tasmiya@linux.vnet.ibm.com>, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us
Subject: Re: [PATCH net] dpll: fix build failure due to
 rcu_dereference_check() on unknown type
Message-ID: <20240229131032.208d0d17@kernel.org>
In-Reply-To: <20240229190515.2740221-1-kuba@kernel.org>
References: <20240229190515.2740221-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Feb 2024 11:05:15 -0800 Jakub Kicinski wrote:
> From: Eric Dumazet <edumazet@google.com>
>=20
> Tasmiya reports that their compiler complains that we deref
> a pointer to unknown type with rcu_dereference_rtnl():
>=20
> include/linux/rcupdate.h:439:9: error: dereferencing pointer to incomplet=
e type =E2=80=98struct dpll_pin=E2=80=99
>=20
> Unclear what compiler it is, at the moment, and we can't report
> but since DPLL can't be a module - move the code from the header
> into the source file.

Applied, and pushed for the PR..

