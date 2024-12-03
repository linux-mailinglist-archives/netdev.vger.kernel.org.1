Return-Path: <netdev+bounces-148328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CFA9E1203
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52142164CCC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2795C13BADF;
	Tue,  3 Dec 2024 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhBuFGrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B92E64A;
	Tue,  3 Dec 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733197717; cv=none; b=bDjtQMFmUdOkzEijqiVa53R52b8QrovMtmxTIwujLLiSoRCR8/a6S6SRexA+04DEzfNmb7MhPzGDB/Lyjq8Hja4LzPQWTrEk/o6xF9bq/Aek+jhSCDu1DMGfz7SprSHVf4T/q0gJVkQ/7+mvwqovdcEzKrlxw4arsyeV2m9llik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733197717; c=relaxed/simple;
	bh=eigILyoZkFbV+wfkqmfAXCXK0eH2C/EFOqosbbb9AOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DLFSN2Rh2dExId3imaDemCwfmpMeg/kBtEqGDQMstgTmooHvASmKi2FjeaLu+zHlBME0JUKEGsE4SykZ1vkSw3gfnib4PvbieGj0L62nqqqSRA2N13480PJNHRVLjGjmAUkhyhSocoLlMj0OVQZ/8jQ6tg/LUeZEz7ItMG6fYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhBuFGrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E546EC4CECF;
	Tue,  3 Dec 2024 03:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733197716;
	bh=eigILyoZkFbV+wfkqmfAXCXK0eH2C/EFOqosbbb9AOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhBuFGrhYEnoH7cnfXFBYaEoQcm8FORW43Ljm5PHLFfLA6YQbR5ti1erwF88XxYU4
	 iojsZ3nMiGUllFleXyUy99QjV6YOEcgsXVS+nCod/7AxtIccAkOJjLMWaSYxN05xVX
	 XLmARZ4iH3ZmyEaOsT7i4TWEXQF2TQq62ZxxEImRGG92kJeN6CLkEHSyZYLyPU7W+/
	 9KULh8OATDvfHobQb4ZuNRDmN1u+aYTg4UwKbRoEekxl6BdOc2VOu+BtpScYJRqYiT
	 gJ1jEYDruuUuhaDWZHTlX7/PysbKYUecZHh5nHVYa+FGTuDvTXnL/J0aSMPVkDK7+Q
	 OUeu/Ojw7S9uw==
Date: Mon, 2 Dec 2024 19:48:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 37/37] rxrpc: Implement RACK/TLP to deal with
 transmission stalls [RFC8985]
Message-ID: <20241202194834.67982f7f@kernel.org>
In-Reply-To: <20241202143057.378147-38-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
	<20241202143057.378147-38-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Dec 2024 14:30:55 +0000 David Howells wrote:
> +static inline ktime_t us_to_ktime(u64 us)
> +{
> +	return us * NSEC_PER_USEC;
> +}

Is there a reason this doesn't exist in include/linux/ktime.h ?
Given ns_to_ktime and ms_to_ktime already exist there adding a local
but very similarly named helper in a local file appears questionable.

