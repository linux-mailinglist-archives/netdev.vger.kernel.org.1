Return-Path: <netdev+bounces-262931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHtQLEQZpmmeKQAAu9opvQ
	(envelope-from <netdev+bounces-262931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:12:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B96B1E6634
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 00:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2525F302FAAB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27CC2C1584;
	Mon,  2 Mar 2026 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwaxuNip"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E0282F19
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491720; cv=none; b=IKZJTWFF8v38xxjx/hUpZzawvrC4hFO+MMnFdbfxZpaFS9shRthyxcKqOwnwoVHx3BraPTUv4Xbo6hnNrSzDPF1LtL3x0ULltTo4y0AO7YbHJGj00RYtpNKANdWZjcDQiwWkADxnxsSNAEA7yzQlzz7P8+8hNQfs0HWUpZYEsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491720; c=relaxed/simple;
	bh=+wy8la/VGkrE9qXcHEYD0ZGp2zojpxnxhsuNxBSUvuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0ZAdBLe+dLbIgwi5qb4SFx8lO0rqixuj+AGmzlsGDezIR+8mbEd0tlQPbfVpj9PSFO57u6nTb5guHrSGHNRQXI045tgqTCpSrAs7f89iwe7xjPUNcHaqCuqaFcaVk4psGYWtM/eyERP/quJWxQF4jw3+IAG/VX/K+IrqL3GNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwaxuNip; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-358f058973fso4567729a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772491719; x=1773096519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te+OrBD2GijL0ppsDjl9gA82K/lUAJNc/dgoG8R+hfg=;
        b=uwaxuNip92aKUxTCec9tRosIiSrB8YJXGvHKzvbHaRxwOcomGztgGH/uowKRykxPGQ
         Ap5BG8sw3D0C2Wpj8Uu94UT7UMY9/nfhYOqpiopMWTzwFC1+cIfed+kga5K6szAL4Dqn
         VGAvApNy0UshpscgCdDEQ0Bre02fS+YEW4qMKDDBqZSlmyJIK8cJskZUhctf9uIYKpRQ
         auW6VgoIwy73HB6wKc5BmgNQjUWGwi/5gWqyh5KB9/xbM7JvIo8/GivR77bcTJeLmfH+
         aBdtoD9h6LqlGSTAoYQ8Th0WmRsdzRRxO0jt6CEFmlfmO1ELCc3fMMdNHJiVaz8cwXSM
         7nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772491719; x=1773096519;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Te+OrBD2GijL0ppsDjl9gA82K/lUAJNc/dgoG8R+hfg=;
        b=FrxxtlJX3NEUlYUdo52Cb25JO8BAOFO//qBlp9BmxgUFjvpIGasC4lcv2QPaTLV0XG
         t/0w7o7tGUnCoc9VN+pvm2JOihXC6if35tIU1BswG/9f8I6Gf6n35/5r8yu7yUS6YW9Q
         yQnND5igHgOAxsGog3Mej2goE0BWApNOhOgLoX/u8IsWJtYUWgLMzd11aCGN1K505n4i
         3K0Z4oEDVnqhtuGhplN9GVoswrekTKUjy0rkEux/8YaGVGSOGxwYvVnNG3y+QlV0lprT
         BZFdaRzqk3eUxJVDO1PTUduj0KlbwshIjh+kyoz4wD70qboJuuh66DC387ZGjFtqRgNu
         c5YQ==
X-Gm-Message-State: AOJu0Yy2VQQQdD731OmQR292L3JJihSFoMED7XWAiG45j0rbhek+3WpA
	xfgjjV5HDvAB14SAwfgGZLophaufEz4woXtsE8p0DWqeCFRvPA6ZMm2k8UJwvxYCkrXN02q8yhU
	zyyWvjg==
X-Received: from pjbgm24.prod.google.com ([2002:a17:90b:1018:b0:359:979d:cee5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d43:b0:340:66f9:381
 with SMTP id 98e67ed59e1d1-35965c4e541mr12062321a91.10.1772491718852; Mon, 02
 Mar 2026 14:48:38 -0800 (PST)
Date: Mon,  2 Mar 2026 22:47:56 +0000
In-Reply-To: <d206f3f708dbc81af07bd71b19e94894181dafc3.1772485990.git.joerg@jo-so.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d206f3f708dbc81af07bd71b19e94894181dafc3.1772485990.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302224837.1286217-1-kuniyu@google.com>
Subject: Re: [PATCH] doc/ip-sysctl: tcp_timestamps is per src-dst not connection
From: Kuniyuki Iwashima <kuniyu@google.com>
To: joerg@jo-so.de
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9B96B1E6634
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,jo-so.de:email]
X-Rspamd-Action: no action

From: "J=C3=B6rg Sommer" <joerg@jo-so.de>
Date: Mon,  2 Mar 2026 22:13:10 +0100
> Since 28ee1b746f493b7c62347d714f58fbf4f70df4f0 (secure_seq: downgrade to
> per-host timestamp offsets) the random offset for TCP timestamps is the s=
ame
> for all connections between a same source and destination addresses; the
> port does not matter.

We are going to revert the commit and then this doc change
will be unnecessary.

https://lore.kernel.org/netdev/20260302205527.1982836-1-edumazet@google.com=
/


>=20
> Signed-off-by: J=C3=B6rg Sommer <joerg@jo-so.de>
> ---
>  Documentation/networking/ip-sysctl.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index 6921d8594b84..0d74f8d8a79e 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -1071,7 +1071,7 @@ tcp_timestamps - INTEGER
> =20
>  	- 0: Disabled.
>  	- 1: Enable timestamps as defined in RFC1323 and use random offset for
> -	  each connection rather than only using the current time.
> +	  each pair (src-addr, dst-addr) rather than only using the current tim=
e.
>  	- 2: Like 1, but without random offsets.
> =20
>  	Default: 1
> --=20
> 2.51.0

