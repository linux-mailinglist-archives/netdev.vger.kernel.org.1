Return-Path: <netdev+bounces-296752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HYheLb5DJ2pzuAIAu9opvQ
	(envelope-from <netdev+bounces-296752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:35:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203465AFEA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:35:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UZNxa8s+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296752-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296752-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 609F1300B110
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145E3B27DF;
	Mon,  8 Jun 2026 22:35:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F69138B158
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:35:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958105; cv=pass; b=gxw58Y2ZTgC1fMGGP+2jak4j1gx/5K2j+RQvrlAWgIv5Vnq6dxsNjpNELCRU6Xsw5hgQfOWUDGs4CfI0A1KRihA1xdAZUp94wwDf3B/pRATYdCk6Gq0jR6uAV4GjNaBCcGl5YjPeLmgzVakrTikTZ1sWkjQ7+vErohSH+Gk9J+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958105; c=relaxed/simple;
	bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE5+Q5Fdi9a9RR2tytHTawrXttAQJjmjCqhtdSr22IFPqWx7gwJJJO2WuQ6Y6LbwBMjcFZpUwfoB3SO7Y9xY8kwAqDsupginpPttqjvVJMctuVc5nmhONFtNln+SaVRwT/D50VQT7Vid4fUJTfXV4lM89/XC1ZONTZcjubvvtVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZNxa8s+; arc=pass smtp.client-ip=74.125.82.41
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137335bc3caso5994273c88.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 15:35:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780958104; cv=none;
        d=google.com; s=arc-20240605;
        b=FkYpfIY2OU+ZG0Ge8Ji2CTLCCK7FrLRsNEe4u/lksId3M6x2ktJo1AfIIzOcvjNax3
         f2OZm/zUzvY3KDvn76tPyVYtfCL53Qt2+1lr6oz/zK1hC44NlMN2I3Dl50eSroYt7fcS
         LiHCy1AUtjIAimp+Yk4W/apKxxrZR37t9IjL16QYkRYPnWpL/Jr7h92aU23A6K6qgMaW
         TlGQMIQjGknUaL4To7hWbERIIC8vxOSQ3YCz3vNF8aAqtNOn0qo5soWyjlUdPYr8dhzd
         0dJpiTLbqoAWD1URdd+OoGZ8d50t6pA0LONwvPyUbiHHbsQrN0jEv//+I+KnJ/5Dt5hx
         MuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        fh=d/hTGOj1ZuGbI9kEjjcpQqKSSG4IzhHqk/JyZrQjZd4=;
        b=Gq6mhTPUc76Sqqv/7Of1h8ykOV0zc5MZvsTxGq6hX+Ni11Nl7YgXwnHyqWibUBiiyc
         oSKJTLS2LE+LIaJZfxFCY49vg/aMSDuK1nWaSkFCS6LPfkpHfTCwHJ5hoE0fG4tuabW8
         WojPcmwNFknuI8QndMajpQFdckHnaLEEOUo+RQUOeoGpzo7AiE+0NM/qjYlajNZFLvwY
         Ip53M/cO7U29aOyMfJh7BiIax2MgZVOhP+iGKUkp/j/VmoiuWQN+nJm+23WDcoZt7Eru
         Tz2mcPOh3mBcZJn8okHNA/J15vs4d9c+jYCvAGaJwc0a6DYbn11LTjDZVnbc8wxTeZcZ
         LIuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780958104; x=1781562904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        b=UZNxa8s+iZMlCKqqQ1SbxK57Q3Mgj26fl1kt8gO1WwVaxYIsXgTmnrv1WnNIVI21Ef
         53r3p7KPeaiGY7+oDsX+jn1SYPyV2AxytFPoKSKpBFXhlmbWMgBejk7hWBeYAX8Bxxky
         sv1VD8HA3ebiW20l8NaEhreYlqd8yveMID1vmkZZicG0Uco3a6+BVHIi2S3B0WUhxbcL
         KQ6Tfhdo+fNHMKiK+EHvWTJD/c3K4A0C9cA1keoGi8QfjbhMivN+m6ymqIvHLl/NYfx4
         KDF8qzEC6dBWSXSu7ns3YVGCCbVIXJXO0PhK02RIleXx20QbMSJwB+1FPda+HlamrJm7
         AVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958104; x=1781562904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/rpv0hsisGb3nHHvAOO3ELylrxjpXbdj4HzmBdxPovY=;
        b=dqNgvwPfqRR495Md7saUWx4InF7HmO3gcBEgBJKSDruErIQFrR6IslPr2Izbw5CXyY
         tfw5V3LOpphsVEcZjLioHrKtNGp4dNKeElINNYeic5DMYCJPMTzzDlIIUvGQKhSS4CY3
         EyZBkwAKoHc74/Rjl8PQHmPDdQFaDiZzvi4WzShi7TDd4PxXt2WGTjNjx3iuX62AHEjK
         kSEu6MDH0Fo9I7XQVO21wXsYGrX9WVJpl6ba9oc6O4DZOLS1JAyxKpI21Dx4BxcBz75X
         VHuFg52LMGZQIY1pijZaX0KWFWnHsS9/UIlk0VHB9YSAOt4JjJ+SKLGCdDYDjqIy27Ya
         CeEw==
X-Forwarded-Encrypted: i=1; AFNElJ/j1yQ6Gi59onSetdpyz1gM6pBLdsFzTqGh1cj99nZpw2Pc5kitF3Ne1eGYOo5lWfCNG+D80ck=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYXor7xwqfdeQ2rAPkedj46aFTAAHJS4eOab866DqCYrmmhu1
	jOEFw15NfW4Gy8ff0JRDu2kg6LRb6gdp5oFYoUSRF4UHFZ24uheXMwUEidOj/xsTCxCWXS+Bd6X
	BKpTq1tms+YAEevh20LDfR8hn/T0HkAL+e7I08skQ
X-Gm-Gg: Acq92OFlgHOaBxeNQOtvfo9NwOsK3az+3HAveh+sYaulwYNZYA2Y0wOklkWlZPly7K3
	Fmm12XX5ZzDI6SG1nZB84GBcGVvvkHqjFuoMetyhAmGdXLlAlQ1Iti947cQOfgNH2C99cp66U/M
	9dFpVnSL/Jh00+4kS0uvqYl6xHlzix/8CSEh3002oR/hHAnV394pKld62d64mZPfC+LyMyUHCeN
	EheDgGz/YF7nZcyGEfH5e5r6TLMMrHgIX1Qi6QfA8ziS1oflIIA5mF0Wvt1AzT/a/oddiauaLVY
	ew21mvq/5DhVb05MO7spbEkzx3/4auJIqmPlfuIA8RhqKz/MhYS2btm8VuAjARnfXn80XY8YgH2
	YtZpmFmi/F+Qv4OorZyk8EUpXXHAErdP4qsqhD5h6/NWRhD1svHWKqfXvQ2H1
X-Received: by 2002:a05:7022:510:b0:136:83f5:c80 with SMTP id
 a92af1059eb24-138066608abmr7982404c88.4.1780958102929; Mon, 08 Jun 2026
 15:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev> <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
 <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com> <CAAVpQUATP7S7OEZw4P_7fp5zmQO-T5jByxAfp0+YsjRENeWscg@mail.gmail.com>
 <CAADnVQKa2Z2HKKZMhyD1HrurQ4LTcCS0Mm0YPxtisGKwVfcxmg@mail.gmail.com>
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com> <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
In-Reply-To: <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 8 Jun 2026 15:34:51 -0700
X-Gm-Features: AVVi8CdeAbkRwHhPre5-1lF1rzTOH3OTwg-sIWZIP8BtHCUTHJ-Y9jp0mJntayw
Message-ID: <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Joe Stringer <joe@wand.net.nz>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alexei.starovoitov@gmail.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296752-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,iogearbox.net,wand.net.nz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3203465AFEA

On Mon, Jun 8, 2026 at 3:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
> >>
> >> btw is earlier sashiko TOCTOU concern real?
> >
> > Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> > (I tested one in a prior version)
> >
> >
> >> iph->protocol =3D IPPROTO_TCP;
> >> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >> iph->protocol =3D IPPROTO_UDP;
> >>
> >> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> >> the networking stack only looks at skb->protocol,
> >> so modifying iph->protocol will only mess up
> >> things on the wire (if this packet goes out).
> >
> > ip_rcv_finish_core() uses iph->protocol for early demux
> > and ip_local_deliver_finish() also uses it for demux.
>
> ok. Another idea... we can keep the checks on bpf side and
> teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_req=
sk()
> and introduce new concept of "readonly skb".
> So after invalidation the reloaded sbk->data will be read only.

Yes, this is exactly what I had in mind in the other thread :)

---8<---
On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(),
can't we mark such an skb immutable after the helpers and catch
subsequent writes to skb->data on the verifier ?
---8<---


> There is no such thing today. The verifier only understands PTR_TO_PACKET
> as read/write. So it's not easy, but probably good thing to have
> for this and other cases where bpf prog shouldn't touch the packet
> once it called some kfunc/helper.

This would be useful and we could (re)move some validations from
the fast path.

