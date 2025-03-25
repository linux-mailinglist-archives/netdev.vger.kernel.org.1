Return-Path: <netdev+bounces-177575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBDA70A7F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3678173D14
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2E1EA7DD;
	Tue, 25 Mar 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDxFuYA5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8490B1CAA9C;
	Tue, 25 Mar 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742930793; cv=none; b=caaHe62QyGbQK1aAP/3h2TQ9ShpkxeQxt6aeX2bzmjDzKazeGKNuA2QPWF581j/XadPFs1XmVmbv38QRaIp7zTs7t7yEdX57dJj9bkn4TR9samWDPG/x9tMKdPy5s853+WIJ/ZRN00M/7SVCAGtnqHC2c38ejETdlUpX+NMWThw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742930793; c=relaxed/simple;
	bh=P0t6GPrTlNbQDEqFicxpL7N/NcAa95Ysf5ebwPVAgW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnELEwoo0/lPyBAfHSzsg7LLZdYUI8PGdbwm+HPA4r2DPa4R6HY9q/3l4n9kdXlRKbR8EacjYa//ognsXxrf46Pbl6McxqS/CpcYAAVJmr3W9itqsEg8z2KJKmEJ2QU3yhoab4yAhXTnPxCFt9nwXcvutE/rwST5BTQPSlLC2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDxFuYA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCAEC4CEE4;
	Tue, 25 Mar 2025 19:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742930793;
	bh=P0t6GPrTlNbQDEqFicxpL7N/NcAa95Ysf5ebwPVAgW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WDxFuYA5auI3iZSbleOgqROk6KxjGkOukDzO6W1IorNf2ZHM93w/ZvDLYlLxYHXpu
	 REenQ4+fv8CWbpYgjYNO8GZ771NRnPfdphMgv/EwueszO5JGQ+a4Gnj30YG/P5AvHX
	 tsgD6laVEbKbRPQbN5cOYQTjCf+9tPtZmF63edjZkyXmy0MzjfpNAT1AHaI+SFLQdU
	 Jjq1Lk5/oWet0WUCpIvU3a4kOLyOFr+Bd2HNLfvc7C4FafjRPGZ3PVUyHzD2rRc0rQ
	 Syl6Zck/6UCZ9xBUkGUs0uLO3o/lmmZGLI9OPJT91hpFhK/N20rVOu+K5YllriHbt8
	 iRJsVJUmRiIXg==
Date: Tue, 25 Mar 2025 12:26:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>, Mina Almasry
 <almasrymina@google.com>, Jason Xing <kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2] net: Fix the devmem sock opts and msgs for
 parisc
Message-ID: <20250325122625.4219638b@kernel.org>
In-Reply-To: <20250324074228.3139088-1-praan@google.com>
References: <20250324074228.3139088-1-praan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 07:42:27 +0000 Pranjal Shrivastava wrote:
> The UAPI change seems safe as there are currently no drivers that
> declare support for devmem TCP RX via PP_FLAG_ALLOW_UNREADABLE_NETMEM.

... that could possibly work on parisc.

