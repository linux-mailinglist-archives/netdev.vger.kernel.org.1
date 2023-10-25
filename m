Return-Path: <netdev+bounces-44188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740BD7D6E83
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C411C20C99
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89D628E27;
	Wed, 25 Oct 2023 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBxMYZrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9ED250E6
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42B3C433C8;
	Wed, 25 Oct 2023 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698243250;
	bh=u8Hb+8CBmmdXR1Qra0P9J+M1NhZnHM1zSoQDSKIkf+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FBxMYZrTnOu+I/bzIz/S2X3Xe36VpCOVt3hg8nsL2D4GTDB63LtkrugeFQpz7DZl+
	 AI1kUjP3apyN8JBjjK8IVo11Gv5VRBSxkn5X/3QjHF2eeJVIKwDv7XjiW++HfK4SrI
	 +Tc8MU3kIPwG/hT8w1YXEnztFfONJJVG48TXOATncsZ/scGB49/xYzFc6tWeLUqlGQ
	 NbOfymHXus9jGMODCz7oCaF519wB56yh6hnqSM4e8SpWs1yX0vOs7SUaB7YZ3vPBn/
	 fZjlI9pIWL5nmUkeZ6CdUXySUaS32LbmkByLGjoEKFhzEbjMDIcgeQQ7GTtCMQTAez
	 HncWaUKF/CsPw==
Date: Wed, 25 Oct 2023 07:14:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
 john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <20231025071408.3b33f733@kernel.org>
In-Reply-To: <ZTjteQgXWKXDqnos@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
	<ZTZ9H4aDB45RzrFD@hog>
	<120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
	<ZTjteQgXWKXDqnos@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 12:27:05 +0200 Sabrina Dubroca wrote:
> > My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and found
> > it was wrong. Do I need to make a new patch to fix the harmless bogus
> > pointer?  
> 
> I don't think that's necessary, but maybe it would avoid people trying
> to "fix" this code in the future. Jakub, WDYT?

No strong feelings, but personally I find checks for conditions which
cannot happen decrease the readability. Maybe a comment is better?

