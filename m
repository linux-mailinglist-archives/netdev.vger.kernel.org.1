Return-Path: <netdev+bounces-224840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06BB8AE04
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3157F16FF4F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB4257435;
	Fri, 19 Sep 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9RyELWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA22246763
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305592; cv=none; b=QVXjCYlpigthMkT3GbXkLqDmIZke3O6kS12OUXwaoS/EwgqLuZfMer0PwFULumkmRTWO/URsajWHRod/KeEYc31sQ7ZDvGgL9XLIiBsesPlaUDkXHoLEHKgJ/7GlP3R8+lcHOGm2qBA7kCqo4LxJ63f2GZWxwvdcnZSWjYkzkoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305592; c=relaxed/simple;
	bh=jaY6ejGzMgXQA75oPGEkZmUwMwJGET/08F5M8zlsd2s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K6lhNvYYevwOGsHqalGGgCjaJIUvxa7napNV4Ila3Ny+fI0uufoXJXCoomjGj5yoiRWe1taMDOD/ngxICSCtmCUyuzY74c7PTcuLsnnOILMT+ThBB7gS7/Q81oQUHqu4IiOF3fqKVCgYDKiCSuf3UZ3Tp+hMTVJAAEw5QSfpR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9RyELWQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso1720442a12.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305590; x=1758910390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ZeJg5CWqbF3IY/EPyUo+KxVGz14Tjmz+KQ4KkqtqRM=;
        b=b9RyELWQX9tH9bmkLO8H3gDwXIkxu59MYmPpC+QOswfqorSHdg7AoYsQRYbpE72IQ4
         jeeqhAKmj05S6ElXWguEwK6RfpR0v/8PBxZRhYW/zgSC2NgTT72fEKJlk5bL8OlFD7Bj
         RR/DuXz6moGLTEmd89+5sz2e1SmPLdYnCjPKpwQkz90vuC3eUOcCW+ZqXhMZNRVcbCSF
         /0GXTfsk0K9U3fxT1opp0hrfMHSRRIjWjBTMaMIT65hhudpiueJCI62tppTOhbugeHHs
         ZXCwowRTC8B+L775x4N+cBT9jsVigIz9yWr/cDj6nphhZuuBYD9hNIOTrUTx/qKIr8uj
         IVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305590; x=1758910390;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZeJg5CWqbF3IY/EPyUo+KxVGz14Tjmz+KQ4KkqtqRM=;
        b=PKNXR/2iwLj4CTCAjr6+/6x6Ass5Ue9x3QekJluzGAfpMD0SF1v1KU0d7rkF8sXHPm
         j4BcLRIUvFNAYQKLdcAJX0Rp42bDwTCkV1ISBCnz/N6hQ7Q09BBdDwrHf/oZeEyaD/eb
         SZsdJoh0VKVMZRaVero8H6BIh1j7eGtgl5pOU9yAAv+SogIBsloL74IBm2U/vkKECM39
         27o3kNWbCQmN1F/LHb7ZTx9/OCPZxibP5lPbLgQbJS60EASDw3u+7CcaocEqrGYBR9Nr
         McII65j7j3DCt/2egEKfIg5oB2vU13/RckOsPm9tSqetaXVczhi6YeovTG2wF5D76pr0
         Qr+g==
X-Gm-Message-State: AOJu0YwEpyAAqkXz15h6FXYrSDHN+N/W/HkX0rthglPQq6QMUFIZZKp5
	/EaWsAYQEUHKNiEqQpgeBzDEW411oCgUEegQdc1qhuTw7nqyfeEij/DX
X-Gm-Gg: ASbGnct7OVxyvIHlGuBu10TSZf6xpDO2yw8oYY4MF/UEqmfrDyljvddQCuJmmNcgG4/
	pY8KNe5GeeKSetxq5Z3iwXH2HIyltWC9WFFKIuqrY9Sk9dKmXdvEiNocVA/BLHItkG8d055rxuP
	COQciHxyWvhmGgd8NDbKYvzlSLuDX+yIoLx+z2RXNaXEg5MrHDyNDFQK2b9+61FU3gKVJAKvDEl
	2qpXt2xn+u+jimRM46vYh1ESsprzdgpxjUWbzMHImzwkP8lJT8mSYOo1kpgnq+zJ6Ly85H8zBMW
	lJ/32KCE9kZe27ts1MlJ9C6MIKu78fCAhj8Bu9EdxyvkvT06gfWcXvGGTwuX65gv9Ub3HPgSwdS
	NzBNwHAKYdz53+4ywCyCBi9nLRcPWGZpnwoS7sQ9arpuMWS58U5n+NX7Afx8+Ac9xbkDfLVxzUg
	==
X-Google-Smtp-Source: AGHT+IGCL/sBx9Oro0ib1IiABvpyb8htBPym0mj+EhPRxKOWXoR2p/j0I4C4V+8NTmnuKjfjEwIE6w==
X-Received: by 2002:a17:902:d2d2:b0:25c:e4ab:c424 with SMTP id d9443c01a7336-269ba534e05mr69731175ad.33.1758305589727;
        Fri, 19 Sep 2025 11:13:09 -0700 (PDT)
Received: from [192.168.1.77] (c-76-146-12-100.hsd1.wa.comcast.net. [76.146.12.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368dc1sm59570565ad.152.2025.09.19.11.13.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 11:13:09 -0700 (PDT)
Message-ID: <bb70ed5e-48cb-41e2-921f-591fd619f304@gmail.com>
Date: Fri, 19 Sep 2025 11:13:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/6] Add kfunc bpf_xdp_pull_data
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, paul.chaignon@gmail.com, kuba@kernel.org,
 stfomichev@gmail.com, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 noren@nvidia.com, dtatulea@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, maciej.fijalkowski@intel.com, kernel-team@meta.com
References: <20250919180926.1760403-1-ameryhung@gmail.com>
Content-Language: en-US
In-Reply-To: <20250919180926.1760403-1-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/19/25 11:09 AM, Amery Hung wrote:

I sent the wrong one. I will resend v5. Sorry for spamming the list...

> v3 -> v4
>    patch 2
>    - Improve comments (Jakub)
>    - Drop new_end and len_free to simplify code (Jakub)
>
>    patch 4
>    - Instead of adding is_xdp to bpf_test_init, move lower-bound check
>      of user_size to callers (Martin)
>    - Simplify linear data size calculation (Martin)
>
>    patch 5
>    - Add static function identifier (Martin)
>    - Free calloc-ed buf (Martin)
>
> v2 -> v3
>    Separate mlx5 fixes from the patchset
>
>    patch 2
>    - Use headroom for pulling data by shifting metadata and data down
>      (Jakub)
>    - Drop the flags argument (Martin)
>
>    patch 4
>    - Support empty linear xdp data for BPF_PROG_TEST_RUN
>
>    Link: https://lore.kernel.org/bpf/20250915224801.2961360-1-ameryhung@gmail.com/
>
> v1 -> v2
>    Rebase onto bpf-next
>
>    Try to build on top of the mlx5 patchset that avoids copying payload
>    to linear part by Christoph but got a kernel panic. Will rebase on
>    that patchset if it got merged first, or separate the mlx5 fix
>    from this set.
>
>    patch 1
>    - Remove the unnecessary head frag search (Dragos)
>    - Rewind the end frag pointer to simplify the change (Dragos)
>    - Rewind the end frag pointer and recalculate truesize only when the
>      number of frags changed (Dragos)
>
>    patch 3
>    - Fix len == zero behavior. To mirror bpf_skb_pull_data() correctly,
>      the kfunc should do nothing (Stanislav)
>    - Fix a pointer wrap around bug (Jakub)
>    - Use memmove() when moving sinfo->frags (Jakub)
>
>    Link: https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/
>    
> ---
>
> Hi all,
>
> This patchset introduces a new kfunc bpf_xdp_pull_data() to allow
> pulling nonlinear xdp data. This may be useful when a driver places
> headers in fragments. When an xdp program would like to keep parsing
> packet headers using direct packet access, it can call
> bpf_xdp_pull_data() to make the header available in the linear data
> area. The kfunc can also be used to decapsulate the header in the
> nonlinear data, as currently there is no easy way to do this.
>
> Tested with the added bpf selftest using bpf test_run and also on
> mlx5 with the tools/testing/selftests/drivers/net/{xdp.py, ping.py}.
> mlx5 with striding RQ enabled always passse xdp_buff with empty linear
> data to xdp programs. xdp.test_xdp_native_pass_mb would fail to parse
> the header before this patchset.
>
> Thanks!
> Amery
>
> Amery Hung (6):
>    bpf: Allow bpf_xdp_shrink_data to shrink a frag from head and tail
>    bpf: Support pulling non-linear xdp data
>    bpf: Clear packet pointers after changing packet data in kfuncs
>    bpf: Support specifying linear xdp packet data size for
>      BPF_PROG_TEST_RUN
>    selftests/bpf: Test bpf_xdp_pull_data
>    selftests: drv-net: Pull data before parsing headers
>
>   include/net/xdp_sock_drv.h                    |  21 ++-
>   kernel/bpf/verifier.c                         |  13 ++
>   net/bpf/test_run.c                            |   9 +-
>   net/core/filter.c                             | 119 ++++++++++--
>   .../bpf/prog_tests/xdp_context_test_run.c     |   4 +-
>   .../selftests/bpf/prog_tests/xdp_pull_data.c  | 176 ++++++++++++++++++
>   .../selftests/bpf/progs/test_xdp_pull_data.c  |  48 +++++
>   .../selftests/net/lib/xdp_native.bpf.c        |  89 +++++++--
>   8 files changed, 445 insertions(+), 34 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_pull_data.c
>


