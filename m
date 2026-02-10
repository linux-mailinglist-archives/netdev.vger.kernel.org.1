Return-Path: <netdev+bounces-258067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMmBMBUci2nSPwAAu9opvQ
	(envelope-from <netdev+bounces-258067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:52:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A8911A685
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EACD230387EE
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 11:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3680E32471A;
	Tue, 10 Feb 2026 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ad2eP7z8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz0EstAj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D46319877
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724369; cv=none; b=FwDgn4GDxhoxWeMNktYiOhGYAIgYZf+XRp+IVLY3yqF1e35+shcaUgkeT4Nh90y4X+lXwhUHJF5WCRwHNEUxx0Pf8IW1V1yHpiAySgYehp2OyEgkluAcabPfG2yDQX6yMND9Y/KsIgaVCIeaNU+AKPaREQmwfYUNtzyAyeRQEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724369; c=relaxed/simple;
	bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Un93cQfGF7kGNgIO0yMORfzNMjVOeaMY+HSyXoq+9ROVi9IWG+dZy3+FTzCVCfytWOWy6tVv9AjGElN6Fvyu9iXozZxZCZoIMyIucA1RllvzLAx18z4LqITYML7z+567MoSUNzTLMwzHwy0xbunocwwEhAKtBATGxw9MyG7KwvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ad2eP7z8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz0EstAj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
	b=ad2eP7z8hUrqXbSoEg7CbcgV+G5fwsv9NkeBun7553tf1SIjDXgimlD+B0oiDhWwrvTH+6
	hcIA69jl3+5KFBWtHOsnLULt13LXG3q4pjCe88VFsQuKQzR2n4VJ4TcsWx9ZOdCTD913u/
	EcYVPHtemu/6Qjot49wXCLyiMn/UHXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-5GXhMt8kPm2MZmDq_C2RBA-1; Tue, 10 Feb 2026 06:52:45 -0500
X-MC-Unique: 5GXhMt8kPm2MZmDq_C2RBA-1
X-Mimecast-MFC-AGG-ID: 5GXhMt8kPm2MZmDq_C2RBA_1770724364
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-436267b01c4so1057180f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 03:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724364; x=1771329164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
        b=gz0EstAjSgb/A/c0NxftkudgJS2mTPC59CO0nWTFFL4i06U4Y/z2Mh1VdS0tUVH031
         AurvhRpVN76JjLEHola5zdVwVLA0hXOeA2BmXPt6eVwYETNlo1okxwWkkQelOTO0S/GP
         y/KfT4K+O1IDOK9mB+l4iy6O+zzGDSwlcLPGqsA4fjso0uANMiALdpOdYZA++xBoNQFL
         y0xfzMiY66ZbaoCEyWgSsfb0OmSEeUyueIs1FcVSomNFumWwnrEVNqUTv80gyJvKKsJ2
         k+ZP1CDbjRYQac222tj1+gH5bZuRaShF3zpDKme1RVaKgpeIsxm3HHz13hibO7NVSLqW
         8AtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724364; x=1771329164;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P48qg3jKPnmERmoakEJVUtELIvMvEEbPouz0SxqkUM0=;
        b=b3Xv2yttkBLVlnBPkvDeNhPwcIabH8rCENtA2h5Ii5QmDLaOdnmzEF7B38+JWD8wo1
         R4gV/l3j6bEguKE9wI+3PFcB5yNzgF7szZ6CX31h9K1qcuxP1Wl4wORJgicvFOWLSQPx
         Xvr8nw+jun4sRJUxezX4v+SnehoEcxSa9fRuQW3wriXItL55cJPKaabyMieNj2FAC/13
         vfu1KIBJ/GDGlUyBLuRdtk1x/clqjBWcq5G+wvPOOTvADN/Tb6Y1WHJKhKVe1en6FhN/
         niDTxBUAinU06jT2Kh5QmSQQwFFGs64bE5Wfb3RX6wW3KeBdj/WVhOg8+IjEjJM/h9vm
         lg4A==
X-Forwarded-Encrypted: i=1; AJvYcCVaBF8kJnkuJUQ5U6L6WwvV0BjcznYo806mirlPwQC5zzViKtX63cIbi/3ex7EKORayzNm7nX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSU+/rNbfpTF3IbSqWKiX4czqrF69R+mKsIrTiN9CXI165rE/
	m5pmckzKQoN9NuxhlEV51apPijisb0ilEejfMPnOCxUuHogbvA7RcbdlFXXwobkhWa6O58KBZgI
	s9MlJ1zihe+5zaHvvQv0tPQQO9N8RLHkcN8uIX+BEL1o4CC1uD8dfy+eD4A==
X-Gm-Gg: AZuq6aKxyTSYUi6YAzUJvabiSjYNxLaXLzr2ijR3cz5V8o/nqh6tJqMgyN1GjEPWEsl
	j+zzjVXvY14hoAOzMAtpBDxiad1EivGJsMcA5ENFHrFiuMl6S0+R4xb+5PNvxdOgZw2HByjenof
	RtVVfM2zrPOcEqv42SJKFRmgijzQIiD7ij/EZfXoOAQvkT3aUOVtxzy/v3CmiCo68jeqVHY63vi
	Dnl43tJOWZCsiI3Ln/gXV6rJ7z23FM1AT5bv3bIT8BksZKzxs4dat1zlS+WNL4/cqPheqMAva5T
	PUYM+UYkPCUrM9g/rh33deXV/AuGl0PsCBziqNJK5AHkefUVZ/49CtZ0YPyLe2RBc7gJq+HqoL0
	Ql2v/dndIGgVYzMf4mMcc0lkj4nLzzQ6YR0v5rFBh6ZS8tmrT
X-Received: by 2002:a5d:5d05:0:b0:437:6bfd:c3ab with SMTP id ffacd0b85a97d-4376bfdc733mr10540277f8f.51.1770724364245;
        Tue, 10 Feb 2026 03:52:44 -0800 (PST)
X-Received: by 2002:a5d:5d05:0:b0:437:6bfd:c3ab with SMTP id ffacd0b85a97d-4376bfdc733mr10540238f8f.51.1770724363769;
        Tue, 10 Feb 2026 03:52:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm20713414f8f.37.2026.02.10.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:52:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id CDE1E4FE89B; Tue, 10 Feb 2026 12:52:40 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 3/6] net: sched: sch_cake: use enum
 qdisc_drop_reason for cobalt_should_drop
In-Reply-To: <177039507595.2258217.4088231078326234454.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039507595.2258217.4088231078326234454.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:52:40 +0100
Message-ID: <87y0l0yfw7.fsf@toke.dk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258067-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 38A8911A685
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Change cobalt_should_drop() return type from enum skb_drop_reason to
> enum qdisc_drop_reason to fix implicit enum conversion warnings.
>
> Use QDISC_DROP_UNSPEC as the 'not dropped' sentinel instead of
> SKB_NOT_DROPPED_YET. Both have the same compiled value (0), so the
> comparison logic remains semantically equivalent.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

So before this patch (but after patch 1), we're basically assigning
invalid values to the enum skb_drop_reason variable? I guess the
compiler just turns everything into their integer representations, since
this doesn't cause build errors?

I guess the only way to avoid this is to fold this patch into patch 1?
Not a huge deal, but maybe that's better then?

In any case, for the change itself:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


