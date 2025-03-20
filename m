Return-Path: <netdev+bounces-176475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F41AA6A795
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE7B17B8B1
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA93222560;
	Thu, 20 Mar 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmLa6jsr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FC1FB3;
	Thu, 20 Mar 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478553; cv=none; b=VDrIgvMAze5AqQxXTbZ3wfvhxB6gGw7mFGSlMINgoN95UoeTRHoT8CojkSPHfklkqs9rkqZ0GfknLQA19rEnKvPHcmHTfT16w+E00JU9F1ieXyI6PofX6Kjy75wlCaVi4ZUZL3Cqhv8JQkLuGzAkdv/dNfbrNRWqAn2OSl3Y5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478553; c=relaxed/simple;
	bh=yDgms/oDr2cMzovdZvyCptIYR62Pb1jEc30RIJ/xnvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGcEpRZ8cdb0wYYXb3SZXNtVeVXW7CXCJ5+14jXbL2dEW1xkKlg5v4ylga/d+kwGq4EVdBUsgl4pYu5/QxV9Len5c1I63uXeiFq2rhGXst/DdD3T2LdKdg+ApNu1Uv/mBPJwbQLzQenGjvwu21Db2gprMGol/jFf5CPQ4xfMYcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmLa6jsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013D7C4CEDD;
	Thu, 20 Mar 2025 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478552;
	bh=yDgms/oDr2cMzovdZvyCptIYR62Pb1jEc30RIJ/xnvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmLa6jsrrCuzVtsy62d/LivJkPgU2W3D0l9F5mam7+E99UKO1ErCruXS2+52nTcGl
	 mRtvGlfw94g3S70qkJ8zOjmiAIh0sqFbgkhhUXKJBwRjoFJoTF1vfJXQQF6a+L6gs5
	 9Un388wgN7y0yfJBb4UB4BEisTFgWMzcgyVjOWSsNIAlgvBsCwGEMwzcNzwGVjlnCB
	 H+yFcChetUc63Y0Eok/aJxGn5nmWohkMf9F+Kbkep85WBt5rZ1HqKPQPm+qog8gYw/
	 8w6HZz1G63rLt6+dk69Sc/UiwM2U0DiMJvMivL9yww+bnF7GF6b50wYetDLNfQH3UJ
	 Wjrt3IMgE1HhQ==
Date: Thu, 20 Mar 2025 13:49:08 +0000
From: Simon Horman <horms@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] net: ch9200: improve error handling in
 get_mac_address()
Message-ID: <20250320134908.GU280585@kernel.org>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-4-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319112156.48312-4-qasdev00@gmail.com>

On Wed, Mar 19, 2025 at 11:21:55AM +0000, Qasim Ijaz wrote:
> The get_mac_address() function has an issue where it does not 
> directly check the return value of each control_read(), instead 
> it sums up the return values and checks them all at the end
> which means if any call to control_read() fails the function just
> continues on.
> 
> Handle this by validating the return value of each call and fail fast
> and early instead of continuing.
> 
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


