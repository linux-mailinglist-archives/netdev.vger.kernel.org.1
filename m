Return-Path: <netdev+bounces-217707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A3CB399D9
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43D37C7391
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E0D30DEC7;
	Thu, 28 Aug 2025 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e91LHp+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF730DECE
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376820; cv=none; b=hlpSoWslg769pupZVpnErs4Dz7WLaB8ugc6OiWKAZlo3J94l5ZgR6AKxfeXvWtl+831hFzTyrCyM1ZNR/I1n3amBZWqtFZ9Ay/ij0trwttbRYRhW2N1LzYSWsn7g7tVf2tausQkBl+z5PwzCbzuLz2JW+H3lYDr86gucUaTDIus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376820; c=relaxed/simple;
	bh=c9cqPgUO8oKsPqQ28CBq8ZQxot6CBLavcG7eanfYbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEYYwvRgKUm1X4P/xvmkBNHy6dYSzOtRPgJSwkyn+YOLzrRuI2aZdflFRvU3ze9lXS+mOmIXDwzhkg0KVONkQR7VsuXHuBjPinu5FL9huBIqWtvtJr6ka47aPKHp/P+LvDGsExckktLRHXiHCmVZnTr8s3zk4LcpoltzZMwRPWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e91LHp+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1084AC4CEEB;
	Thu, 28 Aug 2025 10:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756376819;
	bh=c9cqPgUO8oKsPqQ28CBq8ZQxot6CBLavcG7eanfYbSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e91LHp+NMls5pvq12ta/JVgjf23+KzTO9sjZctElQX9sGV9lhovWMGsiV4Zp9aHQD
	 R3Rnj/GhvOsaKs4Zx+wmDpDyHtR7m37ms4Bw8vM+0AjrS1Z6Gi9WA8iCEEeZdGMnFx
	 FvzTUVu5bSBERktKnO1r7OFU8gvkiubUOpjGs3ruyUnArBxXjMfAZAf31SF1jQAosg
	 tvYyIoY9yNtIO3lsx3QcXC1GllNW9z3NzqJJQRexe+e2u2bGlUAtju6V6bcxCzpcoi
	 GhjvEp6JbrMy/U37ijHbr+lOI2MPSH8iUccLd+Kt3f8VrWlSJwTYl0mWwxCcO9ojEe
	 SwL1EI0Jg1kNA==
Date: Thu, 28 Aug 2025 11:26:56 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 4/4] fbnic: Push local unicast MAC addresses to
 FW to populate TCAMs
Message-ID: <20250828102656.GY10519@horms.kernel.org>
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <175623750782.2246365.9178255870985916357.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175623750782.2246365.9178255870985916357.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Aug 26, 2025 at 12:45:07PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The MACDA TCAM can only be accessed by one entity at a time and as such we
> cannot have simultaneous reads from the firmware to probe for changes from
> the host. As such we have to send a message indicating what the state of
> the MACDA is to the firmware when we updated it so that the firmware can
> sync up the TCAMs it owns to route BMC packets to the host.
> 
> To support that we are adding a new message that is invoked when we write
> the MACDA that will notify the firmware of updates from the host and allow
> it to sync up the TCAM configuration to match the one on the host side.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


