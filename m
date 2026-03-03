Return-Path: <netdev+bounces-263082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLiXJGSjpmmvSAAAu9opvQ
	(envelope-from <netdev+bounces-263082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:01:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4181EB5C6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AE73007E23
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865D388398;
	Tue,  3 Mar 2026 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OxoqPCSo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24B87263B
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528233; cv=pass; b=cOESN5h8cU13nPSemnXhVHi+/nhtuNinC2fjBEMU1Lb6vCyvc1Ed/pHPuwHN2sC7cx8c2WjV7zwnldwjbM24HVBSYcOAeIu7ummvTAX1O4PjQMhuB64J0YIijh7iuBNJBOPGWH78DS3ti+c0oObxUWVXgTrspdMonykmtwHPKUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528233; c=relaxed/simple;
	bh=Cgl644R0lyUsT2xkwxUSIa/Gdcq1apzky0Z2b8gnznQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqOPgyHWsnV8M+tQOzrOM5oupJJMu30CVVVyJUDTEBIBJWxvpjjLfY7T6sIx3x68SiTDZ8Mr3pvsY+PnFY7CQ8v6QpblLBVXV/Rm9qXQ3XV9tPKQFgVHIpL/gJLPfamVrl4WadhMKLW/YPIXV4OQGNqMVFqzyXOZ1AvcsbemRpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OxoqPCSo; arc=pass smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cb3b3e643dso316830885a.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 00:57:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772528231; cv=none;
        d=google.com; s=arc-20240605;
        b=B+b/uTq+vAeOMEdRQGX/qPrcqSLLfdY0rLP5wj0Ou7nUVDDQHycHVAEEKOAQ67HkXh
         UGp/eYAq7bo2UenvMVTzo9Jpanyq7gwCheatNarYOFxqhXIOVJXeYWaINP3QIIdqdAdl
         hZT8cJIbmY1kMhd8eiGnCDeCVdRdAolQrxFZGKeM6cgBVbIPKakr+bxYJMz+EqEM03Df
         kMBZsJ+VuB3iqjIE2HOyLG3SMoB6A5j+dYh8O9oRTLGUwhC+vgfF0qAg4GcHgEezkf3g
         5XaO4+KFTpzPK3wuSI3Keca+ZTkVwPFrb8m+28goWp0tjM5n6QsADLAWmUoL/3EwRig/
         W/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cgl644R0lyUsT2xkwxUSIa/Gdcq1apzky0Z2b8gnznQ=;
        fh=jiujrg/xH9B2Wi7JXy6qvRLPhHa4Sj37Oj/wNmlBUgo=;
        b=THX5Q5WWRaWDeixG37YZwrof3MUUe6IFDi0dyEnxh/7x2nNtgw4YGYY4ixiVvA1Zdm
         5Qi9+5uX6xxdPCUqSwtaUQOHs8iZ5L7fkZ0lnjHpgKA03iOVez03v2flbQ2X2f118vLK
         CPHyAVNJyeVwtFIIScRmPq8upo3TxvhG8k5m3J1kmI6ESsEm1MixLSdY2LxmTGdBodpd
         GIJJSIZCZQtyf9zmYyYiQltEHaLA2bkpcFXEN/Nh169/oVpEerBFMF7wpBnTpGfBEwzU
         w5lCnM4ND5aZ6n2aHrEbXVJxUS+8Ai8ShL+qZEnBmSX1YALlo3KGoJbX8WvHz9ChfRO1
         c5Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772528231; x=1773133031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cgl644R0lyUsT2xkwxUSIa/Gdcq1apzky0Z2b8gnznQ=;
        b=OxoqPCSoMBvtHZZJQ1oOwfeNn+dGO4YJUWVT1IWEY48UXZQ9kcTU8TGLxRzids7bkn
         MEMIdBdtyv2R6dGe2C4CjrOkvwEvk20nWKn1dn3p9FXoNdh68rdp4GHMEdIbToUcVnaP
         dPVJqhY1Iie5CV8Y8sDqyjqzwx6d3ScqYXUuu57l41Yf8Bg4ZPwQsLGxn748XUy77PNF
         Gb+XF11I+g0i3TokDudDiiiMbT7HQOi8Fsu7iwdTSLOyTTYIhAufN0KDrQ7KhZsTXkNN
         xOJBVVe0GQqHY4lO7lH396FZ8bRaknVFtx6G0nVZYNdxRTGJXqXVom5wq7hdHHPQCw7v
         eN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528231; x=1773133031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cgl644R0lyUsT2xkwxUSIa/Gdcq1apzky0Z2b8gnznQ=;
        b=IS1s9TOjZXHUOuYCl1mfvXjvsFg/KCpCcjt2UoiFGNfC2m2ZmcUT4FD9LJTf2o8Cbm
         5rfPskWrNXw+f9mRUTGsMUGNMEG5IaPgBhIViB/9NPuBlXRdLN30gIdcA3nBkHXdxzw1
         Eh5z1Ltw+zbiy7Id2drpkNFOB3cs5+IsO6oORY6RnJieXa3TdJT5hKq+6dQ2eyQ8+vjV
         rlJyVpbcLjoPcW8YhPKGMlC+LlXsxH/1FUdPeiQ1+zosLrZvN/3fuhimwCqwfO90Jydv
         eM/3pshaJ8InhJlmdMjTBl1pBNxB/F8f2CNuZ5fBC8SecjTX/2qG23v/T6WTfm9dvJZs
         qEFA==
X-Forwarded-Encrypted: i=1; AJvYcCXKHyfd4EEvZxaWR6qrx5l2nYN00Vas5IF+/ju9Gp5c8j7/g04eLlsl61mKP4cLBvH+0yzu2JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AYJjZLb3al00JEH9CSvjUqUg+n3LQyQSWJZME68gXhtfApyC
	xhLW+/kA3fmHX612v+KLMTQ/Ng0HEozhaj4o0o3YoWOCZ7koL95hlZR/lfuB8lub4xQQbL5aMg1
	arEln33w/QV4raEkpOCwbFlWA/I0w0jcu5EAUUASF
X-Gm-Gg: ATEYQzy4fFbxLdIzOH6+D8vguwvucvk5E8UfnuIbZPanH9WlV47xilreiwrl/T52Lfl
	JnUFzdCLR9X4GUz79ZtaxIo5vCPBGXjCAZGVajfxpVxLhFItzxE62UkgYACsh351mlG4NhBu/2Q
	bT9rx5548kNi0EWidm0po1NpMblVW99jSSW/IrDw+Vs73GG+NNSR0YqxGzavTBhR0HE+J/4sqAF
	tu7uStnDIt313aASlp7L42UEFooyXESv6DiH8pf4+eiPIFhOOILrfhVul4SJGTXtYpUH7XZZGB2
	XB6TNZY=
X-Received: by 2002:a05:620a:1a86:b0:8cb:4ba9:ccec with SMTP id
 af79cd13be357-8cbc8f52f48mr1953805185a.72.1772528230249; Tue, 03 Mar 2026
 00:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225074633.149590-1-leon.huangfu@shopee.com>
 <20260225174354.5a698ddb@kernel.org> <f611be70-8280-44c8-86af-5866c0b302be@linux.dev>
 <20260302162251.733b520e@kernel.org> <3a623176-fc5f-4dd4-bbfc-64d211f53645@linux.dev>
 <CANn89iJ0=Tx0i+1UXEdcoFuk1F_MfP41-L-kgGDTN+RcLTRcFA@mail.gmail.com>
 <d7f3dabd-e6da-496d-927e-590a41dee009@linux.dev> <c582ab1c-8a2d-4c0f-ad7b-7d44fe4296f6@linux.dev>
 <CANn89i+Bt_AZK=16nekvs846P7fPWxkRrNaNNBOrH0sB7xS1uQ@mail.gmail.com> <03144918-eaa8-461e-915d-232e29a52557@linux.dev>
In-Reply-To: <03144918-eaa8-461e-915d-232e29a52557@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 09:56:59 +0100
X-Gm-Features: AaiRm51Y_i_lwcywSBhhMNnPjIXa9H0tNh811NIPvyqXw9flZSlMBnQHPcMSBzc
Message-ID: <CANn89iKt+1Abi_tUWhWGx1n8ywh4-Senq83APjR0qB_E7Py=vg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: Add net.ipv4.tcp_purge_receive_queue sysctl
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, kerneljasonxing@gmail.com, lance.yang@linux.dev, 
	jiayuan.chen@linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A4181EB5C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shopee.com,vger.kernel.org,davemloft.net,redhat.com,lwn.net,linuxfoundation.org,google.com,nvidia.com,gmail.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 9:54=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 3/3/26 16:17, Eric Dumazet wrote:
> > On Tue, Mar 3, 2026 at 8:55=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >>
> >>
> >> On 3/3/26 14:26, Leon Hwang wrote:
> >>>
> >>>
> >>> On 3/3/26 11:55, Eric Dumazet wrote:
> >>>> On Tue, Mar 3, 2026 at 3:12=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 3/3/26 08:22, Jakub Kicinski wrote:
> >>>>>> On Mon, 2 Mar 2026 17:55:59 +0800 Leon Hwang wrote:
> >>>>>>> On 26/2/26 09:43, Jakub Kicinski wrote:
> >>>>>>>> On Wed, 25 Feb 2026 15:46:33 +0800 Leon Hwang wrote:
> >>>>>>>>> Issue:
> >>>>>>>>> When a TCP socket in the CLOSE_WAIT state receives a RST packet=
, the
> >>>>>>>>> current implementation does not clear the socket's receive queu=
e. This
> >>>>>>>>> causes SKBs in the queue to remain allocated until the socket i=
s
> >>>>>>>>> explicitly closed by the application. As a consequence:
> >>>>>>>>>
> >>>>>>>>> 1. The page pool pages held by these SKBs are not released.
> >>>>>>>>
> >>>>>>>> On what kernel version and driver are you observing this?
> >>>>>>>
> >>>>>>> # uname -r
> >>>>>>> 6.19.0-061900-generic
> >>>>>>>
> >>>>>>> # ethtool -i eth0
> >>>>>>> driver: mlx5_core
> >>>>>>> version: 6.19.0-061900-generic
> >>>>>>> firmware-version: 26.43.2566 (MT_0000000531)
> >>>>>>
> >>>>>> Okay... this kernel + driver should just patiently wait for the pa=
ge
> >>>>>> pool to go away.
> >>>>>>
> >>>>>> What is the actual, end user problem that you're trying to solve?
> >>>>>> A few kB of data waiting to be freed is not a huge problem..
> >>>>>
> >>>>> Yes, it is not a huge problem.
> >>>>>
> >>>>> The actual end-user issue was discussed in
> >>>>> "page_pool: Add page_pool_release_stalled tracepoint" [1].
> >>>>>
> >>>>> I think it would be useful to provide a way for SREs to purge the
> >>>>> receive queue when CLOSE_WAIT TCP sockets receive RST packets. If t=
he
> >>>>> NIC, e.g., Mellanox, flaps, the underlying page pool and pages can =
be
> >>>>> released at the same time.
> >>>>>
> >>>>> Links:
> >>>>> [1]
> >>>>> https://lore.kernel.org/netdev/b676baa0-2044-4a74-900d-f471620f2896=
@linux.dev/
> >>>>
> >>>> Perhaps SRE could use this in an emergency?
> >>>>
> >>>> ss -t -a state close-wait -K
> >>>
> >>> This ss command is acceptable in an emergency.
> >>>
> >>
> >> However, once a CLOSE_WAIT TCP socket receives an RST packet, it
> >> transitions to the CLOSE state. A socket in the CLOSE state cannot be
> >> killed using the ss approach.
> >>
> >> The SKBs remain in the receive queue of the CLOSE socket until it is
> >> closed by the user-space application.
> >
> > Why user-space application does not drain the receive queue ?
> >
> > Is there a missing EPOLLIN or something ?
>
> The user-space application uses a TCP connection pool. It establishes
> several TCP connections at startup and keeps them in the pool.
>
> However, the application does not always drain their receive queues.
> Instead, it selects one connection from the pool using a hash algorithm
> for communication with the TCP server. When it attempts to write data
> through a socket in the CLOSE state, it receives -EPIPE and then closes
> it. As a result, TCP connections whose underlying socket state is CLOSE
> may retain an SKB in their receive queues if they are not selected for
> communication.
>
> I proposed a solution to address this issue: close the TCP connection if
> the underlying sk_err is non-zero.

Okay, makes sense to fix the root cause. Applications can be fixed in
a matter of hours,
while kernels can stick to hosts for years.

