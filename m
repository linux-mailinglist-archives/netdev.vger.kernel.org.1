Return-Path: <netdev+bounces-134663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A799AB7F
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDDCB232FD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736031D016C;
	Fri, 11 Oct 2024 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VUO9ZYgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFC91CCB31
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672592; cv=none; b=m57ZVVXKv0r+XgcheUHV0KgHGjwfSPt3w+l3BHfU4l6Moi8jToW5S6HSCVbJ5NGjTcMVdyIH98U8iTlXLW3yo752otFfkSaIjN0vxuySD6g688H+xD0bXzenJwmc5AfuHaBYGG4xuing/n38ot/gRO2Zf0G4vmoVuGk3iGPMQQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672592; c=relaxed/simple;
	bh=QIHwncpZoPxRu2uYUBr20M+nEnu60kU1bDm4StCp+FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsczhlsfjLY+VS1VLXzPc1ikrrS/z7yuBljkSUetQDwAnMSjkl+ao908RjRqrxwh2Z62mnSOsPqFBYGZUY0s61obwN0Ppr6IjhFM1hRAaRrRNYRIb7ZSfMDD63PFHJ4DGIRZmrQ7IIQGqhb0zi1GxtvnCv7Cr68B1PMmJ+aHD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VUO9ZYgU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c87c7d6ad4so3245399a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728672589; x=1729277389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIHwncpZoPxRu2uYUBr20M+nEnu60kU1bDm4StCp+FI=;
        b=VUO9ZYgUu39w9QKq/L+qfsHIn52oQkaV089XNPV1JKUFUT11ceG/kBfrPsmg8Y0lZU
         tvXCRhzKyK8kMSWN/PIN4sOcpFd6lFDRL/ARyQzEuAijIBptRrCOqPfueDI+b7XHfDTo
         16Nqc6etYljjS1GHnUdgOZFqG4oqBtWn59/V4+36/JMkSCdP9Ovhue9vyqNpIM3vpMWx
         kYefHKzFf1xoczxsY5TgTOMrgDdB9MOqGueAFhqq/Q4/bj/W21Q4pCUc6kIfqKkE/1gJ
         zR5bBOatCg/TJ6lDO6NX2p8guGKcBs9Y6R/eBVUzeZ07hmaLyqMt+LBwfFrWH0Ncjjd7
         39mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672589; x=1729277389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIHwncpZoPxRu2uYUBr20M+nEnu60kU1bDm4StCp+FI=;
        b=H3w7ivljQoxYOpyYYdGvpcnsjILRemFUOWd6GrV6BodMlwXLaQQ5IJ8xsYQ+m7n6Lm
         PntKe0AQQ04ZVJflfq0VbuPKJlDFS5hkgppGWPX3U/ZFWRHb/nlpYht3lZvdD7rucVve
         PWIIDtnoq6opPwzt1tiOkK0UOfZxcUgysZ9uzZCvmfJdXcwM+Y0CSI2WcLkO88XwNSxo
         9B+tCVD3x3BArStgyQxCUCyLDENByP/BLvvSpBfOUzWGZ0NEewcJSTwzZEM58pM9DADh
         SZbkwFBKKOl3UxlWJVl5A2RyMuz879dnDWKhi52x80KSV92ryIeTRxObgcGAwT4Zau3n
         G+vw==
X-Gm-Message-State: AOJu0YwajA0U2C7prnhJOmibbhZY+BHM0OesF3s/d9dvIL956TBY1t0u
	GViZwWS++RcZuQVeuo2yfDiC29pnUvlRk9l16KtqJ0hGqUdFLksy/uH3PFG2Pbu2x0pxaaxHolW
	nIbJYW+usYYkR/6Sj6SQYFH6l2eYqYrjs09qNRG4LHYeHvnSZIr8O
X-Google-Smtp-Source: AGHT+IHkYbxqk/YesUXXruMuOI+CR8GCey6RROAO7yQ6qHLCyPdTSNHKOsMY9NIgQ6xgXpENUM2N0HadBwodQZ7bUD0=
X-Received: by 2002:a05:6402:3512:b0:5c9:40e6:24e with SMTP id
 4fb4d7f45d1cf-5c95ac4175emr209271a12.28.1728672588855; Fri, 11 Oct 2024
 11:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184527.16393-1-jdamato@fastly.com> <20241011184527.16393-7-jdamato@fastly.com>
In-Reply-To: <20241011184527.16393-7-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 20:49:37 +0200
Message-ID: <CANn89iLT1AFU7KidF=w0UkA0PXVa=engQjZvCgsoQ25pDa3S1w@mail.gmail.com>
Subject: Re: [net-next v6 6/9] netdev-genl: Support setting per-NAPI config values
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:46=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

