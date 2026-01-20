Return-Path: <netdev+bounces-251452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFzQN6VqcWmaGgAAu9opvQ
	(envelope-from <netdev+bounces-251452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:09:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 525455FD42
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D733E7C6DB8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E0941323B;
	Tue, 20 Jan 2026 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLarUOM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE3410D26
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 10:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905663; cv=pass; b=SiyxNBCUoPopmKSriDXQpFNIDamEXe01F58kwOFnZG5MYmmUs0rLm8NopRjavXbyrtgkGkxEP81B5XoDWdFFMdpWdaVyaJllVDxHYBYTLvVeIQNVGyk4F0WJhLUu483vuei6+5t/5/OUiTHtP0BCRnBFULKLYTyD8lHvUO0UyrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905663; c=relaxed/simple;
	bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1lkHn94stmr0lv5jI4BYjden3+KnDHpD2r8dO1m+Faa8pWY4eC/cEufOe+rLU0TUV/VeTZmqFPnKQvjMnBPltssOQc7Rl/Je2nHpUNef7MDtgDZHNOXNX5AW3ap66XOeULfbgb+xBoH8ZCNynfmxX51f9Cu6FRihsYa3bTMRjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLarUOM4; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502b0aa36feso25495671cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 02:41:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768905660; cv=none;
        d=google.com; s=arc-20240605;
        b=I7ff/2UpIFTA5UsD10ezOqMcXMraaKBBxfNK5iz92hhxX3J38mqKKRLm6FoJBSDPFh
         TCmPRN7Cw6RgHH8Gj8X5nXnsNAM4sEJ2SM4s2v6xL9ve2BA4xZsFOP0N3p1/yntxx7O3
         WRyo7BsR9/1K+uP9va0OBkIy59b14xzJH148rT8Vk0XWycOFynj3E5nainAs0eGxXld2
         yUKOtbCt5TvxxvTaVZXOoqDg5XhMH6EuQKhyir7ryHKvJ8xmp1zfgWPhwZM/fyGH4Lrk
         KFFwHsHrEM1EmZpkjw+cI8EkuGNT1XhpeQfxHleWwFuYEa2UQctVl0joRMrMFSft8okQ
         mfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        fh=KiKz5OHTL/y0NJT1Zxd8IcC4ial+xCmsw1uJpQW8PZw=;
        b=gc+PvU7/viuymPGKPPmDjR61xKTqD5WKs962iunO2P35sfuCtPj/F7pbVfH6rt3oZ+
         0VGJeMBCriGJodEMEQIJbuBKu94ZDGmoEClfFcfZLyQx2Z76cqp1n7RybvZ9EUnjXHFN
         6Xbpui7qzXhxl7W2qXKiz93Oyk2EVNTcAOjxd/xg5b7HdnzKfPVpZmm8mpF1Yv8Q05hY
         G571sOru//4Vkv8A4H8yIq5+dI42BvFNciQsH6RIyWhUQiZ+vUP1a0UeVYIAWeh5/v3B
         DXRlavi1FuugPGEmPTBeiutzm2Ix7srs/WQKvm6kt48MKjQ6m0LZHN81dichpqmu++ui
         htXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768905660; x=1769510460; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        b=bLarUOM4KWKl8f8jZgqdcCHw3/BWGLLM0Lee/em0TyNUn56jxnJiCCMwImFosoG8BG
         bZ4ByuHgsMz229Eg7TzNOWTJZjiKMzDRETJfukjRdQEjYMCehR+z4Y7pAI9Q2auCxG7E
         e1Y54T0Hw7PqbKEqIZgANAaOQL9U5/pRC8TAKKDsc79lCOYpctfKAhJ2Q0SXP2DqD2fe
         f1u1/sh1/2CY3SJYi11hp/VEgmCZuNhxk/9RtFJ+F5kkn6NkkA1HU1Hl+vwEhd7LTXRv
         yw2bhlQNHF5yNZqfgxWMhFfvo0XmZUQNedyaSYVtNgkhtW/bP8azuPcC+vXn6D3LFXAM
         ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768905660; x=1769510460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFii1bsKXobctKhMNLtq5d1Ip3RYu1nQ6MH14Bs+3t8=;
        b=SOkyIGvVc6C8BUEtJ0P6RebZK4sbiYalHmNnu5RYQrTZO8q/sEVJJ/h0qRN9Cmx/bV
         1IR1HEoA66Abx6SJlYBGjhR9wsxnlKXaPzpA3pUui+m2eO2IUy6xxK/hpJ++u6ThpY/D
         FjRot3zye7QyTsO1o0v/PPA3t/aUUlUXDL06Cg/nsz4gMFQvn3siraZY7kycq26sw3T3
         wJW7K7oEDaOcC1qY9C+S5uYlL5gQpxFtQGwjuFTNzXRoqaqF6iU2kHLQ7UcHO992oWX1
         QrAkLyJ6+V+vbeSoIeu2SF354ULUh1W7mKemEXBKCyUlCsmJ39DTdiBLDgsx47uZ+Llo
         6v7A==
X-Forwarded-Encrypted: i=1; AJvYcCWtp3q6F0mDfCFcCEFOnRV8AMxJhDWKy+6V9ypxwUZDjRXlsxhd8+fmvqyGOWWP+JyyDzYxsPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHJL6B7pQuiVpbrEH26qWe6aVBbRvXMT+8UTgC2kIE0ylVTXl
	HvNwhs7CMTIgyOyV3yni5C4b4cBlQtmXuGy++BbMiBDghUN2EPhvIKHKKMU39hp1z4VY77Tz7Sf
	GaU6bULfZkVvWuo7sKkrkz8VdvBZg869WpkwL1+ON
X-Gm-Gg: AY/fxX787Ok5ZJ9TtPrSAU33t5DVbqAIgrwvLemSll4EoNj9aEq9mB1bQ6Nqtd5llkE
	qPjEwRD1e0Mzpc1bZXhTJSHJeNPmwV4fzN0YNJWxGtsAbwWIwu8hUVpxiKuIh75IEnNShj2Gl4g
	RWOgrgfoOYP4UF3m7DNshRTOEp4xEKQ39WwUuotfRg95qazByc74trq5Ldeh3vv8BLnAtPsGvT5
	ywX6VL1/jQYiGVyrppqxrpXawl9qkCjeIRcuTAxKn4tAfZP+kIcePRFDszw07TA4HRZox4ZcO9W
	Aw/SHg==
X-Received: by 2002:ac8:7d16:0:b0:4ff:7eaf:6fa1 with SMTP id
 d75a77b69052e-502a156ae5dmr191196621cf.11.1768905659838; Tue, 20 Jan 2026
 02:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-10-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-10-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:40:48 +0100
X-Gm-Features: AZwV_Qhir59xi47UnYx9OyC5NKVZCvDNZj7hbofVsggQLWG8gFaqMb9MOW1Nco4
Message-ID: <CANn89iJPE=rCExzfFw-eKe5PiukTnmUogaLJSXgo6JfDeZiezQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 09/15] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[37];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251452-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33]
X-Rspamd-Queue-Id: 525455FD42
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> For Accurate ECN, the first SYN/ACK sent by the TCP server shall set the
> ACE flag (see Table 1 of RFC9768) and the AccECN option to complete the
> capability negotiation. However, if the TCP server needs to retransmit su=
ch
> a SYN/ACK (for example, because it did not receive an ACK acknowledging i=
ts
> SYN/ACK, or received a second SYN requesting AccECN support), the TCP ser=
ver
> retransmits the SYN/ACK without the AccECN option. This is because the
> SYN/ACK may be lost due to congestion, or a middlebox may block the AccEC=
N
> option. Furthermore, if this retransmission also times out, to expedite
> connection establishment, the TCP server should retransmit the SYN/ACK wi=
th
> (AE,CWR,ECE) =3D (0,0,0) and without the AccECN option, while maintaining
> AccECN feedback mode.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

