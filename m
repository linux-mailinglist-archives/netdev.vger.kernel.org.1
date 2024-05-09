Return-Path: <netdev+bounces-94904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1088C0F7C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9EF1C20BDC
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA814B946;
	Thu,  9 May 2024 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdneOt3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DC214B088
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715257069; cv=none; b=cj/ZrYRGlDaJqCB9tvA7Os9P4QF/Bsr4One0s9SNdgxKEnBaVqrWWss6jDe2SPOWsI6lEpwhFmlNjbbSnD5GtVSOk22u1bp0PIYAH5YcMQ9ZO6H35GXinI0iKF8r63x8yeMn5W/ovm3hHfpdlUETtD/KseaKOuimwhhL/ehbQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715257069; c=relaxed/simple;
	bh=H/taeFi+ttPXzJTYGRVgKvToEdN8fDPGk2tnGXZvffE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdzhU9qPIVTI+IZwxL8niF3AIX9QQAY9/oCheVIvnOgsZvQWgjVHkY+CTZJE1Z9OGjPQNT8eS/6tJgCnPXkDm3PT0CFcI02smw7qXIT0FLNC+ODNpidOIgIxHzrk5vmWWKDTOmDWzfwe3aeFeQCnwVrv7ra98s9oJLcoXZhDiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdneOt3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8335C116B1;
	Thu,  9 May 2024 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715257068;
	bh=H/taeFi+ttPXzJTYGRVgKvToEdN8fDPGk2tnGXZvffE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HdneOt3U1yb85tY+JSu4/3apxAQXiLVaAtxs3Y3wmZ/mvvjFZAuMWyMAkngvTLb2n
	 lPGzbyRxCkqklhfsH0JxH90mSTc9mTj1+bAXf6cmcpRL/9FAGFblV3WJmpqtcoi95C
	 CTXj/ifh9GGPXVhlwV/uWtBGRGdey+7yWks0uup4+/2jA0UYFt0T3ofIdGIvoxRCFC
	 iQpryqv4piWeMW4ydA2XbJfTXnmyW+O+EhLdf/UhaTvPCc1BhjdvD0bE5SctiIo43b
	 5jlAhcgxNqcZtPJZbqmWT5NPFyAz4RqahIFo2iZV9JkoaiCxSANKy/HBoLUdqNQQuY
	 c6RTxXbq3x9JA==
Date: Thu, 9 May 2024 13:17:44 +0100
From: Simon Horman <horms@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, laforge@osmocom.org,
	pespin@sysmocom.de, osmith@sysmocom.de
Subject: Re: [PATCH net-next,v3 10/12] gtp: add helper function to build GTP
 packets from an IPv6 packet
Message-ID: <20240509121744.GT1736038@kernel.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
 <20240506235251.3968262-11-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506235251.3968262-11-pablo@netfilter.org>

On Tue, May 07, 2024 at 01:52:49AM +0200, Pablo Neira Ayuso wrote:
> Add routine to attach an IPv6 route for the encapsulated packet, deal
> with Path MTU and push GTP header.
> 
> This helper function will be used to deal with IPv4-in-IPv6-GTP.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Reviewed-by: Simon Horman <horms@kernel.org>


