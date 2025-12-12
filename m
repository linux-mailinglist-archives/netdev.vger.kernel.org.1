Return-Path: <netdev+bounces-244537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E32F9CB9A0C
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E37DB30056C4
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 19:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235A2D9786;
	Fri, 12 Dec 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT2e//Zh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F652C2357
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765567109; cv=none; b=UhFp4Cr29NTA5EB0MJmVSj0KGg0flgtN50nNrHKQOA+D6IJ31VmXrCqzuaCRBhbwG0fThQcQguOFA8IR4b/izokqYHyPmmaL5meoyGWV27aQ/b1MFAWz/kf6EeckcLUxaYH6eD5Mcsx/jyZ4cgWfZig4Nn3vt28BfkFedV5BMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765567109; c=relaxed/simple;
	bh=8wcS+L79g5XoNmj2pIEFde7UEeJjjURZHcBwOgPMvxI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YqFg0EOB4fhdKai7hy1TLYNFQlRgzegAFuHAQ35Fec4w125qLRBCbrSgsfAq5qFgXJY23Aap0YxwxGnDm+hBo2EwkLM1v0rdFgN6F/fDSH9IGK/VWihToDJdGtzE/QqyWHBl2Rm9FF8iPypuOtGI0cUTvOGKmvcMXLq+Ja5LwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT2e//Zh; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6446d7a8eadso1574238d50.0
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 11:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765567107; x=1766171907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tikmRlOkb+pR+sxB177TWT+tvTqTt4D0eR1nii/xhZc=;
        b=OT2e//ZhacEW/jscFQVa/eppcs3IFhINXzDT+uBTMHPGEgmrrkkAhQayc/sU5umGX+
         y0nECzZzlgKo4mQ4snJRyKLGG26KsQmhQPBD+s26QdnFn6wwQT4xyxEXL3fPfiAm20/s
         V/4leb1u3zj/5JoIzXSy07K7yn7pNO6KYAOQ3tc7pGxf4Zasz5pn+V7D/I3ZTaz2CHyo
         zxKPxEPWM2xK6JP2hQTk5y8zAQRlhDJSM2ev2CLKuJoD5Ew2PzX8dtUjEZbDjOQrFRcZ
         nyi3uhAcVklHwtKbJFSjHBMiDJAaVjQ+Os0UZWOn+BxDnocolSxymJkNE1+s8AfYNMLJ
         ddIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765567107; x=1766171907;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tikmRlOkb+pR+sxB177TWT+tvTqTt4D0eR1nii/xhZc=;
        b=s4JqxKR0oKmPsquBgczD1EQwoLqZ+Vmrgx8NYh/y4aUDktmSCtpc8xoG/UC9VDu47/
         i2EzSNR9IlWE51S+RIgcoLnLFWUYPCZt/Evt6VQ1NSAl/0umuM5qro5uzjSSNL2Wi08u
         w41KwMftiygQjzGMbSpH84J9khioUoCmkaECfTDLEJsghb6g4l846Lj8vReNd3wihL3v
         mg5eG/lb+SrG69MnLlh2uGZI32TH2Gl2wptSxBReEjV04A8UkKIBVgoj+TddrQnpO6zU
         y6Yirupzdn/EvFB5lvJivFA6kCQIGKDJvm2llRRJIUwHoTvTkss2nm576MsD0/3B9Hg6
         K6Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXJaEEfDnBAoJ7jqrJmVQJ5UBBO8Wtj96j5F9rTC0rlVsdTJeKK3pg7pcQzWI9YxVLgik6Ggco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1UJ78RVtx9pAbyEuSj7/INhIwsRd+NlObzM/yNwWLmV/LDf1
	BIkKZq7bQ0QEWMJ/weO2wXm7qW6br0P59igLYg+PGsORj7AyRU4t6oW4oFVFYA==
X-Gm-Gg: AY/fxX5Md4ScKt2s76Zuo9JbdEmSyiB8vb+sqoW2EMuRn6bc1E31fab0qycu6cQHkZy
	pwvahfEeQYPBa8wDUCtLsEJ0HS27zNsIGAKJCdmtfU2uh1T9PIpzW424Mds03jlz2TKRmFUrKYK
	U/NnHAJYWu9H3Z7AlkMkr6oracL5Seo8rgNsYqZMGXKEUdCmBh+A/gfBU+G7qrskZoyMMxt/Amd
	74vFrIzyhxnwbc30tONcPBPWg17TmitYO40ZfK+MnFyDxu8qm4khNLcYFIKtglT5iS9BY8HOFox
	tyJlU0H5i1OA9rwFtln88aSo3t2GkmcHBNVYEU7HmUIVNY8St9ERAw07hbsvvmnufNRd0Nnafb8
	TyiaU4wo20w9/UN+Ti7zvu1cX69RVQ3ic4SFTvg4zJDir6aSjIXDYjnhN7JpwF+ho9ydXAMw2GE
	nApL55VMlLsEm8Qg9kkfZ8J6CSE3si8LLd/aqliz/q2FC5xMYLL+hC8bHV1PRgUUNPaUw=
X-Google-Smtp-Source: AGHT+IFwjmfgY9PUmvyHi3gh4Krkf6WPU5h2bmejZGipu3YO819vylIKMEgF5lmWqyWuWYoH2kbs/A==
X-Received: by 2002:a05:690e:28a:b0:644:5d3f:844b with SMTP id 956f58d0204a3-6455564f195mr1950681d50.54.1765567106826;
        Fri, 12 Dec 2025 11:18:26 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78e69ffadcdsm7771707b3.17.2025.12.12.11.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 11:18:25 -0800 (PST)
Date: Fri, 12 Dec 2025 14:18:25 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Alice C. Munduruca" <alice.munduruca@canonical.com>, 
 netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, 
 "Alice C. Munduruca" <alice.munduruca@canonical.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.1702e18dd0a@gmail.com>
In-Reply-To: <20251212144921.16915-1-alice.munduruca@canonical.com>
References: <20251212144921.16915-1-alice.munduruca@canonical.com>
Subject: Re: [PATCH net v2] selftests: net: fix "buffer overflow detected" for
 tap.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alice C. Munduruca wrote:
> When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3', the
> strcpy() in rtattr_add_strsz() is replaced with a checked version which
> causes the test to consistently fail when compiled with toolchains for
> which this option is enabled by default.
> 
>  TAP version 13
>  1..3
>  # Starting 3 tests from 1 test cases.
>  #  RUN           tap.test_packet_valid_udp_gso ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_gso: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_gso
>  not ok 1 tap.test_packet_valid_udp_gso
>  #  RUN           tap.test_packet_valid_udp_csum ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_valid_udp_csum: Test terminated by assertion
>  #          FAIL  tap.test_packet_valid_udp_csum
>  not ok 2 tap.test_packet_valid_udp_csum
>  #  RUN           tap.test_packet_crash_tap_invalid_eth_proto ...
>  *** buffer overflow detected ***: terminated
>  # test_packet_crash_tap_invalid_eth_proto: Test terminated by assertion
>  #          FAIL  tap.test_packet_crash_tap_invalid_eth_proto
>  not ok 3 tap.test_packet_crash_tap_invalid_eth_proto
>  # FAILED: 0 / 3 tests passed.
>  # Totals: pass:0 fail:3 xfail:0 xpass:0 skip:0 error:0
> 
> A buffer overflow is detected by the fortified glibc __strcpy_chk()
> since the __builtin_object_size() of `RTA_DATA(rta)` is incorrectly
> reported as 1, even though there is ample space in its bounding buffer
> `req`.
> 
> Using the unchecked function memcpy() here instead allows us to match
> the way rtattr_add_str() is written while avoiding the spurious test
> failure.
> 
> Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
> Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
> ---
>  tools/testing/selftests/net/tap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
> index 247c3b3ac1c9..dd961b629295 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -67,7 +67,7 @@ static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
>  {
>  	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
>  
> -	strcpy(RTA_DATA(rta), s);
> +	memcpy(RTA_DATA(rta), s, strlen(s) + 1);

Could call strlen(s) only once in the function.

Why does rtattr_add_str do the same without the terminating '\0'?
It is only used with IFNAME so assumes max size of IFNAMSIZ perhaps?
>  	return rta;
>  }
>  
> -- 
> 2.48.1
> 



