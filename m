Return-Path: <netdev+bounces-280922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAmKFSPh6mkNFAAAu9opvQ
	(envelope-from <netdev+bounces-280922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:18:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302D4596A7
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE93301497D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F1E30B521;
	Fri, 24 Apr 2026 03:16:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C802F1FEF
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777000610; cv=none; b=BJWQ02BsOfKvLsIHkcLDSbziUzahFgmRlE7qb6Yz5BnJKkkOX/tvogAzNfnalb+J69G7mBudW1VPE99T9+O+lkiHRQl6Js/C9kcDahrpQfUAw8Lz9Dm99unce1MwU4ELhNOefdjCZR6gKr0GURjX9kfGXPs9wWpF4o7FJ6vlGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777000610; c=relaxed/simple;
	bh=8eWRklEcsnO+layhGpeOy/TdHuVihUKHJU8wUKCcp9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=fseGhfVg/DdncrWgsLnK15fNCgYTSyjvK0pWNnCnXrl5fsFDZz+b55ap2mG+HUlJx2/Kq6kFO/h8Yo5ub4TfTWT8OTGBLiKX1TTrnjpWRDQcjzBcrndgw9QJZmyMjK0Ej/bn3WvY0M75lAEbQS/3gKf5rAMweeJT/m9g3kusuFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-696233b2816so1054749eaf.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777000608; x=1777605408;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtv9d/6hedMhDL1o+7dNWLzzrMUHSCorbLAQ6CQIkkM=;
        b=Ug9srjOoa4hmBspkvOdEXf5LGEal+ZvE96vb83WlAtz3RMATygOFmoIpHD/HrmUfpP
         8fqQJAoZi2o8zvK3aR95LGmV5CghB/nx8ovO7wT59I8zwfkTkhlaUiYIhOJeqfz9/VOT
         m+U2Hyqg3sR7z0V+9TmyXBZbkCcZig3PinbSIvGbdbnp4BiPM3O9lPpHCWUUKCBGF6bn
         0IeaZhFvm4ln10Ih4ubvzxIj5Gj+KRTrbWn8S3zJBTjEbCLL4luOjVkRFAzpqnU9JRC4
         93lYdJdzG2Alk7K7DIvdm2/qWn865w6mqFtHVTHw+MeutCTvTRJEMGjq/EIuKfay3H1+
         rmnw==
X-Forwarded-Encrypted: i=1; AFNElJ91s24++u3l2zqlmce/+HczxLrtHgs2hKHTKh+OZI0JwVvKJ+s2me5uMg1P8cW+3VZNjgxKOwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GVNOkncCacsjcYw8+bWxbZmc8CbXEVsmjI+MFWxIU5TKSjRo
	bn1icURPSss7n6KYZwHH9uhay7Tg5s/NIZLhMtSrsbOBWIOqKaD81KRQp5U8lNXFEDELrKYz60v
	X27Bcsx38At1+7uVGu33sj15eT3RY1r7FVzKKEZQ+vR4ECijBVfiAjQWkT1o=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:98a:b0:681:22fd:a571 with SMTP id
 006d021491bc7-69462f303b6mr16773450eaf.47.1777000608489; Thu, 23 Apr 2026
 20:16:48 -0700 (PDT)
Date: Thu, 23 Apr 2026 20:16:48 -0700
In-Reply-To: <2ebe2714.7628.19dbd7d2b62.Coremail.25181214217@stu.xidian.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eae0a0.a00a0220.17a17.0050.GAE@google.com>
Subject: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when
 queue is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: 25181214217@stu.xidian.edu.cn
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8302D4596A7
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
	TAGGED_FROM(0.00)[bounces-280922-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,appspotmail.com:email]

> Hi,
>
> Thank you so much for the review and for pointing me to the correct Fixes=
 tag!
>
> You hit the nail on the head regarding `__ip6_append_data()`. After re-ev=
aluating the code path based on your question, I realize my assumption in v=
2 was incorrect. `__ip6_append_data()` does indeed guarantee that an skb is=
 queued upon success, making the `skb =3D=3D NULL` path dead code in this c=
ontext.
>
> I traced the `failslab` memory leak back to its true origin: the lockless=
 fast path wrapper `ip6_make_skb()`.
>
> Sabrina previously noted that `ip6_setup_cork()` failures correctly relea=
se the dst. That is absolutely true for the slow path, where `udp_v6_flush_=
pending_frames()` eventually handles the cleanup.=20
>
> However, in the fast path, `ip6_make_skb()` calls `ip6_setup_cork()`. Ins=
ide `ip6_setup_cork()`, `cork->base.dst` is assigned early. If a subsequent=
 memory allocation fails (e.g., `v6_cork->opt =3D kzalloc(...)` failing due=
 to failslab), it returns an error. `ip6_make_skb()` then directly returns =
`ERR_PTR(err)` WITHOUT calling `ip6_cork_release(cork)`.
>
> Since `udpv6_sendmsg()` assumes the `dst` reference is stolen by `ip6_mak=
e_skb()` and unconditionally jumps to `out_no_dst`, the `dst` is completely=
 leaked.
>
> The fix is simply to add `ip6_cork_release(cork)` in the `ip6_setup_cork(=
)` error path inside `ip6_make_skb()`.
>
> I will submit a v3 patch shortly addressing this true root cause and usin=
g your suggested Fixes tag. Thank you again for steering me in the exact ri=
ght direction!
>
> Best regards,
> Mingyu Wang
>
>
>> -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Willem de Bruijn" <willemdebruijn.kernel@g=
mail.com>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-04-23 22:59:45 (=E6=98=9F=E6=
=9C=9F=E5=9B=9B)
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Mingyu Wang" <25181214217@stu.xidian.edu.c=
n>, willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@kernel.or=
g, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
>> =E6=8A=84=E9=80=81: sd@queasysnail.net, horms@kernel.org, netdev@vger.ke=
rnel.org, linux-kernel@vger.kernel.org, "Mingyu Wang" <25181214217@stu.xidi=
an.edu.cn>, syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> =E4=B8=BB=E9=A2=98: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_s=
kb() when queue is empty
>>=20
>> Mingyu Wang wrote:
>> > During fuzzing with failslab enabled, a memory leak was observed in th=
e
>> > IPv6 UDP send path.
>> >=20
>> > The root cause resides in __ip6_make_skb(). In extremely rare cases
>> > (such as fault injection or specific empty payload conditions),
>>=20
>> Can you elaborate on this? Which fault injection lets
>> __ip6_append_data succeed without writing data?
>>=20
>> > __ip6_append_data() may succeed but leave the socket's write queue
>> > empty.
>> >=20
>> > When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
>> > returns NULL. The previous logic handled this by executing a 'goto out=
;',
>> > which completely bypassed the call to ip6_cork_release(cork).
>> >=20
>> > Since the 'cork' structure actively holds a reference to the routing
>> > entry (dst_entry) and potentially other allocated options, skipping
>> > the release cleanly leaks these resources.
>> >=20
>> > Fix this by introducing an 'out_cork_release' label and jumping to it
>> > when skb is NULL, ensuring the cork state is always properly cleaned u=
p.
>> > The now-unused 'out' label is also removed to prevent compiler warning=
s.
>> >=20
>> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>=20
>> I think this is=20
>>=20
>> Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")
>>=20
>> > Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


