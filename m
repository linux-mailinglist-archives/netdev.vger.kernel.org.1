Return-Path: <netdev+bounces-251829-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA00EVujcGlyYgAAu9opvQ
	(envelope-from <netdev+bounces-251829-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:58:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA9E54CAD
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 10:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D738893FC
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874543A9D82;
	Wed, 21 Jan 2026 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jn0f4eUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CD547279F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988598; cv=none; b=BKxPzI1QqUDrvOsPiK6Dp005bnsgVWq5D2YT9xBabvSKGt2Byes6U/1wVs21g4sNqK0ZXBixosdAwaNfnbvzG9PR0waQohFH2ms0381SxCA7GFnOA/AlspvHUDQPRPXrld0mpJSia8W+DkUlJe00MYpPXmYIavYp5hZUFDSFOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988598; c=relaxed/simple;
	bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jkA04NZ3IDQH1qCgiqvUoirxrjFlztqLCk7c3uZdeOuC5afTmiEUy1e4t1u9SBI2INaSdCEVerkeu8HhG3dARC/sUm0OopDCtbuUZZfRNpS+lJ0gNhgDHVMS7t3QAEHLBZ6IJWodvbSEKnN9twKq333cDMErAsQeMphO2xYONRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jn0f4eUf; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-b8768225837so901791866b.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988595; x=1769593395; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
        b=Jn0f4eUfUmBNLPEV6HP65smxEVsU4IBzOkKsosX70uLJpdVhbGesuuUglaRQ6qIy6x
         oBYVupubj9y2kHD/3Bt8bHJxbrO/ROO7lDaoAABkHnrSEZ3m2yMh7oEwP9DVp4W7awDg
         YGy4jUe+n7ErMXHh8OPx9gcf0Ria2Un2n10Bby9Xfmz++/a+eeBz84/fgxpq8CCO46Zv
         WxsTfI9ay0P9X0V6/goUVn7CQXfvskQEZsDh6yFg7QcWcbAxmSeqYc6DkwXF/9HF0BMl
         15YNMgRGu7rOd6QXBiHErWftqtcJUyttMxIWJgnSpL5P8xTxOTOFaYKqRc1+dPHk9GLv
         CKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988595; x=1769593395;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
        b=hSDo6XiYjZQ4VDIFQL0oiwnQayd7Z4WlBSRCMiCsIMXfxZn4nwPrTVkgv/tB/2mXFG
         usNcz1zp/MaGIFsuaF9LjJ3cwisQaKDkOZEGQYWZQiZgHbUW7h33quhRIn51oGKjr9jv
         w332TgOiqAQYR5tJczKBz73yo5LGgkVdDaQ47A6hvecvxbtN0sJZXCXlBElL1UVniAFy
         gnfc1LCW3Obuxu66yoyALH0DAs3tAVJvaS5dh5hRRR5nxArYvmYzrY78E77eq92KpAis
         frmWhYAJVcB4CcEg0wbm56tHB14sViyiIeAcGt8E7BUtdaXdAznWTr+E3PggVYEbwgM2
         72tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCvRtzsJqbnY08iWXqoaWiyXbpimpdoJGtK1lm0lZpquFkV/qeJRvtLfRSKvlGcJYNug2Fw+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyi2hIOuN3Eqs2NTib5xUuXFrUgbN0Al3XWhgSRn70WMl4MaK
	qwpjA6A/Oqs24w5odCF/NrfgjL62wn84bc6PfYpxIRfeXIfTPAc9DoU6ngErHL/eVkY=
X-Gm-Gg: AZuq6aLPXX0YEbTPPFahr4lTt5Yzq10nEKAYDbWnhei4FL3h6yBghZOxsjqXolJNTGo
	fRR1tT5e9GLoej4fZi+7+KMfxWGT1dSm1FZDmtD/3G8LQMy512we+Xm8dX3MuO0WQNVFQgsaEJQ
	a2qJMRtt9OLKdK43b9euP4gr8fySyh5BtNnGkdhV+SeMAtwxSPI1aEhknbvyWpVlCFDpIJ0vTar
	ZG9XnopvLL6/K3tpgtKw0DX9JrytvQJK2KUfrzPkQCLsbcTc6NSSm9fHXnsOJe9Q8rWqXXSdOp1
	amtAWsF5n13eKEAJovia3qk/cykPCsK9LxXibr0SLTkEtw5wvEizYQqLRZHFNr+x4uLP3UFXZuL
	tI0iQX6RAZcwdlfAF2I6Bgct3wzQ7MYFnOHiEQzXkYQOl8z1E1mOQsgy4//1r1lGh3LUeHmFpv+
	6F4g==
X-Received: by 2002:a17:907:930a:b0:b87:751:6f21 with SMTP id a640c23a62f3a-b879300b515mr1545567366b.36.1768988595143;
        Wed, 21 Jan 2026 01:43:15 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8825616964sm25011466b.46.2026.01.21.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:43:14 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,  bpf@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260120153807.gzwnhxxtcocycfmr@gmail.com> (John Fastabend's
	message of "Tue, 20 Jan 2026 07:38:16 -0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-2-jiayuan.chen@linux.dev>
	<875x8wuy4e.fsf@cloudflare.com>
	<20260120153807.gzwnhxxtcocycfmr@gmail.com>
Date: Wed, 21 Jan 2026 10:43:13 +0100
Message-ID: <87wm1bti6m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-6.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,rbox.co,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251829-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: ACA9E54CAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:38 AM -08, John Fastabend wrote:
> We could probably push this without the 2/3 patch? If we are debating
> that patch still would be good to get this merged.

Definitely. But also see my email from today [1]. I think I figured a
way how we can make leave FIONREAD in a better shape that it is today -
with what Jiayuan proposed - and improve it in the future.

[1] https://msgid.link/871pjjux2u.fsf@cloudflare.com

