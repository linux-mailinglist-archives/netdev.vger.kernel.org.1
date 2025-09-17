Return-Path: <netdev+bounces-223837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB9EB7DE78
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4005A325068
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1DD2D7809;
	Wed, 17 Sep 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ycno+brg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BBD19C55E
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758078626; cv=none; b=SACvX0CxPWJK+cilsfqv3YViBCBCWZqQw94rVEYkGh4YNipzFvEXldAeL8E2aoKbvMturr5gK4X38wEC5fnvSYgBvNuS4YOeZEIvObhm2YZjxJhn0VZEcgGNH3TRxrUtS8BFH+DTIpWDfmvbPYq5iIhr3xkFdqPNU5P0g3NETuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758078626; c=relaxed/simple;
	bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y4nq2/yVMlXQo0ITwZWYvH+mqW7VGYJW6MFxCBwVXIB8rTt82VG3M0YKUusrN46bB18C/ZHDWzicTIWCcvRxSBpg6k7sZ8Q0T9U0H0jBMpEK/VsukzoYKxaxFVB9VV++V72XEl9BkDMjdfctR/U1m9chsV64ORnYQs7EZEV4AxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ycno+brg; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so3336847f8f.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 20:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758078623; x=1758683423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
        b=Ycno+brg9GMmuW20SBgx/f2hvmZ2UcgvG+T/j0pNzBS9baci/+Rg0/0mYdr1ZF2VlB
         u8nHF2vMTZGLM2cPY6uJEqY7TDRAe6uedURzFxHRZA4nSbu1FLeghGfpBVWFmr7H6edN
         RWUK8RIKR8fhTb1jvDaITER2c0i+d2acFKC6va4UgUx0h5sQENd1OgdMIUeVAMRt0OIz
         dSHrdbaP7Q8e5TXSi7lsW3PrbtxzKPbz2/9UIjWyFoU6zmhbvmOCnn+O0qm4p2AeM8JE
         QHqMptLaWCmxnreGEeYe2TX9y2SJT/dpNK9kGaKCrrOEfnk/nWPK8ViAkddao97F4Yc1
         +WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758078623; x=1758683423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qo+k8NcZTsre/ht6MSdF9SSU+7BW0nZyjkH4oBSMWuM=;
        b=eH6WcXtaZ8JRg3GLA/7LyhGyvuSDtHfpj8lH4ws/6TAR+aHEAGHXjVCD2xw1NZLFQG
         fpjisRZYIsvu1d9c+7gBIYcXIzxVTMcCIc48Q1XY323ExGC7D0Q0F31gIfH2A2ATKm6N
         n/eXEq45CJIaQuICPrZ+UuE5mk+Lhd2/eLUTq2Q5Y8FV4Trr5G7fBQ7kefDeWOECZctG
         uFuB0uOwF+Ei69XFm23L9QI/udOT/PU5taVc0emkptJ3hMH+XovG+HC86t4HOf1w4rgJ
         F7KFeUhKSGB65cq3ptCdgOr+QUKUc9FyjrxdrWB6vON39YEBIaqJlMVfLZ2saPZ8OHx5
         RjBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdVOMroJgzDN71Jy0l2UjXX23NALwO3zPmYFqAvsD8iS4v+8XqiAQIsK9g7oh1h7b610v3v3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR6gVPuj7evLbDC7US+FQnSJDWvRhQY963wpMnQhIFxOwjS9gL
	2fU/JPhDxevkFuZkxZSAS9A0naYdsVDUaFsRPhWOIhlekQAk4UDkfPymWYr776vBrkqGfl1B+Z3
	TqnEWp3HcwasMKli2gyqZxeFcV5QNFow=
X-Gm-Gg: ASbGncu5V67w/krqhY1hzB2dTuLNzu24AkkLdBnwnanWIy++dKDMNB+8EtUhzPjjE7W
	HSEYTOCUW5TNYRRNMnVv0yh/GttId/p6hNrkPQowHZh2YlYgEIjxFYIZgWUgz8j1zhCpRUEXNW7
	QJrsY6gWo5fz/BM6kZRpzxR4YzNxzSkz4V0tCNbpsivdF41ankZmY/L8hQJQOs/VbaydpkkC48p
	8tI/ie++KyvZtySgjbCiE9YFQx0d0QL0VAHhCKHPdC4F8YIVbIjrW2zv05ob2HrpafY7yEFyw==
X-Google-Smtp-Source: AGHT+IH2rAtLPqjrPkzQAgRzLtpqU6GW5KqXZk29vl3BVB2lerYk/71eQQApYbtq59ICPt5hKbYpbTG3+CYs37kW9a0=
X-Received: by 2002:a05:6000:24c1:b0:3e7:60fc:316f with SMTP id
 ffacd0b85a97d-3ecdfa357ccmr500935f8f.45.1758078623223; Tue, 16 Sep 2025
 20:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912163043.329233-1-eladwf@gmail.com> <CA+SN3sp6ZidPXhZnP0E4KQyt95pp_-M9h2MMwLozObp9JH-8LQ@mail.gmail.com>
 <aMnnKsqCGw5JFVrD@calendula>
In-Reply-To: <aMnnKsqCGw5JFVrD@calendula>
From: Elad Yifee <eladwf@gmail.com>
Date: Wed, 17 Sep 2025 06:10:10 +0300
X-Gm-Features: AS18NWBRXY6QRQwpfBo0poGfWO1ILeFSm2NP9vXOGP2coW97SISUDWSiYlpGLTs
Message-ID: <CA+SN3srpbVBK10-PtOcikSphYDRf1WwWjS0d+R76-qCouAV2rQ@mail.gmail.com>
Subject: Re: [PATCH net-next RFC] netfilter: flowtable: add CT metadata action
 for nft flowtables
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:39=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> May I ask, where is the software plane extension for this feature?
> Will you add it for net/sched/act_ct.c?
>
> Adding the hardware offload feature only is a deal breaker IMO.
Software plane: This doesn=E2=80=99t add a new user feature, it just surfac=
es
existing CT state to offload so the software plane already exists
today via nft/TC. In software you can already set/match ct mark/labels
(e.g., tag flows), and once offloaded the exporter snapshots that so a
driver can map the tag to a HW queue/class if it wants per-flow QoS in
hardware. Drivers that don=E2=80=99t need it can simply accept and ignore t=
he
metadata.

act_ct.c: Yes - I=E2=80=99ll include a small common helper so TC and nft
flowtable offloads produce identical CT metadata.

If there=E2=80=99s no objection to the direction, I=E2=80=99ll respin with:
- the common helper
- act_ct switched to it
- nft flowtable exporter appending CT metadata

