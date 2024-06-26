Return-Path: <netdev+bounces-106927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E691824F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558A21F23AAC
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A58181B8F;
	Wed, 26 Jun 2024 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA4Wowjf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540648825
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408355; cv=none; b=jFwHdXcJb2arBfsKpjKQLpEGsWMDraRlcmYEvad6MS6atTU8IfL9fh7tR1n6/MUEb1vGYDb26iM3JYFWtPpVrzhtgAFPrs33K8uKOccWYLpuhCcm3P5TSoxyWS3Nf9z5x+PYouzq7PJO7LZkfVtUDWx2Z5iBxNlqsY0CxVTs54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408355; c=relaxed/simple;
	bh=dYC/NauUX0HrUmRVOwBe+JsQLEOm5qmaoDPIA6Arr1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5Js7u8TCZkwFma56Woiqj3WSxBoc+VMw/owatkQz/Rn3xoWAGkCgtQ9Ju1Dk/gzy3O0ERe6JuZzUkG6OybDBAYl6f34oY/gQZSONIYsp6Q4YFGf2RdSR2FJupqcPBOHmFhy3pMP0g3sKlthQMMyFluk/RICgi6BhVm6KqYuaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA4Wowjf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630C6C32789;
	Wed, 26 Jun 2024 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719408354;
	bh=dYC/NauUX0HrUmRVOwBe+JsQLEOm5qmaoDPIA6Arr1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LA4Wowjf2P570LtEBfvJCBOGYr/EZrTLdYmcNZypirDgKu4x5o4f4lXNqahsGwGEA
	 iazRG+KoTQ7gX+1wPx4RVHc6ZJ88H37JYO+F4TKR6YDwREyy9PmLFFQmDdustdDgef
	 rv3dwTK8p35k5mEvax/hvZk6C4Qm9GvQrmAs4fBcrKtfcSjBvG58WHvZTyEodQM6c8
	 RgiyyDM0bWddPf3kONkOHAY3huph0FZbB8yb0UzEDPxvq213Ny+OGGci3zkZjBpqoo
	 UGG7UgIWdKruclN4etXJx9dcLkCXfCMj/xa3qJzydeC/bcLF7RJvjhqMkGC4TXSzh2
	 etk6RILmTqmVw==
Date: Wed, 26 Jun 2024 06:25:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, horms@kernel.org, Tristram.Ha@microchip.com,
 Arun.Ramadoss@microchip.com
Subject: Re: [PATCH net v8 0/3] Handle new Microchip KSZ 9897 Errata
Message-ID: <20240626062553.2f7e5512@kernel.org>
In-Reply-To: <df1d8095-93ad-4b79-a614-321df475b64c@savoirfairelinux.com>
References: <20240625160520.358945-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
	<20240625184712.710a4337@kernel.org>
	<df1d8095-93ad-4b79-a614-321df475b64c@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 09:28:16 +0200 Enguerrand de Ribaucourt wrote:
> Ok, I can do an extra commit then?

Sure, but if it's cosmetic (no functional changes) please wait until
Friday and target net-next.

