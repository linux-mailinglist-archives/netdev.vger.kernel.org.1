Return-Path: <netdev+bounces-301465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZyzCEXdOmrEJAgAu9opvQ
	(envelope-from <netdev+bounces-301465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:23:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FE56B9AD9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 21:23:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=ChNPkqab;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301465-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301465-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670703001CC6
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3FF371D16;
	Tue, 23 Jun 2026 19:21:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29E326D4A
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 19:21:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242482; cv=none; b=Wr6LPi/p/+QsLTKZScdHe3UqMDRbJRF+eA38F1qbb3itrk9j0VJYMX9ps6EQ3zwNC499NqBhgzdiYZhoSit6TpWjsdnFOQ86s4zRmQUuHUFbmS0uD60Bsn5yGbZwK3aNZ3d/YKThbQenLLiWmPldpbaY2VCTQJWAn0qn/xLiOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242482; c=relaxed/simple;
	bh=5yz/7qD9d5nUnJsJaK5U9S/CS7fJOjpjpVIPiaeyP1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ymfl6VBOBsGbK2cBHLGDNsSFrMN46Ofm++fe/560DMie0vnQnIt4inCUiT9pnqM0Hv6wIhUe66jCwlzrKgZge+cT3ayH3WtwNEYBAqOCQxR5SGr6Vf+Fld7+dUfYJW2M/Pxzh33M6tcJDQJFt0aWMe7zNl/ZM/uSqnrSMe/SrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ChNPkqab; arc=none smtp.client-ip=209.85.208.50
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6978f0870c9so255226a12.3
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782242480; x=1782847280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTCKNVKjyr3voLzcUOfsCv9QuFqyC7oHt4mjLY0WbOU=;
        b=ChNPkqabujipjv9w1gDwZbhfZk3UiMMwHv2NQbbc/b21CdX4tDMIwC6DhDhkoeN0BK
         psZvV5y5LjnJJ42e4p4u0SmICEpQTcYl3f2PH4g3KXjic7xqZ/lgpL3dfdrgmM3JK8ez
         IUXoGbGXgOb8kh0giCU2ncukGR1XNK6n8tb6B3Fo2tXWDy7ZT9Df8qOB4HxG2zlyg1DC
         1iTEAnSIc8i0VUY1lQF6dnMet1B8Bb7DMhPeWO96yPFxM4y9uCXhzqK9zse4Swl36f48
         eIP5WHrXgwE5cxY4+qeqU4fEttTRXYTRJEzdPcm2V6oYa/aS3a88OfUMPy09V5mv+p81
         KjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782242480; x=1782847280;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTCKNVKjyr3voLzcUOfsCv9QuFqyC7oHt4mjLY0WbOU=;
        b=QJXlDjYPTlqQqTZgVnCbp+DkRUd7OHf0XmyWnG5jXElr5W1TTQRtpKB0S9OWvi7ynU
         XgH45ySowQX/67+percSnwlywUdPzieYUcbz6vY/oIRligTF5xjVAWbI86HIgxfC6TrB
         1M077rrgJAFPEd7Bo1o5EG9BKzGtbg0c38T00WxwPPteHg4z89at6/b32vAg3a9aHOit
         xj6Px7tM/oFKN+KhItFZ5yTCNkl1SJE0vNW5IC84j9ToHQJaed1lUDmVs5cwRAT+oN39
         rhXaDOpjNBhTf3DQeVu34zoiecMVqrf3q7FWuKYgBT8BA30mFsBrPKR3r0TiFq/qH4+Z
         WPcg==
X-Forwarded-Encrypted: i=1; AFNElJ9UC1+cM1/CMiF852Sr+SnYy0bq0nsjgHDlpzONMuBh6xZE5A9hgo7KuwNN1RUVRbtsp+gaO5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PWV9MY66udbzIbFMC7bc8xsabZpb/s0wqHIPIQvng5Lw2uZX
	s4Bkr2Vx4L8MJTU/qu9F5eInEHwQBbQOuGeZ7AFdUTibJQAd6ltNj+tba7uXe1ng3Iw=
X-Gm-Gg: AfdE7cn8fzGj230TngCI5RWZ6j6UI/cYCVOElSzZ/pDeQDRTeueb9LZxkzrBvYbSgH6
	SBqLsnnWUaTRJE7joA2rKShXxhKr2Eme+WOdG8fycCWyi6CEortzZV5V4W3lMUu84tUGxiOc3kL
	j402RyGkgWYBrkkU7sD4QKul7BQj6YvLZDAez9z3rS4R3pgBVSpiU9Bi6+BRQ/FWH5aymfbrK86
	YVVzU9TiNX0fbId7saVOnmbzfOaQSqtMzWoTvBZNgwOLGvp2RiU3bil8kvCv8DxYnNlN3ALbF05
	doVwFe2N6n/c50hnjSHHrf2Mx5Ubuc1ZIx90BL7beopV6VyczOY/zXoM2mWKhHg6+R5QoO6BjiE
	Q4E8Vzu0HpwuSzzmS9T+za7Nj3EnFktx3EOTgIyEWkA2Xbj5WpYWZeWCNSBX8JGGwFBOda/kcE2
	ljxlag2WwOl9wR4Lk=
X-Received: by 2002:a17:907:c205:b0:c0c:48b1:21ca with SMTP id a640c23a62f3a-c0c65adf4a1mr818261166b.29.1782242480048;
        Tue, 23 Jun 2026 12:21:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99aff0sm555213266b.19.2026.06.23.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 12:21:19 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jakub Kicinski <kuba@kernel.org>,
  Jiayuan Chen <jiayuan.chen@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  netdev@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code
 behind CONFIG_NET_SOCK_MSG
In-Reply-To: <CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
	(Kuniyuki Iwashima's message of "Tue, 23 Jun 2026 09:08:04 -0700")
References: <20260623-bpf-sk_msg-split-unix-v2-1-ca7a626a94a5@cloudflare.com>
	<CAAVpQUBsQFFxJFDnJzxmsER3bOjm=zqJ5P5MSeW_T9v-4639cw@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 23 Jun 2026 21:21:18 +0200
Message-ID: <87v7b9ysep.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-301465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:john.fastabend@gmail.com,m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83FE56B9AD9

On Tue, Jun 23, 2026 at 09:08 AM -07, Kuniyuki Iwashima wrote:
> On Tue, Jun 23, 2026 at 4:20=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Prepare to decouple BPF_SYSCALL config option from NET_SOCK_MSG. When
>> completed all code paths related to sockmap-based redirects should be
>> guarded by BPF_SYSCALL && NET_SOCK_MSG to allow users to opt out by
>> disabling NET_SOCK_MSG. The implementation of sockmap as a container for
>> socket references would remain under BPF_SYSCALL.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>> Changes in v2:
>> - Handle prot->recvmsg being NULL (Sashiko)
>> - Elaborate on the end goal in description
>> - Link to v1: https://patch.msgid.link/20260622-bpf-sk_msg-split-unix-v1=
-1-d7e0cb7bb03b@cloudflare.com
>> ---
>>  net/unix/af_unix.c  | 4 ++--
>>  net/unix/unix_bpf.c | 6 ++++++
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index f7a9d55eee8a..84c11c60c75f 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -2675,7 +2675,7 @@ static int unix_dgram_recvmsg(struct socket *sock,=
 struct msghdr *msg, size_t si
>>  #ifdef CONFIG_BPF_SYSCALL
>>         const struct proto *prot =3D READ_ONCE(sk->sk_prot);
>>
>> -       if (prot !=3D &unix_dgram_proto)
>> +       if (prot->recvmsg)
>
> There is no reason to have this dead branch when
> CONFIG_BPF_SYSCALL && !NET_SOCK_MSG.
>
> Let's compile out all sockmap code when both configs
> are not enabled.
>
> Since AF_UNIX differs from TCP/UDP, it can take the
> simpler approach.

Okay, will put the whole file behind hidden config option like so:

--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -30,3 +30,8 @@ config UNIX_DIAG
        help
          Support for UNIX socket monitoring interface used by the ss tool.
          If unsure, say Y.
+
+config UNIX_BPF
+       bool
+       depends on UNIX
+       default y if BPF_SYSCALL && NET_SOCK_MSG

