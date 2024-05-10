Return-Path: <netdev+bounces-95424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581388C2360
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7EA1F2556B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D661171E45;
	Fri, 10 May 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHeelpjE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EC17083A;
	Fri, 10 May 2024 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340441; cv=none; b=owKDxX2sVQjAghEsldjFPPN+wbjFVJee96EdkqJeir0KxF3NSCjhGlW2OMyEd04UHgp2vH45YEjjmq3hWMFBmLXsieCxqtBs9WQ0mH7f+GrILvqtOhl7uVcn5/pZt/Z1yzxDAcXLHMOFXZzvEx0JhCHhKZAqN2k9GZb80EAXUSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340441; c=relaxed/simple;
	bh=4Dh5dxwQMUwQnOXqLi6BQvRsTeACaaji7ugLz/WH9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqV6/bGXg+LTtSnLsxHe/3TNrjzfyzMUHSu1W66mixyb1XvspPij6L5f6g/GpwZe1ifAyTs+8+Ss8FTc0iZklzLartR5pocoyOG70dPt41CCdhlNUNEwrhJoBlCSOf6UHib/EorwvnyIcClOVbG1CJ7QZge+CQoEAIOkE6X/hG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHeelpjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451ACC113CC;
	Fri, 10 May 2024 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340441;
	bh=4Dh5dxwQMUwQnOXqLi6BQvRsTeACaaji7ugLz/WH9Aw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHeelpjEShFmQNx4WfooXMnJ5OwskZztJP/zt30LRFe/Gy9CFLt0KYKiblHfKQ7tp
	 wRDkp2t9LAks6q8Ix1VBDhx+azNAwS/6yKWNXga/uDrf4ZT+rRPY25TOI4XBNlS0zu
	 6BjJzEpCPYd51dcoDD2zil/VokoPgQp9YixpYJH8OjB+5PyfSFuHt3lVwkPBcLn5FU
	 0APdOifPvMzjhOFJ5ceC06M+eVz0et/oRzKFtMIMpBchO7LFMx4X9QfTJ4B/v3HKMc
	 oOh9+UcAeoX74Y/x+qKX+FgBueXeiKF6U3nbJN7El1lTd5TPSGLwSVV7PRyQnJZJvp
	 23cZSYPsRw2AA==
Date: Fri, 10 May 2024 12:27:15 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 03/14] net: qede: use extack in
 qede_set_v4_tuple_to_profile()
Message-ID: <20240510112715.GF2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-4-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-4-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:51PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_set_v4_tuple_to_profile() to take extack,
> and drop the edev argument.
> 
> Convert DP_INFO call to use NL_SET_ERR_MSG_MOD instead.
> 
> In calls to qede_set_v4_tuple_to_profile(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


