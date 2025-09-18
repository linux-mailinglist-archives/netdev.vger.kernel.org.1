Return-Path: <netdev+bounces-224252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90DB82F55
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 07:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E11C3B49E9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 05:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA302749DC;
	Thu, 18 Sep 2025 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1bCS5Qxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFEE288DA
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172367; cv=none; b=keer3aOtQDqa/pBBu35WpKE1mjAH8HKl8KuODS3iIrE1dSR+rFB8UGoxS34GU0km0/cvKG67FRRiXSrrSX7zRCAxDHSF/+B3MSWiDJS5+IcwCW7cuPbUBlx68LXqQV6lj5omUcH5+WwkML6MJ9jkMqioitrhbOcglaRiQVIUHxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172367; c=relaxed/simple;
	bh=Mh3Rb8qzvN7yL5v05SvQTB+/2yoj8j78rm5Ni0AvREM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQf3bpDAkqIEN8BM26aIGB6mAgADEuvKIrkGzuDcaAB+Ou0SsFFOQhSwx05uF1Auiescr7oQd8rPQgY7xZiTk4ZJDWxZciRZreZD+C1ukmxyNHUxv7xRiPdpvnodE5751J2WdzdPssXlKpEMQlEHDfEmQEBtKK99CRzl2WL5xW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1bCS5Qxk; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b5eee40cc0so5618041cf.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 22:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758172364; x=1758777164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46GgRE9cJRD9WIMiWmVC4N43zD13z9B2YDaD/7KbtrA=;
        b=1bCS5QxkhvmDeV84fEQkaWHIfHEKLYciK6TxsyxSR3a9j+MA6X2Q8pooM4bF7wG3CH
         tYgGsYmVi3i87C4JU2dHD00d1ToTikogRuWkbWuwmjwTo+5FYhnfPNF2JngC6i6zhbQy
         0phqoZatZN9JBb4cNcVkmofa57Qbep4AFNJggV/JAU40DWT6132VktV18P/Jh4NCcMeP
         TBF3+04AaAyR5S2AktfTtmeADbO0wFQhLun+BDo+5U+/9ZAslUI4rdGxDtRyqRT9vojB
         XNv82oDmHCz+LuQ0ShBTAyxb60H84qGMMl2NY9UN4RMoPh+zrvN4tBXkt4JrisRaf+fg
         wypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172364; x=1758777164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46GgRE9cJRD9WIMiWmVC4N43zD13z9B2YDaD/7KbtrA=;
        b=g7wJLZ8ahZFEjt5pLyh/cdHuSDA7L+edBA4o91mvPsrQibAW67jxYLpH/P8OwHoACp
         abDf4s49bEFkPNRASECFpnKRzqDpLYUcaJuv30x34f7gHQqtrW+tF9xY0COBdPWsigci
         bg9yH39fnBmfBnp2l60u1Ly66bhdUC2JYsVsdV6rtnGUN2AZ25YaLnseDJRSvywrqjgj
         qClmcUpZ5Pz0h4j6U4ozcyMhYEKKiILKzmxTbZjM3DPv2cXaH7VX+kfKh94s3opN+nIp
         UCZmtlRTNGSJXr3+ahQu+VPObR7EcXsw9zC5XPFn3rHn95gVPg2ZtaBJo2zvgFBf6Dfz
         HI6w==
X-Forwarded-Encrypted: i=1; AJvYcCV1iOAjYzYI5uCQHEG+frxFRnDrj28Vt0rF98W+Y35R1XkT07Kk7Ktni7NyNMzxsA9svWUlafU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhlVTXi+81a2eak5CtU2ggKqOaMMYRcX3iJ97oRZVcY4Apj1kM
	sRnhPSvzG2bbfQmStzmgh7fQm2n3OstjkXZHOMAqzGr800Wi4r3Zp6g2fDty3jCmNLWZpTO0wpe
	cMFMX4AOVFQIDp7/rzjj3l9bnACOMhrT0bwFjfxpz
X-Gm-Gg: ASbGnctjpBu8kOhkfmquNj76HykKndfQWdIIsYmlle8z1pCUnYpCZ+qdphefqQ5ezuv
	+9D461wUjApwl/SWxxOban9uzcgqRm2ezKPdHaKfGjvSb7RuN3Pwmmopd8wirnUcLuI1KA6YFeq
	nZTS+fHPmlJAkLfja+5gZmylxE0LBXtv+BoZSywFZ82pkZBWhAHB/kJZk19sJDPO5m7i7zBjvH3
	Fr8Yq4DJvGq4RvMBHXTqB4uNblLHgT6
X-Google-Smtp-Source: AGHT+IH2eMsycX5qrNhd3fiNSpA/EDn3RQVVh2/eFGCePPiTuhmd65h+bpks81OoXdbkceVO2QwJqAJyquBk6/CKTMQ=
X-Received: by 2002:a05:622a:1a02:b0:4b3:417a:adcb with SMTP id
 d75a77b69052e-4ba6ca8d6ebmr60180621cf.84.1758172363628; Wed, 17 Sep 2025
 22:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com> <20250916082434.100722-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250916082434.100722-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Sep 2025 22:12:32 -0700
X-Gm-Features: AS18NWBW4UjUVwdr3JfUY4L8f3cpv4Wq-6_LdiqGPFoy9WDff-KYdYxjvm7ff7Y
Message-ID: <CANn89iLewmikW_R5hFrUiwnOBJTYxtK5_d2RVEQXM4e2hNFmyA@mail.gmail.com>
Subject: Re: [PATCH v19 net-next 10/10] tcp: accecn: try to fit AccECN option
 with SACK
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 1:25=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> As SACK blocks tend to eat all option space when there are
> many holes, it is useful to compromise on sending many SACK
> blocks in every ACK and attempt to fit the AccECN option
> there by reducing the number of SACK blocks. However, it will
> never go below two SACK blocks because of the AccECN option.
>
> As the AccECN option is often not put to every ACK, the space
> hijack is usually only temporary. Depending on the reuqired
> AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
> AccECN spec) and the NOPs used for alignment of other
> TCP options, up to two SACK blocks will be reduced. Please
> find below tables for more details:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> | Number of | Required | Remaining |  Number of  |    Final    |
> |   SACK    |  AccECN  |  option   |  reduced    |  number of  |
> |  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |  x (<=3D2)  |  0 to 3  |    any    |      0      |      x      |
> +-----------+----------+-----------+-------------+-------------+
> |     3     |    0     |    any    |      0      |      3      |
> |     3     |    1     |    <4     |      1      |      2      |
> |     3     |    1     |    >=3D4    |      0      |      3      |
> |     3     |    2     |    <8     |      1      |      2      |
> |     3     |    2     |    >=3D8    |      0      |      3      |
> |     3     |    3     |    <12    |      1      |      2      |
> |     3     |    3     |    >=3D12   |      0      |      3      |
> +-----------+----------+-----------+-------------+-------------+
> |  y (>=3D4)  |    0     |    any    |      0      |      y      |
> |  y (>=3D4)  |    1     |    <4     |      1      |     y-1     |
> |  y (>=3D4)  |    1     |    >=3D4    |      0      |      y      |
> |  y (>=3D4)  |    2     |    <8     |      1      |     y-1     |
> |  y (>=3D4)  |    2     |    >=3D8    |      0      |      y      |
> |  y (>=3D4)  |    3     |    <4     |      2      |     y-2     |
> |  y (>=3D4)  |    3     |    <12    |      1      |     y-1     |
> |  y (>=3D4)  |    3     |    >=3D12   |      0      |      y      |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

