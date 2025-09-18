Return-Path: <netdev+bounces-224248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29219B82E29
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 06:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC294A390C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62C23BCF5;
	Thu, 18 Sep 2025 04:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X8X9Sdhh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E22629D
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 04:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758169749; cv=none; b=bUYQUmC/S6jj/GCqXMufOsrJuzYjDofXI/FrBmOKBLOFVlBFscMtsHId9zGhl8qJh1H7ccBwvqy6d5zaVrojOTBBQcHO310ybOomR9pJVfCMLLGDhLzXWhcY+c5NDfz8MO2Asyu6wv2ypS0m42oKzQVu3jsGBA3vlcuYS4kAys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758169749; c=relaxed/simple;
	bh=6CV2doEskI99IYmAG+hSlmSAFaeQNark+C2WiRO+/m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Es8SQ81KUkv87IsXQp7WOl6JFsv68I2WAgmRPUqJIB9lS50GrWJqKZ8ic8WANWyD1wdmXpSomhn0d+3wDdWSDB5Y2MxSHT6Td0rG9o1rmXkQfPzmhNegxeRHzTHAkWAeyr2loNzeTBRkOUku5ayZhh2Qoyjn1zg5Ba/TsKsQHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X8X9Sdhh; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b5eee40cc0so5348431cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758169747; x=1758774547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CV2doEskI99IYmAG+hSlmSAFaeQNark+C2WiRO+/m4=;
        b=X8X9SdhhYEe0S0nhk6Cz+L+GpPTnzqKGpdzhWy9GC+DrLcB62+nIcAfAXPR4WOSCsU
         Y+g5mCYH440EgMtW6Mxyfba4ARQIj8Dnhs7SerUGEVqxIb/iyXkepyafcyX4ow5ViHjw
         HqItV8mph25lKCYis+FpeeDOtXdwiH0TCBhTF4OyRC8g1XEYK6G0rMwrehEM/mOsPZSa
         j7+Ip8SHTcnhRwpJcQSuvKIu0lQr90uw9fQoefMBUOJdXnEVdyGZMyvDEBB5KrjdQ5LG
         BVDV1RhM+S6hPxqEuoMqJ84jP4VBz91rGQ7PdBLF70YGusX6ES0xv0IeEA5Xl9qKEqVO
         Hswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758169747; x=1758774547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CV2doEskI99IYmAG+hSlmSAFaeQNark+C2WiRO+/m4=;
        b=OS5cyYgBQKjP3bXvMBFQffictHqs+4xXf4pBDgcTOg5OvDt4In+Gk7d+IjpvIE8bi1
         tt3Fp7Iy6UxgsMxACy4/QMYjLDOV072zfwS80n2TFJDqme1LlJrtK8oWbA29SnV9toMs
         SQE88WUo3It07RUQdxlmHzmf8bF2bpWO7i17xOUnI0Om/8+bpmG5XiEYeM7R79qgGR7i
         Xkj/ijgVi2xmGd7qfq4f9K3gi++6ZbDial4mjZcwu9sCJPpWigUYL7Hj91HofMQl+D4X
         2tABInasS/QqXYTgWn9Ttqs6+2swOWYKzNzFmstkGcvaXMLavABE/mHBc2wTeSTuxaC7
         ZJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUvBSMtaLFRlax5a5au10TS7n461e41YZIw4yBQfOjWbXzBfTuZoIOu+TcS2KcORip9Yoq+scQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsXco3h3d6qZlzQ1fcGcFW5Y+D/9fE/RyQCbIY6PLMqnrRYaad
	wNFAhtCmGhrr4MT2tRL5o/wARl5PMMjKkFoVL/+41nrczbXteRsxFsqkH+bYkxKBqsbzJPFLmid
	EsRVD/2VJs1EgrXPqHYIVoopmHtHEmWzZdQaAQBT9
X-Gm-Gg: ASbGnctnjWP0/ZMEp+ZBPA8aXmAWW9/HiglFkoQBpCmJAiSGL3xlKOxvxKinggAUjPh
	/YV52wIg7fkhBOFvOJoNhOF7ByeT1bv2vnebeCxkPGI69EZJSKmvMfgNKYA/hwUbOiiUZ9FDATl
	4bfro+Qd1lNQI1lYt/87r4pD7S5ey+omBjN/c20hXXCDzrUATYewgbqP1hTStZCJm9ZHhpMCI4k
	gTFBM7qX2kY/hqYGb98mRzNIZiqP57n
X-Google-Smtp-Source: AGHT+IGCsIwIv2s3V4/HLp+PiEMxAKgdWpwfyK0Ts5KhBgc3RBLlBM0krHRje133l5q96T4pejBqNsVk4Yc0FCxSQa8=
X-Received: by 2002:a05:622a:59ca:b0:4b3:50b0:d7f with SMTP id
 d75a77b69052e-4ba6b089cdemr60278581cf.61.1758169746414; Wed, 17 Sep 2025
 21:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917000954.859376-1-daniel.zahka@gmail.com> <20250917000954.859376-14-daniel.zahka@gmail.com>
In-Reply-To: <20250917000954.859376-14-daniel.zahka@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 21:28:55 -0700
X-Gm-Features: AS18NWAawYoOHSwZkPBtxV1FGo_6qr1iXxUEgWdahQqXVZQjeLTIXp6no2GeHOc
Message-ID: <CANn89iK23qny_x0KXLMAVFviEei3Sz3uj09LY=i7Jtj5-uwXsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 13/19] psp: provide encapsulation helper for drivers
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Boris Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Jianbo Liu <jianbol@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Kiran Kella <kiran.kella@broadcom.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:10=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> From: Raed Salem <raeds@nvidia.com>
>
> Create a new function psp_encapsulate(), which takes a TCP packet and
> PSP encapsulates it according to the "Transport Mode Packet Format"
> section of the PSP Architecture Specification.
>
> psp_encapsulate() does not push a PSP trailer onto the skb. Both IPv6
> and IPv4 are supported. Virtualization cookie is not included.
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Raed Salem <raeds@nvidia.com>
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

