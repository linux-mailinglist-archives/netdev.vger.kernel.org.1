Return-Path: <netdev+bounces-169292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DAA43395
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997D016E601
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C63319924D;
	Tue, 25 Feb 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6j9JDZy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209575B211;
	Tue, 25 Feb 2025 03:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453923; cv=none; b=k6jRjdaAyNy8h89XmAdARflPWlXoxfjv/PVB64OjPNhzZq2ev4I8H0OtGZDtV9YEf/TAgF93GJ2gVR0a5qF6ydnAGCMdvN5r0Eh7FRCZ418PQhUqo06Cb92qtlokU4BBnqKpMy8hTfXf5JhwCYYA9Gj+N9tXRrMj8v/O7KAXVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453923; c=relaxed/simple;
	bh=nXm7/WZVwltPon37JLBs9r1NpNqpv8nNfBtz0HcpluU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPL0+KEWpOgmPCVIjgJn0UFa2FMp3T9B1RtrT/IvLEaDbHj5tXgj6K9/msH2D1aVgIcJ2EYxazfLzU83WbcmDeP8Tp7bFpCFa+xOEPu+0joJpT6h1UwFXpDQjCkPcqLkqHp+mcBGxUig1Tf/ZPeUOMpsSsaNDjj3c/MD1/Si5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6j9JDZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E961BC4CED6;
	Tue, 25 Feb 2025 03:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740453922;
	bh=nXm7/WZVwltPon37JLBs9r1NpNqpv8nNfBtz0HcpluU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m6j9JDZyvBe0iqWg0Nq3NHmo4QqB5LRnM7fiqvx6mr5q0DF+E7E56ZMfsb7HPu1zw
	 j6ooSwLUomBpxU92KSqg3T6dFx3VYUFvgeDe01cGxXE6X06KiXvdY1U10bAn6hszez
	 U510gXubRgSW4BLbVtn0wTgLinldgDm8LshZGqsT+rlNB/1QLwK3KhxOd2k/gE2811
	 InsCp75W/fD8wUz5SEZmmvy8KPdvqKo4To+DnmV5JQgydYZ5ceRyc9o8x5CsWyknCT
	 4asHwd8WCbjsap8BtwJc4MoCGf4gU5o2tfwDHTcmVOyXrzpeamzuvzhhplGnRZlkqc
	 9l02xzyt1/jdw==
Date: Mon, 24 Feb 2025 19:25:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH net-next v05 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250224192521.1ea47766@kernel.org>
In-Reply-To: <99b12bb67f466171c349df3d43e7bf6f82708b60.1740312670.git.gur.stavi@huawei.com>
References: <cover.1740312670.git.gur.stavi@huawei.com>
	<99b12bb67f466171c349df3d43e7bf6f82708b60.1740312670.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:39:39 +0200 Gur Stavi wrote:
>  .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++

Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst: WARNING: document isn't included in any toctree

