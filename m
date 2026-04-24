Return-Path: <netdev+bounces-280954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NxoCDMU62lsIAAAu9opvQ
	(envelope-from <netdev+bounces-280954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:56:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C2D45A666
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 451333004626
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 06:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C8363C40;
	Fri, 24 Apr 2026 06:56:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AA35B658
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777013804; cv=none; b=EhIdzNogVQQjpL2zw3aiarOdLLbHaPObcv9myc9J3AtpS37Tw5+0O4HsicVZUN4jXeO5HYLOpqXhAJcBUGW12nsXxy4QErTdDpD5zJ7uF9/raz9n84jMVkw/9zKSlo4IIaYnVnb1PDa45uP84cyp1V9q6lyCKFX0MgOoLfwgb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777013804; c=relaxed/simple;
	bh=J0JmbY+wUWo7NK0iqP2UmmeslQq83d2U+NgxvyHJuW4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=CTCUID8HDISiuUw9RuMhAZuoK23s+exaux9TDTGHDGt1R/gUfeEU1Gjps5W7Ss9OexhrSaNBXdOXNfle4ze4cdeiZdqsYC+vSqcXB+8qvwQIVRxiA2aXggxnqjsvBsyNgk4RJJLHIRuhrKl6xanFewjZNZ3fdaGeO8DxDft8xyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d4be1dee67so18210969a34.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 23:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777013802; x=1777618602;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAsE/KVTWjritLPBB+Y1TX19dLKdVFpMgdPFJaY1J0U=;
        b=mgHADZ9U7I6H7dfVY3NXoJsUNZsfbuWNcXx9SvPHWkrG8G6KztTx3VXwRHL+pl4M71
         a3lE/BExAZnn8qYp6OEJSFjT0pkwZPMA79zS1rYcQnrgv15VXRbTmydWr8sJ22fe4dZP
         BrXexPLcXHCzFoqaf27Iv+dNknafe5niffN9BnH2qos3mk2+oUxMeT0Jrlidqvw33Zac
         19MCP4bY4gFX6c+RuaM9r6Sa270l0A1VGwHbTNg3ovFhkTA2oqdNDx5C1xFA1QBCNMLC
         /BpmsJ03mwS1DQaLv3OHlwCUkQlfWTnmAa2PYH9MAxWJ6qMpPhrkQrq60KLGHpoRNrKD
         hnMw==
X-Forwarded-Encrypted: i=1; AFNElJ9p26Jjq+xrmo1W3jB9ILq3P4d4cXLpIiqbiXdvDALSzkHE/EtInIuHIacpienQx7l1MuKZIj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ynrjhpF6FqN0W3bVEYP2p+9UVo2dYPcJ5Uf6Db8tVBH0mwVW
	2vedKB6850odEXh0EDHd8uIIddqNQP4AIF0OTmWICupVqTSK/5cw/bTJpay/zbBzGtLEqWEgj/x
	iDQGG41qdG28j7d6I5EN16+JC+LTQDHoQouJAT17w6IdCXIumVtzf5BHg1xg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:189a:b0:695:a610:eccb with SMTP id
 006d021491bc7-695a610ee89mr5506153eaf.20.1777013802106; Thu, 23 Apr 2026
 23:56:42 -0700 (PDT)
Date: Thu, 23 Apr 2026 23:56:42 -0700
In-Reply-To: <68628d54304821fe8410e756ce3f92c60da10e1d.camel@siemens.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eb142a.a00a0220.9259.0034.GAE@google.com>
Subject: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when
 queue is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: florian.bezdeka@siemens.com
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, florian.bezdeka@siemens.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C9C2D45A666
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
	FREEMAIL_CC(0.00)[stu.xidian.edu.cn,davemloft.net,kernel.org,google.com,siemens.com,vger.kernel.org,redhat.com,queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-280954-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,davemloft.net:email,xidian.edu.cn:email]

> On Fri, 2026-04-24 at 11:26 +0800, =E7=8E=8B=E6=98=8E=E7=85=9C wrote:
>> Hi Sabrina and Jakub,
>>=20
>> Before sending out the v3 patch, I synced my tree to the latest mainline=
 and checked the current state of `ip6_make_skb()`.=20
>>=20
>> It turns out that the missing `ip6_cork_release(cork)` in the error path=
 was already naturally resolved by Eric Dumazet's recent refactoring commit=
:
>> b409a7f7176b ("ipv6: colocate inet6_cork in inet_cork_full")
>>=20
>> With Eric's changes, the error handling now correctly calls `ip6_cork_re=
lease(cork)` if `ip6_setup_cork()` fails, meaning the memory leak is no lon=
ger present in the latest tree.
>
> Fine, so mainline is correct now. What about the stable trees? Did you
> check them already?
>
> Florian
>
>>=20
>> Please disregard my v1 and v2 patches. I am also telling syzbot to close=
 this report based on Eric's commit.
>>=20
>> Thank you all again for your time, the deep code review, and for guiding=
 me to find the true root cause. I learned a huge amount from this discussi=
on!
>>=20
>> #syz fix: ipv6: colocate inet6_cork in inet_cork_full
>>=20
>> Best regards,
>> Mingyu Wang
>>=20
>> 2026-04-24 11:16:30 "=E7=8E=8B=E6=98=8E=E7=85=9C" <25181214217@stu.xidia=
n.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>> > Hi,
>> >=20
>> > Thank you so much for the review and for pointing me to the correct Fi=
xes tag!
>> >=20
>> > You hit the nail on the head regarding `__ip6_append_data()`. After re=
-evaluating the code path based on your question, I realize my assumption i=
n v2 was incorrect. `__ip6_append_data()` does indeed guarantee that an skb=
 is queued upon success, making the `skb =3D=3D NULL` path dead code in thi=
s context.
>> >=20
>> > I traced the `failslab` memory leak back to its true origin: the lockl=
ess fast path wrapper `ip6_make_skb()`.
>> >=20
>> > Sabrina previously noted that `ip6_setup_cork()` failures correctly re=
lease the dst. That is absolutely true for the slow path, where `udp_v6_flu=
sh_pending_frames()` eventually handles the cleanup.=20
>> >=20
>> > However, in the fast path, `ip6_make_skb()` calls `ip6_setup_cork()`. =
Inside `ip6_setup_cork()`, `cork->base.dst` is assigned early. If a subsequ=
ent memory allocation fails (e.g., `v6_cork->opt =3D kzalloc(...)` failing =
due to failslab), it returns an error. `ip6_make_skb()` then directly retur=
ns `ERR_PTR(err)` WITHOUT calling `ip6_cork_release(cork)`.
>> >=20
>> > Since `udpv6_sendmsg()` assumes the `dst` reference is stolen by `ip6_=
make_skb()` and unconditionally jumps to `out_no_dst`, the `dst` is complet=
ely leaked.
>> >=20
>> > The fix is simply to add `ip6_cork_release(cork)` in the `ip6_setup_co=
rk()` error path inside `ip6_make_skb()`.
>> >=20
>> > I will submit a v3 patch shortly addressing this true root cause and u=
sing your suggested Fixes tag. Thank you again for steering me in the exact=
 right direction!
>> >=20
>> > Best regards,
>> > Mingyu Wang
>> >=20
>> >=20
>> > > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> > > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Willem de Bruijn" <willemdebruijn.kern=
el@gmail.com>
>> > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-04-23 22:59:45 (=E6=98=9F=
=E6=9C=9F=E5=9B=9B)
>> > > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Mingyu Wang" <25181214217@stu.xidian.e=
du.cn>, willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kerne=
l.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
>> > > =E6=8A=84=E9=80=81: sd@queasysnail.net, horms@kernel.org, netdev@vge=
r.kernel.org, linux-kernel@vger.kernel.org, "Mingyu Wang" <25181214217@stu.=
xidian.edu.cn>, syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > > =E4=B8=BB=E9=A2=98: Re: [PATCH v2] ipv6: fix memory leak in __ip6_ma=
ke_skb() when queue is empty
>> > >=20
>> > > Mingyu Wang wrote:
>> > > > During fuzzing with failslab enabled, a memory leak was observed i=
n the
>> > > > IPv6 UDP send path.
>> > > >=20
>> > > > The root cause resides in __ip6_make_skb(). In extremely rare case=
s
>> > > > (such as fault injection or specific empty payload conditions),
>> > >=20
>> > > Can you elaborate on this? Which fault injection lets
>> > > __ip6_append_data succeed without writing data?
>> > >=20
>> > > > __ip6_append_data() may succeed but leave the socket's write queue
>> > > > empty.
>> > > >=20
>> > > > When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
>> > > > returns NULL. The previous logic handled this by executing a 'goto=
 out;',
>> > > > which completely bypassed the call to ip6_cork_release(cork).
>> > > >=20
>> > > > Since the 'cork' structure actively holds a reference to the routi=
ng
>> > > > entry (dst_entry) and potentially other allocated options, skippin=
g
>> > > > the release cleanly leaks these resources.
>> > > >=20
>> > > > Fix this by introducing an 'out_cork_release' label and jumping to=
 it
>> > > > when skb is NULL, ensuring the cork state is always properly clean=
ed up.
>> > > > The now-unused 'out' label is also removed to prevent compiler war=
nings.
>> > > >=20
>> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> > >=20
>> > > I think this is=20
>> > >=20
>> > > Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")
>> > >=20
>> > > > Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > > > Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


