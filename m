Return-Path: <netdev+bounces-67648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0498446B8
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8194B289B8
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7E12CDB8;
	Wed, 31 Jan 2024 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="fsmONdpB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A612F583
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 18:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724216; cv=none; b=qJPpa/Z2le0IIur4kfE2h+e4Z35tJh/Jv/WYvcnxyTKgpjYdM5B4Ziry1DI8X2+2xWC14d/fy1euCgH7ZkAVu6F6lHh+wye8zOaTNjNEEm2q3sVn1QnC+ds3Yuet2hQocqqLyNLNGKSoHA+kun56IqQtiQBoQhISas4zDUPkg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724216; c=relaxed/simple;
	bh=16WCbq+Pt7SUw3ypBo9Dm5jdSTlsLgGEixEA7Vkl89Y=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=qbHgoYjOHF+MJ8BWZqqsQ7VhdGvt4HJARu/RYBYjUKAy7lYpOf3KiTaJmjbdJejvuMfQqfekBWS0vg/L3Rv1IZ/n98uK4z1FM0mJQBdZhtjrywO1su8UmACDmMDlf+J4FOjCPEOCVfeILXwVYg1bU1NCyaiodLALLr2v1BDN4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=fsmONdpB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so701353466b.2
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1706724213; x=1707329013; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=f1kSS9u5dAdM4eR7tKwOFzJFS81dfs/xnltB4nZ8s6k=;
        b=fsmONdpBcLVKFOcMJh0G1pFEHRBP2e+KJCpzBXqlmj0rj+N0rBKQjldrh8e46Dp2+T
         V4e+x+DVqLdGQJa6TompPwjvrkvjQ+YOF5Co28/ZoRPJUNrTvJyu09Sct7pLGsUeTjpA
         c8RBr4js8StjFPT3MZTxzgpV61djUdObBgP6Dykik2h+zVqDFhtpgqRrkZyILrUtODnF
         Ltmat02nhB6UGyA9d67rtUNv2LtoPbm1f9cvFxaj+GoP+wF90JD5Ryqp8ZXfjYBpTfv4
         IZnPhnngdpUgkMhu7z66WWM0tVqTOvsANvrzFXjbc7bvx3IYmWgwKcVYRw53oiKxXca2
         bO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724213; x=1707329013;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1kSS9u5dAdM4eR7tKwOFzJFS81dfs/xnltB4nZ8s6k=;
        b=E/mrRNYonUx7F+WdSdTBJTUslMu3fKVQ3O4qdtVkbsVF4suQBZB8CMSZglYy0bluS2
         3jkeCipcpPSwDwMWc69tFBIR6uT4B9HaxWMyz/Uxti7qPQatx8nRawY9aUKz/RChXXJU
         qZad4g90HbFQfEH2cJD2fFRn+t9Yg0reVAbTgknHYW6SVdXQ68T7Q0W8JlIkqEOkPLbd
         rlNlY/Yr0IOhvgMGtfJV6aHkPA4BL3XmMvnlcaMFZ5JjFfCRa5V9anfZxG0yT+WcERcW
         sNUdYQramUkw7Tamk3TXDGlqhrsVs/Q5lmgJJpCYLdkPxbols61iRxU4eY9lIH00yafh
         fONw==
X-Gm-Message-State: AOJu0Yz0rrihxbCg05mbyndfJc5f0Yf2pKsR5vYg8+ADBN6EpgYPw13t
	aju7kUl3svkbM51f5dTNN4x5fPUmAhaUvD55Nbmdn4K7orH7Wm3fgoQM1EBAFio=
X-Google-Smtp-Source: AGHT+IHWmFvHuS3AWtoqfnYLGn5PF5m4evlVEQjqommXoT2M1ME+JpyPuGxo0Xeo5wl7ipnECpCqLw==
X-Received: by 2002:a17:906:3b8e:b0:a35:9cf0:56d4 with SMTP id u14-20020a1709063b8e00b00a359cf056d4mr31874ejf.30.1706724212944;
        Wed, 31 Jan 2024 10:03:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUXjS7kNbFACQNMr7+V11vwNC5xW9GEsQianeZWLzcy/AKAJR51iK3euoE0etDXFOVfwbViy1/WOMIKjUHfPcL3KkKk4dBxel+DzpGAqZlOY/j5X8wJGFxrMFhv6R9ldQ0MSKPhYsstRfpisZgsbrc4JbvKr22QMFeA2DDpjvluw9HMQVMDQ9/uD4wjAbvHBB9BIJyMLQyG7gFHxGkZ51ZTME1OwfqV/xFo53n8
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:f0])
        by smtp.gmail.com with ESMTPSA id zh11-20020a170906880b00b00a359c588d31sm4027517ejb.100.2024.01.31.10.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:03:32 -0800 (PST)
References: <20240130131422.135965-1-jakub@cloudflare.com>
 <65b95b8b3e4d0_ce3aa29444@willemb.c.googlers.com.notmuch>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@cloudflare.com
Subject: Re: [PATCH net-next] selftests: udpgso: Pull up network setup into
 shell script
Date: Wed, 31 Jan 2024 18:47:16 +0100
In-reply-to: <65b95b8b3e4d0_ce3aa29444@willemb.c.googlers.com.notmuch>
Message-ID: <87zfwlv0sx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 30, 2024 at 03:26 PM -05, Willem de Bruijn wrote:
> Jakub Sitnicki wrote:
>> udpgso regression test configures routing and device MTU directly through
>> uAPI (Netlink, ioctl) to do its job. While there is nothing wrong with it,
>> it takes more effort than doing it from shell.
>> 
>> Looking forward, we would like to extend the udpgso regression tests to
>> cover the EIO corner case [1], once it gets addressed. That will require a
>> dummy device and device feature manipulation to set it up. Which means more
>> Netlink code.
>> 
>> So, in preparation, pull out network configuration into the shell script
>> part of the test, so it is easily extendable in the future.
>> 
>> Also, because it now easy to setup routing, add a second local IPv6
>> address. Because the second address is not managed by the kernel, we can
>> "replace" the corresponding local route with a reduced-MTU one. This
>> unblocks the disabled "ipv6 connected" test case. Add a similar setup for
>> IPv4 for symmetry.
>
> Nice!
>
> Just a few small nits.
>

Thanks for quick feedback. Will apply it and respin.

>> 
>> [1] https://lore.kernel.org/netdev/87jzqsld6q.fsf@cloudflare.com/
>> 
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  tools/testing/selftests/net/udpgso.c  | 134 ++------------------------
>>  tools/testing/selftests/net/udpgso.sh |  50 ++++++++--
>>  2 files changed, 48 insertions(+), 136 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
>> index 7badaf215de2..79fd3287ff60 100644
>> --- a/tools/testing/selftests/net/udpgso.c
>> +++ b/tools/testing/selftests/net/udpgso.c
>> @@ -56,7 +56,6 @@ static bool		cfg_do_msgmore;
>>  static bool		cfg_do_setsockopt;
>>  static int		cfg_specific_test_id = -1;
>>  
>> -static const char	cfg_ifname[] = "lo";
>>  static unsigned short	cfg_port = 9000;
>>  
>>  static char buf[ETH_MAX_MTU];
>> @@ -69,8 +68,13 @@ struct testcase {
>>  	int r_len_last;		/* recv(): size of last non-mss dgram, if any */
>>  };
>>  
>> -const struct in6_addr addr6 = IN6ADDR_LOOPBACK_INIT;
>> -const struct in_addr addr4 = { .s_addr = __constant_htonl(INADDR_LOOPBACK + 2) };
>> +const struct in6_addr addr6 = {
>> +	{ { 0x20, 0x01, 0x0d, 0xb8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x00, 0x01 } },
>> +};
>> +
>> +const struct in_addr addr4 = {
>> +	__constant_htonl(0xc0000201), /* 192.0.2.1 */
>> +};
>
> Prefer an address from a private range?

No preference. I saw both in use across net selftests and went with one.

[...]

>> diff --git a/tools/testing/selftests/net/udpgso.sh b/tools/testing/selftests/net/udpgso.sh
>> index fec24f584fe9..d7fb71e132bb 100755
>> --- a/tools/testing/selftests/net/udpgso.sh
>> +++ b/tools/testing/selftests/net/udpgso.sh
>> @@ -3,27 +3,57 @@
>>  #
>>  # Run a series of udpgso regression tests
>>  
>> +set -o errexit
>> +set -o nounset
>> +# set -o xtrace
>
> Leftover debug comment?
>

Left it on purpose for the next person debugging it. But can remove it.

>> +
>> +setup_loopback() {
>> +  ip addr add dev lo 192.0.2.1/32
>> +  ip addr add dev lo 2001:db8::1/128 nodad noprefixroute
>> +}
>> +
>> +test_dev_mtu() {
>> +  setup_loopback
>> +  # Reduce loopback MTU
>> +  ip link set dev lo mtu 1500
>> +}
>> +
>> +test_route_mtu() {
>> +  setup_loopback
>> +  # Remove default local routes
>> +  ip route del local 192.0.2.1/32 table local dev lo
>> +  ip route del local 2001:db8::1/128 table local dev lo
>> +  # Install local routes with reduced MTU
>> +  ip route add local 192.0.2.1/32 table local dev lo mtu 1500
>> +  ip route add local 2001:db8::1/128 table local dev lo mtu 1500
>
> ip route change?
>

I've tried it. Doesn't work as expected. Only del+add seems do to
it. You end up with two routes if you use `ip route replace`:

  # ip route replace local 2001:db8::1/128 table local dev lo mtu 1500
  # ip -6 route show table local
  local ::1 dev lo proto kernel metric 0 pref medium
  local 2001:db8::1 dev lo proto kernel metric 0 pref medium
  local 2001:db8::1 dev lo metric 1024 mtu 1500 pref medium
  #

I didn't dig into why, though.

[...]

