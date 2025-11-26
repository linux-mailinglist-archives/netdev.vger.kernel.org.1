Return-Path: <netdev+bounces-241982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 029EAC8B599
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40E1A4E69AE
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46CE278165;
	Wed, 26 Nov 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="sMJMDH3/"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A9224891
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764179556; cv=pass; b=J7Rhq8KN5MvhtbcOY6CIm8WBrQ+I9niKGIS1v2uTOD/VjNMrqNpCverw+n/vWOf4BrkLTdBa4g8roa5x6r0bnxy3Pc1Or+42kcHMiSdmdMler4l7Pfy1B/GryPOis+DrauOUsLYBHk6CsVW4qQxEUOJ3Tre/dF9oNV4V87a5lo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764179556; c=relaxed/simple;
	bh=DQfXxJQFcUC26jDmEqaHWrG8u+uw8iZVXVc/7oyWbDw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Jwr4sty5l+3a031MFcCigEsBuS6uORPDlNgkEGseSe4XrozOcK5vY7iRE6vT6J5ADXel4WQ4YEi+8HiqVLFEmBFqIC8SEWqsWJFICt13pw8ppwIuI/z3IA8S9K6e3jd6GMr6mHSxQ7EqI/bQdl5/586jcu6iZH1u+G/aTDkT3eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=sMJMDH3/; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764179513; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=W67ScUxM9k7QwECvzxRjqLPy+JdYBvrfEW3fJyvbyYuL3+vjAs4hBtq29VI0mH457WupfkHm31kWXhpICzrCNUNvsaV7/gDauJhrKOp++tMQkdL+e0k/GX8q6KZlLibPlhdVlWCyO6AxLuMkrvdOgNRTNK0QBoDEwxt6FBlTu0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764179513; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UvdVAR7bfnxhIVO3/JIl96qgNT5pcQ0u1Jxr0eWZVLA=; 
	b=dx6gQosB0tCwdWEKrtD+57OoYAQpD2ow+spIpTA4Nh7Fr69AJSfEUMCvrbyKu4cTwaaXJce8g00N/exliL+2xZwUgmXsUJK5G+lKlQHkWDmEqQDbG6wxLJ8gsVu+eKZ3BpjHBIUfcDaIXTdDOX3D9EVoUSYDPbLDewkvseRlEug=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764179513;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UvdVAR7bfnxhIVO3/JIl96qgNT5pcQ0u1Jxr0eWZVLA=;
	b=sMJMDH3/n6KIxghcWYumSlIJBF5+6/RsxHMaJ0MOVmeZMpjl2nje1cjQTEQ3YxfH
	n8KpMxwnC+TSOSBPm+6i9yv1e0BAfc0EQ8LYtyUhQilsEJRh4Lhj6wZUQw4FVjO4J0w
	c7nTVSl5ivVs/d0o0ukUALvuCWe5R/XMeZahJhAI=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 176417951113610.246620122537138; Wed, 26 Nov 2025 18:51:51 +0100 (CET)
Date: Wed, 26 Nov 2025 18:51:51 +0100
From: azey <me@azey.net>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "David Ahern" <dsahern@kernel.org>,
	"nicolasdichtel" <nicolas.dichtel@6wind.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
In-Reply-To: <20251124190044.22959874@kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b> <20251124190044.22959874@kernel.org>
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 2025-11-25 04:00:44 +0100  Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 24 Nov 2025 14:52:45 +0100 azey wrote:
> > Signed-off-by: azey <me@azey.net>
> 
> We need real/legal names because licenses are a legal matter.

Apart from this, are there any other issues with the patch?

I'd have no problems changing the sign-off if only just to get this
applied faster (as I said, I mostly prefer the alias since my real
name is not at all useful for contacting me, not that I "want to be
anonymous online" as you put it).

I still think the DCO docs agree with me, but my voice obviously isn't
worth much and I agree there's really no need to involve Linus/Greg.

