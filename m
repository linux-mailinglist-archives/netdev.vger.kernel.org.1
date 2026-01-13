Return-Path: <netdev+bounces-249430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C01D18BAA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1719E3009FD4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15249214813;
	Tue, 13 Jan 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RQbd5wCG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8E31A840A
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307587; cv=none; b=E5YTipz+McQxFPyY0NeBrOT8NzLPiZ1m2/z1py/clPie8LtYrOExB4wLzy90tL3G2ahr1YbwvCgBRbjjceUPZB2tBEoMaXaESIQHRbVQld9UjdSPz6T4lNtPMHfWcEaGdbFf44v8yKx59SKS+8NSo/ZySVbwQxygnn2g70CMXdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307587; c=relaxed/simple;
	bh=dEbEAnCGy+pafrbRBLIoJyaTclKmc9Kn8AmsVMZrZr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmvXJflHWgimZYLk8jXcE+UUa+4Js5BR80r3BjmdA3TXFe5BMPROZaMXD3ljF0Cf05rz9KgGJ8Do0yegie8C6Uxs7lVsXgoK0V6QsuWuc6/T34Dl/fHoDUsdPD5OhrrLBCdUYXVquh4o5+K8QIPvXHQgHw1Su4woRZk2qix5eZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RQbd5wCG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so12868688a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768307584; x=1768912384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88S5rbYPKp/7kLImc9Htsmsd5c09rInIOHsU9gp+T3Y=;
        b=RQbd5wCG69RdQTzp4U25QVSLsP8yyZxZd2ix4ds3Em7E5AmGzrzYqYcsVGrvhQu1OR
         Pi488xOJ74XRtwz92HF1RGIXmVqyPLow9eXANF40RyI0MBGOPwE/rZjE+P6XO4Sw0qaG
         xP9cCfDSRLVw2WdVDUEkAnB26HCr0Kv/JIRWVdPFf9kaRZARFpojduKiRGIoQvVRPNB4
         UBgoOLqDun3c01fAAyhuladVL0zA7KYUULkpBAbN0WL1Jncxjw5BdC1aMhdHWk/1lioo
         9fkBqxnoViCOmcFpNqeZuS1lbqTxi9ynElM1fdUbT10211V+5lihVQAuGYi114DMcvDl
         CKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307584; x=1768912384;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=88S5rbYPKp/7kLImc9Htsmsd5c09rInIOHsU9gp+T3Y=;
        b=XCrtzQ+aKp3rrqQV8s7WJYYJ+Kn6VdNFpSUbeTTR4XzCJC0S9zz5F19r64js87+3VR
         IWrWMaRxQduZbbQJ9NsnvNJITekxnGXQAMYplliG0OXiDpTYZ2HeQ1JF2VR+D2A+pVtJ
         qRJQHjpxzqX/GgEUVTWAuUQK2PSxL7cOLX2e9wEHE01InKFeuDzj8Kb7Gi2EZXURONNB
         7pigY3t/f10pWcBs5wDhxb25V5/kmJt7SCKfn0YcDG4T5t891NoPkGpZ4VLiOqHtII0M
         3xPyW7hCHNx5x2dmQXQcpAtJXaYBN4CXt6xf4poCPCJq5b6PGqIs7g+BGJKWUF1xumkx
         wjiw==
X-Gm-Message-State: AOJu0YxYES5CmUSxs0X0PfGbxzyvqkrwfRFUbUh4jYNVrTaGL7Cwu+BA
	HIwTiTyyNPXwdKkfFKhYp1+qARENwFjpgNvzwDtWGPY2S5CRjCP/C7q4djifTEghiYA=
X-Gm-Gg: AY/fxX4P3BXrq5aH48QRdULPBC7dYlw/7sX+Cdp680IuD+pL5uqEeuxTAJbw6Em8lOo
	UZjdFJwektHv/M7QApAKs0qJHePS5cm2T7xB6l7kIU9u3KTJ1WdCiHfwodU2rBWBn5H6B0nUA5F
	aXfCEPIVw+5W9h9AVn8GUFrM3HslPqSqt4OczpNZZqt5xFXurdbWw5gkzAhUxUxqPIO/6M9IOZc
	DL0By0mO4tDR30426lQYt59mAnFuBJ7VZP5U0QDElUjmAPPyDepfdkq2AAFU9mV2bjkd/qVNra2
	HqGMqTstbOjYeXTsiscVb1lgYsnSdQ/azI6KYs1MlWuxbsM81YxNzlNSNYz/iMm9f2X1DThzxnY
	hpspvLhiUHHCnAnWFXYJTzSJ7UNwuTlwbGxobffl0Gc7m7nIvkmgYDHRVDQO6LcfzOSuucoppjC
	lERw==
X-Google-Smtp-Source: AGHT+IHY7NQknvOmV9bLxVz7dTnEjqdLKDpwYX1JJB9eQfKUuNEJjCFIN/0JIzGRucK4wgXDThpJ9Q==
X-Received: by 2002:a17:907:a4a:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b84451e156bmr1964823966b.19.1768307583834;
        Tue, 13 Jan 2026 04:33:03 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b872152ee10sm497403166b.34.2026.01.13.04.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:03 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Michael Chan <michael.chan@broadcom.com>,
  Pavan Chebbi <pavan.chebbi@broadcom.com>,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Tony Nguyen <anthony.l.nguyen@intel.com>,
  Przemek Kitszel <przemyslaw.kitszel@intel.com>,  Saeed Mahameed
 <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,  Tariq Toukan
 <tariqt@nvidia.com>,  Mark Bloch <mbloch@nvidia.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 00/10] Call skb_metadata_set when skb->data
 points past metadata
In-Reply-To: <20260112190856.3ff91f8d@kernel.org> (Jakub Kicinski's message of
	"Mon, 12 Jan 2026 19:08:56 -0800")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
Date: Tue, 13 Jan 2026 13:33:02 +0100
Message-ID: <87bjixwv41.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 07:08 PM -08, Jakub Kicinski wrote:
> On Sat, 10 Jan 2026 22:05:14 +0100 Jakub Sitnicki wrote:
>> This series is split out of [1] following discussion with Jakub.
>>=20
>> To copy XDP metadata into an skb extension when skb_metadata_set() is
>> called, we need to locate the metadata contents.
>
> "When skb_metadata_set() is called"? I think that may cause perf
> regressions unless we merge major optimizations at the same time?
> Should we defer touching the drivers until we have a PoC and some
> idea whether allocating the extension right away is manageable or=20
> we are better off doing it via a kfunc in TC (after GRO)?
> To be clear putting the metadata in an extension right away would
> indeed be much cleaner, just not sure how much of the perf hit we=20
> can optimize away..

Good point. I'm hoping we don't have to allocate from
skb_metadata_set(), which does sound prohibitively expensive. Instead
we'd allocate the extension together with the skb if we know upfront
that metadata will be used.

Things took an unexpected turn and I'm figuring this out as I go.
Please bear with me :-)

Here are my thoughts:
=20
1) The driver changes do clean up the interface, but you're right that
   it's premature churn if the approach changes. If the skb extension
   approach doesn't pan out, we're ready to fall back to headroom-based
   storage.
=20
2) How do we handle CONFIG_SKB_EXTENSIONS=3Dn? Without extensions,
   reliable metadata access after L2 encap/decap would require patching
   skb_push/pull call sites=E2=80=94or we declare the feature unsupported
   without CONFIG_SKB_EXTENSIONS=3Dy.

3) When skb extensions are enabled, asking users to attach TC BPF progs
   to call a kfunc to all devices the skb goes through before L2
   encap/decap is impractical. The extension alloc/move needs to be
   baked into the stack.
=20
I'll focus on getting a PoC together next. Stay tuned.
=20
Thanks,
-jkbs

