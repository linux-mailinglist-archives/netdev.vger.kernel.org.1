Return-Path: <netdev+bounces-191803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C64DABD50E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 12:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF46189F31A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3247F26FDBA;
	Tue, 20 May 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qKs+eHDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847222561DD
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747737186; cv=none; b=FiqqqhSe2k1Ra5IpMFqUK3cao+sq9nfTVlHEnmyquMakyoParGN+f/8YjRRk8VvrOed4Ie1Nml3/x+T8TB8uAB7Ts0pnamGC8MQvjF5pWBPlz3SyzdYB+pshzyu4H8zLKidbqGS8p0V/hIoQ+yyIz97s3o16yH+f6ZFcNR1D8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747737186; c=relaxed/simple;
	bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rr7Xr4IuEzhhyi2PBhA+coZwF5/3SiQaFKsZP/vT/vjijEE1ZhgaptqlLy6TO+/90vY3EYAfm1xF+77oCR5BNUYgJx/ErSq6nLpvYw+6tku99gsE2tkIU949eZWu/Q9uwmogWDHuLnEKrakSbReQu6yOKZLl/efnd0WDA+Vd+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qKs+eHDZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c7913bab2cso545130885a.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747737183; x=1748341983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
        b=qKs+eHDZHhvDRHj5mo37u7KOUKF3tshjX8o4I1L9RFvJ+3OFvZkVQTK7izR+7WQYOX
         NQehIm62FXCPEnDoQVfQzEpKLJwqHuY2Eh9iAxS2bGsqB6RvC4El2xs9FdvR9jYX4MfH
         QxobEUG/RELT02qjFrD8s1SF1LfgXFMNODB/Tjd4c14nmvs3c3Fyvl99hsQd32V1VxR+
         2IHCOVGs9reylrlGkTFAIZQn9okrQy4S/i8DLAWPDNEFienfdOk8p9NGQnEoodSmX6cZ
         2Oy7aRROrY1Yxb/dCjCptN427ITLw08tkW5XTf+7qDhJnvO889FAxWG7nHP8MYfjbWjS
         T2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747737183; x=1748341983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxL3V0jtFjsgAS59v3HWejoNkoAFlD1rvXtnG6y2Zbc=;
        b=AHOnV0m9Z2QZzEhEhI+BxcMxjz7hhMuO1+LFJnMfVtK7cEfiveFxZqyUeonzdv2nOB
         LmDEf82tp03LBIZQYUTfb49kPKG8hj0cwHwtdyFWa4GE/CL/TxwfEYrUOyuAyM/3HW3Q
         SOgorDl390pVSY3dS6DLMQb5b5ru2N4I4Kd/of9q9kUUG8cteotAqlu45QirA+npFL+x
         eJwaCF3JsM7j6sik2N4Hev13grGktWoHqdgHIZcKn8kH/MyuNzIPMhiqJUgoV1o0VjmF
         u7t3EIyLVUC0/pBvxBbZM5ReZrx6eLuM+Mz/88Q8Qe2Pl9mELSblEE2SC0IbM5pT7D5/
         EmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVCRtdXS1/guosaLzprkkWtszztzaw+5vLTickPiD4wMW/2u9q2f3kcAVwDpY7C8UXJq/v/vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxGVM07d40MbaWhanLgF3Qucly3K0qr50noS8rlx+cRmp4Ile
	PTdGgbpF+R0AMcLaEGiY6t/O8BYk5gCs7FmGgaNIvFlWnh1ZOeB19WLd7KR+kguWtH3fYo+6vsA
	nJ5++4KORKbDNcj2fLHFQy5PPPfI7K8Fr91PsywwGbbLL4caZ37v0bbzq
X-Gm-Gg: ASbGncuHyaAjFjBSTPf305uSoYBmfNd4qp2VEJO7hzTgMnQbn2Aj4lamQK6ii58PJoP
	OzGhZ05eIwv9ocCqoiSNOEghTugqC08F0lLn6hbF0v52Z3asZGX+qckNyfb4iFW9ViX6fazYw84
	2EIgyNCRLm7bi6A6LD6EDDAcERce65uXaHvBes0LdKEVRp
X-Google-Smtp-Source: AGHT+IG9FNIYzv6dcarBeI5m4jU9YZIIxiM6brGC8IDm3JalGai8YqmQwl+Av8YyyDW0xxEWATAg7Oa4qlrNCUjkEMA=
X-Received: by 2002:a05:622a:2619:b0:476:9ac6:2f6c with SMTP id
 d75a77b69052e-494b079cfc3mr302490111cf.18.1747737171816; Tue, 20 May 2025
 03:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com> <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
In-Reply-To: <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 May 2025 03:32:40 -0700
X-Gm-Features: AX0GCFt1sJuWIW2WMnPNpQ3xQRDj0A9NooFrWJ-MWgR_JsUGZDwn2hf4HU1-mHo
Message-ID: <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
To: Paolo Abeni <pabeni@redhat.com>
Cc: chia-yu.chang@nokia-bell-labs.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 2:31=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/14/25 3:56 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> > group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> > group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> > group size of tcp_sock_write_rx is increased from 96 to 112.
>
> Note that I'm still concerned by the relevant increase of the cacheline
> groups size. My fear is that this change could defeat some/most of the
> benefist from the cacheline reorg for all tcp users.
>
> Some additional feedback from Eric and/or Neal more than welcome!

I have been trapped lately with production issues, sorry for the delay.

I am still working on an idpf bug, hopefully done today.

Then, I am OOO tomorrow, and can have a look at the whole series on Thursda=
y.

Thanks.

