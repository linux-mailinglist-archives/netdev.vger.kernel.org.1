Return-Path: <netdev+bounces-204835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EF3AFC389
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B347C1897F30
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 07:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF88A215F5C;
	Tue,  8 Jul 2025 07:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xbDlRtcc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61317BB6
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958162; cv=none; b=sAT18GHUTKxiBxcTniRaNoVikHYPeErBbrLQ2j0UDg8dhuqN7e7fyMLgYuF8LTAXD/eDPKxv5N8aR3ryK/8n6gOAnpLXr3EINSpHgaFZkUYcIbmjLDlZWbBsSpsFK/JpPAeXhmVJqLB2U3Flf5yZtQlqz23VSCfPvQqSXZ1QF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958162; c=relaxed/simple;
	bh=/bsmLrCEV92C3mRTMXEx6nF8N09VZ1LmSwDi+/feHPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7ogkOs+ltXTIN5Z9vusyQT6TflGnkxrK0S8MfQmrLFgrwjwJS48Vf/NNOCxPXjcFwIPfeqVbbnFUm2oc6JKhqwabYx/gpgbxqjzq1LlEKKYtrEv3sdY7x5u1Geogy5bWiJpFW9Meg5Jg4QhD/x7QY5fZAbAhth4gIHyeCvdM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xbDlRtcc; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a7f61ea32aso85171841cf.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 00:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751958160; x=1752562960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjnYYgUN8sUeVXxQxm63poGOkmD4F1W7GEVvyuzu9n4=;
        b=xbDlRtcc4dYwDmaDextarjCqaduZ5q6gGJxM+BWj0s46+JR06pp+vv1iVFAY5dv+9R
         JFFIEk3NYIMaKo20dyAZyAZ/M/+ZUlF41PmRPgXkHfJNDqxFmlLaauo2zrCN/MTAYZQE
         79/2jLHK6jzR5V/Knxas7dshdQFnF1lF0h0aNxkwSPMC3G7x/WvsndASewu+j4xmHNWI
         V2hqKJ10yf7qIJ7YLV1I1LoIgeF70wJfZM5zscSkwqXZUJwB7C+pE2d94tRCe3qsaiY0
         gZ3q7W9HYcPPb6HPOmb0qL3k+d4pIE5gA35RlKwfuzGcRXU466VeK/LlLZhQ5erUaQN0
         QY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751958160; x=1752562960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjnYYgUN8sUeVXxQxm63poGOkmD4F1W7GEVvyuzu9n4=;
        b=Defi+iRbbVg962ZnymIac1N2rKVbAKyFqTbxE6VrPXP2GSQzGfVI3mKknwhGF6k3rq
         2AV8Fjv0Hcb8Wl9yA0WBsidrtmsapQVxzlyVRlLhz6QE+A7obrCxEjvS8zxcbHBAmY0t
         X8wqOsW5mN3oX9BJ0XauU3wPpB/JSDBmDfbvmdPdWrtqtSWHqIeGxBvqUp6Iyez0UPtS
         FdYVs+FJqaeGTRTtmo5br8a+JIsQ69rJ7Nc2xCdscCpkhTBohXyPnR7TlYaPaLqyp/zX
         J0eXyJ9W7BVGJoGVFekikUX9Ib1MlFjOoOXRICox5PPQFJr4hPQnbpxHW3hIL0Wg1RJi
         S0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVLlP2UpyRFy1BrcwZTRv6jLF9ejGvUaVuS+4OWNtWmUslsXglfoLhVRsIYr2/3Q7vTElS0vaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTeWGb0VYBGeIQN3cuumuz79kKfiIXOtGQx7PRfmDkCBovok5f
	tci34XqVXv0FkIPhtba56DjLgc541Czxlj+2yfggYT1Co90qMFLCujrcQ0z0zdonC5O89w7tFJ4
	hKo3k2XE7Zvx2i+Yb34+8J1TR7BU0bbSq4OKPIDGe
X-Gm-Gg: ASbGncvyz3VD0SKFGM7TWChVdWdpu+rsFbNnglfkt4RG03aEC4tgW20SVFH4RqnTh9A
	3Tdh5E8xTJ1kuWDxEdFKvKmuetihXrAoVKIkcc3u2Krzn6QRHTyMNmjJfXpM1Z9+JmLjngAjN0Z
	F2p92xE1fnIW1oTBBy3ETCOCnWrDFsXfTrYolfuBb2Iqo=
X-Google-Smtp-Source: AGHT+IH7uSDpiVpe1Fj99Rocw9bDMmEBNalQ6ed3epcu+l1HGsYsnbZuU8Yau4Do9HuPxlXIrF2VJmjWmHmWv12CS8k=
X-Received: by 2002:a05:622a:4e08:b0:4a4:3b41:916c with SMTP id
 d75a77b69052e-4a9cc6ad7femr37886061cf.17.1751958159958; Tue, 08 Jul 2025
 00:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708054053.39551-1-yangfeng59949@163.com>
In-Reply-To: <20250708054053.39551-1-yangfeng59949@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 00:02:28 -0700
X-Gm-Features: Ac12FXylk9_9JpdbK9qj06tieE_DRApYRaUt6LPCQH8g2ZXXGXwajRcN7lRdHhc
Message-ID: <CANn89iKo9PXZiCtPJYoauVesx9JggSSbQ_+PMt9UgST1vF1Z+w@mail.gmail.com>
Subject: Re: [PATCH v4] skbuff: Add MSG_MORE flag to optimize tcp large packet transmission
To: Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	willemb@google.com, almasrymina@google.com, kerneljasonxing@gmail.com, 
	ebiggers@google.com, asml.silence@gmail.com, aleksander.lobakin@intel.com, 
	stfomichev@gmail.com, david.laight.linux@gmail.com, yangfeng@kylinos.cn, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 10:41=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> When using sockmap for forwarding, the average latency for different pack=
et sizes
> after sending 10,000 packets is as follows:
> size    old(us)         new(us)
> 512     56              55
> 1472    58              58
> 1600    106             81
> 3000    145             105
> 5000    182             125
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>

