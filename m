Return-Path: <netdev+bounces-149945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11029E8304
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7D7165727
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 01:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39ABEEA6;
	Sun,  8 Dec 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBK1aOu2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7EB2F36;
	Sun,  8 Dec 2024 01:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733622271; cv=none; b=SsvHEwLULsm/HquGvICuxdJpUseuyKKbG2vBzTcOFnRYAodUk2NM0hfbN0DVKC39ZnXxEwEPLQKq86DFKntcTzAFOxt86Ip/XdC8g8i1NYgvPVu8g7MG/5y/TwECneLzgIe/N0Rzm1TN2jwYLnj/UNBgfVwsgpwvYja4yRvq3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733622271; c=relaxed/simple;
	bh=Z9/yk9mNKyO5ehIGsfDTf7lqVP+bp0nTu0O3jk+SUyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXNuiWXH/lJTD5RIQb7jHaV2IRsth5iZnVMH5aHBO5KA+Wtnm9SV1XO4gVrt4z21qsypDVUjc5/suVHSOqOVy8JARpT/piv7wi/eRH4kfymHoztpDdxNK/NCN7v5iJ3d24AjU5Bnfy1/yrL7EDxyu6f5gbXFd67jTd7s22Xq8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBK1aOu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF45CC4CECD;
	Sun,  8 Dec 2024 01:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733622271;
	bh=Z9/yk9mNKyO5ehIGsfDTf7lqVP+bp0nTu0O3jk+SUyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBK1aOu2N3LIvfYhBJcpsjXtOjJf3p/4RbZxzY32ehe5yDe0ho/9m5Y6fSgANYBdm
	 Lq1V0SBMt9IRU9X4uS9r562fFFwATyX9w1AcYd9pDRocySxD+zgGVpj33tvokiX2Mi
	 SSHIfeD/X74KwBT6see15e0thKoceC7bxFcC3d9EdET9++ir66ibu0+ZsGKNvEbm63
	 eHQlHjalfdfM6dKli3i9Kx2qUOm3GH7xGP46cx0IrgFLotKBiy0Su/pC/YbxiQ0w0u
	 JsR3pZbzTfv4Y+jXiTqEVLOU9J/PQpAcW+V9Rh87N/hq6Jh2MAusNgdsNVU83NEJyh
	 jQZ4Vj4uNh1CA==
Date: Sat, 7 Dec 2024 17:44:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stas Sergeev <stsp2@yandex.ru>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tun: fix group permission check
Message-ID: <20241207174429.06d7528f@kernel.org>
In-Reply-To: <20241207174400.6acdd88f@kernel.org>
References: <20241205073614.294773-1-stsp2@yandex.ru>
	<20241207174400.6acdd88f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Dec 2024 17:44:00 -0800 Jakub Kicinski wrote:
> On Thu,  5 Dec 2024 10:36:14 +0300 Stas Sergeev wrote:
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> > 
> > CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>  
> 
> Please avoid empty lines in the future.

I mean empty lines between tags, to be clear

