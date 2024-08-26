Return-Path: <netdev+bounces-122038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610C95FA3A
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CB21F24203
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9998B1993BD;
	Mon, 26 Aug 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0gHqOmP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AD3199244
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724702329; cv=none; b=huyef7jjklgR5PhJKBt5V1BnkUxWIcVTqm9475kympu80vhzZK+aus1YqmwWWJxaRB2Lg0EqW7+H+EFjr29TwTP5ho9AUSri/T6tl2NL8G5GssgYIbOAt9ylLmwi0glLDBfYkYrxQDQLyjUrHTSsmWhEqfgwrr0qRKLMyVmc9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724702329; c=relaxed/simple;
	bh=WNIzx5i3oPs6WaNJdhO4xjopJ3PNEal+LVVYV5EADJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPzoDvwWZ38q0fNj5DLPw+XQMblzakMnshE9/bScelhx4TVd2xmyd3wKlQGm/H1C02NQs5cWnxennLS6/KHvwgE3lV7vZWw97SDg3T95iwp+w2LgfVX9gE3MUQGtq2n03RW5sPGy3q5VHuF4C1A1AGZQsm0V5gn+u/4E4Pd6+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0gHqOmP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724702326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sZeMyJWkAVcCvry81yl0/4YWVdBPs30WCndQ9OE2fq0=;
	b=U0gHqOmPUAH4Id7Q4BTlwKjvmH01fzNt1mql8HhDbtw3td6MKrINYh6DA5oq7+2pfRZ7xB
	x+ZEDry33SR6MQdQUiRDX7bN8S3lmR1UbrQZe8BQO3YZXEyi07QE6K057kAgHRiF3rHNqh
	DqDBI7/RzAyn4WDMSCAc1TUNyW/kvqE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-AmhHehl8Nba2kRxV_A0cRA-1; Mon, 26 Aug 2024 15:58:45 -0400
X-MC-Unique: AmhHehl8Nba2kRxV_A0cRA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6c32c20bbd8so1182166d6.1
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724702325; x=1725307125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZeMyJWkAVcCvry81yl0/4YWVdBPs30WCndQ9OE2fq0=;
        b=HeXbR6mhboaK2iVRGDK7pjnEunNJesr5CiLBH0saZK0m6eUEnc6FjAFbHEX4sKtXrw
         TB0xbfMQ+2Jf4OnA4hw7xDCY0YRnSGPXFrwoOmV/fPVs6IA4jrCu/DfZOzgm7Mw3Mf8B
         LURmg2TgGgmOXOeXCFp5AFNjevAb38iOPDLSZ8EE6vfKf3mKmx5W1ya3IuEHGOREM/v+
         xfAHxjuITgMud0EYgLjwZN15nvLnnfSTbR5WRr5gpPqT2GM5briDcnYyYn8v9T88ejlR
         HhT9UzZWG7U4H1ItCygSZvPzwBwcO86jQ5UmpEhTmi/GM9wSSW46cf9Shbjk2nzpo53y
         RwtA==
X-Gm-Message-State: AOJu0YykQ8C1pw1Oa9SulJSP/s8suHL1qc/irJn/E/bYOPV1QlLnxCw8
	aUhdFr2nMDIOGbm3wfN9r7sX/u9FiQEx5uU19MaU0hu4/AHNFsvB9VTq4kOnK5N7A2F28gKr2+m
	kJhSdHfslR9aswCUefdyfPbbAWQSvF80rTsMSOELR/Par7VBxmz+mww==
X-Received: by 2002:a05:6214:5882:b0:6b4:4585:8e43 with SMTP id 6a1803df08f44-6c32b6bc8e3mr4885856d6.31.1724702325141;
        Mon, 26 Aug 2024 12:58:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHZaThSq1wtxJRl+kk1RkVzDOkBRPqIFqK0pqxMp5jgbqjVm7RZy7HnATCZO0XJItbPYBFjw==
X-Received: by 2002:a05:6214:5882:b0:6b4:4585:8e43 with SMTP id 6a1803df08f44-6c32b6bc8e3mr4885646d6.31.1724702324628;
        Mon, 26 Aug 2024 12:58:44 -0700 (PDT)
Received: from [10.0.0.174] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db07c0sm49711836d6.90.2024.08.26.12.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 12:58:44 -0700 (PDT)
Message-ID: <9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com>
Date: Mon, 26 Aug 2024 15:58:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, edumazet@google.com
References: <20240823211902.143210-1-jmaloy@redhat.com>
 <20240823211902.143210-3-jmaloy@redhat.com>
 <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024-08-23 19:44, Jason Xing wrote:
> Hello Jon,
>
> On Sat, Aug 24, 2024 at 5:19 AM <jmaloy@redhat.com> wrote:
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> We add a selftest to check that the new feature added in
>> commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
>> works correctly.
>>
>> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
>> Tested-by: Stefano Brivio <sbrivio@redhat.com>
>> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> Thanks for working on this. Sorry that I just noticed I missed your
> previous reply :(
There is still the ditto UDP selftest to be done ;-)
>> ---
>>   tools/testing/selftests/net/Makefile          |   1 +
>>   tools/testing/selftests/net/tcp_so_peek_off.c | 181 ++++++++++++++++++
>>   2 files changed, 182 insertions(+)
>>   create mode 100644 tools/testing/selftests/net/tcp_so_peek_off.c
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index 8eaffd7a641c..1179e3261bef 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -80,6 +80,7 @@ TEST_PROGS += io_uring_zerocopy_tx.sh
>>   TEST_GEN_FILES += bind_bhash
>>   TEST_GEN_PROGS += sk_bind_sendto_listen
>>   TEST_GEN_PROGS += sk_connect_zero_addr
>> +TEST_GEN_PROGS += tcp_so_peek_off
>>   TEST_PROGS += test_ingress_egress_chaining.sh
>>   TEST_GEN_PROGS += so_incoming_cpu
>>   TEST_PROGS += sctp_vrf.sh
>> diff --git a/tools/testing/selftests/net/tcp_so_peek_off.c b/tools/testing/selftests/net/tcp_so_peek_off.c
>> new file mode 100644
>> index 000000000000..8379ea02e3d7
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/tcp_so_peek_off.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <sys/types.h>
>> +#include <netinet/in.h>
>> +#include <arpa/inet.h>
>> +#include "../kselftest.h"
>> +
>> +static char *afstr(int af)
>> +{
>> +       return af == AF_INET ? "TCP/IPv4" : "TCP/IPv6";
>> +}
>> +
>> +int tcp_peek_offset_probe(sa_family_t af)
>> +{
>> +       int optv = 0;
>> +       int ret = 0;
>> +       int s;
>> +
>> +       s = socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
>> +       if (s < 0) {
>> +               ksft_perror("Temporary TCP socket creation failed");
>> +       } else {
>> +               if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof(int)))
>> +                       ret = 1;
>> +               else
>> +                       printf("%s does not support SO_PEEK_OFF\n", afstr(af));
>> +               close(s);
>> +       }
>> +       return ret;
>> +}
>> +
>> +static void tcp_peek_offset_set(int s, int offset)
>> +{
>> +       if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset)))
>> +               ksft_perror("Failed to set SO_PEEK_OFF value\n");
>> +}
>> +
>> +static int tcp_peek_offset_get(int s)
>> +{
>> +       int offset;
>> +       socklen_t len = sizeof(offset);
>> +
>> +       if (getsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, &len))
>> +               ksft_perror("Failed to get SO_PEEK_OFF value\n");
>> +       return offset;
>> +}
>> +
>> +static int tcp_peek_offset_test(sa_family_t af)
>> +{
>> +       union {
>> +               struct sockaddr sa;
>> +               struct sockaddr_in a4;
>> +               struct sockaddr_in6 a6;
>> +       } a;
>> +       int res = 0;
>> +       int s[2] = {0, 0};
>> +       int recv_sock = 0;
>> +       int offset = 0;
>> +       ssize_t len;
>> +       char buf;
>> +
>> +       memset(&a, 0, sizeof(a));
>> +       a.sa.sa_family = af;
>> +
>> +       s[0] = socket(af, SOCK_STREAM, IPPROTO_TCP);
>> +       s[1] = socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
>> +
>> +       if (s[0] < 0 || s[1] < 0) {
>> +               ksft_perror("Temporary probe socket creation failed\n");
>> +               goto out;
> Nit: I wonder if we can use more proper test statements to avoid such
> hiding failure[1] when closing a invalid file descriptor, even though
> it doesn't harm the test itself?
>
> [1]: "EBADF (Bad file descriptor)"
Fixed that in v2.
>> +       }
>> +       if (bind(s[0], &a.sa, sizeof(a)) < 0) {
>> +               ksft_perror("Temporary probe socket bind() failed\n");
>> +               goto out;
>> +       }
>> +       if (getsockname(s[0], &a.sa, &((socklen_t) { sizeof(a) })) < 0) {
>> +               ksft_perror("Temporary probe socket getsockname() failed\n");
>> +               goto out;
>> +       }
>> +       if (listen(s[0], 0) < 0) {
>> +               ksft_perror("Temporary probe socket listen() failed\n");
>> +               goto out;
>> +       }
>> +       if (connect(s[1], &a.sa, sizeof(a)) >= 0 || errno != EINPROGRESS) {
>> +               ksft_perror("Temporary probe socket connect() failed\n");
>> +               goto out;
>> +       }
>> +       recv_sock = accept(s[0], NULL, NULL);
>> +       if (recv_sock <= 0) {
>> +               ksft_perror("Temporary probe socket accept() failed\n");
>> +               goto out;
> Same here.
Fixed.
>> +       }
>> +
>> +       /* Some basic tests of getting/setting offset */
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != -1) {
>> +               ksft_perror("Initial value of socket offset not -1\n");
>> +               goto out;
>> +       }
>> +       tcp_peek_offset_set(recv_sock, 0);
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 0) {
>> +               ksft_perror("Failed to set socket offset to 0\n");
>> +               goto out;
>> +       }
>> +
>> +       /* Transfer a message */
>> +       if (send(s[1], (char *)("ab"), 2, 0) <= 0 || errno != EINPROGRESS) {
>> +               ksft_perror("Temporary probe socket send() failed\n");
>> +               goto out;
>> +       }
>> +       /* Read first byte */
>> +       len = recv(recv_sock, &buf, 1, MSG_PEEK);
>> +       if (len != 1 || buf != 'a') {
>> +               ksft_perror("Failed to read first byte of message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 1) {
>> +               ksft_perror("Offset not forwarded correctly at first byte\n");
>> +               goto out;
>> +       }
>> +       /* Try to read beyond last byte */
>> +       len = recv(recv_sock, &buf, 2, MSG_PEEK);
>> +       if (len != 1 || buf != 'b') {
>> +               ksft_perror("Failed to read last byte of message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 2) {
>> +               ksft_perror("Offset not forwarded correctly at last byte\n");
>> +               goto out;
>> +       }
>> +       /* Flush message */
>> +       len = recv(recv_sock, NULL, 2, MSG_TRUNC);
>> +       if (len != 2) {
>> +               ksft_perror("Failed to flush message\n");
>> +               goto out;
>> +       }
>> +       offset = tcp_peek_offset_get(recv_sock);
>> +       if (offset != 0) {
>> +               ksft_perror("Offset not reverted correctly after flush\n");
>> +               goto out;
>> +       }
>> +
>> +       printf("%s with MSG_PEEK_OFF works correctly\n", afstr(af));
>> +       res = 1;
>> +out:
>> +       close(recv_sock);
>> +       close(s[1]);
>> +       close(s[0]);
>> +       return res;
>> +}
>> +
>> +int main(void)
>> +{
>> +       int res4, res6;
>> +
>> +       res4 = tcp_peek_offset_probe(AF_INET);
>> +       res6 = tcp_peek_offset_probe(AF_INET6);
>> +
>> +       if (!res4 && !res6)
>> +               return KSFT_SKIP;
>> +
>> +       if (res4)
>> +               res4 = tcp_peek_offset_test(AF_INET);
>> +
>> +       if (res6)
>> +               res6 = tcp_peek_offset_test(AF_INET6);
>> +
>> +       if (!res4 || !res6)
> What if res6 is NULL after checking tcp_peek_offset_probe() while res4
> is always working correctly, then we will get notified with a
> KSFT_FAIL failure instead of KSFT_SKIP.
This is intentional. If IPv4 is supported, and IPv6 is not, that is a 
failure.

Regards
///jon

> The thing could happen because you reuse the same return value for v4/v6 mode.
>
> Thanks,
> Jason
>
>> +               return KSFT_FAIL;
>> +
>> +       return KSFT_PASS;
>> +}
>> +
>> --
>> 2.45.2
>>
>>


