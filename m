Return-Path: <netdev+bounces-102775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 205A0904907
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA331C20D1A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E565244;
	Wed, 12 Jun 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u77b6X5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6855CAC;
	Wed, 12 Jun 2024 02:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159600; cv=none; b=h30mSPzsG3SFpun60tNqmIaslRdV9ywoBDOmTksNBQ+F3ayLvXalQCK/QLFW6X3P3XaDF/+hfOUfS4b2CqLuSsVgAnnUI5Lm5GKFEBdz8slOeaJbNOyYUcG+JDOaZ26FNa0pwxEZfV+gb3G63fI1H2dBKw64pEkEl/Z3W9yFtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159600; c=relaxed/simple;
	bh=kyes9Q6OW55u/G4qVbFNbUbSoCjYV4ury2VRteKhvpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFADrqbKIplRnGMUXNbbrdlY/XSOaImCHuAEBVdlsOmKzrOpSyhI77x3ed8vKWg3V9h3vDaD1SOmrD12z7+v3bVJnUwHdIaEgPHi7PJfoGVgnFxLP0vJBJxQlyGt4GmS0th1HWn6cs32huYzXfrXFYwIyTL+X/64/yOx4h/lExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u77b6X5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D923FC2BD10;
	Wed, 12 Jun 2024 02:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718159600;
	bh=kyes9Q6OW55u/G4qVbFNbUbSoCjYV4ury2VRteKhvpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u77b6X5J4EA+OH7/Hs6+vovIZ2FmEltyPjR4nXOEAUAwnsU2EhCn5jhwvqt2BMM4A
	 scQvOHAcJ+pGH6WlGXq7AYhr6Rc4/wBgedfneDZ0/GT8Nn1s3RJZmObYBglpmXUKzb
	 TT28sNtb+fTTOsXuMPmdwew4nkp1afg51wj+r39BVOQzTfSlBSf3djx5rFj2YgB7BI
	 X/i/OYN0AynKTolYrQDL5Dca/z+B46btNpo1MLKV8UVoAP0OAgdJ71ky1p7jbe4o+M
	 2kp8YTq3WGBOEV+E2uDDOT41sI5X9y75RTaBIgyOr/HsHq0QrdrlRBWO4htslt+r86
	 Bf3Y8qUJtoEFg==
Date: Tue, 11 Jun 2024 19:33:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v0] net: mvpp2: use slab_build_skb for oversized frames
Message-ID: <20240611193318.5ed8003a@kernel.org>
In-Reply-To: <20240610035300.2366893-1-aryan.srivastava@alliedtelesis.co.nz>
References: <20240610035300.2366893-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 15:53:00 +1200 Aryan Srivastava wrote:
> Setting frag_size to 0 to indicate kmalloc has been deprecated,
> use slab_build_skb directly.

Makes sense but please repost with a Fixes tag added.
Presumably pointing at the commit which started rejecting 0-length frag
from build_skb().
-- 
pw-bot: cr

