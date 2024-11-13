Return-Path: <netdev+bounces-144286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142159C6723
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 03:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76F9284572
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 02:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AE770E2;
	Wed, 13 Nov 2024 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDAB9qLU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BB3C00
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 02:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731464121; cv=none; b=TiAEmb5zrb/l/ffMJe0clNxpAPn5wS+0hghwEc73wUlIVmXfAQUh6hl6zWOCyu21r5pjPkZOOx2QNrUHdN4YjtdfuqtRGERE+MjSlhMJWgoE+Cz+t9cMPZJR8n+57JdjRRN7HIOQ/j4G0cue2fYriN1YsF5f+OLmj0VWGHKmX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731464121; c=relaxed/simple;
	bh=fk7Pads2nlZKJDGzc0rasuyy2zFL0JswoVb99NFsYqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InonJkv7QtMYozl9pqOX+gEJn2WrRefzFVb7qPhY3z5c+2eiwnA1au9TmOXpcvxiOHBS5GYXnwgTOSuC1QcXILbEpgwoDgZIKXc+wThZrj8z/6Is8PLeB1+HI0Jl1flx9a4zUQ6xonzuVBV7nnP2XWNQEHpqnWEWUbR4PvwlGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDAB9qLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE96C4CECD;
	Wed, 13 Nov 2024 02:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731464119;
	bh=fk7Pads2nlZKJDGzc0rasuyy2zFL0JswoVb99NFsYqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RDAB9qLUsjg3JX3Z4B/5AhELlb5yA7u7yBSfJLeNpkCsM+hpZm/yoeYGYj0icl/qg
	 RCd5hsuO1cBbDmI1VRkaTxR+pQ9yPkx9JneljY0VsNcMayJs+0/h8U6/pxmz4AsDTp
	 Yw1UQYMMXQCsAUErqCBWUnpfiExLzOusKyt6+ulB9oE0nZ0V/g4o1Dvdw49TGlQ9pC
	 S0uI759TBIkIe96FchXUklaebtdIHfppTAYpdeNQhGNcfQMhJZuSJLNF5CLhJCNfHb
	 xaw+ZUmPw+CYQsQGVpKjRl++jnBnfv2HqL7RFw+Sx0tfW7ijtXScyjA6OA9VTSquo5
	 f9CcpB5JzQYQw==
Date: Tue, 12 Nov 2024 18:15:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next] geneve: Use pcpu stats to update rx_dropped
 counter.
Message-ID: <20241112181518.3f55a359@kernel.org>
In-Reply-To: <a6bd2ee8-c732-4922-9e7c-ae89a1ad8056@redhat.com>
References: <c9a7d3ddbe3fb890bee0c95d207f2ce431001075.1730979658.git.gnault@redhat.com>
	<231c2226-9b16-4a10-b2b8-484efe0aae6b@redhat.com>
	<a6bd2ee8-c732-4922-9e7c-ae89a1ad8056@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 17:53:36 +0100 Paolo Abeni wrote:
> > How about switching to NETDEV_PCPU_STAT_DSTATS instead, so there is a
> > single percpu struct allocated x device (geneve already uses
> > NETDEV_PCPU_STAT_TSTATS): stats fetching will be faster, and possibly
> > memory usage lower.  
> 
> I was not aware of the previous discussion on this same topic:
> 
> https://lore.kernel.org/netdev/20240903113402.41d19129@kernel.org/
> 
> and I missed the previous change on bareudp.c
> 
> I still think that avoiding the double per-cpu traversal when fetching
> the stats could be useful, especially on large multi-numa nodes systems.
> 
> I guess it's better to be consistent and keep geneve and bareudp
> aligned. We can eventually consolidate the stats later.

We merged the bareudp changes... begrudgingly. You're the third
maintainer in a row to make a similar suggestion, which is pretty
strong signal that it's a better direction.

