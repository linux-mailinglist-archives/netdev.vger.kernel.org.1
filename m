Return-Path: <netdev+bounces-155219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BCA0178C
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 01:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3341883E70
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 00:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F9F1BC4E;
	Sun,  5 Jan 2025 00:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggDk70iA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3D23CB
	for <netdev@vger.kernel.org>; Sun,  5 Jan 2025 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736038622; cv=none; b=aYrk4+XZvHQD/8793zN4jsFtkCmFjesvqHSNzORBSdhYwZBlLC37+vU1HB7W9OTaLsm9L4GllDE/WTlWRMnP9j4HsXDPouV+cSRaWZw3njQbzykuvqrQSehpCkpcP5zXYic1SRfklhx3Wj0fWsgPf4KLlvyMam/r2SuPTH6kgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736038622; c=relaxed/simple;
	bh=npO1mXcYD3egBC3YF271H3fwmqUHX+KAYtUQqoGHCDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr3XbCKGVqA498jZFxfmUIKsLTm8HvndSJqNBCYdzh4guSMouGy8YGhFj7pHPN+ZgXAuPrPDt6/OSsO1rely8ukpAdc3WPz3C12cUKXU7vll+PL6Z2Am3lbRAOQC1S+/QwnM+DCvcdsVl7JaGAolRqE7HgF1x6CpRmY4fGGNjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggDk70iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09091C4CED1;
	Sun,  5 Jan 2025 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736038621;
	bh=npO1mXcYD3egBC3YF271H3fwmqUHX+KAYtUQqoGHCDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ggDk70iA1Ob6VZrNJ1Gy2eJvQ8VDgqZdpshUjObYrc9lZL+No/Mz+yMaRtAAXZLhm
	 7RWprJdFEir2EUEXIyWxdmfsA9A12eHKgS1/zsP7FirTeHlCxPT8HaFUSaeE7zDpUC
	 8PCr/6/T2E43MT8M07zzz6UF8FQgNuKYL8F0baVJ5z1AWrUmGzAjZvkMROnRt5t7tt
	 mhvaOzmGmwLzcmVx7/CNgx4IwO/VC0yEzfdSS2RFi0iYGdAGfuveRTGvFTA89Emnjz
	 T84fEYySJKrWPeHabsPOtxfKvRECO/XYz4Yv4S2gTfhVIApi0hjKdYi/4aAsBOaOwJ
	 on3F91X0VXe8g==
Date: Sat, 4 Jan 2025 16:57:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.ne, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, kory.maincent@bootlin.com
Subject: Re: [PATCH][net-next] net: ethtool: Use hwprov under rcu_read_lock
Message-ID: <20250104165700.04915182@kernel.org>
In-Reply-To: <20250103013947.3332-1-lirongqing@baidu.com>
References: <20250103013947.3332-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  3 Jan 2025 09:39:47 +0800 Li RongQing wrote:
> hwprov should be protected by rcu_read_lock to prevent possible UAF

Looks like this patch did not make it to the archive or patchwork.
Could you please resend?

