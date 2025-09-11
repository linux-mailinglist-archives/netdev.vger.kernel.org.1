Return-Path: <netdev+bounces-222046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9DFB52E39
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E561689BE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB13101B2;
	Thu, 11 Sep 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1So9rSBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B5E30F93E
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586225; cv=none; b=m8T7qFXs0mceM3qfzv4REgbe/bMK4PcgT03C7f/QHBd2IZgHY+8XuxsDC0EGgNrXr5JISQvhc9+FnUP117i1XX1PMJMX5la40nqAphrlMb7dAxNwYaKLUDrTBxson+/6PhvF8A4KUKDTFme7/R02d0krZioiEZU+AP+iBIz23Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586225; c=relaxed/simple;
	bh=ukn8wxXXJttJe0inA/6JoLw4EvA5oymvYI6Xf/Ei0M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRZn4TwuBGdoN80/m+EEx3WfkduMKSfNv233wz5hTC5HzlImU3LGq+9D/k+NnmXqss9hMcW2ftX54ukmg4Lplowqmkp+W9+9rbZY+V8hK36h+/nrWvbOY5rWZzVAOmCPYo4f2HpyTpukth4JjBzvbJelJVtLQvf22LljIbUPXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1So9rSBm; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8173e8effa1so33874785a.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757586223; x=1758191023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHnZCYEfRxnGmMFHuhxex5pyTO1Gc8zq/OjkEGwsVds=;
        b=1So9rSBmXScebmIV9UhHdJ9t5sKNYZV8nzCaxBsiujwU50cMy3av9JnjY3Tquh41pA
         N4eXIad6ohoJRUQdhpEdut0i5tTFH64GXud5j/0fx97KQmlzu9FgTDpfUVAJIUlqmOrM
         PX9a2JsT1w5Jp2VmV87vlPNPTqcEajJorxtrUO00V9B5/Ufi1KADhKLxrEOoYQLIlKdJ
         4ppcYV6UGOz9yDwU9Fr2SEDVUi0GgXbEI1VvaJBvfDtGbOz3SDl22z8ObsH1HfFaEa+d
         3CV2GYPOuMzTQvTVhxCOTJ6OdpI2NU9Zuf4ccno1h5YB2wwPEU1RsC9PGHAAh26sPqal
         5PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586223; x=1758191023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHnZCYEfRxnGmMFHuhxex5pyTO1Gc8zq/OjkEGwsVds=;
        b=u7OiF2qXjjl10j35vMdmAyVb/YMi/6EcVmjzQqgZMpbt7jmW6+raoOphggHY43LNtx
         pr648zqHpP3KHpcszZH90zFTcUWTo3eB29kZrSBsyooMndSrCPz3OpNiaENBOEV6m4DN
         HcwWJ4sOYukNQ4Jndndhc2DJWqAvYzZPawrbSZpWnGmY5HaPOFpB1H/ZoegEpeP4GTl9
         3Hst+NM5h+nMi/7advWl2+PL1KeyrS5637v+3qMGi5cTRDC5fCzgicmCOiroenPy+Vv2
         aQDmD0USYA7E21TNzmaorCbiGNy4SdT297wuTlC3BtrNwNgbxg7Z6PK8SspjHuDzxErP
         D08w==
X-Forwarded-Encrypted: i=1; AJvYcCU5YfK8x/Ej5odqQ+CL30GpN6EJP3ajPVj9i42430hwjzrKkp4NBEkX6NvX8qIJY5N5YrLfEbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMxrqVdQR3n3nUYIJDa2SyQMHnsEizVlIHAA6rm82F8tXOmy3/
	wZ2AJvVgsYRVNdz7DCdlsbQrLLCAs6CR9qr6Wp+h+nWuDE7IBKVaKjDzPAXPluX7u/uyKnwUBAN
	UGaPczftxrIu524VpDQFCtJYBxHNRFFXFdZ6MUB02
X-Gm-Gg: ASbGncsQFBi/jrWEy+4FkJy71pAy7P4ZVlm2h9r0/s96ctFBp5RvVtnLq85HkGMHSgl
	t35jqHWw3i2XuUhDixybHLTepqW4Izx/+PMkWlQjgDf5QdJpPJnWkO95PG8ReubO8bRkD2+axMg
	5JReuQuM2bZDmo/2kxvrbv1Mb9ToTSTqOSMoD/WA7apEFtRXABc0SvxKBKnFt/pegwYQSLFgazy
	1kXYcHUgehToF46SNk2eD3I
X-Google-Smtp-Source: AGHT+IGgK8q4SNrpdQUJbe38ZudlYHbCzwzu4yMycJPq+zayMUYl4Bx38d6dAEyRQo0OxNalegvGHWF/qhqKliKmXlE=
X-Received: by 2002:a05:620a:370e:b0:80e:455:941c with SMTP id
 af79cd13be357-813c4347e16mr2301175385a.75.1757586222335; Thu, 11 Sep 2025
 03:23:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com> <20250908173408.79715-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250908173408.79715-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Sep 2025 03:23:31 -0700
X-Gm-Features: Ac12FXyvUxriD3hjoGqqSHZZuY5KfMXoGHwV4vpzThNN3yobS1kkx_rd_GW-OVw
Message-ID: <CANn89i+LVRbmGq8Ft3WrsCoQmP8YfMYLM8-NQbaVT2bXnCWQ3g@mail.gmail.com>
Subject: Re: [PATCH v17 net-next 10/14] tcp: accecn: AccECN option
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:34=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The Accurate ECN allows echoing back the sum of bytes for
> each IP ECN field value in the received packets using
> AccECN option. This change implements AccECN option tx & rx
> side processing without option send control related features
> that are added by a later change.
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> (Some features of the spec will be added in the later changes
> rather than in this one).
>
> A full-length AccECN option is always attempted but if it does
> not fit, the minimum length is selected based on the counters
> that have changed since the last update. The AccECN option
> (with 24-bit fields) often ends in odd sizes so the option
> write code tries to take advantage of some nop used to pad
> the other TCP options.
>
> The delivered_ecn_bytes pairs with received_ecn_bytes similar
> to how delivered_ce pairs with received_ce. In contrast to
> ACE field, however, the option is not always available to update
> delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
> bytes calculated based on the cumulative ACK+SACK information
> are assigned to one of the counters using an estimation
> heuristic to select the most likely ECN byte counter. Any
> estimation error is corrected when the next AccECN option
> arrives. It may occur that the heuristic gets too confused
> when there are enough different byte counter deltas between
> ACKs with the AccECN option in which case the heuristic just
> gives up on updating the counters for a while.
>
> tcp_ecn_option sysctl can be used to select option sending
> mode for AccECN: TCP_ECN_OPTION_DISABLED, TCP_ECN_OPTION_MINIMUM,
> and TCP_ECN_OPTION_FULL.
>
> This patch increases the size of tcp_info struct, as there is
> no existing holes for new u32 variables. Below are the pahole
> outcomes before and after this patch:
>
> [BEFORE THIS PATCH]
> struct tcp_info {
>     [...]
>      __u32                     tcpi_total_rto_time;  /*   244     4 */
>
>     /* size: 248, cachelines: 4, members: 61 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_info {
>     [...]
>     __u32                      tcpi_total_rto_time;  /*   244     4 */
>     __u32                      tcpi_received_ce;     /*   248     4 */
>     __u32                      tcpi_delivered_e1_bytes; /*   252     4 */
>     __u32                      tcpi_delivered_e0_bytes; /*   256     4 */
>     __u32                      tcpi_delivered_ce_bytes; /*   260     4 */
>     __u32                      tcpi_received_e1_bytes; /*   264     4 */
>     __u32                      tcpi_received_e0_bytes; /*   268     4 */
>     __u32                      tcpi_received_ce_bytes; /*   272     4 */
>
>     /* size: 280, cachelines: 5, members: 68 */
> }
>
> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> group size of tcp_sock_write_rx is increased from 96 to 112. Below
> are the pahole outcomes before and after this patch:
>
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4; /*  2522: 0  1 */
>     u8                         unused2:4;             /*  2522: 4  1 */
>     /* XXX 1 byte hole, try to pack */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;    /*  2668     4 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];      /*  2728     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 167 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4;/*  2522: 0  1 */
>     u8                         unused2:4;            /*  2522: 4  1 */
>     u8                         accecn_minlen:2;      /*  2523: 0  1 */
>     u8                         est_ecnfield:2;       /*  2523: 2  1 */
>     u8                         unused3:4;            /*  2523: 4  1 */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;   /*  2668     4 */
>     u32                        delivered_ecn_bytes[3];/*  2672    12 */
>     /* XXX 4 bytes hole, try to pack */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];     /*  2744     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 171 */
> }
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>

> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

