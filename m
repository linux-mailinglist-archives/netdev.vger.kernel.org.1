Return-Path: <netdev+bounces-142147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF29BDA6E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA42845A2
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB26BFCA;
	Wed,  6 Nov 2024 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICov8Tlr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD45B05E
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853553; cv=none; b=rgCQHXljMh/M7E/DgLHM4WB8NWbVlelP6bVyNhWMBJLF/IOJyRiL8jwrB+NCWS1fYEiRNe7GQi/Aseq3YjU9TflETLATVKH/nG9hkV8cJyPENgfHSv8ATfWjxPhjMk2jejN5GJE7O2m6iolpvrv4UeAuRSD8wZcyl7WuRzbjqSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853553; c=relaxed/simple;
	bh=GQm8jPeeDcVMG+sCBL83od5GeOteLXOWM/T9bai1TkM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZ9htS41UpPWuZPh0gU8tgd/rwwKq4aitAaBbUXe1KqS4oOTanrjevdr8UUAv3YM1dhiqGafNBKkcVQ87PsGfT95kVUFEIKPdQlJwDHjKDFYIA/vFbq/wXGTD1na3t2cWi5ODPfCeQQioK/LprNHjv/VEFnQm++likLXqs/xYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICov8Tlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5ECC4CECF;
	Wed,  6 Nov 2024 00:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853552;
	bh=GQm8jPeeDcVMG+sCBL83od5GeOteLXOWM/T9bai1TkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ICov8Tlruvlnw5xegQv4fFyqPK/+/oT8F+zfoVQhBNzQEOsZuSDQXF4DXe8zMtmbN
	 YXm9IQI5Ldyjv+8xvyVR2aiXLMb9mSseMvMZWA+qIsVhWWKFcrdZ4X3+4j2BcCtnUE
	 oOrCUCRy4J8Dzru3OpXMJEwqHXfkrd0m1hC1a3bSRl5KQ6cgAOujSLAHgDXV6evgZH
	 bRqgohU2DFgkZlwxJRtLB5U69Uo2kAzRcsrqONpM18SodFRxPoYXqUvFTYEnjnBwpQ
	 Csc4JkL/+AD5sotrQlIYAaGM41bQL4xfcmXQ3qhnanVPm38ERJHpT9DcYoRCsWYKq3
	 oBSTzPTb05TKw==
Date: Tue, 5 Nov 2024 16:39:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
 <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct
 rtnl_link_ops.
Message-ID: <20241105163911.55d1bf60@kernel.org>
In-Reply-To: <20241105020514.41963-4-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
	<20241105020514.41963-4-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 18:05:09 -0800 Kuniyuki Iwashima wrote:
> +	const unsigned char	peer_type;

technically netlink attr types are 14b wide or some such

