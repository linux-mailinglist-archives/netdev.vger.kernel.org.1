Return-Path: <netdev+bounces-114337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7419194239F
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E6E1C21305
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE94192B79;
	Tue, 30 Jul 2024 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaWJTz7s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D118DF7B;
	Tue, 30 Jul 2024 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722383954; cv=none; b=TJqhX97+r1q+5yNW24BlWUmY3ENKQx9A82IQDUDaiaXK9ZkpKg7pGNtG00isY0kodyqfYzXom1FjxiDaJSaSMHIMIotEyfSskon0y96kgqcSM3N3ynrt4qLsYK9uXVFYmrOgH0s+SNx0y9YHaJ07h1d605k4iuikqC+ojoOdjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722383954; c=relaxed/simple;
	bh=bOSfBfu48OQoW+y0suZVARTS2ibFatRunHlnSxblh7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n25JIGFWnXsiUw9fXs9DXWu2FAeSBjesQRiVm0jIUeZulwkjWGTnkrJVGdFM9eH6Sgu6WS9pJ5yTHqIvBzWCiVbMA+wKBxhzt0yXAntr8lVo2M1q7sLpaGuKvBlrh1+JUzRPvtih6/hD4QQMu7J9nK5YqIWyz/OOA72Hp2/BxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaWJTz7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFF5C32782;
	Tue, 30 Jul 2024 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722383953;
	bh=bOSfBfu48OQoW+y0suZVARTS2ibFatRunHlnSxblh7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaWJTz7sPmUdpgzOiosnIGcA1y7+zQ6MY3Y8eNVnB2HFH4r8tTCst48TXgrFEKn+y
	 4fFAOKmP+H+DdlErX50tI6B4FkxZMuZi/kV2RmxChz65A0WEsBcogiIxee/FTe9QLp
	 MnExB5VrA2+yMVZiw80UqDOo9KD6tPEFPVJW3+gQfRAqxzZEl/T3Ii6u50WNA3p6xe
	 OKog30WzDXbK/bpbMRpmnctUfDtfZni64vNaH9Nzff6M0y1/KIvPHstpZI0xfCuZnz
	 8Ody4XsO4OsYkHeyCe1roJFWmxR2Ubv4YtHrq4n3Nw4LnJhWemKMZUgbH2pkKlApvy
	 /v9jDXGY7EOww==
Date: Tue, 30 Jul 2024 16:59:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 idosch@nvidia.com, jiri@resnulli.us, amcohen@nvidia.com,
 liuhangbin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net] rtnetlink: fix possible deadlock in
 team_port_change_check
Message-ID: <20240730165912.67600510@kernel.org>
In-Reply-To: <20240730152210.25153-1-aha310510@gmail.com>
References: <20240730152210.25153-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 00:22:10 +0900 Jeongjun Park wrote:
> do_setlink() changes the flag of the device and then enslaves it. However,
> in this case, if the IFF_UP flag is set, the enslavement process calls
> team_add_slave() to acquire 'team->lock', but when dev_open() opens the
> newly enslaved device, the NETDEV_UP event occurs, and as a result,
> a deadlock occurs when team_port_change_check() tries to acquire 
> 'team->lock' again.

You can't change behavior like this, see ec4ffd100ffb396ec
-- 
pw-bot: reject

