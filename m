Return-Path: <netdev+bounces-297184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FAN7DLJKKGrGBgMAu9opvQ
	(envelope-from <netdev+bounces-297184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:17:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC6662D69
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=b0rMbT1E;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297184-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297184-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F51C301DC0A
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9B0495538;
	Tue,  9 Jun 2026 17:14:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9C4968E7
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 17:14:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025295; cv=pass; b=k4EDbXwhZPdKQNjph/R+YNDhkmSQceGDv8DVbErc1BaZMhOKoLaZU58LQ01MYHgh0vplsK8ZsF+Ojk+MQ1QpNxrCQ2L1zXQGs5Aku15s2NVpTNwE6QxTVu7jo3PXfflEkm7CZNxPRx5hB9kw08xaJwPXQIfAgRjczOqTT0yD9X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025295; c=relaxed/simple;
	bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wk03LXqFLrnlxjZkkv9r8M8GuzLirupKaKoBS+KA7fAgqypksKCsNSQSO2mF6PkmOHpkRGulQZY9g4GvPKmyh96nRTuwP/hppCGTnpfqJvI6su1QqXpMeeUJPu8P6v5N8XUhkqgLl30KvtfhZSsw2JCawGDj1/pnotef6axniQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0rMbT1E; arc=pass smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1370417c01cso7678686c88.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 10:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025293; cv=none;
        d=google.com; s=arc-20240605;
        b=hfJWZXFE80ZiD19G+cKtUB06HY+3MbhmAGe59Skste5jzB7XBZihSMmn8oOocMyYoX
         YCPKD+w0dD0O7/bgNs8DzRSCXldID0eJnd1o78sd+tFMjXjDObs5Df08ut2W364Be+e4
         I+XqjnTsRF3jcYVD2mZyjzVtDMa5g/ifY3wvUgulk8PJmCJxXn6NLdFo4FFPqyB7VPIf
         YPwCjpzn1A6LwYop2iOeCi2bTWWih+evqZSCumtvie+39d7Jcc+B5fjl3nl0iczkzMBZ
         X9AvYkQ4GSjtc7Uscp4nM+4Dgk4mSB6dkqaV6eZ2L9FvWqvXdJPqLcG4Nv5AU13VSw/9
         +6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        fh=HpyeTd1K1eutTPlIzNBJZuO10e4EIUXAwmrpJIkYDs8=;
        b=kHws+nE5wFvB1XNJVeYFAtLosLtFP7wY8FWWFrBH194JSbM+a7MwpDJHer8yyYdUvf
         xiBj1mnTOnbq4EljACBR8j3/XO/NlzYvsH+WJ4S7k862jP2+8MHiIcJcuScMbzSIMMb0
         wL8jLX4d3mplbN2T/9HMrxbGxwNmIHOMYuipZZ9oa7RQieXAUwiaEKp7OYBIeMEjJzvF
         CXnCkYx7Wzb+pc0Pz9xsE2bKi5q4JuS3sUosfCn94a11id0VcaYtNDQft61pnrY8q4ci
         avlWC7nyHtLdi6G35uulkRErNF6Ep8Vj9G0eUiO/aqWDs/3EGaIRNqSi8l4j5/Ji/ZAO
         mgCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025293; x=1781630093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        b=b0rMbT1EYBkozeO7X4b6HKQQyaiZA6zDG9qsJym95lRSvE55qHWJrNvAccj/CtItRe
         NW5ThQElREuHxHtVPEvWDu7o+Mut2fCIduepMhZ64CReUnRxEXoudU+pbzgflpiVvE73
         X0NcHq8fA5mvA7EK9CkKajfhCQsWcEeLDXQRoKRa4rNcwd1/lrclITJFjUS30JiksLPQ
         lbx5VFX01U58iDqpppIKGtKfx8t9w31CaOBsJPP/CnKYhSeHwa9r3Cw7Sh3POhYrT1wh
         s9AAMLyM8tqT4RSuHqMulYfqqKKR+Hi10pVsAowrRJpFTZzC1TZbnyT3Xq+RfQU5cBo7
         mFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025293; x=1781630093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uEmI5xWjbsRJZ1CrxCtcNunqVcmNADT/o8HWSzvO/Zo=;
        b=sGtQ7wUysnL2VDbxfOAE2dqMYjbm4wf5Vjmr82SpwwNn0DWWRTUaXElrnT1t4rCbVC
         YJQYyhRFcwZki4XVmx6dduzdqVlnP47R3KGoi5mwy3RVtjA52ieTeD0QmlI0+rRgKOxf
         TfdKTOWeAStvZAo5MDZI+j3elgyLfYxWKxoP4y9g538sEouo/zAO7BhJQUZEOuTQ7uvk
         JdCVCeu7uQlIbj4cXo9PbnQuD17cJfmfsYt25PlI/sZoMjjZiKypxL6KKh4O0ErfiN99
         iA3QXad48/bf34BQV6RWESOt3et2aloUx4aO+IrYMKTFaGr4sc7f/8wDSQZGKFLixKoB
         g9sQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DEoADUy1PQDoaa8/uPon8TzsviBzUEyCEzBcx/uynLsZt+hZtjA5FyVBQjKhzzFIQzmXEE08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNovKnE8gJGNtmZ4CVk7AzfNeQlSr08kP01u8iGYcttlxzafV6
	x+WCRpDX0J8SjkbJK2EWByiHJIj2Rw6+eTC1dqkOIr/5qSJVPm/ILe2alw8WJ5UoI+7mUv9ZoJk
	BLW84vHo4kw/uZYQK5D2G/UJL2cBsLoXp9vEBJHh3
X-Gm-Gg: Acq92OHnqXV9wHwxT1AITz7f7l3cvZemQ7hu1MDa+QmTLk9VTL9I7mJvdETtwN8BvbF
	aW7wYaHr7BbFEXYSlJ0u7ifYZhTrXbSfoPk5kX9OszLVqmkNXjETmt6sTA43iUqM0KyzlAmDAMZ
	BbyEYRBOJWmOL4/vDZ8CZIu8p3w3mvGJ7K7SmkRTYGC94G/o34WsVkOhPNygJ4u0JgYTZE/2mLW
	j2b6rR/MwoOUDlBZ1OjhJMWe6reEBrBlbKaLDUkYKUGvJM+wsN6lF5zHyBS2Rt0Nr5Y5ls7MBWa
	TcD03mC15w+BiaaeTcas8DIfeUcGi18LjL/JWElcQOcMDNDgyfNTHWWOLgU3DK4O1VEb+OxLGd8
	PDiM1rMoNwKi79eQxxZ4x5uW545EtWQYlnByQrLeEdkhB/WRtpibz43YBoEFh
X-Received: by 2002:a05:7022:510:b0:136:83f5:c80 with SMTP id
 a92af1059eb24-138066608abmr10538613c88.4.1781025292274; Tue, 09 Jun 2026
 10:14:52 -0700 (PDT)
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
 <CAAVpQUCJH3iknHSfNwMqvHVc_V09zNDK-YbXbqa-=K159PTqiw@mail.gmail.com>
 <DJ40JYME18U1.3RA3TUXB3MH3M@gmail.com> <CAAVpQUC1Ot9vr09gNoe+vxgLoqU8Wwn2DV+CQZYYpAJUATJiWg@mail.gmail.com>
 <f0468cb2-1b52-4216-9592-ceb204f6ea41@linux.dev>
In-Reply-To: <f0468cb2-1b52-4216-9592-ceb204f6ea41@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 9 Jun 2026 10:14:39 -0700
X-Gm-Features: AVVi8CfkVjeAeUk17kjk2s6wRYeo3MTRMX2aePnQQmjsoDb5ybrS3XbXLwOcaFw
Message-ID: <CAAVpQUC=AJvJS1yppw+aAVpmRhB6GganrUKMsKSo7WUKNkZHfA@mail.gmail.com>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock() for
 BPF-assigned sockets
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-297184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:alexei.starovoitov@gmail.com,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:alexeistarovoitov@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,linux.dev,wand.net.nz];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92DC6662D69

On Tue, Jun 9, 2026 at 6:55=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
>
> On 6/9/26 6:34 AM, Kuniyuki Iwashima wrote:
> > On Mon, Jun 8, 2026 at 3:16=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Mon Jun 8, 2026 at 2:35 PM PDT, Kuniyuki Iwashima wrote:
> >>>> btw is earlier sashiko TOCTOU concern real?
> >>> Yes, the selftest in patch 2 should reproduce null-ptr-deref.
> >>> (I tested one in a prior version)
> >>>
> >>>
> >>>> iph->protocol =3D IPPROTO_TCP;
> >>>> bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
> >>>> iph->protocol =3D IPPROTO_UDP;
> >>>>
> >>>> as far as I can tell past bpf_sk_assign_tcp_reqsk()
> >>>> the networking stack only looks at skb->protocol,
> >>>> so modifying iph->protocol will only mess up
> >>>> things on the wire (if this packet goes out).
> >>> ip_rcv_finish_core() uses iph->protocol for early demux
> >>> and ip_local_deliver_finish() also uses it for demux.
> >> ok. Another idea... we can keep the checks on bpf side and
> >> teach the verifier to invalidate packet pointers at bpf_sk_assign_tcp_=
reqsk()
> >> and introduce new concept of "readonly skb".
> >> So after invalidation the reloaded sbk->data will be read only.
> > Yes, this is exactly what I had in mind in the other thread :)
> >
> > ---8<---
> > On top of L4 validation in bpf_sk_assign() and bpf_sk_assign_tcp_reqsk(=
),
> > can't we mark such an skb immutable after the helpers and catch
> > subsequent writes to skb->data on the verifier ?
> > ---8<---
> >
> >
> >> There is no such thing today. The verifier only understands PTR_TO_PAC=
KET
> >> as read/write. So it's not easy, but probably good thing to have
> >> for this and other cases where bpf prog shouldn't touch the packet
> >> once it called some kfunc/helper.
> > This would be useful and we could (re)move some validations from
> > the fast path.
>
>
> Hi Kuniyuki and Alexei,
>
>
> Thanks both for the discussion, it makes sense to me.
>
> I'll go back to fixing this in the helper itself, like the previous
> version did.

I think even the previous version is the same type of change
for intentional misuse.

Both bpf_sk_assign() and bpf_sk_assign_tcp_reqsk() assumes
sk_lookup() in advance, meaning the bpf must have dissected
skb, and bpf_sk_assign() relies on it and has no protocol check.


>
>
> Then, as a longer-term and more general solution, I'll try look into
> marking the
> skb as immutable after these helpers so the verifier can reject any
> later writes
> to the packet.
>

