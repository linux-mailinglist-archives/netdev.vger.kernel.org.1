Return-Path: <netdev+bounces-180965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C36CA834B5
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C248A6E7D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1668121C18A;
	Wed,  9 Apr 2025 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE+Bf7wQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F602135AD
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 23:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744242139; cv=none; b=rGD+LqcVibsuH0tP8Zp1kqlY/OOcClr+6bNVBB6bNyYBlDET+7Byd3veNLC1Yezv/kpr8QjEgFG3aUIK6AqTCOQt0tPUOTj4Gs08eY/71+blXuw9iglRjLgyEVrgs6xemwry8TZS5iaoktjVU4jzOz9Bpk8YMWs7JEf2zS+aqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744242139; c=relaxed/simple;
	bh=CuEpPCT3gLiuL5wj81IJtcGBfMjUau9OfM/ROa8u7gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mVfTSHJbuR8opXmpteOyLhrqzb5y6dkduCetaYCWxOW8YK1oH/9KcEW5mEP2yasr/TN5XXu43dMqHAXeBqamcj+cs/ICOnT6VFNI2+nr2+tOe6DkuhNwkTsEPfNcdjLbUWRyTNRDoYgEDWn3RtSv/R+u5qez9Jw6dhy3VmbwFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE+Bf7wQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0736C4CEE2;
	Wed,  9 Apr 2025 23:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744242135;
	bh=CuEpPCT3gLiuL5wj81IJtcGBfMjUau9OfM/ROa8u7gY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cE+Bf7wQzA100fhzT6VAI0SHgh08TkLSmdAkjxhn/inQqZzq5494QiiQaV0OGfV2s
	 mCsUdEZfdi8jiYgO+VYXTOD/hPVyri/OJtP87TCzZTbCiX6VRsksEH5fEPulbjEVqm
	 iqA0zOuFtjX1MTTyaF+KB8/cbSGY3AWaCjYcd8EnCpdkIQuLbGRKlj8wuVJ4PQJtmU
	 IbpEv3zBx1psWgl4f1zOSVGYAYSRjpD18M4LerIutUGtyOr45n16gmKXgTi0boYvpr
	 pjdcM4cg0+Moq9eqLFmKT2WSDRHdY6Gr+6Dr9IfFNTl1VbBvccdCfRg4euSoi8OyhW
	 0kKLJVrCSeU9w==
Date: Wed, 9 Apr 2025 16:42:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 horms@kernel.org, danieller@nvidia.com, petrm@nvidia.com, andrew@lunn.ch,
 michael.chan@broadcom.com, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net] ethtool: cmis_cdb: Fix incorrect read / write
 length extension
Message-ID: <20250409164214.6a19e340@kernel.org>
In-Reply-To: <CAKSYD4y5cTMdRmo97naYX=xE4k3jLBOBzptmyXi-YEimK4VmPw@mail.gmail.com>
References: <20250409112440.365672-1-idosch@nvidia.com>
	<CAKSYD4y5cTMdRmo97naYX=xE4k3jLBOBzptmyXi-YEimK4VmPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 11:02:47 -0700 Damodharam Ammepalli wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Please fix your email setup.
-- 
pv-bot: trailer

