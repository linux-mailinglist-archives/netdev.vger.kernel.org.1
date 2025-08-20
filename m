Return-Path: <netdev+bounces-215216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E13B2DAF9
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CA21BC5AA1
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D82DE711;
	Wed, 20 Aug 2025 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irRQTQN6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CF3227563
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689382; cv=none; b=kZv6loqmUet8tCt+BZ1/NUl83jlLFR9kPNIo4+pDjIrqg79UrtmTfeavMV8dpg0bXL1W9yatQNKg8mT5KM1+pvK3XhKyzsUax1koSKRQB+786kW8+4SCGyBmCfN4fkxhy61PM8eQtMSUdllCgXqwIivrZDe+Lbio27nnuviyWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689382; c=relaxed/simple;
	bh=UEhL4WGyy0YR4ZjY0OkUxBKiF7l6OecW0p2yybYFv7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TnVCLETMT37g8FfPsBXzdCUJojC39yu7NrUbJMXnN2mKOVe16sbObdHbOSyiPsKDt7VOIw/2v6DEA1BBravuHOJ4f9eTV2qIUocyWrDsSo4am8qJ/Cou/Du2ropwTE7p1MPnpPRWNHp7z4GSyXY57xIGSqwA3926V/nOvWfwvP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irRQTQN6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b109c63e84so66734631cf.3
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689379; x=1756294179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kjNt1G9RdtKSs/yqIOTqan9jm8RzXkmVU4NzA9StdQ=;
        b=irRQTQN6MwRaqSfOEVeDSDvuqVHyhmr1vfeMdxPgCSJJYojptIKRK7SSSMCy9zY8JE
         z7BKFDBvpKq2r8r411+nCTbCs3aDjjegWcmgKH3pLZIxE8gqMfCvGHpwI0KLOpqWHfWs
         v9yRVPSNgilzELNSkNDBONNYEiGeQp9xaKJIpRr4rDMue8v5pl2lB10Yx71fd3MaMPyD
         yQTCCG+crWsKqSS0hh7vTG6PBolvDPZECWaxKoYhgUJL7PqjqWDoIQoimcC0BaJ0LgZo
         slocbBYavz0NeA05KdQmAWOfqh8NRVlgu+PJiU9hA9zrtgHQI2+Sja1TBqvVVTONhKe+
         +M0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689379; x=1756294179;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7kjNt1G9RdtKSs/yqIOTqan9jm8RzXkmVU4NzA9StdQ=;
        b=Q/Fgd7dh7gcnqSrKHY3VNdWAUxr4bqBKM7JtP8LlFa5Gku+OFx817mQHfDf87AxW1A
         neGHwuE5WwAKNiiZUyWSX9P84KGdjzohozaT3smtx1WcKzAv5mjZ68wAVqPSgDXE3Xqk
         YsqspKZVqI7/MaHLodKAViHayaWMKDCsLDJONzq9WTIh795Nr27eq1cz8LfnxslK88lc
         mkxKYhzGDwjo+wKQWrlDYn0f81zeEj9Sncr2HBcNMAKjd0hssmGYZndNWihnf49XPDhX
         6oQ4hlmOQYhXKDch0TWfHyFhwzuN28MdWkLgGVewnvjpbnzqj9ZLoRFSyT9DqYg6SmvX
         61Lg==
X-Forwarded-Encrypted: i=1; AJvYcCX/pYALGqcdVVOzhTrVHZ7PTmZqo25XoyeJBXEXIEBkf+bIQqp3mw6hkCh1biTwzrgUDFRV4oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAo6uucWndpXKWQOy2hKCJNf4TyGHIlBpE7TrrNWSDvlJzb6Y
	54Ek+vX4u3DhltOoaCXQT87796zLxktQzFpFJ2pSkclDgt3ZRzatR9Qa
X-Gm-Gg: ASbGncs2TEWxrwtuXkDz2VtlnlZyeNhldXyrZKA2zcOkEnsvK6XJ8P7GYta6wYw3T7I
	2e5KwpyZYzQOdMKhvgfVOI+/L9HbQioobUsJ95/pu/GQ3wedf9qqpcthBgazNhNSPhubLLNoB9p
	3U2xh9bJKS+Rp+zLpzp4QZchKmEgyNREP0OKpz4zXcXsEmH2wilaiz8XvvYeaLAQpF3v41iFtfz
	wXQVYZbMUUEXCJWRsDydhCFmmm4zicaAegcw8/X/EFa85nj/iSVgTrDFDFj/MQZ/U6VzzA4PB1p
	JdWc+SIvrPVTNrNp1x6cW3UhzhT7zX0szt2TtkWzMliW1U9NF6Zq/UklrwVp5+EGY33iZGZGtLz
	PwlsYh8BpgaVA0R8A3xY+y6X4L6WTzERkwPoVFjkmmhhU4B0ZnnSOwRG3VSPBvzQPU9S2jg==
X-Google-Smtp-Source: AGHT+IGks/OE0SxtmY7GM5iHuhNMnOm6wb+2K6zRW1D9c2LTTUQcGL7OMNapWOHRaRo6SWIMh10yDw==
X-Received: by 2002:a05:622a:5509:b0:4ab:9586:386b with SMTP id d75a77b69052e-4b291b8df69mr26554671cf.53.1755689379468;
        Wed, 20 Aug 2025 04:29:39 -0700 (PDT)
Received: from gmail.com (128.5.86.34.bc.googleusercontent.com. [34.86.5.128])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87e1c42e5sm920966685a.65.2025.08.20.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:29:38 -0700 (PDT)
Date: Wed, 20 Aug 2025 07:29:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1deb495a9cf2b@gmail.com>
In-Reply-To: <20250819231527.1427361-1-kuniyu@google.com>
References: <20250819231527.1427361-1-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next] selftests/net: packetdrill: Support single
 protocol test.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Currently, we cannot write IPv4 or IPv6 specific packetdrill tests
> as ksft_runner.sh runs each .pkt file for both protocols.
> 
> Let's support single protocol test by checking --ip_version in the
> .pkt file.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  .../selftests/net/packetdrill/ksft_runner.sh  | 47 +++++++++++--------
>  1 file changed, 28 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> index a7e790af38ff..0ae6eeeb1a8e 100755
> --- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> +++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
> @@ -3,21 +3,22 @@
>  
>  source "$(dirname $(realpath $0))/../../kselftest/ktap_helpers.sh"
>  
> -readonly ipv4_args=('--ip_version=ipv4 '
> -		    '--local_ip=192.168.0.1 '
> -		    '--gateway_ip=192.168.0.1 '
> -		    '--netmask_ip=255.255.0.0 '
> -		    '--remote_ip=192.0.2.1 '
> -		    '-D CMSG_LEVEL_IP=SOL_IP '
> -		    '-D CMSG_TYPE_RECVERR=IP_RECVERR ')
> -
> -readonly ipv6_args=('--ip_version=ipv6 '
> -		    '--mtu=1520 '
> -		    '--local_ip=fd3d:0a0b:17d6::1 '
> -		    '--gateway_ip=fd3d:0a0b:17d6:8888::1 '
> -		    '--remote_ip=fd3d:fa7b:d17d::1 '
> -		    '-D CMSG_LEVEL_IP=SOL_IPV6 '
> -		    '-D CMSG_TYPE_RECVERR=IPV6_RECVERR ')
> +declare -A ip_args=(
> +	[ipv4]="--ip_version=ipv4
> +		--local_ip=192.168.0.1
> +		--gateway_ip=192.168.0.1
> +		--netmask_ip=255.255.0.0
> +		--remote_ip=192.0.2.1
> +		-D CMSG_LEVEL_IP=SOL_IP
> +		-D CMSG_TYPE_RECVERR=IP_RECVERR"
> +	[ipv6]="--ip_version=ipv6
> +		--mtu=1520
> +		--local_ip=fd3d:0a0b:17d6::1
> +		--gateway_ip=fd3d:0a0b:17d6:8888::1
> +		--remote_ip=fd3d:fa7b:d17d::1
> +		-D CMSG_LEVEL_IP=SOL_IPV6
> +		-D CMSG_TYPE_RECVERR=IPV6_RECVERR"
> +)
>  
>  if [ $# -ne 1 ]; then
>  	ktap_exit_fail_msg "usage: $0 <script>"
> @@ -38,12 +39,20 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
>  	failfunc=ktap_test_xfail
>  fi
>  
> +ip_versions=$(grep -E '^--ip_version=' $script | cut -d '=' -f 2)
> +if [[ -z $ip_versions ]]; then
> +	ip_versions="ipv4 ipv6"
> +elif [[ ! "$ip_versions" =~ ^ipv[46]$ ]]; then
> +	ktap_exit_fail_msg "Too many or unsupported --ip_version: $ip_versions"
> +	exit "$KSFT_FAIL"
> +fi
> +
>  ktap_print_header
>  ktap_set_plan 2
>  
> -unshare -n packetdrill ${ipv4_args[@]} ${optargs[@]} $script > /dev/null \
> -	&& ktap_test_pass "ipv4" || $failfunc "ipv4"
> -unshare -n packetdrill ${ipv6_args[@]} ${optargs[@]} $script > /dev/null \
> -	&& ktap_test_pass "ipv6" || $failfunc "ipv6"
> +for ip_version in $ip_versions; do
> +	unshare -n packetdrill ${ip_args[$ip_version]} ${optargs[@]} $script > /dev/null \
> +	    && ktap_test_pass $ip_version || $failfunc $ip_version

minor if respinning: indentation of 4 spaces instead of tab.


