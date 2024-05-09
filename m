Return-Path: <netdev+bounces-94897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74A78C0F70
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37161C21759
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361114B95A;
	Thu,  9 May 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiXh2rjx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7E14B091
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256932; cv=none; b=mP32dKUehVWFk8n7AxP/jRN6QhQG5TdXUvTqGRMpDX0vqlCm8tEZX9rIrvoRNIhXeyb/Gi2+qXOqQsdiceiUKORDda9jyAudeKr8rb97Um+dFEfDSuikI6DHF6+aWY+s1Wz9ok/Fv58CkhaU9D+VocdNpO4itAWz46v3i3mpCWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256932; c=relaxed/simple;
	bh=f1GWrio1ONxxh6G4NN+qw1af8Ljsw1qrTwTO/cMT/bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fU/OB2ECwLq0IWnLlaaa5mwqc2ss9gJocT+ZzLAFQgdT5umstaZ7ZcAPXIor0uHkeSVx7mfbTSggoZb5BfmCivFwzwhOXyyAYvVAKeFfWPkbG1jlTsvYoxUU3bKBxpdpDIbNql1AN2uVkJpayzdhDUYQO/XRjZ1swW45Q1eZzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiXh2rjx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00276C116B1;
	Thu,  9 May 2024 12:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715256931;
	bh=f1GWrio1ONxxh6G4NN+qw1af8Ljsw1qrTwTO/cMT/bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FiXh2rjxtNFPYyEOcznpXLSqYCADP0u4j3iBmU61Z1PufAf4r7eSlFB7dAt50Ua2g
	 jfecJiIYtWnxJXJOtJYRvbXi+OgcKBPjJByKl0Q6eJzM7C70kmT6zKfF0nZHuB+T0Z
	 yZYVskeG7c9vJlFvKkIx6kE4eJ8fJ/M05APPjxW3hR9Z4s6KIgfT1AlUdE0WO0lgcu
	 wKO3DuBE4mtUV3SJ68p6R5jfGQAJwkRabjHIkcSAGc4n/CUX8rhxox58nqehqGTm4G
	 7sGRvSTFbNRS8awVSj/RTWDZmQ9+lI2k1QTuF/bvvHU4MPPXnote5AjMK3rdYWWsDS
	 3VsZxfaqdxBVA==
Date: Thu, 9 May 2024 13:15:27 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 04/12] gtp: add IPv6 support
Message-ID: <20240509121527.GN1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-5-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-5-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:43AM +0200, Pablo Neira Ayuso wrote:
> Add new iflink attributes to configure in-kernel UDP listener socket
> address: IFLA_GTP_LOCAL and IFLA_GTP_LOCAL6. If none of these attributes
> are specified, default is still to IPv4 INADDR_ANY for backward
> compatibility.
> 
> Add new attributes to set up family and IPv6 address of GTP tunnels:
> GTPA_FAMILY, GTPA_PEER_ADDR6 and GTPA_MS_ADDR6. If no GTPA_FAMILY is
> specified, AF_INET is assumed for backward compatibility.
> 
> setsockopt IPV6_ADDRFORM allows to downgrade socket from IPv6 to IPv4
> after socket is bound. Assumption is that socket listener that is
> attached to the gtp device needs to be either IPv4 or IPv6. Therefore,
> GTP socket listener does not allow for IPv4-mapped-IPv6 listener.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


