Return-Path: <netdev+bounces-246992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EFFCF3424
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBCC6305FC89
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635CD330B26;
	Mon,  5 Jan 2026 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT8WVbMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C233066E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612450; cv=none; b=AH61pyi34wwU1U6Ryp8+w9xeGpuN3PU9B8k9bVUQg+kSiybVoXObLWxFfTl5NUacnJtJl8HyTh2Vn8gE3Mwjw55gkXte1xNsYiFCgASyrsh9+/+QhuKZPPpk5mj2PjsbZgDPaQ5tiYRgEfR83NB8WX1xe+6H4L/wKlYOm3iAdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612450; c=relaxed/simple;
	bh=VUXdc9hwk0T2er9DTckmrZex4qeCTOgDcVRoChu5qdY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jIHn8Zg7aw1sDYxeQGELNVvp1m1YVkWtvbd5YQf0/wy09iRXklYRaYO7q/f8zZ9Vi4aVljXlGMmXugPP6SDF2HE7TCYJgF0Zag2Ro83GmOHHEgeRYh965Sb/aKmMT2CX0bAMiqZytVS1+c35qPyieuyDGE9QFIK+3vPSasW9hYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT8WVbMX; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so11396374f8f.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612443; x=1768217243; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=GT8WVbMXD21yXh5A1tsJXqAr0ScK130QqyKqO+2dPqIgMxTD/Frhr1f+s+nnimJ6Kv
         bLsObw+XWNwICqT8lFmdv0l/yMEG6uAInIEd+rt1+IZ3qeQaIcUuTzBpdvGKKCYJMGDg
         MXhA5GoI7c0KwTP3qZl4nB8nAWXj+1xsJa1EgYNfRhk8VXZQTF1Y7pi/9t8Jtaq5u9K5
         uG6KIt/xdc3/t9IjzgOzlfMKB9DleqOCcAPJxE5kKRhDe8K9m7ic46iwr2u3ocaOVjqc
         KJMRfl7W/FjlSyL+e/AkVd8fD6WnQu1d3egnQt8Ccyiad0RoWF6KZRmtJYioBakDHJDf
         cG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612443; x=1768217243;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2qHDzkZJACXcp+eQuf4jUc4YyVkIXXCNoOh0gjbwoPI=;
        b=apNuPTEx1bloP9nEaLXgigZBfmEPCz/jRGg/OKFpG7fFWAoMUwBdG9ipWR627p3MQ1
         hsBMt8nOYAzE446qhn6Nh8+LAXpXoVVpxmn/zrlB1uYU6G/RyIWb7Nvfu1APRwfqga31
         emEbghPRlyS1B8PJoH1yXWqx97gKzgTtpHYul6KJhpjwHoPLdnUZ1nIfyuvBxXFL4LR9
         qZZp31Dq4xTmolz7Ak1r29+TfBHKGRmH8VWSzVDxlWs0g0W5fKxkyc5+SksOOzTQg9wA
         tgr5FbgmltJdxAvw9ijvlQuJn3PN0dDutjqMANaQdLXnxkCRvLJEASdybwaCiNh8I+IK
         mOnw==
X-Forwarded-Encrypted: i=1; AJvYcCVMqWRaZmVRWe6ZRmcNDZq6eVqYnKlNr3oOAqKpNSDAT7/4CYqBxgy4/O9/NvImpmIEuCHmzqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSGq2Cn0abxpsgLkqcuW8ke+6KIT1Gcq2MlDwLkBOSm2e7kUu
	pqpsvDw+ZjxjtNKZKXJbn1JFvpVYjTfm0ctRLqlpvKKb0HrTy91UUdma
X-Gm-Gg: AY/fxX6PpkadFbStdX3Vftu3Q4rRAhwaM976uEVVqMJ2tjtvlgqPD4aS2OrHLHM05Ct
	n+d1qIiAo09qeTUCzkt/eFbgT/fbIqE86yZ83n6oQ6szBXksU/nnc1PQNZn76IB8b4nONGwZ787
	JyQgXWnsdJVc8OU83guC97anHNGALPmgBCpeXcqNGIJZkLif8yOXZgOwjE+ukIpyY4C4uCMrgW8
	WsjGMpBSGzBFoxEJPfN0C9rLq2Pn4fI9Y6CqVogaQ7+xIRAGyBdCl+QWVbOeOQOLwS+53cFynjQ
	TNLbBglHgxM5dQPBFZKSdnlUN7mJ6CuXw3ZrMJQvRgacS8GpTVrm3AHlymT6wVHYG9e7C5z+SZx
	xw6MWxMgcvE0ScE6LTcnE/FLjJI+lvDZFU+dhyUq3ts47l7ge334/F+Xo361wWMwNATiGKynUYs
	ZAmXXU3wTqxcOChUcL0kmcSe0=
X-Google-Smtp-Source: AGHT+IEe3zf1IkKFKkWJiFRWFG2kWewA423+4tt5YeHwRg6lgVblS3TIR8XO7sEvsL2qPIhcXvtY5g==
X-Received: by 2002:a05:6000:25ca:b0:431:5d2:4526 with SMTP id ffacd0b85a97d-4324e4c9df3mr65957051f8f.19.1767612442851;
        Mon, 05 Jan 2026 03:27:22 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4327791d2f3sm69505535f8f.11.2026.01.05.03.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:21 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 4/4] PM: EM: Add dump to get-perf-domains in
 the EM YNL spec
In-Reply-To: <20251225040104.982704-5-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:19:16 +0000
Message-ID: <m2bjj8i9xn.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-5-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Changwoo Min <changwoo@igalia.com> writes:

> Add dump to get-perf-domains, so that a user can fetch either information
> about a specific performance domain with do or information about all
> performance domains with dump. The YNL spec, autogenerated files, and
> the do implementation are updated, and the dump implementation is added.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 12 ++++
>  include/uapi/linux/dev_energymodel.h          |  3 +-
>  kernel/power/em_netlink.c                     | 58 +++++++++++++++++--
>  kernel/power/em_netlink_autogen.c             | 16 ++++-
>  kernel/power/em_netlink_autogen.h             |  2 +
>  5 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/netlink/specs/dev-energymodel.yaml b/Documentation/netlink/specs/dev-energymodel.yaml
> index af8b8f72f722..1843e68faacf 100644
> --- a/Documentation/netlink/specs/dev-energymodel.yaml
> +++ b/Documentation/netlink/specs/dev-energymodel.yaml
> @@ -47,6 +47,11 @@ attribute-sets:
>      doc: >-
>        Information on all the performance domains.
>      attributes:
> +      -
> +        name: perf-domain-id
> +        type: u32
> +        doc: >-
> +          A unique ID number for each performance domain.
>        -
>          name: perf-domain
>          type: nest
> @@ -136,6 +141,13 @@ operations:
>        attribute-set: perf-domains

I think this can be changed to 'perf-domain' and you could remove
the 'perf-domains' attribute-set.

>        doc: Get the list of information for all performance domains.
>        do:
> +        request:
> +          attributes:
> +            - perf-domain-id
> +        reply:
> +          attributes:
> +            - perf-domain

If you use 'perf-domain' then the reply attributes would be:

  reply:
    attributes: &perf-domain-attrs
      - pad
      - perf-domain-id
      - flags
      - cpus

> +      dump:
>          reply:
>            attributes:
>              - perf-domain

You can then change the dump reply to be:

  dump:
    reply:
      attributes: *perf-domain-attrs

The dump reply for multiple perf domains would then look like this, no
need for the 'perf-domains' wrapper:

[{'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]},
 {'perf-domain-id': ...,
  'flags': ...,
  'cpus': [1, 2, 3]}]

