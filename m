Return-Path: <netdev+bounces-280924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ih7FRnj6mkbFQAAu9opvQ
	(envelope-from <netdev+bounces-280924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:27:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E536459706
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEFA130075C6
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661C2332906;
	Fri, 24 Apr 2026 03:27:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528933067F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001237; cv=none; b=avuiaXsTJLrDl9oOyetixgM3wpDBGzpCrlqUfJOypfFWq0+c6AKZI4nErds2nmqJIdcOG1xgjEKIA6p+65r0GvMC34I4t18vccBHzBZz+k7z8HPK5EPddSC5PdMGovN0CdcuRAJLPjSiaaV9rWSiboKq0URXF0r8NzCu3KZhs7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001237; c=relaxed/simple;
	bh=0AoTguzBN8mKKCDCJ82u/RQxCwI2CsHGJNhMtrhiwYY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bJihRm+b2l8WJIzce4bZ5uVXfURNrUpHcyzdsonmgSPM3wK/GZ9oJ/mRx9YgivnmyR3dKRxw8fm6XLSIgKxLh601u152rBSlj0UIuBG6Pozz8CkB2ZN79fYFUM5YgF+po3Yp2hbxG2o7v3slQ7EwT//jaCIRl/n8D5AfovPLSdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-694885643e1so9364498eaf.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001235; x=1777606035;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9H9/taI5CUrg1eJFWKBiLdIg5ptElOQYy3iuN3iNMrM=;
        b=snPz1sn+KRDm+6HiSHBPSIIz3zYZQG1NdBvIUsfJHrJNbMRzWaHHK9CT/4dbIjfj86
         L+aqb1LbbVa7xO9CgfvGyedIjZP+a14gIZfoOAHi3w1wx9M7zNeD9K5QbAEulLUbJFEV
         /aU7wocX5cf/6Ve3UIU3vvMY30Rd/YF22+GyEp+wZdp3GbX3uFdIO/BXyYmDHRFHroHZ
         t9qt9w3PShlLrnZBtKcz9tux9+P2gikAka9I5ZRbhK2Uj4jYRDUUy0XZfAfM5Izmo7v8
         XAVASLD2fE3aGMgWCLDztTh5OISFLFH9RSNZIcOQrv5kOGN3XyG+CNmoM5udGowDxL84
         NZ3g==
X-Forwarded-Encrypted: i=1; AFNElJ+o+NrvQ+GAk+fRDqumPVhjgKtUBvw02fXlikQ+mNk2CRd35UK6wukW3+jZ4VyalU3U9t5Z6Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcdqzTUgnYr3N5BEvaNMonQyUsPc9FqXhH6uPY+xk5GrmauPm
	MW7kQpLafztKYfHcIcHjrHPNNLNzKVT4yF0WBI0y59bBQEuyqMViyRDWS6z/YYtMbwRzD4jpz5C
	w44t10J15bBuIOyCF0Hy8U9S6Awzb3cXA+sGYTkhygAh9O+iiVsq3vyPcD+Y=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1629:b0:67e:dab:7cf5 with SMTP id
 006d021491bc7-69462e4892fmr18137490eaf.17.1777001234878; Thu, 23 Apr 2026
 20:27:14 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:27:14 -0700
In-Reply-To: <5eabb1a1.7642.19dbd869da3.Coremail.25181214217@stu.xidian.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eae312.a00a0220.9259.0030.GAE@google.com>
Subject: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when
 queue is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: 25181214217@stu.xidian.edu.cn
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7E536459706
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[stu.xidian.edu.cn,davemloft.net,kernel.org,google.com,vger.kernel.org,redhat.com,queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-280924-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,xidian.edu.cn:email,appspotmail.com:email]

> Hi Sabrina and Jakub,
>
> Before sending out the v3 patch, I synced my tree to the latest mainline =
and checked the current state of `ip6_make_skb()`.=20
>
> It turns out that the missing `ip6_cork_release(cork)` in the error path =
was already naturally resolved by Eric Dumazet's recent refactoring commit:
> b409a7f7176b ("ipv6: colocate inet6_cork in inet_cork_full")
>
> With Eric's changes, the error handling now correctly calls `ip6_cork_rel=
ease(cork)` if `ip6_setup_cork()` fails, meaning the memory leak is no long=
er present in the latest tree.
>
> Please disregard my v1 and v2 patches. I am also telling syzbot to close =
this report based on Eric's commit.
>
> Thank you all again for your time, the deep code review, and for guiding =
me to find the true root cause. I learned a huge amount from this discussio=
n!
>
> #syz fix: ipv6: colocate inet6_cork in inet_cork_full

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.

>
> Best regards,
> Mingyu Wang
>
> 2026-04-24 11:16:30 "=E7=8E=8B=E6=98=8E=E7=85=9C" <25181214217@stu.xidian=
.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>> Hi,
>>=20
>> Thank you so much for the review and for pointing me to the correct Fixe=
s tag!
>>=20
>> You hit the nail on the head regarding `__ip6_append_data()`. After re-e=
valuating the code path based on your question, I realize my assumption in =
v2 was incorrect. `__ip6_append_data()` does indeed guarantee that an skb i=
s queued upon success, making the `skb =3D=3D NULL` path dead code in this =
context.
>>=20
>> I traced the `failslab` memory leak back to its true origin: the lockles=
s fast path wrapper `ip6_make_skb()`.
>>=20
>> Sabrina previously noted that `ip6_setup_cork()` failures correctly rele=
ase the dst. That is absolutely true for the slow path, where `udp_v6_flush=
_pending_frames()` eventually handles the cleanup.=20
>>=20
>> However, in the fast path, `ip6_make_skb()` calls `ip6_setup_cork()`. In=
side `ip6_setup_cork()`, `cork->base.dst` is assigned early. If a subsequen=
t memory allocation fails (e.g., `v6_cork->opt =3D kzalloc(...)` failing du=
e to failslab), it returns an error. `ip6_make_skb()` then directly returns=
 `ERR_PTR(err)` WITHOUT calling `ip6_cork_release(cork)`.
>>=20
>> Since `udpv6_sendmsg()` assumes the `dst` reference is stolen by `ip6_ma=
ke_skb()` and unconditionally jumps to `out_no_dst`, the `dst` is completel=
y leaked.
>>=20
>> The fix is simply to add `ip6_cork_release(cork)` in the `ip6_setup_cork=
()` error path inside `ip6_make_skb()`.
>>=20
>> I will submit a v3 patch shortly addressing this true root cause and usi=
ng your suggested Fixes tag. Thank you again for steering me in the exact r=
ight direction!
>>=20
>> Best regards,
>> Mingyu Wang
>>=20
>>=20
>> > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Willem de Bruijn" <willemdebruijn.kernel=
@gmail.com>
>> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-04-23 22:59:45 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
>> > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Mingyu Wang" <25181214217@stu.xidian.edu=
.cn>, willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.=
org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
>> > =E6=8A=84=E9=80=81: sd@queasysnail.net, horms@kernel.org, netdev@vger.=
kernel.org, linux-kernel@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xi=
dian.edu.cn>, syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > =E4=B8=BB=E9=A2=98: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make=
_skb() when queue is empty
>> >=20
>> > Mingyu Wang wrote:
>> > > During fuzzing with failslab enabled, a memory leak was observed in =
the
>> > > IPv6 UDP send path.
>> > >=20
>> > > The root cause resides in __ip6_make_skb(). In extremely rare cases
>> > > (such as fault injection or specific empty payload conditions),
>> >=20
>> > Can you elaborate on this? Which fault injection lets
>> > __ip6_append_data succeed without writing data?
>> >=20
>> > > __ip6_append_data() may succeed but leave the socket's write queue
>> > > empty.
>> > >=20
>> > > When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
>> > > returns NULL. The previous logic handled this by executing a 'goto o=
ut;',
>> > > which completely bypassed the call to ip6_cork_release(cork).
>> > >=20
>> > > Since the 'cork' structure actively holds a reference to the routing
>> > > entry (dst_entry) and potentially other allocated options, skipping
>> > > the release cleanly leaks these resources.
>> > >=20
>> > > Fix this by introducing an 'out_cork_release' label and jumping to i=
t
>> > > when skb is NULL, ensuring the cork state is always properly cleaned=
 up.
>> > > The now-unused 'out' label is also removed to prevent compiler warni=
ngs.
>> > >=20
>> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> >=20
>> > I think this is=20
>> >=20
>> > Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")
>> >=20
>> > > Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > > Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

