Return-Path: <netdev+bounces-305184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dZFGCv7zS2qVdgEAu9opvQ
	(envelope-from <netdev+bounces-305184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:29:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE7A714852
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 20:29:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=gt1ranLw;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305184-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305184-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91D07301DEB3
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619B1436BE4;
	Mon,  6 Jul 2026 18:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBA436BEB
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:20:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362032; cv=pass; b=RNIqZu8RUDbm5mWUaufjuVgtKCa5eL12dK8MZiD3ovd3NfdHH58HPJ/W6bTpB99upgK9dNPcniA6sQCXiLRrmmqFvnY4gpsWdxPe50IWONTkqBtXEFEMv/wJz0Z1psWBDPLeF3kDFABqUDAS2aqrtQ+om7tPTnAuYI7n78DPhvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362032; c=relaxed/simple;
	bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r86Wb79ONXcQc6UFIVLMx8k1jHSVhgAk0LJK6A11IaLpExnUp8XhmnRK2p/q1i/Cevu88R04yTZymzq5VzAK8qzlx1/ne5Dt7ys6mB/yHP30bdjGmL+xhXB8k5jDpAJglYdUlpo0JExhV3krLEg+QH4Qgy4aOSx/Ipg+gdlGkEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gt1ranLw; arc=pass smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso18758545ad.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 11:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362030; cv=none;
        d=google.com; s=arc-20260327;
        b=fQn8E5N405fJnYzbXd2UHDvKa2txNxCDf/wkcxz6g8New5B2wfx8sK3G6JGFLe/j0r
         TIFsFxX0gW+J1VMjhPr3t9tiql5sRLttYdwrTzYBePecJPEfVt+gevI+OlFUv1L5p7kf
         JbrWsAjCFnhXaeaFxr4VwSD6K3yGqxHLOifTYwjyd6OwQ0+K+RzlJLFn53oH5c/DZA2Y
         h+ofdaBqrIfVMBFemRM5UJmupzswG5C+W3dH7fVutogRX2MFNYezKo3ENKh51V4QgxIX
         XUZesZbePBHQZxcMiBUcLOZvKTWND9wKvV3V7fl1NRy5V+qhfDzcWiSZDsGAs2/YzRKt
         gNgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        fh=csTbyqsCpu9+rdP9Gk4oTvnhxHgYQbMW9WtwydVGp5Y=;
        b=BRaEHZstcwsWcOLB3UxPzidIAm6Iueft9O98tug8UkP+EV9FxkA6QwA2uHN937PLXx
         QERSQT2t5KFTCA4gwnpG4YNc1sanz3kOi8MNHe04/L7PTOgZsXXcTmjSGiZn/xbTxNTb
         jd4aUELrXl1K/MPscRtxdCrTjEtBawhiucRGpmnJ6IKY41nkYdhuXUZeapYnh7tvkPo7
         mLAwaLVkoc2hEa/tpIu0VFiWExHnx9Zg/zLubGUQnxdskFKs4EJDUzjuQKU9DmF4FFLl
         a4I9gP1igmcaDTwteYxqsx1vaXzEEDAQ/zLism3WsKx6Yf7kRBpQFJGWSN9FJALTGJOl
         GUsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362030; x=1783966830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        b=gt1ranLw6AeYolFBNOfjD/7XWMW8UFwoLKzwKsAzE0dZnLTpuq30Mq5mM3YE5pvzgQ
         TZC5yhUsm04Pfsu0HWQ7ABJv1Ws0J/P1Xa+z6xvfPGzZQt1imEX8nXMq/Hbo37GvPSF+
         J6py53/dt5sMJQ1RfbAf1Oymm7EaqZSdboSPiUvzRiHLomrrvhY4yyds78FFZkLtY3In
         XvH6OtgCvsLYgqwj/pB6Yq9KpiJOcEKlZLxwMfuxO9XW2WTkSIYSYkS2u0fshLLezP/k
         MMrU4Dq0AdCiJIQVu2uCwzqXDFpHm4PBV9VVNKpOU8p11bb5rVfnBBbR8z6x3F9PoKAt
         Kvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362030; x=1783966830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        b=DWHgkbEeIyOeZMetYQw1Ixee7PZtxp0cBVFoLd6bBADpMwVZU3/1/ybvKm+DeftdsJ
         pyNWRKKCHC1arhPcvd5xJ1sZQddGwz5MPp8tY1PY+RVjE9zVu4c8q0aEO0XCAVp32IUw
         /kzdz6UpyZrT/xdy8EPxVytii30O5u8mEBoBJ7I+z8jROShBpLtoa0K3jEGjE5nBIMaJ
         PeMXKUQIsD0LD/PjJDgPbiwRNFgUmm7ysKTMXZVUCRU7M4D4MIoZcOjEeahIyiQ1pMLl
         5UwmdenUvxkwlkMfLfAA1eFj1CD6CJoBKcJJ9On7CSgM0r0x5e+QDu4Nze7dPiQoS9D+
         0qyw==
X-Forwarded-Encrypted: i=1; AHgh+RryT8gX9oBUGxNpvRIQcQ+QvIWHVIjF2YWP/Xw8oisVmtxgCelGziXLwh5A+mKhB6S6LHkfJCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2PstzSo+4Y5xTIHWYo1FrnrGZNEjc0czh2XU6DF62c/jC34y/
	YdwbBaRqsqU8iH75LXIRYq9nqx3+LjmqhfUVWNYyU18rwmUzm7OG2lrjuwTNFAi75NTss3LqrJY
	MZiDi9HKLMqi2tjJqFgayJmN8AX6i895v9AHZEPei
X-Gm-Gg: AfdE7ckkP3ilw+QVppt7gN7fGoo+o3EDG0H+B3nDUMLaoU0Z9j2RxYTtll/HlCtOUfz
	rhkFNdx8771H0D35TO+v5mz1romGg6t0iinqG04NRKRZhIqCn8zcrjEmMqEnntQOiKjNb/1LiEw
	VVrd0ENy2Sn9agBaDoVvPNWzkpEfhcGzKag4kMe5bvDcs1KGndxbgJ2une8zSNL76LorRvpMEmR
	NaaB1jlhbuog/7kN8fwZKgWhinRU8Zep7TT+8wmA1vceWEC0sdu8r0wnZaawixR/qu7awmQ00vt
	FSzeSU7/wIxfzzKjgUpFUtzhJlXTIqk7Qiep/R+xQ7Q7RaEgZcRuWHkP11D804B6+keDyUGl8tG
	xHak5LR9MhgNB0M3I+LZDWzieaZhfBGDPjmZowNs=
X-Received: by 2002:a05:6a21:7116:b0:3bf:6c08:2b2f with SMTP id
 adf61e73a8af0-3c08efa611amr2088864637.55.1783362029050; Mon, 06 Jul 2026
 11:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl> <20260705123826.3818443-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260705123826.3818443-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 11:20:17 -0700
X-Gm-Features: AVVi8CcxohvHsY7AotTJutKD4Bx9caNjYENOm7GnE1Tqy2ObFIE98uM4BTIeXi8
Message-ID: <CAAVpQUAViuZ0DY_1=N_VGuzN7cBM+oFDKb_Fiik8Hb-ueQJpjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: scm: move scm_detach_fds() from
 common path to scm_recv_unix()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:brauner@kernel.org,m:cyphar@cyphar.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305184-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,xs4all.nl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FE7A714852

On Sun, Jul 5, 2026 at 5:37=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> scm->fp can only be set when using UNIX sockets, therefore we should
> move it out of the common path __scm_recv_common() into
> scm_recv_unix().
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

