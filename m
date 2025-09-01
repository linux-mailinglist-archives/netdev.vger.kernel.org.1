Return-Path: <netdev+bounces-218897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFDB3EF8E
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7337A5C22
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8E26F2AF;
	Mon,  1 Sep 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbankOLi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793626E173;
	Mon,  1 Sep 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758213; cv=none; b=kYsubgeZyxVneK9N/g25DEyqqTNe2uidI/dDj1sdQe6aFOVK00tmlkBNkWjXN/rzI4Nh7nnnydblbLe8wFzdEfNbeCNGVl8YsCFR2kizo/jdi5up+2vMoBG2KDt+9AdM5fu1oB64X1uJy5A15a+J/DyELf/T+ngKpFFaEXxD3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758213; c=relaxed/simple;
	bh=1B3z9r52+xL3XsQiyd4k3+LcXwAcLY90M4YB+j3HsGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1ZHyV+ZGUbBARpaf9KFHOaDb8k1Ea39DjZOSuwBeTCkR2vw3M4HZdLoCM4LSz6SiNzmkz0P2UmC1L4t/6gF19qLtXAjMhsoaljeK6Xfwr6dNLaJe+FeJOoWKNIr/XrEDvzSMZ3UJRdhbTHDCC2R7G41tjsNs1nVqKCR8Jqrv7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbankOLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A471EC4CEF0;
	Mon,  1 Sep 2025 20:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758212;
	bh=1B3z9r52+xL3XsQiyd4k3+LcXwAcLY90M4YB+j3HsGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbankOLi2LrpondWjkVkWZmWFpUL67A2zvw7Q0xzoEoe+/hHb1lhGlw+jq/Nxh3Wu
	 8Y3oi3PSKQQLFfrXChxMgOxE+OyXcaXuAzx+ZgtLQlMMEn8zpmALz+iUQfMUGio2Ln
	 yAe9eSErxKqLbvOZ4/ZhAasxbIELF61ywyX2vpAGnYSG/LWH35+VsqtVv7oou6wa06
	 3+Tgox7EqZuwKf9lmFPl819vCfQTuwZo/9omsKHTTVd/ZaIY0VJXJ9nGBH/M6Pxoyf
	 s0HrXRSLHiV6CqOVB6RTKOV5Jw3kgIBXjbQ2qMSS7kAb1Fbl+9pveKhCvID+GApZlJ
	 vS17Guke6RpGw==
Date: Mon, 1 Sep 2025 13:23:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Longjun Tang <lange_tang@163.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 tanglongjun@kylinos.cn
Subject: Re: [PATCH] net: remove local_bh_enable during busy poll
Message-ID: <20250901132330.589f4ac5@kernel.org>
In-Reply-To: <20250829030456.489405-1-lange_tang@163.com>
References: <20250829030456.489405-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 11:04:56 +0800 Longjun Tang wrote:
> When CONFIG_NET_RX_BUSY_POLL==Y and net.core.busy_read > 0,
> the __napi_busy_loop function calls napi_poll to perform busy polling,
> such as in the case of virtio_net's virnet_poll. If interrupts are enabled
> during the busy polling process, it is possible that data has already been
> received and that last_used_idx is updated before the interrupt is handled.
> This can lead to the vring_interrupt returning IRQ_NONE in response to the
> interrupt because used_idx == last_used_idx, which is considered a spurious
> interrupt.Once certain conditions are met, this interrupt can be disabled.

I'm not sure this patch completely fixes the issue you're describing.
It just makes it less likely to happen. Really, it feels like the onus
for fixing this is on the driver that can't discern its own IRQ sources.
-- 
pw-bot: cr

