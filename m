Return-Path: <netdev+bounces-257135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC4UIkKAhGl/3AMAu9opvQ
	(envelope-from <netdev+bounces-257135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:34:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56AF1EC7
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FEFC300B985
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B9D3ACF0D;
	Thu,  5 Feb 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYPxu70z";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I5E1laiZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6B25DB0D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770291263; cv=none; b=LzfzZlFwTC7XTPsZeeev6HScfbgHGkNV9z5dQw/Qt3Mhir0pS/ivSnS9HMc/1Cd077HP39kn/Dd7hNmVoRMr1qnY0XWYGhEWr72lRtpoRBW/993/Wz3z6MZ4Zu6ic3TTLbkhrUQwErzlIoi1oQUDM0BL7z1CNLBvkIZrqxXBXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770291263; c=relaxed/simple;
	bh=N4P1rTEaiRVoBP5YzqUCAYVm+4YmWUXPGm+5vZ1R368=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aAf+FJdhjHDhC0cEYBmEZw1zKxZI6536txXHPlmWlPdW/W0RQw0YLPYFrsJcQ5IKT0+U7Kw/NYGt8NfdCUScCQ/T6rC3QeHWExT+GavhTHQfDXNIaPX0Nmq6RO0lJ5wKcI6T9K9N2TsmRzizhP5n3autZBpc+z9duolRiE6Y4do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYPxu70z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I5E1laiZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770291262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
	b=UYPxu70z0VTKYYUMmfqUdByc+zwjMrDy1jsYJzwHTEmaaDSdDr5vBbV/T50jUiSnz2ht7m
	pZvB2XF9i6hHhz/MquJZiY4nqORY5ui5fJqh4p20Uv3RVCmBmEZaIlTBQEYnk/tTmf7ZMf
	b1a/RDj+k2tHoD7G6vcczoXoe2HYX+o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-_opfEhjmNqWY5DwUzZ1PRg-1; Thu, 05 Feb 2026 06:34:21 -0500
X-MC-Unique: _opfEhjmNqWY5DwUzZ1PRg-1
X-Mimecast-MFC-AGG-ID: _opfEhjmNqWY5DwUzZ1PRg_1770291260
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435ab9ed85dso761573f8f.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770291260; x=1770896060; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
        b=I5E1laiZ94aNfAKKZeIH0rmuOUXAjqDww9PZRtRKnREnEtxf5pnOqh0Qp+pYlDs1BB
         o1WE23mZGAAerqLFZFJ0p9LjYTyDyon/ideyWtCPkXfGxVIKxTnlO4dpi8nk3z8zE/ju
         dL6zcrFXCEKEBrnRKNIm39G7cE5bwp3fB2iLFRwfG84QFJUJDAskfnsIZ6ZLDN/MfwrF
         hFO2m0TfZBt3lCtOw0Ji40Px4nMdhAzx5/DUmx/ptNbOTAfN7h1qDCL0HAPRiaQumCN2
         x9yCTrUUAgL6eZ3/dSuQcCEoYUpC8WJ/PNM089EZeSziPNVYDfFLItfoKrqE1JycZ068
         1DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770291260; x=1770896060;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZjEzuRz7BplWMcNqxxm3QxaRX6RnMIACl/NvfHd6qac=;
        b=ZeJbKupLr4qlHF8SAOOGLAxsgLLlGOp82MrVGtAgJ4xgmADQgii7qPheII3lWcp0Rf
         t0FYK88t9oPY60S4EOh8MlYNzJ5JjOKqJ3DynLgGB1Nd79IgiRLg9QGYbcnrx5wq7EZa
         CpJAiUzS4G99gy3us1p3eJl+vJte2XRJmuFiUgsVFxZS7i9dPi+8xE7+C0ospYnamIfJ
         7JKjreCWtKxGl/QCW2NTKC9PxYK4YMjrqSriqJ9Ha5qUyxkncg5uOUFzhe3/7n8d6MzV
         XhpQyok6okym/5cYZJ52T6Mcs5Psf9GSjZZzsZqKYQOo9A0bJild4u8eR6yHB9Pobc5u
         RdjA==
X-Gm-Message-State: AOJu0YwqDFRsG9uVCPSo0eFqmv4htwCahTArYz2Cb17UrfyrRv1qhrJD
	YVBJfrTdq64nzut9pTyZYQN1Kw85xHpjgHgytUyU4LZv3W6+BpIGKLSLwoatdFXvewiCgr8+1Wh
	zzvDFiFLeXmDoCU7TSR/aXNjeXUF+wqdzYreV+Y9hyqJEmpGlxv6wEeMKVg==
X-Gm-Gg: AZuq6aJBoIDUUlklQ8khw6yLGmA6xMYi27bna2DV2THmHFbj0PHmbRODRnjRvNWqw5Q
	T6+lFDI3b0yaGazyWUvWLWj7ekNK4YDuD35ioUHQY5idqmYSd5hqixSgVIiZCnRWJV+mEkHQWCL
	d6VlJqCMTPT8NdWglijFLTdoP7QnOq/VjNVnTQHm7DsPmpA3mbe+xZwfp6vSwD5XrnRpblB3GZU
	QS2YVlGHq1i31ipV5ucyK0d3wuM6tvDXBqP0fscEwcKX2bmjg4Mg6vPVcL+OgHhmbI0aGVLZwYi
	67obN9mOqFsPQLN0zfFs0AX/eQUP82/Fws6C2xp4Qb2hT7bs+FgVscoccL3mg6XEg3E1wlOL+CY
	CrcU8Tyo6Y8uq0uLOoPEu3diH7Eu8hzSXzG7e
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-43617e351camr9160955f8f.10.1770291259877;
        Thu, 05 Feb 2026 03:34:19 -0800 (PST)
X-Received: by 2002:a5d:64c7:0:b0:431:488:b9bc with SMTP id ffacd0b85a97d-43617e351camr9160905f8f.10.1770291259456;
        Thu, 05 Feb 2026 03:34:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e25d47sm12473826f8f.5.2026.02.05.03.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 03:34:18 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 27C274D1132; Thu, 05 Feb 2026 12:34:18 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 Antoine Tenart <atenart@redhat.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
In-Reply-To: <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Feb 2026 12:34:18 +0100
Message-ID: <877bsr1l1h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,cloudflare.com];
	TAGGED_FROM(0.00)[bounces-257135-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9E56AF1EC7
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 05/02/2026 04.04, Jakub Kicinski wrote:
>> On Wed, 04 Feb 2026 18:02:49 +0100 Jesper Dangaard Brouer wrote:
>>> RFC: Seeking feedback on this refactoring approach.
>>>
>>> This series refactors qdisc drop reason handling by introducing a dedicated
>>> enum qdisc_drop_reason and trace_qdisc_drop tracepoint, providing qdisc
>>> layer drop diagnostics with direct qdisc context visibility.
>> 
>> I like this!
>
> Awesome, then I will continue in this direction :-)
>
>> It will presumably require existing users to migrate over
>> but sooner we do it the fewer users that have to move?
>
> I agree. Existing users will loose some details, but the patchset
> results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
> which existing tools/users will still handle.
> (The more specific drop reason is now avail via trace_qdisc_drop).
>
> Eric and Toke is this acceptable for your users?

I like it! My only concern is that drop monitor tools will see two
events for each qdisc drop. I guess that could be relatively
straight-forwardly deduplicated in the tool, though? +Antoine who works
on Retis to give him a chance to complain if not :)

> In patch 1/3 I kept the qdisc "name" as part of the enum for FQ and
> CAKE. IMHO this should be changed for next patchset, but I offer you the
> chance to review and suggest generic naming (else I will choose).

You mean you'd just name it something like QDISC_DROP_FLOOD_PROTECTION
instead of QDISC_DROP_CAKE_FLOOD? No strong objections to that...

-Toke


