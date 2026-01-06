Return-Path: <netdev+bounces-247496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D2CFB505
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CEDA30133B4
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD922A4FE;
	Tue,  6 Jan 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDJW00s3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA414126C02
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740535; cv=none; b=Y8vxNjpd5QRodoPij8ZfIjsxurIncUoZJqjTVyg/ji6OXLHqsuSxuBUcwcgIe4260dZJx0zlwf70/QSBl2mm0gz8CzArYtzqaOBAi5K19df51FnKV7k+ta7bhe94Mc6xODzsnFGsynM34WJLi4rrZUOmXz4ktiIEABAVz7ibnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740535; c=relaxed/simple;
	bh=5LUs+6G8z+ZR20ZNfLVBfY6bcs4XjEBEeR9iiVww/78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p84LYg62ezNKjmFOmadvdYeMJxlTdWIpRpIFfWCNLbUqqu4WF0rjeRnfpy1iAMrKToRrLUfazeqn0kNsxd4fk15HTLgQgBGo1WUZ/zMNo1gV8JNQjUMiz0aZY/eFcjxeN6JszewZcW1wKVIQfHavUsOfdxfeho5BI+N7vSTcV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDJW00s3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2956C116C6;
	Tue,  6 Jan 2026 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767740534;
	bh=5LUs+6G8z+ZR20ZNfLVBfY6bcs4XjEBEeR9iiVww/78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDJW00s3nxJpZl3Rylte3NSOyAiLQJX/9uOMdjR6P7JaKNARUr/h2QvtinsqmK3TS
	 kBIoVtaybYiEd3T37crTTF7ESBYi93zBxC2CrisoZfMfOlvIc1SExsl4aeWtM5K1Or
	 KXQ0u78+msGNu457CJ9eq7UEAkofPhC5lVB07By7gMR4/0A+NsYNg67R+AYoRRtkEv
	 wKoQtr5Edh5jLueumnEiWD0biQmXtL0BdSkSlnP8V0QNBjE+SxWU7M2JZzi9Pfp7JX
	 VIEvD04i7uPQv0OCmRYULEauz7aLZ9UHgzrbexOK+QGkp0J0vJzgSbq+w5UcyDy2b7
	 Ge38nWENm7n1g==
Date: Tue, 6 Jan 2026 15:02:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Message-ID: <20260106150213.18d064c5@kernel.org>
In-Reply-To: <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
References: <20260105114732.140719-1-mahdifrmx@gmail.com>
	<20260105175406.3bd4f862@kernel.org>
	<CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 09:41:04 +0330 Mahdi Faramarzpour wrote:
> > You must not submit more than one version of a patch within a 24h
> > period.  
> Hi Jakub and sorry for the noise, didn't know that. Is there any way to check
> my patch against all patchwork checks ,specially the AI-reviewer
> before submitting it?

Unfortunately we don't have sufficient funds to open up the access to
AI reviews. But we are just using the public review prompts from Chris
Mason https://lwn.net/Articles/1041694/ so if you have Gemini / Claude
etc. access you can run them "locally".

