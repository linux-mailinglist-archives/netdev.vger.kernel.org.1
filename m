Return-Path: <netdev+bounces-255589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id L1ThIWYhf2nukQIAu9opvQ
	(envelope-from <netdev+bounces-255589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:48:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B960DC55B2
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 10:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9022C300FEC7
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 09:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01AC2EDD4D;
	Sun,  1 Feb 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h1w5+llC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDE19B5A7
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769939298; cv=pass; b=R7kOg4zN60q/5ZcYEqQqfDvrV7lqmtDpyqjDxGf98Wp+B9ulyOCSfSXLLIF0bjfWhrfnOJZXx2QLUVZG3hf1lTC6OIF5j/g7De0FP21CvIIhyMkhh1o6W0R+/RVPd54BaLi4f769lw10Tm4/RWLx8Ga8sSeweTYWxtSV3DSoV0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769939298; c=relaxed/simple;
	bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJ9QQ8zwsA66J9zJZAw3MV+wnoBsAJDAARGxtdg/sW8gPI9D8JF2WkbU9KzV5eR4iaMTpL9inikxtKDoF4qMf2UqnnK9E9AxWk610GFMlFjb+6cFlVyjV+oI6qw5NjDRO4QxcP/Ojl3JHu/1GLODNB3VapJ4XFofGWPhc5SzFVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h1w5+llC; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-894a2309a29so50681186d6.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 01:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769939296; cv=none;
        d=google.com; s=arc-20240605;
        b=SdBKK5lab6SDwwxCLcaVytj5wOg0SGnIaYf/XpOlwZqqlFFp8tn2BwG7xxnsfj/Txn
         kCvzln8BLfwa/O3rx3bXsHuhCSd4Mk9MsruYb7WZ/CE3VnagXAaWSlAtoHn8hgQym/PR
         gM/+HqZV9NBxCOhVbEYy6E2WBsRO4xnhg/N/LR5yekK/KM1Q/Epg3ZTGOajkebUWuByJ
         rxowNO+VnBvU1MOmFZl/uwSrVStqoQ+1gQIJ6W6O0RbSBqXjA38YwPmWU9EgZFZAjMYe
         C90Pw+Z1yP9LN1jSy9WLI1PPCMvchUQaQAMkdA7nRO9gMRKkCBuFtGN4SbtJIEhnJA64
         n8KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        fh=SqoYs0dAYe18d6soaOlWMwFfvoz7BzLgBG+bjH0GILU=;
        b=Nl9CIxBOlUJnpek+xDFTG7u+LE7ehPCVZ1VCWRdeXrmBzqdbbaEnfXQA+gJTBzuYE0
         XdUKNhj4CSgaqwwFt8Ecjw/xSsEGrozaW8fo0BR8LQUNyoo8Wt0jv8ij+KOKn2BFcvtu
         i6yFXo/emfrCw0n+f0jdfvJxi1F062gfuPSwiRKd9QwAwz3aj6uSs8/jRO7arUGFtaCX
         NhZn6o5XIM7zrVEUyfBU9zH0Ho/kA/Qikm9mtQRRxnTw0fp3mhAvmj5k34z5plXF7GH6
         ifENF6dbiYdkcQ/Q04u1ZZHNzuA5ZdJEFFqoagyjWOVPFKJdv3tAF8JSPqjlqwaNZyY6
         Ys6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769939296; x=1770544096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        b=h1w5+llCCiuIxjPNhVXpGF+Ct8UzHQQec6wl3+wukIQQL2Kl+mahgVwyhwW54DVti2
         Jz8/uTckRoLMMGQcPRTjeJF26KYNEaaq35LN7LA7CqnQsXzTdDTJKCb84xvpXqwrv24I
         D56rHSNkA3y9y/yt0PEHwieO074xLIZYoLMkdwSAbtoeTfRG4q6Q0CYxJGgRkT0rZd8I
         W+XNkKMZ0CwDFH0mPE4+zjHZq165ZTsUsNFj2pyoJ98vhBRsJUi9deCVOv8eaV6e3atQ
         QDSB5YzqOE3b/ozGkEux88pHIsyGVER7drdnktrPQv4Do6lhmTCU5V5fFKPlLx6g0Kf3
         cO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769939296; x=1770544096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXkN9oyywybnewmZSwlkjibNHUjLNW+K3CsKXmN5TTw=;
        b=vaBUfE2vkGLCSiXLSnMqixOV2GU6iNV0PvW+rgeftenE2lnklMsza0FdRkyc6L/dB9
         rEY+b5tmk6naa+AGKjR+s3MAaE1RXv8+RbasERacqx0cP9nJp5wBLBf+SXG3Io990XRe
         di7HXUOs+XXHgyk3KQAUkI9ulCvr+Iti+xj1RWcC8760KHTnN+DN0jtdcTgfcKED5HFK
         7ByZ4eV/Kri8PpzlyR7DwBH7PiBngPao8s1oWCaOViuG0eTuj9hxk/rl7uLy9ysnppOl
         pypEuoT1B7V1tiOhSD0xJdfxDfipM2fptAWNBsrwl2pOjC+k7uv+BxNVkqyhzMbper4s
         UDlA==
X-Forwarded-Encrypted: i=1; AJvYcCWhJz6Ibc4rRfw/9fKSWecHLytjBZlPxxgr/XceoKCMMCKPNUsKrtmjaG/gPw+qgk60emqNP8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGiiBDc4Q1h+ftfCHSCOuIf5ut9NQrbXCXbt6UGTeEE2ehfzw
	6YlLRpMUMdejj/DNoFFg7NydWc+5VxaA/2PJ6QuzXJGtvewRsBQgl7D2DeT8rP3RvTcOPFF3g8s
	SRKlMT/3cjrg+ciZ1a0tkjxI/NumYzev2WNQgSk4i
X-Gm-Gg: AZuq6aI+vPC6ZbSYIwoExjtsbJP01jy81twH/HrjPsXx0p/ZlQOnJY/4hUd9AeODvS8
	HF7mbO+JnjJ2bOxr8WZJlIKumVylDVSZDFKnWPpLDr6a91fmdXCMvfq6Ao+bk/bQZFVras9SFK7
	aOFXHTuitDc6K7GAwCfAVMbTSg7a5QUVTF2uu2hHY4tzVveqUC2mWxZ323WSS1buVb7K+sbZCDM
	OBGiz8gR0YUXgZMfwpwC2YMCV9S/XYwDZ57jibJwZYzrjTOlLdXX8cWDgb1BIH/MIk96+8=
X-Received: by 2002:a05:620a:710a:b0:8b2:eefb:c8ab with SMTP id
 af79cd13be357-8c728ad7591mr1412506185a.19.1769939296149; Sun, 01 Feb 2026
 01:48:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201022128.2658251-1-hodgesd@meta.com>
In-Reply-To: <20260201022128.2658251-1-hodgesd@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 10:48:05 +0100
X-Gm-Features: AZwV_Qgr21uZb6Gw6qcoEI0Og8GwGJ1uywAoPTfLxzPls-8511ycqj1xtKmr1ek
Message-ID: <CANn89iKZaoJV-zRLzB7jrrkvrun-AqrN+TjxTkNgrKeB3uML8A@mail.gmail.com>
Subject: Re: [PATCH] tipc: fix RCU dereference race in tipc_aead_users_dec()
To: Daniel Hodges <hodgesd@meta.com>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Ying Xue <ying.xue@windreiver.com>, Tuong Lien <tuong.t.lien@dektech.com.au>, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255589-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B960DC55B2
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 3:31=E2=80=AFAM Daniel Hodges <hodgesd@meta.com> wro=
te:
>
> tipc_aead_users_dec() calls rcu_dereference(aead) twice: once to store
> in 'tmp' for the NULL check, and again inside the atomic_add_unless()
> call.
>
> Use the already-dereferenced 'tmp' pointer consistently, matching the
> correct pattern used in tipc_aead_users_inc() and tipc_aead_users_set().
>
> Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Daniel Hodges <hodgesd@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

