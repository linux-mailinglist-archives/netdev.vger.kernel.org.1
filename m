Return-Path: <netdev+bounces-213970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3DBB278AC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640E616ED86
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 05:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4059221CC62;
	Fri, 15 Aug 2025 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdAE6JbU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143DF2192F9;
	Fri, 15 Aug 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755237366; cv=none; b=PZkGyyksgeXTNVVsc2DX4XX2snZLSIYtRw457uUsvgHcdnwDNRThXdxvHn/4+8QjH4ihKXf9mxYHL5qYAn24QWhVy4wptHVC9UO4D2B8xEAW0cm8inDD36H/3agkb0t+x3yU2r/Eenvt1eMTNdzVyfEdyxc16m60WeTWyM+r2iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755237366; c=relaxed/simple;
	bh=bfKrrkTfyrpACOTNr5WVmWTWKBqGGumeVY6yYEwqPq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFNKZ/eez7aHIC/d4cY5LuuEe3brgV2mbYNczCzY1Sel/Q2WUfCoI2IFHxSx8ijzL9FmFdmVxpQgmWJsMr1j7feJFRcs/PnV2KoaDnHmaiWoAdXL1OB+hd3uM3oScbdNK7AomZJPxnD/NyzavpsRnW92vh1e6OsNbSs9XEc6RHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdAE6JbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56AB9C4CEEB;
	Fri, 15 Aug 2025 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755237365;
	bh=bfKrrkTfyrpACOTNr5WVmWTWKBqGGumeVY6yYEwqPq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mdAE6JbUY7lLx9LHAyTfYwbSAkRe0rPYMOe/xDJyb2RTNZhxbE2qjanljm8/cuS0P
	 WkDPpk7+uxT5BXifCcQ5f/zOa2xB1Dvm34tU9reas/eYMub1GKu/ZqBNejOVe6Z5EU
	 zCabyP+4P+Pc3ZsNUwmV0kk38FLk+K+EvaN1sUCzwLZj+mOHAkfPuX+kukSje7v/XY
	 hSjo9GNL6Z/ejQ6LuFE4NEtTCqLWsHce2cxaQu74z51keathXC2+5MsaXpduIfs1yX
	 iq9aSNjFVWZHZq98ifEe8vl6BRqTWCapEmboxcUvLSFLZqu9gOXzlEB/8uaNa1ttQ1
	 atZWPnctRd5uA==
Message-ID: <e3cfdd98-6c51-479d-8d99-857316dcd64b@kernel.org>
Date: Fri, 15 Aug 2025 07:55:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/nfc: Fix A-B/B-A deadlock between
 nfc_unregister_device and rfkill_fop_write
To: Yunseong Kim <ysk@kzalloc.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Taehee Yoo <ap420073@gmail.com>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 yeoreum.yun@arm.com, ppbuk5246@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814173142.632749-2-ysk@kzalloc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <20250814173142.632749-2-ysk@kzalloc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 19:31, Yunseong Kim wrote:
> A potential deadlock due to A-B/B-A deadlock exists between the NFC core
> and the RFKill subsystem, involving the NFC device lock and the
> rfkill_global_mutex.
> 
> This issue is particularly visible on PREEMPT_RT kernels, which can
> report the following warning:

Why are not you crediting syzbot and its report?

there is clear INSTRUCTION in that email from Syzbot.

> 
> | rtmutex deadlock detected
> | WARNING: CPU: 0 PID: 22729 at kernel/locking/rtmutex.c:1674 rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
> | Modules linked in:
> | CPU: 0 UID: 0 PID: 22729 Comm: syz.7.2187 Kdump: loaded Not tainted 6.17.0-rc1-00001-g1149a5db27c8-dirty #55 PREEMPT_RT
> | Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8ubuntu1 06/11/2025
> | pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> | pc : rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1
> | lr : rt_mutex_handle_deadlock+0x40/0xec kernel/locking/rtmutex.c:1674
> | sp : ffff8000967c7720
> | x29: ffff8000967c7720 x28: 1fffe0001946d182 x27: dfff800000000000
> | x26: 0000000000000001 x25: 0000000000000003 x24: 1fffe0001946d00b
> | x23: 1fffe0001946d182 x22: ffff80008aec8940 x21: dfff800000000000
> | x20: ffff0000ca368058 x19: ffff0000ca368c10 x18: ffff80008af6b6e0
> | x17: 1fffe000590b8088 x16: ffff80008046cc08 x15: 0000000000000001
> | x14: 1fffe000590ba990 x13: 0000000000000000 x12: 0000000000000000
> | x11: ffff6000590ba991 x10: 0000000000000002 x9 : 0fe446e029bcfe00
> | x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
> | x5 : 0000000000000001 x4 : 0000000000001000 x3 : ffff800080503efc
> | x2 : 0000000000000001 x1 : 0000000000000001 x0 : 0000000000000001

This all is irrelevant, really. Trim the log.

> | Call trace:
> |  rt_mutex_handle_deadlock+0x68/0xec kernel/locking/rtmutex.c:-1 (P)
> |  __rt_mutex_slowlock+0x1cc/0x480 kernel/locking/rtmutex.c:1734
> |  __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
> |  rt_mutex_slowlock+0x140/0x21c kernel/locking/rtmutex.c:1800
Best regards,
Krzysztof

