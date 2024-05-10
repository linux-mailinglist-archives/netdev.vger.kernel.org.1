Return-Path: <netdev+bounces-95430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B408C2390
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7A40B25279
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F4916F911;
	Fri, 10 May 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDz3vdfl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250A16D4E5;
	Fri, 10 May 2024 11:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340557; cv=none; b=hRlvYvMHK101buf6wSKqU+pT8jTFn2eRKkDsuuDQC9VLJmh/aSprVosEpxlpPXL8Y2APDWqUwVPu7JhZRGihPVeZz0jpRKQnSEXGnxCB+1M7TUOUgQSJtaTTN3xZTm/xRusBXoS+wGJ9L6u5nMmFsHudnoLmpVIyhRMN9+ULpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340557; c=relaxed/simple;
	bh=6xyclrqH4lk4q0fRmet06/KlrMnIvP24KED31yvid7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG9Ejphghb/NVpk+tGCFo25gSw+F9kWCCADVUTfmv3/QT/Zb61izq5kksCG8s8uupkGlZtzRL3Bwq4Vi6ORXUveoXQBxxReZzF5P2EWBKoM8vObyNUmY6Je48GI/i8yI7+uB7W+7vEhTO7swuCtUdmGDIFGOC7cZ3z7hM3vNZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDz3vdfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312FAC113CC;
	Fri, 10 May 2024 11:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715340557;
	bh=6xyclrqH4lk4q0fRmet06/KlrMnIvP24KED31yvid7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDz3vdfllbdwfCvyLCrYMyAJOV2kxDdIvzQKcOB8MJ+ZJU+3wwDkmMwudymCPClcR
	 k3HoUuY0tnVBdJWpg1KOh5uXCKUfrv5k3P4yMnn7X+IMyHxXERT8UPUJCYY2wTn5Zg
	 Y3cBEMDgJ5OOXQTMQSawhfDVjRoayPXOsPQp2FHxP5ilpaTjYvsnG4GnmOatYhM39g
	 ztMVFKZ3WV1dhmbGQJw+uiDSNItOrChs752+Mw1+t9lKzMhcDaUmhn+ajD73M4zP32
	 EHUji1kOjMrui8W+V/vlg81g0xbLfPlmRM52IuefWjMDDTX63HCYqYHejptzntwA7d
	 5b06RA1ALQlHw==
Date: Fri, 10 May 2024 12:29:12 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v2 09/14] net: qede: use extack in
 qede_flow_parse_udp_v4()
Message-ID: <20240510112912.GL2347895@kernel.org>
References: <20240508143404.95901-1-ast@fiberby.net>
 <20240508143404.95901-10-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508143404.95901-10-ast@fiberby.net>

On Wed, May 08, 2024 at 02:33:57PM +0000, Asbjørn Sloth Tønnesen wrote:
> Convert qede_flow_parse_udp_v4() to take extack,
> and drop the edev argument.
> 
> Pass extack in call to qede_flow_parse_v4_common().
> 
> In call to qede_flow_parse_udp_v4(), use NULL as extack
> for now, until a subsequent patch makes extack available.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


