Return-Path: <netdev+bounces-301159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eqD+Kj5dOWqOrAcAu9opvQ
	(envelope-from <netdev+bounces-301159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:05:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30F6B0F79
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:05:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b="hZqyaz/R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301159-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301159-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E313002B7B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB143CB2F0;
	Mon, 22 Jun 2026 16:01:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4E3921DC
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:01:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144105; cv=pass; b=K+4G2SfIkjTJ2GOJHSKIHf7RdIaA9v6Rhy6/MODJ79b+yxwqBiNkYsOV5B/IG1HH0NBK4SR3MsCJemIvbWEtjngOJBQMJzS3Rf7YFmwQBXwQs3isFOydWNBiTE2AjzZdGjEk9bgGGH/8ayuhVR1UQT4CsJw7RK9IajqU4R+Ns9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144105; c=relaxed/simple;
	bh=rWkvd+EMjIgnvfIzdDWmMWyKR8/5ZcQUEU9ymOufTME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvK/bZfVcX02EGCOHE3ZkjAofngwOhRBDHFo92dvmjQDskqieyRH6rUa6NP2DRIt2J4ytBMg8YQEqg97qn97z0T/Qa5w+Ux+g3CJXEn2IPXT1RGrRXVHJqbQm+CIu3jNhfg85qLk/+5adY0vcuw9QxWyM8CS8JUuqreAaZfiGXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hZqyaz/R; arc=pass smtp.client-ip=185.125.188.123
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01C1F3F60E
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782144102;
	bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hZqyaz/RjR+DGm1EH8G+LV/L8FSR32rEXCiDzbH8mkOn0E4EGkx5L/EyeL8azxpYr
	 0Mbejfb0acW45BZjAyaRysYT2AqGzHUMt1hw3+6EI0SMvdBIOk6Q3yt1Jr8VusQ9zd
	 xsWK4MzR6qKD+Y3SagABlVuvfAf7zbvM9YzCZQFBFlEhfa1+tW8V+VR/d9vnHIjVjo
	 4ayLSTLId6pijB40jCmQFf0Oez9sgzFviuVKxb8+yGQ0SeQOTyLItdMW/zpcJ6OewO
	 9/L7ZhULSBrlLXA6FOfBvRr/6yhkzwc74PTTVk3Yq+wQ0Vipsvflk2gcvA7pZ1/ehg
	 PsN4tqcNq/X0sZzCcpMDoE35ASbpFH9iDwohVgwWFZAhOKRbsqdolB8sODtCKOVLRO
	 Jjfx7DMQBNCuPUCYavlFVEn8Y98Q9B/PqvaYOdd6FdXwFiHkHrCANQzxHAADQ2TNCV
	 14naEphU6q/aiCHgZMkR3eAVMoPsNgTV37sYpoQIOc45Yk4DpLN2X60g4pQsRyVK5W
	 FBiUZfvwSjWoiPgxPdVLQjk5kNYIhtBlah8V1SlDU1W64rRKymbzHn4kW6svtwe36a
	 D26WzJYfVR4Trdti+slzblRDaZAix0Mo/uGi+/Wkr0Y5KuSMH0wl3bFVmrgsLcbqN8
	 g3fqU12aWEuM0yd4glYfaO44=
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-662bf0ea6b3so6594747d50.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782144101; cv=none;
        d=google.com; s=arc-20240605;
        b=Zv/3mq7Zx3aNPM510iUfLlKapOLzBvyREpM+PYH5DKuJ9/JBowtqIyUNqNcY0d6CLh
         Su7ur4AFBWdNUglZeq/a4F5obN93f+9ecz4sTxNoUwqO3REa6e7AzY7/01ZiUFbIZQUE
         EBEyW7ePaQST5dCmFKLJYy4htSNj2fW4Nv2+Ffoy0XiuYYBQXuF8pzGXtrMgNScJRrLG
         RQM2varey12zG0G4z2qTlIb3y82dcA8YRsjWk1aFteYF8VoVfOmdp4wJQlbu+m3HEG5V
         dHTqCmL0W8fA7ym5E91mkWn5otYUXhAUO2rlBs2060GlxThhyBzOQKCLMeMbZwXbA+lE
         NA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
        fh=JJieeeXQVetB/YINQ+1EwjQXwkiaPqFhcEe6fJs/E5E=;
        b=JaPSArBazVRgbtxYEPYaQoktUXIJ+vy9OlUM/vjOoKavUbWAiK7wpbo4hu1efU7tv3
         xh30bZYLJfDlYyCIrPIlXPFJsPBMMk0LG2qj+YxyDgxb0raNOsXEdIdiVATU+QGoDBW9
         6r0KQDcV8sJ42rXZBKpHcjrMHrG4iZTJhUmLfJJT3rQuJouVGmuIPSDfVtOlMEGYftR+
         JzxmiXzXNO1LSjSCg3aJviSDGW9qJT+kUNVFCU8089XUeu7dF7HkA9uxCOcczWHknlKL
         gy57xY4UCmw5nfMNigOn4FdXpicH7wQAs+IzVdW1iYIee1sDYI1f+FAH+6IjdLKifFNI
         m76Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144101; x=1782748901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNnUNGcYlXek1bndNKg8h/XCXP07hZRUxLwxIa672vQ=;
        b=o1YRCyzViEVCCuSA7rlMu5VX7UXlCJn8RXLcpvv3eVTWC5DqgTG14RbVHl/UIjlBJR
         KV1mqltfEEZF8styFgvZk3hplsnOcqJ3V9X5kwMhP4m0QGZkLZ8u9/OuhHodGvR9kfNy
         G3WHKP6uXxfVsLu/0Q/tEIVC0Lj9JQWoyGl5vwJaudeJyDm0U9nzTLLSMNitokU/ssQI
         tPwMxhKo2/b3XfbQjPTY6nxfmVuTns16VToO9Hi2sG8/3ELQoh1pc4b/xmIFH2ZL/phk
         IZf9mXRG1Xv5Aq46K4woay3OGMb1tyWnZcFzotzqzzniAeH5CNjrTmjlRKpSQMUG3LcL
         ydfw==
X-Forwarded-Encrypted: i=1; AHgh+RraK7BW3mavz64rOAFBrOUzj8EsS6MI9wA2k1sqLTvpSH3pT81LVay6kBz7gdB9aw0ME9UpGvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+yVnTmIH1jhNqR/XEu81/DQsRf/h7bQTEK3NrS4FPgtoHLXD
	/ZyjEhllSWCRNynN3+77Dd02iJcGggl9Ypn85VTp78e4eTjqZoEwyQ+5Dy/JE1pV/RE8/y4qT0I
	aJz5oqFAF1HZYfkwdSy2AyFdRdPmbMnotTszBDpr0lGtYdkud4dySFOJf8b/2pVEw+QRJh1cPa3
	irwBYTyoVhaoDXScibGUoIsj+V5YZ+wVD79Eg3JYSj4VgXWqCC
X-Gm-Gg: AfdE7cmOf1pXkgWhoB3YBIDYyNwN91+Q8QVSXX7ZeV0JTClyPBR6ugUwdM0v2FBVkt9
	qlsG2aEWKSw2pYO24cG611TszBWEWp5NXOiw7/rDjcdXL82oSZvuYiMt75nS8LpRhgH+MnszCnu
	DesJBLcsBRbHnFpn9ciixESkOWuaJx94wzb+x+Q5p5t0QFgJTgDFhSu702yE/c/MqnbSMAgDfko
	hvVbXwn+qXMNQzQPfNq6D/jkTwXh2v7C65A+aEgU8Ji7ZjThxy8d43x
X-Received: by 2002:a05:690e:130c:b0:660:6a0c:c734 with SMTP id 956f58d0204a3-66312db92d3mr9612965d50.17.1782144099203;
        Mon, 22 Jun 2026 09:01:39 -0700 (PDT)
X-Received: by 2002:a05:690e:130c:b0:660:6a0c:c734 with SMTP id
 956f58d0204a3-66312db92d3mr9612779d50.17.1782144097184; Mon, 22 Jun 2026
 09:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619011138.264578-1-hexlabsecurity@proton.me>
In-Reply-To: <20260619011138.264578-1-hexlabsecurity@proton.me>
From: Ryan Lee <ryan.lee@canonical.com>
Date: Mon, 22 Jun 2026 09:01:25 -0700
X-Gm-Features: AVVi8CehioJRX4sF0fHaXxWwQZ817Vualcvqp9lWndWRp8Tl9cr736Ah3GtggiA
Message-ID: <CAKCV-6vvVcVNL0EDGss7jMUV8nqM8nNWrbCZ5Teq7u3jSM3JvQ@mail.gmail.com>
Subject: Re: AppArmor: TCP Fast Open bypasses connect mediation (last
 unaddressed LSM)
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mickael Salaun <mic@digikod.net>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301159-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:john.johansen@canonical.com,m:linux-security-module@vger.kernel.org,m:apparmor@lists.ubuntu.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:mic@digikod.net,m:stephen.smalley.work@gmail.com,m:matthieu@buffet.re,m:ivanov.mikhail1@huawei-partners.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ryan.lee@canonical.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[canonical.com,vger.kernel.org,lists.ubuntu.com,paul-moore.com,namei.org,hallyn.com,digikod.net,gmail.com,buffet.re,huawei-partners.com,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.lee@canonical.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,gitlab.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,canonical.com:dkim,canonical.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC30F6B0F79

On Thu, Jun 18, 2026 at 6:12=E2=80=AFPM Bryam Vargas <hexlabsecurity@proton=
.me> wrote:
>
> Hello John, and LSM folks,
>
> I have been working on the Landlock TCP Fast Open connect bypass [1]. Ste=
phen
> Smalley's SELinux fix for the same issue [3] -- "Similar to Landlock, SEL=
inux was
> not updated when TCP Fast Open support was introduced ..." -- made me go =
back and
> check the rest of the connect-mediating LSMs, since I had only been looki=
ng at
> Landlock. With Landlock [2], SELinux [3], and now TOMOYO [4] all getting =
fixes,
> AppArmor is the last one with the same gap and no fix yet.
>
> Root cause (shared with the others)
> -----------------------------------
> security_socket_connect() has a single call site, net/socket.c (the conne=
ct(2)
> syscall). TCP Fast Open performs an implicit connect inside sendmsg:
>
>   tcp_sendmsg -> tcp_sendmsg_fastopen -> __inet_stream_connect(..., is_se=
ndmsg=3D1)
>               -> sk->sk_prot->connect()                 net/ipv4/{tcp.c,a=
f_inet.c}
>
> This never calls security_socket_connect(); the only LSM hook on the path=
 is
> security_socket_sendmsg(). mptcp_sendmsg_fastopen reaches the same code a=
nd is a
> second producer.
>
> AppArmor
> --------
> apparmor_socket_connect() requests AA_MAY_CONNECT; apparmor_socket_sendms=
g() (via
> aa_sock_msg_perm) requests AA_MAY_SEND. These are distinct bits, and appa=
rmor_parser
> compiles them independently: "network send inet stream," yields accept ma=
sk 0x02
> while "network connect inet stream," yields 0x40. So an egress-restrictio=
n profile
> that grants send but not connect is bypassed by MSG_FASTOPEN.
>
> Reproduced on 6.12.88 with apparmor active. Under a profile granting the =
inet/inet6
> stream lifecycle except connect:
>
>   aa-exec -p egress_restricted -- ./probe
>   [TCP ] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)=
  =3D> connection established
>   [TCP6] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)=
  =3D> connection established
>
> (The coarse "network inet stream," idiom grants connect anyway, so this o=
nly bites the
> fine-grained "allow send, deny connect" policy that the asymmetry is mean=
t to serve.)
>
> Fix
> ---
> Same shape as the TOMOYO [4] and SELinux [3] fixes: in apparmor_socket_se=
ndmsg (or
> aa_sock_msg_perm), when MSG_FASTOPEN is set and msg_name carries a destin=
ation on a
> not-yet-connected stream socket, additionally require aa_sk_perm(OP_CONNE=
CT,
> AA_MAY_CONNECT, sk). I am happy to send that patch and the reproducer.

We would appreciate having the patch and the reproducer to look over.
Ideally, the reproducer could be integrated as a regression test into
the upstream repo at
https://gitlab.com/apparmor/apparmor/-/tree/master/tests/regression/apparmo=
r?ref_type=3Dheads,
but we can also assist with that step.
>
> (A single core check in __inet_stream_connect(), gated on is_sendmsg, wou=
ld have
> covered all five LSMs and both the TCP and MPTCP producers in one place -=
- the kernel
> already mediates the analogous implicit-connect-on-send for AF_UNIX via
> security_unix_may_send and for SCTP via security_sctp_bind_connect. But s=
ince the
> other four LSMs are taking per-hook fixes, AppArmor matching them is the =
consistent
> move; mentioning the core option only in case it is preferred.)
>
> [1] Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open (r=
eport)
>     https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@prot=
on.me
> [2] landlock: fix TCP Fast Open connection bypass (Matthieu Buffet)
>     https://lore.kernel.org/r/20260617180526.15627-2-matthieu@buffet.re
> [3] selinux: check connect-related permissions on TCP Fast Open (Stephen =
Smalley)
>     https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.wor=
k@gmail.com
> [4] tomoyo: Enforce connect policy in TCP Fast Open (Matthieu Buffet)
>     https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re
>
> Thanks,
> Bryam Vargas
>
>

