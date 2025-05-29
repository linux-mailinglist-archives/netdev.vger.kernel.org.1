Return-Path: <netdev+bounces-194254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C83AC80B3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C52188B6D4
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E026722170B;
	Thu, 29 May 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXwv/bOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896820B7EC;
	Thu, 29 May 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535005; cv=none; b=I3XSJMmpSWDURq35X7so4N+NJ4EJGsSdTE6c8UPzfo2lHOs9bLrRZEZEwDlJLXX3yxTCkRteTJUCLmuXFMSn02UorPfO/8hFNPjxn2ZDbp203H7OMMZTzUAQKuycYH72DyPpEXoKZ3pt8d1IB4eXrYXdma/KDlRJ68c5lRUFrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535005; c=relaxed/simple;
	bh=nyu44VEuMSd1Tx2ErlV0dLspzKPJK8XbJw+jAB36ZKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDG/q1u3VrLnTB9W8QvQ+6J0J2iMF4nxtT3zjmmwYB3gMlqs4aOqoMX44QS7tSo5/tqfImPCfwcpWdxgynV6u7dDi30CxXf0yMVOTvWSvozokwEhn9FsV3QXTucCW0nkAmUY8WzgNMaykDhxcVJOxFa6XiyhFjXYtN+JtoUNNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXwv/bOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB03C4CEE7;
	Thu, 29 May 2025 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748535005;
	bh=nyu44VEuMSd1Tx2ErlV0dLspzKPJK8XbJw+jAB36ZKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gXwv/bOerM9omxqi2uSzWs3yF6O7uRs+i/Sk+B3EV026XGSaCy9/vB7XQczXc48iH
	 bE66xud+qbZScY+7xj+Ub/yF/1k20LMeF1E270jT48m+eYa77AT/d8IbhbUMKXIb7K
	 xBx8Xq6p+OahACSzmoqwgvD0Gi7Fo5/t+FhmQbbbJ67p3EnU0s47k5XRwxQrXpMJF2
	 fIT/qtPByIcA2YKlFl0cwHhxndc5Y/53Ub6OdEipcbeGw1pjidwT3aG2/BARD/UZQh
	 POrp+hf2ek/Q5OuOMw4oBSeVoFm3/BWXGuF05sqWphPTJJm/WCfkeY8qM3+gBL4w/a
	 8fDYq1sPR3UPw==
Date: Thu, 29 May 2025 09:10:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: syzbot <syzbot+846bb38dc67fe62cc733@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_newlink
Message-ID: <20250529091003.3423378b@kernel.org>
In-Reply-To: <aDiEby8WRjJ9Gyfx@mini-arch>
References: <683837bf.a00a0220.52848.0003.GAE@google.com>
	<aDiEby8WRjJ9Gyfx@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2025 08:59:43 -0700 Stanislav Fomichev wrote:
> So this is internal WQ entry lock that is being reordered with rtnl
> lock. But looking at process_one_work, I don't see actual locks, mostly
> lock_map_acquire/lock_map_release calls to enforce some internal WQ
> invariants. Not sure what to do with it, will try to read more.

Basically a flush_work() happens while holding rtnl_lock,
but the work itself takes that lock. It's a driver bug.

