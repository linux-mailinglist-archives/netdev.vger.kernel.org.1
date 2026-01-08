Return-Path: <netdev+bounces-248022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4569ED02022
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 11:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1114D3008751
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 10:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B253BB9EA;
	Thu,  8 Jan 2026 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv8B0xcm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E53C1FFA
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865153; cv=none; b=HfV4TpOWefdBOmm5Qj73g8hfTZIhkj8RA7H/ivMSdGjNSeR1Vv4+i/afzHglOqpyIKBLmDvjwhzeHbAzkJQhOhGcjEtmzSn570ei5iMXlXGbf+y2Pj0XBHNPZ4o4HFGC7mNhuWYtadGM5YaHcjAyURbFGILzChJXwCiXf594iaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865153; c=relaxed/simple;
	bh=Bq9lo2Ohtvj3XIL6dpPA64B4eaxXyOVIuYLGEY645Q8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=AyLOmlN3lbbCz/Kn97Apm1OgyGMGaIgTpPDEIVY5pW0xeNUS1lncibU5ME2YLSRotS974XLWBRYD0a3lAOG4V3jDvY8x3woTdb5LCUatycE1pplmICykYNN8BsvYw8b8bguJDn4v9o4YniFUlKoyoZo6MdtKDJReHYGsL8LXrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv8B0xcm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d5e021a53so21901245e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 01:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767865142; x=1768469942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=Cv8B0xcmLl2j34XrZnNE4IF+xqk2mfBFKkgsqzKcJJRMcSNfbR3ZFA/HOg1e9nC5z0
         3qO5L72saJeuTDPochuDP3wz2xZT3B/YzppFqT5zqtCpBLjigIeB327bs09GPAVtq+Pg
         kMz5bZ3BLp8hypDIeokNKJJW3P1FN5EQ3hqGwBPnX6dYbzUCWH+UDeRn/mlhb+L2J/oP
         B4N16eErEkznVxE2BiKNQ7ky6//0hIz4slCWwRRQDOlc7mMiY+SlyO/Q97mp765zyhA1
         rQXSwcRdIRZLXAVUZPAB/xZ6H4HDud9r5X0RsxPPQ4V4B3eNs+KFHgZn8QznWC5IN3ak
         yxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767865142; x=1768469942;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91O35Wu5Tt42VZKwq2kPLdWW5NTRjmE00iaWWCPrcU0=;
        b=m+430LwNYp60SRS8JPVQ1w/+WIgEbnVIEnXa55/Nb3SJyICnnCJOLkI1+8dgY0Do5M
         FVNI3NRN40hgdOWxbQfucBk/ayqxnWwCYj2P2MOaxxf2b9/GRZfahFTBcIEV64rDYVwR
         melaMBxy3ukKiIFXxDi1JKsZ4zTZyB0fuyGQlMulU/3v0kyx9YDCXjCsOPDTBQxV13gR
         Y7J2qiXcu6fPVrW6lYXCFpbVxlZGRREEAG32LYHSzq2j0BVQc2KeRU56J+jB3kVnOhnn
         JYeeexjgjRUNWC3IXACvosIR4s7ibuQ83Xli9iQYSXQfabr1V69DuGtIfz4Fw8o+sB9s
         5GzA==
X-Forwarded-Encrypted: i=1; AJvYcCU9nDtpxjR1svjWQa4XZYJtP4I0cY9b/xNKYf0PmuvGfYVp3EFM66vhohx7NdfU6JSkWzKq7Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkxkSpWKa3l2Y04l0vBDPCRDDfbJgucST4vVGFAufZ8sy8smo
	nOHdTLdmYHykYPSq08yky30TjbCQCZJrxwV5YSG4zkgiVL8O1jgkSkSR
X-Gm-Gg: AY/fxX5wk0NbOf11hp76q80j6ptxCTASjO9kzF882SCI1dVu8675+LoPQmMS/EYnNtT
	dYOLvhv3BGV7/gQWgZME9+12sBYe3RXfZvptKYBin22F3Z/35RvKMbBsAifMRTAdqNR4jEbrQgQ
	wFr7n2pNrTaA7WhexIfz/QdmHe/KtBEXK/eelaBjf09+fETerQ4FcZE5Y9iEkWVMUOkcDsn7oTQ
	L7ughiG88TuXz8+ERQdQ1GjQeXkXf1X7R9KlrDdHRYS6Aq3LJsF8ZS/1+hsf1pBZDZ1wupn7kZE
	2WH31bFr4Ymvk0feOfWr6vp8qoJ8TwXFHaYZsnpNQwH3cnoEDXc5zup5319VGNzTqro+o7X4Oo0
	hSJ0Wh4dJpKr7vpUvx+WHltnGHvDo7P7u7F0lpZllYfBa90GE56Y4VmSMjeTCq2iqTcMCke873L
	vfl38gaKQkwRKlaLxYP+WR2LM=
X-Google-Smtp-Source: AGHT+IE0ivurfeyw4RGMPF7H3eHa1D98hrIj7ko+VBPF2UVbcwlddpeCKfgvEgdfZlhOZHZZlhrZMQ==
X-Received: by 2002:a05:600c:3483:b0:47d:6c69:bf28 with SMTP id 5b1f17b1804b1-47d84b3476fmr69913435e9.24.1767865141446;
        Thu, 08 Jan 2026 01:39:01 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:8115:84ef:f979:bd53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d865e3dfasm33121615e9.2.2026.01.08.01.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:39:00 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: lukasz.luba@arm.com,  rafael@kernel.org,  kuba@kernel.org,
  davem@davemloft.net,  edumazet@google.com,  pabeni@redhat.com,
  horms@kernel.org,  lenb@kernel.org,  pavel@kernel.org,
  kernel-dev@igalia.com,  linux-pm@vger.kernel.org,
  netdev@vger.kernel.org,  sched-ext@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 for 6.19 0/4] Revise the EM YNL spec to be clearer
In-Reply-To: <20260108053212.642478-1-changwoo@igalia.com>
Date: Thu, 08 Jan 2026 09:38:56 +0000
Message-ID: <m27btswij3.fsf@gmail.com>
References: <20260108053212.642478-1-changwoo@igalia.com>
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

> This patch set addresses all the concerns raised at [1] to make the EM YN=
L spec
> clearer. It includes the following changes:
>
> - Fix the lint errors (1/4).=20
> - Rename em.yaml to dev-energymodel.yaml (2/4).  =E2=80=9Cdev-energymodel=
=E2=80=9D was used
>   instead of =E2=80=9Cdevice-energy-model=E2=80=9D, which was originally =
proposed [2], because
>   the netlink protocol name cannot exceed GENL_NAMSIZ(16). In addition, d=
ocs
>   strings and flags attributes were added.
> - Change cpus' type from string to u64 array of CPU ids (3/4).
> - Add dump to get-perf-domains in the EM YNL spec (4/4). A user can fetch
>   either information about a specific performance domain with do or infor=
mation
>   about all performance domains with dump.=20
>
> ChangeLog v1 -> v2:
> - Remove perf-domains in the YNL spec, as do and dump of get-perf-domains
>   share the reply format using perf-domain-attrs (4/4).
> - Add example outputs of get-perf-domains and get-perf-table for ease of
>   understanding (cover letter).

v2 looks good, thanks!

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

