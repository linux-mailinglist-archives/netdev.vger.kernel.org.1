Return-Path: <netdev+bounces-83469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD589267D
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 22:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B2D1F25153
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 21:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638413CC60;
	Fri, 29 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+8dykE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AC28DCA;
	Fri, 29 Mar 2024 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749319; cv=none; b=XVQFfHeE9c0xnyYx07Syowd5TeLXf3pto5rmG1SsHR7H+7AOzfy4pspo9LNKbgLlZFu9KQybTmplG3h69Cegz7JISgOhrER2TsLV7W3vzMOiXj2onDyVxSLJsB/Qki+wTDKdSxSYjsLsMCEiRZOGxrKZplOoqofXF/YJUuJMwiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749319; c=relaxed/simple;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIQ99dvb6UMV/aWTov9pUyTkMiTogmsGmcvwczu67NkrjPWL8dg5sp9t1PCUVSj5xTeqZ7n4cIap9pbON1zNasJv3lQ0K72dJFPSLEOA5XhVLMjRS30kIGcFqD5niDdQ4EzDBrWDioiwpKdq1Sr9iUGnZUWvslbiA8ACObaUw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+8dykE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6F4C433C7;
	Fri, 29 Mar 2024 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749319;
	bh=+poyNpseyrz9Eoa77T92yhDQwuECGmxB30jUzIAKH98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i+8dykE3YQdY+53+8POC4U17NyrlajsaBHru/9ULCn8ZmHHgjv6YhubjUAVssnGn7
	 9gdfmdlrdeqSQsdEs+TqJXpADkQZZWLiOO7dIaOZAI7dbu8yKWvYHv6WrRT6ZFQrHx
	 D/I4ma82Tn/VN/p7+hO9u5INnF4+b8tIolpHEl+k6HT9IOMlPWENg0c8cYK4L74bN1
	 22isDn6kmwlgOHnzWF08arFawoiHlUdA+oSLOonYtrVg5dFp6q4KgleAb+oSYoBcyL
	 DbMiAYDpwjVwkCZeC4eL0eUpVpoM7rVsfxekupwlZuXqR+EUguXEzifK4bFgeg2yRW
	 Scvby6W1H5WyA==
Date: Fri, 29 Mar 2024 14:55:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chintan Vankar <c-vankar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Roger Quadros
 <rogerq@kernel.org>, Richard Cochran <richardcochran@gmail.com>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool:
 Update rx_filters for CPSW's timestamping capability
Message-ID: <20240329145517.7b46a15a@kernel.org>
In-Reply-To: <20240327054234.1906957-3-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
	<20240327054234.1906957-3-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 11:12:34 +0530 Chintan Vankar wrote:
> Update supported hwtstamp_rx_filters values for CPSW's timestamping
> capability.

Is there a reason this is not part of the previous patch?

