Return-Path: <netdev+bounces-186527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EC3A9F85F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC721885AE2
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42C7291166;
	Mon, 28 Apr 2025 18:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFtXtVNc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C12F7082F
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864426; cv=none; b=Z18YIsxYZrVRavEaLlc55zJcLMhMtXjgGknqRVM6x7QjzhAO5mFtldl+DWvou3EUa+EZ53RsoZRhX9ufjkyEcGxpnjc3xbF5EXU5bNMeWrEI8q51CVV/Xy6WRUCHJOszN9WZaKQXf4euDCnA7ycxzX2c4OlUd5nsCdjGQ3R009A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864426; c=relaxed/simple;
	bh=MY3SGWX6vvAb01RFrR3B0sqoB5Mr347jE1sqdtNHkok=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fmesQWf+Cw9rV+semuvWy9GgjBBSe8OU7+iFKe0hOIv0CHdxnY51ePqx9o2Z/0pzuAJm2dTxZR24wfObh7YgxGCOLGeyu9KI4M/oW70SB4dbRJYwL3YnueequWRDBeYeBI+1DOn/JXIcE1Q25tZAQtVSNNvIjS+5TU4Lq6vackA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OFtXtVNc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8fb83e137so52629626d6.0
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 11:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745864423; x=1746469223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVUlFqXUuoZAbJYxgMSJUL7ug6wHvgo6+5LfcAw+Jho=;
        b=OFtXtVNcUY4Y5zaohiv7s5mBU7DRR3S/mhJRMVkYd3TF9+TEyLlIP+SyFwbz+5iHv8
         TxadDfita+51KFn7j7FtELnCWbuwd9k6Z5vY50aZ5atDgBXP5lI/qS3O1Z4l/esso+Zv
         6HMikOWiooIf7M0LRNzX+00wTw7apzvmp+RD25myUSeCeDV0L0lIM89AOedQl7j/3f9C
         8jNJjefhVT8x98rxjkY5Uo64bdckxQjNea32QGLuSkTtuZr+fimUhT9DinNhZzc6KfY1
         P6ENgG6KbMYu01G8QTKYMdLpXcveHKCX2vk9QJ8nsnFm6R3VuFKOSgAmRAytteBWmmcm
         0THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745864423; x=1746469223;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DVUlFqXUuoZAbJYxgMSJUL7ug6wHvgo6+5LfcAw+Jho=;
        b=uFg/AIXaZDUL0kG/bXZnmeUAfwB4nXH/Do+l7BILNLnhieLC55r0LashFaPJfb9sFH
         +zsY9+rpD8Cv5qJDxKfaAQaLVopoSzs3vEVDx4Pwar90srOazKAT/RYhHTVcDgc+Tp/b
         PkOz8zBUok0IEiNVPvMFXdamFeq+3yJj+I34ES6zRSh7HxCZTBWiQlf4GsskewHaBJrH
         GLaIGSqKtN0+/0SMb+snyV10FF812V+VvSmPyedZoYRfu+CPHZoOmc7nkARTectY5WSk
         Ea05g3OoxW9ALS53XpYJXWjIxaI5Rb9o0sKV1maD4dq9NUMFPrj4oLnDxbzkCgXyUXPx
         3qkA==
X-Gm-Message-State: AOJu0Yy7r8r52OH1FAq8CLz14EjwuHwsW1Y5/T4ZUsICdKMcqUmcK1UL
	dtnMJ0ZJGzRncYnmirS30MAyw/Y9GpSIA4rbGsTSRuC5fh9S3fhV
X-Gm-Gg: ASbGncsQ65eFNCmpy3rfAc428Eaqgyc08/5gyB4J2xcEC9PQwvYwgp5/ERS3scIsADR
	9gHx82ei7BCV7KHvv2vMJuPrXMT+M33Z8hA3lwTLDAkrNyRTE306PL5Ap0qE5ZyC/HdzE/yLhMo
	aYHyNOWw7jUU9ZVt7Vw2DQopPgTBzDJX63tTl0zlZeAJVrtr4QIoUm2Xe8BTht1V1yc7vXWikJV
	82ChLOnC4I77jCHHxelGKLB2nZkKuQT1bP5P2KN6jgdb2o1EJPZ9lIhghPDStN+TGgT9rEZxPP1
	rx/wUmMrAFwPYRhjHE7E+wQlwepI0LqjN7Wg0W1QL8N6XRCZxnZyDzvVR+eoE9VTUEewUG9teiO
	nUok79tD8PPF3iBTs8vRF
X-Google-Smtp-Source: AGHT+IHoc1tcILDaG263NCDGMVOP+8nEFIOW+r8zwPMeuco9GL0eNcDOBoGsZjhrJrlNniOvWDCCIg==
X-Received: by 2002:a05:6214:27e4:b0:6ed:15ce:e33e with SMTP id 6a1803df08f44-6f4cb9f1294mr255303406d6.27.1745864422803;
        Mon, 28 Apr 2025 11:20:22 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0a73c83sm63586026d6.92.2025.04.28.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 11:20:22 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:20:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Martin Karsten <mkarsten@uwaterloo.ca>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 almasrymina@google.com, 
 willemb@google.com, 
 jdamato@fastly.com
Cc: netdev@vger.kernel.org
Message-ID: <680fc6e5cc652_247f7d294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <b65404cb-cd51-40ad-a6a0-d7366391da7f@uwaterloo.ca>
References: <20250424200222.2602990-1-skhawaja@google.com>
 <52e7cf72-6655-49ed-984c-44bd1ecb0d95@uwaterloo.ca>
 <680fb23bb1953_23f881294d9@willemb.c.googlers.com.notmuch>
 <b65404cb-cd51-40ad-a6a0-d7366391da7f@uwaterloo.ca>
Subject: Re: [PATCH net-next v5 0/4] Add support to do threaded napi busy poll
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Martin Karsten wrote:
> On 2025-04-28 12:52, Willem de Bruijn wrote:
> > Martin Karsten wrote:
> >> On 2025-04-24 16:02, Samiullah Khawaja wrote:
> 
> [snip]
> 
> > There is also a functional argument for this feature. It brings
> > parity with userspace network stacks like DPDK and Google's SNAP [1].
> > These also run packet (and L4+) network processing on dedicated cores,
> > and by default do so in polling mode. An XDP plane currently lacks
> > this well understood configuration. This brings it closer to parity.
> I believe these existing user-level stacks burn one core per queue. This 
> scheme burns two.

That's specific to the AF_XDP use-case where AF_XDP also runs in
polling mode.

There are other use cases that more closely match DPDK, such as an
XDP dataplane. Conversely, DPDK with reinject into the host kernel
will also have to handle the signal or polling of the second stage.

