Return-Path: <netdev+bounces-179214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16DA7B261
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 01:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B542C18972B5
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CCC1C7008;
	Thu,  3 Apr 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYtB5aCD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641E1A5BB3;
	Thu,  3 Apr 2025 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722504; cv=none; b=Wvt1LxcFwuik3TtONj/nylB5xbq+W6tunl/oVGBEXSufqs/ALRfDzZ3m0dUuPwbddGq6MLkAaQO8kSr+2ddlO8v5ic31XNBbZp4uWgi9Yeu2W9O5BhXvjfhvt+etcGb7p4s4DTIPvgsqEkl77zqJc5lZFasLT+l0pOCfLZQvViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722504; c=relaxed/simple;
	bh=9AQsIS3/HzI0J/t7IV4zCEylmibMx5ZKcZ4pESOO44g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTTHSgB9dj5uO9lJkgBpEqex3AKkIztM6c1zwGlMPDL0fkgPkWjNfDvItBRmymyDZbbUP7bQYbkAanYAySYGuAF2WQnneVwedAJS2M5zdPePwJ72h+aK03VPj1Bcnf8z3Rz/0b0F0gBBvLev6TC5dSumPPgtaJP8OlolVm9jD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYtB5aCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88AEC4CEE3;
	Thu,  3 Apr 2025 23:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743722504;
	bh=9AQsIS3/HzI0J/t7IV4zCEylmibMx5ZKcZ4pESOO44g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYtB5aCDIgOgGNAaC+s/BfG0KjOGj7Tye3tz49Y/RRfs3htaEVPDbr7P5ftamxnYJ
	 8U0Es9BgXHxEYSPaAqjRhCYij7vYmSA8ik2GToA3bvNxgqrWQN+GqlycdzXyJIEDrY
	 gujDIsd0SC1FvGO3m5zWkMdv3dKNOvWc2O9uzkl1Bs5wMEFZexv64106L5sMr/mYO5
	 U4OXdU6+wvj+8iWgSiYHQSCPPgN/XA3IXmM6ZkYAeT1jviN8yCcb3hrfJkoGy1pByf
	 EuzupUvr7ALI2x4naCXn8tn0S5ojUeQpHL3qjzK1eI/XdO63YYQParnqez+IECW7fG
	 ZcKAGUd/V+/BA==
Date: Thu, 3 Apr 2025 16:21:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julian Vetter <julian@outer-limits.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Louis Peens <louis.peens@corigine.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shannon Nelson <shannon.nelson@amd.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Caleb Sander Mateos <csander@purestorage.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, oss-drivers@corigine.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove __get_unaligned_cpu32 from netronome drivers
Message-ID: <20250403162142.03148506@kernel.org>
In-Reply-To: <20250403090743.3878309-1-julian@outer-limits.org>
References: <20250403090743.3878309-1-julian@outer-limits.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Apr 2025 11:07:43 +0200 Julian Vetter wrote:
> Subject: [PATCH] Remove __get_unaligned_cpu32 from netronome drivers

Since the merge window is still ongoing we don't accept code cleanups:
https://netdev.bots.linux.dev/net-next.html

Could you repost on Monday with the right subject prefix?

eth: nfp: remove __get_unaligned_cpu32 from netronome drivers
-- 
pw-bot: defer

