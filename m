Return-Path: <netdev+bounces-222350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82250B53F39
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAEE81BC4213
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6237519C54F;
	Thu, 11 Sep 2025 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/1VVDu2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C67A199BC
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757634418; cv=none; b=elvz5E0B4ekkKdd0z8VoZP36SLRxkVRwpiRgweLRQP/uG+Ioqu8w5Q2DOirvhWfrEEBRtkijmHQK8PD3bzyMQr+NCLHG5Ds0aWUXDBET5bw8U0Izej4JT2DObt3R1q/jxazP+UavDdJEJdJEr51QI86yUTSMkci6qYMA34Y3Uq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757634418; c=relaxed/simple;
	bh=vwoV5LpC7HHWDsTmf0jPmTYQc8UZTbPVuFnCgvd07qI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feznZMEVFtCb2Q2M5VBzstY//al3yJmHUWJrh+mc4vvA8zxiOKNPGTF+9X+zNXsmxzog/VBJP0vFwJsjS/8/kSL6GmcgHRuGwtYjnROXKYA/eHxog+eQmsx0hWoqed7wJV5f+wZvEPpSsgYj1RueHmXfTMKPRF5+8zaFyMOBDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/1VVDu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DE0C4CEF0;
	Thu, 11 Sep 2025 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757634417;
	bh=vwoV5LpC7HHWDsTmf0jPmTYQc8UZTbPVuFnCgvd07qI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k/1VVDu22CiqsWxVvGIxUYcWevQPf2mWqqXRcqV0JB5D60YFxZ9OKQd6mQNQte9cS
	 ObK0dICuXsJOxef2z/YV0TooDW++nPteunxJtneZv/baa2V4kPaiXe+u0O60d/swnv
	 bgB87u4hUIJjiJi1cz16xlIVM7A8CSS0HPOwvXk8v9r0B0yOXX8sxUCS8o82Ms/xvR
	 JZmzp+SJkGHkPGoCRei8WxpC+pkoAFBfyS+b5g10/65NchTeK+J0KRbIyl4T4dUV0W
	 pex749kvZsYML51Or67XlJ341mIuVZvRIaNJKjUDTnbTlGSKemd7WiRKU15I1DiA9+
	 8OkUHxArOUi9A==
Date: Thu, 11 Sep 2025 16:46:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chen Yufeng <chenyufeng@iie.ac.cn>
Cc: horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: ipv4: Potential null pointer dereference in
 cipso_v4_parsetag_enum
Message-ID: <20250911164656.2f49f407@kernel.org>
In-Reply-To: <20250911135858.1203-1-chenyufeng@iie.ac.cn>
References: <20250911135858.1203-1-chenyufeng@iie.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 21:58:58 +0800 Chen Yufeng wrote:
> Fixes: 4b8feff251da ("netlabel: fix the horribly broken catmap functions")
> Fixes: ceba1832b1b2 ("calipso: Set the calipso socket label to match the secattr.")
> 

no empty lines between tags, please.

> Signed-off-by: Chen Yufeng <chenyufeng@iie.ac.cn>

You should keep the tags people already gave you on v1.
The patch hasn't changed.
-- 
pw-bot: cr

