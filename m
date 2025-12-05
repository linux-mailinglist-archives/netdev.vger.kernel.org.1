Return-Path: <netdev+bounces-243686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4DDCA5DBC
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 02:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 246DE303544B
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 01:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA3219301;
	Fri,  5 Dec 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvCRUhE4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4930D1B4223
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 01:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764899510; cv=none; b=TdWAr1HaWfbKx+uSDOmr4wwTK3a5CTZuLWvCJVzw7ZDxWnXXxELIvocsDjFl4zy9gssNBoOgYK4Wk71zcSbwWkZbJYVHAkesqRD5zCFjEwp0kgRPpM2xj+re14+C5YE8Yt4PfsA32xWX+6D+YjJTbh6MX6QzMIHwb499RiW1HsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764899510; c=relaxed/simple;
	bh=sKh7ACLjMjQtVuiTyjntM342EI8O9YcjrBWtL5K0Ou8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVNCCIagT44habHLUPukYLofjGJ6qnttjovGC5HA7OK2BtQ4gWe9D5PdxqWJ20oqWXbmMkZt/agiH/uQuVDJ49j43eROJskslNNA1mIm2U3OucZLaUO9w6/PclPTLJV666bWyXlxfkIOajgDW3GeS9gpsWnLi2NzppSn/l29fXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvCRUhE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A4DC4CEFB;
	Fri,  5 Dec 2025 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764899509;
	bh=sKh7ACLjMjQtVuiTyjntM342EI8O9YcjrBWtL5K0Ou8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dvCRUhE4cHp8jX4hjL7MrcKx+G/eDwKRqqbfP+yt0xwK282dAeQVkVLguW4qM3Kwe
	 tNZe0rV1mcebu3UjlH00h3WRgBdW88mLIaTeeyitTIRxe2KQotLBhn/NRvy9PoY9PO
	 YfrvVQssy3G6KbMQPjo8mDMGVUp2nTAhq2O9oT/L/FukZ6WDXvjGBx9fv4Lw0fSvhc
	 jFKYbTr0icmubOJPfqii/uQKXL/XLPuZKytqgPp7pGN4DPrQIxLEepuCLasHQPCzTS
	 q/IN+5MbpRe4CDrswQSV5wXN9+QuBTTydwNwXxnWygCZN2LHdPJihzmJxZP9o5Pkk4
	 Q/+LngI7aVRdA==
Date: Thu, 4 Dec 2025 17:51:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 2694439648@qq.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 hailong.fan@siengine.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: Modify the judgment condition of
 "tx_avail" from 1 to 2
Message-ID: <20251204175148.5a5cc065@kernel.org>
In-Reply-To: <tencent_639FC431D959DA3E8FC007985FC88EA5A90A@qq.com>
References: <tencent_639FC431D959DA3E8FC007985FC88EA5A90A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Dec 2025 09:31:52 +0800 2694439648@qq.com wrote:
> -	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
> +	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 2))) {

Please add a constant for "(MAX_SKB_FRAGS + 2)" and a comment next to
it explaining why the literal 2 is used.

