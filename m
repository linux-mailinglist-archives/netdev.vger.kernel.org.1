Return-Path: <netdev+bounces-177221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F6A6E550
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28483A9FD8
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075A1F63EA;
	Mon, 24 Mar 2025 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+S2xOtU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6911DF970
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850309; cv=none; b=BPnFyNhoXRbGW2zAsiX8VbOKiXXHpfL6A4g2N2OhhlKtydIOaa8sfj4QSC0oDdqC0eu3RpQvN+4WjBLOqzLvfvDGlc5woledx0Q6NJDwObLmPXQd2cmsvxIZLM1f1bwuJsOv0/yuQi1es0AarGxOh+IOVEf8pjnNCIg3DXqI5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850309; c=relaxed/simple;
	bh=6XYWzjLJs77951EmKhNDpgpgXHAM0qPer/wp52gDja0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lle+7DlytG0z+cE71Uvpny9lJZV82MMFgrDgkYFchXZxTn8RjSikiN0ziHDnKs5iN7vp7qdXf5Yzng5mBmo6SAlCaHzs97rIJgU+tT5fr3VA10CNEpsGbXnaj5UxLMjqsfywLQbqPyOhWQmCVQHb5FaTaaWxVYBD/6v+HmoG350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+S2xOtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1698FC4CEDD;
	Mon, 24 Mar 2025 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850308;
	bh=6XYWzjLJs77951EmKhNDpgpgXHAM0qPer/wp52gDja0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I+S2xOtU7JmHo8wYlQx587tv3V8Ns/rT5fgZF0WVR+0gG1AkFdtSvgZAcBd/jYfTl
	 aMNmDNpyARY9YK9bs80Oq76wFvdhCDRsxTgWM4lpKQWTYxsWt3yFxWDuSMKcbBO4Xi
	 o50qB1Lct+gkvAHFzLzMJpfta+OWjqp83cOyryQ2/PPW6gUjT+6liBNuUrfzn6w1Up
	 V4vhlNaNoVpf2a2ypzhjRrg6y5qB0331jawRxWe0DLfkMXYdbb4BRjuyIzRndEV/ef
	 mApdXKf15lZH36n42vAGq4j00RRZQ7lmUeHiKhVoc0nFE29yTF222UdPWUU2P/0kuQ
	 ESI99sj4A+jxQ==
Date: Mon, 24 Mar 2025 14:05:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 maxime.chevallier@bootlin.com, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory
 corruption
Message-ID: <20250324140500.43569cfb@kernel.org>
In-Reply-To: <87msdaaeq7.fsf@waldekranz.com>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
	<3f2f66ae-b1ac-4c87-9215-c1b6949d62c4@lunn.ch>
	<87pliaa73x.fsf@waldekranz.com>
	<1eac57a5-eae6-4e2b-99d1-2b06c8628b1e@lunn.ch>
	<87msdaaeq7.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 11:46:08 +0100 Tobias Waldekranz wrote:
> I am not sure how to proceed. The documentation around how to use these
> attributes is quite... sparse :)

sparse locking assertions are unreliable at best.
lockdep_assert_held() is probably best we can do?

