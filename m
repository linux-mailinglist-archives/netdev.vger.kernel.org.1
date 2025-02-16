Return-Path: <netdev+bounces-166787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90986A374ED
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 16:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F2216C664
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D608D199252;
	Sun, 16 Feb 2025 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ThQddU+R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116711991AE
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 15:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739718680; cv=none; b=oB2jUlHbwqV0MjylYzSnvuYZCfQBrwKNXJx5kdXNOa6elqoDbCKLNg2qY7tCOrSkwKXyt67MxiJqbNE7I8brFpupu2p2H69ndhtvFDRoGswJI3cw/gDVT6ZPxOfYryj2krZy2a79nhJhfhd6KSvrjSRe3hBdx+E+YEPlVOpQVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739718680; c=relaxed/simple;
	bh=4IQ0g5KvyuNbmI4QCx+VPX0qeUVxl+rCSR4p41A6Qs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7J+PIeYZTi7JmOcq/36/AIsm92Jynxon4jF78sQuYIetEpRZQ7XxBI7sGvqrY4Dr9IRRmazOGU0UxHbj+SzV19CVDhazrBrmq5EJ+t469ovgrim63RHwUd5h34ETCgMYQsPmBxHb3aTBBh6I2V0TJPzPdE6rI+1mzvOOLiHq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ThQddU+R; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaec111762bso814908566b.2
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 07:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1739718677; x=1740323477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=ThQddU+RMy7z0OSUJzzrS1h5g8C+aFHJEUpCeFTZIJjxuUuZtdmKhMSIQC4n94wsMA
         pDafPzHJ9SHhih0K2pNSaOECzLZF2sw4Sflu7Qp9Vp/gSgbYl4P5wPj+NSMhOmlVag/O
         q5meUpCfPzJgianjuaexCNE60Mhx7lfj6eiEJssnoi6ar4ubQDGV7uOkoD2r/g+JPqtM
         IEGNyUMPGTvd3GsvqA2z/npDltepLpNt/hTdYtVUtJ8bezynKDFcwYf7dPxWYQcun3N5
         uyEk8WG+9L3ZE3iHT6G7jtFsOEKGOGhAwvBnTkk4SdNdvPB779Th13jhGSsyKHpPBeBN
         xLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739718677; x=1740323477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxEs174tgEejEhOGBs+mL3V6fq9DUU/u2mDzbjv/spw=;
        b=kxU1M7fg2Y9mQcUv7Vcz2/c+3gsAUS93d1E0At9PAIrV+yHGWmQZA46q8JkaNtkpe3
         h9vfr9NbVyHqHk/m8cUVLpZkHvDoibAlR+fYnQbEeGBlBLCZdgRLaMQ/RKEKQjZpJgjC
         g/5y732cPmAZsn7gt3i6E6rvL+Txqae6ZmZWz+5JRQ2pbX6alXfr10E9rG1va14DzWva
         cI6BUiC0PW9Tffrg+qkO/2Mlk9v20R189yHG63cDfnKha4H7dqrYXMplA7t7uBmBa40a
         bzagDaDWw6XGzud2/8o7aPBIS3vOq3NThMt0ZenKdGmQ7KO2vppSpo4XBKl3sNek7b8F
         BXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUklsrjMTZ31JQU9gFOkKEzzg5j1klZAh7gdbYbsYP9l1YFTr8L+6PHYpbiVVu4ybQFuvjvNrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPE+CX6nFaxEn89JxNoRTatps7M3c+Rrv2e8Z8wVwc/xOV8yMD
	ljECdwwSeSJ6OL017L6ryMtUbZnKw33pRPOa/itsIYCiMt0yKHqF+ySavVNfFdM=
X-Gm-Gg: ASbGnctjSN8yGvCn1yOpy+oA7xVPDjPggNKOz+MnIPnE6eUfiprdSrnyu0XpErcAG14
	CpmAazBfcZN3/eRGrItQxsKVhAoMjC0n0oCB+2mA0i5TkWmgvvwSkQ4z78CIVKhn6uxl0U7pvbo
	EWaUwX3rslyl9N83rtmgM8IbHFRCfS70aVTFhDnG+oR7wfyvcrKBBJm8OItJ/kgp4HQdFyTJLHQ
	9KCBqexY1Y09lglp3XxdaB1vovmVGChuRDnSvcLrv0Ek4Lj8Lsapo6DEcvLXbbpUeh3Ud5Gx1ow
	nHBHJA9ny2GqYNhzb/9KWMVhfxqnPkCFq2BNCB0NLiAbf/M=
X-Google-Smtp-Source: AGHT+IFJErHfiwjq8OuATuDMBXLWRjnh3cAPDyG+uN8XMo+VzOnpfp01aY9p8urTKh5hiaXOlWw+3w==
X-Received: by 2002:a17:907:7f27:b0:ab2:da92:d0bc with SMTP id a640c23a62f3a-abb70c01ecemr672451566b.3.1739718677216;
        Sun, 16 Feb 2025 07:11:17 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece270967sm5963200a12.55.2025.02.16.07.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 07:11:16 -0800 (PST)
Message-ID: <684bc34c-ae15-4cff-9e44-945294ee233b@blackwall.org>
Date: Sun, 16 Feb 2025 17:11:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net 0/2] bonding: fix incorrect mac address setting
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
 Boris Pismenny <borisp@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250207092920.543458-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/7/25 11:29, Hangbin Liu wrote:
> The mac address on backup slave should be convert from Solicited-Node
> Multicast address, not from bonding unicast target address.
> 
> v3: also fix the mac setting for slave_set_ns_maddr. (Jay)
>     Add function description for slave_set_ns_maddr/slave_set_ns_maddrs (Jay)
> v2: fix patch 01's subject
> 
> Hangbin Liu (2):
>   bonding: fix incorrect MAC address setting to receive NS messages
>   selftests: bonding: fix incorrect mac address
> 
>  drivers/net/bonding/bond_options.c            | 55 ++++++++++++++++---
>  .../drivers/net/bonding/bond_options.sh       |  4 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 

For the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


