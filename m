Return-Path: <netdev+bounces-230617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2EBBEBEBE
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7B1407AD2
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80702D661E;
	Fri, 17 Oct 2025 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG/zH9Td"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF72223710;
	Fri, 17 Oct 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740054; cv=none; b=XEIHHhJ3Dnr9PLLd1krWQdq3b037SP/VMcoSrmxjSnKI7FUZFIQ3DzS0PuxeP/3HlglALkaV4cNXFQePSHEQM4x/DldQ9X3tUuV1zM6N2c6+bPwqDj1PUGvD4RU8+GxKtCLN5xzjYB4WPQQL/8x61QveVP0h2HRk2obov2+Nuxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740054; c=relaxed/simple;
	bh=p0l4lq0bjml/HIPy65VCiSl+37cdkkZIB4pXwea07Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOMxfEM+RFTs4lVaXhscCKEKRSObiiWH8KIkIDgXhnVWItFAvtRdKtbWqrWIvXbCIlymBlkipQSt0XlgjbI7Ggy8WQKwwV74LFY1bszSol3MMOxWsv7ItpxqrJuBSXriUKLJhLQ16EAuFmOpW1UlMwXjVKYOVkq23cCvQTzf9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG/zH9Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD7FC4CEE7;
	Fri, 17 Oct 2025 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760740053;
	bh=p0l4lq0bjml/HIPy65VCiSl+37cdkkZIB4pXwea07Ik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jG/zH9TdQnrlPxC/KU/+AzRE9NScNHjasLFcx5E0L4RN5V+3uPohg4OPawlCF2++R
	 6rWVkQZHtpT8lNB5wnbDRZPSEe4br2Av03TNE9XBvWd4D2YDK2uQl5YVue0ZjbzGqb
	 76G1pV8CozbfZHWWYXhx62nW1sfqBBxn85NXrPtLDXX9BpE52Bj4gaHPU/ZDpPyLqF
	 qH/Ccqg0yHwOMoDDWyHvA+iZ8lVCVIDw/hM6gql5EUg3jq8fXqAhzMmmRFrU3WtVn9
	 NKKnDAf/iwqKeWDc0uFqH24YKRPjjVlJI84aiM6RrcBIHfHGoeBd1UJDUGwyLKnbET
	 nWXMnnP9zzabQ==
Date: Fri, 17 Oct 2025 15:27:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: <ahmed.zaki@intel.com>, <aleksander.lobakin@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <samsun1006219@gmail.com>,
 <sdf@fomichev.me>, <syzkaller-bugs@googlegroups.com>,
 <syzkaller@googlegroups.com>
Subject: Re: [PATCH V2] usbnet: Prevents free active kevent
Message-ID: <20251017152731.4bb7f1f9@kernel.org>
In-Reply-To: <20251017090541.3705538-1-lizhi.xu@windriver.com>
References: <20251017084918.3637324-1-lizhi.xu@windriver.com>
	<20251017090541.3705538-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 17:05:41 +0800 Lizhi Xu wrote:
> The root cause of this issue are:
> 1. When probing the usbnet device, executing usbnet_link_change(dev, 0, 0);
> put the kevent work in global workqueue. However, the kevent has not yet
> been scheduled when the usbnet device is unregistered. Therefore, executing
> free_netdev() results in the "free active object (kevent)" error reported
> here.
> 
> 2. Another factor is that when calling usbnet_disconnect()->unregister_netdev(),
> if the usbnet device is up, ndo_stop() is executed to cancel the kevent.
> However, because the device is not up, ndo_stop() is not executed.
> 
> The solution to this problem is to cancel the kevent before executing
> free_netdev(), which also deletes the delay timer.

Please add a fixes tag, and repost.
Please don't send new versions in reply to previous / existing threads.
Please read at least the tl;dr of:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

