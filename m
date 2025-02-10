Return-Path: <netdev+bounces-164783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7337EA2F166
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 16:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8698E166DF1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2AF2397B7;
	Mon, 10 Feb 2025 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZUQJz+9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0172343BD;
	Mon, 10 Feb 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200972; cv=none; b=uysmPR/5LhSBSIIFpK8s6TbTEah73JWo39Xm+4O8+fG/+fEl7FvXmJ6XwyQaCQCnor4vF//W6Ac1Z8mrHDuOC0fLu+CJlePGnXmvszmFXRw1ZLTPy5sxS866vFPKEB8SZ60D/648EBCT3Fm9f5zC444ML1TqEW+6V10FfRZ70js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200972; c=relaxed/simple;
	bh=4ey5/kZZywhO4NrHdQDX0eGskD/P5tmgMEuhTvXsAnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/byD/UhLn2y87GJbnnZXrUs/eNITJeJ/Fj+7zjnGRrFYMIWcWE+/3OyqXJcERiHjqa7eBSYEgh2heVTN+CsjCtMAnMuqYmWD94dHTq+AssuG7O1zDvbT3vw5/W4m4Db5JhQEZOpQu+b2smyoiZE9OKf+KfPYwLVedAzDbldN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZUQJz+9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43938828d02so2760755e9.1;
        Mon, 10 Feb 2025 07:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200969; x=1739805769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Br74BShwtiiuy7z2LZlgm7PDF+Zhj54VgRc9wxXedw4=;
        b=YZUQJz+9LXwUlrXb98qp1cShVTYaImShSCqPUKMao86wxNkG5pr8LHTRclfgW9gupS
         Iu/3+VRYVp2+G4LakjyG5cf554Qf94ZvWHBT2Umb3n53CavUzQOAR+lOZY16sTMLverL
         gQEzYwonBjg34GOA8qkYZ+WNzjc7KJIEPbMinEVMKyW921wyD823HPQMROlKnU7BIgC2
         KqrotgvCWfNoVPxwGKHLAg9kQqjmtKrFifWpHJ7EXK3oCSN5F5JbLj6ugp19o5BwyvAK
         E9c93fXQjRWJ1Y67Jn0uZjQyrkUTP81o96k5edVfddcxzvc6wsGKsbIbRUHAcbVYFiy3
         +6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200969; x=1739805769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br74BShwtiiuy7z2LZlgm7PDF+Zhj54VgRc9wxXedw4=;
        b=W6UEoosmLpnSJz/QnjCCxGhd5gkN7fepAFSXk2UDGXRl2SSigpoVbMwBB3Bpne/eG1
         0hCYx1U5hKdLcQdPUBpP8SQ0DK9Yj7vFl990G5l4B0zAUMm6oK44YHOH100dT2vhdNpl
         MqPWvMzOVTjHqxmERQ0gtuzCbslx6h5E7pEhEkQuZkqKzt5llw0L85muXgMQ3fUAXjYc
         UA8w6JiaYliWPU4ahcfAEZacOy9XM5oVPaJQKbvIftZwdzImxKBBXkdmuyImz9+DM7QI
         Rwk+OknHveTgl2YH2IpnxRF7X8BC0+MWsN0SrzVi1/3JdxRSJfUaIRDooGG7Dm8WPfn3
         ABwg==
X-Forwarded-Encrypted: i=1; AJvYcCUmBFsCogLIDXZWB68puCAonZicRE/bp6KwmNUey5JuJYW5r+7bq8MoPsqnADplU/cWqYTIr6MjnsFwBCM=@vger.kernel.org, AJvYcCWDp26qDmV1cxurW6lxoGbHJqFwk9zj83n4DQzAQ4B/eOLJe8uTRVg2MLX8bxQTSLzAAEIlK4zu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx434Utagbv8rvoof3zjaveD14Bbu4Oc3beBPUWwdyZ2SNCPKIx
	iQnRVt+1It6KoIJiO4o2pj1UVgKjVEPnDa9lLqqA57liRd7vJhBf
X-Gm-Gg: ASbGnctkee3YJGyFiR6oPNEZorcbke6B8BcmXeTrDrI/LZNT+m5EMSLUDO4R4INk/cX
	BMiLmOM1sXT2TCOCs11SPQ6uLOdftbomfikxlXKUFn8mUQZQSXI623j5ChNxJ55bOwob7nQyGRE
	bKHYqmDWqnp2/WP0gLrmYF3y5oVx9Q7FcD5B+eCW7nXXwIRcPvqPihsWytg0bNA33kDok1GPiQ0
	bGhMiedTGbt5m9xS8+fKldN5F/eZQM+Y/sZMXBoGXJKqHrKi3OA1RYUVmAmDF2K+AiQ0ELybjhH
	8Xs=
X-Google-Smtp-Source: AGHT+IEDYZZ6jSptYMQEw+9oVycI5AcOuMHr+sf8wBwW+OthyZShWcZ0gpBTn9WQOn4H3vy7SzPuTg==
X-Received: by 2002:a05:600c:3b1f:b0:439:4a9d:aed9 with SMTP id 5b1f17b1804b1-4394a9db2f1mr7336105e9.8.1739200969126;
        Mon, 10 Feb 2025 07:22:49 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4392fc7ceacsm83217705e9.20.2025.02.10.07.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:22:48 -0800 (PST)
Date: Mon, 10 Feb 2025 17:22:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Eric Woudstra <ericwouds@gmail.com>, Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 net-next] net: mlxsw_sp: Use
 switchdev_handle_port_obj_add_foreign() for vxlan
Message-ID: <20250210152246.4ajumdchwhvbarik@skbuf>
References: <20250208141518.191782-1-ericwouds@gmail.com>
 <Z6mhQL-b58L5xkK4@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6mhQL-b58L5xkK4@shredder>

On Mon, Feb 10, 2025 at 08:48:32AM +0200, Ido Schimmel wrote:
> On Sat, Feb 08, 2025 at 03:15:18PM +0100, Eric Woudstra wrote:
> > Sending as RFC as I do not own this hardware. This code is not tested.
> > 
> > Vladimir found this part of the spectrum switchdev, while looking at
> > another issue here:
> > 
> > https://lore.kernel.org/all/20250207220408.zipucrmm2yafj4wu@skbuf/
> > 
> > As vxlan seems a foreign port, wouldn't it be better to use
> > switchdev_handle_port_obj_add_foreign() ?
> 
> Thanks for the patch, but the VXLAN port is not foreign to the other
> switch ports. That is, forwarding between these ports and VXLAN happens
> in hardware. And yes, switchdev_bridge_port_offload() does need to be
> called for the VXLAN port so that it's assigned the same hardware domain
> as the other ports.

Thanks, this is useful. I'm not providing a patch yet because there are
still things I don't understand.

Have you seen any of the typical problems associated with the software
bridge thinking vxlan isn't part of the same hwdom as the ingress
physical port, and, say, flooding packets twice to vxlan, when the
switch had already forwarded a copy of the packet? In almost 4 years
since commit 2f5dc00f7a3e ("net: bridge: switchdev: let drivers inform
which bridge ports are offloaded"), I would have expected such issues
would have been noticed?

Do we require a Fixes: tag for this?

And then, switchdev_bridge_port_offload() has a brport_dev argument,
which would pretty clearly be passed as vxlan_dev by
mlxsw_sp_bridge_8021d_vxlan_join() and
mlxsw_sp_bridge_vlan_aware_vxlan_join(), but it also has one other
"struct net_device *dev" argument, on which br_switchdev_port_offload()
wants to call dev_get_port_parent_id(), to see what hwdom (what other
bridge ports) to associate it to.

Usually we use the mlxsw_sp_port->dev as the second argument, but which
port to use here? Any random port that's under the bridge, or is there a
specific one for the vxlan that should be used?

