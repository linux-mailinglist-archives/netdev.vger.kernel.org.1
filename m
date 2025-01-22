Return-Path: <netdev+bounces-160434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055DA19B93
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 00:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0173ABFE3
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 23:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C98F1CAA86;
	Wed, 22 Jan 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdIauGde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F4A1C5D54
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589715; cv=none; b=hcJNz1Y0WtM0DEbfo/2bGml7xBvYiFQZ4JaMrZKpcgfAeIvnjMP+eLqCCxRahuRyIYPAahXNX2GHz8hFkYHqHv9GsP/wWsgfIU7W6J4N4d+4Ob4aI3/f+w0uEz9WIgWJof0V4sTHYFC+jz4KcgHNi+o1TwJkpyL/Om0q2AoRVqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589715; c=relaxed/simple;
	bh=V8naJHXqSshAemITgdngPF9mVqmx6BSFK5MYkruHqaY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cucIdb63HyWFZEud9lqsZ4LfQKKRUP7eXXps8lSFd1+BaBZveMjYUoWLuh6n4aT/85zWUfrH8JrQX+BLKav9BS3WN+gWYEUVg2k+Tm37923xfVxpreUh4brbbvmxDJc+opHXTnTuCsgC+g7jjfWWA55rtpoURSNsKEZZoQ0133k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdIauGde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C09BC4CED2;
	Wed, 22 Jan 2025 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737589714;
	bh=V8naJHXqSshAemITgdngPF9mVqmx6BSFK5MYkruHqaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DdIauGdewcL1G9qj68ZvgQOskDqXdvFKLSBGpcq2ol1MQUoHuq+GTKDevUxnU6vS7
	 9js/zM1HtrCf5CuuGV60ocnYcVAlWMIfpQ4GSc+QqxnVpO8wd82DlZXKU477ISbBeV
	 vHGtgQ2brvwt9O18s6RWD4Je7y5yA9l3EfKHKmhLngIFYdVwcVgt0JhcY1/XT0Bj12
	 7eian8/RIxd2xaJ1QzE8OkY69/hLI/791pC3Ran5u2xNbTI0YMYkL8YWnkD+OqQHju
	 tILgXRn0DciiAXp4KxU4dejR9fRjRQmFPNBOqa6+QAQsDAU5EroddkgMXjVA14ugei
	 JvAvtX9qmdDJA==
Date: Wed, 22 Jan 2025 15:48:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dan.carpenter@linaro.org, pavan.chebbi@broadcom.com, mchan@broadcom.com,
 kuniyu@amazon.com, romieu@fr.zoreil.com
Subject: Re: [PATCH net-next 1/7] eth: tg3: fix calling napi_enable() in
 atomic context
Message-ID: <20250122154833.0e40aa86@kernel.org>
In-Reply-To: <20250122062713.09c9f8c9@kernel.org>
References: <20250121221519.392014-1-kuba@kernel.org>
	<20250121221519.392014-2-kuba@kernel.org>
	<CACKFLim4WrqAPY-WB2C8Q8n49nFavi9xtWV1Xu3d5=vX91fsSw@mail.gmail.com>
	<20250122062713.09c9f8c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 06:27:13 -0800 Jakub Kicinski wrote:
> netdev_lock / netdev_unlock don't have the annotations.

Looks like sparse -Wcontext is happy either way, so I'll add it.

