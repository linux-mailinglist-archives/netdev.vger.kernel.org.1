Return-Path: <netdev+bounces-229439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29087BDC28B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7763C3D0E
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF40215789;
	Wed, 15 Oct 2025 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWXb1jdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B632C859
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 02:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495674; cv=none; b=LnOX07WeJKscZBHu52hZVyQQYYpevMKDNE090h/5NMiXUP/1iCKoBgZzDB3u3nEQ4OdY1xEYMw4GY6qKUClOaVLaZwunjvQpCtH2QkwAOmtDHg5T2Hw34134FdCRZ2rjYDYIh8Z+fCnjkgu1OVmsWoPFP7q/JpSBmaKGkMuDgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495674; c=relaxed/simple;
	bh=o81XooG0FpKbiasrl2MnN6Gh/wrw0Sp2uXZkkTudHVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PjuuACntukiBIjd5r5Ap6aQI6DG6nl1C+2VJRt0YrwshMv2MoyS8TuG3iM6lLoJyd3ZrdE5LRqGC3tCDaetR5TQBDyJmxnrdiMpLpO7i5zLNzQZ3jYghRbzNl8DC/Ug8ZE5PSh7Uw/68asjV0tHpyyfONJw1QSlj5samMuJYP5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWXb1jdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A820C4CEE7;
	Wed, 15 Oct 2025 02:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760495672;
	bh=o81XooG0FpKbiasrl2MnN6Gh/wrw0Sp2uXZkkTudHVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iWXb1jdJlbDBpx8MiHvHNbodfwRt+P8EFpBb2HDi4+H4A2tju9Wu4qpHo/bfp+dBw
	 YVoy8taAHkohYSPkwlQRfKhbqrCStwW7SzrV+AlkLCgnvwECaqCELtthFHxH4+zrso
	 p3bEZkNRgq3u0jMguyCZnWGSj+8q0yYymYZK+gQi/R/45n21m/f6RTdV8UrqtLtWSj
	 7ZuOCFhQ5a19dZ6Nw6pBvbsx2+hwzVopFPatKhfpVw3aWsP7zW7RGU65QiqKWYx5+T
	 ga2YSlPQIiSCNfJqmW+1Ur3rpD80DQ0NSeDhtaFPHql7ONxqxEhNxxL78Yjlia4rdF
	 WVGi/m6CGa72A==
Date: Tue, 14 Oct 2025 19:34:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
Message-ID: <20251014193431.534653d5@kernel.org>
In-Reply-To: <20251013145926.833198-1-edumazet@google.com>
References: <20251013145926.833198-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Oct 2025 14:59:26 +0000 Eric Dumazet wrote:
> +		if (val < 0 || val >= (1U << (31 - 3)) ) {

Is the space between the ))) brackets intentional?
Sorry for asking late.. we can fix when applying.

