Return-Path: <netdev+bounces-81921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C4488BB24
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78C71F32AB6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B291130A47;
	Tue, 26 Mar 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heGMKgeF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4584D29;
	Tue, 26 Mar 2024 07:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437848; cv=none; b=rw0U7ev/rUwbFtImKrZoR5jmHEQpUzy3z0ZleWqjriZgBR1L6olZnzwnUvJKFvX7AKl6rhWk8qu2EaTWv9+ERqeRcQLQVCZsDwxSZMFAqfvd3Z2K9QXrL115jBy9ywReESoXAeX0tamqxtJv7+ih1PIbITZeof6Y8GPAqd8yBGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437848; c=relaxed/simple;
	bh=BTAyZ60NaXGo3GBC4+AymyKOP8H5Or6ePkRT5LyuNJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PN2FmGgdVdAKZQuWzH4Dec/zHWkGhnYLp80vtHlUlcpu0DXF3mN2QdjujYNMdmFXdk7IIPjct+9QPGf2GzYuw+pk767xrkYjIHwoAJRUoz4QAF1M15aUmA6iFkXth0POKxLmurkyjNMpvCxou1D6hGKA/DZept+kxzZpg6oHLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heGMKgeF; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430cf6ebff0so10892021cf.0;
        Tue, 26 Mar 2024 00:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711437846; x=1712042646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux4IM0v/msnT5HlRHo0+7nKicRE4antbODicCPKkfK4=;
        b=heGMKgeFgjy1o7J7DdhPlYRMqdhIr+JII/bw8w/Xt2YOY1GWJx/JGK1NPsAMXiZno2
         DOd2zEgEmz4W7uH38QjIxax296MsdvrESCHpEV1BxWhHyS5g9Ou37084i24vI3PqeZki
         +DQ/bNwW5T5KjAjtVphCLCJVlDVUoS3mDNNnc7bXpNFsM3rqZVa6saANi/Spvo89DxbF
         FH95s7oy7ZKk1hoZa+efKOwNiPZrDkYfBlG8/L1GC36rZeZUgldWJyEMvV3uJ42Op5C/
         x2HfWwXsSygsi5T66nngJTMehEWffqJy+RNsi/tFG7nkieGDwUsDj+dMwTj2iT37jYmU
         TSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711437846; x=1712042646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ux4IM0v/msnT5HlRHo0+7nKicRE4antbODicCPKkfK4=;
        b=Ec0yLCBMsa0anDVXqXbmz/fm5sOvAago37szheLWXqb6DdyyOduD1NdHNxjDfRUkik
         YKaa3meqbzjj1O0btLfdmQbTfJ/WkowngWQx3bvm+/XqX3tVmmIaVLxTb+CQ7xc/zldW
         v93K666BQTfIPzI/mS1m48btYzv3JZV1MGGhxox+0oszfw0JDCVBOaULU9JBBfT+KEEE
         SURPlJsED7kYEJ/k0/5/ZotRwke6hMeGV7OamdH5nDvDbQsAU+QFKrlLcP6zQv54xyEm
         GyMOx8/BnxzSBDufqx1ELiaMsw5XKsE6eA6n+S7RSdZjXF66oD1m+SYdzUqVJOqcXrTa
         dyLg==
X-Forwarded-Encrypted: i=1; AJvYcCVV7NwK9P7sh4vLlAA6SnoGLx1LunFj87nLezGWLZyiblhrlWutAILXgHaOstOYgu9iukdH/1ZMcuJ+uaKEUGGtVzt1lc8z
X-Gm-Message-State: AOJu0YzIDhZ3hL1Yn+H2T5XHQw1yugSHnM9N1t/qRZRVrbZYQurocA4X
	GilIYqzynoh68aJPEUZ/1jFuN0ZEWKvcXFvv9s3B5QkyWWoTLpia07QyzbhifgcPsD/TcY/DNAo
	4iuZz2y2+F4egALwKTV+LjoP+k0w=
X-Google-Smtp-Source: AGHT+IF+0h5+Ma9GOJRtOW5tMIRyitaTd2HReFeR0teyuX8qVZJGYXQLCxyBE5EKwzFafwH4zXQlzeOqQt6zdiYTGCI=
X-Received: by 2002:a05:6214:5d11:b0:696:5961:e213 with SMTP id
 me17-20020a0562145d1100b006965961e213mr10627816qvb.4.1711437845376; Tue, 26
 Mar 2024 00:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321134911.120091-1-tushar.vyavahare@intel.com>
In-Reply-To: <20240321134911.120091-1-tushar.vyavahare@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 26 Mar 2024 08:23:54 +0100
Message-ID: <CAJ8uoz1+ubemU4FPviGjTgtbW9f37=AxnDVXvkw85d4eQkfzhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] Selftests/xsk: Test with maximum and
 minimum HW ring size configurations
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, bjorn@kernel.org, 
	magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	tirthendu.sarkar@intel.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 15:05, Tushar Vyavahare
<tushar.vyavahare@intel.com> wrote:
>
> Please find enclosed a patch set that introduces enhancements and new test
> cases to the selftests/xsk framework. These test the robustness and
> reliability of AF_XDP across both minimal and maximal ring size
> configurations.
>
> While running these tests, a bug [1] was identified when the batch size is
> roughly the same as the NIC ring size. This has now been addressed by
> Maciej's fix.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=913eda2b08cc49d31f382579e2be34c2709eb789
>
> Patch Summary:
>
> 1. This commit syncs the ethtool.h header file between the kernel source
>    tree and the tools directory to maintain consistency.
>
> 2: Modifies the BATCH_SIZE from a constant to a variable, batch_size, to
>    support dynamic modification at runtime for testing different hardware
>    ring sizes.
>
> 3: Implements a function, get_hw_ring_size, to retrieve the current
>    maximum interface size and store this information in the
>    ethtool_ringparam structure.
>
> 4: Implements a new function, set_hw_ring_size, which allows for the
>    dynamic configuration of the ring size within an interface.
>
> 5: Introduce a new function, set_ring_size(), to manage asynchronous AF_XDP
>    socket closure. Make sure to retry the set_hw_ring_size function
>    multiple times, up to SOCK_RECONF_CTR, if it fails due to an active
>    AF_XDP socket. Immediately return an error for non-EBUSY errors.
>
> 6: Adds a new test case that puts the AF_XDP driver under stress by
>    configuring minimal hardware and software ring sizes, verifying its
>    functionality under constrained conditions.
>
> 7: Add a new test case that evaluates the maximum ring sizes for AF_XDP,
>    ensuring its reliability under maximum ring utilization.
>
> Testing Strategy:
>
> Check the system in extreme scenarios, such as maximum and minimum
> configurations. This helps identify and fix any bugs that may occur.

Thanks Tushar for this patch set. A year and a half ago, we had some
bugs in this area in the ice driver, so these new tests are very
welcome.

Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> Tushar Vyavahare (7):
>   tools/include: copy ethtool.h to tools directory
>   selftests/xsk: make batch size variable
>   selftests/bpf: implement get_hw_ring_size function to retrieve current
>     and max interface size
>   selftests/bpf: implement set_hw_ring_size function to configure
>     interface ring size
>   selftests/xsk: introduce set_ring_size function with a retry mechanism
>     for handling AF_XDP socket closures
>   selftests/xsk: test AF_XDP functionality under minimal ring
>     configurations
>   selftests/xsk: add new test case for AF_XDP under max ring sizes
>
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
>
> ---
> Changelog:
> v1->v2
> - copy ethtool.h to tools directory [Stanislav]
> - Use ethtool_ringparam directly for get_hw_ring_size() [Stanislav]
> - get_hw_ring_size() and get_hw_ring_size() moved to network_helpers.c [Stanislav]
> - return -errno to match the other cases where errors are < 0. [Stanislav]
> - Cleaned up set_ring_size() function by removing unused variables and
>   refactoring logic for clarity. [Alexei]
> - Implement a retry mechanism for the set_ring_size function to handle
>   the asynchronous nature of AF_XDP socket closure. [Magnus]
> ---
>
>  tools/include/uapi/linux/ethtool.h            | 2229 ++++++++++++++++-
>  tools/testing/selftests/bpf/Makefile          |    2 +-
>  tools/testing/selftests/bpf/network_helpers.c |   48 +
>  tools/testing/selftests/bpf/network_helpers.h |    5 +
>  tools/testing/selftests/bpf/xdp_hw_metadata.c |   14 -
>  tools/testing/selftests/bpf/xskxceiver.c      |  123 +-
>  tools/testing/selftests/bpf/xskxceiver.h      |   12 +-
>  7 files changed, 2376 insertions(+), 57 deletions(-)
>
> --
> 2.34.1
>
>

