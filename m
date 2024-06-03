Return-Path: <netdev+bounces-100182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ABE8D811B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5CB2540D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B9F84E01;
	Mon,  3 Jun 2024 11:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xha9/jXo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE984DEC
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 11:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413774; cv=none; b=X7+/PzHhVWD5a5R8mo1/kuSzR49jzZ3agKBpEnxLpSjYgaO/yu6sYfN3guhUy7Jt8N320pL/zT7t+e44GPsunX7vyxW+6aCaOAjE4kX/JvjOp/fdFuCPYDvEJplNBJtOx6j+pcUtIcXPQMf32RQbI1R3rw2aIxtCecKHjaiLQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413774; c=relaxed/simple;
	bh=G2AXoJWTaAoyfkfoCz6ZyOinQKV1M5bcGxfieTviH68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pjd7AxsWZ3DLpoFM1tIe+wv4wAdt7U57xNHmCDxaIdzlHlytCfpKx6Qnu2wotwpWCO//AF+8P5CNT/plqxebntVClr7tpDBP93P5ugMHpr+tw4CV7ariAKibkMUKYJz/tRRkTWDWMGVmpspC/2zmJoiW799hG3YQt5ACtr6iNEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xha9/jXo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a033c2ed4so2348999a12.1
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 04:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717413771; x=1718018571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mokEQDy1RJCGWxi/+5KZaqblRGioaxI2aR7oEqy/PA=;
        b=xha9/jXo1582QkEMmSO0qigK8gEjcS6YYgLTnDkrk0p3BuveqB4Q4uOEoFscn3kysS
         p44h9p9e1U5uNWsXSRrcHVRVEzAveI4FCXI2SChb+/nsryXtVqQRfvFPcxHtAiLffs+4
         bAdpH7u2hJUXYhtfkGKS7tOIo9zPf6H0fgLeLa5W8sSejXBN1Szb3tTL8NnX4/5YG0hB
         fyzaKl5QcpKZGYnFWRUx6CzVlJToo4gzH3aEpufC4Wwky1RLs5fuNZ6QukFsvc9SdlRc
         koVQKguj5qD9barMYQmcA6TOux2a9vC5nCudcvxytDvKoq6mwSC3PCh8zwDlhdvuIZPp
         LuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717413771; x=1718018571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mokEQDy1RJCGWxi/+5KZaqblRGioaxI2aR7oEqy/PA=;
        b=JaC+g6h+eIrMv2ErFopEPQj1lLrZACLaczvSoV857tObmbCOtoXtKbSCLld5AXblZf
         oIEZZD8YvTzmOLBqnVhZssse7VsDR+YiIxywttSLSZsMNE0kdqSnM4dw1bRK5SkcozeR
         CRIllk9/FeTWAkH7DiBqGgro7cuyLv6tmomnC2+3uLh6yQYOFFdPQFJmq58LUZjpUtRo
         f94G0B9P96GunaSxOGqWmAs1cHf8XPjW5TBXtpQc3ziyapxlBXxy/5eiR2+gUIhaYK0h
         xEUa/RI0piRjBtAqyJ4P0CL5YFgnLncDGjQosqpsIH8ndC9+yjKaPZ8LomfIq3Qysrvi
         D7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWYWU3mvLqhj3Tj4NjlBbLAs7Nwb1uXT1nfIQ3rophe07SXS3BaCKKQIwW1yg6BB9dckHrDNLO9cDBnusTIpxKvwi5wWbQb
X-Gm-Message-State: AOJu0YyjoaMhRnLz80oUKi1mXiAQv2PWCvd9nPmePtK7950rm5b4vLC8
	e5ny1ta5QjeMDuP4opbuddUppwUByCoiYs0F5PwhPMQIuwgFYqv5UbxHFhLXYMs=
X-Google-Smtp-Source: AGHT+IEJ4JA3WwXxRNNtwtkc8f/jOeCsVusfaOUAAy0TpjcK1HBjOvNwFwECFmM8qTbQEqHACqOscA==
X-Received: by 2002:a50:c30b:0:b0:57a:2763:c29b with SMTP id 4fb4d7f45d1cf-57a3647ffecmr6309974a12.41.1717413771268;
        Mon, 03 Jun 2024 04:22:51 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a3ebc6751sm4490452a12.51.2024.06.03.04.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 04:22:50 -0700 (PDT)
Message-ID: <68e734cc-c049-4414-a8a8-47151a7f650d@blackwall.org>
Date: Mon, 3 Jun 2024 14:22:49 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] vxlan: Fix regression when dropping packets due to
 invalid src addresses
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, David Bauer <mail@david-bauer.net>,
 Ido Schimmel <idosch@nvidia.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240603085926.7918-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/24 11:59, Daniel Borkmann wrote:
> Commit f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> has recently been added to vxlan mainly in the context of source
> address snooping/learning so that when it is enabled, an entry in the
> FDB is not being created for an invalid address for the corresponding
> tunnel endpoint.
> 
> Before commit f58f45c1e5b9 vxlan was similarly behaving as geneve in
> that it passed through whichever macs were set in the L2 header. It
> turns out that this change in behavior breaks setups, for example,
> Cilium with netkit in L3 mode for Pods as well as tunnel mode has been
> passing before the change in f58f45c1e5b9 for both vxlan and geneve.
> After mentioned change it is only passing for geneve as in case of
> vxlan packets are dropped due to vxlan_set_mac() returning false as
> source and destination macs are zero which for E/W traffic via tunnel
> is totally fine.
> 
> Fix it by only opting into the is_valid_ether_addr() check in
> vxlan_set_mac() when in fact source address snooping/learning is
> actually enabled in vxlan. This is done by moving the check into
> vxlan_snoop(). With this change, the Cilium connectivity test suite
> passes again for both tunnel flavors.
> 
> Fixes: f58f45c1e5b9 ("vxlan: drop packets from invalid src-address")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David Bauer <mail@david-bauer.net>
> Cc: Ido Schimmel <idosch@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  v1 -> v2:
>   - Moved is_valid_ether_addr into vxlan_snoop, thanks Ido!
> 
>  drivers/net/vxlan/vxlan_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

LGTM
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


