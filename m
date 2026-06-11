Return-Path: <netdev+bounces-297968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iqyULT9ZKmqAnwMAu9opvQ
	(envelope-from <netdev+bounces-297968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:44:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CEF66F1DC
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:44:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Ck/M3nVb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297968-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297968-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686CF30E623E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2FB35837E;
	Thu, 11 Jun 2026 06:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01572F0C74
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:43:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781160207; cv=none; b=OUGUXMBYR2Wye6OLtDq8xRnTExmFsDdfh/XdptT4HbbdRi3LmcBCrmJDCLZnlMC9BWFOYq9VVLHCHYv1no1SxXMtWeJ91s1dps/J4mDSJb+5pVSG9NMnf3VwCAn5h84PwC6hZzwNojMJl31jjnV2EIOIF0Ldqty05Dg7BC983Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781160207; c=relaxed/simple;
	bh=K/M8coSFnq6IsTOuqp4zuktQLAgl5ei8ih3qN6roLE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFWy4bIB+ZK3M8rg+PBXBA5/DFCGwxXD0+mUHsIcIyfrDi2xbYQ294HeJ67GTxJoQaqIEZO5P7BUVVgc+diY3IlKslTjlSiBWO90BmMvKmbVicXOh5Q6NX5s7GoJ1e+ZYzp2Vc4ph2HFjLi8L8phFKwI7MvJg5ZdWKfhqxjXthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck/M3nVb; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0c3546924so50943885ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781160206; x=1781765006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjDQiQ3ktWIaKvOvujnBDVWDyaYYudokO5mTxz5o6xs=;
        b=Ck/M3nVb4WBIfZ7VS0zlbZj/4ugA0ud/3l2us/u12bU7qd7NCEC5xOthvWgC3oYezQ
         wshbEryvIkk/7A+QHnGF3F2OgxndYp86MGe+BMuxd1rQvhWoVgfUSu0+lTT17tZLx+Ct
         VYKnNZDAJ1UCnAxPUftD8g1iswPmhheMISeOV4m/x+J19Fl2VTqMTFubMhu5AnScy8N9
         cqH/7FfIvDOQUuXSk2JdQpxX4JSDnguwplnVoxMJn7gujehRoIbgEB8xpNyajRqrBP/y
         cZ345mIqnV9w01F6rOR3aVNey9eg2643sSKWGeEShL4mrc00yNInSegKHf4G5wCm3+XU
         8P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781160206; x=1781765006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjDQiQ3ktWIaKvOvujnBDVWDyaYYudokO5mTxz5o6xs=;
        b=stDaZHIO/kffcxah+Ww4fUtlmsIIXh9FjWOWqjWGHn3qTgdEF6zoMf7Aqn2covsVyr
         29BgKaTaWCHkVwGPnhKNzn0J7e9loswIpcVv3IVlxuMinVzaM+M+z2tCMc2jQIS4Nsd6
         jpo6IC4JZgILptn9fIkOBGYqx3QIQNTDXhI6LjP69jDiBpsde+/1QalJ7pmxxNDffAxp
         EgGu9cOqrJFToWXN5LcbwJYMeVrUbvh7IDcDarOzW3jcximI5VYd/MoOWJK+U2Fcc9cs
         IkTkL37HAynUsFTXQxCExpLTU558F9bYzCuAhwUAvQFA/cHjWTkmh94+NN6iPyzFuKua
         Q5XA==
X-Forwarded-Encrypted: i=1; AFNElJ8Jb5VhcIwFUX2i+0gv5GXY9/0gOjvuDT0KKJ1w+xFO+s6y1r3qZKAFY9v+N9As+PKEQ7jPu0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKIKMoyTsUTlL04jqpuNh/CSI6bm3iKYrspyDleWV58aOZ1MGe
	9BycQeCu1wz+n7HNpHukWe7w2rWwU/eAmDEEk/3JI9kZLRzLm0LWQf1R
X-Gm-Gg: Acq92OEFdjdxqD7CRgIeQpt69DD1h7TV/ofHZb3VMowjTGfaLY93Z+Px8m0yFex8VaT
	ExBjansZmXcPFnEfQJwxiHlH8Fn67A2hl4Yt2ccgUloobR2p0crTEL3Lj//dPQ/20s4SWSR1Xnc
	Q2HsmMstU+L3Qm2EiwuVhTMYA7LCQ93sFdN0Mu3V7XuOkekKRFeZ8aizi9e667m/WXZwcA3nP6J
	Wa5aaL2zGqfJ/M/Jy5U8cha04THovEE/VqGMK9OsWFBX4MEBqTGKucIaUmDDs3JoIybAG/F4gKf
	HZdVp1POuyrhfEvZdpnutThakCwxbGKqnrPYnB87VkXomVJQzeSoGweW60c4jrQhdHwnlUAB8t1
	0sh/6e1Fz9cJ5QIzfBcDE57ytlGCG68+SV+F99+bo6as/DCLjZ5SZS44V60XHzt00oj6wooWB35
	fFzWHpBV6EluH19tZdQUcDq+n6ZQOGot2bBcs2Pgfuzz2/vKbxvSfth5UnCgZZU9jTR6GCCvq/+
	SeIAAlI
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr16600215ad.21.1781160205915;
        Wed, 10 Jun 2026 23:43:25 -0700 (PDT)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edc8ad7sm144553485ad.42.2026.06.10.23.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 23:43:25 -0700 (PDT)
Date: Thu, 11 Jun 2026 06:43:17 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net v2] tcp: clear sock_ops cb flags before force-closing
 a child socket
Message-ID: <xidpdd43jvuzb3ifbsnjjr7puxc6cmh4abp566rv2twollkn6s@eplmy3mtfksj>
References: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
 <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:brakmo@fb.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297968-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,eplmy3mtfksj:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 10CEF66F1DC

On Wed, Jun 10, 2026 at 11:11:49PM -0700, Kuniyuki Iwashima wrote:
>On Wed, Jun 10, 2026 at 9:00 AM Sechang Lim <rhkrqnwk98@gmail.com> wrote:
>>
>> A child socket inherits the listener's bpf_sock_ops_cb_flags via
>> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
>> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
>> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
>> without it.
>>
>> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
>> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():
>>
>>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>>   Call Trace:
>>    <IRQ>
>>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>>    </IRQ>
>>
>> The child is freed before it is ever established, so it should run no
>> sock_ops callback. Clear its cb flags in inet_csk_prepare_forced_close(),
>> which covers all forced-close callers.
>>
>> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>> v2:
>>  - move the clearing into inet_csk_prepare_forced_close() (Jiayuan Chen,
>>    Simon Horman)
>>
>> v1:
>>  - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.com/
>>
>>  include/net/tcp.h               | 7 +++++++
>>  net/ipv4/inet_connection_sock.c | 1 +
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 98848db62894..97eac5fa341c 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>>         return tcp_call_bpf(sk, op, 3, args);
>>  }
>>
>> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>> +{
>> +       tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
>> +}
>> +
>>  #else
>>  static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
>>  {
>> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
>>         return -EPERM;
>>  }
>>
>> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
>
>nit: I think prefered style is
>
>static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>{
>}
>

Will fix in v3.

>> +
>>  #endif
>>
>>  static inline u32 tcp_timeout_init(struct sock *sk)
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>> index dbcd37dfdc15..209f73a61a1d 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -1290,6 +1290,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
>>         __releases(&sk->sk_lock.slock)
>>  {
>>         /* sk_clone_lock locked the socket and set refcnt to 2 */
>> +       tcp_clear_sock_ops_cb_flags(sk);
>
>mptcp's ->syn_recv_sock() will trigger the hook in the failure path.
>
>inet_csk_prepare_for_destroy_sock() is a better fit.  We don't
>care if the child socket is locked in this path.
>
>

Makes sense, I missed the mptcp failure path. Moving it there in v3.

Thanks,
Sechang

