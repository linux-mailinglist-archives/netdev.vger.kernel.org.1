Return-Path: <netdev+bounces-281007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBt+LDuQ62k+OQAAu9opvQ
	(envelope-from <netdev+bounces-281007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:46:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B7460ED8
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3454300749B
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494963CF045;
	Fri, 24 Apr 2026 15:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BC364021
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045245; cv=none; b=EFbS1v435UxD3dBGSvgNPnaAFfSamZRGgEJsqXfmf+0FuGDEE41LzZ7BoYmhzal9j7kgfnUpUCeceraxPoxW8jlGoQuTnNaS5QVW33e1IEWseweQfwNHi0St4O9+qLhFjncCyS9Ly9OUvm+ZomYkyw8MgVrP0t8ptyvx+WHpDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045245; c=relaxed/simple;
	bh=7fSIjeraM9Ech3knnZfdxx6ZTw19M1mSL+9l+VL2Iy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ktT1WGyaOULN0/e7uU+FYvXFr5xQLVTO2dxjKIWkgTPK0HYhNft7BaIctnAwxGetzeGHPqWpZLcBFlNBN5EZcmoFnuBXxUiolaiUfco9MwqeyH4T8j59yS8KrVyGPHN7YzsaUPglF73P9J8aMM2y56DJO2FolnEB8+dSzs83W+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dbbb806e10so16515075a34.1
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777045242; x=1777650042;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozZqfUgHbG5YT/ysMNliibcNAY4cXM7ckBYYcrMJsJI=;
        b=BUuO7Qls8TXej9oOFoISO4UteH9i4UIM2XmBJDuM0hJdPc+NqCbBsQbwodBQarDOsB
         CzNUyocP9sz5B9JNJxjuZYNZ3D6K/KyRBWh18WrKabf9XDYk78nr/DP2M+DWahFZMXmA
         1SmxIeEhx33ju7XyriHCH/3M8uY5sk6oEC/URcIJ+i6n72N8vepcwjHOYXOMm1YeDVl1
         lirTnC4YjqccKmzCqZRlzkGKFtnslT91gcse+sdRoawazmnedS/vPcZGggLoCDNyRXYX
         X5k6zaOf0FssFhdlmO6yqreWAlyzR6Wz7Rfnp/xinmunStxtawbJyjZ0wZ2+f7dmVxb7
         CWaw==
X-Forwarded-Encrypted: i=1; AFNElJ8zoGmL1Ci8DadLMiveL9XGB/2uSZl1sn+9izQqZYIdF7ASosgjcbPCpHQsQVZtLoSGHYFqlEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXZHYg/3Ap3RkTCbgrOdmMUDLl2Sum0t8zsjNwvUOtSje2Wqx
	IxiaHp0iAAdUQ9bpa6qHW6g5ejjKsdeWoa9KwEK6ydjtzB8WpgBOeS6l0EQl+7708uAx5lkDdyF
	eznT+rtuoN1luTvM2NYAMWK9WirH+6m05kmMfuaWVvi1tgmaOheIxv5KcOsk=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2227:b0:695:aea7:8c1a with SMTP id
 006d021491bc7-695aea79107mr7138880eaf.54.1777045242618; Fri, 24 Apr 2026
 08:40:42 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:40:42 -0700
In-Reply-To: <378c89ac.7c26.19dc0263038.Coremail.25181214217@stu.xidian.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69eb8efa.050a0220.37931.0001.GAE@google.com>
Subject: Re: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb()
 when queue is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: 25181214217@stu.xidian.edu.cn
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, florian.bezdeka@siemens.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7A3B7460ED8
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
	TAGGED_FROM(0.00)[bounces-281007-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,siemens.com:email,davemloft.net:email]

> Hi Florian and Sabrina,
>
> I checked the stable branches for a potential backport. It turns out no b=
ackport is needed because the stable trees are not affected by this specifi=
c leak path.
>
> Looking closely at `ip6_setup_cork()` in the stable trees, `cork->base.ds=
t =3D &rt->dst;` is assigned at the very beginning of the function.=20
>
> If a subsequent memory allocation fails (e.g., `kzalloc` failing due to f=
ailslab), it returns `-ENOBUFS`, but the `dst` reference is already linked =
to the cork. When `ip6_make_skb()` catches this error, it calls `ip6_cork_r=
elease(cork, &v6_cork)`, which successfully frees the `dst`.
>
> As Sabrina correctly pointed out regarding my v1, adding an explicit `dst=
_release()` here would actually cause a double free.
>
> The original syzbot memory leak report under `failslab` seems to be a fal=
se positive or related to a different object entirely. The `dst_entry` hand=
ling in this error path is already robust.=20
>
> This issue can be closed without any patches. Thanks for the discussion.
>
> Best regards,
> Mingyu Wang
>
>
>> -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Bezdeka, Florian" <florian.bezdeka@siemens=
.com>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-04-24 14:56:35 (=E6=98=9F=E6=
=9C=9F=E4=BA=94)
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: "willemdebruijn.kernel@gmail.com" <willemde=
bruijn.kernel@gmail.com>, "25181214217@stu.xidian.edu.cn" <25181214217@stu.=
xidian.edu.cn>
>> =E6=8A=84=E9=80=81: "syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.c=
om" <syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com>, "davem@davemlo=
ft.net" <davem@davemloft.net>, "dsahern@kernel.org" <dsahern@kernel.org>, "=
sd@queasysnail.net" <sd@queasysnail.net>, "linux-kernel@vger.kernel.org" <l=
inux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.=
org>, "horms@kernel.org" <horms@kernel.org>, "edumazet@google.com" <edumaze=
t@google.com>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pa=
beni@redhat.com>
>> =E4=B8=BB=E9=A2=98: Re: Re: Re: [PATCH v2] ipv6: fix memory leak in __ip=
6_make_skb() when queue is empty
>>=20
>> On Fri, 2026-04-24 at 11:26 +0800, =E7=8E=8B=E6=98=8E=E7=85=9C wrote:
>> > Hi Sabrina and Jakub,
>> >=20
>> > Before sending out the v3 patch, I synced my tree to the latest mainli=
ne and checked the current state of `ip6_make_skb()`.=20
>> >=20
>> > It turns out that the missing `ip6_cork_release(cork)` in the error pa=
th was already naturally resolved by Eric Dumazet's recent refactoring comm=
it:
>> > b409a7f7176b ("ipv6: colocate inet6_cork in inet_cork_full")
>> >=20
>> > With Eric's changes, the error handling now correctly calls `ip6_cork_=
release(cork)` if `ip6_setup_cork()` fails, meaning the memory leak is no l=
onger present in the latest tree.
>>=20
>> Fine, so mainline is correct now. What about the stable trees? Did you
>> check them already?
>>=20
>> Florian
>>=20
>> >=20
>> > Please disregard my v1 and v2 patches. I am also telling syzbot to clo=
se this report based on Eric's commit.
>> >=20
>> > Thank you all again for your time, the deep code review, and for guidi=
ng me to find the true root cause. I learned a huge amount from this discus=
sion!
>> >=20
>> > #syz fix: ipv6: colocate inet6_cork in inet_cork_full
>> >=20
>> > Best regards,
>> > Mingyu Wang
>> >=20
>> > 2026-04-24 11:16:30 "=E7=8E=8B=E6=98=8E=E7=85=9C" <25181214217@stu.xid=
ian.edu.cn> =E5=86=99=E9=81=93=EF=BC=9A
>> > > Hi,
>> > >=20
>> > > Thank you so much for the review and for pointing me to the correct =
Fixes tag!
>> > >=20
>> > > You hit the nail on the head regarding `__ip6_append_data()`. After =
re-evaluating the code path based on your question, I realize my assumption=
 in v2 was incorrect. `__ip6_append_data()` does indeed guarantee that an s=
kb is queued upon success, making the `skb =3D=3D NULL` path dead code in t=
his context.
>> > >=20
>> > > I traced the `failslab` memory leak back to its true origin: the loc=
kless fast path wrapper `ip6_make_skb()`.
>> > >=20
>> > > Sabrina previously noted that `ip6_setup_cork()` failures correctly =
release the dst. That is absolutely true for the slow path, where `udp_v6_f=
lush_pending_frames()` eventually handles the cleanup.=20
>> > >=20
>> > > However, in the fast path, `ip6_make_skb()` calls `ip6_setup_cork()`=
. Inside `ip6_setup_cork()`, `cork->base.dst` is assigned early. If a subse=
quent memory allocation fails (e.g., `v6_cork->opt =3D kzalloc(...)` failin=
g due to failslab), it returns an error. `ip6_make_skb()` then directly ret=
urns `ERR_PTR(err)` WITHOUT calling `ip6_cork_release(cork)`.
>> > >=20
>> > > Since `udpv6_sendmsg()` assumes the `dst` reference is stolen by `ip=
6_make_skb()` and unconditionally jumps to `out_no_dst`, the `dst` is compl=
etely leaked.
>> > >=20
>> > > The fix is simply to add `ip6_cork_release(cork)` in the `ip6_setup_=
cork()` error path inside `ip6_make_skb()`.
>> > >=20
>> > > I will submit a v3 patch shortly addressing this true root cause and=
 using your suggested Fixes tag. Thank you again for steering me in the exa=
ct right direction!
>> > >=20
>> > > Best regards,
>> > > Mingyu Wang
>> > >=20
>> > >=20
>> > > > -----=E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6-----
>> > > > =E5=8F=91=E4=BB=B6=E4=BA=BA: "Willem de Bruijn" <willemdebruijn.ke=
rnel@gmail.com>
>> > > > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:2026-04-23 22:59:45 (=E6=98=
=9F=E6=9C=9F=E5=9B=9B)
>> > > > =E6=94=B6=E4=BB=B6=E4=BA=BA: "Mingyu Wang" <25181214217@stu.xidian=
.edu.cn>, willemdebruijn.kernel@gmail.com, davem@davemloft.net, dsahern@ker=
nel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
>> > > > =E6=8A=84=E9=80=81: sd@queasysnail.net, horms@kernel.org, netdev@v=
ger.kernel.org, linux-kernel@vger.kernel.org, "Mingyu Wang" <25181214217@st=
u.xidian.edu.cn>, syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
>> > > > =E4=B8=BB=E9=A2=98: Re: [PATCH v2] ipv6: fix memory leak in __ip6_=
make_skb() when queue is empty
>> > > >=20
>> > > > Mingyu Wang wrote:
>> > > > > During fuzzing with failslab enabled, a memory leak was observed=
 in the
>> > > > > IPv6 UDP send path.
>> > > > >=20
>> > > > > The root cause resides in __ip6_make_skb(). In extremely rare ca=
ses
>> > > > > (such as fault injection or specific empty payload conditions),
>> > > >=20
>> > > > Can you elaborate on this? Which fault injection lets
>> > > > __ip6_append_data succeed without writing data?
>> > > >=20
>> > > > > __ip6_append_data() may succeed but leave the socket's write que=
ue
>> > > > > empty.
>> > > > >=20
>> > > > > When __ip6_make_skb() is subsequently called, __skb_dequeue(queu=
e)
>> > > > > returns NULL. The previous logic handled this by executing a 'go=
to out;',
>> > > > > which completely bypassed the call to ip6_cork_release(cork).
>> > > > >=20
>> > > > > Since the 'cork' structure actively holds a reference to the rou=
ting
>> > > > > entry (dst_entry) and potentially other allocated options, skipp=
ing
>> > > > > the release cleanly leaks these resources.
>> > > > >=20
>> > > > > Fix this by introducing an 'out_cork_release' label and jumping =
to it
>> > > > > when skb is NULL, ensuring the cork state is always properly cle=
aned up.
>> > > > > The now-unused 'out' label is also removed to prevent compiler w=
arnings.
>> > > > >=20
>> > > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> > > >=20
>> > > > I think this is=20
>> > > >=20
>> > > > Fixes: 6422398c2ab0 ("ipv6: introduce ipv6_make_skb")
>> > > >=20
>> > > > > Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.c=
om
>> > > > > Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


