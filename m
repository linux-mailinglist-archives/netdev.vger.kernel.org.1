Return-Path: <netdev+bounces-303405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cPt3Al1PRGrvsQoAu9opvQ
	(envelope-from <netdev+bounces-303405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:21:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E546E8A18
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 01:21:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VzNNrkAt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303405-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303405-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9A2A303CC4F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1603338595;
	Tue, 30 Jun 2026 23:20:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3446321F5F
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:20:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782861655; cv=none; b=k+kA8V83rF0JkBPaZF28viLneQCPkF20DAqyZ94t6z8Y4oOoqn/McTJRHT+7BiqIGA5J376FkIVUgZZjMa27hxtCWIUzrlV2km4ThFcafy7/hnXJHUJkeYz8kwryd5hjCwZr9NtggnJhy79vabNPskFYemOemDaqnfS/FEdbU08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782861655; c=relaxed/simple;
	bh=MyCniKPbL+Lqz0L65ltscAhVa5RtLJou0ccIhfIbqqM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=s0r0eKhLC0vmwBGqd8VX1EJfAGjmtBvXlcYcySbzbW1tlyntUW+xVSoh5sdMI+pYkJwI/XfSMC3VZQhN9SH9Z2il2hx1XiAT1yHwoDDNTyy67LZBev9/xCt7AKyOkeeKSj3Go2rhCDI4rTdc3iydiL4DUTB9YPCtS+JDV2VBpQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzNNrkAt; arc=none smtp.client-ip=209.85.161.46
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a1888969ddso22793eaf.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782861653; x=1783466453; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cB/ZP5ypFx7PVtX4ppcUb1XeE8gYOmi+BvjetO5FJh0=;
        b=VzNNrkAtr3vorUdKjBcmEOX/USgnVzzkhlPWtka584Vgz/IoNRu1z9NPYEmrCdpGoD
         T/goRJRJtuLRDQJ2EAvmoLQh3tMkw/G/tHpRw6xVpA7ym1ntBYQd0YAYJZduCLLA5VrP
         oW47bR1oNIrvTTNdZHhQq85wj+x26Tm/yvBdiT3dBR4Q8ChN85UwYC9qd7euygesn8nM
         4XZyxkg3fbj4Dvgj+dobyXV4jCXMZZsNsOvVigmzhpcvqVOadGDCOKLX8PS6m2+QjSCp
         hTlfcPGqoXltU5VRQDdgMB3p7VSyP38DaHsSm+sFnTx7Q28Tzs7LoN+UCuGR9gxrjEAY
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782861653; x=1783466453;
        h=in-reply-to:references:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cB/ZP5ypFx7PVtX4ppcUb1XeE8gYOmi+BvjetO5FJh0=;
        b=ggWL7S/DLrnNJf7/Je2B/MWHzbKOl5guKbokdWjgMKu7pkuIhLUzl2svBTzedDX8+x
         LgbNvKCuPrHkhGdTAiIJrwaZRSSpoVcgHiXx78ff3j7BH/Gh0AE9AJU0JTHJDD80mGb3
         lm6cA35iee06VQkOTa2fhbiuvigyS5KWiyV94iKVrA6eZYls98uFZpYhwY1bhAcN1hxY
         7nHPysUOYHOGy0X3jilJzOqetZhWCR6Lc2dstuED7qP2cky4yfHCl8Uz6u56AHBnKCjm
         4hkG4ckapVbhBbxoGnpbpj+5rv9PeS51/Jqwp9yWps/NCR3c10LwWGxG0F6Jjv10PlrN
         6RzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/UXE6rTnTBeFYQ+SSpaadHFjrOWH58ElErD2iV1mt/WXEgAzuvoOsg2j6BNntLciP2J9d1QOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNgeTMy5cp2bkierKEvOcRMhPIEoMziJThIa0rMp1Lzrvgrwr
	XK9XlZ3B5gRffcOz/VsjfiHhdlT6WT6c9f8PbUg1DTHLYQ/iirFlCxHV
X-Gm-Gg: AfdE7cmebHAbdKP9JXlso1abhpF1KR89CJDncDnbqRzlu56BM8+i5z1VapLk6V8i7tP
	y/0bX0QmlhaOZEVojoxLFFmLo0CsZBU0qJbVELxZyZ8vITxelv8SOva05OIYxMtiw+BTicEZZr1
	dLDKHmfTosRn9TSAhmi9DVW0M1j1P/+ylA1wY7jGdnRwou777nwzitSohAVLdqOqAYEEdHkeCG6
	JMdWEyGeRMaxC4jPaI7cLlT4xXirYs4Mry7yf+pgyxQfG8WxSral+8w5O4+h6PzZ58wyygWgDWM
	TrQ1U6MXDv1UkDokefFNfasRe8e8oNuWzKgaeyfsnZDiOBTDK8XPJfLiQz98+OGweqQttfVU0Wf
	NGr+VOfzDXG0JXs0CKdjruHkR9hf+Us2sN1ZTZN8QMNqX1+OCyvLbA7fPuQcT/D2XMW9gZ447/y
	VaE7o569Qa0sj8Q1NkOvo0ymV7xo2bbf0KnQOIC0uMCXQz1o+AY9wyU5CAD4PnPN2z93RWkf1V8
	iTJf7I=
X-Received: by 2002:a05:6820:4df3:b0:6a1:4592:eded with SMTP id 006d021491bc7-6a188e2a5efmr3936292eaf.0.1782861652634;
        Tue, 30 Jun 2026 16:20:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a18949b384sm2986584eaf.15.2026.06.30.16.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 16:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 16:20:50 -0700
Message-Id: <DJMRPJEUTY5G.30HYOMPLBGZOJ@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chia-yu.chang@nokia-bell-labs.com>, <jolsa@kernel.org>,
 <yonghong.song@linux.dev>, <song@kernel.org>,
 <linux-kselftest@vger.kernel.org>, <memxor@gmail.com>, <shuah@kernel.org>,
 <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <horms@kernel.org>,
 <dsahern@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <jhs@mojatatu.com>, <kuba@kernel.org>,
 <stephen@networkplumber.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <andrew+netdev@lunn.ch>, <donald.hunter@gmail.com>, <kuniyu@google.com>,
 <ij@kernel.org>, <ncardwell@google.com>,
 <koen.de_schepper@nokia-bell-labs.com>, <g.white@cablelabs.com>,
 <ingemar.s.johansson@ericsson.com>, <mirja.kuehlewind@ericsson.com>,
 <cheshire@apple.com>, <rs.ietf@gmx.at>, <Jason_Livingood@comcast.com>,
 <vidhi_goel@apple.com>
Subject: Re: [PATCH v3 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
X-Mailer: aerc
References: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303405-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:chia-yu.chang@nokia-bell-labs.com,m:jolsa@kernel.org,m:yonghong.song@linux.dev,m:song@kernel.org,m:linux-kselftest@vger.kernel.org,m:memxor@gmail.com,m:shuah@kernel.org,m:martin.lau@linux.dev,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:horms@kernel.org,m:dsahern@kernel.org,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:kuba@kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:donald.hunter@gmail.com,m:kuniyu@google.com,m:ij@kernel.org,m:ncardwell@google.com,m:koen.de_schepper@nokia-bell-labs.com,m:g.white@cablelabs.com,m:ingemar.s.johansson@ericsson.com,m:mirja.kuehlewind@ericsson.com,m:cheshire@apple.com,m:rs.ietf@gmx.at,m:Jason_Livingood@comcast.com,m:vidhi_goel@apple.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,kernel.org,linux.dev,vger.kernel.org,gmail.com,iogearbox.net,redhat.com,mojatatu.com,networkplumber.org,davemloft.net,google.com,lunn.ch,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91E546E8A18

On Tue Jun 30, 2026 at 5:01 AM PDT, chia-yu.chang wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> This patch replaces existing min_tso_segs() with tso_segs() CC callbak
> for CC algorithm to provides explicit tso segment number of each data
> burst and overrides tcp_tso_autosize().
>
> This change provides below impacts on BPF struct_ops users:
> - The callback is renamed from min_tso_segs to tso_segs
> - The signature gains an extra u32 mss_now argument
> - The return value semantics is changed from "floor value passed into
>   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
>
> As a result, BPF programs shall be updated, beccause retuning a small
> constans will now directly limit tso_segs instead of the minimum.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h                                | 13 +++++++++++--
>  net/ipv4/bpf_tcp_ca.c                            |  8 +++++---
>  net/ipv4/tcp_bbr.c                               | 13 ++++++++++---
>  net/ipv4/tcp_output.c                            | 13 +++++++------
>  tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c |  8 ++++----
>  5 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6d376ea4d1c0..7fb42a0ce7da 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -824,6 +824,9 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu);
>  unsigned int tcp_current_mss(struct sock *sk);
>  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when);
> =20
> +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +		     int min_tso_segs);
> +
>  /* Bound MSS / TSO packet size with the half of the window */
>  static inline int tcp_bound_to_half_wnd(struct tcp_sock *tp, int pktsize=
)
>  {
> @@ -1361,8 +1364,14 @@ struct tcp_congestion_ops {
>  	/* hook for packet ack accounting (optional) */
>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
> =20
> -	/* override sysctl_tcp_min_tso_segs (optional) */
> -	u32 (*min_tso_segs)(struct sock *sk);
> +	/*
> +	 * Override tcp_tso_autosize (optional)
> +	 *
> +	 * If provided, this callback returns the final TSO segment number
> +	 * and will bypass tcp_tso_autosize() entirely. The implementation
> +	 * must derive an appropriate value and ensure the result is valid.
> +	 */
> +	u32 (*tso_segs)(struct sock *sk, u32 mss_now);

I don't like this interface change.
It introduces churn for no good reason.
At least I don't see why you cannot live with the existing api.


