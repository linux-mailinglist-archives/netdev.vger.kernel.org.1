Return-Path: <netdev+bounces-306695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZhyqHAJlUWqsDwMAu9opvQ
	(envelope-from <netdev+bounces-306695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:32:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C206973EF87
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=meta.com header.s=s2048-2025-q2 header.b=MHyYFJ8T;
	dmarc=pass (policy=reject) header.from=meta.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306695-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306695-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E52304B295
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439D63CF1FA;
	Fri, 10 Jul 2026 21:26:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C262C3C10AB
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 21:26:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718800; cv=fail; b=Xout1N84fNk6F5dnKghFiA1sP/CybzORZbOstcu/WZGm4rDx7QgqQ5BBiqUE2F8qL+hc4pVKRruUiPoUvuByXVhnX7c5nDy1codMkUa6W8Jr1Od76kxrE/0i3SCbA09rrpPJXTVn2uhq6pKISM0XnX9SMKBp/Zn7GrYAmTbKWcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718800; c=relaxed/simple;
	bh=VkC6ASY6hMpcb2N3FQ3m7UCF3tlkExQIcMsQcc5KFgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvPL6mOiEuncIn4Arcna1rORbxDxyBAIdU5jr5iDMB1yw8980sXUVtGhZSrfmBQ1scHXI269xf2NffmclnlYa9DUFv0nCCyU5g51wCig2jCBwJ/ZTZf//oJIcW7TlMguU3Wm02eKMpxM4sn+N31odOc+To76wZ3v18Fa+/Y0UjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MHyYFJ8T; arc=fail smtp.client-ip=67.231.145.42
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK39B11830400
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:26:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=4rVTCVe8LWbzPm0wjrSAG/mKG3KG/lwpsyIV2TiZsYM=; b=MHyYFJ8T0cAB
	L2thTi2mW0tU4fKtEkEPlTuNlGSYNbAUHm2cGN71mq4XJ4e9JRvXbECAO+LUE4wt
	K1IoCs6xDb82FhZ25qMZbkgIExbpGLxJb+j7vZQklv61ikYvgVa3EdM8bUKoN2kn
	qVAEIzWte1NFNwu9+oa2TdM0NR/dky97cKPGNGaJFWix6NXSrHe/BFvk2SDDVAKM
	E9UpXcQv9/N0fhLIFCRg7OHIzQeeZ6I1uG2uWvQ0XeZG1mAzAhXXnkNT0bLeIzcc
	ALSpjILyQaLkuXvHF8KPQQBD1/CJXMd9rnIQNZB/myvXMIMoLEeh/K7YDpFPbdMZ
	F1lIpqYrqg==
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fak45q3d3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15ddb61f13so128695566b.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 14:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783718792; cv=none;
        d=google.com; s=arc-20260327;
        b=GrqUzQn94F1F/KQjaXO+hL12cQbeK8PPdcrNnvInYt0sjcebv0moxmWkThrxSIYCg0
         0ZFIJxnNLyu6kDPHrG6i1V2BmvqNn1/GPswZWjrs1/IHzjrLCbA9dbDsr0Pied2QKOHj
         mxJL1zd0uhZli+ItyI/zKeS+yV+K3K2cimrSoD56/svx7E+qRLQ7UJ5go03srhZgJ0dX
         YP0aN4cG69R1/IfiVyatCp0A4uQXCHWZNzj0lpxFKug/8mI/EcEbpvmDQmeY4wYr/FYz
         0TLjkwCZNyv4bCRAXcOgH8HO2jCvSNk6FrQdCqIecmrfI/bjw9/noU0n+uF9Jq9//q4D
         7IWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=FNJYGUchRZc+yyibQEoFJBWXm2WlrbE2kAvLAMOngVI=;
        fh=+fPoosA5TnDWbKPesEwsEFp5ZAoGQCGtXesi2UAZHkw=;
        b=p+cWaxGu5URSmoIkf528yb6wsUWwRt7Ji9l4yVOdrakArWZiaTTWTjUlL8XU1IavnU
         yUFVw989Gqo5XM2ChbN5oqjEuF7A1IaX6vWj94YZ1d89fUmFi4LAtjaC5eb441LLgulC
         Yqr2E9YBd+aRInA0sIW1lN9sX8mn5chaoRYpj3x/q9DG/zQRqFbt3kF94ak2wsavpEz0
         iiWjkE4aM4iIstImOGrN7lxk/tmvZf7N1gZNQCXbGx/CjpFkhvP/nUvkAVeQqzlCAc7h
         aSTN6Fy+qVIpm7HJCQ41HKbEqET7BgoDQB3WNUs1FMdwb+Tzf8H2amlOrsvwDFoSnO6q
         AKZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718792; x=1784323592;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNJYGUchRZc+yyibQEoFJBWXm2WlrbE2kAvLAMOngVI=;
        b=jZiXHytzvfd+J7/RbmYwtHfKBhvdxOQtHfrPdSRsp1OlJ3ceFEbLYlWYHnDhDXZ6q6
         MEv+H+8M0FQKnAAlhAcRF8bRlJRC7EQxc5M3pvdHOMN7GGCA80TlbVP3ugNzVL//4Cri
         72NrCILICq/YJV01vCXtIBS9aH/QC+KsAPDINVv+g2Q/yMWEW/9+/H4+RxxGZBaqD26t
         8nrki1EsQn9lgevJltKwfUJYw4c6PCSgbKopCtTHrBeIG+eTfwZWgrQ3d5grC+yX3JiV
         3oSZY8pVoRFhwoqax8lKf2ZX9Z3EZuZvsmQGoK1SEt0nLx6gi3bQr4qJZ7gxsg9FnAr7
         yLtA==
X-Forwarded-Encrypted: i=1; AHgh+RpBX1hhH+Nv7SZKIXLTwUiSITqpriCbCbP/zsQ5qKsBtJnRDC+M2GQUiWxX0eOzlfZdUrNSW40=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRpie59Y8XCSJcK5oQPt09ptDPJieANonv51fZhK1/SEsjCU3
	rNLEcDimy8GDd6r7dNe4ajkUb/FZPDatgWeOhppjEaWJWUSF+f/o4mCeSWyyIlqNkXEAEtPqANX
	dIunMB0IG7giOT5gmjSYjwEGJ97tTHYyzgQmshb4rBCUal9QuCR2//G7Llqy2/W74xixmYzzlGk
	qJj0apdC8U/TNmyDW7fsdCas/ZEVfBdA==
X-Gm-Gg: AfdE7cksjJkZrjE8Dy0d43AjwpApntbpHds6KgVFck4VZKmiFl/sJJcMuhm7kL1bcKE
	X+n+5Noyhr4HP7WJez05yKRt2kp65UtbDU2pwD9/m3zeFirD2LZSjm0/54SeuvpaE8JRFBIcD2a
	Tel58707nyaLTFEAeVZ94e/OHIg9ZjVouc9waRdNmUdysDRlP9SCB8imLMcjJh9xg/APJ+ww21
X-Received: by 2002:a17:907:c084:b0:c0e:883e:93fd with SMTP id a640c23a62f3a-c161ea934b9mr22612166b.48.1783718792368;
        Fri, 10 Jul 2026 14:26:32 -0700 (PDT)
X-Received: by 2002:a17:907:c084:b0:c0e:883e:93fd with SMTP id
 a640c23a62f3a-c161ea934b9mr22610966b.48.1783718791996; Fri, 10 Jul 2026
 14:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org> <20260710-net-sft-fix-containers-v1-6-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-6-a2915c294ef5@kernel.org>
From: Wei Wang <weibunny@meta.com>
Date: Fri, 10 Jul 2026 14:26:20 -0700
X-Gm-Features: AVVi8CfAds6-1QvMPvHqFEOGQj6cDhKRwM4ua7wpqufDJTfdW3NOUKcxL1Pga9E
Message-ID: <CADe0Y=tMSQerM4or_QNO6tjc6GaEiysaGpmcHnWhaDKQocN86w@mail.gmail.com>
Subject: Re: [PATCH net 6/7] selftests: drv-net: add missing kconfig for psp.py
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Mohsin Bashir <mohsin.bashr@gmail.com>, David Wei <dw@davidwei.uk>,
        Wei Wang <weibunny@fb.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX2WfhMs9Kp1jl
 pQ4c4lChKcnA/uoFqQH7hU5SrbmE6q27vm57T6B3nBMRaZ1HnmAWZsv1sYvi6jfV0LVRn5IDT0L
 ed5/Md0KmAolURPBZdXNEUpXH+IJAUs=
X-Proofpoint-ORIG-GUID: DFNcdsoif3EG3mdsU2mfaxAw5DN-BbU7
X-Authority-Analysis: v=2.4 cv=C+/ZDwP+ c=1 sm=1 tr=0 ts=6a516389 cx=c_pps
 a=Ak8bExYEjeps3Jj0Zi+cTQ==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=FOH2dFAWAAAA:8
 a=ctOhbmcJb_RA1L7furcA:9 a=QEXdDO2ut3YA:10 a=IIT_bRn7abC_HnDGr_W6:22
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: DFNcdsoif3EG3mdsU2mfaxAw5DN-BbU7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX+REcyJFpW+zN
 OAMBDg6JVScrx5vkLVO10gslVwHjJQ7HpoeJlCWUaXzAcq96kPYr0OnptJqkKhbzmUTzelJ0NTm
 b7eJwaq3VjCg0ntIySYy61arl0N4S0GBdmrY+sMA/QFcAAR4FnHMRS4NC3p9BAZ1UUYPfP3MNoU
 Ad1tuPTp4Mzyh/2WNfFfrtQZLJ7L6yw+Ql7L+aJMkVhXYY8OkIGTfZFU9LooHHE9ULRVn7OpQkT
 x76GTDulRYvZeML5Q4nTKUsSagHDeGg/P4A03+W8ldB+Up8cqeg0lYhcI70H3yE4LGcjJguV9PK
 +vsFg6OebyrSep2W+ObbIPwccVVf9+MiH2Sj+rM12oaWzX0boJjlNkW441oUD4r+rVp26QRNJJw
 Qrdj1YjdIfk6qd+fl7RyoZH3oet7yha2n6QsAbcVk95/es43Emrs2GsohGoMI0g2b9tk/fHfJiY
 6Grqj3Y6MOFgCQ8FCdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[meta.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306695-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mohsin.bashr@gmail.com,m:dw@davidwei.uk,m:weibunny@fb.com,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@meta.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lunn.ch,iogearbox.net,gmail.com,fomichev.me,davidwei.uk,fb.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C206973EF87

On Fri, Jul 10, 2026 at 11:05=E2=80=AFAM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> >
> This psp.py selftest was failing on my side when only using the
> drivers/net config file on top of the default one -- the recommended way
> to execute selftest targets.
>
> It looks like some kernel config are needed to execute the new tc
> commands.
>
> Note that this was not visible on NIPA, because these tests are executed
> with the drivers/net/hw ones, combining the two config files, and the hw
> one contains the missing ones.
>
> Fixes: 3f74d5bb807e ("selftests/net: Add env for container based tests")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> To: Andrew Lunn <andrew+netdev@lunn.ch>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Jesper Dangaard Brouer <hawk@kernel.org>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Stanislav Fomichev <sdf@fomichev.me>
> To: Mohsin Bashir <mohsin.bashr@gmail.com>
> To: David Wei <dw@davidwei.uk>
> Cc: Wei Wang <weibunny@fb.com>
> Cc: bpf@vger.kernel.org
> ---

The fix makes sense to me.

Reviewed-by: Wei Wang <weibunny@fb.com>

>  tools/testing/selftests/drivers/net/config | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/testing/selftests/drivers/net/config b/tools/testing/s=
elftests/drivers/net/config
> index 91d4fd410914..2070e890e064 100644
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -4,6 +4,8 @@ CONFIG_DEBUG_INFO_BTF_MODULES=3Dn
>  CONFIG_INET_PSP=3Dy
>  CONFIG_IPV6=3Dy
>  CONFIG_MACSEC=3Dm
> +CONFIG_NET_CLS_ACT=3Dy
> +CONFIG_NET_CLS_BPF=3Dy
>  CONFIG_NETCONSOLE=3Dm
>  CONFIG_NETCONSOLE_DYNAMIC=3Dy
>  CONFIG_NETCONSOLE_EXTENDED_LOG=3Dy
> @@ -11,6 +13,7 @@ CONFIG_NETDEVSIM=3Dm
>  CONFIG_NETKIT=3Dy
>  CONFIG_NET_SCH_ETF=3Dm
>  CONFIG_NET_SCH_FQ=3Dm
> +CONFIG_NET_SCH_INGRESS=3Dy
>  CONFIG_PPP=3Dy
>  CONFIG_PPPOE=3Dy
>  CONFIG_VLAN_8021Q=3Dm
>
> --
> 2.53.0
>

