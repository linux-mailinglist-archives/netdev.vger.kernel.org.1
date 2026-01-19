Return-Path: <netdev+bounces-250945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E37D39C22
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C83430081B3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD2200110;
	Mon, 19 Jan 2026 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryn4QC1p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF97C1FE47B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787179; cv=none; b=mu2f2loraQGSswtIOLl6AKQo7r03P27+lkWtZcaAyGyaa4tmoHLes1JSl0UxrH3Cw9GeHEftCHMlwQDhGfPA6JmgSltEB//bOHBNxtSWNiA63+DPmJQhmmCI/tvQKQvrCkmsP/+qC6gTbieahiwdKI91cOJZTSmmi7W8/8jiiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787179; c=relaxed/simple;
	bh=wrgcs+IqYacF1AlDyVVm/ck42vuv/KZDBpOO6H4e3og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRR6o48Cch0zoyDXWp8yBxkOW//9nA7Q0M8xv5TuFHU4mXx4LlLN8faJ/DPwy8S8gpNeRz8KUXl4mW7wwS3UOkjtWlxR7nieCTni7vf9qdRG1LNKoWnMyDqnSZgGCZUx6bh4/BOve5InrFcduoyHi29XrhGCSMyHk0v43AROQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryn4QC1p; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b453b17e41so2490563eec.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787178; x=1769391978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i9FVgCq+6TGX4ndZB+uUL0x/i+U6FGafIrPf+7RfhaA=;
        b=Ryn4QC1pao+GHyVc9qcZTw4469hYKwDpmIJObB8focFDrGFq4LjzYa6Ui1WTKX5z0V
         1bwVPa8+eyGjG9fx45OKyzvw3WD8v60NOe1TYv2g11fOkcUwrvi/ldJJ4B3C3/6q0y4d
         Jfnz+Hu/Um7eU/WEVu+K0BnPTMY58Yzkab3YoR553ulbi9fTv74Gz0rRxnOXYQL1JkGG
         O9P2wh4oQtDv9L6iH5PTXXTEtBSYErSh5SIvt+/u4gkn90Jq319UkuA0zFleCI8pC1dc
         x88lEtMTAYz623LxpCylN4wQ2rriBlulZkFRPwduZLTldZpjT9MlV3sgm9f9mefOysoX
         w73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787178; x=1769391978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9FVgCq+6TGX4ndZB+uUL0x/i+U6FGafIrPf+7RfhaA=;
        b=lFhWv93S0fM+jqNxrd1mffDDblsupcL/MRnoKmXR/LFEE4JSbJlwMsUvMaW49pdKN6
         aDnUV0LHDhryQa/drhKKb2UJY6TmiMB/RvqjzZoGPsL17j9C3GRMHcRqUTed/UMkrhDT
         TBPP2osmT2mSn+XIS4cc3yzRT8zBh0lwsgaSRq51pGWVtJddCSHz7yu3QICIQkJ7Ts4V
         g+irQSB1n6eo3HZLZMMH33nz3eNvwUy1XoSWijEEgOaOO3oF0MFJcgaCBHNBsEokd7rX
         TBxHu3KH8QSCWwdbn8/iutf+EpAPXWEIcXvaIe00r9OPPTT9BrprkjPQKGhhCCdZQbw+
         8hKQ==
X-Gm-Message-State: AOJu0Yz+OlPaWC1RzMbFuKcX1FI8WvXOJcEzmmq6spCXQ7vt0LhqzCo+
	F6L32AT17pKQVSTKCwcezAuFIvjbz+aOzNJQKSWrfaHXGMaRXj8wl2M=
X-Gm-Gg: AY/fxX416SVJLdra1aIapyBU6ndveZ/aHCfp4R9cFsyBJqickrvW5kuVKaOfP+zIH8u
	GEoSMJkNNdFPdyFFLfhs/NpzqthP+Lj5wr8SAqxW1JM8oELAQnSlzEqZcbEE++E5IBgko9wMbXq
	RUdcAWGETabTCwXu7wuT0MPT9Pk+9sJbbzG7CJjDnUflhVTo2hN+kdUQOq7ch1ywlsOQzdR+EbI
	bbXjPPmlcphwJdTci4Iu9ticaTwHB56IlY9LJ+8ceVU09w7qIQ0+6ZCLZjjRNctryPP3sPF7+Zl
	3gYR+vvM+nt7KkJMHIravLYjqYuIajQjsnBzxkYU4yCshvVyTqTZoX4FAeETo+M/mavv8A8VAEe
	sP2a7q9OVJEbKhV5aWqSOzVeNAsgPY7goOesJUTuicIdX5QRy54AbqGPncAs6XrllwO6ZMQQ4s3
	5KUb8DEKZzF2sREffeKX+xr7trufxlpDElaofiA+AcouREePlKyKoQ95/2Ba9ATKS2PURUVmA6y
	FnBJQ==
X-Received: by 2002:a05:7300:5353:b0:2ab:f490:79f9 with SMTP id 5a478bee46e88-2b6b35a1060mr8727080eec.21.1768787177749;
        Sun, 18 Jan 2026 17:46:17 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3619a7bsm10870916eec.19.2026.01.18.17.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:46:17 -0800 (PST)
Date: Sun, 18 Jan 2026 17:46:16 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
Message-ID: <aW2M6DZn8lhy7H3G@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add a new parameter `lease` to NetDrvContEnv that sets up queue leasing
> in the env.
> 
> The NETIF also has some ethtool parameters changed to support memory
> provider tests. This is needed in NetDrvContEnv rather than individual
> test cases since the cleanup to restore NETIF can't be done, until the
> netns in the env is gone.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

