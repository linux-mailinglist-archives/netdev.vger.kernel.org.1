Return-Path: <netdev+bounces-231924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADFDBFEB4D
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58FD94EA83A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8451DFFD;
	Thu, 23 Oct 2025 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5xWq/On"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92180EEAB;
	Thu, 23 Oct 2025 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761178180; cv=none; b=iYFMdCszg7GXavEpaY+AL+EL3YTSwPV2s5HBXUrrrNZ+ZFpZanvDn+aTlGPXjWU1/sSwMW/E45RMruQCZlzuIPC9Wwkh7GburjVTHLr8MR8q7tkaw2lkVTdJ3/wQyafvG9rM0H1Tho6KXp87LWhUzq6MTzWXnO0+x7lhwrMUK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761178180; c=relaxed/simple;
	bh=SPnrZ6pXq3uCIz1GD5ICqGWvmRNq3OAdoFlRfs9S6Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Akf34vtD31YYrznOK60wZOGBJV2YYoyEfK8GRiFw5MVeQ9LmY8hGc0ihosskcJMpGlZQWSWoRNMahk/T1S7TLmZYwl3GdEMIijPrleQuGDnNpRRJJ5b11jx8AZTFQvI3+pQW69W55SdNVDlMcA8hxaeKFj4utgY/7eejO+PnYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5xWq/On; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B01AC4CEE7;
	Thu, 23 Oct 2025 00:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761178180;
	bh=SPnrZ6pXq3uCIz1GD5ICqGWvmRNq3OAdoFlRfs9S6Ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T5xWq/Onj5dJ7WlQPLqGCyWWTrnTCCjFJzbO/vsvJAmrhkuuWcXkjD53GTY5nQY+N
	 pc8eT3ZSexIegpd1mz9POsw3KXfLb7Ute0WKN2Qfz/c/5cb5Yu/cfZuveV3B7o7fNl
	 oDUU9CjfbQk8rZdrB/gW+NECFEc8uzWRL3RIU/L3tzsZI3qMRtx1g404on6px7sk8Z
	 ZareRjSkaIxWYFpEMVUS5lLKIT1u1lNXfKPeSaJxHjffV/ljH1AgSV/Fnah0YlWh69
	 qe8nBtcqLzgZHYk3kYLBWVQTwey9UtT71YY0B/9rz53n2eCVN09Lq2LLnEOZ3unjnZ
	 uR/tX6gEZIPcA==
Date: Wed, 22 Oct 2025 17:09:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <davthompson@nvidia.com>, <edumazet@google.com>, <hkallweit1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] mlxbf_gige: report unknown speed and duplex
 when link is down
Message-ID: <20251022170938.3a9a618e@kernel.org>
In-Reply-To: <20251022170825.1108218-1-cbabroski@nvidia.com>
References: <20251017155402.35750413@kernel.org>
	<20251022170825.1108218-1-cbabroski@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 13:08:25 -0400 Chris Babroski wrote:
> Hi Jakub,
> 
> Thank you for pointing 60f887b1290b out - this commit resolves
> the issue and our patch is no longer needed. Please disregard.

Lucky timing :) Thanks for confirming

