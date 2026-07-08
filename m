Return-Path: <netdev+bounces-305892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M1B/L1V9TmoeNwIAu9opvQ
	(envelope-from <netdev+bounces-305892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30958728CF6
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=X7RuaNBc;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305892-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305892-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2D4305EA6E
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 16:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2942DA43;
	Wed,  8 Jul 2026 16:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237F53F12F9
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 16:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527597; cv=none; b=aqBQfeEj59pyUHyrZdm0MG56i3dM3k5U6/NNeXU6XY23dcF8ZEaFAU7hHUHui72Oed7EVe3NDw+5vAi1pLpzUoRdcTCIeI0kz7xF/YBJ+YeAMhlB4ME0jvSkNuqM4fQKNRIoyCX5LFQ7StOw++wpHx0cmt7AzZkr2xg5vtpzyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527597; c=relaxed/simple;
	bh=LqRAHZpn9XsmnomtiA/+PnRH4DsQWzTchYzEcXUBzzw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JfaxHaJ/zfNLW6vGUcYEEnBaUyAeZYXrEUQs/Xe8sOiIjcOd7e5MirAVw8muHLJ7iN5T3p2/m2trj070I7HX8V2ogKia3psRip65dP1rrnFbcdPklKK9F3mu6g9Fgi7XgqbDQOBgCdwum7i1VEuQBvFvgRr4HkhvQslA/gCN43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=X7RuaNBc; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cad225673bso7954235ad.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783527595; x=1784132395; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KoeQIzrdmjIACDxHWQZkS7jhZWHaXngGQAZTPpEL6vk=;
        b=X7RuaNBctzYyEIibVicUKWtIPdBaXKUeTXIHLe58U7zhA/wCRzfaU1MrTjT8fC4RJy
         TcchrOPiH7wN8BRkW2WB+iH6sc2g3pnvHoft7L8C0Fx/9pz5i6YyNo1j6j7arUzXks1d
         y2xkQBdyzNaLQ5I810+/Gv5BeEHnR0AZ+rZ1eArJwGd80Rnv1ihyICtyr+GxZSb9hb28
         KevviloO+GYQtdnv6Xa6OUvVVK5sO/OXsgzzgZaj8hh+MBAJrg1As7LcMB2XkkyHpD29
         fGH3MoXRyIc2krjsbtBlivBLkgLNokzKt1sGRgdPDkr51jDQ6RCL44Bmo5Xk1HGMekvf
         27DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527595; x=1784132395;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoeQIzrdmjIACDxHWQZkS7jhZWHaXngGQAZTPpEL6vk=;
        b=hVl0WojrPtbnukF2hILwxMTvdDU4jwoLj9lcP9gg99fAEv79Rir7GmO7ePgfkqrtO6
         hHppTwAsvNj4NqD2QPOkGaTAUa4mG3NpVVINgspV0QVV3EMr6SWvo3NQZOcECyNJrijZ
         E9UfPYXL1gmYA/bRAkAqPSDRQim+qxEtx7COUc/UmMypG6KCQfmIHkDSLHLCYcShqyrK
         4ew49F4shjUHpUbYrlpx3VigfDDyxql36ijent2Sszx5M6Iq/XvUSW4JJthBY+01YgSo
         QrsjFmEYNCr2zBqAJXeVU3Y8BSlwWzrs/oKQk/wfIZb9sfLXZnX9ebXw1A5p1RWGG4ze
         zfXg==
X-Gm-Message-State: AOJu0YwOu9IGt7yrTZcSoabmpzK0K3URlFxM0bJEsyXxfAdNosi40hc4
	eGoHQCiCiWfqos2o3WOcrBMM9DsFc82knIhCIGaUA2Hs9UQVm5JzO/f2abjvoFshEns=
X-Gm-Gg: AfdE7cl49dR1pN7DB0sNIMQF6zKO0cmABANanMIhe+qzwP3iH0WFeHjKPFztE+mRRLs
	bXJQf8EVK/OvfHjjG8eyxXQuw6/qMwFh5UpalcXw0xgwoZ0xcSJUFyAqQeS07EzV1FqIwskhwJe
	AOAEn/2TuV08xJ3wmlGM6ZPyTwU44wJ1EQKDWGPrtsgERcJ1nmOxzuRNipEKxikgBC4NHLI8CE7
	2rZwc/aqnWS7MuVC8Rar7LpcDUYGur2XkxoxaDp3M72r1qmOFkO0l7AKknozf9K3p85nAxkxusE
	xrrERTpzA8EELfwt3TO926fdQFqQ/6yjgNC6XaQy6uxaH5gO05U0jRN+uJ75I+Eb6G/eYe+btzr
	0nhHepW87CwNfH3bbmir1iljoAZTx3tV7Wck6GxtWc5YTRU/wcGcV7weHaQ7vEvY8SDu6pg++15
	Venr9w9sNdikFDUjWE4MR2nRevy2FSipZWxgYGxaGY0w==
X-Received: by 2002:a17:902:e5c5:b0:2cc:aa36:c046 with SMTP id d9443c01a7336-2ccea2cbd6amr32640175ad.14.1783527595214;
        Wed, 08 Jul 2026 09:19:55 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d2efsm30247775ad.64.2026.07.08.09.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 09:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 12:19:54 -0400
Message-Id: <DJTBRLLCR138.YFMNJ4MITDR7@etsalapatis.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
 <DJSIEQSX3AFI.341HNU79LHFEF@etsalapatis.com>
 <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>
In-Reply-To: <DJSWX1VY6XXI.1XRGI8HMHT6JT@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305892-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattia.meleleo@coralogix.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,etsalapatis.com,coralogix.com,cloudflare.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis-com.20251104.gappssmtp.com:dkim,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,coralogix.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30958728CF6

On Wed Jul 8, 2026 at 12:41 AM EDT, Kumar Kartikeya Dwivedi wrote:
> On Tue Jul 7, 2026 at 7:19 PM CEST, Emil Tsalapatis wrote:
>> On Tue Jul 7, 2026 at 12:15 PM EDT, Mattia Meleleo via B4 Relay wrote:
>>> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>>
>>> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
>>> counts bytes in ingress_msg. Without a stream/skb verdict program
>>> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
>>> returns 0 even though read() returns data.
>>>
>>> Add tcp_inq() to the reported value when the psock has no verdict
>>> program. The two queues are disjoint, so bytes redirected into
>>> ingress_msg from other sockets stay correctly accounted through
>>> msg_tot_len.
>>>
>>> Add a selftest covering FIONREAD without a verdict program.
>>>
>>> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
>>> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
>>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> I don't think the Sashiko READ_ONCE() recommendation is that important,
>> we're just checking for the pointers' existence and I don't see how the
>> reads can be moved/optimized out/merged in a way that breaks this code.
>>
>
> It would be necessary if the xchg() can happen even when the lock is held=
, at
> the very least, to suppress potential KCSAN warnings, I think. Even for t=
he
> theoretical load tearing that causes false positive, it would be benign d=
ue to
> wrong accounting.
>

Fair enough, nothing wrong with adding the READ_ONCE since the set already
needed respinning.

>>> ---
>>>  net/ipv4/tcp_bpf.c                                 | 16 ++++++++-
>>>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 39 ++++++++++++++=
++++++++
>>>  2 files changed, 54 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>>> index cc0bd73f3..a001b1fff 100644
>>> --- a/net/ipv4/tcp_bpf.c
>>> +++ b/net/ipv4/tcp_bpf.c
>>> @@ -334,6 +334,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>>>
>>>  static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
>>>  {
>>> +	struct sk_psock *psock;
>>>  	bool slow;
>>>
>>>  	if (cmd !=3D SIOCINQ)
>>> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd,=
 int *karg)
>>>  		return -EINVAL;
>>>
>>>  	slow =3D lock_sock_fast(sk);
>>> -	*karg =3D sk_psock_msg_inq(sk);
>>> +	psock =3D sk_psock_get(sk);
>>> +	if (unlikely(!psock)) {
>>> +		unlock_sock_fast(sk, slow);
>>> +		return tcp_ioctl(sk, cmd, karg);
>>> +	}
>>> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
>>> +	/* Without a verdict program, ingress data is never diverted to
>>> +	 * ingress_msg: it stays in sk_receive_queue and is read through
>>> +	 * the fallback to tcp_recvmsg(), so account for it like
>>> +	 * tcp_ioctl() does.
>>> +	 */
>>> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)
>>> +		*karg +=3D tcp_inq(sk);
>>> +	sk_psock_put(sk, psock);
>>>  	unlock_sock_fast(sk, slow);
>>>
>>>  	return 0;
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/t=
ools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> index cb3229711..f0f368201 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>>> @@ -1373,6 +1373,43 @@ static void test_sockmap_multi_channels(int soty=
pe)
>>>  	test_sockmap_pass_prog__destroy(skel);
>>>  }
>>>
>>> +/* A socket in a sockmap without a verdict program keeps its ingress d=
ata
>>> + * in sk_receive_queue: FIONREAD must account for it.
>>> + */
>>> +static void test_sockmap_no_verdict_fionread(void)
>>> +{
>>> +	int err, map, zero =3D 0, sent, avail;
>>> +	int c0 =3D -1, c1 =3D -1, p0 =3D -1, p1 =3D -1;
>>> +	struct test_sockmap_pass_prog *skel;
>>> +	char buf[256] =3D "0123456789";
>>> +
>>> +	skel =3D test_sockmap_pass_prog__open_and_load();
>>> +	if (!ASSERT_OK_PTR(skel, "open_and_load"))
>>> +		return;
>>> +	map =3D bpf_map__fd(skel->maps.sock_map_rx);
>>> +
>>> +	err =3D create_socket_pairs(AF_INET, SOCK_STREAM, &c0, &c1, &p0, &p1)=
;
>>> +	if (!ASSERT_OK(err, "create_socket_pairs()"))
>>> +		goto out;
>>> +
>>> +	err =3D bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
>>> +	if (!ASSERT_OK(err, "bpf_map_update_elem(c1)"))
>>> +		goto out_close;
>>> +
>>> +	sent =3D xsend(p1, &buf, sizeof(buf), 0);
>>> +	ASSERT_EQ(sent, sizeof(buf), "xsend(p1)");
>>> +	avail =3D wait_for_fionread(c1, sizeof(buf), IO_TIMEOUT_SEC);
>>> +	ASSERT_EQ(avail, sizeof(buf), "ioctl(FIONREAD)");
>>> +
>>> +out_close:
>>> +	close(c0);
>>> +	close(p0);
>>> +	close(c1);
>>> +	close(p1);
>>> +out:
>>> +	test_sockmap_pass_prog__destroy(skel);
>>> +}
>>> +
>>>  void test_sockmap_basic(void)
>>>  {
>>>  	if (test__start_subtest("sockmap create_update_free"))
>>> @@ -1415,6 +1452,8 @@ void test_sockmap_basic(void)
>>>  		test_sockmap_skb_verdict_shutdown();
>>>  	if (test__start_subtest("sockmap skb_verdict fionread"))
>>>  		test_sockmap_skb_verdict_fionread(true);
>>> +	if (test__start_subtest("sockmap no_verdict fionread"))
>>> +		test_sockmap_no_verdict_fionread();
>>>  	if (test__start_subtest("sockmap skb_verdict fionread on drop"))
>>>  		test_sockmap_skb_verdict_fionread(false);
>>>  	if (test__start_subtest("sockmap skb_verdict change tail"))
>>>
>>> ---
>>> base-commit: d2c9a99135da931377240942d44f3dea104cedb8
>>> change-id: 20260707-fionread-no-verdict-a4f8697ac9f9
>>>
>>> Best regards,
>>> --
>>> Mattia Meleleo <mattia.meleleo@coralogix.com>


