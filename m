Return-Path: <netdev+bounces-155115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94EA011E2
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 03:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987583A461E
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 02:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B26A8D2;
	Sat,  4 Jan 2025 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5PP1d60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF775134BD;
	Sat,  4 Jan 2025 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735956873; cv=none; b=cZL0Uu50j68oWQNh7QWctLYZbjHhzaBT5pPL07uEZml/rqIo+gv3eggPCJJmbIlzULQP2iw81dl3wFgqGYc6gedyCFm/ehRm5KmFilaKY0CZhCNzz4en4yZoTFaCKV/Xq+4xR3Ocxw+8yzgu48MTd/aYEoTutB6wny3EfsMYDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735956873; c=relaxed/simple;
	bh=0kD/Qav3CMKX3PRVMdqzDy2KLijr2u/AwaZGORrDsUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE0ERR2I02jlD6JZIOojl8qJoMy7H4q7ChtmqN5cW5olocvlFAxuugvCQ/ospeLLIctzjqddAu3T381jyboDeLpvCDCNB0OUu/HtnDjb6QRjxyjAnAdOperMC1iXTjYOpX684bYFscsjEqf/qAIz2V8IVDDOWIbyuCWyE1XooQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5PP1d60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963EBC4CED6;
	Sat,  4 Jan 2025 02:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735956873;
	bh=0kD/Qav3CMKX3PRVMdqzDy2KLijr2u/AwaZGORrDsUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5PP1d60bJO/ZUAmRTfHxP69gUefDKNGx8NTaHR2DeZ0hFRQ9QqFGB0VdUBU20DLG
	 uTT+S8vMxeWTdYWgDvN4Kc5cT25HRXgU9X0Wh6Mya2zVBu6UybjIqnp2HS29eeLmmT
	 lz0fRWXNt2t9kAon2idgnqNntJUpMrnrw/tEePKbK8wxahkKpsSaTW/XKzUs6D9qwr
	 LUaQcjFLWKMBOHaiRkN4TWoONqbd8BsJgrebtN4OA7WmCHETt54x0vzNPGn1At6Hho
	 pn3NY167XjiK19hiATM0dUedOS37mzScDblBtezreYHa3dPodzzF7XDu1v1GNRv80W
	 pM9qfqgIHKR7w==
Date: Fri, 3 Jan 2025 18:14:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shiming Cheng <shiming.cheng@mediatek.com>
Cc: <willemdebruijn.kernel@gmail.com>, <davem@davemloft.net>,
 <dsahern@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <matthias.bgg@gmail.com>,
 <angelogioacchino.delregno@collabora.com>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>,
 <lena.wang@mediatek.com>
Subject: Re: [PATCH net v2] ipv6: socket SO_BINDTODEVICE lookup routing fail
 without IPv6 rule.
Message-ID: <20250103181431.536909ad@kernel.org>
In-Reply-To: <20250103054413.31581-1-shiming.cheng@mediatek.com>
References: <20250103054413.31581-1-shiming.cheng@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 13:43:49 +0800 Shiming Cheng wrote:
> When using socket IPv6 with SO_BINDTODEVICE, if IPv6 rule is not
> matched, it will return ENETUNREACH. In fact, IPv4 does not behave
> this way. IPv4 prioritizes looking up IP rules for routing and
> forwarding, if not matched it will use socket-bound out interface
> to send packets. The modification here is to make IPv6 behave the
> same as IPv4. If IP rule is not found, it will also use socket-bound
> out interface to send packts.

CI shows failures in tools/testing/selftests/net/fcnal-test.sh
and tools/testing/selftests/net/fib_nexthops.sh with this patch
applied. Could be a flake but please double check before sending v3

