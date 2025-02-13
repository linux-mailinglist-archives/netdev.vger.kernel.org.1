Return-Path: <netdev+bounces-165936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF5A33C4A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67443A3083
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79AE207E1B;
	Thu, 13 Feb 2025 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PfuG79WF"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA9207679
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441762; cv=none; b=QpeGtpzVtq0yM+xxZ1qxzaNWES6HCqmM5xJIqcVLhyRRkKa/FlFceTfflOQi5V6hvAuDf1Jv/QTHfxuiypw82NJ3K8tqqQnqEZP1acWF5ru6t4mYpE2AMuwt9mvZFLeFu5kQ1ErvNNEMUgq5k+b8hwEA+yd1nAuyy2hUl6Kv9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441762; c=relaxed/simple;
	bh=pz3tc0SO0g1/e3JCmkLkjxbri5nrbrZrCnui1Oq2VLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW4TuYl3YqgxU4x2PniCX6GQPNvPZNDbKRNkv4dApD7WdeFvzTuphp+BgQ93WXZL9m6MIZz0mYQ1/ahRvJZvj6YchLZNSKvMbeNim2rECE6xYO0wtHz15xtxYUmq9eIkRwD6EjMYUVALyoSZ7DFFFfc/8nYwLAe8tbYyyqV+XOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PfuG79WF; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tiWG3-002ETa-HI; Thu, 13 Feb 2025 11:15:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=DWg2lCPnoVcn/KkW48X0ty7FaIbtxIh1+ENKBQJOFMw=; b=PfuG79WFAj+wIsJ+jygloKW91+
	geHe4SfVLK1p+riQYxBysfLMT6e1ldu25JkRUsrXZwljIo1pwUJWQfszoUxt6ynXFhgKHq5B7iT9r
	dzFXsRdEj7UcTWsYT2rDRWmvmOmvGo33E0KfDL2EBRGglSPC+odFLiaVp8p/tn2bvAC5qUEzbd84t
	32mNOJ14Wm03fw3DtF/WbTTzepOWWipqSwbVW2OlCTgIs+vOAoKvWjodVjDIvhenqbj7sMa5c5s9R
	Y1USR0ijbVSz6ryFrZOy/QUsKZPQey6E87TdnykLgu9ljOpHolEmT6/22D1oKJrPoHp+9LSIz9E6x
	VfBoI4hA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tiWG2-0004JV-Pq; Thu, 13 Feb 2025 11:15:46 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tiWG1-006VjP-K8; Thu, 13 Feb 2025 11:15:45 +0100
Message-ID: <04190424-8d8f-48c4-9d07-ce5c2f09d5a1@rbox.co>
Date: Thu, 13 Feb 2025 11:15:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/2] vsock: null-ptr-deref when SO_LINGER enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org,
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com,
 Luigi Leonardi <leonardi@redhat.com>
References: <20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co>
 <20250212200253.4a34cdab@kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20250212200253.4a34cdab@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/25 05:02, Jakub Kicinski wrote:
> On Mon, 10 Feb 2025 13:14:59 +0100 Michal Luczaj wrote:
>> Fixes fcdd2242c023 ("vsock: Keep the binding until socket destruction").
> 
> I don't think it's a good idea to put Fixes tags into the cover letters.
> Not sure what purpose it'd serve.

I was trying to say it's a "follow up" to a very recent (at least in the
vsock context) patch-gone-wrong. But I did not intend to make this a tag;
it's not a "Fixes:" with a colon :)

Anyway, if that puts too much detail into the cover letter, I'll refrain
from doing so.


