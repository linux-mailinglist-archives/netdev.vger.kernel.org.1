Return-Path: <netdev+bounces-114771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5049E94414E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C181B3097F
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13AB2BB10;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVzdaVfu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B90F28376
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722475244; cv=none; b=C7AWvHl1YFbGgLd92rNdcqGSYr9AchTFzKJ7Wj1EBcggsG20mgA4baFA6Yw3Xhsl5HWpq745o5W/8M0t0EkUQemRO2Z8yGjG4t1po1YpD81kjILeVv18mO6FkBJsDabwoTaQghJOoDaGJv87jfkZS/d4+7sjQblfiTZliBfFBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722475244; c=relaxed/simple;
	bh=MM+dsADRPwraAvCMwryOYCfHCnBl8sXMiDGIZhDhW/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QX6jTPUhk6MTq4kiAbfgTZFlegE3gLk1XN7jqM51t7QCpXFDiGGb4OaX9ruRVy/dK5VoXtYO2YhOoBhojdWm1euyPRAWuNQd44UXX9W0gk7+obSAznsAQw2PT7DYxqiMw0KQwLGTrpx4rnrzKAbJV+W42/cr/Da4IH3bVXKq/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVzdaVfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA49C116B1;
	Thu,  1 Aug 2024 01:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722475244;
	bh=MM+dsADRPwraAvCMwryOYCfHCnBl8sXMiDGIZhDhW/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aVzdaVfuTzhSstg+aVjtqtwZWbeiq9g06ijWRrKf+9OISSmJWtmfyEH2aDdMT3CEd
	 9+TRanrCFC8jO6aDNEDDXjYee8huXpQ5OH5jMw3KUm0Z7Y82+5f/+SAGiReiAVuIwX
	 PRc2omL1C5c+ubSY51WqBiA3eO8X0Bpkj2SN725GUf8osrFJbdOpX1mkkygKUiiRGR
	 Mq9toWGJRCOvMSQxA/o8F5tMhoUZMtkIlGXbT10b7sbxdnRpbZ/S37jX6bSzZrd1zI
	 LW+o/Aadrvxe+NW6yPV/TIIN/zZjK92bfA/AEBKfEaY7l6bWD7nXPK3guF2QePA0vX
	 5SoV14UeGA+OA==
Date: Wed, 31 Jul 2024 18:20:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ethtool: Don't check for NULL info in
 prepare_data callbacks
Message-ID: <20240731182043.51286ac6@kernel.org>
In-Reply-To: <20240731-prepare_data-null-check-v1-1-627f2320678f@kernel.org>
References: <20240731-prepare_data-null-check-v1-1-627f2320678f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 10:15:28 +0100 Simon Horman wrote:
> Since commit f946270d05c2 ("ethtool: netlink: always pass genl_info to
> .prepare_data") the info argument of prepare_data callbacks is never
> NULL. Remove checks present in callback implementations.
> 
> Link: https://lore.kernel.org/netdev/20240703121237.3f8b9125@kernel.org/
> Signed-off-by: Simon Horman <horms@kernel.org>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

