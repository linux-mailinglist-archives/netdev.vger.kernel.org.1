Return-Path: <netdev+bounces-242107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F7C8C65D
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22B1A3435B5
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13D02F12DF;
	Wed, 26 Nov 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgDDGwM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBC25785D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201579; cv=none; b=PBIJL2TSr7ozWqhaz3FObxV4aQp1ubHXnl3gJ9yzWWJthen8shbQb3chMrBnPIgD8XNRrFQwC3j+VSNGQogGd+0JchhoZm9hjCTqTOLSDL4Cqi6kL4p8wfrfi+pibDixNKhDa1CRLaRYkACprbRXPYsAPwEbfNwKcoun1YfIFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201579; c=relaxed/simple;
	bh=XXesTwQBQxQbkts5VRZ6Fay9AF3QN7VI+NHyBf4U1P4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQFuFfFHt0uBdzqwF8zAxbG4GdcmdHfXnXLJ8rGunuw+FmbwJerP8mqZIlTd7WwJ7PK3Xx/h0eTS9doyLvQ1keWHaqVzZF/wCjRFsr1ArB1PNFaw7jP4HF0QTUHLDmwHbrGgxoRER4Sf+xlIdMEsxpWdk+6oOHCVRv5xMRoFazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgDDGwM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21CFC116B1;
	Wed, 26 Nov 2025 23:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764201579;
	bh=XXesTwQBQxQbkts5VRZ6Fay9AF3QN7VI+NHyBf4U1P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hgDDGwM4o+6cSFa/jYz0n5oNQWucs/hx8tOVqThQAO2WipxL+zZgRiYT0j6GFc3BM
	 J5onfLozskLEX+4BAhfROnapDV80PC3WP7tShdOHoBeYY7u+dsIyVAORcE4hZAkOTn
	 q6GyXJxRn12qr2cOZTVj7ddiM8T26TPOxIjiq2lmXifwtV4Q505YK4D5vdAUNALIOZ
	 539oQ2ZmsVfgFKFDEV6W4BW+UNgQ0XOlNme7RJZ87HgfUCqwq4bKr5my+AtlDWbsfU
	 q2ZWGAbsWRTjBe4NeTh8IedGFWrrcFlwavcQ8W4v3dVLPQsiT1PblDtvQc7a3zRTvR
	 p9AKkgtmMQr2A==
Date: Wed, 26 Nov 2025 15:59:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 00/10] geneve: introduce double tunnel GSO/GRO
Message-ID: <20251126155937.05a8c280@kernel.org>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 17:11:05 +0100 Paolo Abeni wrote:
> This is the [belated] incarnation of topic discussed in the last Neconf
> [1].

You mentioned off-list that the ai-reported issues here are real, so:
pw-bot: cr

