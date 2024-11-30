Return-Path: <netdev+bounces-147940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3424A9DF37E
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 23:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96C6281486
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4C1AB539;
	Sat, 30 Nov 2024 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOYkVJiZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35143130E27
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004859; cv=none; b=kwiqcHzytz0Ey+fKP0zyV9gmoNDgxv7Nc7OkQd3Fd8WAU9qLmVqvws915y7M2OfZ3QMpOTfoiNhG4hXFOrsg+P7KTKnZzCZdkNZnefAGTkPBIwTBor/HDoy9bn46SpAgXGDI+0jjkTG/+oVrQy8DHOVkBBXJoob1uFwV6IPme6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004859; c=relaxed/simple;
	bh=VhkLq8Mpr0l0TOWWS2sp196kYJ/UyI9Uo7p1e+vc3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT1P/9oqs4xsD0+dosC6nySnOKJ/pA29+QvvbVISQOB1ciE0tAJPqodAEFMSJdARkOwol5MmHUEG+3OMhO2LzohwAWm8gjDw8IBzelNeN8vzpH3XnSBdt7BuV9nIQE0nBLBvazXAILsci416tTuO+52SRscjlQWk4Wij6qkj81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOYkVJiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C82C4CECC;
	Sat, 30 Nov 2024 22:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733004857;
	bh=VhkLq8Mpr0l0TOWWS2sp196kYJ/UyI9Uo7p1e+vc3/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nOYkVJiZRrkdrNpmS9X+vVOaqG46Pc7B18X6sO0OUFXXsb07R7Egv6BTV9UFM7wzh
	 GM8Uix1rC41KgWYlWr4qUfi+nG0/xNYDbsmCg+DVZCfOiXwFjUb5hwq5qwfALXH4a8
	 OL6waJoomriNl16AIp+D4TuFTc4fDaTSxbguG5Yg6yvUAiBb6mEAdFFXkLpDx7kPwj
	 /f7pHGS2jTfPiL5GNcoBGKJsfKqM5Ltr/FXtytDFzXR9QBQE7/N3YWirnoA4SFXV/O
	 BnpRbS9rDSbjVN0vVvfO8DbihiGZ6+xX0uc9wKG5JeqqiQf1XVk/TTg0aet6hb+ix6
	 Mivig5XSy9ITw==
Date: Sat, 30 Nov 2024 14:14:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>, Andy Gospodarek
 <andrew.gospodarek@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Message-ID: <20241130141416.3c703eb5@kernel.org>
In-Reply-To: <c84c5177-2d1b-467f-805b-5cb979edc30a@davidwei.uk>
References: <20241127223855.3496785-1-dw@davidwei.uk>
	<20241127223855.3496785-4-dw@davidwei.uk>
	<CAOBf=muU_fTz-qN=BvNFoGT+h8pykmWe0WX-7tw0ska=hEk=og@mail.gmail.com>
	<c84c5177-2d1b-467f-805b-5cb979edc30a@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 16:43:40 -0800 David Wei wrote:
> > Just curious, why is this check needed everywhere? Is there a case
> > where the 2 page pools can be the same ? I thought either there is a
> > page_pool for the header frags or none at all ?  
> 
> Yes, frags are always allocated now from head_pool, which is by default
> the same as page_pool.
> 
> If bnxt_separate_head_pool() then they are different.

Let's factor it out? We have 3 copies.

