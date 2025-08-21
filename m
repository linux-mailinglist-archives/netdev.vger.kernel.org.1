Return-Path: <netdev+bounces-215533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C32F4B2F01D
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D8C5C3830
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99827991C;
	Thu, 21 Aug 2025 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC63UWA5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0532B21FF28
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762724; cv=none; b=Ky4Y13TYVxR2B2aCu8Z6STqW8EQU5Qwa4IGOzdx/jCyeIv+P95ewsUZqfEzFOBW3jjwgtqWdu8ka3aR97ahIRT7fCQW9vBSis+G3LYU4aVFcEITjErSSHy/xiZBwKjz8ffkt9TCpxfzbsVIKJCA48ipvqMJWP1qYcSNvWHslcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762724; c=relaxed/simple;
	bh=7ZmxhJsGOT+T4+UKUfQqApQ36bzEPa+HjY77g59zyvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaDaOYnTcMgPXo8CYyWaKEfq+dtvhYpCHzqEJaxkR5qAAsoQY2GCzYRu28/dFwR8AZ/kFuKsgxzc5Oi5ZPzMvizajg1u838RipVU4rRdFgTUAFD6vZ1SNgVdI+Hot9qo90V1FB4RoDu54ptJN/Up5dSEWkXWiP4rErI9jfQ/94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC63UWA5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755762722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=esXsitI277rHDT8/MgHr8IhcHQcwLfQND8OByi3H/q0=;
	b=gC63UWA58XrtEurXDCWl7dO8DF6QPI1tpPFqdqkTpdnttxsrWREA6tbMLAbDkTLZfQDe8V
	YEEMGDRby+nVCnv/lImRmp0W1nT0SSft05uXVOvenhe0yz4Vsj+PBkGPJA20+OEEiYp2+S
	Yqrp/VpU2gMGPm7lY1hEpX5mGvlykLg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-O5ryc6z1OsS3_9Kgf5m-yQ-1; Thu, 21 Aug 2025 03:51:58 -0400
X-MC-Unique: O5ryc6z1OsS3_9Kgf5m-yQ-1
X-Mimecast-MFC-AGG-ID: O5ryc6z1OsS3_9Kgf5m-yQ_1755762718
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0060bfso4025695e9.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 00:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755762717; x=1756367517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=esXsitI277rHDT8/MgHr8IhcHQcwLfQND8OByi3H/q0=;
        b=TXDXUdROesfEY6EkhXHGVfbYZ/hS2iebbO8jb8LRP5FFPI1yERzuMAt/N1SmF64Usb
         RYSwXya+fQq1CDNP6h4dn64iwSWfy8oUGUEY33exRWJl6VXWDgP3kGcWb3pEtk2T46yF
         q8eZhzIh2hdPW8Qn/q90VCw9BpzNOQYyxYSk6HXQdYQhHnYP1bHbB26I9OpWydG3UMm5
         VZEzV9SC7AHbEsAbIcNQ8fIsyUuAaLDsizEncwCnrk5com1FZbaHUO7WltdFVY74Z8fa
         7G3KWX8XrZR8n6iMGg/HOnJJ+mJ6vj58HuEWF00+VkDxtvuqE7aPZvFrXMF1ZHYP2wtx
         dymQ==
X-Gm-Message-State: AOJu0YyDRBzBJxPEnfSZAJgkMOtXP5YyePLA2nWsnxVsFgIEZ5kyZ6Co
	HSTeAAi4ku6tfqK5QdC1qNCYR2SyC98Gjqg4EqRqWe8sfbQLy5koDg7pSc2UwJYNFCqOd0vNipB
	xM6Ox0f8foek6CssZWCVJi/CR8/kK8wDVk9zeU3TLH0PyeVaXh90yIpPwJg==
X-Gm-Gg: ASbGncv57sjMcFhG7/Xx0MXyfYjgtfCZJ3ZYRfbHHX/DUFcTrK4MY346UF8D/v1FLk/
	sgGB5rmpbjj7z3KyYRQLGcqNhxrkKc+cORc1rteDgJVRyfwRoZhaxoAySR3+WefrT1SxeLQ+Uh9
	NQBdqeAEYa3nCqG4Z5OpIy+pvc0tV0cgHYVlFuipHJI8DKFYYdzEfexaR+Ds/F5MzyQmmemoEOS
	jObDbiDPUg6J8FdCyLFpOscMMYofpkmXSOXJi3bsf5eaFGyCoNDAQZbdglH1vG1TP8U4H28iedE
	Unj4B/tH93pG8ml3SVP91m6lVe5l/Q+W1QNQiQfhAT7fswzv0WZrS4jPvHGAGMleGvelWW+qVBU
	KAF5cQ+6wFCo=
X-Received: by 2002:a05:600c:4588:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-45b4d74abdamr10630715e9.0.1755762717466;
        Thu, 21 Aug 2025 00:51:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGefUJgjP1LDgopNEU5Da1SpJpUXM62EJ1FqtWMXZBodlhTumUctQEn8wN1D8mnpzjefR0lPw==
X-Received: by 2002:a05:600c:4588:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-45b4d74abdamr10630515e9.0.1755762717033;
        Thu, 21 Aug 2025 00:51:57 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db296aasm17238515e9.7.2025.08.21.00.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 00:51:56 -0700 (PDT)
Message-ID: <5bba5969-36f4-4a0a-8c03-aea16e2a40de@redhat.com>
Date: Thu, 21 Aug 2025 09:51:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/15] eth: fbnic: support queue API and
 zero-copy Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, almasrymina@google.com, michael.chan@broadcom.com,
 tariqt@nvidia.com, dtatulea@nvidia.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, alexanderduyck@fb.com, sdf@fomichev.me,
 davem@davemloft.net
References: <20250820025704.166248-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250820025704.166248-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/25 4:56 AM, Jakub Kicinski wrote:
> Add support for queue API to fbnic, enable zero-copy Rx.
> 
> The first patch adds page_pool_get(), I alluded to this
> new helper when dicussing commit 64fdaa94bfe0 ("net: page_pool:
> allow enabling recycling late, fix false positive warning").
> For page pool-oriented reviewers another patch of interest
> is patch 11, which adds a helper to test whether rxq wants
> to create a unreadable page pool. mlx5 already has this
> sort of a check, we said we will add a helper when more
> drivers need it (IIRC), so I guess now is the time.
> 
> Patches 2-4 reshuffle the Rx init/allocation path to better
> align structures and functions which operate on them. Notably
> patch 2 moves the page pool pointer to the queue struct (from
> NAPI).
> 
> Patch 5 converts the driver to use netmem_ref. The driver has
> separate and explicit buffer queue for scatter / payloads,
> so only references to those are converted.
> 
> Next 5 patches are more boring code shifts.
> 
> Patch 12 adds unreadable memory support to page pool allocation.
> 
> Patch 15 finally adds the support for queue API.
> 
>   $ ./tools/testing/selftests/drivers/net/hw/iou-zcrx.py
>   TAP version 13
>   1..3
>   ok 1 iou-zcrx.test_zcrx
>   ok 2 iou-zcrx.test_zcrx_oneshot
>   ok 3 iou-zcrx.test_zcrx_rss
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Blindly noting that this series is apparently causing a few H/W
selftests failures, even if i.e. this one:

# ok 2 ping.test_default_v6
# # Exception| Traceback (most recent call last):
# # Exception|   File
"/home/virtme/testing/wt-24/tools/testing/selftests/net/lib/py/ksft.py",
line 244, in ksft_run
# # Exception|     case(*args)
# # Exception|   File
"/home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/./ping.py",
line 173, in test_xdp_generic_sb
# # Exception|     _set_xdp_generic_sb_on(cfg)
# # Exception|   File
"/home/virtme/testing/wt-24/tools/testing/selftests/drivers/net/./ping.py",
line 72, in _set_xdp_generic_sb_on
# # Exception|     cmd(f"ip link set dev {cfg.ifname} mtu 1500
xdpgeneric obj {prog} sec xdp", shell=True)
# # Exception|   File
"/home/virtme/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py",
line 71, in __init__
# # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# # Exception|   File
"/home/virtme/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py",
line 91, in process
# # Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT:
%s\nSTDERR: %s" %
# # Exception| net.lib.py.utils.CmdExitFailure: Command failed: ip link
set dev enp1s0 mtu 1500 xdpgeneric obj
/home/virtme/testing/wt-24/tools/testing/selftests/net/lib/xdp_dummy.bpf.o
sec xdp
# # Exception| STDOUT: b''
# # Exception| STDERR: b'Error: unable to install XDP to device using
tcp-data-split.\n'
# not ok 3 ping.test_xdp_generic_sb

looks more related to commit 2b30fc01a6c788ed4a799ed8a6f42ed9ac82417f
(but ping did not failed back than)

/P


