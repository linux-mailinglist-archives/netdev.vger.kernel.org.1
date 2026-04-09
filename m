Return-Path: <netdev+bounces-276756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OROGnDu1mlYJwgAu9opvQ
	(envelope-from <netdev+bounces-276756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:10:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E31293C4E71
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 02:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A883003EB3
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC9175A71;
	Thu,  9 Apr 2026 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vx+3caNq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C18142E83
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775693419; cv=pass; b=vD60oBh52heM5q3tY95s87meB9wXa2p2S31WomCcMZ2j3Paqo2GAclxsR+6Zbii3bIiJhvlHV6hjD+u3uS5CLcZRiFV5IHoRK3+vhz/M4y++2EeiQ/Q1Fa6t6B/XrqFN0NiCGS85wnc29pPOS4m/M8Om3tSKvf9SLkCkatrNpj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775693419; c=relaxed/simple;
	bh=HYu8gdFcKMXVJvVw7I09J006LpciF6JI3kYsv0hyAr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UPa7zMSGnCV2L8vAteCkylP0xxkeROF8DAI7jDk6fZwVphsP4ha6iovg6rCcbPvZaFzZVWVIvI4AOs5s3SeZxL5dxD0/NayrFBFpYoz00eASPpjKjrjJIrCaR5KfC1gBJU776ovtkvMiUoWRfhnPg7bq0ROj+RZT2oAu/qiDcEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vx+3caNq; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66baa7fdfd3so2604a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 17:10:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775693416; cv=none;
        d=google.com; s=arc-20240605;
        b=ftgwDjc1TjyE4lXNm9CojlqtoBjm1CzLECwdRKVnXFXHIXJcJC7b0DgEZEDvu3AbvU
         NWeWCacOY4v1bPUv+SsDIYlJnenFJMrHL0u5RsRUSQ6VdR7LZ48tg0/yZjD76IDFBnYs
         XBBK1gqmgzVqK6LHkvsxsULFsgKMKMVtZZ2lxedqemkiQZ5Dq1f1dyRLRnmdxGwbCKGS
         YT113MDb45ZA7r7Tr0eCE1pCWptvK8JIRxTkfiWCFKW9HvmvB3Dm7SNG63uSyoOr1agw
         EDn7A09Jcetv1NuPu5a4RHTHxGdptsRj7jT3lBysH9TwwXkBwSlTSfrCvEYZfV6+gKZX
         613A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HYu8gdFcKMXVJvVw7I09J006LpciF6JI3kYsv0hyAr0=;
        fh=xA4wJ07aV40sGu26CVF/Q5BZLyOu+zjlfEWNmbqc50g=;
        b=Ti9JIWhNzIz3AlycKbP+BapFbI8m9lEvdXHqTs4569BhlKFVJogAXSa0op03oumG1p
         7lufLvxijBLSLE7luKkqJg+1gp1iQDyzHlb2dtBtCyZQP0fQqPgGG+pjl0qh4WVccJIu
         rkcjXyHDqtzL6SYykC7Fe/4ApzBlwFAMhHd0zNosPEpmqKFpJ16JeSObBWiCQYInsdLR
         2zPuC+LwSzfExri9KJkZqs0UfSUYUuKxtA2krq1qC9bnTZ23DX0/sZ8XegWjwsH5CvXo
         RwYkuHgU8YVDp91uN0Xom6aE4UKQwjsA1tvYUZCkABnTsuARKs47pzVuZAfeil3KqFhN
         sudA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775693416; x=1776298216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYu8gdFcKMXVJvVw7I09J006LpciF6JI3kYsv0hyAr0=;
        b=Vx+3caNq8zL2Pz4bqQJY/rU0ULYdmUeWPNLVcRZZ7W55IiRfIXU91UYesycx5I63ZE
         FRIKNDpxHK8IS9cIT3GHDAZ127j0cer5rnsyMxcemv2h20gwfcIf3uo5xdmQGQs9NZHp
         /6iKHyxivo7cIRGxS+GvTTUMQvBNmBkpWYvG9+xQ+mmQmnXImJyPl3zdkay5856XDCZn
         BW34pqlpvLZrc6TK3PaauWlXEm8ayqjskx4hJRqG6InQTJ/rqMIRawMd8o9CHCcxsC9E
         xHNxWXw642UFggX3gEw6w/9OcgHquPXI0v9JHduqjaqUjgbpYYc2ekFjYI+kPCVcRQws
         xVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775693416; x=1776298216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HYu8gdFcKMXVJvVw7I09J006LpciF6JI3kYsv0hyAr0=;
        b=EEsejxh16tfIuU+hAJsTTLIDDMW0C88hnqNfjPPhtCTY9RarGGXVxuFVexYDXywEr3
         zj8tGw8cfUeIIEGcPsZyopflz2Pxz0e+mJJKVePysKfKZtzz3sDam44jqhOTv1w0HBat
         F3ck2DmzQ4+dx/S7475wrK8OChHzY7sy1wMrI+3mVXvc5XrW6nHiwrPLHXUjqiXG3Y1v
         +SHcE5jfgVxWe/YCx3QkwZB+juisaN1VhFiXLI0m7+qzlmHgnSvY+PRJ+LSjNIhyHJaY
         9sRyyl2yr2+Ynlse131RsblU7izYINeoD76oqAUGshg4Sz3VGnV3HFQ6Hg5kar2raf8L
         8cPg==
X-Forwarded-Encrypted: i=1; AJvYcCWwTeyL8lG0NVnTE2zxWgFESdNd5C1yQzgt3vLks4FLudzWk9pFoGZm9O7fLFUUJiEtg0Y9d1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9WuS/MPaTOnc7bq6lD0QHImNqtaFwW7xzljHbKY81Q/y+91QC
	H1I0qLyfQ4aqhq70JECl3GKKHdAmZm4tVUVL5DOr0D/9mWNOns4pOrpLRjvhLA+AUXGseXHQnby
	CMf8lcXBX52G9dM0QcMJgj3epOdOHw3sDi7XMc4DV
X-Gm-Gg: AeBDievvBik5vEQhRL5YEKIeGpw/sV9BrPtut7pFCZluZN9+R88/kwaVgNoXnlG7LrG
	BXPQSdrBBryZyOJUgS1A3cleO0kb1ZPF3Bn60xC7B4VXWCi4byiijWbfQfxiOCf/1roKdB5oNMf
	KVGWMLg7UYVjOa7qwXKQQ34lpKLLbyEFhOVj6ei8M7X/iNaJQ0NuLl5cBxfxgIqhT+QXym16TXB
	Q6YjiEfQHTndJ/HIQnB1zPnZS4GdElBMj8ypT/+s44ydzLZtnRm5BzDGGbwQOxj4DHoKuJGTs86
	0EnOtyr8HRj/3O+sr292lqVpdO6aisL0OiqGZ0Vcz2wFm5WZU6+/j8swVLNA9qYhl7Zo+g==
X-Received: by 2002:a05:6402:534d:20b0:66f:a171:b9c0 with SMTP id
 4fb4d7f45d1cf-6700fe9740fmr19945a12.2.1775693416087; Wed, 08 Apr 2026
 17:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com> <20260408094015.3b8359c1@kernel.org>
In-Reply-To: <20260408094015.3b8359c1@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Wed, 8 Apr 2026 17:10:05 -0700
X-Gm-Features: AQROBzBATnnO5hyX42b-C14QXLjQxO4SDa3or_hh7MHL1ydBQmMoa0JtF8_8ksk
Message-ID: <CANkEMgk16j2xzQ85JGQ4OWqeiwiVO5Gy-UfkN3omKkKizpLxiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/10] Decouple receive and transmit
 enablement in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276756-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E31293C4E71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 9:40=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> It pains me to report on non-debug kernels:

I'm sorry to have pained you. Despite my best efforts to run with the
exact same environment and conditions as your CI, my teamd can be
killed with "teamd -k" but yours hangs (both are version 1.32 on
Fedora with the same kernel config). For v7, I=E2=80=99ll invoke "teamd -k"
using the timeout utility, or just increase the test timeout.

