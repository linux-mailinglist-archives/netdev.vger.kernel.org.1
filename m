Return-Path: <netdev+bounces-93110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926298BA136
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 22:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0252842CA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 20:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718D91802C5;
	Thu,  2 May 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQx5ssaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A28C1802BF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680051; cv=none; b=tC3I/TJOa8lrh9rbdBO72j2jh/etduR+cUrdAXi/abIBvf7621ou0FBYA6OEnyCEQnGWE9BGkqm2imT9MpsFOZ2cEywis9WsGjRGDtjVv1K3qN37ULakoudmWJ2KQNRdMFV1hA9B35AkYL/FXe9W2H2YCLWqSM7l2ijz2wd6Is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680051; c=relaxed/simple;
	bh=EKnSSn/byRe7FzO1Hjae/gt+i3LHDiGM8Y5G2lt8frk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=tjGpuSUa+iDLEfwyPFQ8JZDKrrj13v++gCXsnbJyc2tN2Wn4ftMywPa7N/oCRHnU0u3vaiQC91m0Wvee3XXWfHqsTGseDREthDgCQ8+3tsD2nHQJ+r9bonfqnOK+eFuHcFbaeyDBRqFGP6yUIqvx46lmI+Nqh1k11uQiubygN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQx5ssaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5732C113CC;
	Thu,  2 May 2024 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714680050;
	bh=EKnSSn/byRe7FzO1Hjae/gt+i3LHDiGM8Y5G2lt8frk=;
	h=Date:From:To:Subject:From;
	b=DQx5ssaYQfCwmBacGGhQSsWxnAwzjwDgqnKKHc/NhzzbWH5qmKSCS6685YdcEkiZj
	 ryGkoPpKD2NWARE8VBvByrmg8PZduyQKotQx8BlgLO+p/MrUtvWe1Y4uNyE7Ca3gek
	 YY+W5lGWr0/+Zb50aSKS0GHv+CaA84FBhDrRS9M86PkfNoYXzgvh0axF4cEQXKKVEb
	 RmVKpHVy9mls9JV8nhW3nIEYow4yT9HgXGqmmRnjQvqgp1IdfdXEadUQpclXj+I5rX
	 d8ccMqG6HfVemiYXodGf5QhfNcvgMyxN+VXnoLaoYi15ZFVp1sC3kW993j4JWWWeez
	 XH0xokZMMGSGw==
Date: Thu, 2 May 2024 13:00:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org
Subject: [TEST] amt.sh crashes smcrouted
Message-ID: <20240502130049.46be401e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Taehee Yoo!

We started running amt tests in the netdev CI, and it looks like it
hangs - or at least it doesn't produce any output for long enough
for the test runner to think it hung.

While looking at the logs, however, I see:

[    3.361660] smcrouted[294]: segfault at 7fff480c95f3 ip 00000000004034e4 sp 00007fff480b9410 error 6 in smcrouted[402000+a000] likely on CPU 3 (core 3, socket 0)
[    3.361812] Code: 74 24 38 89 ef e8 4c 33 00 00 44 0f b7 f8 66 39 84 24 e2 01 00 00 75 09 45 85 ed 0f 85 ed 01 00 00 48 8b 44 24 38 0f b6 40 33 <42> 88 84 3c e4 01 00 00 48 8b 3b 48 8d 54 24 38 48 8d 74 24 50 e8

https://netdev-3.bots.linux.dev/vmksft-net/results/577882/4-amt-sh/

So I think the cause may be a bug in smcroute.

We use smcroute build from latest git
# cd smcroute/
# git log -1 --oneline
cd25930 .github: use same CFLAGS for both configure runs
# smcroute -v
SMCRoute v2.5.6

Could you check if you can repro this crash?

