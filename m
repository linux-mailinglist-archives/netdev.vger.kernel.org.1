Return-Path: <netdev+bounces-271927-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJaDOczvxGnv5AQAu9opvQ
	(envelope-from <netdev+bounces-271927-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:35:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 703803316EC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 09:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5E5C3093BDC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 08:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB00322749;
	Thu, 26 Mar 2026 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVNhpJXI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB42036075D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513597; cv=pass; b=OUweKn5po1TOra7rZkALmRqKG6v8K7ujvYLiugx9L3bp4Ks/KyOVOrmnwgvdezPFkZrivuZwWefGM6/mRVSs95aJHPxS7p/gZADNz0FMGvjC9Fz9+8T/1gYz+RuL5weMWrXukjkO2fPLodljsXvW9nii7s3Zkzty/kZ1ckP+Bl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513597; c=relaxed/simple;
	bh=OJrTyAprx+F4u+3CkvC3F7RmtUcy+qiuWiiriH2dj2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7nO9EVTcm0gIhvxGWMEUTrdLPKQLcdBL1tY/33jLG18jj2lSxRbzfgualh8R3NLceY+gxHIWLpwXWf4wG5ZgRCJueKFPk5AEGW93dWbd7goTuDPLTQc8xwEJ0UFIuEeouMXS2pmnNp7a7QHdXqeGx274VGTFV9krhNMY09RMDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVNhpJXI; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a74765703so6284957b3.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 01:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513595; cv=none;
        d=google.com; s=arc-20240605;
        b=eYGMXKdXiZ4s+S/ZXplrY3cNb8aQ5d6S+BEGEmDb5ldzxj2Sk1/U/O1OGvvLHSXLr9
         WzZ7zZE8zLRnoUoKkSMXADE+5tfLPstXZfUpIx2nojYgz3ddbdhlVsvSK3kV3SP9jv9Y
         fQsKCSh0sIF5Qpr/WgrRJH79c+8sEtReEZNpaNpoBWDl6CKyvjazCZPzA8jwKCNAMCKy
         mdZ/qeOVsRX+MQtoUrKy1cCHLpRrAeauvD8KzTxWXgtmroFZPwJhd9jFkw03XC9vMv1w
         5L+42pxLV6AL3kQbkFyRsKZzdRDtzBDCMe29aD56g2wGxlNA42bZGrI+ufHMmU97Ayjb
         QsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJrTyAprx+F4u+3CkvC3F7RmtUcy+qiuWiiriH2dj2Q=;
        fh=xcVVD7/KBKCT96V5Ong9ZwIeSjvFBsjYvZkt+IaLkq8=;
        b=SpsvSfemtqQa1vF6BBNbnSps5gPI3B8C2z0hGK7ddldxFBDUxjq8zob7I60XVU0lNi
         wzPN/mjYoOOEzSU6B/OT45QGy3pE34EmUueiSxA4oelyk2PpXEndL17xieS2QH7T+htc
         BRJZsDxYrckQJA2z4O4vD+S4h5eXrRg6lf+4L7G7/tS2vEnBhMjzyZVpjlTafa2zUUBz
         lfMfhFgcIJCStZ/gwswrBvVw6IH/2eYWSYRBMKNA08hgtIoBBizReOOyaKZLlXuKo0T6
         TqFGE5YS9p6131hG4wqBNezBqm7SmTBIpoD9Wlx9X9USU61aAdyYRWJf8hY/YA7keJwT
         kN5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513595; x=1775118395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJrTyAprx+F4u+3CkvC3F7RmtUcy+qiuWiiriH2dj2Q=;
        b=EVNhpJXIzS1Wo3JWLqs8C/YYXDrGugVOxfHsB7LYt/UWt+II08RRUnFmWCdPZRYCRB
         fjtzgKMO58j9g6uQ9wNkhwo9pDWCrjpkUdf/Wxdnrv03YsvOYS4iEV9OTw6GR408vy5l
         NASTZhPGLxd38RPFPdpl0xgh2v18i17EUifz018WADrQ+vAfr60VHYnnVBsZQgMfs+rY
         I2TpltHQkDLNOWYyXchuDQVXhwkHhAK72PDbTdpcC9NRycvj7S+yA9szRu6mQ2TvwVbL
         nIx8j0ojsPMQ8tD+w09vfGU9VR4Kpm+ODVpfQIex/A1aPWrPCFWtSZe9rTwfzmZHW1RX
         4b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513595; x=1775118395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJrTyAprx+F4u+3CkvC3F7RmtUcy+qiuWiiriH2dj2Q=;
        b=JB5wYjOGpRGLTtR7QMZmDHKNgfUKQ6hKwpOVLoJ17rtflNvvgeSDJjuxUCe6Lpn4NI
         o01cIIbyeKxfgGcQDTK8Nk1Xx3eGkJfM/ITlQxP2cl1RUEUDqpJlMQR0qk4M+1xFoqym
         Ft7hpwjmxGYUqRplRUPklf/SGWLG4qAwW4azul76k7PAnkHNCsv5tfsQpntyfV/7UcQ8
         8LaCaC6CsGd0ZFTxxZZ/kN3NzuYML6ZXws/QQw8WaVTcCqbFvHSvqFcb4b76PZySmfEo
         gL0aOTTBIEQPqYTku1hvDFAnXMGGXeYiMGHXYJ61ApHbzcTpIwV7xrL30GiWP/Zx0FH6
         uZDA==
X-Forwarded-Encrypted: i=1; AJvYcCUSCQwTL9X+hnEWHYNdIp1Nb1E+b7G3DWUjM39SBUNR7/zTV7cxHTaVegOJvDM3lRgrf2O0ua4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThU08QfP4LTDwQ77cEH0BlUPuVWPc3m+oXpAH1wqyeCfmNx2Z
	mRWYm4g1K1oMUkhpexnvED+ECu8JD7IJZeKtWYzW4K76xpg+IiWKC9kBFj24EBxZ8BoCyNuwq0e
	fK6As9ZwtSUXz1xbVAfEm58AkJxpmAPE=
X-Gm-Gg: ATEYQzyP8FXPNqBzfG6K7RcDa7SUHmAonQCTzTsWhjAjzPqjd+qDIZC7xDLO/ZhkW1t
	fik7A4Dk0iax07Ha1piVS3xb/U/6itp3SAYHy87RblgJPv+YO21wqEdtIIqu3FtMO+WO1JHWaKt
	lc+nUmgQ1gbV0vMWAmFbFz9Jfic4bQ8DHVjk5BPhW+LL1TpHGNs5WYO3W5fYNIwsZB7TsoXRwDp
	bO4XNJu9COZ/rX4jBrm1nL9VWd7zbjIu9JI4uymkSk7ak0RDamu0Ls+INkb7RoSqpUmUF7nXxe6
	EeJZTQ/Ufioj1yV8DBiaOWQiUHA=
X-Received: by 2002:a05:690c:a:b0:79a:b983:b44f with SMTP id
 00721157ae682-79acf2e95ccmr68192227b3.5.1774513594860; Thu, 26 Mar 2026
 01:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326021642.29170-1-dqfext@gmail.com> <20260326081304.xKa7-s_1@linutronix.de>
In-Reply-To: <20260326081304.xKa7-s_1@linutronix.de>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 26 Mar 2026 16:26:23 +0800
X-Gm-Features: AQROBzAqSiYwDVv-JZ4YazMfucMB6x1v8l0fzYVRYEFWN75xZh-iD6Nf7djB4VU
Message-ID: <CALW65jYdzn_rZWa2zwYd5J+Gd=kyaGMsVFyX0fMJfKfgULMO6w@mail.gmail.com>
Subject: Re: [PATCH net-next v4] selftests: net: add tests for PPP
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Felix Maurer <fmaurer@redhat.com>, 
	Antonio Quartulli <antonio@openvpn.net>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, 
	Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271927-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 703803316EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sebastian,

On Thu, Mar 26, 2026 at 4:13=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-03-26 10:16:24 [+0800], Qingfang Deng wrote:
> > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
>
> Oh thank you for doing this.
> I haven't look in detail but this cover the "invalid loop" cases that
> ppp tries to catch?

By "invalid loop", do you mean transmit recursion?
https://lore.kernel.org/all/20250715150806.700536-2-bigeasy@linutronix.de/

AFAIK, this can only happen with PPTP or L2TP, which were not included
in this patch.

Add Cc: Guillaume Nault


Regards,
Qingfang

