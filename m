Return-Path: <netdev+bounces-199148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1FFADF2B9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1BF1BC18E6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1F42EE29C;
	Wed, 18 Jun 2025 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhljU//i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166F2ED86C
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264479; cv=none; b=ZpOilyGVRbdEu9SxVglScqsqjxL8Epjogb1cdMKhgVkZJ0nbC03oM8sT9CJT0oQPusR8/69GsQ4z7iSSnIevgGn1VN0r5R4jWemKy6YqGhKYRvI5k1QPLBjcsoWxyjVnYRBbBfRqwU1BaI0xqG1Mng0PAZ4CL0HEY/TNSnpXng4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264479; c=relaxed/simple;
	bh=ZpjxbXJilygZEa1TmasV23ZFXaekM2vT4FxyFQzIqSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s35j+G9zIPA33X0vvRXsADCfxeQY0j+/d6UC3e0ei//DuQwb7u13ecS0kpYJAzIbAekyam+vzli65bbNmM7kmMgHqinoQQpElur/gJEV0vuktRkAqpB3a9cduPk7toBa9kAoAwFyuQOC8TgkhtPSSu9n0P9ffGhag+SocefXLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhljU//i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D14C4CEE7;
	Wed, 18 Jun 2025 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750264477;
	bh=ZpjxbXJilygZEa1TmasV23ZFXaekM2vT4FxyFQzIqSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhljU//iM84aUdVU8yuWaVilgx676eJhlxkMjsp8ZvVPjIj7WnUaN6i85prBo4YTx
	 0KYOgkUCisvck2qI3pOpodE1buIr/eI9jDqIZBcLCHp1dI1vuFNMa7uNYBCZsWiuK6
	 hoRHmxH3bLyqdOcDjoDSld86OS3NtmVHFZHeUEFu60mOzVCYbwGMhOmnkUxJfkDQRH
	 B8MAd8VxIVuzhDMyJ+q0PO9wgeC3Sq4lsI2Y/0CRETbYYYb+re4CZpZmfc65yx//71
	 +k8EYCkImnaDRGNiuP6sq5vEpLXOV6QO518mY0nBGV972wP8xCU+37uYpGcaj5XrpJ
	 4Y2Z/Qqnoxoiw==
Date: Wed, 18 Jun 2025 17:34:33 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: airoha: Compute number of descriptors
 according to reserved memory size
Message-ID: <20250618163433.GR1699@horms.kernel.org>
References: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
 <20250618-airoha-hw-num-desc-v3-1-18a6487cd75e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618-airoha-hw-num-desc-v3-1-18a6487cd75e@kernel.org>

On Wed, Jun 18, 2025 at 09:48:04AM +0200, Lorenzo Bianconi wrote:
> In order to not exceed the reserved memory size for hwfd buffers,
> compute the number of hwfd buffers/descriptors according to the
> reserved memory size and the size of each hwfd buffer (2KB).
> 
> Fixes: 3a1ce9e3d01b ("net: airoha: Add the capability to allocate hwfd buffers via reserved-memory")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


