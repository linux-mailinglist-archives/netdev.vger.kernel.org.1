Return-Path: <netdev+bounces-246537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C844ECED920
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 00:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E177300A1E8
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 23:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF621D599;
	Thu,  1 Jan 2026 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn64q5Ol"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222072459E5
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767311904; cv=none; b=RexBqiEzhU6UGDcsJVB3TBWYcK9pOEpgWGSX9PamqPD8fZ+J9yZG1k2b49k8ZNAOk7xl16JOT7DrQl6AfLjx8YgBWMATnijqAOFNkXcb1CxHP6xog0LEDmDAtxWFuJRospsT6KcO0DATzwD/NumyxY5cqAaxxAc34nCmevV652U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767311904; c=relaxed/simple;
	bh=8siTNbrpTJbAklTnTARy6JaEYVIFFW/vQOM9LGSCEuI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XvF8oIXkCeNN/Lh0nb1E3hAqLvTKb7ce5VF6Je7CXN3A21BIiCagBafJSicrL+4nJcTEQj5KZdw5jG10+YY5NvyDQ0+Fjfa70OwpD9yKDoD/kP9x0NsOJD35vOnj7RWeP/bIkD9/T+VHqWBjVnXhoAGmEBRD3qIsFeUj9eL/UZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn64q5Ol; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fccbc683bso84774897b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 15:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767311902; x=1767916702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44NWk22GMeh5qMFMg6DlMiWm5Qp2Enym4Sz/btosLP4=;
        b=Yn64q5OlRHvxV8CsAtMfSkGOSRoYbk8inzLbnMlH3vM6l7prViGWRS9YV/V5qYAl8I
         CUg0/BUb44UXRqv2BIPVedXL3JfuwlyhnrGKNgv9lsJBB3lRZxIzoM8u8ecNcyaiWNP5
         eQceeF8Xpj1xeXRxxRojy4PNKFcgPCwJs3bJz0ff3jRZr/gIMCY8nWghhdxmXD3dmHi+
         IXHkzKJPkOc/DmoYNhvhxleTxX2thgBeytZB+LMzeNXPDbcqt7tVXKK38jMDmS3PNDPu
         jJIsxPNm4idSi/m9M3XzbrMXV5ZDKTw69/6rc6l/YxmmAt1xkYfXXNiafvwP5jz7VtEZ
         e7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767311902; x=1767916702;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44NWk22GMeh5qMFMg6DlMiWm5Qp2Enym4Sz/btosLP4=;
        b=UT4AxMA6GuWZ2bpEl13UfNHuU6/A2RpG/rw77lEy0HkwSpwvXszJnAdPcKsfq0XMDz
         +RALfAKiPyareKU7ULRV1FBaWhm7uiNvOujDtrZQ7tICGQ6YdkNiuLeK5+MIUNN0l0Xt
         RZK7Lxotr7nOuOL4tJhNGbDDVSTE4/CBG95D4BFxT0Bwy02NY9W9tFV2KW6eOV2vvm2w
         3yB9U1yEDB+jjSttr5e2ErmTscDOUTqEHGJWlx/TTuLwrRipJIrj4h3V02HsNt+WpD3O
         ei/qa0/+zzZhcf1DfJC4YjPqfy8Mmw4MDwGwUro5lnUvck0A31kp5PokOBSGD5UGFmuh
         Ie0g==
X-Forwarded-Encrypted: i=1; AJvYcCWBQoId9u80pxP/teuSPERxaiPu6T8hfQ6KHiWUDd1ag8jfouDn/QfnshHtbCA8Kr0IcmQtyYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHTyQuwZ25RAIpiVmt4hRZIIXejIHfafTnchpktqsPb+aA/KN
	qJfuaNGmdo+kKyfyk1v5N/wJueDbPALAv5n50zLW/iTTk6/YpxJ2YSwk4syixA==
X-Gm-Gg: AY/fxX7zZrJMqiHBqiPspM4tkQQEnMWoKpC5F8knvuSlvbM5Ht6NEIxQ4gnWDrAKI1m
	Wan38ObN8N3J/ETX8JZ4+PpfQFNqyTXJ7GFLbf4a1W6on1Lni0nvF1CJZYair/pjLI5uQhOSDBG
	SJNPzEKsobyrnPsrIgPBoBbmxcbD2XnwIKAgTvKP2k7qsGSvCQnUvkYjDtPmq8wq2zv5bq4PlKB
	hnNslbJQyo48KiDYBlJyW1rf7UDSsD3UE7NlgDLMOZW/s05Fd2nB8vYtWytnNsUWpMzl5eYMdpx
	owclsFUIW/EGHJXHVdStj5WQNG+ZIGtcPnvMEexeZwyfoKgZWZ84EDc5rRtB6uC9Dc2lkC+Z5/l
	oQtR+oK7Evld61EnZzVNXyeozziCeD0HT9UHotMkso6SxFeaZbc1BpG979/NQRU5PN9daZsZs3m
	//J8r3f3bRtWbK14Qy7nAcH/gmxxPAs1xdI+qVHp1kOlBIAjihcnQw2Wg299hEX5AVS9I/CA==
X-Google-Smtp-Source: AGHT+IHuGHqD7mTDIMXSkA+4FBDB3tWrua4XHs2DHPo/ZAmj/UPhZ8FWq52KKAMKfwmzuZysEZYfew==
X-Received: by 2002:a05:690e:1404:b0:640:d038:fb02 with SMTP id 956f58d0204a3-6466a845e07mr30515488d50.25.1767311901924;
        Thu, 01 Jan 2026 15:58:21 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790166a5da5sm76822287b3.22.2026.01.01.15.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 15:58:21 -0800 (PST)
Date: Thu, 01 Jan 2026 18:58:20 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: mohammad heib <mheib@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kernelxing@tencent.com, 
 kuniyu@google.com, 
 atenart@kernel.org, 
 aleksander.lobakin@intel.com, 
 fw@strlen.de, 
 steffen.klassert@secunet.com
Message-ID: <willemdebruijn.kernel.26c920bcfc4bf@gmail.com>
In-Reply-To: <0684bf0a-c6eb-4d06-a054-dc9b4f97dbfa@redhat.com>
References: <20251231025414.149005-1-mheib@redhat.com>
 <willemdebruijn.kernel.14a62f33c80f0@gmail.com>
 <0684bf0a-c6eb-4d06-a054-dc9b4f97dbfa@redhat.com>
Subject: Re: [PATCH net v2] net: skbuff: fix truesize and head state
 corruption in skb_segment_list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

mohammad heib wrote:
> Hi Willem,
> =

> You're right. I did a deeper dive into the callers and where the =

> SKB_GSO_FRAGLIST bit actually originates.
> =

> It turns out it is exclusively set in the GRO complete paths (tcp4, =

> udp4, tcp6, udp6). Since these packets are built by the GRO engine for =

> forwarding, the fragments are guaranteed to be orphans without socket =

> ownership or head state.

When revising, please include my short note on relevant prior patches.

Also, let's self document these known invariants with

    /* Only skb_gro_receive_list generated skbs arrive here */
    DEBUG_NET_WARN_ON_ONCE(!skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)=
;
    DEBUG_NET_WARN_ON_ONCE(nskb->sk);
 =

> i will simply removed the truesize accumulation, as they are =

> inapplicable to this GSO type.
> =

> =

> One thing that=E2=80=99s confusing me is whether I should remove the ca=
ll to =

> skb_release_head_state().
> This function updates reference counts for some fields in the skb, even=
 =

> when no socket is attached to it.
> =

> So I=E2=80=99m wondering should I remove this call, or keep it as is?
> What do you think?

This was apparently introduced in commit cf673ed0e057 ("net: fix
fraglist segmentation reference count leak"). To handle a special
case for skbs with skb extensions. From that commit:

    "where the frag skbs
     will get the header copied from the head skb in skb_segment_list()
     by calling __copy_skb_header(), which could overwrite the frag skbs'=

     extensions by __skb_ext_copy() and cause a leak."

So I read that has (1) this is still needed for some skbs (though the
only thing that is really needed is the skb_ext_reset(skb) call) and
(2) it is evidently safe to call unconditionally in skb_segment_list.

Same as previous, please include this context in the commit message.

> =

> On 12/31/25 6:58 PM, Willem de Bruijn wrote:
> > mheib@ wrote:
> >> From: Mohammad Heib <mheib@redhat.com>
> >>
> >> When skb_segment_list is called during packet forwarding through
> >> a bridge or VXLAN, it assumes that every fragment in a frag_list
> >> carries its own socket ownership and head state. While this is true =
for
> >> GSO packets created by the transmit path (via __ip_append_data), it =
is
> >> not true for packets built by the GRO receive path.
> >>
> >> In the GRO path, fragments are "orphans" (skb->sk =3D=3D NULL) and w=
ere
> >> never charged to a socket. However, the current logic in
> >> skb_segment_list unconditionally adds every fragment's truesize to
> >> delta_truesize and subsequently subtracts this from the parent SKB.
> >>
> >> This results a memory accounting leak, Since GRO fragments were neve=
r
> >> charged to the socket in the first place, the "refund" results in th=
e
> >> parent SKB returning less memory than originally charged when it is
> >> finally freed. This leads to a permanent leak in sk_wmem_alloc, whic=
h
> >> prevents the socket from being destroyed, resulting in a persistent =
memory
> >> leak of the socket object and its related metadata.
> >>
> >> The leak can be observed via KMEMLEAK when tearing down the networki=
ng
> >> environment:
> >>
> >> unreferenced object 0xffff8881e6eb9100 (size 2048):
> >>    comm "ping", pid 6720, jiffies 4295492526
> >>    backtrace:
> >>      kmem_cache_alloc_noprof+0x5c6/0x800
> >>      sk_prot_alloc+0x5b/0x220
> >>      sk_alloc+0x35/0xa00
> >>      inet6_create.part.0+0x303/0x10d0
> >>      __sock_create+0x248/0x640
> >>      __sys_socket+0x11b/0x1d0
> >>
> >> This patch modifies skb_segment_list to only perform head state rele=
ase
> >> and truesize subtraction if the fragment explicitly owns a socket
> >> reference. For GRO-forwarded packets where fragments are not owners,=

> >> the parent maintains the full truesize and acts as the single anchor=
 for
> >> the memory refund upon destruction.
> >>
> >> Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
> >> Signed-off-by: Mohammad Heib <mheib@redhat.com>
> >> ---
> >>   net/core/skbuff.c | 16 ++++++++++++++--
> >>   1 file changed, 14 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> >> index a00808f7be6a..63d3d76162ef 100644
> >> --- a/net/core/skbuff.c
> >> +++ b/net/core/skbuff.c
> >> @@ -4656,7 +4656,14 @@ struct sk_buff *skb_segment_list(struct sk_bu=
ff *skb,
> >>   		list_skb =3D list_skb->next;
> >>   =

> >>   		err =3D 0;
> >> -		delta_truesize +=3D nskb->truesize;
> >> +
> >> +		/* Only track truesize delta and release head state for fragments=

> >> +		 * that own a socket. GRO-forwarded fragments (sk =3D=3D NULL) re=
ly on
> >> +		 * the parent SKB for memory accounting.
> >> +		 */
> >> +		if (nskb->sk)
> >> +			delta_truesize +=3D nskb->truesize;
> >> +
> > =

> > Similar to the previous point: if all paths that generate GSO packets=

> > with SKB_GSO_FRAGLIST are generated from skb_gro_receive_list and tha=
t
> > function always sets skb->sk =3D NULL, is there even a need for this
> > brancy (and comment)?
> > =

> >>   		if (skb_shared(nskb)) {
> >>   			tmp =3D skb_clone(nskb, GFP_ATOMIC);
> >>   			if (tmp) {
> >> @@ -4684,7 +4691,12 @@ struct sk_buff *skb_segment_list(struct sk_bu=
ff *skb,
> >>   =

> >>   		skb_push(nskb, -skb_network_offset(nskb) + offset);
> >>   =

> >> -		skb_release_head_state(nskb);
> >> +		/* For GRO-forwarded packets, fragments have no head state
> >> +		 * (no sk/destructor) to release. Skip this.
> >> +		 */
> >> +		if (nskb->sk)
> >> +			skb_release_head_state(nskb);
> >> +
> >>   		len_diff =3D skb_network_header_len(nskb) - skb_network_header_l=
en(skb);
> >>   		__copy_skb_header(nskb, skb);
> >>   =

> >> -- =

> >> 2.52.0
> >>
> > =

> > =

> =




