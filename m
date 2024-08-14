Return-Path: <netdev+bounces-118484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08A951BD1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3585CB22DEA
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19671B1418;
	Wed, 14 Aug 2024 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vultr.com header.i=@vultr.com header.b="ukpNUVZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAD1879
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642093; cv=none; b=Y4n693tJS/mDmSTVzTWhy8gUpLrjCk/RnXw4xWgJ5sg9oppvSTCh9OH8aw7YvCfBnGvfT323wkiHR/R90hHEwQ6sr/uAjmOs4c0DuBVQHYULfd4JX8i7Kpa96FsjSjwOYBcpAD/SNIIIv5NtXBBObylSH/b4it/scVjbH4QaKJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642093; c=relaxed/simple;
	bh=V56bb2SBeWuj7U2AOoCQl9ccR/u0/St6ciB6GMAx3/s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oyStCv907Q+a+0qXEZE16+6LIA4LgMNh0tMg71njFEl6p1C6IKcRyPVz2RHTt5RueQzLwAZAIKsd4bo4CZHJqVTWw0B8Y0ISgtMp0qTlvFQ855+aTjyKpv+QwaeRrTvQRNJR3oMv3qE1JadUnEOm8QBwK7ymztE62pYK65sGMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vultr.com; spf=pass smtp.mailfrom=vultr.com; dkim=pass (2048-bit key) header.d=vultr.com header.i=@vultr.com header.b=ukpNUVZS; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vultr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vultr.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3db1e21b0e4so4514128b6e.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vultr.com; s=google; t=1723642091; x=1724246891; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qpPX7lZVsuwgLLnRc1mGzsnfVgyXzTNONNpmbI4+pZM=;
        b=ukpNUVZSYnEtejG5aJb4h4AOTkHKne4W76MMJ50MKL0F9KsxVykXmu0rm80i6bZX0P
         TaIacJ5yGUmZFpU8G9l5nbULIDHYKXPZd6B0Q5Bi3M+CB4Uv33tc/07/OPVr4MDW05Xh
         pL3HJntQGfwxgOZWG5lxC6372gs7owmyMpjNNZz9fn0xzArElg44qd+jBiKyNcVPmA86
         T53Hu96lP7Yn/SVKlNbhhns3KtIvn8lk0qPw/pU8mJx++WPZ9MA3iNbrFj7lu4wq1k2u
         Wqnf6eEbzJEwdWdPKsqAcG1ukIFUi4oWMhNjwJaAy3I00AmK7XacD0Df6m3zE4dGyOVX
         +CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723642091; x=1724246891;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpPX7lZVsuwgLLnRc1mGzsnfVgyXzTNONNpmbI4+pZM=;
        b=B2tO7mMpYe1lYiOREwXWvipNK79qGWAhp83Vk/BF2KdE1OhyjHTm836vpmfDrzIxyE
         C/32T9G15JCEYxtnooIuBO136pF0tox+6T8ftkfPJnoU+jAzppPCw/lx+xMt7Spyic3J
         AF720+8a1bjkpj8dKc7wZFN5UH8EUmlP67D9b6FjG4jGoXPT/iKIXgMAUmUYhVF3busW
         MDCODwvRTY5y3+80SnkFNeFXb2o99HdjhloekckBwV+5ZarTNkQLXA/XLmPbUCZAc36p
         fqAQSsfpBHBh60faHubvU+aIrZRHWS25Za5kA733UqU1q4THx8L7nL+CTkNegCy6S9M6
         D9IA==
X-Gm-Message-State: AOJu0YzuzBgtOXDMwYMQwDoH0dnoZK86JifACwU0gqfQl7QGUUWDQsNt
	04iZ5RW5v5vQSXy4hoKHtKyZcG6WU7utqO3s+XTI9rm6trAZQaYbJhhNBOkOgua4Irjshd1wKLI
	PnYBxE++Xx2R5sdnIwEyDL2V5qdRdSWwGLFBvBooD855SXJddODJ+jQ==
X-Google-Smtp-Source: AGHT+IFieDgJ3jOJW1QIqhwCx+X4t2oVIxMIhWAW4LAW/O/SFpcuTm2RhrCT7rE3RO3Mwl8CaATwPibvp/mZL2zma2U=
X-Received: by 2002:a05:6808:1150:b0:3da:b335:538e with SMTP id
 5614622812f47-3dd298dc3d5mr3303561b6e.8.1723642090888; Wed, 14 Aug 2024
 06:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Waterman <mwaterman@vultr.com>
Date: Wed, 14 Aug 2024 09:28:00 -0400
Message-ID: <CABmay2CxFPpsgzSx6wCxyDzjw2cqwAAKs6YjiArR1A2UPLpgJA@mail.gmail.com>
Subject: Add `auto` VRF table ID option in iproute2
To: netdev@vger.kernel.org, stephen@networkplumber.org, 
	=?UTF-8?Q?Daniel_Gr=C3=B6ber?= <dxld@darkboxed.org>
Content-Type: text/plain; charset="UTF-8"

Hello,

Package: iproute2
Version: 5.10.0-4

Feature request: Add an `auto` option for VRF table ID management like
in Cumulus Linux. I believe it'd be the iproute2 package on Debian
(11/12).

Example: Instead of specifying, say, 1001 for a table ID, we'd do the
following with the `auto` option:

```
auto vrfexample
iface vrfexample
    vrf-table auto
```

Or:

```
ip link add vrfexample type vrf table auto
```

(I'm new to the list and this is my first request. I tried to be brief
to respect time. Please ask any follow-ups as needed.)

Thanks!

Best,
Mike Waterman

