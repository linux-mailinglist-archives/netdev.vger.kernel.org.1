Return-Path: <netdev+bounces-246994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E001ECF3433
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6EFA3061FF9
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2033121A;
	Mon,  5 Jan 2026 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL8qm6eH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D9330B20
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767612455; cv=none; b=BGrmcHLSkVBHXHkN33HPzWhon1ea3Mq7/3w0jMUlTmecNJcx8VoroK+ADM5yCqtgAYMkJBZJrRTWp4Lb5vh9va6Bel3MF3qJXzMOQ1Khvou2SIssRX7WO7QaKxyhHI4WT5QPBSPQaxDEraevUjThqjlz9nuHTjQL8atA3QKYrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767612455; c=relaxed/simple;
	bh=Go+GAYzO0jgTKcc48Myrg2Pj0BaCXr+2m/+CGE76n6c=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fxRWAISFivEv475hVA7R67gv/gRDorm/2B426xoiB2Yu6P6sj5/JaVUHLM1M2HPR+pe3h3hEtYw0fiD0/BQhvSe9r74GR0WqjkVnxq4/5kMaXQjPLLu0B4bnjHZc+2SwJS7s2c19ReuyPJ4YXaGxApMH2/fDyjL3hJf5HkH+m0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL8qm6eH; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so11225665f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767612447; x=1768217247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=VL8qm6eHO80/CL3xLajJ/0K73Rm5sil51ejACLf1u1FBCS7IHgblbisukbmtPKMxZe
         4nZVJ+2wVvCtGMuChE81krgIJw0xAJ1/cOXGtQxBEHCthzFAMCdH67GdYpEmVWgxSnL4
         8U3TLBeLQStbNUIiT48gC8XyyeJr4bF9znvtmyf2D1XHdrlWnP6L7p4vaN9o3X1d+/Yh
         vNS4pr/X8eB2XGNtJhVj556T7dU+r0gLZATqK67SciJx1ee//z/qgUfGXOH8Nxvx6yYK
         jYm7y3GMxCqzZ6YgzzlOWawF5I5h0L5FIEp34tV/XximpcSBGP7Q63yi8Y++Focv6gMP
         IFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767612447; x=1768217247;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j95TD1ZmtU4Apnwzg09U0kNwpICIT3BxQAw/HHzh+18=;
        b=CDEzMTY5tI0nL+AZM7GNvYk2hBCNrGELf8xzEYaG6OeSwkRFHfa5okGcgvLaWs4PyE
         3tapT9t+mjaAxCZ4TU0V5mBFBu1BCXkq/bT8hWhWiXSc3SQRA1nl0pXtgfNhHDxcssGB
         lhdFHb1sOEP7lWrQkpay/LGHXFVw5tKLNhA715iwa+MK/Sw+Rxxowt3HMX9pqqb53TEb
         DqRiOqC+FUTRX4X148r/TYCfYwQ3MfOZOj8MYfrn0SwxscdvZ3ntZV2NQJX/cj4O9sGQ
         hCKQo9Z/Rf7EQ+3b23eHL06MgSqxNqIKQ3efIepSvp4bF2F0IMrUitFF9BUBBJ0y2GiH
         Wl/A==
X-Forwarded-Encrypted: i=1; AJvYcCUBq0Klvffeh2HWjj0wK701TushxV0j0/pZoh55VqrH7hKGqck2z0L1WGnqNuRH5NixeE1uKrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgMMBnPWkM8y9OnARopzb2oUlKg5Bg7XdBZ9pIwyI4QSBz3je
	+0bPB89I+B85bIvJQ8r0MAfalaL8qXzyP56N61Qxdxl7UBYUJIy20GHA
X-Gm-Gg: AY/fxX6LeqR/uR6XujHJF9usWpGVbSwEf1srN7BC5b7AaYdbtC8LkXRkQIeTZmt1PvX
	d3sQh+Q6O7WZbDOfPEB1FvsJWIYupOrCNzt8nzaQfqPFx8Tr1s4LdWYuk993JdymWj8MMrrKbJ3
	PVVGfh9Z8QX1pMQzpv71564kBISaAIDSqETQ9+ufQ3DjKJ2s0Clf45kMacIjPmnu9uS+63Ue+dc
	5zJNMdSJP7u/rDoA0+xSDtx1QeRdRgdV+Is0P0UqUccAG5X8IjxJxxDdDJElrutJQp0mtXP4PC7
	P2Ywal3z1DYPtCovvAl3iBVxbkDCMlKhzAaw9PXxrCkBPAbKEKh0O4YDwWr/0pm4A3uoU/W9zWB
	IZAO0aNUGMlTL7VmuJF+GiwEdI6RXAKC2JMbgIP9vivO5OI7KDtMPTN1WioKyKmKJzSoMWJndza
	wSxrk8g8ofax1ruznyGEryBShpV4MnCdb37w==
X-Google-Smtp-Source: AGHT+IHKBRGJ6Q+jIIfyxjpoPEvNxTxw0yHBFy5IfbUyV2HSAIYXiI1jCB0lNf27X4mjsLq2EPc8PA==
X-Received: by 2002:a05:6000:178e:b0:430:f7dc:7e96 with SMTP id ffacd0b85a97d-4324e50d6ccmr65245024f8f.48.1767612446482;
        Mon, 05 Jan 2026 03:27:26 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:fc71:3122:e892:1c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm99180248f8f.22.2026.01.05.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:27:25 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 6.19 2/4] PM: EM: Rename em.yaml to
 dev-energymodel.yaml
In-Reply-To: <20251225040104.982704-3-changwoo@igalia.com>
Date: Mon, 05 Jan 2026 11:25:09 +0000
Message-ID: <m2344ki9nu.fsf@gmail.com>
References: <20251225040104.982704-1-changwoo@igalia.com>
	<20251225040104.982704-3-changwoo@igalia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Changwoo Min <changwoo@igalia.com> writes:

> The EM YNL specification used many acronyms, including =E2=80=98em=E2=80=
=99, =E2=80=98pd=E2=80=99,
> =E2=80=98ps=E2=80=99, etc. While the acronyms are short and convenient, t=
hey could be
> confusing. So, let=E2=80=99s spell them out to be more specific. The foll=
owing
> changes were made in the spec. Note that the protocol name cannot exceed
> GENL_NAMSIZ (16).
>
>   em           -> dev-energymodel
>   pds          -> perf-domains
>   pd           -> perf-domain
>   pd-id        -> perf-domain-id
>   pd-table     -> perf-table
>   ps           -> perf-state
>   get-pds      -> get-perf-domains
>   get-pd-table -> get-perf-table
>   pd-created   -> perf-domain-created
>   pd-updated   -> perf-domain-updated
>   pd-deleted   -> perf-domain-deleted
>
> In addition. doc strings were added to the spec. based on the comments in
> energy_model.h. Two flag attributes (perf-state-flags and
> perf-domain-flags) were added for easily interpreting the bit flags.
>
> Finally, the autogenerated files and em_netlink.c were updated accordingly
> to reflect the name changes.
>
> Suggested-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  .../netlink/specs/dev-energymodel.yaml        | 175 ++++++++++++++++++
>  Documentation/netlink/specs/em.yaml           | 116 ------------
>  MAINTAINERS                                   |   8 +-

YNL spec and MAINTAINERS

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

>  include/uapi/linux/dev_energymodel.h          |  89 +++++++++
>  include/uapi/linux/energy_model.h             |  63 -------
>  kernel/power/em_netlink.c                     | 135 ++++++++------
>  kernel/power/em_netlink_autogen.c             |  44 ++---
>  kernel/power/em_netlink_autogen.h             |  20 +-
>  8 files changed, 384 insertions(+), 266 deletions(-)
>  create mode 100644 Documentation/netlink/specs/dev-energymodel.yaml
>  delete mode 100644 Documentation/netlink/specs/em.yaml
>  create mode 100644 include/uapi/linux/dev_energymodel.h
>  delete mode 100644 include/uapi/linux/energy_model.h

