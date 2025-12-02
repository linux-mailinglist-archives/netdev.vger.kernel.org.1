Return-Path: <netdev+bounces-243113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28758C99A59
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 01:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB23B3A3B69
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 00:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F382899;
	Tue,  2 Dec 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQeSKPz2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CCEACD
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764635125; cv=none; b=UivswHmcIhoUfeUVbAgbZgsAnWx2cLmc1rmz28wCzL68OofSkDO+MPfwIj50SYdOM/oMRlWMO/fXYIdUrje2ld8twPtIQugUjN5lQM7zNEEHphGGKYe9301xn5yKcfq5+IxSwLuIuWJIIzZMSdZVxQ2icCaFaix5KkgSEILQI1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764635125; c=relaxed/simple;
	bh=r0u3FTz8yxx8sgEL+iFMijS91BdU1TcFHpNR6PDy/as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0+d1D+RWnao0TbwnmJgph/tK4PyePcORp+njHe2Q+27yb61e7fg84xJfCdirb5059ErAmi7pKOPB3rFJeEUc2XdJJZ4oKLyJ5coJt6XMsOGh6TN/0TAlvCTZeTQfcWURHhr4KSHGDJii4UQd9yufEfpS56qgHogQAJWpkNsa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQeSKPz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3EEC4CEF1;
	Tue,  2 Dec 2025 00:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764635125;
	bh=r0u3FTz8yxx8sgEL+iFMijS91BdU1TcFHpNR6PDy/as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uQeSKPz2/CdFHN7t64OkwvFOX1m946HDI+2ZEi0KDmRqWXywaQwlZ/lRpPQR0JzK9
	 zn2m7lv3NRH6WeR5d8H5WtPeuzlIz63AYDHDCFsbpvLM6OwW/f/WJ8TrtZ5gkuXXLN
	 qaI+zuv94/3zLma/kjq634qAbcobYasfhy/jXcG1dI6VxHjawYefhdXuRE088jS1cz
	 uVXnCmllps/lWGEUQqEQnwmcss1LfXdT4+hHVxbM+sRTAmS0+1EUPqWyTRjv3UcH23
	 AEYbC5tQSbi7srfAnVH7KCHMGamFrpemoEtpWgA0n31XQrTcHQ3ihNvPouvrizx3+J
	 ifTt6zASunZ2A==
Date: Mon, 1 Dec 2025 16:25:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, Cong Wang
 <cwang@multikernel.io>
Subject: Re: [Patch net v5 4/9] net_sched: Prevent using netem duplication
 in non-initial user namespace
Message-ID: <20251201162524.18c919fd@kernel.org>
In-Reply-To: <20251126195244.88124-5-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
	<20251126195244.88124-5-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 11:52:39 -0800 Cong Wang wrote:
> The netem qdisc has a known security issue with packet duplication
> that makes it unsafe to use in unprivileged contexts. While netem
> typically requires CAP_NET_ADMIN to load, users with "root" privileges
> inside a user namespace also have CAP_NET_ADMIN within that namespace,
> allowing them to potentially exploit this feature.
> 
> To address this, we need to restrict the netem duplication to only the
> initial user namespace.

What gives us the confidence that this won't break existing setups?
Pretty sure we use user ns at Meta, tho not sure if any of our
workloads uses both those and netem dup.

