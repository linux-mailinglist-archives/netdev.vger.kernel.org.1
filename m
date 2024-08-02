Return-Path: <netdev+bounces-115173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A92B9455CA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD171C20FAB
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F954A19;
	Fri,  2 Aug 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9JaZtRR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394777F6;
	Fri,  2 Aug 2024 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722559800; cv=none; b=TNukTq6mnql8HaQ1FCXIcvgQ6ixAafXO8UnZpi3zaCQ0KzIvXwtp++V1FeWZ1L1jFFT9DNK5d4aG41tMbK5+DY0Jl1W2/dZwBWCu0Fmd8K6gDi7TZn0ebnWYatKa+9/BrOu3WWWM+Iv0xsyahip6j0tR4GKdPP3ZXXJaferAiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722559800; c=relaxed/simple;
	bh=KDh88CM/3k3OQw1jbFFfcO9VCi4zV1K5bivUVdqboCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RmBifFh7gteLWaABBi1dfgQAKYDCW6qqUqRKrjgSXJwNynKhzLDpddeKlJrgkHKipbumI1PghbvSGPagqf7ZGcjKfQ3pZZS0rmcv9Vnl8HVAcQEhMytjxEkuISct5V9WhD3KtE1nuqOuwHjJ4K7O1VE27tZj+IAa0MnM2g3Pa/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9JaZtRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5B3C32786;
	Fri,  2 Aug 2024 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722559799;
	bh=KDh88CM/3k3OQw1jbFFfcO9VCi4zV1K5bivUVdqboCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9JaZtRRO3lk8bVi5zXLWSpc1BDSwu+NKx0+zE9Z2mqPHJB8VMVQlSobinCD0A8HR
	 2zE5db67HuwCICcvwhGhXAsRcnnNGLhoUdlDuIzrHWWrte1TuEPCZuxuP1x5IWXV7R
	 S0sl2EcX1gJ/ySiy9ZzImSuK6FyJFGO75HtNL8coz+X4UH62VnLOOR5GxELcgC9Z5o
	 wm/52ULFIGSn2I+h7uLSPt02y+b3yOzfpFfQaBFi/pJyh0G8Z42MsFH8IXdIcG/NOi
	 tj2p9z05faxiht68yXvW0exSfc60qQudu876ExZKq2qSLlNbkoDmX1TaQiNLa6OIof
	 ilyH0RUgaeELg==
Date: Thu, 1 Aug 2024 17:49:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net] team: fix possible deadlock in
 team_port_change_check
Message-ID: <20240801174958.050db514@kernel.org>
In-Reply-To: <CAO9qdTHJKMzOTRJB_N1VPjh2=Z=qLkpzu8eL5mcAr6hnFfiHXQ@mail.gmail.com>
References: <20240801111842.50031-1-aha310510@gmail.com>
	<20240801072842.69b0cc57@kernel.org>
	<CAO9qdTHJKMzOTRJB_N1VPjh2=Z=qLkpzu8eL5mcAr6hnFfiHXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 07:51:19 +0900 Jeongjun Park wrote:
> > You didn't even run this thru checkpatch, let alone the fact that its
> > reimplementing nested locks (or trying to) :(
> >
> > Some of the syzbot reports are not fixed because they are either hard
> > or because there is a long standing disagreement on how to solve them.
> > Please keep that in mind.  
> 
> Okay, but I have a question. Is it true that team devices can also be
> protected through rtnl? As far as I know, rtnl only protects net_device,
> so I didn't think about removing the lock for team->lock.

Yes, but I think that gets us into the "long standing disagreement"
territory :) You may be able to find previous attempt to remove
team->lock in the mailing list archive.

