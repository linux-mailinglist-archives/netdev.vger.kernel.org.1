Return-Path: <netdev+bounces-218880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3308AB3EF1C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10583B305C
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2F91DBB13;
	Mon,  1 Sep 2025 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgTKWPZu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A290C4409;
	Mon,  1 Sep 2025 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756994; cv=none; b=XJT5ousyFurZPYY15Rg1H5EdoYrCMROe3jtSUo9P2Aonk9MxVQXh0G+l3rNRg6JWCSdpQMzEYxmPcjbkWxUdRMDWYPaAlHsnyxDov+sgrU1hl5lIeCJyKOiJr5dI4mbWIm2GUEFqBKOnNPi2EzI5yV/cbsq/Prv33fyyntJPJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756994; c=relaxed/simple;
	bh=LgWWJpc4TzZgy7ej5NaLr9/zG0soOJqZdg2QxkgT0sI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPjPWwALF9L0rbD4U0iis5AxzAOm1Gc3DqC993+Xx3m/RZ0wBGbO0rtv6V1YvwuqUKxE+D6iNAXTKlqcogHwwJrXt+Y9kVJjf/o0QMxtv0dFCciIWUU3h/XwOtnpN/pLqWRzB+kc+PqFkXXvIto8WtrCrXzQA+YVEjf2YcEqIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgTKWPZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DEBC4CEF0;
	Mon,  1 Sep 2025 20:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756756993;
	bh=LgWWJpc4TzZgy7ej5NaLr9/zG0soOJqZdg2QxkgT0sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mgTKWPZu/Z51gqloH8vh+m/juPcPkZVxa6pFvFDFIraWCAJ/U92huoojGPr0uUAsY
	 PVX5by2VnqNSXK3HjTrani+U/gCYaPAAUgwuWJSGYjNBFINYBzPnibhJOrnB3u1rTF
	 cpsa+TCbJDJghoZIA3/O4vpiTnO02MX8G8U0/HOvs7ociJbECKWMmOKx6iiNHMGMnJ
	 VdPD4/47qEIgphPnKxMD442tpbCbRZY9z1crCzm3Vb3aRhC6sHu57ujLziJcSpkRms
	 jwSUFIlo+Pjthffh01N917aV9mYiHRsztSzLq9FPyY966FbdI5UeCFb1QYQhWKUTL2
	 RTjKh6w7DZV+A==
Date: Mon, 1 Sep 2025 13:03:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Konrad Leszczynski <konrad.leszczynski@intel.com>
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cezary.rojewski@intel.com, sebastian.basierski@intel.com, Karol Jurczenia
 <karol.jurczenia@intel.com>
Subject: Re: [PATCH net 3/3] net: stmmac: check if interface is running
 before TC block setup
Message-ID: <20250901130311.4b764fea@kernel.org>
In-Reply-To: <20250828100237.4076570-4-konrad.leszczynski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
	<20250828100237.4076570-4-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 12:02:37 +0200 Konrad Leszczynski wrote:
> If the interface is down before setting a TC block, the queues are already
> disabled and setup cannot proceed.

More context would be useful. What's the user-visible behavior before
and after? Can the device handle installing the filters while down? 
Is it just an issue of us restarting the queues when we shouldn't?
-- 
pw-bot: cr

