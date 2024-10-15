Return-Path: <netdev+bounces-135388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F6799DAF9
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 02:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585B1B2281A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 00:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07B049625;
	Tue, 15 Oct 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbPbOi3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866C0535DC;
	Tue, 15 Oct 2024 00:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728953636; cv=none; b=BwO27up9O5eWdcTO+EdTGViwWYdimOi977Yhc+B6FJTUnJC2O6TfFuDZDtCOj4qPyI8ej8la8R1RozD1BhcH69XOPpRuUIXlHdH1U5H/++vCZt0/RXLIjfXaI7ervj4TkV8388UkXP1S+p17w4ClhSXQUB9n+uDtfoJ4hBMgQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728953636; c=relaxed/simple;
	bh=Vlwh+IoKxo+PywJMA1nuZ9Uc0Ubh1fRLfDOQVqPQIi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAUHvB4Wv/1VraixlKX1qeLoeZiWoKCWYSHcDM45PC+oQtLQ3PF64nxGteyWSFVPlOP6OIhO3hzWTG9FG9sqvIKBGxklnw+hLHBq8sk5Ap0EC5A3DKSXZqcrWAy//xX1awOw8HYwWWcwBbnwhIs5aILmxdMG2Vj0ocpVxEldQNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbPbOi3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E80C4CEC3;
	Tue, 15 Oct 2024 00:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728953636;
	bh=Vlwh+IoKxo+PywJMA1nuZ9Uc0Ubh1fRLfDOQVqPQIi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IbPbOi3pQRnqOPqXwSVZfkQ/g3RGpNg3KdNfAdDHfhJgEd4CGxt761VAlvvk+ZKeO
	 0uyekOFdfJi43rQVQNljvPK2Q7w5H2FCtniYHPxf/M4zWVEe/6pd+k+6WWLF9o5Qgs
	 Q8csLd3wPaf2o7/sE9vo0ufkx/7tfYOdbMOv5JkioE0W7Nkl3sCoYOMzyr3ukB+g7Y
	 I8xXRzEPOMexys2trAvTg6pPaPt2V4DeATHG/LGsWMv6lu3UX22v6T+hg2HO4wuU1X
	 hcYj/rYVw0jflKdEkdzbTb9gdvvW3IG2gfc5JPRR6WhsLJ4evvKPL6XoIJXzE5PTtM
	 lXCq4muDBNk+g==
Date: Mon, 14 Oct 2024 17:53:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] ethtool: rss: prevent rss ctx deletion
 when in use
Message-ID: <20241014175355.62d40b01@kernel.org>
In-Reply-To: <966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
References: <20241011183549.1581021-1-daniel.zahka@gmail.com>
	<20241011183549.1581021-2-daniel.zahka@gmail.com>
	<966a82d9-c835-e87e-2c54-90a9a2552a21@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 11:10:33 +0100 Edward Cree wrote:
> On 11/10/2024 19:35, Daniel Zahka wrote:
> > A list of active
> > ntuple filters and their associated rss contexts can be compiled by
> > querying a device's ethtool_ops.get_rxnfc. This patch checks to see if
> > any ntuple filters are referencing an rss context during context
> > deletion, and prevents the deletion if the requested context is still
> > in use.  
> 
> Imho it would make more sense to add core tracking of ntuple
>  filters, along with a refcount on the rss context.  That way
>  context deletion just has to check the count is zero.

True... This is my least favorite kind of situation, where the posted
code is clearly much better than the status quo, but even better
solution is possible. So question becomes do we push for the optimal
solution and potentially get neither or do we apply what's posted and
hope the better one will still be delivered later..

