Return-Path: <netdev+bounces-70064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CAD84D7DD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB341C21E6D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 02:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335981E;
	Thu,  8 Feb 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRCqr+Oq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804501E885
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359847; cv=none; b=cpezeLdWSOW+gLtRLI2BzmGvtQUy4u2MPY6p7fTo65wFlUtiyn5VpXwnvK8c80vmsaRvJnXNuf1sjcfDbgx4fSMMAAJeKPg8AbUK5tZOtX+/4OPa2NgQSekDa9QHRLEUFHhqGtxemvhYxXcXNXmVowue4sUZPcCzbygjuNTWu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359847; c=relaxed/simple;
	bh=DdyX3bM664IIVUZuIaaPxikZ/RoBb6AVv83T16FG5/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGq4C0QGwtC+zj/xLP6+kZxHhY4//odqyXPcJ7u41dSwCHgYYQo8G/bwrLNiRT37jYHfcS6wz97I1iVZhedUaUi/yr4vINmwFh9kacwl95ceUlg2xPmnwQr+0JEztnGtR1/xMoqcf7mvsfC8CpSaOptTLnpgr4CxAwmuGxB3iOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRCqr+Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB461C433F1;
	Thu,  8 Feb 2024 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707359847;
	bh=DdyX3bM664IIVUZuIaaPxikZ/RoBb6AVv83T16FG5/0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vRCqr+OqnvIUjPTW4qXqmHWN0XKhynmTTV/+jU/A4T05Pk6ZVnE82qIQ8B3VgCwmA
	 5o/xpOhrwib9dn9eKilSGQ1Xg8UWbnWdMaAnFw60KvzoK49OBiZpwcYDj+sN8fc+vH
	 VGPTJdQ0JMTDlfYKgcfeCVLdVvOwGIstrsiowhTjQPneg7WObnO8muk19jrECJtWKQ
	 ahLSJCE2LnU8vNHN5eANEHupsLyaoKOsE5urKcZ8VvSQlvqiCAc1/hBQxVtAvLh8AL
	 a+apPW+t/+gM4gD8IrfTw8axgs34W2AKxxIgiEY25L4b2se0CM8aNbyl6cLlM08R92
	 9E+20jDqavuqQ==
Date: Wed, 7 Feb 2024 18:37:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
 manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
 simon.horman@corigine.com, edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com,
 drc@linux.vnet.ibm.com, abdhalee@in.ibm.com
Subject: Re: [PATCH v7 1/2] net/bnx2x: Prevent access to a freed page in
 page_pool
Message-ID: <20240207183725.4ab9c941@kernel.org>
In-Reply-To: <90238577e00a7a996767b84769b5e03ef840b13a.1706804455.git.thinhtr@linux.vnet.ibm.com>
References: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
	<90238577e00a7a996767b84769b5e03ef840b13a.1706804455.git.thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Feb 2024 11:48:21 -0600 Thinh Tran wrote:
> Verify page pool allocations before freeing.

Could you add an example stack trace or explain how the crash can occur?
Could you add a Fixes tag?

