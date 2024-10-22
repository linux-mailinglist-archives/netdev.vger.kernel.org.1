Return-Path: <netdev+bounces-137961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B49AB422
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D295D1C22DA4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604141BC9FB;
	Tue, 22 Oct 2024 16:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8egWqcp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5311BC9E2
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614967; cv=none; b=rbuOXo1Mv8Rk5Ja32cFBQsYNqPDZM2ewYZgRGHb2r1o8oLl+fk4x9Qec52BW7idUNNg3n6Pfxn6q9YjzGE9OQuuQ+0/ugFmIPGaZXzyDuosFIOMC7j76RTnw/NvkEp5D8TYvsXvWGHh4ys39nWadxKCZI+wfjhSCxxhE3yis1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614967; c=relaxed/simple;
	bh=IBTe/AqA1fGpH12sVwz7PCkkKWe4VfOCZyBlYt0/6y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcYINKyUKEZntnOMXCJUVko9EiZKiuYWOhNJgxCbF+oiGrxlkIWEFtZQJiVlafN+BfNhSsHK8THtzmCZhGZqlwbo8C6VVLKnn3YW7+M8ptY61LXri1kDAbhShVD2wY19mvWgWs6aPCibcngqYIAJSuORg9rKGlaSZWrtT1dOaTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8egWqcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD919C4CEE3;
	Tue, 22 Oct 2024 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729614966;
	bh=IBTe/AqA1fGpH12sVwz7PCkkKWe4VfOCZyBlYt0/6y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8egWqcpBiK1/9m+phA/HWrRyGDMxGxY8MMLtpUY6Q59XaK0xzCnw3tlhp8sRcmkM
	 AYarriRVTVLhF3wCXU2HRtBYLhtl4Fiv70FkUu50VvIz6lPWf4MspVDjNAZWq2whyo
	 5nUEVINi3S+94z29arCFyfL6ff9DavHL4s7/bYoX4TziMtjBhOlMXoxlLw0YV34AIz
	 X8f6RdGM9tCeedumQ9ghbBUukKBUKm0PTkX3qziZxIe9tlMZkJ7hHKz9jyy5J2e4bL
	 NmQK55NmZ8UhRTXO25j4eFOU2WOW1ahL7T6QgaJpCRHUSGNtyGQxUywe48iUI6prcb
	 VvKUX3aG6D7xA==
Date: Tue, 22 Oct 2024 17:36:03 +0100
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: netdev@vger.kernel.org, satishkh@cisco.com, johndale@cisco.com
Subject: Re: [Patch net-next 2/5] enic: Make MSI-X I/O interrupts come after
 the other required ones
Message-ID: <20241022163603.GE402847@kernel.org>
References: <20241022041707.27402-1-neescoba@cisco.com>
 <20241022041707.27402-3-neescoba@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022041707.27402-3-neescoba@cisco.com>

On Mon, Oct 21, 2024 at 09:17:04PM -0700, Nelson Escobar wrote:
> The VIC hardware has a constraint that the MSIX interrupt used for errors
> be specified as a 7 bit number.  Before this patch, it was allocated after
> the I/O interrupts, which would cause a problem if 128 or more I/O
> interrupts are in use.
> 
> So make the required interrupts come before the I/O interrupts to
> guarantee the error interrupt offset never exceeds 7 bits.
> 
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


