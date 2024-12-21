Return-Path: <netdev+bounces-153883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E129F9F0D
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8FC188AD3B
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AB81EC4C1;
	Sat, 21 Dec 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="CtdJKTsk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236D1EBFFA
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765851; cv=none; b=iv05VdOTX+wVdQAOYTEdSBq877z/O4WMbDlNJ9xxkLOUZ/Arb0iPt4+gKe1smkUXq7qRbMUPAkcnaYWvwMrMgTfwA0PAPw48RlXjoP/xz8DkKXjwfkREkiufyl7kxYENhoAGFq6Qw/on2Y/y8rBisG1y9Pk2hr3rawSGlLdt8yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765851; c=relaxed/simple;
	bh=vk60omweXjX6SnQqQJyR2j+N9Ja1OJHyKZkcgTBw5QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJMHqTNoCV3jj9SE3nH/OUUAue8ZnRlf1QxiUXd6ojEonQV3YFuqtm5UttBq9ydNz/TX9kACDy5EyXFx/k1l85Ms5l0Qunt6cQVXjJk5HZgf7v986nsv0gdm3E3otycdbrwiSgnUMRV16AJXNG4ZPNFmVqCja2asrKg0aM+ZnWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=CtdJKTsk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so26487605e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765848; x=1735370648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGEFp1KPbeLDL94qhspE2PUo2l278kl6WFBceVcNGBk=;
        b=CtdJKTskldDvq1OcpJLXi0jtnZST9yDZsoanwgEeXwTwKiWhCbiLZ4HovZlRi7Bhba
         lMdPxXOjWnGq0ekwc6EtOUbzWny1HhXPW+erVnutQexsTxyAA6k4Cst6VX2v5BktHOZM
         /wCwIMIGVnCrd4ZxlzklWhug8Np4vnFDlrcJ6oSqF3ANtjpWzh2VUUvy8wSWyszNz7WU
         a27ng33jAAiThyKN/WhS/PCx6yeuSHlxgfWuRO5DDdotoYuaLRrC9Jvgk/HmQUnZvHfX
         8xA2/xHzdNi6XUPHPq3u5GQh2W7sn6upIvCW35nm10BhoQTzvPhQPX0eHc8fpnhqJMsz
         2svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765848; x=1735370648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGEFp1KPbeLDL94qhspE2PUo2l278kl6WFBceVcNGBk=;
        b=OjtEP+gP2U472MDOMEuW1lcXILJOk0brS/P1EiXKAvAzIkQfhj9CU1bTX58++bbbOm
         TkxfmmNnzCdGc2regs+1WNNu7hzABikRGxi3SBU2k1vAV1YKkSP6ItDz07ODmv2D/0b1
         ggE6DSiEWFt+dRpUPGg6QTVfHB7Yrq0FjC2yntTgDGsq9CoI/w3fZJBN5m3ZYgW4sR6t
         KfalAFa1apm4vNGklhBO1fBO3sN5jrUWg2ZY60hdWTeU2NgyRtyUbaVqwdxfLcPMnogR
         LKEeb+0eihcW5/wnVtNrRxMz9A64XEZ7aZn2Vkd0NGgpGGuufiVXdNJXgFBHzX/KexaN
         Ob9w==
X-Forwarded-Encrypted: i=1; AJvYcCVJQTycTgNdcagnuX72vMpNmcggLXJqhH6d+S/vfUrJRWDCf/xF7r8fbvquVzJ/GHChmsZu1WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVy8N5FO5tdQrXP+UNcSlHlQDXZlYMg77C5UcqIgYxQxWrFAhV
	SbVfRnrG7MzQgHnCgk87RANlfGldK3Z0LLJeC7g79tWMohQkmPo3VphKHiRZy08=
X-Gm-Gg: ASbGncv5MmeTolPVVK8TCWhJmolV7AUm4miM217ybXNE+yaCsbxT4DafcTFvsZE3uU4
	i5hNiWH3r2/QtdmZkvwaB0T5U9/N0N05G+uKPJsbJWvwwRiABLEKDNfKdiNVs7JtBL097zsl/gY
	9HQQmZepgYayS92YwVF483YoEUPl/8KAJnabTq8aZfM9jHfAxNR7V9xEicBy7TBVDevFAYIbIUb
	9mIevFEMd0RfiICGIub8YxjDzc7PlVNqCSIwlog2kBwyTwsfjFfqFvgOl1dmyeofDwK/WtjmmCL
	w4QNETLf0KWT
X-Google-Smtp-Source: AGHT+IFK4C/XgshfBwOKq/NkUSSIx04Y0eC4xtK3xybQdj6GwzPmOY1eORzQR2obtBLIIkIuUgUzlQ==
X-Received: by 2002:a05:600c:6b64:b0:436:469f:2210 with SMTP id 5b1f17b1804b1-43668548aa7mr37920275e9.1.1734765847845;
        Fri, 20 Dec 2024 23:24:07 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm68543305e9.5.2024.12.20.23.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:24:07 -0800 (PST)
Message-ID: <f1652194-13cf-4304-a81a-a3de91d4b839@blackwall.org>
Date: Sat, 21 Dec 2024 09:24:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Extend netkit tests to
 validate set {head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241220234658.490686-1-daniel@iogearbox.net>
 <20241220234658.490686-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241220234658.490686-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 01:46, Daniel Borkmann wrote:
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
>   v2:
>     - Rework to pass flags to create_netkit
> 
>  .../selftests/bpf/prog_tests/tc_netkit.c      | 49 ++++++++++++-------
>  .../selftests/bpf/progs/test_tc_link.c        | 15 ++++++
>  2 files changed, 46 insertions(+), 18 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


