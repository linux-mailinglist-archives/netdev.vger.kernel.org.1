Return-Path: <netdev+bounces-122919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B049631CD
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7E01C21346
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9131ABEC5;
	Wed, 28 Aug 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TH9NCiOZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DE1A38E0
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 20:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877050; cv=none; b=lN4FtHf9EflmAiM2hIXRaO60dX5eUNir1qvwuumyD7vdsFFii/pbQCCUp0Svs79W/Iv1b0P0J/bYwZLufTZLKHfL8qiCDANEOkF2GXQ8FMEvNZep7zbrtHIiK/Dax7klXaUW+CxyGwjS2h1KIZ/LyOVPRt64YlzpI2NjgIFrp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877050; c=relaxed/simple;
	bh=NcCH55ExngTBLNsf0KzMUjxVkqb0h/ouLVWnSI1nMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lL3LxYLA0AWbs9HuTrZgAWKyMRWed9Pl9hYp4r1XmEpKCgV9zE8nxk1hePVBJR5GOmgvAh9+69jwtNFuV8keMaUIQ6/4VTX/qmYRIrbXRl7VhBeyl4GUBT9PZTp03JnKeCtZPn8eqgtcaR6w205EW318fnKGh+38ohTdDBfLtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TH9NCiOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DBEC4CEC0;
	Wed, 28 Aug 2024 20:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724877049;
	bh=NcCH55ExngTBLNsf0KzMUjxVkqb0h/ouLVWnSI1nMnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TH9NCiOZ1k0nbyEwPgPSMrJhtwIe9fld1QQnELbZYi0oXM23vsMPqdQLMs0kNTGlq
	 QCICC/cA3GHvtnRc25OxGpz9pl27OPebv+ocltjI6+dQE357uoyGeIpVZz21j3M9DS
	 w5OeeejZBVvLshFq6eBcjgZ3VKt5KVpCEL65XLMsHdsB8gWa1vMA8s4u8W+mqrtyt1
	 ei7raJcG5gER4EnjmEeTBkYIDy2brK2xj5NYKBbqX45LmM8iKLSpuQsUJE0u5VjY1p
	 9GEXq/gjAu+Nu/5ixFbAb/cXDcsy33bv6U5o8iKl/Q8QDv/D+X2FRIr0AlNu2EWDGy
	 kdTUcGEMxK93A==
Date: Wed, 28 Aug 2024 13:30:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240828133048.35768be6@kernel.org>
In-Reply-To: <061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
References: <Zsh3ecwUICabLyHV@nanopsycho.orion>
	<c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
	<ZsiQSfTNr5G0MA58@nanopsycho.orion>
	<a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
	<ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
	<432f8531-cf4a-480c-84f7-61954c480e46@redhat.com>
	<20240827075406.34050de2@kernel.org>
	<CAF6piCL1CyLLVSG_jM2_EWH2ESGbNX4hHv35PjQvQh5cB19BnA@mail.gmail.com>
	<20240827140351.4e0c5445@kernel.org>
	<CAF6piC+O==5JgenRHSAGGAN0BQ-PsQyRtsObyk2xcfvhi9qEGA@mail.gmail.com>
	<Zs7GTlTWDPYWts64@nanopsycho.orion>
	<061cba21-ad88-4a1e-ab37-14d42ea1adc3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Aug 2024 12:55:31 +0200 Paolo Abeni wrote:
> - Update the NL definition to nest the =E2=80=98ifindex=E2=80=99 attribut=
e under the=20
> =E2=80=98binding=E2=80=99 one. No mention/reference to devlink yet, so mo=
st of the=20
> documentation will be unchanged.

Sorry but I think that's a bad idea. Nesting attributes in netlink
with no semantic implications, just to "organize" attributes which
are somehow related just complicates the code and wastes space.
Netlink is not JSON.

Especially in this case, where we would do it for future uAPI extension
which I really hope we won't need, since (1) devlink already has one,
(2) the point of this API is to reduce the uAPI surface, not extend it,
(3) user requirements for devlink and netdev config are different.

