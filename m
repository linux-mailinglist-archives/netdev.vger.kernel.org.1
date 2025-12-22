Return-Path: <netdev+bounces-245729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA5DCD6510
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 15:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 224933016A1B
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 14:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998429AB05;
	Mon, 22 Dec 2025 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqWNEFek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0E299AAA
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766412332; cv=none; b=JpFiX8ZPGke1l0t0iXHKzRkJTjloeCTtdcyp3WerkRXv1xnu2tgCvwtUKhH3ml0hKNA1zs9Tmz8OM/oT3T85dzqOe9lBqtTqIIM13QzD4fnXtZsWn4nYs7BOE9AxNo5BzEYCJzRSpXKfw6vWREEUHH9u1A3qcCteLFwQ+zMgViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766412332; c=relaxed/simple;
	bh=rCbhBCG3kuZSHT0Z+tcW/TLBtQcP4XcZxoEU4yC1TYs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fAK/b9vr2gOZQyQwRK/LbQQ+Ti+iCyTJCEQMuoglPfy4fH7gbxeHeOasnjNlygQNeZh4t6+6Ld7ehqs9j+xzayFcdWkBjppL8fblqtgwdqyPPENIJ9GsPHCqpZqWbhsMLzdnlizHuMBa4HztAD4tdxtbdH7h96MsqSJ5c/AGMCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqWNEFek; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fc0f33998so19457267b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 06:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766412330; x=1767017130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g5xJgwDc/I3k6P8a8DERXiS6hBpdBmZn1zN7X8eAh88=;
        b=LqWNEFeksTDJwAepeAu+ou9Vhw4HxfS6l6kpzW98C3Yx6x0FPTKvQi38CIsLqZqBBV
         lI6nUWrRZD9YFA0AS6emNSbB6wJSt3mTItm1u2C0BYuQexemkUWo5wkpwQUE2zXXe/HB
         6fSuD97+H6zywFRIk/YsFaXKNha8pMnpKKhOQAeDu9WUNISP1dn56Q92C0pC3kpN5GwF
         p7N7mn0HwAhS81zU7B0PVkGOWV9YGFLehlfD2UVS9rptjITMT8F6VguSkijeAdxQuox3
         93Tg17cR6vvq/O12beaTmzcfdCuiNuuyevlPHmdO9bDH3lHPrlN/oFY1XTq9udj7B0MM
         oHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766412330; x=1767017130;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g5xJgwDc/I3k6P8a8DERXiS6hBpdBmZn1zN7X8eAh88=;
        b=sbEmPMF62ziTvWxIE0NNEWMYi0oqJUfGr2m/iSw/ZpGSeqhfJjWE43kt3LnQdrJUYz
         TRrpQ02gSJ7uTb9GZ3n1gsgTCi2p+sSdZ3TVMg1PnQ/ejpH8VGMWHmui7G0IdnoeECJB
         Cr4eUKxgf3r5GxhtEFQp1bS9Y3u51Rwn4SLsazA5FBJJtMmxNJ3i4hjZh31BJ5hKtq9n
         vYEoUFdcBgKLaPzGhu/r4qFqr/jXpUu9T2YMZbztk5RuZElB9HgSZPcL8C5OYvoCF1Rz
         ZFP3WVadycto6fD/KG5WE55VHGbM8KWT13w03kF6dT7HHhZS6C7LIiWkpATcQCDujMHw
         77Gw==
X-Forwarded-Encrypted: i=1; AJvYcCV4A8uGOQhEQc3OZqrNnZZ+F9vZtB0xLLpD3XReHWDM2PBxW+ZRbCR8Ij8y2obom1N4aGvH2AE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrj4/KqOJRPcYpdYZu3d2wGzFVcZqDCP0fFGeX0GlRWhITaTYA
	7LCnPjTog7NQbOv7Zm+OUl8zXKrzn0sRtYZDtcJuvyQNgMFZXnawGlgV
X-Gm-Gg: AY/fxX76mhxDDq3cLQ1M8WlEoW4uvGczqTb3EdLQrTnlTqblK2qJmugQTbBaNQnNpk2
	CykvCcuAseEEzpNis+p9AmQiVr+tGuandasrIofHa/D5OlVbHB/N9ANliq31mdtdv93eEU59uRq
	AsJpFmtl/xf++NDSnquJ00iiBDc3Y+smUI1CdBGiarAzPccXgjEjNfGzV1kdqiEAsJ1UOmc3Ipe
	T5RD/xhlEn4+bsrouRy4bojK6gSMddiuuYHJNY8B9HNRYmk4NlmibAQfYxO7ZdHc+jBWbxQPDZy
	Cm4v/N5LXO+Dhr32fOogNDRm2lOIUx2FyCcFnf18vcTmWZii/WUmcl3XxZZzLpuXMtZ4jSxLbyh
	HNgbL7eNvF8gYPWSdTOWcTZLq9C16231s9gfKh6eshHWhKXushZe0gWGAGB1HmLUWGHyMSlnC3D
	sazdCTatqr4LY+scUNcZ6McopUHztpHdToYS3bJtXCV+P+U4PF0DlEnHgSx1zPaj8OmOE=
X-Google-Smtp-Source: AGHT+IFiYy/DTQmfD2ngTMnemVnYy9HxKB7ZtEM8oUBGcMYzdxIovMGajHGYerKCyJ51HTDGAyq5Qw==
X-Received: by 2002:a05:690c:6903:b0:786:4459:cb84 with SMTP id 00721157ae682-78fb3f709d9mr184034947b3.29.1766412330132;
        Mon, 22 Dec 2025 06:05:30 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78fb4377f5csm43645607b3.2.2025.12.22.06.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:05:29 -0800 (PST)
Date: Mon, 22 Dec 2025 09:05:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <willemdebruijn.kernel.7a5aa1f215dd@gmail.com>
In-Reply-To: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
References: <20251221192639.3911901-1-vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net v3 1/2] net: fib: restore ECMP balance from loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> Preference of nexthop with source address broke ECMP for packets with
> source addresses which are not in the broadcast domain, but rather added
> to loopback/dummy interfaces. Original behaviour was to balance over
> nexthops while now it uses the latest nexthop from the group. To fix the
> issue introduce next hop scoring system where next hops with source
> address equal to requested will always have higher priority.
> 
> For the case with 198.51.100.1/32 assigned to dummy0 and routed using
> 192.0.2.0/24 and 203.0.113.0/24 networks:
> 
> 2: dummy0: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
>     link/ether d6:54:8a:ff:78:f5 brd ff:ff:ff:ff:ff:ff
>     inet 198.51.100.1/32 scope global dummy0
>        valid_lft forever preferred_lft forever
> 7: veth1@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 06:ed:98:87:6d:8a brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 192.0.2.2/24 scope global veth1
>        valid_lft forever preferred_lft forever
>     inet6 fe80::4ed:98ff:fe87:6d8a/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
> 9: veth3@if8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether ae:75:23:38:a0:d2 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 203.0.113.2/24 scope global veth3
>        valid_lft forever preferred_lft forever
>     inet6 fe80::ac75:23ff:fe38:a0d2/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
> 
> ~ ip ro list:
> default
> 	nexthop via 192.0.2.1 dev veth1 weight 1
> 	nexthop via 203.0.113.1 dev veth3 weight 1
> 192.0.2.0/24 dev veth1 proto kernel scope link src 192.0.2.2
> 203.0.113.0/24 dev veth3 proto kernel scope link src 203.0.113.2
> 
> before:
>    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     255 veth3
> 
> after:
>    for i in {1..255} ; do ip ro get 10.0.0.$i; done | grep veth | awk ' {print $(NF-2)}' | sort | uniq -c:
>     122 veth1
>     133 veth3
> 
> Fixes: 32607a332cfe ("ipv4: prefer multipath nexthop that matches source address")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Willem de Bruijn <willemb@google.com>

