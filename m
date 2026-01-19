Return-Path: <netdev+bounces-250944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8CD39C1D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A85EF3004206
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533C41DF723;
	Mon, 19 Jan 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7wMwpeW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0822A288D2
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787169; cv=none; b=K2tOscYcX4njMcZXZ5qu+UW4PQ9AWYgVV0UEzy1Qt8za8LaAQ3fJdoOSEU+Dna4vvJnuiUEYjteOBJWmz3EUFshO9AC88xiUz8hw/w+5nendaCAf3imNkHuKQgos3Kn763LcPlI1cMZ6b6wlGPwOx2+ir9KIzQco4bi/N7B67UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787169; c=relaxed/simple;
	bh=8n4jkxTb0fLh1ddnqPN7isprVsihrMr2TKV/ri6gVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMgstSL1IA2jGxhQ9v6hqCd99pSQbpmR7y5FFGHNlLCJW4IYDSFgqINFSy+9gg8PXYhRYPAyID0em8bzj1W7W7GcQauxSmLbHuRVWbqZNM0Gzzhb0sB/sBUzuhq1B0/ENuWd3Qh9m9ZeHQrq31EobVMFoo+deLEJz7RksxaGkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7wMwpeW; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233702afd3so4697948c88.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787167; x=1769391967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQKwNZ/6sT6svQL2xa/D2wH/FEbpm+0aM/XsFNKVOyo=;
        b=Z7wMwpeWScbjiGsSSdo+lYMkzG1+B36F87L6EtOP86QOkoB3wS7/wgvIrLOMxnxt/N
         3J+uBemrMqRGOm4flwMg3uKtbnhqZpu2p0HY6qs7tefsp0zl6LOTWQ4po0fIEKyIdbxi
         rr7eAfDacWvFABDgWcbDDFG1USL/mzB3Uo+XIkRbo5pNgyomrbBmQ5+ggze5J8EqlFk0
         eNAooGTqTA32vIsxbSoUC2CpHZ0Uhdf2cQW+wJrWJK956m2j4PRzVLKSfxEPejfzJJYP
         O3WcO3LQaa2Yxdfn8bnF0RSRdaM/feBbWrSBEw9ogIOhwX6wQr9U595ojtBzi7bB9PZ4
         DWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787167; x=1769391967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQKwNZ/6sT6svQL2xa/D2wH/FEbpm+0aM/XsFNKVOyo=;
        b=o5+SV43mdPppATAco1FWJq19FmHfzf+unnoyNq1QqGL8UNxtk9y3ERWEM29t6bdDfP
         NnwC0EgOiIYpMkGnY90/X24SzcHF7xIJ+TrHDTJ16ulD6xBUwS5XaO3/L3dsHU6HnXvo
         bO5L+XTtz+gVu+b+v4u81TmGULTsmbhz67YQsCFMCKhUInUrZ7Ik74VWb7RNNODyrMEB
         fn8m0fXeeJYE/lqbxQYnSqqxrZuQv4sgPex8nzdTit1hsiteDfgPNXWcYyAB4XYUSguu
         1C2OQQA1N+x/LQkNpxQGMGaIhmUhYR+gRB+0lzhOHDgUtXacClsPrujj3bSPHixES3nV
         +nBA==
X-Gm-Message-State: AOJu0YxTcQelcy9+yFwMxW2Bdtkt34fePy7hyz/EGHD9OxOeepTBJEyO
	7Ueu64ZyRCm+bBFZpAYUbM+Uik8/LfvTzLFdf7MNpDYrbJF6Bm5uWkg=
X-Gm-Gg: AY/fxX61DBUZt6D7LHNpccstMhDLf5RomJKV0EPUTw6O/cezdnHF04rdeDWaM4lLNfS
	OOQlumQwZz7X/igtLttM9k/6SuZsfYL/3iwb9yjpHKMDzCOOpcE++k/Pi/s3m3SVgFVhqcjOfC6
	bPsz8O/c6AGbolyK0268MLf7Ydxfxp4rb5k+BQSS9QHFMIuR9M1BMlGAR8bmyIGrsIDBI2xBPpE
	e65+12xGQEn1nEOPwp6841JjHFjDOu//YXXC8GYgo6AnoMHoxk8YQpwwATvlscK3mYPtXqzCKvU
	oN0wCCGH9W9Fo6W71/U9lSooUuiRcNd2TqSbedJuhE0s0x+N+IHlqQPhPIgeTOb0SA49iet5tCn
	HXm1tu4VD+ED5cTiO2Er9AE3H7EltIaziYipw7UgGcwyKK5J0/daKvwrUJaNihAIfXf0syo4nDh
	FzQaakhoomTtCdSJ3znFHpwgnaT5SoJG7kL+iBxBih1nB+KBHs/+Bn/VoSdq5Vexz+IVVTZNcpQ
	JUB2g==
X-Received: by 2002:a05:7022:4190:b0:11c:ec20:ea1f with SMTP id a92af1059eb24-1244a782226mr9167354c88.33.1768787166902;
        Sun, 18 Jan 2026 17:46:06 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefaf0asm11798741c88.9.2026.01.18.17.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:46:06 -0800 (PST)
Date: Sun, 18 Jan 2026 17:46:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 14/16] selftests/net: Add env for container
 based tests
Message-ID: <aW2M3RT6g7hR6EWV@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-15-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-15-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add an env NetDrvContEnv for container based selftests. This automates
> the setup of a netns, netkit pair with one inside the netns, and a BPF
> program that forwards skbs from the NETIF host inside the container.
> 
> Currently only netkit is used, but other virtual netdevs e.g. veth can
> be used too.
> 
> Expect netkit container datapath selftests to have a publicly routable
> IP prefix to assign to netkit in a container, such that packets will
> land on eth0. The BPF skb forward program will then forward such packets
> from the host netns to the container netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

