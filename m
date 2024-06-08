Return-Path: <netdev+bounces-102020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA6090119B
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 15:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7C1C210B1
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F9D17921D;
	Sat,  8 Jun 2024 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBmHCc+G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3479178384
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851591; cv=none; b=Sl/+dHw86AAAEhh5R6r6IPMmKh9XeHnmNOxyDL00egUv4nXtNgMBiUI0/1/GcZsbT91CF4H6/q6+nAtgkhWA8YNH0IEDON3weA1SKwcZtHtp4N6h+Z+PLniuZWX2AuqsQ7Qe2IsLnxWWkV07fJKQhqJEwRcwDbm1ESL9Udj9Bio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851591; c=relaxed/simple;
	bh=Kz4eb2k8dxXqorGumPATCT1fbeT9by6ERngbLi3EnJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQS6+GXyxVYJcW6EPRPP+JqWlIuKNtTW9pGXaaUH6NyoEbLux34w0bus6DFgPZI36vurNrUvK0KHOeVpyRgTuGhx+YBAtVC/I0IkEuvAnNNvjJ45WFIWcZbrrtgQPm5xWlLwffavOVqUtlVaD3SG6MbgBB6Dw5+VlFyYrWjknWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBmHCc+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA490C2BD11;
	Sat,  8 Jun 2024 12:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851590;
	bh=Kz4eb2k8dxXqorGumPATCT1fbeT9by6ERngbLi3EnJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBmHCc+GbsJ84xO2zw02iaN1GUPQhDuMnEb04/80Ky+T/ecH54J1v9x6sMURJK24g
	 81FycrJUZk7aBZfBEO8WUVJ2IEN3N/GF2NTTjPeLO5aWJNwi/UhkUnJWXfLcP8LXP5
	 SyPQWxZ1XKg2c8La2Vntii4+6fHv7s+r4LHuQ/jvnFB29qKvtMMIw8Ht2BFf+QwVgc
	 b1YOswwU0jiYnGaSr5j49aRyptAa6H1ttCBQTqj5aia4GJca0FtqVCFXCcUsV1cnTH
	 lb0qVJnUI/mQFWU03pcM3sDIA5Rzqw9BkkBGXQzIOOUjhHYIEWwS8Wv/J9WfdmQgW+
	 /2ruRaKAbe3uA==
Date: Sat, 8 Jun 2024 13:59:47 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 10/12] iavf: Implement
 checking DD desc field
Message-ID: <20240608125947.GC27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-11-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-11-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:58AM -0400, Mateusz Polchlopek wrote:
> Rx timestamping introduced in PF driver caused the need of refactoring
> the VF driver mechanism to check packet fields.
> 
> The function to check errors in descriptor has been removed and from
> now only previously set struct fields are being checked. The field DD
> (descriptor done) needs to be checked at the very beginning, before
> extracting other fields.
> 
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


