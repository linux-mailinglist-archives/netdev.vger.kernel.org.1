Return-Path: <netdev+bounces-251213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD20D3B526
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EC4A300252B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028EC33A008;
	Mon, 19 Jan 2026 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPwXglRY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E9C32AADA;
	Mon, 19 Jan 2026 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768845947; cv=none; b=BJ/F/HOfYtvHCCXMJ5TIp1HGmJlOHneSiL9ILvbb0LStlpmgnrf5P2FxSoohWBghEAPo3nzTbBaYIWaM0DAwFoEtwLPR4RnyPPiPqcKy7UxdR/+r0UhQgba6u/dFpiaONtkiyfpeF1aLitDVjUPZzoDSII1lMbwJGGaUA4ZH630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768845947; c=relaxed/simple;
	bh=aqYVGTY83GGb7gI2sP/jjAIYkMZtYoayqVhNrke0epc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzpQIpnrcCheX/n2+GWflnLMWUBmmYljHfHeO7fcCsd+xyX7edKRDbbPTQ9wC2Y3LutdEKTFDodDFtsRGo1GrvhZgrqjy6tlrkSAxADf0xO05gQJ8AKOY1h7EaafDdCNQi+Kwca3iolbDnf3dnKuhF7+H80Re+DAWCXRWA1s9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPwXglRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB508C116C6;
	Mon, 19 Jan 2026 18:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768845947;
	bh=aqYVGTY83GGb7gI2sP/jjAIYkMZtYoayqVhNrke0epc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UPwXglRYGW+YVXWumph+UlKzRxTM6xehLs/Fx9FcoHNfqdUOx5bA4RHbREc0cc3Hw
	 av/6uIYzKwwczDLG/HO8dgGEEvSB0WSH80F8AwN+Pqp3EZqGaZdj0UxYQI4oct8lKh
	 qjSYOlEG2QjSnRHL94ySQ+EBd/7GCnDpFk0+n3PbpDvtA/T6Aa9TTVa01Jq2Y7JYUk
	 8Hqol4dDBqQlIfW6nmhX+TtznEUoVrVF0rkzn4Tv9Ycnkwfeh0k4OUIl9DJ/Xvkm4O
	 RGttat8PGHdA04G283G/ctO3aB5Jwc8yFNy0hx16EJtGBdxnPkHadNASdABwy/VPUY
	 KI1lCL1GMIg2w==
Date: Mon, 19 Jan 2026 10:05:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, Faith
 <faith@zellic.io>, Pumpkin Chang <pumpkin@devco.re>, Marc Dionne
 <marc.dionne@auristor.com>, Nir Ohfeld <niro@wiz.io>, Willy Tarreau
 <w@1wt.eu>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, security@kernel.org, stable@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rxrpc: Fix recvmsg() unconditional requeue
Message-ID: <20260119100545.3460fe32@kernel.org>
In-Reply-To: <aW5JVspgbtaAHl-v@horms.kernel.org>
References: <95163.1768428203@warthog.procyon.org.uk>
	<aW5JVspgbtaAHl-v@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 15:10:14 +0000 Simon Horman wrote:
> If you need to re-spin for some other reason then please
> fix the line above so only tabs are used for indentation
> (a leading space seems to have sneaked in somehow).

Fixed when applying, thanks!

