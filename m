Return-Path: <netdev+bounces-178416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1AAA76F6D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 22:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E121118876AB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06CA218585;
	Mon, 31 Mar 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMIPnJrv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961C7214815;
	Mon, 31 Mar 2025 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453376; cv=none; b=F8xKOueCwU+ZS9q27jMuLu2fVjfdB47+ETfTUcVj3gkacu87msMEsbS36j7JvDj1ea+5iTWTVzMZr+ITuMQjQRqB6cAD5s+EVcq0Oi/SRErZHAnLSPSrcByAOAS68Tb+egcbyxJ3wS45ygo+2KDsgvnys0zqnAxvGdykXNH8WUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453376; c=relaxed/simple;
	bh=Xo1Ibr8NUeSi7iJ7yKN+q5UAR3IGl57czIIIOHN6BbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqHFlqeTRyaAU4hhArlMdCYii25UIYmOc0YpQa4po4J1PkRwT+zCWZWHm79OJ5HuyMMV+38MqDEmHD4xI9aCodQPyz7Vku2hA+5P9A9G6eYB6TSGt1SctzmsLWZ+mFBAajFxQIWmfwTGEUFHw1aQWeeQdYC47Xl0Tin8HOIaHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMIPnJrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7DCC4CEE3;
	Mon, 31 Mar 2025 20:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743453376;
	bh=Xo1Ibr8NUeSi7iJ7yKN+q5UAR3IGl57czIIIOHN6BbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMIPnJrvR4hFIIoB8o9CuVr01b5GXh+yQwD3y+mlF0C2UXPcZQzfhxfaTqW2rtbXk
	 B4oF/Cz7rJl715vJPI4tSexbdx4VKFuVf3i057E/jCxO6FeIzLq7mBpY0RcijUfPcL
	 jSdW2soD+cPhMln1Domt1bIOq21TpBWQ6gECNMJ+lTR9GbMP8rTMXaOgh43rvescsa
	 Sk4KqqT+ox2km4As1366S4ln6qhX6qH+f/cLtp51CiGSXSanhlXdql5FL0Pp2vfgqP
	 6/1yieG0bh8TRgyB+WjQ0kFDPFXGgTUHj5CNIZDs+HRd7een/CAlK8OYu8EilF3QYu
	 Bk0Zxk5XbuBkQ==
Date: Mon, 31 Mar 2025 13:36:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>, Eric Dumazet
 <edumazet@google.com>, linux-kernel@vger.kernel.org (open list), Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <20250331133615.32bd59b8@kernel.org>
In-Reply-To: <20250329000030.39543-1-jdamato@fastly.com>
References: <20250329000030.39543-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Mar 2025 00:00:28 +0000 Joe Damato wrote:
> If this net-next material: I'll wait until it reopens and send this
> patch + an update to busy_poller.c as described above.

Let's stick to net-next. Would it be possible / make sense to convert
the test to Python and move it to drivers/net ?

