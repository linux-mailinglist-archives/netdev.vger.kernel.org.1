Return-Path: <netdev+bounces-303917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r7GHMR/SRWoJFwsAu9opvQ
	(envelope-from <netdev+bounces-303917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:51:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9C06F31D0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 04:51:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=oE5Wgasa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303917-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303917-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D2BF30391F2
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1D30FC1D;
	Thu,  2 Jul 2026 02:50:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF230F815
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 02:50:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960653; cv=pass; b=quAhg3CaLzTrY8TymYqJAN7uu0jyexTlVJvPwuC1h9CTBMMu03gL74xIyRuVwdRUU6QDZ32CNKFHUMjl7ID2aEe92nftI3j/6sO7yfcbzg/0y6UcY0mVDDYrNOv9IJtqOYLnwJFP7cevfuZPCPVHQP3KdbFSExn58HzgyYNrft4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960653; c=relaxed/simple;
	bh=ULAe+kjj/NSZzCT2fEehzYznLKXZteqJ+nMg5OARVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmG576bpIEpvEd13BNYgVsS27QuwJvi7u54D0fv9mZ1x7k190U7cvEeb37gklh121SZ+SQN+Ze/HJOc/nKF3KepwNtPxuytF+PLvTo2PtXaDGLXj+tZ3icB/WATKAyPGiXlc1CHxr6PPF1VLle4ZR0HhyzXZmK6e5u2KF/EPG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oE5Wgasa; arc=pass smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9a20f70263so83993a12.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 19:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782960652; cv=none;
        d=google.com; s=arc-20260327;
        b=qt1zukp0VZPEVuwWCCDUV5fCR4K2JZueA3TJ1k7xaRUjdIUrL5BQr+FDE8B0LgnBhS
         p/wVqc6VemLM1ARQYJXN/huuawse4bySkIIVeWB2NP36jPg/xdDD6NW7OzYzNyYcxfju
         PxIzBbTeuObe2d6IeZa403IAAXw7D2UU5JMlIljEs3n8ZWOA3HyphJA/Fn7PKduXHdOr
         FE/5ebmbUBzEvxnje0nTOQBoSoyveEUr7NPl4M17jO+7sBfNkWYikgmek3+h7MEwbt5F
         3hgv27jFcv0aWi/OcBfYNMqsGENq7Sz3/ZaA5Oi982cNdSpBeCzrN4c+5/KNy/3swtEM
         mPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULAe+kjj/NSZzCT2fEehzYznLKXZteqJ+nMg5OARVxg=;
        fh=jPv0bFnARxcWujNrYjv50ujNuKyZh8LkqEWCrD5LmEo=;
        b=P4YjK2KZ5BPgsSZhIZevGMGXhwoJxtCYvP641aetTJYyEndSTRzeSZbQhDeWG5lSdC
         s4/KurveS687tWv+NSaqoofB726WIRoj2bePuD5m+rO3ILcGrLrJ5x79J6V+GtifPsQf
         r/evZ6NXcBVosDRdzRHxw8zXgmoOfbKxxUAGC6MyjrAXjgY8V7mWUNW+5Ktc0HPqL2L/
         wrjmfNWbi2Ga4zwM3R6DsHb1Ii+9MkXPX7RHcR7M/R0/yQlBsS4MZGTSwEQCMiEZic/d
         UtafND5d36i6rvwnXgHSSVsy1eGMdGangVOl8ro1ovVtnSWnxkyuGdcaJpgKWEGxwxPx
         nqBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782960652; x=1783565452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULAe+kjj/NSZzCT2fEehzYznLKXZteqJ+nMg5OARVxg=;
        b=oE5WgasaVZjeA33hBKGuVlUmd9ztR6uexnhQAcyHN0sxuvAfNfzTCmA9z9DeZzlxcB
         YLnIv6GVC0LTZ27hAI+tBWasKbwTdF+f8Ih+J7LnLz4CRdUeqRcU1BZ9XbspkL0DpphR
         kql7o01oMPIK38/yhTwShk610FVJwjjmi6n4jBRWtgpZOb5Qu6tprblrBgQZhZ7N9MnY
         l3zNARu1mBqu4dAJTJal9dulXueDV+EWPEJGBBMDeCDeVKi9C8SDp91dqMJIG3BW936B
         Ui26W75Kvwayq6A+SnjlagAW1b40qiK4LC72O4EJuVFUV00AzOpsyf8IfAY4Iowwt3hQ
         SrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960652; x=1783565452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULAe+kjj/NSZzCT2fEehzYznLKXZteqJ+nMg5OARVxg=;
        b=NyO+JrCQD01zmD5VjebA1JOvemgWzkVGXfp9ozttaN1+gfLolTvhUCmSO1nuFpYJ1S
         ahAucxIG1iqgY6FzNdvXIbbKQj4V0E2woWdU1aLRqdJyAljz88DN1tLpKtb+F7Ytx68U
         ySLZ61kg19FCcua11vdaDZJbMH/CV4JrzXxEfFXNB1ZGoGoK6I614PS0YWVx+YGkbbLz
         /LsQoQLX88mA/Ye2ebI5KDO5/SAwevytmDz9M7186B29aYE/EzRb6Yyz9CCqRkFrru06
         w6OCxrlsKpWQwf5gzevgREXH1h7QUt06Z+d3T52F9+KE+BqrB50So/vZjrYVj63VZF3n
         Y0Jg==
X-Forwarded-Encrypted: i=1; AFNElJ/9yP2w3wkZTKSE3YrMOmJ886pLbnq7yZ3ORUUYBO51jlQJpmWfs438pS8x/RCgOJJpLAGyL04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJD8DLPeK4kCoH1wBiQT5bQT27YsRTwjfZYYTjsN7g5eaQRpuu
	JjjFtR4cEs8JZ/F6+JWZlZ/2wMy0wGL2Q17hL39290Z12hW1ZwN9AqKbPKhjAhz69wrCxa/YxBc
	rWcSVXVxF3r2SYiSc7vpRsz1+Tdk5C4dROwi/9XUVgDwF49wC00Vp0ucmQZE=
X-Gm-Gg: AfdE7clntH28ZH/1B+HGlSEVGD8IELx4ZHny9uU+fVr5uTpa4j5sqI267dYoWfBwxs9
	eCpuijT9J6rxNxr3FXIvAIhyX9DGmJYXUEJist8QXjKuLDlDMYYw0vIOQdZa/2M+VWx39RzNu4G
	XS9mwFaji9nMyJtL0ZRxS/c1Pn5+AckcPo2vq2E+GWydSGaOaOBNZ2V/7jaqUWI5WM9dToS1DlJ
	jWwhmAG2YgDGLW5gohAVH/obuyI1hN1nTu+exD2bGbTf74V514EnMcZ4k+09va661FwPKr0grNJ
	4jKKnjnsykKcykei+MAVlv1e3wabzzrrLVXDu2xbWsKY5Yic9647yQR1W7jZZJcwFKV0YasfDdx
	A0bHKR+SjF+o5TZ33RuL+tJrmLYB3a5O02jP55Mcea5HQrmM73bAb
X-Received: by 2002:a05:6a20:7490:b0:3bf:7032:681a with SMTP id
 adf61e73a8af0-3bfd2870a53mr8590871637.28.1782960650909; Wed, 01 Jul 2026
 19:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701120454.3533252-1-edumazet@google.com> <20260701120454.3533252-3-edumazet@google.com>
In-Reply-To: <20260701120454.3533252-3-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 19:50:39 -0700
X-Gm-Features: AVVi8Cct9RfVDSID6e5RmdiX0CbIVUBcVySujLPUfAIX5m30zHkBaFIquODy_KE
Message-ID: <CAAVpQUC1YZHDhCr=QEdvRd=OERuA3sqMkG8DZHuMfg4Qkeh3Lw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] geneve: make geneve_fill_info() RTNL independent
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:andrew@lunn.ch,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED9C06F31D0

On Wed, Jul 1, 2026 at 5:05=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Now that geneve->cfg is an RCU-protected pointer, we can update
> geneve_fill_info() to read the configuration under RCU read lock
> instead of relying on RTNL.
>
> Also add const qualifiers to the dereferenced pointers where appropriate.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

