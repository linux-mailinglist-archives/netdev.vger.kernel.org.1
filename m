Return-Path: <netdev+bounces-191681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC8ABCB4B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 01:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FD11B668EC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2843421D595;
	Mon, 19 May 2025 23:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+xevFd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF920F09B;
	Mon, 19 May 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747696191; cv=none; b=gBWqGpnrmSgQuwfa7gtyVebdntbeGMAifI6yun/9CUwkbEzr1PDo7gZKlWNFEsSY44ADatiLzkEE38Y63kzRWH57e4KfNXk4Y7i+rbSYARO/CpDL00YyTTS9w722wV2sfINokoYWcCioyg+Izh+r8b3H3P1rqPR2W4++/GteZgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747696191; c=relaxed/simple;
	bh=uD2sJcWJzSBAxSVffBZOg+c5a3LYBLA4Ibl9Blyocy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spuk0FhJYBXK49kYeJNuGfePkwFJyd2uadqiMkgnxNGIcEoyP6pHzHrHc/Xx8I/a09pAUJX4T6cmLn1azBQAdVLAqCN6L08dtwiVtLCTy4vK/807NyYwKLjyzPria8eXv5tK3VX4Ok+ZK4N0r0tId3zjahOijHeZIq60OIueqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+xevFd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DF3C4CEE4;
	Mon, 19 May 2025 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747696190;
	bh=uD2sJcWJzSBAxSVffBZOg+c5a3LYBLA4Ibl9Blyocy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c+xevFd+eaLim0vjvC4Zx7ltMTWO+6OZRfCbNPJP67nHknZnK9Vs9Elskt2+U3Uf8
	 lLI7T9uuVINQVDIopftjYVbXAjtSl3dnVvOhj7U70qSd5SuHfRAybxenvH88G/m0HY
	 rR46I/wYSApgx2+6I9/dxYvtxwWOBJqecexItolHbRFyzmBARengCN6T9Sv8xL1zWo
	 ETDMp9upn8Sy4QvdDkdJ7F264U2h7kPIlqi7IlB4DroQf48XhSKz6IUGudYtg6cd8z
	 cjYbxpVAFUKZ4JBNZjF5pqaryauqjROYIBJoR/KqrlQ6RexWPXas3KZtBUXvBTqkWL
	 GV5M7Q0aBkiyQ==
Date: Mon, 19 May 2025 16:09:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 1/1] queue_api: reduce risk of name
 collision over txq
Message-ID: <20250519160949.08b29b84@kernel.org>
In-Reply-To: <95b60d218f004308486d92ed17c8cc6f28bac09d.1747559621.git.gur.stavi@huawei.com>
References: <cover.1747559621.git.gur.stavi@huawei.com>
	<95b60d218f004308486d92ed17c8cc6f28bac09d.1747559621.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 May 2025 13:00:54 +0300 Gur Stavi wrote:
> Rename local variable in macros from txq to _txq.
> When macro parameter get_desc is expended it is likely to have a txq
> token that refers to a different txq variable at the caller's site.
> 
> Signed-off-by: Gur Stavi <gur.stavi@huawei.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

