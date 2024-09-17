Return-Path: <netdev+bounces-128692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B487697B010
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 14:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A031C22539
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 12:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D0416F824;
	Tue, 17 Sep 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fTXFL85G"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EC943150;
	Tue, 17 Sep 2024 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726575799; cv=none; b=igDA+BYVcYrKSyHbLH9RMzJVZxSo3A4i8xKmiFTORiQouOHlR5XA+9mp/QotlbfDS2RwbXT91YiNxNPNHio+bhKUCkUKcVzUUnpUpYWBILAY5yRHm2ZO5AecMrxIKodahn2gKESL/prxRlGbA8SLHHuoHL1GosvfpKp8ru0IMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726575799; c=relaxed/simple;
	bh=s01KuvTCbDVR8WKC3ckvpZ8pP6ILxVGR4xqqntSdNlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=duyG7X1P/yJONxqqGtb78Us5ID834EpMF2RU0I6snauvk1me4UGXEOT/c3Uz0g8OpB1CzsYqYuJMEScf4W6caYda7E9VYqNlcil3npNWEHe+2ylUHCS8tMRIsZ/ikbDrm9Lf0Y6yrOqUNeGyVV+3yxBeJ8d/8vrMVZaXhI3MQ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fTXFL85G; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1726575793;
	bh=l5b1A67OP/Y2uiKoarqWCTGMlz/bG3WrxVqC/iAu3zk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fTXFL85GDr5HeFSDPu9Y+CkmW/P0RtSfgEjjMiSdGzNozY6cY6Awj9UbZQKIM4xVK
	 oHB7mD9cc/nK2Al08TLCS3WY5I9NP+f2zH1Y1/7oGZoYqCmFvfvyxuXYHHdm0dtOCY
	 x1wUxpPgTp4QvAVsRc2ydkSq26k1z/ISa7Z/3g3vE6oumDWN65hlICdxIn/+NZ9XDz
	 WxmCtw8oadH1bZBzztHde+vBtDr80vypqGqWA/4HcdVJgAJqkk2a8GvcnIhku3PQeG
	 vQhBzxDO6Bw1ghmXha0BVZ54teVQW1hhXw8jLgnv+gRQB3B1UD19/4dr8rTdicEM1s
	 hcXtr6zMCWQ0A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X7LXd3z57z4xVV;
	Tue, 17 Sep 2024 22:23:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: christophe.leroy@csgroup.eu, segher@kernel.crashing.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, almasrymina@google.com, kuba@kernel.org
In-Reply-To: <20240916120510.2017749-1-mpe@ellerman.id.au>
References: <20240916120510.2017749-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/atomic: Use YZ constraints for DS-form instructions
Message-Id: <172657576225.2195991.10894874767253579579.b4-ty@ellerman.id.au>
Date: Tue, 17 Sep 2024 22:22:42 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 22:05:10 +1000, Michael Ellerman wrote:
> The 'ld' and 'std' instructions require a 4-byte aligned displacement
> because they are DS-form instructions. But the "m" asm constraint
> doesn't enforce that.
> 
> That can lead to build errors if the compiler chooses a non-aligned
> displacement, as seen with GCC 14:
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/atomic: Use YZ constraints for DS-form instructions
      https://git.kernel.org/powerpc/c/39190ac7cff1fd15135fa8e658030d9646fdb5f2

cheers

