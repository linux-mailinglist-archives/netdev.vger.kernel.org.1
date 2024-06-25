Return-Path: <netdev+bounces-106613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D04F916F74
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE692285D97
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7BF1482F8;
	Tue, 25 Jun 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFNdiVJN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EF116C840
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337318; cv=none; b=B8CFyu4Xqaoch5RbRFyxuKAZ+sm+T5QKll+ASe1r2mmcs16MQzhJQv9zZ/9EqPbBCL7JSBAE6DFHXdh11TSskdNZHcJH40PBVVY+00FAUS83/Qa5AcsJ5Dp0/5FGAosQaurICg/xN10r63OZW2FeJpOhv0pbg0j5Lj1p7j3a8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337318; c=relaxed/simple;
	bh=36rt9zPAygIwjdkH3fIXUiUxClnMItJ78+tBVE/UUp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJzCd1aVM9LZ2Op59VsN4PL5KnhS9iVQb2c1D+u6wKG+241doVLZsKnC/zYtKOgRyzKjR42Xhhfu1IreywNENQBmbovnTUl+zqH8XDxwlfPzlHT0qzyYazTpbaT0OXbmYfRPLbC5M8gmT59l8nr1Cg3e69jJT37zw+TMjcLuiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFNdiVJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C42C32781;
	Tue, 25 Jun 2024 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719337318;
	bh=36rt9zPAygIwjdkH3fIXUiUxClnMItJ78+tBVE/UUp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFNdiVJN4XbzxaP01LSETeylNIaHCUrdJG1S/P70ZgVPJVAio13+FVYNmPevpwtSc
	 lRSKXzYXKNuhc4AetSrAUXZUnznBbDJ4RidgpSYzb8v0NDRkXIRmOR51UCvZtIrErV
	 +jKnl3U3kglHGB/uZStZ/BZmrkzZXhKbPA4uW98Xd2+pcxiT+Jr+2D1N2PES6XfQEW
	 SLchvhPby3xvoZxY5oQU5oLoMupFk1z8mcT3on3LF+U5N9wRbEWy3as1uW/ru4BKUI
	 LzJFKEMegLV8brbadGrPDR4IbwnCITCexp2BxnQYKbNMYqQKQhULa674p5b0Q+OrW2
	 JzobMiRxdgatg==
Date: Tue, 25 Jun 2024 10:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
 <ecree.xilinx@gmail.com>, <dw@davidwei.uk>, <przemyslaw.kitszel@intel.com>,
 <michael.chan@broadcom.com>, <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: rss_ctx: add tests
 for RSS configuration and contexts
Message-ID: <20240625104156.4ab9b5ce@kernel.org>
In-Reply-To: <20240625100649.7e8842aa@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
	<20240625010210.2002310-5-kuba@kernel.org>
	<877cedb2ki.fsf@nvidia.com>
	<20240625065041.1c4cb856@kernel.org>
	<8734p1at4e.fsf@nvidia.com>
	<20240625100649.7e8842aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 10:06:49 -0700 Jakub Kicinski wrote:
> @contextlib.contextmanager
> def bla():
>     try:
>         yield
>     except:
>         print("deferred thing")

Ah, finally, not except. That works.

