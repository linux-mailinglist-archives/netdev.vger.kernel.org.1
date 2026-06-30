Return-Path: <netdev+bounces-303009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HpVdMIZwQ2rLYQoAu9opvQ
	(envelope-from <netdev+bounces-303009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:30:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD756E1293
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:30:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KLT4WTD0;
	dkim=pass header.d=redhat.com header.s=google header.b=MuKy0YhC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303009-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303009-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD473065F3B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713C739D6FA;
	Tue, 30 Jun 2026 07:28:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD939A04C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 07:28:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804517; cv=pass; b=EwAXaXjz7cwEgUa4sFOYTQ8pUFyYDuxLqwbRnWCUvM7NEKfo+qFYsdsD7F5E4SSBmhHeemluxogBVWkhDhzeZm7nF9+cly8JUjlb4u8Be2UnsZ3MUERLKEWBzFXiJp9ZQLlkzx+nipg3cam95V2amMouiEBsscBJFB4sWVXc79w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804517; c=relaxed/simple;
	bh=QpiJXUd/TdRC88Zy5JYnnExcUMasQKSq5TYcaHFChJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRE0cRQrZvgHQO04sUiRTZ4D24Pr3AQCW3KSK4Pf8gQcJVsQ9/FKArAqA5hjuEtShtxxNtlx7DtuWWU1CY3Gp0Q/8DZdqScVCQzRKoSYNsRxV/qiZp7R3YjAqgDGV9rba/w4YNWe6gZg//wIDeV82LLiLwhyoceo/cELIXAMZ3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLT4WTD0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MuKy0YhC; arc=pass smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782804515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hTUJ3hTjCt2yXulZuZv+e76jNuquuhLumAKkPqjpPY=;
	b=KLT4WTD0K6sioNHAsjZQDVerxtrp6So33sjga6HdAj4e5mal2KuINNfV+Z6VSwmCQ6UYnk
	+lrF45FdXhlaro015Pax0Smni4go+ukFP+wTeXqon28xP0I5qmzv6JDL2NScjPME8JD4sY
	8XI82B2ssjgYPhZaTQdqQS3MaSidZm0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-AiXfctltP3a4CCISLeclFw-1; Tue, 30 Jun 2026 03:28:33 -0400
X-MC-Unique: AiXfctltP3a4CCISLeclFw-1
X-Mimecast-MFC-AGG-ID: AiXfctltP3a4CCISLeclFw_1782804512
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-473bc66c837so1395385f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:28:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782804512; cv=none;
        d=google.com; s=arc-20260327;
        b=qHqsO+wOmpqs0swVQlSxxV78Iu/bL10tY6a+BPLJ9y8NPsrQtXhxI+QdstjZMcWHQz
         7rOk7Ukgt7nY6KjANWpHeCCBUSHeFXG67xwjdvt8+1JUmzleKKYUUxJyLWll27Y/uO0d
         wtLqj/JvjCuO9mHotEZDYcWKNQwx/ugNvcdcQlf5P5cfqSdjUTazVYJnCWMXNlFwx3Pq
         JUB3WRJt5S7lPt1AaK+Ea7uYiqpZpwlhrxCyz3BZn6+11kgBPXTeaeIBbg1FoFPrl5Yi
         Yf2AYmjXG0SBBgh9yHWs+tQu7b2rTMLCcfxWKA9yieHVV+tN1arj2ZpR751PylsZiM7N
         TCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1hTUJ3hTjCt2yXulZuZv+e76jNuquuhLumAKkPqjpPY=;
        fh=mh/9pi+RVlXxT5wIYgEzEXjhwpsuYOsKtHYfXIh81fA=;
        b=UAyqcHSXHokTedKlh5eXkP7y8EhTStvRvIzTNm+ZS9+BbYZtApN+yE1NIfqLIYNoGh
         5/jKBEbYUAS3YCBFhuHzZ8eC6ntfFaj6zvlAONQvCinJt+A/T8uZcPV3kNG4IcjxNMcr
         l3jBLP7yeu8aU2braeQaYZxZVfoZ+rnLnZmSUgL+ypsB4+6vZ5Q8LEWrmi066lKLYE0v
         OlzubIEzv4sLexkTXmNlXW+SETgBr9n3VBQLSDaZC0tWF5DPjreMUCIDfT2a0xyE4RsG
         ocPWF6ujEohKCwpqG4BvROpqtYw+qv0s+6CV5Ioho/Qqf08rTXkQDPqNq+22wwWIgzXR
         Zk6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782804512; x=1783409312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hTUJ3hTjCt2yXulZuZv+e76jNuquuhLumAKkPqjpPY=;
        b=MuKy0YhCCFb8cSNnTjZ8V3Kgo3nl6s9tbEUhoZjb/UYRhWQCuqvbYN624xN9DdNTBr
         2OufUModUUMXv67fLbj8gU9iRXOLN0uEZdgVLVHlO29vpvakbu7RaQ5tWCs/mvB22K2E
         pIqewZVmI4Rmuygd3O2nn8byOEZfs72uo5E2lAX6D0tXj8nuKfBYITLpXdmy8UWTF4AY
         bFMpYBFk+0Z67575U9/M+VZopyGB86PSYVna5qG2Mc45Ll1asF8TZhNJEPxCnWV5f1m/
         +4XrOqOLArRXEDOHmh8KEYHJH253Uol2G8K++IX5rzBOye+Sh/2D2tD29cyYsOJ2fmae
         to3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782804512; x=1783409312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1hTUJ3hTjCt2yXulZuZv+e76jNuquuhLumAKkPqjpPY=;
        b=ULsKztMRBlyMAsnSfrAK8irVKy6cEfnT6GX3ofMOJYL3gZJnbePJC2wtgTZGabMdVt
         PLvtWHLn244hp73H81r6lH7/6JOOvS1Vazt9ygQTqPwflQ9tFlZIEwHBuoHIBPMqhWv5
         PGTOhwXZry7Qze8LfOHke6+f0VJcOxiHJ/83XGFHexMICkDxAiA84oUhmaDdEu8DIyuw
         N50gxhw221G/0THzAU8XfmiyYtH2HmKZS+KVIfj4PhDovjLFSsjElZQtXWJGm1eJ4YSJ
         7rJMVLV+A6AtxqI7umuOaDlsVgImwLSnVGH6X95vwjAmbOx/wPmNhaB14fkV5Yb33Fbd
         vLgQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDwxu8aFuuTt6DIhenf8RLyKVaZwbRIkPgBNkWy8I+EfpjKIx5Zpsy1QHBFYy1OsWYeA0jlKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UYGemb+L/wAS6mJI/OBFeWUd/dz9DrajBZvxV7e287O7Gy2F
	G6VFHdlGnVDVh6e6me5WZaZwmkjGXUCV7K+FRy0XY4CSshmuejXNho21UzdbFrFbzZtSy1iLdHA
	bS9YrXXbG2OVwgjzhhf0aTiOsIulQlxFfFZRCx1YuUiK5hHjTN5ecdlWo0B7sF3RHGbHPhKVS17
	GNOhMttLsYP9HCQVOMQPKQB7mnWWhHPL0l
X-Gm-Gg: AfdE7cmJQIhE9HILG1kToQJEoHzM/+qHSZkpPCbh82WjwaCL9vRRrVNxZTlzZ/nKlDQ
	TR3DquI+nDjXevbWmbgXNnB2MoyQWGPKud/hA1miaS9ASfIeYnJirsCUkYhLhpa4RfLjNOzck96
	cjiiLQtaQMXslfsoW1VrWUf0vlA3o80x+GWOX68PkbqEFAv8PqjT+9L3ROIOUB06fWXVg=
X-Received: by 2002:a05:6000:40da:b0:46d:d6e0:9cc4 with SMTP id ffacd0b85a97d-47553d96e98mr3142197f8f.46.1782804512188;
        Tue, 30 Jun 2026 00:28:32 -0700 (PDT)
X-Received: by 2002:a05:6000:40da:b0:46d:d6e0:9cc4 with SMTP id
 ffacd0b85a97d-47553d96e98mr3142160f8f.46.1782804511792; Tue, 30 Jun 2026
 00:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630001432.2204298-1-kuba@kernel.org> <20260630001432.2204298-2-kuba@kernel.org>
In-Reply-To: <20260630001432.2204298-2-kuba@kernel.org>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 Jun 2026 09:28:15 +0200
X-Gm-Features: AVVi8CezvGUJJ6tK2r8Ed3axYsHeG8WJZoxmVVLjU0XdqUzoRNnMhue2yMZrwkM
Message-ID: <CAASaF6yKwyfDRzXoi8pXk=976kC3zxfNVuh7MwOFJQOHv866fQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tools: ynl: pyynl: re-export the library API
 from the package root
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, sdf@fomichev.me, gal@nvidia.com, ast@fiberby.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com,fiberby.net];
	TAGGED_FROM(0.00)[bounces-303009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jstancek@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:ast@fiberby.net,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jstancek@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3BD756E1293

On Tue, Jun 30, 2026 at 2:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The public classes live in pyynl.lib, so users had to spell out
>
>   from pyynl.lib import YnlFamily
>
> which I forget at least once a month. Re-export lib's API from
> the package __init__ so that
>
>   from pyynl import YnlFamily
>
> works as well. I don't think there was a real reason not to do
> this?

I think it was more uncertainty on my part whether in future we get
more subdirectories.

Acked-by: Jan Stancek <jstancek@redhat.com>

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/pyynl/__init__.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/net/ynl/pyynl/__init__.py b/tools/net/ynl/pyynl/__init=
__.py
> index e69de29bb2d1..d8f59c132ab7 100644
> --- a/tools/net/ynl/pyynl/__init__.py
> +++ b/tools/net/ynl/pyynl/__init__.py
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +
> +""" Python YNL (YAML Netlink) library. """
> +
> +# Re-export the public library API so it can be imported straight from t=
he
> +# package, e.g. `from pyynl import YnlFamily`.
> +# pylint: disable=3Dwildcard-import,unused-wildcard-import
> +from .lib import *
> +from .lib import __all__
> --
> 2.54.0
>


