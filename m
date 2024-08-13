Return-Path: <netdev+bounces-117893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5303094FB74
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 03:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39804282817
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 01:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184AB79C2;
	Tue, 13 Aug 2024 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZwMKKCF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4007494
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514090; cv=none; b=bCX1nZQRqqBgizzoLUs0ozrTrFEppsDSXIjasGYvsAUCm6ggQWppWBs2zdPUCF4VvzM+DfRldo2vuIzJVK53l8jzC56hLTFbkB4IYOQM+LAlPIwzyeMyf2nivE92y0EYNmkFKFCnLDpnAfbZuoIyZLW+UIupeni1hP3IHPtSdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514090; c=relaxed/simple;
	bh=L4pzlt964eWlQSX4SasQxcwlcIY4K4mNQUTVWbTAFGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxmB3b7hqsKhEgmW+5EtH66tkfHoc1AYqICwBBTQP/t2oiv62YXJ7tXQ+KuuvH7EUJRc2I5YOByVZRY2d8EsxpB60v2kAVK3KT8nvy7EeptKGnnS0AmwCxHjDR+FcU3PAFmsW318VQEdALcI6dqQWS/CR3++YHpRlCWdbXxKMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZwMKKCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA4BC4AF09;
	Tue, 13 Aug 2024 01:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723514090;
	bh=L4pzlt964eWlQSX4SasQxcwlcIY4K4mNQUTVWbTAFGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZwMKKCFQXhpNgAFTuNd4oxOj+Uuj3XdgkitnYjth3gIKBAkp6nD4WpuRB6eIT86x
	 IRNTZK3pmDgB3iar6pvtW1wmw+eQx/KQCoC5nIn5pD3IaYHyyc24V8DXMyC0PWSQlA
	 QyOVuKle4xciMmtUOTwgvWdAZQJ4I+sUhx+4aRf28/08iPRo869zGOxL+EyJhWsr0G
	 APs9qkATmdZcbme8bLhDbSBHh60I/BrI/c4NYYDYuKqaU3tjsCMraBwz2nkgtNJaBe
	 otSWgXJiMXmSMYIZfvLSgaMWUAIVcZFta5gwQb0pSZJ/pdL9oOyf5ALyJV88qKi/7E
	 kDfkY+CZA83YA==
Date: Mon, 12 Aug 2024 18:54:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse,
 David" <dwmw@amazon.com>, "Machulsky, Zorik" <zorik@amazon.com>,
 "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
 <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
 <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
 "Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
 <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
 <shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
 <osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>,
 "Tabachnik, Ofir" <ofirt@amazon.com>, Ron Beider <rbeider@amazon.com>, Igor
 Chauskin <igorch@amazon.com>
Subject: Re: [PATCH v1 net-next 1/2] net: ena: Add ENA Express metrics
 support
Message-ID: <20240812185448.791af6bb@kernel.org>
In-Reply-To: <20240811100711.12921-2-darinzon@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-2-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Aug 2024 13:07:10 +0300 David Arinzon wrote:
> +On supported instance types, the statistics will also include the
> +ENA Express data (fields prefixed with `ena_srd`). For a complete
> +documentation of ENA Express data refer to
> +https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ena-express.html#ena-express-monitor

On a quick scan I don't see anything about statistics in this link.
One can probably guess the meaning of most of them from the names.

