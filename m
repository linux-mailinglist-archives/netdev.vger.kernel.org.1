Return-Path: <netdev+bounces-296707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bAKmIq4gJ2o3sQIAu9opvQ
	(envelope-from <netdev+bounces-296707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:06:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E226665A44C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:06:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JaGM42CN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296707-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296707-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2623303C39D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0193E51D4;
	Mon,  8 Jun 2026 20:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBA23E834C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:02:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948942; cv=none; b=T0bizPkOFRsyI8RZrtMDq1T6qnUQd1tfAGDEvhw0O0gao0iefCPyhAoc98uR8KQ6vtgjc+fPA8dZt+MZnx53w8/kXk7Kc2OWHBFkuUvQApS+ykC4ZLti4ZStlqZ8IvdfiKufmSwIDxZILQxzkQAmIAA8koV92Bh/qUCgDAB5iDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948942; c=relaxed/simple;
	bh=wrqE2O76YCV8wdY1YPpUUnMYdTSt/lGtjLT9N9f7KaA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=XWFaDkFokTO5UeZscS050r2xlgLLQ/GNvCtGh9pHeRAkb7qJ6w79UQS6Jn2rpz8fYbFF5bCGHbmEVR7ejxaD/jT+6IInZ8kpmXKdISQfCUWvDOq7yf5KomBf3CmcuS9tifjRgl3D/+TBn/xAHt/BRkrIRmvHDEcKt3jfuYRpDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaGM42CN; arc=none smtp.client-ip=209.85.210.47
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e71198e0adso1205448a34.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948940; x=1781553740; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwrxcif3XUtEKF7lrhb7eyL0FpVd3GzB9U/X8qwd09o=;
        b=JaGM42CND++GVCO/APZTAt8fet5/AfRQBUcUWxHYxHHqZInMxKQbF6OT3FmXDjtx6i
         ozM356muRW6wHE7nxLSzn0SpJLwzCmam74OffTWA0QxKNXp2uBjvUKkWZHa5Qn2qSMvL
         LUMkkAtJm/hr/K3MutMWwkwk9vP0EL8d053cguGLhQO+eWhd9DcMNR1Mp9om4+fpp3Ne
         R6SlRzNODEgUPxSoeYrLPmWT5FDBkX33xxLwNapI3/HMCNc2SEWNQmWHBOZPmRQYpqpp
         +PAbwSpx/A6u4EDuoiFZcwRcVVsnSb9x8xXTMxRMeUutezTmyBN38WGw74RGHhb8To9j
         5amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948940; x=1781553740;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwrxcif3XUtEKF7lrhb7eyL0FpVd3GzB9U/X8qwd09o=;
        b=qOk5Q8rbRYnGxVC0k1HrAC2J/Ndj/fvdZ8k/RFytSwISwOgIOL9YFgYxexfcb00ufE
         GddquUQVzsHm0+PRyzjwHyxDHl4JLGUfcFWg25pp/DujGBWvbY86+EEn5725UhVKbNJp
         778I9JhQ3ZlfUTxwMOW/OH5eeC1NpCmqSCyGmH0jAaSN4zGRzKdX6+BZmZpjlmuX8BOi
         Ww1x50vEuOg4tHtE5U9RoDkCfNCOhza5/4Wwa/jxAxiO4OKpcrah5JYQapvN8YosmW71
         E0pmbMYSaZXO4Qw/7i/2/cu8mAShcuvYxBMJQrbx5nRlUcm+1I3/+K9XNlnFf1/eZ521
         d+Mw==
X-Forwarded-Encrypted: i=1; AFNElJ+IeaBUhUZ5cYxChe05KqamHzSjrgcreQ2Kw3CVJG/algW+0mjG5RvmX0ph2lXK2gH4i7yq75o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMDd8V6j8IWKXiPVBGRraPDIvoYVs0dNfEs+BgvK1eAmHhxSq
	MJ5Ndw95qHhSSYKN2iZNFUGa3fxZ/ibh8TVSENIaJ1IYAJQuoBIA9yCj
X-Gm-Gg: Acq92OGC9JSRaoqKvyo6YdYitU9zwh+fwUJr7PZE0LPB3kfN6VxYbhVP50WOC82g7SV
	DWXte2L3JOHtR3vxpW8X5a9IrffeKb+wcJynReMgkAYvszBP6C/+9K+f5CarR3LRlbQIPIblHgJ
	Up/5UtEkuoFaTeJl/kZvABtzIwY1vhAG2HLnNjYpE78k+GmBesGWd+ARXaZspQJYoNnS5zNl6Rg
	kS0eCXPzsfEmPq8DsLBHeS8NjH/6jy5zqKAZa1InX3oZ2lGQqQX4TB6oderW5DGLLx2gKBFGzmG
	BpmSt2c0f+mde6xOxr04NAGDrL4uKF1BrabfgIaNL/voE53rw8gGMOjUVRiijteXnHya5vrmFgA
	6JtIgNtj82qGbwcdwllUAxrSFWhr0/VowWKeLhVk671zrNy19b8inf7N6DdcXyzA6ShlIC2tmif
	LYd9cPjVUVUMB/3V715meDu3gNBqMPjmWQ9a91WBLaQpi7rPggU1qJE4AWtBfSIAsDypTUf1OSI
	Aw8qWFyVpSwaASrQ0tJddT+SBah3dEcl45uyHE=
X-Received: by 2002:a05:6830:902:b0:7dc:dd19:7f53 with SMTP id 46e09a7af769-7e70c7906d4mr9896252a34.14.1780948940066;
        Mon, 08 Jun 2026 13:02:20 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e7923af1sm13046364a34.20.2026.06.08.13.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 13:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 13:02:17 -0700
Message-Id: <DJ3XPJA746S5.NYKZWY1HBH8O@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>
Cc: <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Shuah Khan" <shuah@kernel.org>, "Joe Stringer" <joe@wand.net.nz>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock()
 for BPF-assigned sockets
X-Mailer: aerc
References: <20260608125846.157004-1-jiayuan.chen@linux.dev>
 <20260608125846.157004-2-jiayuan.chen@linux.dev>
 <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
In-Reply-To: <CAAVpQUDZoEVEX1kXok-29dzVHk=ZK_2MkZyZY8kRHCJCfAWVFg@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296707-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:bpf@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:joe@wand.net.nz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,wand.net.nz];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E226665A44C

On Mon Jun 8, 2026 at 10:21 AM PDT, Kuniyuki Iwashima wrote:
> On Mon, Jun 8, 2026 at 5:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>>
>> bpf_sk_assign_tcp_reqsk() can assign a TCP reqsk to a non-TCP skb,
>> causing a panic when the skb enters the wrong L4 receive path [1].
>> An initial attempt tried to fix this in the BPF helper by checking
>> iph->protocol, but Sashiko [2] revealed that BPF programs can bypass
>> this check via a TOCTOU attack by modifying iph->protocol around the
>> call:
>>
>>     iph->protocol =3D IPPROTO_TCP;
>>     bpf_sk_assign_tcp_reqsk(udp_skb, tcp_sk);
>>     iph->protocol =3D IPPROTO_UDP;
>>
>> Furthermore, bpf_sk_assign() has had the same class of vulnerability
>> since its introduction =E2=80=94 it can assign any socket type to any sk=
b
>> without protocol validation.  Since the BPF helper check alone cannot
>> prevent a malicious BPF program from crashing the kernel, add protocol
>
> I'm curious about the BPF maintainers' stance on this kind of "bug"
> where admin tries to shoot oneself in the foot.
>
> I saw Alexei said this recently, and I guess it applies here as well ?
> https://lore.kernel.org/bpf/CAADnVQLh7VEKAtckzz=3DXOVPT8ovpDQshvPPCWHDQu2=
OWQx27_w@mail.gmail.com/
>
> ---8<---
> Not every "bug" needs a fix.
> If a malicious bpf user wants to crash the kernel they will
> find a way to do so. Especially with agents.
> We cannot realistically close all of the holes.
> Right now the priority is to fix the issues that normal
> users can hit and not bots.
> ---8<---

In addition to that I have to add that skb_steal_sock() is performance
critical path of networking stack. Adding runtime overheard there
because bots can find a way to abuse the interfaces is not a good trade off=
.
If there is no simple way to fix it completely on the bpf side
then we have to flag this issue as "won't fix" and move on.


