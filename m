Return-Path: <netdev+bounces-238719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2F9C5E5EE
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB9203E02F3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75A329366;
	Fri, 14 Nov 2025 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24yBSHim"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA6328B61
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136585; cv=none; b=bydUeLOfoXY9u6tEkyKIY/8Ieh1i7L3DptXqZ1lB++P/rHiSRB1Ij/MZYXyggHwFv626qit8Ol4e7XMn/5uWhSReodni57xqvcY7IL4UnJPchRwi+3abOON3MVnKYm/aLqqP6GQPpNKyAAoq98XxJ3iEm4TY4rRIecBTcVWG83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136585; c=relaxed/simple;
	bh=E3OEtO+qewAwpL/2VbZYq4oTCOauczk1z3Y/sPX9pe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KT9Sil1PkzNFpGVCWrM4Ykb5E17Xw2hCYrwhgCagH/D04htXQMkowgbJsnlxFE/ZKWHdMNeixSyRJUJN1PZGX01b8IN/NeRS28/+iH8xaYHQ1NXWxafZVaj2raKfI+YxqQqVx2ZAUfpIOLMB2O3XppGGebm0vsm+vqbvps4rb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24yBSHim; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-88f239686f2so180772085a.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 08:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763136583; x=1763741383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3OEtO+qewAwpL/2VbZYq4oTCOauczk1z3Y/sPX9pe0=;
        b=24yBSHimfcM7JlhCNq1oAfcWuT3fdrpYbMBbq2m5I3oJJ5jEgimuzz3D4ikXee4D8f
         gycBF7m4sOeK9JLJfgvKz5NLhjSilKmxVrxjLPrrLGPsAKZUP1IxAA4I4npzKe7q2VKn
         L00FGnkuHEyt69RWV2hskLjsSrbJtupq9/CaXWT/k8cgjSMd/xt6oklYROt0yLDB5pyP
         WEPcQ/S5eRjOQbiw+TsHsZ/mB2G+gcEZOWLoKTPy1XJYZ37GEzaC6VquvwXSGQ+w4K2c
         9Gg455Kgs4FjrTkYf3Pmt8ft82hQAWAgYTufykZfQaTU/8K6JgTV4wDAiLnBWc7JIXQR
         9oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763136583; x=1763741383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3OEtO+qewAwpL/2VbZYq4oTCOauczk1z3Y/sPX9pe0=;
        b=SbALTendyLa6Cx0a8z+wiBX2bOn1WzPoJjxp2p6gqfdB1iVlk1UqO2SLZJycGNESD7
         3QK2L8BG5LMVzEdXlb+qhxDlYHj1kk958PbCg6q4xaoy4ZI/Us1FGEpZB4e9F/Jwnn6+
         KKkyHyV4pRSaAmgeaTRHj4k/vd3LVWkRPeDAyKAqbnIM3AVrDeyPaj+BEqb2OXbE2lZA
         YLkgci5j3siWc3g1w3z06MNrvsqGgRuaCmQKZWO3vyLt/4ZkpVtxt05JAqIYuu9vrSgA
         38EzW/LXtFPI7sCiAgLNBmnjKMORVDZavh3A+KCWucGYgQX5xUzJvXYoFaCJIxHzVfMX
         Zalg==
X-Forwarded-Encrypted: i=1; AJvYcCWeIpNosX4K1qkKctL7BDj56L8+Wl9Aq16qvL98eP4qEXYOG3PDuCbm5QsxZB/NVNm35yZ8uYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNFqJEiQYTGJAKBGLtIR9PlY5n5Njl1x8UvNg0hTSHueqyLs6
	Ajvir/1+5hcc9gSeAy4xgXe6WsLuy5g5d26CvrhQuWS3rpJwh7BxJciM0ZXBXuL2W+tBmpHg09v
	s/27MfzI8h1gTLQZzAHSSeZEftwcDD5RBpCIYhUDg
X-Gm-Gg: ASbGncshJV+X+BFUfQglE7kaHv1uXf6u01NMrgj+ETQl+49vhxgAzq12zb2RTU07ZuO
	ssBeZ03ELsUbBEWtqX9qiSuE+k8ZFxKEFhTlwU8L5hVyskNBtanWmayS753xS9R6Cy3QoCgcTwk
	SadgkNE+44fdp7TZHR3eSPgbBLsjzmUzNekMoIR+NMdtpqfbKkmDPjvE9lbLgK+KP/ZGOT339/n
	sf6U951nh4cdwjo4g0L8oZw7MENnPtBV6h3wPhK/Ouw3JeAV+DPrDns526z2qua1fmgA8F1qIFL
	27Cl4xyOQ9LOtkKk3IyYLWQ9jW+qUDRFx8LHoQMj
X-Google-Smtp-Source: AGHT+IF7Olm270cHo9e6aX0J+0tWrewts61PUWumQ3CbM90wBGFQfrvXgINvj4VSlhxpkmEzXhlWppJdOfFq4sG5pXM=
X-Received: by 2002:a05:622a:19a9:b0:4eb:b294:3620 with SMTP id
 d75a77b69052e-4edf2054bd0mr50801891cf.18.1763136582516; Fri, 14 Nov 2025
 08:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113140358.58242-1-edumazet@google.com> <7da3a15b-c1fc-4a65-bdfc-1cb25659c4db@intel.com>
In-Reply-To: <7da3a15b-c1fc-4a65-bdfc-1cb25659c4db@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Nov 2025 08:09:31 -0800
X-Gm-Features: AWmQ_bmHFPbq1XBRz0m_S-CUV3ntia1I4zk1dV8fGKnJu0t4Y1Zfs4hFsyoiXt8
Message-ID: <CANn89iJejn+MEBqrXDKxgwPZydU7mMrk2HYZqN+CF9Npyjx7pA@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: gro: inline tcp_gro_pull_header()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 7:56=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 13 Nov 2025 14:03:57 +0000
>
> > tcp_gro_pull_header() is used in GRO fast path, inline it.
>
> Looks reasonable, but... any perf numbers? bloat-o-meter stats?

This is used two times, one from IPv4, one from IPv6.

FDO usually embeds this function in the two callers, this patch
reduces the gap between FDO and non FDO kernels.
Non FDO builds get a ~0.5 % performance increase with this patch, for
a cost of less than 192 bytes on x86_64.

It might sound small, but adding all these changes together is not small.

