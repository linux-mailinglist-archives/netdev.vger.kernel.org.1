Return-Path: <netdev+bounces-108973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038592669A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966081F245A2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89517C9EE;
	Wed,  3 Jul 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/LNd2c1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7091170836;
	Wed,  3 Jul 2024 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026044; cv=none; b=dCusyjJ0M2INLcEHJGmZsPg/iyqhrPmAZzjGuqhm40XmIrVAspm6RRMziQituxoeAJH20s1nigtD7XaiuUdBMC9/Dg+ypqz1vMb83OOykdYDaqZYp+8rGtSegdrdmfNNY4s1d2AUIcVGTbbj5amcAKzKcUrQa8t4szA0A+52/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026044; c=relaxed/simple;
	bh=tDwsYKcr+DxOGBzzPRNV4hKeU0x0NOM/7htsqbQeYRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tC8p+0K6GIBAghRiuaGctVlh0zyMYEEaTExHjg8I0PgOt5ibkLtJre/R+fRs+CzOJA+fGjv/Ef86SLm6X32hz6NkXNQ6pQLAa/yqAJ5JIlz0S4XG4PJhQPFCuyqIulWgzfT7KRtvJPNAoP5S6T6cKSHiCDv9xFzM0lhn/75LzjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/LNd2c1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EAFC2BD10;
	Wed,  3 Jul 2024 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720026043;
	bh=tDwsYKcr+DxOGBzzPRNV4hKeU0x0NOM/7htsqbQeYRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/LNd2c1m6ogDTQR9f229MLa6Vkh3Xg2TeLdE+Uw6uszguh4Oyo8ahMdkeWalbG93
	 fXdmHl/iTaw3fW/QhD/x9IPIhdK5dqg8ttwQI/Vucgkza1pHBmgCy2pNNlwpHmotNP
	 Z/9Hjn9jG2ONJTBCZKxgvBORzZSNxrXSNGvffROGjdrHvlHpqXKzfJ+qSTz1X/RUY4
	 HaZx9SijelUhHYJuttrTY3VEcdQYutXJIj6Gn49dDAEE5YFGnpkwwpTkV2G5cK7/s0
	 eGeavu6cPz3WoZG0M1T09QYrIhNNWhXiUSLK7eMI4lzAlcOehtgtY9grItgs2ap9lz
	 SlawVvGZfXrXg==
Date: Wed, 3 Jul 2024 18:00:38 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
	rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v22 04/13] rtase: Implement the interrupt
 routine and rtase_poll
Message-ID: <20240703170038.GW598357@kernel.org>
References: <20240701115403.7087-1-justinlai0215@realtek.com>
 <20240701115403.7087-5-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701115403.7087-5-justinlai0215@realtek.com>

On Mon, Jul 01, 2024 at 07:53:54PM +0800, Justin Lai wrote:
> 1. Implement rtase_interrupt to handle txQ0/rxQ0, txQ4~txQ7 interrupts,
> and implement rtase_q_interrupt to handle txQ1/rxQ1, txQ2/rxQ2 and
> txQ3/rxQ3 interrupts.
> 2. Implement rtase_poll to call ring_handler to process the tx or
> rx packet of each ring. If the returned value is budget,it means that
> there is still work of a certain ring that has not yet been completed.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Reviewed-by: Simon Horman <horms@kernel.org>


