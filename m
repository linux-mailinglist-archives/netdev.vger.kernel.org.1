Return-Path: <netdev+bounces-245019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38841CC50BB
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 20:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB98E3035272
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B0316194;
	Tue, 16 Dec 2025 19:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYfJABa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA2C2820A9
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914901; cv=none; b=WP/t5WXh3IK4fqrNjAfiWth2OHAHa3+g8m5nj7nn/vI977h5ndV02+IiUHsG8qhZmJpKUQik3Gg+0H9tEC9OrHBHywqnHxabvHhff+OLEa92XRmP6eZkfM7j+1wbOzjkGbGiJ154u9Yl01iaDqZ0QLQLclKO4p6QUGqvtDnmBn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914901; c=relaxed/simple;
	bh=MfqDH4/O8KDzWjnyDBeFxR8tAnjUXaceNmNX3aeJYhE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XXWhh8EU97yepw+YG8i85+LFqrfJn4wLgl9Yj9hZMHOYe60hEfQsrUx/xOKaREXmSdGoBDIc/yv3paV1vS7L6m1C6u9xjpaI5qEDQ0+l1l5ML6B3SELzP9eLa1gorTZi8jxNsw3GvgBzt2aHPWycJZoqjrnzrCq80f8W7p9ci64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYfJABa4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c4d112cd8so48060297b3.2
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765914899; x=1766519699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be7JUAAiM3hDUesPFCNkuJpo8VlqDg0Gc+p9llIp0js=;
        b=AYfJABa48t0H317KhfFy5O3tHj6oi+LPM9OYatXKr2FGi/O4RgNokgbSm1m4dI6XzR
         e2EUa6RTUxjexvT0W37OKnJ3mw064PSkj/87dbCRNm7qJIlUi7gg9V0mGLX2AGHhiz1P
         E7hwZYT6H+1v2jHCG04vyEBv4X+1/IlpZDXeZKS2pvq9Dp8EQqh+iLxOu22cN7qBy6Ra
         UDHeTZMDY2hHspiASXoVovMLg27UcSm037cGxVX+5OzQKrcz3NGGx/v86r2rFjU67lZR
         nmifE+L2FVDE0TVySD/vOvmrbf8izbi6wOO32HKpdCeBWCgnfuVz0KAcROMbbSn92Sri
         KuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765914899; x=1766519699;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=be7JUAAiM3hDUesPFCNkuJpo8VlqDg0Gc+p9llIp0js=;
        b=HGv2hwPpvUc8TI/2G3CoDuxeBv4GMR9lwUjOh04kIjagDhyazD6fl0sIn447QbLUol
         iEpb1q9IPwZXJns3dUVUML2DNKW7WhOpiUEtIWRQ6mfX7/DsYzm+jHbLGlIXowyYPzCw
         zDuQ70Zu4HVwbUIMMJa0T0+Lm/CzzQ7Bxo3iX7Ks/Isku1YjRoBYJwQU4t4DLsQiiMWj
         WpPxP5g/yUbV7ZP5A9Y7olS4iDR1CDlUtUtsIRH3QFVd7k/5t/2ZtobcQkLPcMzyCO4J
         2LfS1sqmO3vA+1aKxuU3ufshUwD/61H0o3RC/lBVLcVUyMp9Fwy8kva/xuXxCc/mkVTd
         L3Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXbbv/hsFGc16yp1WJT2/zK9ytLYWNI8UtGPQnyBAKrQR39uje3f6fU4Cd+VtZ9NGxc5RiskW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxojA+8TX2BHr19lmmHIlKwRpaQ+UQSowfHBvsNwdGdF69Ge5Fh
	5AQX+vysmgvqn4ndmBQdA8r5e4/Ncqr7jsoK3d8SKJKU7nn6MgANDZJy
X-Gm-Gg: AY/fxX4o4bx38w6RlKx99SvLnxFt2/dWNhKIIwvlTOSZ6P6n3/UW105UXyZLU9NsZwu
	a9tBoVtT6ycuoS8X6CnolxDl9RXNspUHzlt1qADX7Mu889riM93E3+v6zBcKX6MThkH3g5oiXPA
	fjxhiiPgUX80LmitrKGK3KK7/IWHUshoWHp+9Ick2qrsRS85holwPxqWqEDVrxW/shPgv8n/HF4
	cj8qMMyNw7nFQDPCQVyfJcv67DmOfZS+fOKDrkudWANCABjAQ25sFcbrT/A46jF5aGsYxqOrr60
	9kvIHS75eKTSh66LAYXVHQSoyDCfq0ygn79DD/ZUF7xVhmM5ajkLtUeV1wVGEJeu9qk6lISYa47
	hSwYs6JxsoYb1gZHhGlroJhlPC/M87yuLSo1JlRJacPEUvyAT7jlNQvM4l6MJ1o1xujcG/SdkWp
	3vYLJBtaR0bAoJa9RCyfA4xfatTg2eFn0qwGxfZyr3V/Buac6eAM2o4pXAF6erremX6Hh4oXVxd
	vNqSw==
X-Google-Smtp-Source: AGHT+IEuqpeuP1UDy+6XnjcNYN1ogGOeKRu57NupIJPcHrmfdc0of+efEM03iL2q5TAnMgXbrad84Q==
X-Received: by 2002:a05:690c:3581:b0:78e:1aa5:e98a with SMTP id 00721157ae682-78e66dc9157mr271655907b3.37.1765914898696;
        Tue, 16 Dec 2025 11:54:58 -0800 (PST)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64477dab686sm8053046d50.16.2025.12.16.11.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 11:54:58 -0800 (PST)
Date: Tue, 16 Dec 2025 14:54:57 -0500
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
 Willem de Bruijn <willemb@google.com>, 
 Cengiz Can <cengiz.can@canonical.com>, 
 cbulinaru@gmail.com
Message-ID: <willemdebruijn.kernel.311f094b4d393@gmail.com>
In-Reply-To: <20251216170641.250494-1-alice.munduruca@canonical.com>
References: <20251216170641.250494-1-alice.munduruca@canonical.com>
Subject: Re: [PATCH net v3] selftests: net: fix "buffer overflow detected" for
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
> When the selftest 'tap.c' is compiled with '-D_FORTIFY_SOURCE=3',
> the strcpy() in rtattr_add_strsz() is replaced with a checked
> version which causes the test to consistently fail when compiled
> with toolchains for which this option is enabled by default.
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
> reported as 1, even though there is ample space in its bounding
> buffer `req`.
> 
> Additionally, given that IFLA_IFNAME also expects a null-terminated
> string, callers of rtaddr_add_str{,sz}() could simply use the
> rtaddr_add_strsz() variant. (which has been renamed to remove the
> trailing `sz`) memset() has been used for this function since it
> is unchecked and thus circumvents the issue discussed in the
> previous paragraph.
> 
> Fixes: 2e64fe4624d1 ("selftests: add few test cases for tap driver")
> Signed-off-by: Alice C. Munduruca <alice.munduruca@canonical.com>
> Reviewed-by: Cengiz Can <cengiz.can@canonical.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Cc: original author cbulinaru@gmail.com in case we're overlooking a
reason for the split between rtattr_add_str and rtattr_add_strsz.

the first avoids the \0 and is used for IFLA_NAME. Device names are
guaranteed to fit into IFNAMSIZ, including the terminating \0.
> ---
>  tools/testing/selftests/net/tap.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/tap.c b/tools/testing/selftests/net/tap.c
> index 247c3b3ac1c9..51a209014f1c 100644
> --- a/tools/testing/selftests/net/tap.c
> +++ b/tools/testing/selftests/net/tap.c
> @@ -56,18 +56,12 @@ static void rtattr_end(struct nlmsghdr *nh, struct rtattr *attr)
>  static struct rtattr *rtattr_add_str(struct nlmsghdr *nh, unsigned short type,
>  				     const char *s)
>  {
> -	struct rtattr *rta = rtattr_add(nh, type, strlen(s));
> +	unsigned int strsz = strlen(s) + 1;
> +	struct rtattr *rta;
>  
> -	memcpy(RTA_DATA(rta), s, strlen(s));
> -	return rta;
> -}
> -
> -static struct rtattr *rtattr_add_strsz(struct nlmsghdr *nh, unsigned short type,
> -				       const char *s)
> -{
> -	struct rtattr *rta = rtattr_add(nh, type, strlen(s) + 1);
> +	rta = rtattr_add(nh, type, strsz);
>  
> -	strcpy(RTA_DATA(rta), s);
> +	memcpy(RTA_DATA(rta), s, strsz);
>  	return rta;
>  }
>  
> @@ -119,7 +113,7 @@ static int dev_create(const char *dev, const char *link_type,
>  
>  	link_info = rtattr_begin(&req.nh, IFLA_LINKINFO);
>  
> -	rtattr_add_strsz(&req.nh, IFLA_INFO_KIND, link_type);
> +	rtattr_add_str(&req.nh, IFLA_INFO_KIND, link_type);
>  
>  	if (fill_info_data) {
>  		info_data = rtattr_begin(&req.nh, IFLA_INFO_DATA);
> -- 
> 2.48.1
> 



