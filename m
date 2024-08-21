Return-Path: <netdev+bounces-120499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5808295998E
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9B11C20FE9
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F0120B32C;
	Wed, 21 Aug 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF5kJcJY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE0620B326;
	Wed, 21 Aug 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724234728; cv=none; b=ZyaTL43/kNa+IIrPw+bxWZygIT3+pym11jFaDn9VRJDtC+i5d/2oa8X+FhusypjFU9tbHehuPFwmGkPcvZZNtkNjOcenzfPl8ZvTV2ISLA16VmHpJ2rIYHfwlRK7dO5GgJD+VgVoLG/7iZVeMpRWF7IHhPmzOTFA4jOSAWSli+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724234728; c=relaxed/simple;
	bh=Hqr8Mm8YpR3FTexCXxW6pfgLn7A4XKa4y4ZPd83+qXQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=dBdGirLKpxi1+7wvLz0eRQnsBU3CpOpqmwJKipVsiCyFJVdOXUag73j5iwE1eOFAz7Y3F3zK7qb2GewnVeUfkPhxg+dIP8QQf04zeiqbQJNeeNAIp+MAb7c5yUqhrfHI+YZoQuw0akJ5yvFWdbpfAevNToLwK1y90CSRRommpAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF5kJcJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5C8C32782;
	Wed, 21 Aug 2024 10:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724234727;
	bh=Hqr8Mm8YpR3FTexCXxW6pfgLn7A4XKa4y4ZPd83+qXQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pF5kJcJYqTsm/4MCgcdJqMGcuFcS1vZx7xdLXTevJW1h/dpDATmSmSuuIdDZEWdVH
	 8H4wsmwGcFJgHr9meB907n3WPsbb/kxah+ipnAVMzaVv498PYXhW/gRRsUrPWbVAxi
	 u7mb63tiwFLV72ea5Ak01cEFxzy+ltlrW+LXEAYEtQpRirY6fNE8OnrTghAlv2vLSE
	 t5STre/3L0FapyGqrL8YkI2RaMTHM7UVAWocziPzAVJkIHWJDlUKchbV57nxObdJRl
	 n5VxgSXOdXtYE/CDJMTRf4F8SOCeGyR5bk9ox+zbzolZq/pxXB05Z8jKKTNevk7s5O
	 TOvncUlNeAA0A==
From: Kalle Valo <kvalo@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  opensource.kernel@vivo.com
Subject: Re: [PATCH v1] net: wireless: Use kmemdup_array instead of kmemdup
 for multiple allocation
References: <20240821072410.4065645-1-yujiaoliang@vivo.com>
Date: Wed, 21 Aug 2024 13:05:23 +0300
In-Reply-To: <20240821072410.4065645-1-yujiaoliang@vivo.com> (Yu Jiaoliang's
	message of "Wed, 21 Aug 2024 15:24:10 +0800")
Message-ID: <87ed6igpi4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yu Jiaoliang <yujiaoliang@vivo.com> writes:

> Let the kememdup_array() take care about multiplication and possible
> overflows.
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> ---
>  net/wireless/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The title prefix should be "wifi: cfg80211:".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

