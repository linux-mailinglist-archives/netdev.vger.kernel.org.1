Return-Path: <netdev+bounces-119728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14937956C63
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1E91F225FB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F3816C6AD;
	Mon, 19 Aug 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DoJJlDWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4A16C448
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724075082; cv=none; b=fHDrWuyvCJNP4MrT8HgHIjO+RNf4WiMuLgCdCotCGz/rIEB/Tb9pqdm2RB8uJLm/J3sQzo9NwWIC9LiU79wp3DNrTX/6iH1BwLMCDJw4OSjUU3qNNIlAHrfCmuYd/+2ipswH8u3ueoRIWVZ9HiMLO+XZhDl1GptmhheT3ZM7WsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724075082; c=relaxed/simple;
	bh=E3+H36LrrYbYFOTje12tu0r/LFKn6i0tGjNHP89CbuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRWse6OMwLC5lgV1g+Nl+W4o83KZhQi0FHui4BwkAFL7H0/WgefTVVH3uEGDy/FHJwCUWyndeog/uwtS3CPps2kxaP/GJSDvrvNE6TW6MgDdaJtazZP+TFK6ZbporKvAfVEWpYbsvlOVwmF+d6xgL8TIyQH0gU1rgHnyhMqZhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DoJJlDWY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7de4364ca8so479358766b.2
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724075078; x=1724679878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrrxTX117vijzUvBlkMKUjEulnMWXb88Od42i1TC6PE=;
        b=DoJJlDWYqkaplA4NHzy0ZPNZSZdvxahqNyZur8YUyGmilUIDlcWUnA3Eqj6mDIeqkO
         0109VUGsyRh3Fj/ysuK/w3fwAKeMkBpKitf3AM6yhyeSfE9UNJuymcyR1/AQSz9vAtUp
         ca1N0y6M/8AOSfQMFbME7579hubuWa7mk55RROLCPfdFdafLbN4+MKuFSZaZKNj1AkYp
         Gl2w2NReWw2nD8rpWqczFLbtw8Q6OxUIazLqdqwOAH7LSJGcecq0Qq46r3scaVDmOiXa
         pM9vAPHcB1l6+9acYAMftlIxX4QG6WdRf6b0nzQnZgBvKD1ou71E9gJed8LSbGx07yay
         +Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724075078; x=1724679878;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrrxTX117vijzUvBlkMKUjEulnMWXb88Od42i1TC6PE=;
        b=n29+Mce5IiMV2ngmj6Q7jSmnxYCVq5tkt0THWsoeZDJkc+DFGm/dC9Qwws3fbReTcf
         l6Fzr2uF+JosTN7ZZl2krzhm5+aSkGZhirDPnuECvw4gYVEP7MxKx2zdpV61A/PziStF
         ZVZgJFOXoP23qQ0sdljK8P+0xc8kwfj0sfaWglXNQ6QySQ3QgAiqHz6ZYc7rLzs1nQ0H
         pQ1O6SKTm1BZVzI5ClTcLh1fgM9Y3P7EzQPIocVe34/SBGyxatwvhYUU3MUrsbId91Mz
         p+yMZUftj4pxBdvzcPZotOJ3Dgvka/867HIu8cOsU1vDwCRrUhxL/b5IUfxywsuG7Y45
         GRWQ==
X-Gm-Message-State: AOJu0YxtSn+LmLT9BgkO2zfu4CzQGa8/cSFaRCT/KfDqOclrSzvek2Vc
	MATUd0jo/OINrLjGKd3reWlk3hHUxJzizmFdIrJFDxqYuR0LAwdfbAmhlikleWM=
X-Google-Smtp-Source: AGHT+IGA/o7nezwkWzmkFtA4fGwF5k5K6vL2YqvtQKgE+AxSwEKaYs0dwEwCJwiCZvVhVmILhxAZxg==
X-Received: by 2002:a17:907:d2c5:b0:a77:cdaa:889f with SMTP id a640c23a62f3a-a83928d7835mr791186666b.24.1724075078254;
        Mon, 19 Aug 2024 06:44:38 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935807sm635077066b.134.2024.08.19.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 06:44:37 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next] tcp: Allow TIME-WAIT reuse after 1
 millisecond
In-Reply-To: <CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3DraQtsceNGYwug@mail.gmail.com>
	(Eric Dumazet's message of "Mon, 19 Aug 2024 13:59:40 +0200")
References: <20240819-jakub-krn-909-poc-msec-tw-tstamp-v1-1-6567b5006fbe@cloudflare.com>
	<CANn89iKB4GFd8sVzCbRttqw_96o3i2wDhX-3DraQtsceNGYwug@mail.gmail.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 19 Aug 2024 15:44:36 +0200
Message-ID: <87ikvwr5iz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 01:59 PM +02, Eric Dumazet wrote:
> On Mon, Aug 19, 2024 at 1:31=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> [This patch needs a description. Please see the RFC cover letter below.]
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>> Can we shorten the TCP connection reincarnation period?
>>
>> Situation
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Currently, we can reuse a TCP 4-tuple (source IP + port, destination IP =
+ port)
>> in the TIME-WAIT state to establish a new outgoing TCP connection after =
a period
>> of 1 second. This period, during which the 4-tuple remains blocked from =
reuse,
>> is determined by the granularity of the ts_recent_stamp / tw_ts_recent_s=
tamp
>> timestamp, which presently uses a 1 Hz clock (ktime_get_seconds).
>>
>> The TIME-WAIT block is enforced by __{inet,inet6}_check_established ->
>> tcp_twsk_unique, where we check if the timestamp clock has ticked since =
the last
>> ts_recent_stamp update before allowing the 4-tuple to be reused.
>>
>> This mechanism, introduced in 2002 by commit b8439924316d ("Allow to bin=
d to an
>> already in use local port during connect") [1], protects the TCP receiver
>> against segments from an earlier incarnation of the same connection (FIN
>> retransmits), which could potentially corrupt the TCP stream, as describ=
ed by
>> RFC 7323 [2, 3].
>>
>> Problem
>> =3D=3D=3D=3D=3D=3D=3D
>>
>> The one-second reincarnation period has not posed a problem when we had a
>> sufficiently large pool of ephemeral ports (tens of thousands per host).
>
>
> We now have network namespaces, and still ~30,000 ephemeral ports per net=
ns :)

It's just that we are short on public IPv4 addresses with certain traits
we need to proxy on egress (like ownership, reputation, geolocation).
Hence we had to share the addresses and divide the port space between
hosts :-/

>
>> However, as we began sharing egress IPv4 addresses between hosts by part=
itioning
>> the available port range [4], the ephemeral port pool size has shrunk
>> significantly=E2=80=94down to hundreds of ports per host.
>>
>> This reduction in port pool size has made it clear that a one-second con=
nection
>> reincarnation period can lead to ephemeral port exhaustion. Short-lived =
TCP
>> connections, such as DNS queries, can complete in milliseconds, yet the =
TCP
>> 4-tuple remains blocked for a period of time that is orders of magnitude=
 longer.
>>
>> Solution
>> =3D=3D=3D=3D=3D=3D=3D=3D
>>
>> We would like to propose to shorten the period during which the 4-tuple =
is tied
>> up. The intention is to enable TIME-WAIT reuse at least as quickly as it=
 takes
>> nowadays to perform of a short-lived TCP connection, from setup to teard=
own.
>>
>> The ts_recent_stamp protection is based on the same principle as PAWS but
>> extends it across TCP connections. As RFC 7323 outlines in Appendix B.2,=
 point
>> (b):
>>
>>     An additional mechanism could be added to the TCP, a per-host
>>     cache of the last timestamp received from any connection.  This
>>     value could then be used in the PAWS mechanism to reject old
>>     duplicate segments from earlier incarnations of the connection,
>>     if the timestamp clock can be guaranteed to have ticked at least
>>     once since the old connection was open.  This would require that
>>     the TIME-WAIT delay plus the RTT together must be at least one
>>     tick of the sender's timestamp clock.  Such an extension is not
>>     part of the proposal of this RFC.
>
> Note the RTT part here. I do not see this implemented in your patch.
>

Not sure I follow. I need to look into that more.

My initial thinking here was that as long as TW delay (1 msec) is not
shorter than one tick of the sender's TS clock (1 msec), then I can
ignore the RTT and the requirement is still met.

>>
>> Due to that, we would want to follow the same guidelines as the for TSval
>> timestamp clock, for which RFC 7323 recommends a frequency in the range =
of 1 ms
>> to 1 sec per tick [5], when reconsidering the default setting.
>>
>> (Note that the Linux TCP stack has recently introduced even finer granul=
arity
>> with microsecond TSval resolution in commit 614e8316aa4c "tcp: add suppo=
rt for
>> usec resolution in TCP TS values" [6] for use in private networks.)
>>
>> A simple implementation could be to switch from a second to a millisecon=
d clock,
>> as demonstrated by the following patch. However, this could also be a tu=
nable
>> option to allow administrators to adjust it based on their specific need=
s and
>> risk tolerance.
>>
>> A tunable also opens the door to letting users set the TIME-WAIT reuse p=
eriod
>> beyond the RFC 7323 recommended range at their own risk.
>>

[...]

>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index e37488d3453f..873a1cbd6d14 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -3778,7 +3778,7 @@ static void tcp_send_challenge_ack(struct sock *sk)
>>  static void tcp_store_ts_recent(struct tcp_sock *tp)
>>  {
>>         tp->rx_opt.ts_recent =3D tp->rx_opt.rcv_tsval;
>> -       tp->rx_opt.ts_recent_stamp =3D ktime_get_seconds();
>> +       tp->rx_opt.ts_recent_stamp =3D tcp_clock_ms();
>
> Please do not abuse tcp_clock_ms().
>
> Instead use tcp_time_stamp_ms(tp)
>
> Same remark for other parts of the patch, try to reuse tp->tcp_mstamp
> if available.
>
> Also, (tcp_clock_ms() !=3D ts_recent_stamp) can be true even after one
> usec has elapsed, due to rounding.
>
> The 'one second delay' was really: 'An average of 0.5 second delay'
>
> Solution : no longer use jiffies, but usec based timestamps, since we
> already have this infrastructure in TCP stack.

Thank you for feedback. Especially wrt the rounding bug - eye opening.

Will rework it to move away from jiffies.

