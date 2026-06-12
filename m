Return-Path: <netdev+bounces-298770-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2nVIL/9RLGptPQQAu9opvQ
	(envelope-from <netdev+bounces-298770-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:37:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1667BC9E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:37:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Lh0H9m6j;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298770-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298770-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1DFC3003733
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83B34405B;
	Fri, 12 Jun 2026 18:34:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9523C4FA
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:34:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289278; cv=pass; b=YloMxhxgjiz5Z6Wh0Tqwd5FRpc9JbPAL7Ll98kQpslSwXRIdtITzak17Cs91sfCZX2tCLRLCtu9RGHHAEQ5ScPiTq3jAKtBXfHplQMCYp9qCc6gZQjbsIMySbEaQALSQLH6U0cWMC0Az8BYzM59n8Wtjft+Rd3WEj7oCu48Qbto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289278; c=relaxed/simple;
	bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z33l7r4ZoeuUovTA7hNKojol77MsE6dC7YFUSXFysxOOaDhLda4mQ5DMTx0QaDyFPZH9oM83LWN+i3jlGjnVkWpxjCxNI8+WguX2T1Rkn+UMpxC7z0FcZWB5RTPhc/+8C94dBajOEB8o8u06Kqn2k3V/+l/D15FW0GDC77PHntc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh0H9m6j; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f869421so1072179b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781289276; cv=none;
        d=google.com; s=arc-20240605;
        b=PkOVARIhiOAiZ/9spiAK39KPz89VZcUrEp4n8X0Z2PXNebVe+zhuBBOY0gmyAD0PNl
         DR2lMytmvZNMNN9ObfYAEk766cjD2/Qw538Ic+FASsI7FbUr+c3Fd+tuntmhR8sGhdEI
         Gi3vkTw9viSLFBI/feWGPYf2xFepAR+RHFjS/YcGzhiWpL7yr0eqhg/Chppzm5/WsHQy
         bzbpzZ4WDNOnUsrsK5XDHP2+YuWwoQPxoArzNb3Kvk/Pw8OF0PRX3Mu6AgX0sGRZv0jL
         s1vZyr9uJgNuXWH28dvaaOxmXwfVJN78hLi2xryczN2/kz2LzJv4RxDybNoIHAWy+o57
         hUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        fh=5yRgnhBSksDRJcMmfyHVrcla2IzZw+YprwOHC1E3wss=;
        b=O8dTG4rS8irjFESTrIFmjAwwwpeNCs4yfPA8ZKDGs1V1cjVZuDYWnxOmeMMsQs5DMl
         yWkdHblWeRqe+58upbFly1Lmu67/EfLAnLURloJyesUGeq/ZvMX9PFT7Q6AxFdZSI4Fz
         qTWA9vAVx2q9lFOponcMLmn2AIq0Clm0avMSPpQ+7LD85vqdoMNIS3sPddM543k/bn3+
         4GpqGPl0EEsLFDJgalY4U6HsR3Ee1lIOEyEL7qxyOHRTJcdpqJx6ujhs5ZncCXzNSKFL
         rgZBrbr2H4NwX3k1VUEQ2FyhkVm6+y9IziOxJdQVKCFz0u/ceA+KdqVdVv8nkLBjEYKf
         t0tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289276; x=1781894076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        b=Lh0H9m6jyIR+PD8Ye+qRHuYZziPwIayRolMFmDsEipZMJFiboDNgltZvPmjBGhzVLb
         O53UsGkl99pitYGgmh3dZ6TdEgFRe0bOq80bN7cMgQoeT+WLX28eP1AAkUlKaZkCez+6
         HPagc2wVq6GpaXzBF8FdxEy058tlVMkirYg9u46gyyPZpd8Tv7q70T8JfFuPAvPv6gI5
         fplynwQMOgSK6ONEiWAYGY5ygpLFu7GgHxRQCmtIGMcUfeRy8AKpwRRQfvnlrIyJbIP6
         /3mX3Jtwe1kUjSq6DmE5P3ymur0DQJUJbqSPed/W+osfLqDoxg1MBnhHRtnRuRPsuIbP
         LaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289276; x=1781894076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fx0MzIxMVvSvgIzyBZbRnRQSIiFTKkQqo6pT3/wbQdY=;
        b=fZplIV83nMoYbdb7B+ANPT3BXNNhKLwbQhSPLMl6kGW4CjA0TKi+MDC5+Pl9YEnm9e
         OO0hwh6n1R5HeEdfCeDN17j2zRXPhS3krt057IFaYD/ZgoBU/VaB7PV0QKVu82vL3Cxw
         uuYiIHRWQxYr96mLk1s+VM8LcFrQ3AboKOTRn9beVflYAw33219ckeSp3NjruLbusStP
         49OrssYeVcJ65kXh1dm3G7Mt+0Ym2JWuCVDpxUM/4s5N/x6yrxpM3jgu9Zh2k5C1JcHO
         VxPJolYLdDdOyU1fgQ/UQgHFSzlFMsBME8CxlTUNnwN/PuUFaQAd48hUDPaMPnFAKoIA
         XMsw==
X-Forwarded-Encrypted: i=1; AFNElJ/qRzQEX8ZCkg9KSPWx3RNEYmenb6LDhCXrbeK+UfbDzMcYF/QU1x4xXo8lBigVSbS0cSVuxNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjCLAawbLo7s+wrzDE7U/MaTP0jEYTWINZnnOD7ElTkYk5nlr
	1TixMBoNhf8CsGCPt4C1i9yFZuPMcztdkIAYGcWAjBSx3PazvwHzayuOdy2qjB8IHVapD477cSc
	yv0zkl7gmN+WMTMK3eqb0VhRtuDab+wUaMMks
X-Gm-Gg: Acq92OFIqHBCUHRovbLZVxU/aOW2EhXoiziX/avk+jLVxuF8OA3m7dskthOISN0w0N1
	b1xrSMYuSS/riQ9kIqk4ccHttkcuNxQRSDUfipwJ4p7q2E8tse8IrI51OITp/ZJnZM6sqap1V57
	o8gOvf6yp+YxQtJlAWvzMLmAo7RZMLC7O7LYNsOo0LN37rpXZJ0f7oy5NhkaDJGAr2FH3dHKQX+
	j1+7zekHwgEaHxr/m/ah9Q8vrEO6kdI/dHMLuMxDFlrLv6XPdzsJIrGnn/jXPdNCRIVEpkGqrtM
	TqvMga5VnAT09fqB2tn8hztf4YO3sZL9bZacFHI7wbSFtpCE05elaUT3bClv4hSs58vDajL0Tk0
	syPdczeOwYxXCFsixxIAaN2rN
X-Received: by 2002:a05:6a00:94c8:b0:842:614e:cc8a with SMTP id
 d2e1a72fcca58-844e1a2ffa7mr845553b3a.28.1781289276251; Fri, 12 Jun 2026
 11:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
 <CAADnVQ+KTNKkf_Tc-RZR-g8wEfJU4qWcOPnjDbA2=PEtZsYnYg@mail.gmail.com> <aixMETjhANSYBZP_@pop-os.localdomain>
In-Reply-To: <aixMETjhANSYBZP_@pop-os.localdomain>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 11:34:25 -0700
X-Gm-Features: AVVi8CfQKniRQEMr5OnUvtD3CO2bD1CLLbu29ZZ1l2MB6fCjeNzhT_TTtepnwQw
Message-ID: <CAADnVQLzEopmoR7vdTnno25gCqT99ja3jPaMGUnW+edg9P9Sew@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/5] tcp: opportunistic loopback splice for
 BPF-paired sockets
To: Cong Wang <cwang@multikernel.io>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Hemanth Malla <hemanthmalla@gmail.com>, 
	zijianzhang@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298770-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,cloudflare.com,linux.dev,bytedance.com];
	FORGED_RECIPIENTS(0.00)[m:cwang@multikernel.io,m:xiyou.wangcong@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:hemanthmalla@gmail.com,m:zijianzhang@bytedance.com,m:xiyouwangcong@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,multikernel.io:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDF1667BC9E

On Fri, Jun 12, 2026 at 11:12=E2=80=AFAM Cong Wang <cwang@multikernel.io> w=
rote:
>
> On Fri, Jun 12, 2026 at 09:01:43AM -0700, Alexei Starovoitov wrote:
> > Just saying that the code is free nowadays, so whether it's 1k lines
> > or 10 lines is irrelevant for the discussion.
> >
> > As far as the idea goes, I think, it would be interesting in pre-AI era=
,
> > but today splice and friends are a prime target for bugs and more bugs.
> > skmsg and tcp_bpf are reeling from unfixed bugs too,
> > so my take is that we should not add any new features to skmsg
> > and instead deprecate what is already there.
>
> I guess maybe the name misleads you, it has nothing related to splice()
> syscall. Its ring buffer was developed on top of include/linux/circ_buf.h
> which again has nothing related to splice()/vmsplice()/pipe().
>
> In case it is not obvious, this patchset does not add any new user-space
> interface, only a kfunc which is visible to only sockmap eBPF programs
> which already require CAP_BPF privilege.

Not the name, but the concept. Taking from one socket and feeding
into another already caused a ton of issues for the networking stack.
If you can convince Kuba we can entertain it.

