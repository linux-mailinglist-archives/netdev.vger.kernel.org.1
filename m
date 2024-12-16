Return-Path: <netdev+bounces-152255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CC39F33D2
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 15:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE29164041
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 14:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0E45D8F0;
	Mon, 16 Dec 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPzX+stS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171595588E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734361002; cv=none; b=Plkx4zQW5TfidKkZs9mkd244zUwLh6hwmIWcXXA0rq+9DUQtJALqfbJzBQz+b8c8og8vT3+Kdil2j4uq3JaWXbhvthj+Dv810pdSW5p0z+3YJ9SSbh3juJv8nr8Kkx5PxqkVRgwKm8ySwKhsxcTgMqIj7IyAfRMwJkAgU0rSs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734361002; c=relaxed/simple;
	bh=5/FnNeMWRh0rN9TMAjU3XQ2FuOc2lrjw7vzBh95X0do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBYmduwCnOBBh77e1E5DDRuvPN1PUxI0EOmlyOIsmHHlaMV/ZblmIiy653gsXICQk7kbOM4UCygWRNUEWJMSVkEbnuaCHSt9yz3+QWs7SdtjPw8WdmbMBo6+MFjLTIUAf4u1so495dV0LaiplKTZppBJgX+hHRxJ9zxTodtt8LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPzX+stS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76A6C4CED0;
	Mon, 16 Dec 2024 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734361001;
	bh=5/FnNeMWRh0rN9TMAjU3XQ2FuOc2lrjw7vzBh95X0do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPzX+stSG0ss+/IhlJ+yKXooSmAUq2Ec6HkpHfQuOCtLL5SQR5np3ymNNE09prXTE
	 +a3WFm+a2RiMfYuTlwmrkRWJPeRTLOxEEbOi0oXyTs6up/IrPM19uIQmfG2AtchQqD
	 U8408MnXUmfEJBbddud0K5esJqXavoxFDug6lFQI59CgACi4CZYAqTpapcXQW9N8WH
	 98HnNGEaUEWG99HIanJNTSVM6j5gfZ96XphJ2ewILl2/DtwVF9O3Fa0BX1Lum+8th4
	 8L5vQCCGmOl48w304PXmNnucSTQC1nXSjdi1PXdUarov4uQK7/JRuq/wFoyU8eSjr4
	 rwu7oWP6Q4qsw==
Date: Mon, 16 Dec 2024 14:56:37 +0000
From: Simon Horman <horms@kernel.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: bgmac-platform: fix an OF node
 reference leak
Message-ID: <20241216145637.GD780307@kernel.org>
References: <20241214014912.2810315-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214014912.2810315-1-joe@pf.is.s.u-tokyo.ac.jp>

On Sat, Dec 14, 2024 at 10:49:12AM +0900, Joe Hattori wrote:
> The OF node obtained by of_parse_phandle() is not freed. Call
> of_node_put() to balance the refcount.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 1676aba5ef7e ("net: ethernet: bgmac: device tree phy enablement")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in V2:
> - Avoid using the __free() construct.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


