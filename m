Return-Path: <netdev+bounces-103029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD2906045
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CC61F21E29
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088578F62;
	Thu, 13 Jun 2024 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7QvzyXD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92B44404
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718240912; cv=none; b=s+LmfrTRCG/34AICUMR/nC2g3SSBrjZYNm0yq0JP409bKHHAa3nfpa3MN+CutUBqRuRFI16rZ+6yrVOXGO1GdK6Kvy3Doe+bjqlE0EsXUbQI7J7fmtjpo3dORtv2KEx5Mkx7Y6aJz4bc2PsfT/RVXIeaNCwggGqBBVXXg4peQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718240912; c=relaxed/simple;
	bh=vWcy6KMuC4Dp9rgaLfuSgJZWH/S1TG4fXrK505LJpHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROrcWJGj54LtHW69Ys4PsnrljPoyPLg97NSKUWPF24g54yR5A5uSkCVVxMaH5HSc6TbnFOqav3FW5uWkA8uUwMa9D3L4AXGIcaaYpbo054UQnzjaUwxOH8pemjygnnrm2+4LyiAuavffnYtVPoSTxTYGG+2gaOgGaDcqdN3Bi4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7QvzyXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250BAC116B1;
	Thu, 13 Jun 2024 01:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718240912;
	bh=vWcy6KMuC4Dp9rgaLfuSgJZWH/S1TG4fXrK505LJpHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7QvzyXDB3Z6H8zLHn6o4UXtI909BNKPDY54fecGDy1wr76SKLGK6eahpEd9KUBtd
	 h62Pw/WEK1HiFx573SQcGc/lNZ5nEVgkT5FlwWBuYCV7TTIXzfAtMPfYmOQJZPSNlq
	 57Cq+beP36BuZf6mwoyXYD5XzFvvT6OB5KwJvhu1VktNMSv0+hh31RuAHHf2EPxEED
	 7Xm8I9QwtjAjnyBWBE/QI2vKyrSseiMf0EeKpatWo8h5xNCQ+BW274c1uVGX+pLnWd
	 tu2cIuDPnEZ68aG7MsbOdJX8KdIiVOebXjoR7Ej1WFjrEUpPvvPGPbOBlnYAX1dMST
	 NAQtPnnYXcsVQ==
Date: Wed, 12 Jun 2024 18:08:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH net-next 3/8] ionic: add private workqueue per-device
Message-ID: <20240612180831.4b22d81b@kernel.org>
In-Reply-To: <20240610230706.34883-4-shannon.nelson@amd.com>
References: <20240610230706.34883-1-shannon.nelson@amd.com>
	<20240610230706.34883-4-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 16:07:01 -0700 Shannon Nelson wrote:
> Instead of using the system's default workqueue,
> add a private workqueue for the device to use for
> its little jobs.

little jobs little point of having your own wq, no?
At this point of reading the series its a bit unclear why 
the wq separation is needed.

