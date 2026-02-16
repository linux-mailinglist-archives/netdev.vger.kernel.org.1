Return-Path: <netdev+bounces-258820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NIiMnlskmmMtwEAu9opvQ
	(envelope-from <netdev+bounces-258820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:01:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80597140854
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 004BA3001F8F
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538FD25E469;
	Mon, 16 Feb 2026 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UM4uI4Ai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B8823D297
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 01:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771203694; cv=pass; b=mjQDBabmkIZu2yCRVPZVlK5MKR3eDP84ytmHHh5o+BIAbLx79ZvkN1vIZ9yMtPPCIQtZQtcRxi8ZjIjP8coc7XRPmF5DKnHwm5arb18zsWN+EnmX5ipGm8P3d4d3l+4VW73Hd3mcumMpFYLlmqBNGtu77LEF2HLu1UUnSueeZvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771203694; c=relaxed/simple;
	bh=3QJtMsuXIyHxsWHKvmz6MS7kM7/HtKdkOLAi01CSRp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEUOkPVItqHII/jaS5VN+4OXDD8HKPp8oa/Hxt01IDtjTENsVmM1k8ZlqQlJT/EnOrxT3JCoc2txlfSrn6gfeIJFqufgZYSaW47SKkBrNtcNu+goko+iQAWsqZ1QhJKeukizNICFadRFdjiegIIl64fmdHMmOL8N0cwfRhTjSoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UM4uI4Ai; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1270be4d125so905748c88.1
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 17:01:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771203692; cv=none;
        d=google.com; s=arc-20240605;
        b=bqMvmOPoK1/uP+IZw9Pc6TggmCXaE4LqU4cDiiygD4qkLV5PvrxkSphqPPlUUhGDCS
         zQtr+25Wi7/h33JyBhzlbLoykkgBAz0cxoQWi6e4WEMo4ElJIdQDASn3hPh6uWXTuhu3
         IMUzcg3AiK6+ifdw0KxPcDM5t3gFSfXLMBoGDPwQJsxDJOWXn+2Gj2/n96NBsqrDHGA5
         0205HgOxY0Ydyt98QWuEfui0IHbxq0ZXwZKc4/e7M6zTjktSmVHrlUwd5SiV99+Fva73
         osYLWtHu67oa6u91bIFPpogQRHV0lU7QnIz0uxJ1/LRMoA96a1IEAlQxIa4bxmQLD7ui
         VYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QJtMsuXIyHxsWHKvmz6MS7kM7/HtKdkOLAi01CSRp0=;
        fh=xiH2+MUvP9khMu5TaEMhSj1Vgp0AN6nSmSRc/Wocbms=;
        b=GH3zkBLRRdu50gMLPfgiTdUQnp0onVkFflI/gt2pAE0YFsX7vW20LcH44NvKaKoMTx
         30t7L/t7sSj9sKbgcyVGuJjrrTZ98j4SnSNezo41rwRAhDAdzeZISxGHFEw5b3jbE2W2
         lFAAPQcwAZ+zsMIiCplGMtJDy66h+7iaX/3hiYxVMiYaBGM++6Xm7HozOcwWVcP+lahL
         8LzXH/ZL4low0MsRqRLmckpZsCBWqmDkRnvkyc5K2X8LNt1nblciz88ZXN7/qbO/GCdh
         3rJ0LXnIfviHE8KAvPEeum1GMU36WRbUnBIXsf5SnaZCsdjpiSkQadknuPE2wCMBWseu
         56nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771203692; x=1771808492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QJtMsuXIyHxsWHKvmz6MS7kM7/HtKdkOLAi01CSRp0=;
        b=UM4uI4AihxLXBf8PqLlQ0IhSjPVY9Dv8gZHGdFdxKjKct7plqveRh1VAIsk/BZ0+/H
         359RcaLXVoTG8O7FdpAodTZdeRPKKORpG70A3ao1xrvWLRazuBvfcpxsQNHJIKXq8jJv
         hl3+49Ktqlz/cOt8XGQAlJHNl6YKFHA3D4gkHANCevdGbL1F8BeSEmzJBA+7nb8IhNG/
         0j0vDmrwL8xNf532VPMCI0nAvbEz1hv3s/1iIsBxhJW1mEgh6XJxIjAfcJcXtAr2dkGv
         GJPp8WtHBeY0uar4quGZEI2kTEPlRo0eU44xsJ/noUJQ2sRNS8UMm3C/KRQQilEaiUV/
         reQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771203692; x=1771808492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QJtMsuXIyHxsWHKvmz6MS7kM7/HtKdkOLAi01CSRp0=;
        b=rAHyPAIwjTR58f+BRuQ8wE5FetEdVbjaOajwbZ7KJt1bpe2kAz8pedSyEwKC0nS/jE
         0OuE8UvBVCROumqM677xd7j+5epOZ02GdBk5LLyZrXV2yemus3ekw4/KCd6gvJhY93cq
         wYblQG/g9LgBWrPHEm5BiLQhz6zQK//0HVA9sVxcy3W1Ci90sw24MTNUJLz4zkjZCVDd
         NHWopnlKC2wyp0XOJJlPlX0yhOQtAozRrrNbH7r7e9mCl+7+DCaP4PLqshUEqjRvEBED
         YwGeoQkraVm+ANifLvqHAxC8zFiAW6/sk0dN/Z5nEB8vudmpCJnsGMO6Vm7xh0o/sEPz
         /kYw==
X-Forwarded-Encrypted: i=1; AJvYcCUnlvzh8QgBDFR7Eq4X+lHkK+GVJrGS2aF+KB8CgXEMGfMn4aPKr9Dg0YI7XBDoQvSh+zTLE/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHeGhnK8sVZYJaWZ6E67XoyJ4L+jByd6fURzPpMX9Zx/VgjuX
	llHTZ10Cb5DfRHTZlTckmFHP0djXTaMEycmx5Zac7xtyG9lmus3JvV3kL6KUK+FKoELVWnkLZea
	UgrIynUDfKCWIFNWCkSVPn57MGO0Zhmq6Her/QLO5
X-Gm-Gg: AZuq6aLm4FsLUCuT8pt0o8zrQZqbuqXL07orj8YzlPJhRBT61PKX61YN5PdAHWPK0XF
	Mj90289IMa+OTxxbVuEJ9co/XcqnVYNQ3iNYbh/dLIvEy90aQdysAqpqAg+Dn7OjK+WATeuU4uN
	d5I4ivWXYAULOhs+Nz2fFekWKmLDiLsejZVOIGzaAxwg7rEfeH+ooKPZB8ZhV4u+SxjsFTqYSDR
	oGUnBsvzejWLI2eG+Ba3/jKQ0pzTzB57VsLK02r5IQpNTqd9KcaIh1dpS/gtiZiZYlGAFLyN6/H
	hxVlD4gPKm4WIGHrmHWv5xG2/3d79M8fCX9PmYTHYpQW5VvaERb8Yu/j9d9YEldDhi/+SA==
X-Received: by 2002:a05:7022:e1d:b0:127:3214:c868 with SMTP id
 a92af1059eb24-12741beaa84mr2621764c88.47.1771203691768; Sun, 15 Feb 2026
 17:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com> <20260215143821.2330791-6-edumazet@google.com>
In-Reply-To: <20260215143821.2330791-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 15 Feb 2026 17:01:20 -0800
X-Gm-Features: AaiRm53rSv82T5FmGRIjBu6OkkOFplJKEhLOdop6pdkMyNgzMhqr8pmNNWT1GEI
Message-ID: <CAAVpQUCt9R2=0UpPJioLTd_T6Nb5zHsp-qfF-CJCQ7RPPbwcNw@mail.gmail.com>
Subject: Re: [PATCH net 5/5] ipv6: icmp: icmpv6_xrlim_allow() optimization if
 net.ipv4.icmp_ratelimit is zero
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258820-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 80597140854
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 6:38=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> If net.ipv6.icmp.ratelimit is zero we do not have to call
> inet_getpeer_v6() and inet_peer_xrlim_allow().
>
> Both can be very expensive under DDOS.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

