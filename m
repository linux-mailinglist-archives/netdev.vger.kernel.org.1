Return-Path: <netdev+bounces-221364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124E0B50503
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC85542A16
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2835CECF;
	Tue,  9 Sep 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tH4nqUXa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24743570DF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441358; cv=none; b=Za4sX5JVz12+7lQ0d9KUZJF+37fsFT8rS91fANO5AFWkNDzRW7ITtQhbcQq5zOpi066xBYsbU63MLOg8V9Wsg7gQXR+Lf+3Dvu1+2qKwRD5ABZ0WbSQI3k0VCxjHW1HUZmLhHCy0TjyWYr1bLdY38ZhrW/q0T3DLDLD7Ijgh7dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441358; c=relaxed/simple;
	bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAha260aWpAxJs0+pOsxHvNxGQaM40WhFVgZZkJsnZvBOCTY11qTCysm29mKre1Yg9RMOB04WOgA1MyODULEgFgjg+UogzgV61LwEKNL3RCxhDcaIAJ30Aycd9yfZ3KEmdP2ze9Zof5rzAo67VDxifaxUV0MCngcms74yaSwnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tH4nqUXa; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b38d4de6d9so30815261cf.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757441356; x=1758046156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
        b=tH4nqUXaHdu8kr4QNEFqAlWvTeoRqWZdmEZNR1lFeKlTwlVFhYU/o19AJA3NCFafE1
         Uo5rdnVAnvQLinhGXlPZPty1VnC0ymcSIAr3nrdQwEvyfhBKunOoqczi8d3SOSSbX7W7
         GC79P1EvailNAcOS0hwojWiEuNVyfyApT9szGh1OlGfR2Sj6OTvvXIBTXL4pJJLj86zt
         R2ycd8vetZZdqBVOpQ6aLGS/NLid8oOfKMQUmzmp1HUrnAMJtm1t8A/HYikRv11tHQcV
         okL4epUAZ4eYiHiWsGwmS+CsI+S9gXcvVHXtxd4DZ5IbdhOZwce35I3mVROrfs+DkNxp
         USrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757441356; x=1758046156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lATgt4xq628aM1dc0TtLiWTkPU0OGz9Nq4M1dAe0Ps=;
        b=U7SML04BY5/js3sb3owUb3nmpidMFpGE1hAI8XU9JvXSRgbGGlStXYpSfr6XSP+GdO
         eK1UyGPgedFGr4siRqhDG1kK62RPz+HLFvT8S2YW7wmEMYA4bkCUh5ya62bCelH19mDU
         wFlW82w7J1rDPJN5L85wmCMeMANq26BgCW6qpAJKvu2Osii5e+BnFhZLJ4/r6PoozYb6
         Tv8/OqX2xW8q6Zvi3qkHfEC3fbHMSSt2N5dmR6EoaE3nilYK8UdmpYHYqL4YNYY/xzmJ
         CszYizj/zbRFh8OpDObi1GhnOPTbxArc4O5xaD8IvzWMqsykDVAMSIRmnBk4Zp3zY/Qm
         WzAg==
X-Gm-Message-State: AOJu0YyubUddCrRJKCCrLf8/ErDDeI6BFTudIfPFdSBKKfInEXMRZKaU
	4Ewsuerw2dcHczJ1a7v6zF7ETYXsUFFKp92igDBc7N6R4XXinTuOIDSIPhzv/LREyw9o4ETmmt2
	KBKgKTa7utz3qzsUJP+4YEAk+8QhxK01o/pXpwCmd
X-Gm-Gg: ASbGncssm/2vkOrntN4BHih2zvkZBSOFVHBUURinrIhbmyyvyCm9MJbet4AZths0OqH
	KyK74f8+VWMeHOE5eByynPgxr4mq3xJFRYXMYnwMLomH7KA98kWu7e4gZx9mHA/HAkIrhFUC7Yv
	CthcjfUzZ9uvdrhboFUIF7tws+7PH4qrjPYlwu8aiGzTdTr5u5wv6MPj124scedVSzwu1igrGL/
	5aFda8Fg9pvz6Y1vVvKmiEKLHDgVK/Hn1r18eglwV/X2SCkegzcQ4mMo3M=
X-Google-Smtp-Source: AGHT+IEMJVPF0HWMiZZlxTuDQEWujN5ULFYWrs76ILnh137CJMPr/ZtX4aEHVgPrCEVxVSnaiVmMbLpWfGDRRvW1sws=
X-Received: by 2002:ac8:7fc2:0:b0:4b4:9550:47e9 with SMTP id
 d75a77b69052e-4b5f845562cmr138967051cf.67.1757441355166; Tue, 09 Sep 2025
 11:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908175045.3422388-1-sdf@fomichev.me>
In-Reply-To: <20250908175045.3422388-1-sdf@fomichev.me>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Sep 2025 11:09:04 -0700
X-Gm-Features: Ac12FXyKIQhR8dUKP0Ssd5jrrL9lQdx2gpWmqHF7a77lpEUCQ7AbJCKSHD5diPs
Message-ID: <CANn89iK61cuFiPRBiF6owS26Em734ioC35tXGV1RMS_WyCZuTg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, kuniyu@google.com, 
	dsahern@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org, 
	Mina Almasry <almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:50=E2=80=AFAM Stanislav Fomichev <sdf@fomichev.me=
> wrote:
>
> tcp_recvmsg_dmabuf can export the following errors:
> - EFAULT when linear copy fails
> - ETOOSMALL when cmsg put fails
> - ENODEV if one of the frags is readable
> - ENOMEM on xarray failures
>
> But they are all ignored and replaced by EFAULT in the caller
> (tcp_recvmsg_locked). Expose real error to the userspace to
> add more transparency on what specifically fails.
>
> In non-devmem case (skb_copy_datagram_msg) doing `if (!copied)
> copied=3D-EFAULT` is ok because skb_copy_datagram_msg can return only EFA=
ULT.
>
> Cc: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Eric Dumazet <edumazet@google.com>

