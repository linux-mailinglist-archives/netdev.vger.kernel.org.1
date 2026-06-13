Return-Path: <netdev+bounces-298875-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5uXwCuOyLGpQVgQAu9opvQ
	(envelope-from <netdev+bounces-298875-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:31:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D867D733
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:31:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sD2wrGBW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298875-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298875-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CC9A313AD39
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C138D3F8;
	Sat, 13 Jun 2026 01:31:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B7388392
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:31:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314271; cv=none; b=dMZU30P4cuIq5tnZ8iVhxPdL3Rm2sjQe80BdhrkbwWleQaYgulZb9M8aiWP5s+cvT0O+xvMDHVZPQ3uC9jYzI4x6oQY0nNt/QFT9O944gz0uzc45AiMW1QET+KyOitXYJOu4nWGUEigiHkjA7B8c4OBj58+L2FFD0X16/slbohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314271; c=relaxed/simple;
	bh=o3Ppwk8Pxo2eOnZQYuZg32wpqsbKuSlPC70ZBZfMUGY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=f38Z3L2K64VFQbhydgS1hrt4YjZ67qqd/ZiS6t9q6fto3p168fdi/0eGP+dmTxoljbR8lg8hPMPgHCYSJgoD4imZfwiOd6y8gaVYA68cDTV9Z+SdMO6rtdmewGeozKJiOgl2sF4MBlMuPSFA0N58y8q6SMeZKVLwyC5UB50zBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sD2wrGBW; arc=none smtp.client-ip=209.85.161.42
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69ed219d3ecso1088225eaf.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781314269; x=1781919069; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kG4r8a+egx6Sz73/hv1qlVjU+AH9cIZy42JaiVuxTy4=;
        b=sD2wrGBW1v1TO4G+NK2K1onVahwaXCkFrFHZNAzpVS9IAQyNzTPDOq/YwDBJqGd+f/
         5d/XDE9xnaHNLWkHeu94SEWDk3QPI/WiH8Nt+rY55B9jN0NCZMf6Q7XRvP97ncq3hjH9
         aVC+kFXmUHbHdRwYGVVgIE2jwNMNHcj/QZztqXAAKKHGC7cNdZ4bZ0siUVSVimZRziJc
         Ct5KqZRdP4LXwA/JQV2aXHxqVpzKU9gK1F7aNV7vJp83Y6Y2PD8goZLSf9VuYZbWCxa/
         sBlyDMZv44wY7iajctdXHsvwt9xQ/+b6xenxMIr9wg/+dS6kTTWpYuYWqh7cYOlLEFVb
         GLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781314269; x=1781919069;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG4r8a+egx6Sz73/hv1qlVjU+AH9cIZy42JaiVuxTy4=;
        b=CHbe3grwnx0kpOwH9sNCo/np3HAsrgLM41AzRroigerEygJpcB7M1w/p3GbLjpvsYm
         9nj4AHxLTNObY1WRK2Lvz4jZ4Z0CJZ1kHTVPqQ75x5CT9CCXxQELzbeBMLR3cUJTuAG2
         K83PLGn0oiWGLSaIuRoe0cjhqaG11p0caa6AvJhx2wtk0+2JG/w22eW2tnC5CaRxuhfo
         UODAJHgnNp3aLQCvyFkx7E1cRbdbCv5yjnK/401dBtD7TD45/S1QDDhj8DHzxNb3nS78
         mEvk1f83c4gPN25vxA8KQTXedWcWW2jqJNspNd8HZrneg/le/u/dNYOz9/uCIJyeMGaX
         KNHw==
X-Forwarded-Encrypted: i=1; AFNElJ9LWFA5T/J6EWXK+wtlbfzabKDZut5mpihxIx3CdbVcJiGc9nLOJFrdDgo2XWESQ5ouaANTDlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxucchejUaG0H0wBt835qJeMVcNHcZe0yYollIsms44hlC+pTP
	dPN/5A4j2vsrhWXBU5N54kFLNrM66apnhFo+DIijeHHmmoqAhU/8TB//
X-Gm-Gg: Acq92OGvB/i8skL0N/KCaLCHJTW3V7yCnN44Ox5Qepd5UozNsTppogXshdlSe0AIb6i
	7cbeZhSA+WLK/VDA3xyIS+68nI+Yd/k6YutGl9IGGxjLJTazro8Hyz4SH+Txq4He931l5fVtRGZ
	wRKGaPF0GpU5AkBUepmw4DNVK3NOi0IuUTgZkZMhh4W3HMDAj8IHlamBSv2bTY/XH8fHstmDUDp
	hBvc6lncElnd9Jl8uLc0d+YbZC0/xKT9xcmlNXlMTV0Vxv8UjR/lnj1L/cYeN2lnugliADRNWmN
	IOPqC74Sx2He+2DXHiRDjv7DWvx66X5LWfDLp0ZybzbUVayD+mgRaq4D2+0hr3j1JFxkVISBiGk
	OGUXFOhBR4CEnwbmdE5EzJruGUjuWYXaOIzV3X/vLa+YOPYUTiMMsrw4LA6o+tqneo0K1ihk7P2
	dYK2rBdcbKStDND2QD1rtkh4MeB0w+4EcPXtCVbjVDWQoUZvExpGbEtcKZLnwHVRO19NKFDrn4w
	Oih9MaK+nVSaluzAw==
X-Received: by 2002:a05:6820:1787:b0:69d:7a88:9cde with SMTP id 006d021491bc7-69edc73e0a1mr3369586eaf.26.1781314269167;
        Fri, 12 Jun 2026 18:31:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426abf2782sm3492674fac.8.2026.06.12.18.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 18:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 18:31:06 -0700
Message-Id: <DJ7J7GXSJCRS.2FA4LT0RF9GZ5@gmail.com>
Cc: "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Willem de Bruijn" <willemb@google.com>,
 "Kuniyuki Iwashima" <kuni1840@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next/net 5/5] selftest: bpf: Add test for
 hwtstamp proxy.
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Andrii Nakryiko" <andrii@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Eduard Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc
References: <20260613010039.1362312-1-kuniyu@google.com>
 <20260613010039.1362312-6-kuniyu@google.com>
In-Reply-To: <20260613010039.1362312-6-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemb@google.com,m:kuni1840@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:sdf@fomichev.me,m:andrii@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:eddyz87@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298875-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[google.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 871D867D733

On Fri Jun 12, 2026 at 6:00 PM PDT, Kuniyuki Iwashima wrote:
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index 7dad01439391..8d119b10ed0d 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -92,4 +92,14 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry,=
 const char *name__str,
>  				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
>  extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *na=
me__str) __ksym __weak;
> =20
> +extern int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s) __ksym __weak;
> +
> +struct bpf_hwtstamp;
> +extern int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> +				struct bpf_hwtstamp *attrs, int attrs__sz) __ksym __weak;
> +
> +struct bpf_tx_tstamp_cmpl;
> +extern int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> +				      struct bpf_tx_tstamp_cmpl *attrs,
> +				      int attrs__sz) __ksym __weak;

...

> diff --git a/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c b/tools/t=
esting/selftests/bpf/progs/proxy_hwtstamp.c
> new file mode 100644
> index 000000000000..e13963f2393e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/proxy_hwtstamp.c
> @@ -0,0 +1,236 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2026 Google LLC */
> +
> +#include "vmlinux.h"

Please update your pahole. It must be old, since you had
the need to add kfuncs defs into bpf_kfuncs.h.
pahole was improved couple years ago and all kfuncs now
in vmlinux.h automatically.

Overall, the set looks good to me, but I would like
to see an ack for networking bits from somebody.

bpf-next/net was the right subj to use, but this is very late
into release cycle, so I prefer to land it to bpf-next/master
and send together with main bpf-next PR.

Kuba,
is is ok with you? thoughts on patchset overall?


