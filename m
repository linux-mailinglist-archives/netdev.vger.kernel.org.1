Return-Path: <netdev+bounces-217013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C42B37093
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F333AE8CE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D72269AFB;
	Tue, 26 Aug 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVJjpofz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B61314B91
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226201; cv=none; b=Y5wsFzVgBbZR7BiH4uEYDgMAxvTE1NmWdp/P4GyGvLOHBNQpwdlY3cXGk/b1HqbixeYjgBAYBHOQw04mlXycs8KG212fXOYnCuyxqrC0X4xcM44COJS2Hw91ogr+J8cGFh/vrPNlyx8qO/S3Pf46MDNSsi/XfDZh3q7EFabTApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226201; c=relaxed/simple;
	bh=LD542g5aiwUB0UK0QgBaqLiP9350DrYBzkUTF6bDdlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntGgAX4WjyrO3c8uVVPAP266NHabfMn0LjDvqcnwDYUu7MImfI5Ubfc4urdgUrgdjUetJeBTK8vuCLpaaRxjNFIRGEbkfqRyqux2zZf5iLUPAumDVJANZA1e1huE+VgHxDO0qN66QolS5b0594pnk2a+TCYZh6Sk2BWlaNKnycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVJjpofz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DC1C4CEF1;
	Tue, 26 Aug 2025 16:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756226199;
	bh=LD542g5aiwUB0UK0QgBaqLiP9350DrYBzkUTF6bDdlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uVJjpofzUGjmjxQKqXMqEJQs68iKKt8pZzzfjHzk3uHFhThcIuYUtiIp6g0+IQNBs
	 capYwf0wUVaA+u36/8g291bAv3vkKMWX+Q4+RiifdzHVqURFn4Raioh6pHlpC9Z1xO
	 av/T7+JUuX8aMdUGxNLT6Petd8t5cEMPvT/Mpqc4pvX+Cuhl6tWvyJRNDLu434DHk/
	 IBMgJFAAfDuJMwiCxsbV+EF3FSysoGrbrB64rBiAjl1QcJ+R5bTu5GEi6Yc03U3m0h
	 6fZQevaujD4mdgVZoNKlioIg/SqR4Q7jjWc+cNNvNoxUWAinM59YV7m2c2GM790eYM
	 vwMZneUo5B9uw==
Date: Tue, 26 Aug 2025 17:36:35 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>, jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com, Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net 6/8] i40e: add max boundary check for VF filters
Message-ID: <20250826163635.GK5892@horms.kernel.org>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
 <20250813104552.61027-7-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813104552.61027-7-przemyslaw.kitszel@intel.com>

On Wed, Aug 13, 2025 at 12:45:16PM +0200, Przemek Kitszel wrote:
> From: Lukasz Czapnik <lukasz.czapnik@intel.com>
> 
> There is no check for max filters that VF can request. Add it.
> 
> Fixes: e284fc280473 ("i40e: Add and delete cloud filter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


