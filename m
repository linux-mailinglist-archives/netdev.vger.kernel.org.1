Return-Path: <netdev+bounces-257247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAViCrrEhGmU5QMAu9opvQ
	(envelope-from <netdev+bounces-257247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:26:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65DF5342
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099B03048B0B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036DB436378;
	Thu,  5 Feb 2026 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="de/LKwFW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAdcbhx0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02C0438FE9
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308687; cv=pass; b=HmgxAOMMQ0edeMR+fCG643xW/S3sqF07YaZeUTEjIEYzYc3e9+krUmZGfnay7KFxzWynqX16Hri74oMb6PR8OL9NpMsBZbiJPsbVezYbgvdEnwYj336ck55kNFAhiDIHCpHuM6Vobmu6qC8pyKUljSytsaALdWtmJXBWKAROgz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308687; c=relaxed/simple;
	bh=odNvXPzdKEvCp0BCtgvbKVCz2w6TVfIMVaJ+RANVd8U=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRCqEZZIrSc6lTGe5pGcg0MvJNP3v04upyBQL4fdpf+NF3Itvif/IzfWp4lUwDK3n6LUEJ885U56fc7xJgWVzzlLPd4wRfO1mpXiOOJ8PSXQRdAoNhOlYXxUkPo4sNMeeI104V22jY/v8Tt7uphUcpFV4I5AfKqmpSw/zYsCq7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=de/LKwFW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAdcbhx0; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770308686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
	b=de/LKwFWMs+DMwXS/EPh2hHQ9tV3tuLSHUJC9g8C4gRhOA7MmcAMa+JXP9pRine08cev+s
	L8TnWOB6PFmLxecBU6139G/TDR3RNBo6uztPai7VjQ8V7SCBikbem+BjAgYjHOhjHcCWF/
	MRf95DmbKuu/CvyxY5wmo1D8eIB33Nc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-zH3i3hbPNGyaBuKFVV6tLg-1; Thu, 05 Feb 2026 11:24:45 -0500
X-MC-Unique: zH3i3hbPNGyaBuKFVV6tLg-1
X-Mimecast-MFC-AGG-ID: zH3i3hbPNGyaBuKFVV6tLg_1770308685
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-894709fbae5so40049386d6.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 08:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770308685; cv=none;
        d=google.com; s=arc-20240605;
        b=OMwXXrhDWxozQKRP0n6X8Z/tIQ26lvrJzlA0FXAV1EHq5Flqys9WIFBTBP4gsxjbE/
         O5Wfg8Nb8+M+94m5FRWuIUlnG/xNdICmI0TBAvfiI8qHtqWF8pk73dG33HOzWtfeEF7R
         n7bKegwy/Fa0M2S69xAxAEpWjyL0ZfSTm4w8JWZtCcZUpDipR3Wv0Ls9s0KoCaGANxRq
         lDhjfWSmkHtlrE5oW5+UO0CsBppEcBeUtf8tKYeUZxnRVz7OISUffzWic6oaAjoUqGGR
         uJib6s2Q2ocSNGn9YLJhzwX1yUrqL96ea5dymcKpE08cuia3dCqtkuhuLztlppJsiqwp
         y4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        fh=xQNrM0bbu3+xrfDdor0ywQTvm3rWHTd2IBXjukRuUqM=;
        b=EyOAcDhtXgbFmL1SlOtV/TcDI8GnUconi70v7pkSW8tReshTWHW1kIrvppzAb+9x9C
         CG8xU23TvNAsO1nkAISlvNEwFtIZfoRQEHBudX9Qs157ExegRgIfPHZ8husyb32QeONF
         zaUAi0d9LJZYFOkhMDqEaagrkbYXOHW/ENVqlnPBTBaqlAbA6OZ0zJt9fsuJhuz0PFhp
         +4/OscfBRuW8GgqsV06kWIThdWvOntLi/xyUPH9IAkC2eTv7jDm4UEH4UG7H82enHptx
         OtS7aOSOkL+K663ucj5s+aKpxjLy/ikHc6MbAukhQ4y1M9VwBcuQ+UBwPOSqBpJcpd0S
         n60w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770308685; x=1770913485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        b=LAdcbhx060Aprp5sPiDWtlb8i+WZhnO/8k+cF1UoEXeHc2oi4rxX3H54tcRPyOFYeA
         Z/36EOdAd7juGBVsGBb5wPMrY7HRYJ6GpQG3Uvqf9Z2ziUl7o1n5b32TgnRaL+benfLM
         4P6xZqNxOhNtdsauPZfdxXD7/nMrSz0zNO2oww6SnHSdJvtrNJr6dMKtiyBllLCWSPAF
         2sg5ClSKsnU7+DhG+38Ep5I13kZJD59OeG55ZrlUou8s92N6DE5ualIi/3oYSBJ0UTEP
         TkeRDczvYDWWVIEsn94fE5+yzzxXiGps8X99mQocC6u0QobtW/eQOeV7NBApyqSXWm4X
         cWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770308685; x=1770913485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cthf3UpvR7SCVCTwNlvuIv9lekgY0gGhp/EgpN064I0=;
        b=Y8Kood/q85WsgkY2bGULOJoGvZpACRmE749Yyt3USGjvgX1kU08xCUO0BrOatUEiqD
         Ck6DQ3M64gDGMV7+pvtvAzZe0AfHzMqbVr4EeDrJ3S3nIYwCEB6NLAlykj/BwovsPygs
         N4ndsDzonONycpFALDiNdMZyLY0Hs8BUgyNpRadzNdFRroAIKE3ZjZbfQOmguRdq9iHz
         ee1Y1RRoDMuVAJg87xA+dHwM33Vs6mnkYpgLgGAQPE7G3WaLD8VRTkvYxAjpZX6K8V8H
         lN3RG5PX9+YYb6/b8iZom+TPiL5ImCqcq4utEtoBdQfHSuzQ8aA7F8fR+Dg7TiSLScgJ
         32Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVAd/bd8X5Voxhzc9L6NSiI7Sy1rEqaFrNB9rRew8Hi+u7u1oDDB02YQaHUox/WcOgGiI9edoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3jb169QQppEK/pKFjgDyzakoYfvU32ho4b3Ge/o2HqQIJt33
	h2qYbPREwrVXCWQ1ReMi0xoYabbMho8sbjx661ICnhIWQt9eM90ItDHVchf2sdxYmypyYEQ5Eaz
	scvSBos0FyH2a0WhZgiCKkmBykSiWVqEJBysllKS4P6OkVkJ21pvebdMonp7AM8h3/s/5DToFSg
	ZRTu3RR39vKZpl2ibE51fIrR5LNr6z7b0U
X-Gm-Gg: AZuq6aIloadSoLFAyqkLoxSDcKwi+wj+7tyNjZ3rpueEQ+rdnff9fohWa8YlyB6b0zO
	UaTJt3dEK5BT50Bc2zdJc9K57iZAX2Jp8RlF3gyxYd/PYDWY7/wn3Hu4/mvjfMcBZRCx1ICl0KS
	VuelpmCv3TNC+gR1RIbHwCopS8ZyFvhxqAENUwbpFjZdZKdlENulQSfjD419b/H387C3hA7I7ed
	9K5MTsKC7DDqhq1KFp9q1x7JQ==
X-Received: by 2002:a05:6214:29e9:b0:894:7051:2681 with SMTP id 6a1803df08f44-895221b95ccmr104470896d6.51.1770308684585;
        Thu, 05 Feb 2026 08:24:44 -0800 (PST)
X-Received: by 2002:a05:6214:29e9:b0:894:7051:2681 with SMTP id
 6a1803df08f44-895221b95ccmr104470156d6.51.1770308683860; Thu, 05 Feb 2026
 08:24:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 11:24:42 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 11:24:42 -0500
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk> <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
 <87v7gbz1ru.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87v7gbz1ru.fsf@toke.dk>
Date: Thu, 5 Feb 2026 11:24:42 -0500
X-Gm-Features: AZwV_QhdojdkYOVl1RGk_7Zu-0LDXZBDivdkSb9oE5RRssG5O18zc8Kz5q75RuU
Message-ID: <CADCXZ1z-gg_VsN4kjf325HvWRxL1irhUC76B_erggm5+A7qQ7g@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257247-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,davemloft.net,redhat.com,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F65DF5342
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 03:46:29PM +0100, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
> Antoine Tenart <atenart@redhat.com> writes:
>
> > I'm wondering why not using the drop reason subsys logic to combine the
> > qdisc specific enum while not conflicting with drop reasons and allowin=
g
> > to inject the qdisc reasons into drop reason enabled helpers as well?
>
> See this prior discussion for how the proposal came to be:
>
> https://lore.kernel.org/all/6be17a08-f8aa-4f91-9bd0-d9e1f0a92d90@kernel.o=
rg/
>
> Basically, figuring out which qdisc a drop came from is not possible
> with the current drop_reason code.
>
> So it's not just new drop reasons, it's a separate tracepoint with more
> information available (qdisc handle, name, etc). So you'll get two
> events for qdisc drops with this series (from patch 1):
>
> +		trace_qdisc_drop(q, txq, dev, skb, reason);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);

Right and that's fine. Using the drop reason subsys logic you could turn
the above into:

 +		trace_qdisc_drop(q, txq, dev, skb, reason);
 +		kfree_skb_reason(skb, (u32)reason);

You can look at enum skb_drop_reason_subsys and how that is used within
OvS (net/openvswitch/drop.h) for example.

Antoine


