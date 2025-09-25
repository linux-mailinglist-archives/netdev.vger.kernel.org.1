Return-Path: <netdev+bounces-226249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD6EB9E806
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F3D1BC0EFA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E96127EFFB;
	Thu, 25 Sep 2025 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LU6oAXxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E28277C8D
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758793869; cv=none; b=tYOs+DMl4Ojej2DMAfIesAZ7YTTKMX83mm/MHnXjiXDdZejYFQNYgamuqTu3n9yRoake8gVbgFjgb5LaVB1oqPEICIgIvLlTDpZTISVEk8AflvU+GDADmL2ucWlrvenwCaN8W7E5B/ZNyJM5GVDNeBU0Um1dsEwzOw/7+33SkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758793869; c=relaxed/simple;
	bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGxVZ4Z7O7qGdtEtt2Wo0TBYjbSCJQCdYdhQfyyme9fPUXWxLXQVVHISpIOJj/eFJIZI0MoRn089Wa7rjiQJfxDJRXjQi8axLkO5Vqb/qMLnFyzsgDzih4ItPXIN4XO5fUyygw7SAVm4gXum21BLVRDgLBJqF1vauIZnnRqK/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LU6oAXxM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b2e66a300cbso146276266b.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758793867; x=1759398667; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=LU6oAXxM646knKdDRetHDdvY5uXOb4M4EZgpP8OGwWE5C5MTxEB/SMWkDEpO1K4WXU
         peE6mvythlUU1n6naOwG9r0orSbpuEn5pM7wOOIdJYTM9IxUNWeS+E7Bx2LVA6CwQ+Uv
         ZC00HEdLuz90PmjEf0YdItWdhcNXN6xpANEXnChhMndyO1JJiAZEfPUymK/GBIiPvObO
         7YaYlZFrC4zBQTEfcv2fuNk1UcsyE3+9GQApNA+/ual1fCWG8fsGOHMNbvGLjVFhY5F+
         5Fg5ToleSGmSB6IyYPql3RFwYnondio1r6BuuHmuPVoTPZJ6P/TX/a8MkD9wRz+KFCZo
         agaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758793867; x=1759398667;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmkFbEfQivCqBMVs45gL6yXtOiKwXDMn9AvVAlKM2NA=;
        b=HAstaaNB+EP4EopSxrDEncf/e8mGlr91R5zwnLHm4es3I/mxQAIVrE4mG3CNfkOTA4
         jXDeKX+xUZWnW6QZYQiyF9yB3Nhad9iEphTY0wWYgPKKaOnLUTYH3Vy2ZJEzMCCYrOQ7
         WlArTy0y1VTOkN3Drlfby/VFAHUkdd9JhnDr4AGt/Hw5NKDGrSy/8xD8toMlMDwPC8dd
         WygxJ3BBAdIUGYx+B3C3x/ND7veX1vNWLgwklkOBLoC6DyjyA2fUPM67529tmftRbIUw
         6jAJr8zlH6ji5hdQ1WZBcTxMwkr+agwfcwEX9mM1YJxPRr7o9d8Y/PqKVjqzkz3I38jn
         PUXA==
X-Forwarded-Encrypted: i=1; AJvYcCVpVFMCiiXgpF6vuBaxLJHJhavUpCjS3tC1E6dIe3q29qwhYPNoTjmoI30zcMNZjr+6t2xVhi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm1hqS7CLid+RTnp+sZGugD5+gKwbm817tnZg9/TpcQ3FARKuz
	WxcFO3md16cArfo0WZaWB0F+jZDKmaRlc+aWYUfKcmRg1wEcv72lqZDtRgLCMjqO3So=
X-Gm-Gg: ASbGncuN9HnVelmUjJSqJ38mgGbseb/C7llFmZ09o1v4esdV2aTzCi87eksZy6Qeocq
	PZtfIB7gyroZ47tm5qGynUAkPk/cE06hxocfZfKIOysVU/xIJQZCMya6oOg61Xnyb6QrYM1sJ9F
	8M0t9xJLvgYABiShFXOprFNQhE6X6q/zXUTN0qhlQsq2zcToc8H867mG7FgEVMyl5juo5WZR2Ao
	+IYFjSHTdi/klyOqCjTP1qXwAvCL+6F3Uu3xqo4PqWmTSz0ohYGKN2Sh1B9E6xNfdCYWeYrMCY7
	MWW8mzfLaBmJRpkPFVE2YG7IfAs+yt2z4Iy1FWxAK+VwRKECCDsYW5NgtLXNsIYjgmR/ygOMEbr
	HNallzwCJbmb14wI=
X-Google-Smtp-Source: AGHT+IGEVGUv7B9GwkQ2/AJ6K1sBRZgNTUuhBCswgHVtL42XXaKHIxqK5bg7kju7asdvwIL8eCRs8w==
X-Received: by 2002:a17:907:1c8d:b0:b33:671:8a58 with SMTP id a640c23a62f3a-b34bd440633mr294373466b.37.1758793866605;
        Thu, 25 Sep 2025 02:51:06 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353f8686e6sm131994066b.38.2025.09.25.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:51:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>,  Jakub Kicinski
 <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Jesper Dangaard Brouer <hawk@kernel.org>,  John
 Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	(Lorenzo Bianconi's message of "Thu, 25 Sep 2025 11:30:32 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
Date: Thu, 25 Sep 2025 11:51:04 +0200
Message-ID: <87bjmy508n.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
> RX cheksum results in the eBPF program binded to the NIC.
> Implement xmo_rx_checksum callback for veth and ice drivers.

What are going to do with HW RX checksum once XDP prog can access it?

