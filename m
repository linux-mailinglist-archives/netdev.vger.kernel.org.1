Return-Path: <netdev+bounces-69914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FDD84D03D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 18:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E6CB26FCE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBBA82D6C;
	Wed,  7 Feb 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9CA1DwW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CF7FBD2
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328551; cv=none; b=LPH3jEEl0aMLfc2CJ8dKM7RqZcFoi1fYZl80G877nfXr0kz9E3mOrz7+lo3iJ1IVk7KcVwjeKknYGU6YURZahxBOWegX5wC3RqeYvZ2jceFUTw4Yjh2AZ7vHixlz9kkNqn7igiCt1SZIebwQjJLD5ilIBQH+xxjfULRX02vDWC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328551; c=relaxed/simple;
	bh=4xx7mraCpsnLQh+CqGwZ6bJg2PqcalURvbcbhzq1jxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSDKOs4aauEq9YcSd2p7TKWHC4trrF81WPJ+TwZLQnEe+xy28jKkrSe/BAz5p3kg9DhO7GRBUO6eSOlkp9GCZjrC8nYwkxavKObNubQpgydZEb5GVZbzH0wf3+kkzVkNosQOCg+DRmJ5bmr7L+E3M+o/jm8KPbMSXpjjAn2fxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9CA1DwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BABC433F1;
	Wed,  7 Feb 2024 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707328551;
	bh=4xx7mraCpsnLQh+CqGwZ6bJg2PqcalURvbcbhzq1jxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d9CA1DwWduH+ktoktQ5UEsYcKibUsvrqcZTh06ZZbjUATNPAp8pjzskUWrglQDbN6
	 9fEWL+ENSbQrwjZ74VpIrzL3IyedL3t1EmstKVr4uOIGmr235M9NWq3Yme9XBwsB9n
	 eD17lZqzed6gzF3kIKr30TMxw6KIeRklJRRJx+FGEwa7gK3YBzyzx13mSnhVIqTcUy
	 t47mlabBBBNorRTAekC22exv12msDQC5r7O1l8YMwambcW5WFq2VDTpaLyfXF8qtjf
	 sKd7SUPoyY4672GW0I//b2ZMef3MAklymOswTwxWECRkjF0x8nxHj9rN0XX2ndnRkd
	 UIXVtKDVt3yCA==
Date: Wed, 7 Feb 2024 09:55:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net-procfs: use xarray iterator to implement
 /proc/net/dev
Message-ID: <20240207095549.00237661@kernel.org>
In-Reply-To: <20240207165318.3814525-1-edumazet@google.com>
References: <20240207165318.3814525-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Feb 2024 16:53:18 +0000 Eric Dumazet wrote:
> In commit 759ab1edb56c ("net: store netdevs in an xarray")
> Jakub added net->dev_by_index to map ifindex to netdevices.
> 
> We can get rid of the old hash table (net->dev_index_head),
> one patch at a time, if performance is acceptable.

FWIW there was a basic benchmark result in that commit:

     #devs | hash |  xa  | delta
        2  | 18.3 | 20.1 | + 9.8%
       16  | 18.3 | 20.1 | + 9.5%
       64  | 18.3 | 26.3 | +43.8%
      128  | 20.4 | 26.3 | +28.6%
      256  | 20.0 | 26.4 | +32.1%
     1024  | 26.6 | 26.7 | + 0.2%
     8192  |541.3 | 33.5 | -93.8%

    The microbenchmark scans indexes in order, if the pattern is more
    random xa starts to win at 512 devices already. But that's a lot
    of devices, in practice.

obviously not a very realistic load, but I wanted to mention that,
in case you were planning to do similar testing. Having
wasted few hours yesterday reimplementing tls fixes Sabrina
already posted makes me hyper-vigilant now about people 
repeating work ;)

> This patch removes unpleasant code to something more readable.
> 
> As a bonus, /proc/net/dev gets netdevices sorted by their ifindex.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

