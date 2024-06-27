Return-Path: <netdev+bounces-107168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48F191A28B
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFC42856F5
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 09:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72987137C37;
	Thu, 27 Jun 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ4MD9EI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7146421
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719480155; cv=none; b=HnhWAG8n4Gg/iXtTB87AOm+Yc6qwfZCuOChByMtrOJxhJT9KkCI3XCdiVZFc3w9t/V48ZrTJhIKvExcmL7V3AP93ReP6z5JMYSpDsfLKmkv2nfWa6zmHEK7lZuQr8JjUhAnvMjIiAbA9tDHAT8Mote/O+jGT/I1C9yy1I42ORKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719480155; c=relaxed/simple;
	bh=h9/pYhTmEPHl+6mOuk3E5OOVUOoQvw4uOk28dHxDX0Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=jKDYIWKls+VOgb7iZfl9nB8JzFWU6Qcb5QpcQgcleowUzDulrQhJICizXPZU+n4rVrCuIejWRj23uumLfxou/kvCRIezufGuaKcH9LwlCafFhSJvZ6pjrsRSr5q1cyG3vQfwCD4WM7E9/rZfQ/dwQVTh+sBTLuB+dh7K+8mlWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ4MD9EI; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367339bd00aso809754f8f.3
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719480152; x=1720084952; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SDT/hLtiC5GqmbrCvw7WNDqNl/Kr9DcdFu9sOYPaws4=;
        b=TQ4MD9EIHF3Orr3h3JGSWbuUFJKFk+2xD0icP7cMHyJ7p8405dal1p7S+4hx+a99U/
         G4AW5Kf98sdRZJdnImSjukokUALSE0Byh+BimMxSPQel2S7Ytp8rlH8LsDhQjBIuWWfQ
         UetXo4DbbVw+4vMV1BraQWm9DAvtht1TRI6I2U0UDdQvvdJezoaF0AZdo2E6ZmvN8xuN
         6bddiHKHrQM/VTMTYHZA7V9xLfC/awIsphYcP/c7iMQlkwdzW2VG9SX/n82YocYj6J+J
         167rDCLghTlsrE/Qfmqa3hU1z2SrmD74hXsZbZY8j2Fz4FTChNaa3tZmFsRqYeq+SSvd
         1T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719480152; x=1720084952;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDT/hLtiC5GqmbrCvw7WNDqNl/Kr9DcdFu9sOYPaws4=;
        b=AvsS6W8QbWsSRwPIbtP4aJ8gTq6Ut7ymJw9XS3ya76A1hsco9+LsB4E2DMoHsDg3jm
         aBda5MKK5M8FRmFYpS3Cmlgyw9MvrIfOlSMTNj/PyCmnm9xOqCWOA9oaJaqi9zj5aXWY
         KpaPGMd66B7ug3jwD1+7nyk8qu/qX7syAGBxhomsLQ+ygWwfdkjHMOwiathoCdyLKG0K
         omDKIK4z1YIxVBe4LcfgZE7HXGwxHHXgm5PL7lf/36NVgIZVEvRL1BpSlAtw6pSYSjrX
         9WvGgsoH0ezkzk31e2z/41nwR0GEMnKzg3yZYBvrDkb/Jve9DJWz9CNR/saMr3E0w7ze
         ++Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWgXWi+D/5bbF9W6ZBPR/jYzStr9O48ieSjMkiXHQmuRhbMlkjGslDA7a6rRMaYLJOWA73MficvuxEBtyqbr8DRytZbHthH
X-Gm-Message-State: AOJu0YwXv4WaO9oChhp++smnGefdGibTFJDvNfUnDwUDJUl8sbkr6KW+
	w7m+/9EjdAcJeYRZSuXTFGbjoxIYq70awz+8PZyJqY+7Kva318R2
X-Google-Smtp-Source: AGHT+IEbu8NTRrl1XWC9E6+RxhduQSsSVFkJwT+Yq3/j1yByu6euk0kxFjvUceFEjwVfdGS0Co/yqA==
X-Received: by 2002:a5d:6143:0:b0:367:40a8:4a70 with SMTP id ffacd0b85a97d-36740a84abbmr892177f8f.22.1719480151721;
        Thu, 27 Jun 2024 02:22:31 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:546e:2dab:3aba:3182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367436998fbsm1210978f8f.84.2024.06.27.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 02:22:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next] tcp_metrics: add netlink protocol spec in YAML
In-Reply-To: <20240626201133.2572487-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 26 Jun 2024 13:11:33 -0700")
Date: Thu, 27 Jun 2024 10:20:15 +0100
Message-ID: <m2o77md9o0.fsf@gmail.com>
References: <20240626201133.2572487-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add a protocol spec for tcp_metrics, so that it's accessible via YNL.
> Useful at the very least for testing fixes.
>
> In this episode of "10,000 ways to complicate netlink" the metric
> nest has defines which are off by 1. iproute2 does:
>
>         struct rtattr *m[TCP_METRIC_MAX + 1 + 1];
>
>         parse_rtattr_nested(m, TCP_METRIC_MAX + 1, a);
>
>         for (i = 0; i < TCP_METRIC_MAX + 1; i++) {
>                 // ...
>                 attr = m[i + 1];
>
> This is too weird to support in YNL, add a new set of defines
> with _correct_ values to the official kernel header.

I had to add tcp_metrics.h to Makefile.deps to get the generated code to
complile.

diff --git a/tools/net/ynl/Makefile.deps b/tools/net/ynl/Makefile.deps
index f4e8eb79c1b8..2f05f8ec2324 100644
--- a/tools/net/ynl/Makefile.deps
+++ b/tools/net/ynl/Makefile.deps
@@ -25,3 +25,4 @@ CFLAGS_nfsd:=$(call get_hdr_inc,_LINUX_NFSD_NETLINK_H,nfsd_netlink.h)
 CFLAGS_ovs_datapath:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_flow:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
 CFLAGS_ovs_vport:=$(call get_hdr_inc,__LINUX_OPENVSWITCH_H,openvswitch.h)
+CFLAGS_tcp_metrics:=$(call get_hdr_inc,__LINUX_TCP_METRICS_H,tcp_metrics.h)

> +
> +  -
> +    name: metrics
> +    # Intentially don't define the name-prefix to match the kernel, see below.

Typo: Intentionally

> +    doc: |
> +      Attributes with metrics. Note that the values here do not match
> +      the TCP_METRIC_* defines in the kernel, because kernel defines
> +      are off-by one (e.g. rtt is defined as enum 0, while netlink carries
> +      attribute type 1).
> +    attributes:
> +      -
> +        name: rtt
> +        type: u32
> +        doc: |
> +          Round Trip Time (RTT), in msecs with 3 bits fractional
> +          (left-shift by 3 to get the msec value).
> +      -
> +        name: rttvar
> +        type: u32
> +        doc: |
> +          Round Trip Time VARiance (RTT), in msecs with 2 bits fractional
> +          (left-shift by 2 to get the msec value).
> +      -
> +        name: ssthresh
> +        type: u32
> +        doc: Slow Start THRESHold.
> +      -
> +        name: cwnd
> +        type: u32
> +        doc: Congestion Window.
> +      -
> +        name: reodering
> +        type: u32
> +        doc: Reodering metric.
> +      -
> +        name: rtt_us

Should this be a dash, 'rtt-us' ?

> +        type: u32
> +        doc: |
> +          Round Trip Time (RTT), in usecs, with 3 bits fractional
> +          (left-shift by 3 to get the msec value).
> +      -
> +        name: rttvar_us

Same here?

> +        type: u32
> +        doc: |
> +          Round Trip Time (RTT), in usecs, with 3 bits fractional
> +          (left-shift by 3 to get the msec value).
> +

