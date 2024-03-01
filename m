Return-Path: <netdev+bounces-76658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1A586E72F
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D87A41C21A9C
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511387468;
	Fri,  1 Mar 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtI1pSPK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53A33C0
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314095; cv=none; b=DUCKjSJ/E5VMujBBu2LCxhL0wnpVLZqHjgOQWgqG+uI7WN0DbdmZHRhjz8pcbx31V6wNmUSEYI/HX5pn2t03bhCUOp3Ye+N5KbpwC2JJmYwV/Z/lUWb0Ju5VncOzvHLTEbDGTtfPm855yxOsJT3/Qy7adnLSuD/pvIESeia8OQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314095; c=relaxed/simple;
	bh=9teRozo3GXGC4zzvwAgTOt5z44s5xHzrURgOL/zeYpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9o4r1FlliygTpkW3Ssrh3Qb43j42qLx97ty2U6xQTP9l0c9xAMZ8P5DAFNC6C6hZYROfwGCd0LtPEjYGIInGTVgXYDxVT8uG3UxKsZynF0hpdEI+31alzOtLY1RY/AuwT3ZYLV5aCC4yQAbwTbnkY0zL0dkGmdHN+lp32zHvbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtI1pSPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63288C433C7;
	Fri,  1 Mar 2024 17:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709314094;
	bh=9teRozo3GXGC4zzvwAgTOt5z44s5xHzrURgOL/zeYpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtI1pSPKG2F6f31rnrw2/t80sxKWiT6hHi8OvGo18vnfFSabuztjY3uPvHiTdQnvS
	 baph5WmY3UZZNtocZCL/0d6KJgjqkBnPdb936oIimanHWmXG0hRGU2v76HHlGow1V1
	 Fs6/gnpYlf1H/m8bSNToYs5zYRcwlVcizAcXWBVyI6eysIbgvDzCyNKxRzaiD0FXMx
	 3DY05PERwKx+FZoGpKkBL5F5BQuW6UzOUjyGnAdElqfXOvmxxIPhbUVOeJEFzCO8ao
	 LJZgHNeyHeHhbxT79WRsBG5r8LowRelDUqSEYcYK8injJZGC9UQp1NNdXsm8gvjMyy
	 FIxlA5zekk1Hw==
Date: Fri, 1 Mar 2024 09:28:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, mlxsw@nvidia.com
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group
 stats to user space
Message-ID: <20240301092813.4cb44934@kernel.org>
In-Reply-To: <148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
References: <cover.1709217658.git.petrm@nvidia.com>
	<223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
	<148968b2-6d8e-476b-afee-5f1b15713c7e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 08:45:52 -0700 David Ahern wrote:
> > +	/* uint; number of packets forwarded via the nexthop group entry */  
> 
> why not make it a u64?

I think it should be our default type. Explicit length should only 
be picked if there's a clear reason. Too many review cycles wasted
steering people onto correct types...

Now, I'm not sure Pablo merged the sint/uint support into libmnl,
I can share the patches to handle them in iproute2, if that helps.
Or just copy/paste from YNL.

I need to find the courage to ask you how we can start using YNL
in iproute2, I really worry that we're not getting CLI tools written
for new families any more :(

