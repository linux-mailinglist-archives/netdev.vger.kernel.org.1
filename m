Return-Path: <netdev+bounces-212973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3936B22B24
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D4823B25B1
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F042ECD1E;
	Tue, 12 Aug 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8rsUzgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167F2EBDD7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755010054; cv=none; b=kWDfUVwzy3aWDEAIgW6mdNM3JV3TH9OZF/JjzQdoSwvhp1/ZoU9HsC+T4Yw80+mY7BOu7h1Yr5kDukxrsbHiOxkqt7tfrsOxqYaCkn78tshOF5q6fukOL70t8MFD2nrhnSV2vwJ/1LL9e6Gm/oYdgaH9YP6jOIR1rZkpn3tVVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755010054; c=relaxed/simple;
	bh=Q1jwx0kZzzch/7OW8PpuyjzFRcOA+vKCG40OPK4R+TE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JepzMs/GisxstisKJ/SFq/V0Bs+PlkIrgyhbE6+WwTgfO5lMQz9Dh4pMkxXjSjcXJe73GYI7amJNajSGzyDCKH+QB2WLwd4P09+sru3SHhnPUitKU3gCKVxKlzO8+B4zxyaI/6kvXA2bp7hhjj0qP/L5Gpffl3UlQjB9mqjthLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8rsUzgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A367C4CEF0;
	Tue, 12 Aug 2025 14:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755010053;
	bh=Q1jwx0kZzzch/7OW8PpuyjzFRcOA+vKCG40OPK4R+TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g8rsUzgs8lu8oGrriZrvANCd5EWlaQNhPMjJk9puKNEwFpip1woUdsA08cQdlrXjP
	 /8J/I1mYHKBLIumH42O/IAJAOfd5/86J8IoI68t38dcmWZaBn3JBsTXbR1c3MknSeW
	 RB8R8UREh7MUHf++CSL6noBcS24pYklQqQvzhRId0DMAA+GQ+OK1HV5UUfWXG3oit7
	 VxzZNka9pfn1086/gs5G67qOP3ZyG/1eydgci1OJInnIVzlkBbfw8LTHD1qrEA/7NA
	 b8nw/x48MthZmq06+kPE9fYHa/8F5U2vygU3HGpJGHQ/nn7aL9MPsIi7WFfgcXip6S
	 k1cS4fHnqHb6g==
Date: Tue, 12 Aug 2025 07:47:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 2/2] devlink/port: Simplify return checks
Message-ID: <20250812074732.1f76ade4@kernel.org>
In-Reply-To: <CY8PR12MB7195C1ACF298C258BB37E759DC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250812035106.134529-1-parav@nvidia.com>
	<20250812035106.134529-3-parav@nvidia.com>
	<a3f91ab5-d9da-4ef8-aecc-8d1264b8bf6a@linux.dev>
	<CY8PR12MB7195C1ACF298C258BB37E759DC2BA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:45:09 +0000 Parav Pandit wrote:
> The general guidance was to not do multiple different types of changes in single patch.
> No strong preference to me.

It would probably make more sense if the order of the patches was
inverted.

