Return-Path: <netdev+bounces-257220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IIBLhquhGk14QMAu9opvQ
	(envelope-from <netdev+bounces-257220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:50:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D97FF43E6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D31E302AE28
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD041C2FD;
	Thu,  5 Feb 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVko8npW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qc89RXCN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE97286D60
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302796; cv=none; b=W0t1PHpvFxIbsWm1uMGWBV01jKMgjB9RO7IDhSwFdmXBXZpBWXKm16iHMGI24Jnu/kMcbjSRu9+v88yn+MWdPLOj0XTVSs8fNpiNwulmU0ZjpGygzzrrPKnFSM16HMCgl6swVtEc5exdzxB2T+lZUWucGn85bcU5W8wwGiap8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302796; c=relaxed/simple;
	bh=MGLs4AHeGuuUiwrTtFVMTK1hvgbi9j+AlpfLaMkfR7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U2uBJ+fczeXZzuSSIgAiyFVnha3210GKv5pmW0aQZy1MHXk7gfuEgHbTJDjcS+05bLHm7GgvfvP6fJKFPmUJr5yVhKMXmWqQ4jZJgPpc9XKb4ArEMunCyhMPEvg3BHOGUGpR+6vF8qAZYt5SULn82TXsePuHODxTJDjlPHUH3Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVko8npW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qc89RXCN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770302795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
	b=dVko8npWVyqtj8tEPlq7V+gGcovm1Yj0e8Uiv22cEV0ltRhdnqc1urDULbvmK6Uo5aIbuy
	Mt371tg6e5OS9Q+jD8RRcgqJ4Eq3wKZUHNTcJLRR8f6DPQDhrn9ukAmwh9TARYj0u5dYsp
	uA1ajEDZsHg6Jzllqbv6GwwrChBFD48=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-esIsZGvVPEaZko5-JK0FYQ-1; Thu, 05 Feb 2026 09:46:32 -0500
X-MC-Unique: esIsZGvVPEaZko5-JK0FYQ-1
X-Mimecast-MFC-AGG-ID: esIsZGvVPEaZko5-JK0FYQ_1770302791
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee432070aso7216285e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770302791; x=1770907591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
        b=qc89RXCNMdyZauyKr5wOv4Wp28KRb1T5evrLNdxZky2oX8wflJEX21vFG/7KhXrtHN
         1r9e2ChPaAT5V0acrce6JDPEuW2yL0lwLrACi3vnVUKUsD61nRjtO9aCp8VO41aBvkDK
         QsTX+uouqNdNBSKqfBl6nc6UQkZtWKUTMDctseP3YHMcyuLGrAF65rcITeoEEvH7RrD7
         IR17/I9OzO8bCa/IMRbSh+P7HKZRM+GQ86SYiaJNdxY9IpmTtgsPUWNjU1IvSgVKI+ET
         939j7dj89wR7NP3eVW8cP9dDKm3MiO4T/gvNie+MJIkzUHVOYL065RoU2SYz7Qo++dmA
         oFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302791; x=1770907591;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oFOMQPyw5rr74qw2CeOtYNKg1tyNBe5jr7LotboMons=;
        b=Wuf45YOYWJlEQB3Hd3C1Xe9BmhQUXLGls4h/0Hv2zDdRw+bpsRnDBJX+7HIS3ijYio
         ygTwUuElhdB4TlzoMRngzPG6E8AQkAha+L6NyiqH1yJ2qa7HbYy8B72yb5WG98t9gshN
         g5GYL8LHyf477WJG77flDxRoefnRb3uvmd2ao5Fmkw/CbQlVUWtDBFaLn2mfdoBWkaw2
         UtvRqOngmweDQhQioQW3BNTPCow+ikj2dKptD+OcIAruJXtxIMl4AD+lkK63056ZFDU/
         4IkZNAwuy63I63+NSXGl7G0V8bXp7EJD3EwfWj8sZi5kFNA24FLOtAnqivfwh7cQUB2Z
         jP4g==
X-Forwarded-Encrypted: i=1; AJvYcCXm+HGc+JQ7/hN4pvEG9WetIk5nWf23TvhpQ1WEPw2EyInr0ij3rGt6AF1a8yMLmcg+dP21/G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlOAf7MnD9iowreJBUmWiOi+Fx2oF74Z07tGKPrlvZ+Hj8LvO
	lj8+Ig4QnbEm7qPOl7eetqdK2vWECAt9TsyNNho2yQvF8QKqWVWTQyCMjFy8UlJ0EiHuarUPgrh
	S58sPgHmyTFVP7989Qjp+HA1jGtvhMAXpmU4CVo7BOTOVVVGjyqTrJ6Sb0A==
X-Gm-Gg: AZuq6aLhO7gu/zQjKIxMuRZSt1A/hGKfOpowInImLFKC3ZjM4ovTeWLLrGg0H8Tphzj
	ecmY74SN0BOkzroPwhod2+1n8umadtAAqvKfGz8i8PRuEv6jsYWeQCzcYX7GOniDjze8pIjN7y0
	yR2gfdEoWrk0ip/8gS80t/qG8jeCQHeTj4YTUpxH68h9gTBqTUpNcDkyNQgJ7g+nRTm75JLgkZY
	8O2Og5IdThaK1HmkylrdhUbcgVcf2u29Hj4hmFgcn8QCr7nf0NdYNexy1O/sFWGnJChxJCf1E+n
	sMdS+CEKhUwryROvVlc4uKI1JvhiRHQdzBjvzlBQLAlBfjJW5aqhGNO9kxAG2Tuy5zsy3hZCMOz
	qyZ9n4eXHQ+zf3FNKE/hE/wrdP4WxpX6fYOns
X-Received: by 2002:a05:600c:4e41:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4830e990b54mr88589015e9.26.1770302791161;
        Thu, 05 Feb 2026 06:46:31 -0800 (PST)
X-Received: by 2002:a05:600c:4e41:b0:480:1c10:5633 with SMTP id 5b1f17b1804b1-4830e990b54mr88588315e9.26.1770302790517;
        Thu, 05 Feb 2026 06:46:30 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f8c1sm12112640f8f.37.2026.02.05.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 06:46:30 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 419834D1165; Thu, 05 Feb 2026 15:46:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Antoine Tenart <atenart@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, horms@kernel.org,
 jiri@resnulli.us, edumazet@google.com, xiyou.wangcong@gmail.com,
 jhs@mojatatu.com, carges@cloudflare.com, kernel-team@cloudflare.com,
 Antoine Tenart <atenart@redhat.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
In-Reply-To: <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org>
 <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org> <877bsr1l1h.fsf@toke.dk>
 <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 05 Feb 2026 15:46:29 +0100
Message-ID: <87v7gbz1ru.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257220-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,davemloft.net,redhat.com,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1D97FF43E6
X-Rspamd-Action: no action

Antoine Tenart <atenart@redhat.com> writes:

> On Thu, Feb 05, 2026 at 12:34:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Jesper Dangaard Brouer <hawk@kernel.org> writes:
>> > On 05/02/2026 04.04, Jakub Kicinski wrote:
>> >
>> >> It will presumably require existing users to migrate over
>> >> but sooner we do it the fewer users that have to move?
>> >
>> > I agree. Existing users will loose some details, but the patchset
>> > results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
>> > which existing tools/users will still handle.
>> > (The more specific drop reason is now avail via trace_qdisc_drop).
>> >
>> > Eric and Toke is this acceptable for your users?
>>
>> I like it! My only concern is that drop monitor tools will see two
>> events for each qdisc drop. I guess that could be relatively
>> straight-forwardly deduplicated in the tool, though? +Antoine who works
>> on Retis to give him a chance to complain if not :)
>
> Thanks for the heads up. We'll have to add support for the new enum
> (pretty straightforward), other than that things should just work.
>
> I'm wondering why not using the drop reason subsys logic to combine the
> qdisc specific enum while not conflicting with drop reasons and allowing
> to inject the qdisc reasons into drop reason enabled helpers as well?

See this prior discussion for how the proposal came to be:

https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.org/

Basically, figuring out which qdisc a drop came from is not possible
with the current drop_reason code.

So it's not just new drop reasons, it's a separate tracepoint with more
information available (qdisc handle, name, etc). So you'll get two
events for qdisc drops with this series (from patch 1):

+		trace_qdisc_drop(q, txq, dev, skb, reason);
+		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);


-Toke


