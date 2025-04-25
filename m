Return-Path: <netdev+bounces-186070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA618A9CF5E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0E097B6BBA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA054191F8C;
	Fri, 25 Apr 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYDAMx7j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58B0134CF
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601470; cv=none; b=A72KLdpQ3yVuAHwOpjHAY9YMm7fbEktxriZTk3aEz9xSnrdiMN63F/Hauo+T0dadr0mvFz8kijqRJ0cc0XuLIMrxeSsAmB1rS7MjE+Sog34QBfiMVOjOVX69fM6ScbSE1qy0dn/M8XF+hDp2HSrXivUFw4BaQNXS/pkY3haed3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601470; c=relaxed/simple;
	bh=R52I6WUQCQs45ctJowrJR75VTjTfZSijCSTrcbzlAmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4AzFHtVUWqn9oKn7j7Na4W0b3NJmZz2fVBuVmDS9FhZD3dscEDkAbuf49OfzAc5dPmcRu9np9lreeeUev+2hf0Hykf0Rn+8l8pQZhFRN64qcPDDtiLg3wIcIUi6QzMyToDvljBPfClx0RY8vRt82Kb8PqkReKBSMJINMV+PIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYDAMx7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AC5C4CEE8;
	Fri, 25 Apr 2025 17:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601470;
	bh=R52I6WUQCQs45ctJowrJR75VTjTfZSijCSTrcbzlAmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYDAMx7j71t0WtC/3fJAY8yr2Zl2kSJxnmbLCPYSKrXsf7LwxmNUu23gys6C0giaE
	 ABdAXKPSJ14gf+soUke6TuLgSG/LS/cFIo3aCpHP5WISPDoTp3xBPurXI9DAwPFevE
	 7E9/yenOe72MrtBwbwYwbOgTblH9tR1FVXoiZF3O+SSUnVe0lb6dhIseSbi/kvc5K5
	 aHpU300JhWaA8am5yyw4zd6B54Z+ztnVLP4zu8DEx7rNumy3DMjJ7Vslln0FI8EwoY
	 Jzs5gr5aqNA6EmO844mClez2L2HykB2uZWIfH+hB8eVKwFdirGBKsjcp4wf+kxJ+wg
	 89S7w7vnOCzCQ==
Date: Fri, 25 Apr 2025 18:17:46 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/3] io_uring/zcrx: selftests: switch to
 using defer() for cleanup
Message-ID: <20250425171746.GQ3042781@horms.kernel.org>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-2-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-2-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:47PM -0700, David Wei wrote:
> Switch to using defer() for putting the NIC back to the original state
> prior to running the selftest.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


