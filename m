Return-Path: <netdev+bounces-153880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2D99F9F07
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B78D16B984
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE01E9B10;
	Sat, 21 Dec 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Ibav1y8J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866DF1AAA3D
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765766; cv=none; b=h6r/YbmCPUrlQNvGvjiR0AR9hyv6Ak5NQdAOJvB0o/q4BtiiK0kwwhLHnujLU/8KHUsEEgLRL4LLRa6ePIzaBy9dkaKRq8I8AMckpvnGVjHNExOUen6HsZ/Fy3iJi8quf4qYwjgqqypSsG278dlmjD5rFufadOXQQmbera/Xt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765766; c=relaxed/simple;
	bh=0rAosgF3Ztuz5d8Yvh86KvdnQ2ufSZRKMNHOv7KYSTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfM6y6B6IDyQzMdDqDp+prWAtHO8EFdSO3AGu8hCJEmtLIxjW/zltqLZvwaQAaswjtm9EqHalPKtevHwUT/kkq+77YtJNfS7xRrXQsRRXF3NDzj5SX2KE0WEDVSQ1naw5D3aFuqKdWhiWkqBQLgJxjIkIVRU7Ey414gKHCl67EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Ibav1y8J; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863494591bso1428826f8f.1
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765763; x=1735370563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EUlBe1ti783aJq8oYTzxxJuGG7AnBX8HC1zASLsrUg=;
        b=Ibav1y8Jf0i4VecL5JpNV3A72I3nXExj45em048cNfQN10o2pkTskbx5HFiZe57UfR
         AROUZLNPjXVKYBvNVa7JaL4yhH50/rM4v+9pu2ovYmm5nqIG52SfoqXzfuMlGhuvZFqM
         vtMoR63Mb5CptFh/T65Jf3PJXlkfwsOqc5SzfntXMAbx7285o7SPVzgjH5cGLeWOmO61
         QfD+XXCSWRhwFGmlg1b22VRqwM6EoWyyCWV0pA27I2p7Xjpm7e3vR6Gd24A05Rp/98WU
         YkwpzwCjPofyRpxTqhpXl9iFSU19rm+82Bvl4Zh4hsLb0n2WSBj5rUB+hcbveo+kuN56
         Au5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765763; x=1735370563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2EUlBe1ti783aJq8oYTzxxJuGG7AnBX8HC1zASLsrUg=;
        b=vQdTyjyGzF2wLrwF/pTmzPxq4RAKSuFZpUye+Du3PGhwCR0W+3f7WhAyfYFhpHNkHK
         YyZOXuT+3bdayp6xNHWWW0v9j3Tqa9iVZMyej+0jhhFeIOtxapcjqYOTcOV3Xp/M7pfW
         EYu0WrtZ2DE3ESVXNeFWhSFiXMrQyvWuCcei3hw+lkxIdGtj1j/WIcw00iUlqCTxVuXh
         TMGuKazuTGGiXNhjqJguqFju4GmSMqyaB6zbQygN6/GDFAAVlHss/1ZblpzkOHaAukIP
         eoqIU5d9fQyH5NyNLIGl25vI1bdXPS0nZMR1HGB4qpN6UlkTkdhGSEWezaXO7mGdUY+X
         c2Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVeGDMb6GWASbMwNFit0Ys4qPlMUJTXCoEXPF5l+tCQkSJ0fMZlC/Y9v4PswAzNSbr2ubvsAcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yLEGZUDWFkkV92T9eb5eJNNQH9OM2TUsM3OncEjRHVqjDD/c
	e39fk9vsdZagjqTkRZtSbHA0mgC6sjepM8lk9Z8AL6jjOsSe2bx36chFW4hVIPQ=
X-Gm-Gg: ASbGncvH2VU6wfnmZRkcsgEkD8jJEsrDTNZMmp6zSN4/TniNQoK6U5H1d7DHChDkVnQ
	w5wu17UnJxylYEMwv3IElSIQ5rFQhfzLDnrdpS9rOJ0a36kYjtrxNJepR85yh1OOYuk1iU6ypuT
	JhbvRwD+wbMpbeaIgqy2frQOEInGGtSoAVDD06MiV+Va1aFMEBde40KzTexZRu2F20zzvY6rwwS
	eWn6pAIV1ZVbHl6+8McFDjlXp5R0tPUOCZv2T4jJdtZFEjzs8raH2e/8G+SW62xUoOUWhXzrxQB
	43Ya45HKsv2S
X-Google-Smtp-Source: AGHT+IEb7LQUNtCxYlO/uzup8sRen9gVLF0bzI6pmzmw36NSidzZZ11gwIBnl8/npx6c01D8spL8yA==
X-Received: by 2002:a5d:5f95:0:b0:385:dc45:ea06 with SMTP id ffacd0b85a97d-38a221fab2dmr4994638f8f.13.1734765762909;
        Fri, 20 Dec 2024 23:22:42 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm5752647f8f.103.2024.12.20.23.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:42 -0800 (PST)
Message-ID: <960da366-baf5-4b27-9583-579534e5ee00@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Extend netkit tests to
 validate set {head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
 <20241219173928.464437-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Extend the netkit selftests to specify and validate the {head,tail}room
> on the netdevice:
> 
>   # ./vmtest.sh -- ./test_progs -t netkit
>   [...]
>   ./test_progs -t netkit
>   [    1.174147] bpf_testmod: loading out-of-tree module taints kernel.
>   [    1.174585] bpf_testmod: module verification failed: signature and/or required key missing - tainting kernel
>   [    1.422307] tsc: Refined TSC clocksource calibration: 3407.983 MHz
>   [    1.424511] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x311fc3e5084, max_idle_ns: 440795359833 ns
>   [    1.428092] clocksource: Switched to clocksource tsc
>   #363     tc_netkit_basic:OK
>   #364     tc_netkit_device:OK
>   #365     tc_netkit_multi_links:OK
>   #366     tc_netkit_multi_opts:OK
>   #367     tc_netkit_neigh_links:OK
>   #368     tc_netkit_pkt_type:OK
>   #369     tc_netkit_scrub:OK
>   Summary: 7/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  .../selftests/bpf/prog_tests/tc_netkit.c      | 31 ++++++++++++-------
>  .../selftests/bpf/progs/test_tc_link.c        | 15 +++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


