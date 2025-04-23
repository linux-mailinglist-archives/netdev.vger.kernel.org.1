Return-Path: <netdev+bounces-185254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A01DA99824
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BC67ACBEB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064328A1F4;
	Wed, 23 Apr 2025 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R05ie7IS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89688280CDC
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745434213; cv=none; b=K6xd9mn8x4wY5/rtup2ddL/nDEj676j33FeZddL0joc+BtW0cVR9fJuvVea0F1Cx9erkAqbDJZCCR0dtvmYRR+TMtlQb6XtxJW0/rdmZO2uY0ZbvakEvTfVstOHPy/k3XxPzQheADdt117PMCSlK/LTBbi1pQ8HWzeWrmv/E/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745434213; c=relaxed/simple;
	bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGQiLfOqK9PuU2DgFQoPP3Gjg22+2+WpxcMHKoVQP1BhQLeBoTiaKBPHtffCnozfBeh7YjMqtHzm+EsgIp3vEGF2QGtMK4JlI9U5AsowqJNOClV2fZnIX6Um+f3/52w/YVpJjxiMDd90mYvpZt0JfdI8N83xRa0TYftq+rLfN2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R05ie7IS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so41715ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745434212; x=1746039012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
        b=R05ie7IS7KrtSMqRsawPTOIyER+HqGpT8JBOwHimX/pj4e2yKyMrYOrLnakSRMRpGe
         CXxMvbnLo3uDd6zmWC9frilWcOlP5kSX1NpQRxP4bqdysVXAZ4Akuwvb+BnynxOZ4DGd
         Xsqm6Z4u2QHBlf94k1nqEp/0J4zEkdvY9DtxWdA2NwLJMKEG1qBRf4ZRf5K9b/6Zpf59
         KRTu8IxUOswNBKAPk4MqtegGzgLfcnAosqYbwX+8X2yJHDmb4UHcSR622j9z3el6TzTx
         qCqAL79FJWXVSVzKv3Ql+ZOxdPylHDrJSB0XE5yoZRa8rW67N392oXKpZyrW2M9/pCi/
         lTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745434212; x=1746039012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46YI0j6vLtCLaxnHlsMJBI+Z9TXQj79mXcDdZPes/Fo=;
        b=Z/cH2r2r0c34GCbJFHFshKTwq/sF/RrWx2FYLFVSuH/M1OMjtQ1K+ku3g1lPObmIRA
         OBtkxBPhzt3LfTPjjnsadpFcl4KNMUuALr1TnAQN0Vm2m+tSOogZteyPkwjj3vUmI9v0
         c+j7nPL1/5trhHbPPURDNI9QWwA4MBrfopxkWRKztPXHaS/c5ChsAtD2AVsj0Mz8/3/w
         xlLn6m1l93mnf4roJj0kufCRNmevW+9l32CkYxoEpLMIshGTuH5mpAG9Byn7lWuhT4SW
         7uKOlqmTFt05IQVPdscAI7lOdTlB7iwpt8W/+7XILb0RkXvQrbev5Og3qpoygl+tbZ3j
         93AQ==
X-Gm-Message-State: AOJu0YxXSjrooAoYzX4qs7CBJ0S/4vijg7GQ2ZlVbGE2I1PYHbctp1jO
	17bumkk6IVz1I85ggQGFJN7ng+X8OeqXTn37zWkEzPrTnDG8C5/ISTAuO14zuope8+bU0MEutQh
	/G4CIcSOq/fLb3x6XntDGCYEhknY41FEl5d3Jj5TWIYT3zGYSSQ==
X-Gm-Gg: ASbGncsbfjijxP5fd7P3KDTG09n7bCmEvcq+TRMgrWAbtX6TzH6p3Z0iICImVddIeAN
	JlyGT6fwGv4+lMe1vdLXoRWvXTymxDhhXEH8of/rJMp/kFn3s5wkHO/QuAvOD2l6FYjr8BRm9I3
	6J0snlmNj/3c+0oO3og50Ujjl4JSQrSHKH6tAmy3tJ4uS0saZ/LxGS
X-Google-Smtp-Source: AGHT+IGDdQr4gPC/57wQTS3NlPWMgh7VtzJjlRR+R1rpkZIj4VicuBwBY2NnnChIvMtHoNNYZlJ8koUe45NHhKsTg+0=
X-Received: by 2002:a17:903:3d0b:b0:215:7152:36e4 with SMTP id
 d9443c01a7336-22db236f2a4mr299635ad.27.1745434211536; Wed, 23 Apr 2025
 11:50:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423153504.1085434-1-cratiu@nvidia.com> <20250423153504.1085434-2-cratiu@nvidia.com>
In-Reply-To: <20250423153504.1085434-2-cratiu@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 23 Apr 2025 11:49:59 -0700
X-Gm-Features: ATxdqUFRoPAxj8O5gyFHvPrpXz0zS8j_z75QAgKXLVKEmLgp6XG2WdrYdvwRpIM
Message-ID: <CAHS8izPSH9UXZwrETq2ze8_-gZRLmJ+nsKQeDp9EXm-PVUADjw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] tests/ncdevmem: Fix double-free of queue array
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2025 at 9:00=E2=80=AFAM Cosmin Ratiu <cratiu@nvidia.com> wr=
ote:
>
> netdev_bind_rx takes ownership of the queue array passed as parameter
> and frees it, so a queue array buffer cannot be reused across multiple
> netdev_bind_rx calls.
>
> This commit fixes that by always passing in a newly created queue array
> to all netdev_bind_rx calls in ncdevmem.
>
> Fixes: 85585b4bc8d8 ("selftests: add ncdevmem, netcat for devmem TCP")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>

Thank you!

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

