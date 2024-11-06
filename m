Return-Path: <netdev+bounces-142197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABA79BDBC5
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0FC1F222A9
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51E118E740;
	Wed,  6 Nov 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkgvcUzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F71418E368;
	Wed,  6 Nov 2024 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730858699; cv=none; b=pQcMSljaQ3b+nICxBkqAzOShd+8LOI7P4z5dyI/1NoiA8/Co4m2fy+RhsalnlyEWnHkaPa9EYqWnu9tHZwfFXG7e2bdG1atRcrL/TeOoziz7Te8ZL/S+J753feUz4o2z0f53q1AdzYOo/WBdhQA0MXZYIZFJzpiKgkcnv9yT628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730858699; c=relaxed/simple;
	bh=FzSRliyBhUYrj6Xp5rBHLlRQ8OTE+NIc4/G8yoAocPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAaPeMa3un7P/NB5J1GChoXalHOMyzP4yn4iJUWWiGzaSVSA2l4NLaOjKHzQdtYXoRrnSlxJQZGhJLF8pOeE6SnbbIKRVsRSXaXu+7UMPxylKg55odbTFpvvC0l5StnQoczH3nLohIJRtpF9AshSIJGR1VYuYgdSBVdro4NADlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkgvcUzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDD0C4CECF;
	Wed,  6 Nov 2024 02:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730858699;
	bh=FzSRliyBhUYrj6Xp5rBHLlRQ8OTE+NIc4/G8yoAocPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PkgvcUzU/joUyXRQhQLOzEbKQTtWFsqPH9F4Dit9tMYhQNULXAYYtjz1Vc4yqTqKt
	 Kt+POgKZp2V5K/leBqsvY7Qp1Ez4T6d6352Tdsi0aJjIZPwAYDEuYKgOJUJzyB4c5k
	 L/ReicyiQlUSSfQ5wZIPJA5GErw4lHIo1Y2rcnjirpQ5EU72iI0O1LNXA5V3tBtKt8
	 kBwdFJfLa7PnundZhoVqTJWRflS4SNqzLAboQBEMqeNyPAdBUHdoXxTZDKVqfERImU
	 iG4/q8C1SExmZ3Xj7aBSYy/P/Jzl55juAjl8Ld8wXQUCOsyMgCCdsh9GxhQywftrfk
	 o0nO27KrMmkLA==
Date: Tue, 5 Nov 2024 18:04:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 1/2] ptp: add control over HW timestamp
 latch point
Message-ID: <20241105180457.01c54f15@kernel.org>
In-Reply-To: <20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
	<20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Nov 2024 02:07:55 +0100 Arkadiusz Kubalewski wrote:
> +What:		/sys/class/ptp/ptp<N>/ts_point
> +Date:		October 2024
> +Contact:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> +Description:
> +		This file provides control over the point in time in
> +		which the HW timestamp is latched. As specified in IEEE
> +		802.3cx, the latch point can be either at the beginning
> +		or after the end of Start of Frame Delimiter (SFD).
> +		Value "1" means the timestamp is latched at the
> +		beginning of the SFD. Value "2" means that timestamp is
> +		latched after the end of SFD.

Richard has the final say but IMO packet timestamping config does not
belong to the PHC, rather ndo_hwtstamp_set.

