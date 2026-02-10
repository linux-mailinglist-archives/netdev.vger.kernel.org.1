Return-Path: <netdev+bounces-258065-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEJZNCIbi2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258065-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:48:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8A11A632
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA862303EBA2
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1C73242D5;
	Tue, 10 Feb 2026 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCorfNxP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz6G6Tn0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9A322C88
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724117; cv=none; b=M7wehkq6asWp+kdEHUEGEEX6UMyBHUsnyWNfFfSgEhT1R9RMShPoVQ+5qLO6wDEBvEQzY2+EEr2hHqF2F4YZlWmvqsaZX0fpujYKEIeVta8+xGXUGn+9GRWdL3PQ0+A5GW0OBNyQyzxmuutz9h/OOISQZYIJV1DfvSUkrbqObpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724117; c=relaxed/simple;
	bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vhnf0XIMJvjPLtdNLCEHE82waIQHJUTCdguDRKrGxEoBCAnm+ofL45lUHdxjc6QRtvCmra1TMitKia46OP4ImbJOtAPRWVECKUjZ7KgE8MxzYNvF3Lnyju5NuKdqrCTxV508EoXbfFiGqfR/pd1f62wdL2275tEE12i7iPVoWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QCorfNxP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz6G6Tn0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
	b=QCorfNxPX547T2bHVMgmTyroDbUOoEK741ioQJh8/BUZXs+VRLDMMBwLPZ1QbNj0EvBSqn
	YSJ7sMknAIep1eE/OF1kHWexcOgJTAgT8rfUGNA9xWS9JVduRu0TYXxIwmyqmSdX7KoF5G
	sNPdf8ubMBZzILFSrTbYyOCL0OwAnRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-xUHKe4CbN9qEsYsGAXA60A-1; Tue, 10 Feb 2026 06:48:33 -0500
X-MC-Unique: xUHKe4CbN9qEsYsGAXA60A-1
X-Mimecast-MFC-AGG-ID: xUHKe4CbN9qEsYsGAXA60A_1770724112
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so8036365e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724112; x=1771328912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
        b=bz6G6Tn0WdxlxLBr2Fe3uqpN8LNeqvdMDiIcCVGwUtEQ8t4HE/vOQ/yf5XrAa3on95
         AA+R3tfJLwfb4HEa6Js8lcKs3pTcr6Zyaglt2mWO01Xf83LuZvNK/lu0MGlQnDfUYAPw
         cWsl0gAqvn1Q9g0KQt1aEnd8rd5gwL1DT3Oj6uD1/BxElDeXLpbg6Q3eymRyG84zSdhT
         /IeGDsGLbhQUmnfsxP1qd2pTMSVd223E3RDtufj5MUxFuy3AJ/MhUMmBwM41Mer5N5TY
         2QteTcE8iY3g8kYPx4WJOPSWMfJk9S9RjL3UqQjCkjm4tdeQ2G09wmyZfdtOKt5TOkRI
         f7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724112; x=1771328912;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
        b=eFk1L4DT9nLf4Th/s2Jaqb5qSnznTOZWWahcl3REoh0Hb1RmR+6LcNGHl/FcL4rHAO
         lZPJdp7UnvlCjv8Jr7ZbT6byy3/0RX6jfyS/UoWO4I9FF7iBirbsP8vUZjHLlZCLs29e
         StCwcvbsBK0ZuSu/UMvhv8xF4qj6D8Z82HPyZiXCxht2zWyf1JeFPKFddF9HS7Y0B10m
         +V14xaKN/qq97hK+5+4g23xVGqH1bFDmqJmEID+fv/+WXp01f8mfedvyZtiU3HTrIMIg
         Tho8GTsiFHefMs0XNIceORRFGbZCd6ZHRzFX0wESrkh3jnFraGjA5aW37Oi1/6FvVOlu
         a0Dg==
X-Forwarded-Encrypted: i=1; AJvYcCXVQl2bYX0kXW8kL8cpKjBaKo+wm1UpVq40s+gcDvtXkPdaTJfABGGDU/VwlP2ZgtAJbw97/ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1x7FVaKIdoXsAxYqhclsGIBHRmsoHBfG5Toc5JMJqt6liii+
	6Qajg0BZ5h2y2AHInZRayAfQIjC49Cia+izg212u2eWETBOT+oPt44CP1DP2ZWlgS1KHurx9ubk
	B8s1UwIdfwgfpgfeynXMJ8Yz/6X+yGu3EsK1YXiGJ5neUMem4+F16aib4wQ==
X-Gm-Gg: AZuq6aIvD3YbGHUtnSY4XiwqJmPg84z2OtEKanUsPPa9LZBGnFD5nNS+tTev1lCMBf9
	i9U4x5rmHPvFJqfXX5ehY40rHd/F+7iAMsZrQUD4RnpbFoU75EGFk/PovSdktWhRYqSeGcHoH2X
	78BnQUThiykkI8XSUZpDKzcZolofE2Z/JBBJNGMuiYADo1768NN8Y70Nlmq+HT0EUeQr6iPnWPu
	D7Ejc9s75FNND7OF9EckDFLirRYBM3SwulCEHilKlyRZBkeMhqjQ/CxuQ3NPEZv3of2yKP/8z2J
	oiU38L5xnYfv0UGqVqGL+MBeX26W6luVYYBfBA5fC58pGGdR1dFK4jlDnDb+gNFSoXrY0dDsdpd
	Q5KYhWn9uwin3DoivsWL35o0navzJhY3n4hEAwytBiXihsA==
X-Received: by 2002:a05:600d:6401:20b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483498f7a88mr43201105e9.26.1770724112102;
        Tue, 10 Feb 2026 03:48:32 -0800 (PST)
X-Received: by 2002:a05:600d:6401:20b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483498f7a88mr43200915e9.26.1770724111682;
        Tue, 10 Feb 2026 03:48:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm117106035e9.11.2026.02.10.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:48:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4C0454FE899; Tue, 10 Feb 2026 12:48:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 2/6] net: sched: sfq: convert to qdisc drop
 reasons
In-Reply-To: <177039506943.2258217.14978587773203412149.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506943.2258217.14978587773203412149.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:48:29 +0100
Message-ID: <871piszunm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.13 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258065-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4CF8A11A632
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Convert SFQ to use the new qdisc-specific drop reason infrastructure.
>
> This patch demonstrates how to convert a flow-based qdisc to use the
> new enum qdisc_drop_reason. As part of this conversion:
>
> - Add QDISC_DROP_MAXFLOWS for flow table exhaustion
> - Rename FQ_FLOW_LIMIT to generic FLOW_LIMIT, now shared by FQ and SFQ
> - Use QDISC_DROP_OVERLIMIT for sfq_drop() when overall limit exceeded
> - Use QDISC_DROP_FLOW_LIMIT for per-flow depth limit exceeded
>
> The FLOW_LIMIT reason is now a common drop reason for per-flow limits,
> applicable to both FQ and SFQ qdiscs.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


