Return-Path: <netdev+bounces-257200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG6BBxWmhGmI3wMAu9opvQ
	(envelope-from <netdev+bounces-257200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:15:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80763F3D8C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 15:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC003008762
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 14:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40B286D40;
	Thu,  5 Feb 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfgjRpA0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okDMgw9Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B8200C2
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300927; cv=pass; b=K03v/YvRm9l3eFNWH6Px94WgGJGZG4LDQKfN60iiHNnZZSbsiy60Cbv+017JUwim9YL0nvzihTyYM9homJnpyZpcJm0As7+Dzz8tYA/byFalKV4zV5jJKScsxw81/9akauLDY3zGQm1Mu5B+iGrODE5dV26qgGWZ0eKN1qX7xHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300927; c=relaxed/simple;
	bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf/5fJpSR+7wQXfUc7MVh6LXVA/weGq9au/9dSN00lm/Se7cizwUup7aSD31YEwCmBeHgHW3iCzYzSX4r3bBE3hUPFh3KguW0T8eG+t3xBPSAg50Nr5Ul9vRmE3TgbcuB4Vqnkfk2/P2Ub+M0cvjZZRl/6xVsWWW61WbZu81Hns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfgjRpA0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okDMgw9Y; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770300926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
	b=KfgjRpA0q0vIZFGG02yedlDbq8DC+PdpZrIw+QfzplRqA+6iTk0bUKS40CbY0gRfaf7SP6
	/sjDc3JMPhfXIB4ZjnZ1Pl72bd8ixHrr+brTqDDHzLWOmyspSjz+S9Gzk66/3vGyIXIub+
	qzwQsESmz11pPQCpsxO+B3jP8kYs/Dg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Hrji7LmHPQSDl-eTdSjCZg-1; Thu, 05 Feb 2026 09:15:25 -0500
X-MC-Unique: Hrji7LmHPQSDl-eTdSjCZg-1
X-Mimecast-MFC-AGG-ID: Hrji7LmHPQSDl-eTdSjCZg_1770300925
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c882774f0dso263583585a.2
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 06:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770300924; cv=none;
        d=google.com; s=arc-20240605;
        b=JobY/L/WKQKrqlyUCctP5no/5CVX4ebPrXU+zMC06Vg886yfnlXEElqM9o00EkZAxp
         B9+inmDNap7Xd7h649h3MG5Vt9DkOJC2Tfpyxg6ew5uAPaVaUArEXPI2IsGJGKp/xb97
         +c10zmtjrfN9/7uaQsugydVOd1N07Dwi+l91T0UVD5wwRK+eYKbQFQWqBxlGoOKv1GpW
         BQPqF93Qw5SEN1ZvCzNxiAPx0PHADxX+/jPSUt5vZV7LycAPAqhLUaSC581Czztp8qwJ
         c7dfvOoB+BVoFpJgA7nGdpEB/JCcRlxTl+ounOclV/l9pOzSQjNUKfvimAPiL4rBG8o3
         id2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        fh=rRoeJ7/C5Gvd8/H3NFhcUTNEt0RuSUjLuDYjDTv+wcQ=;
        b=QGgbjEvyfSpo6mA2/RikrLQ8Ob0XKDmnsrFcu2HOl66mlM25/TqBulSVfZwC+OrEXe
         r29IeF9nJq7OxAmluVWUcbF25CBslUbh0JEjbjcU/8QT4qxAmTeiZbeZoCMAHWC2jaws
         aBh4GQ8S4KV6oZScRqtaf6QP78me4utWSRQXogMI5stT+iRzZFxM7bGFlH/Ntzdo9ukM
         hHehtK5nhQGLgjX+qY2imGMmpZxQ1gX4HsUOoY+RGA33xBQSWTWeszfJd6QSAM0auXcZ
         chPPZRS5dYP/rwmwlxlrnYw9XGyZsYO6UR2gSuDpPj5WP0ydG6g1Y2slepeECBqj4tTM
         tiuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770300924; x=1770905724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        b=okDMgw9Y6wCx4RH/0o+XJoXhPfbmIrCtiKYwMU2QY5ghcjWnYv9P00tJo2Zp/pO3aI
         ArlTpaGrtniZE4gfIQLhFK8MtVoDVyjGqfDch+179cAQCvvSTtRV5osuG25zBoYripfH
         q/MfrMJ4L6m8qWWj7brLrEXeoxA9t0yyrpUFSnZYn4smxcuqce9paAWXpKvsEwlIxdgH
         P/8hcdBH9ToKwBLUv/nQMrNmWT7NxNZhLGItx4q3RoO9j80I/9wBh2W1BTg4jKpBiyIW
         0GmtWgGlcbLOSX5x6nhGIIgkL9d1DRhxwuXprvmz8NJhcPObyKjw8W2X3QcE7nQNs1TZ
         GUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770300924; x=1770905724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        b=R51u/htIA/HQSPfQA3ArPc3Zd+heQsiaxjC0xdLtLbPr0mn3vFFmBsvmzUPv1q9H7Y
         UafqjmYidSoSEIBKbUS2HRN9nxy7IpEWE76IX0Gcc43FmzU6/0YqY4XnbBoQ2Vs9ziN7
         FYaWaTqRlSpLX4/SLDJ5z1DMsWjsbWxFsvjRySLyaEpbfqODpWdrrIvv1PGnEbdQSfy0
         eSRHJMaqxjNn6giR5iblVvPWEqt3hxTrNbkH0WewGjhAFucsrY/PbqDBpBLcxZlBFomE
         ECUHXZMtvJweNJlnQ9eym2beNmNLlSITUXnYbTEcqTE9FcG3q+ZtX4qMCVE7V7rvfWXo
         B4/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIkGNNOnEeob2+ETrHO3uj7Vr3T9eaD3ZW/Em0jVcfy+2mljiBZ0EgMqGcIscEknVAiCFKiqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qRbxaiQfk0fMNnY96CyLMSEmDY8c5IjmyE68r69fesymswFn
	5DnXhzxfv3gWhZjp5ohX3gtkz+SnKyaZXBZIrreU32dlFL2Lkge/61g5FeZ1zqmVYihk3ObxDmC
	qu0zsypXvh7Fx9/GKC/RB6KS2QR/hzfjOEXKfAe0pLserMq2r2MANRoagqtaFWIAV7ax8BCgAKJ
	EswN7YMsQO8TOIZmSKkiwF+do+hnqVU2/G
X-Gm-Gg: AZuq6aIg9zkneUbAvGrCWAkSUrcOSgqvNJtbCJcl6D8EmjZtI5nJaG3Cc7P6Ls+H8zV
	i6NNgZVPjjW7KXOn/HDVstpWSIB+6NDUQTcLtmnIemCFW7ED5MYlxqkUpiegXvZZWWk1jCCStZ4
	A8JN8/ftstByc92ZvMjNrw3r+yEog3u97FtpZmjJMVmQwc5+W5Xxyfd3ycljxuQZf66PKCXLCdU
	+2SaZLJpYcrco21RRUdniRW0A==
X-Received: by 2002:a05:620a:4541:b0:8b2:eb66:c64 with SMTP id af79cd13be357-8ca2f867672mr990704685a.29.1770300924465;
        Thu, 05 Feb 2026 06:15:24 -0800 (PST)
X-Received: by 2002:a05:620a:4541:b0:8b2:eb66:c64 with SMTP id
 af79cd13be357-8ca2f867672mr990694185a.29.1770300923828; Thu, 05 Feb 2026
 06:15:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 09:15:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 09:15:23 -0500
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <877bsr1l1h.fsf@toke.dk>
Date: Thu, 5 Feb 2026 09:15:23 -0500
X-Gm-Features: AZwV_QjcB_MBND46w0GTpSb-IAFDgDb1HaZ79yjWvd5G1Kk8nknomGGZF6Rm4Fc
Message-ID: <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com, Antoine Tenart <atenart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257200-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,davemloft.net,redhat.com,resnulli.us,google.com,mojatatu.com,cloudflare.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atenart@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 80763F3D8C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:34:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> > On 05/02/2026 04.04, Jakub Kicinski wrote:
> >
> >> It will presumably require existing users to migrate over
> >> but sooner we do it the fewer users that have to move?
> >
> > I agree. Existing users will loose some details, but the patchset
> > results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
> > which existing tools/users will still handle.
> > (The more specific drop reason is now avail via trace_qdisc_drop).
> >
> > Eric and Toke is this acceptable for your users?
>
> I like it! My only concern is that drop monitor tools will see two
> events for each qdisc drop. I guess that could be relatively
> straight-forwardly deduplicated in the tool, though? +Antoine who works
> on Retis to give him a chance to complain if not :)

Thanks for the heads up. We'll have to add support for the new enum
(pretty straightforward), other than that things should just work.

I'm wondering why not using the drop reason subsys logic to combine the
qdisc specific enum while not conflicting with drop reasons and allowing
to inject the qdisc reasons into drop reason enabled helpers as well?

Thanks!
Antoine


