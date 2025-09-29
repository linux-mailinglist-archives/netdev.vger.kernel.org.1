Return-Path: <netdev+bounces-227160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3BDBA9503
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 15:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCCB1C1A1D
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D13074A9;
	Mon, 29 Sep 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQJwLIH8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733B13009EC;
	Mon, 29 Sep 2025 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152058; cv=none; b=AX43iMx/Po+19+7vcSf+Yf+8Jy7tZcTLy8J/5PDtt0gXxrMfkK5JlaF/+8izQgtUEktumUd3kGvUUL8r304+LP9vTEyhfx8ZERl03AQxG4nVq7kAeoAQsOD2bszsVSfMqGQDkkVzbGLNBTl44B4niS+zl4eX4PDCrFEhPlJsXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152058; c=relaxed/simple;
	bh=9tkWX6G78EOBvdCsrJhOv25hEF845H6fxqO1x19Fh3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCFISgrwx0erE9B7GjGMlYIzSerpRcupuQdt0/OEQw2EkbAP3qxjhQVZ+tSMf/qur5FBmRizy3XKzcKLO9vNPKC1HfTEHKu6LrGJ7Zg1pLyp+6TygM3ufJd5VvC54aP9asHQTAAlvVP2k5OtqHr/ziMmvL4wolLDCfenonUsiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQJwLIH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B801C4CEF4;
	Mon, 29 Sep 2025 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759152058;
	bh=9tkWX6G78EOBvdCsrJhOv25hEF845H6fxqO1x19Fh3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQJwLIH8zDUh6ZcGOHvnc0/hvFVbXcUgvQ2on/X3UItfvSro81aGZOAoJNsnOqM4i
	 PlKEKbc7RTKQBTTzkzJYfXGdJdoiMp+0UwTyubEDW/FGZs7COIp7r5wpkbSTDi0LHc
	 1mJBYlf6hrIYLhy7UdP1kI6NpR6fkrnKE5X/ShGiVYICZcgYuAGbKnIpuNsq2+GOYS
	 4govV+GYOZ6CFvILcGbhcN4cLqUpVhmtPxRNa87B/W/xl5HyTgYHuqUIjGfNjulkFR
	 jBWjHDGZMtH031wR14/s979thhQrBWBXXOc53Jp36vfirGGCx47aLmU3/DxS8mnxME
	 k4DnYW/ZMwpMQ==
Date: Mon, 29 Sep 2025 14:20:55 +0100
From: Simon Horman <horms@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next] ptr_ring: __ptr_ring_zero_tail micro
 optimization
Message-ID: <aNqHt7dgy3tWRGjZ@horms.kernel.org>
References: <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd630c7edc628e20d4f8e037341f26c90ab4365.1758976026.git.mst@redhat.com>

On Sat, Sep 27, 2025 at 08:29:35AM -0400, Michael S. Tsirkin wrote:
> __ptr_ring_zero_tail currently does the - 1 operation twice:
> - during initialization of head
> - at each loop iteration
> 
> Let's just do it in one place, all we need to do
> is adjust the loop condition. this is better:
> - a slightly clearer logic with less duplication
> - uses prefix -- we don't need to save the old value
> - one less - 1 operation - for example, when ring is empty
>   we now don't do - 1 at all, existing code does it once
> 
> Text size shrinks from 15081 to 15050 bytes.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


