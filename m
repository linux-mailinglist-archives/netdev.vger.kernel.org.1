Return-Path: <netdev+bounces-242598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117A5C927C4
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 16:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E973AD50C
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BD823E35B;
	Fri, 28 Nov 2025 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b="iEwPDHRM"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E7322FF22;
	Fri, 28 Nov 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345277; cv=pass; b=DtDH6reSzHrzAUF/ko6Cr8HzhC57FG79K3iEnN8Akz2UaoMIPUTXBVj74Al7HnZYCQLrbb0kkVw+l/kG9u/DU9bZXApkBzHR89ED91Ro5InKnolbxVFjzrUj7jzbe+v8CuO957taG+X4R0Nv+WkB5lOucTm6SL826E8nqaxUvoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345277; c=relaxed/simple;
	bh=UiX4iOz1Q9CUFmjh+i+ER0ijUCmT2bMplL0gAkaGrzY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fGTHcDsEdgDienXJhyh4IZCvvKL0pw9JFkQET3DlJnNO+4UnrwutZGomlNPC1jrYPYgLKGtRYXn/Mcr9miAVFE836/IwS7ohRT9wgj7iT2sjvD+0gggx4ot/Ll5XQwg8gjpVqTNWGPt65pZhq2a8k/eEvRhfPTK6CAkYtsQ4A5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net; spf=pass smtp.mailfrom=azey.net; dkim=pass (1024-bit key) header.d=azey.net header.i=me@azey.net header.b=iEwPDHRM; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=azey.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azey.net
ARC-Seal: i=1; a=rsa-sha256; t=1764345256; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Jd+4zQ5wRQIVnMQJLOdEbzn3o+jqBIc8YzwefSx8zbBThVHEPBSJvVV6eBi/M2X47GGTxEwq78+JWdYrUrmc3XoWBotNX76eK279/qS6oQd3pxRlsjxV2ZL9XgrramPPHgrvDwaPLKX4KFm3UCoJNFFaNb65jRMrD3HcD9BxeT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1764345256; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3FFuE1eqnnxDc9ibaMqCfzZxeG6544BVumyWTXiQi2A=; 
	b=iysVHmqf2VQluO+Sg5PvLNNh8mBlXdTiHc/5SwP7EzHu5bXpSq3AblxELij8tWEjHHqzWtSZsL7hKQ2yDw6TbK/1nqQPPVdyJmGoso9IibWCgrx3o9QUla6fNiDU0zta4KW+TkAuUlHoWNGJForl8133Y9r8cspa5CX+s4YNKA8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=azey.net;
	spf=pass  smtp.mailfrom=me@azey.net;
	dmarc=pass header.from=<me@azey.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764345256;
	s=zmail; d=azey.net; i=me@azey.net;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3FFuE1eqnnxDc9ibaMqCfzZxeG6544BVumyWTXiQi2A=;
	b=iEwPDHRM0hWyVLSZjmWwNLGb0YwJvv3DlwpGO5arfdvDRgvSRGF3A8jro1a+wjLX
	lGD/aeXyBJRWcMZz75Bh7yVScclcBW0gIDhhEN9ZfHDojCRiLw4AWHbgtagqj3cC/Ns
	fmbjlC+tGtRCWKTm5dSexjoNGt0Spzj3OXnimVtA=
Received: from mail.zoho.eu by mx.zoho.eu
	with SMTP id 1764345254702430.62621643153716; Fri, 28 Nov 2025 16:54:14 +0100 (CET)
Date: Fri, 28 Nov 2025 16:54:14 +0100
From: azey <me@azey.net>
To: "nicolasdichtel" <nicolas.dichtel@6wind.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "David Ahern" <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Eric Dumazet" <edumazet@google.com>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"netdev" <netdev@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19acb2c1318.fb2ad2c5200221.6191734529593487240@azey.net>
In-Reply-To: <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net> <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com> <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
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

> On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
>> doesn't allow this:

Hold on, I think I understand what you actually meant by this, sorry.
I got too focused on regressions from the discussion in v1, I'll make
a v3 of the patch that allows dev-only routes to be added via append.

