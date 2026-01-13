Return-Path: <netdev+bounces-249579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C411FD1B309
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 21:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 603AF301FB4B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172135EDD8;
	Tue, 13 Jan 2026 20:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="S5t4E9Op"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F26D30F95F
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 20:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335779; cv=none; b=rXgrQ5K6nuVHJQBK8zOzWEx47/o9RHvliEUjhF5LfxR1E+Ld+PDCRSeo7lTo1Iv4nnCD8eGkNT1mVi2YiwL7YPlIH337mtfGhfKaQMuWFkcMT81UL3sl8MDcGmPKtIpVZJEvVxCihA5295Akd1FQ3aMzJHooq0LduOrzG9cNamA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335779; c=relaxed/simple;
	bh=N4vJNx3dUa8zDPVZMwGwt/ppJvMqFmg3kxgkj5Re3hg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9NB2jN94/Ft4ThZWTBiFtDG28dQrV91wfUem6hvh4X4hEtKolPl1YdZsjerdZ8ICgJY4UQ9lnneMdlppM1ERAohunLGd7tc22o3BYkPt09yGM3O6PJ+QzRrKuD4SsdYYX80RUwsATYgXG2GCWkWCXqyX0VVVqfzHoTeVpgkyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=S5t4E9Op; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso11804386a12.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768335777; x=1768940577; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
        b=S5t4E9OpNiiuR6TsjF1K3JFlVtQxEkkjXN49CcvjpsvKDvignDGZPt5Ul38UTrcOI0
         zCQBTQlkMOqUoMUygYghfor56xbzScRq88LXOIEbfYYdQCPTDNWerC1y/dh88q4J/HeD
         PtAf/igt0u152z7ZUw90O23KBmUx+2ZF3L0ubr6u2ct6tkhjQXfrqziouI/3lIxBm8Sj
         +bcYJw5rAiCq2WuYvLoZsQpTIciLZIouU2x0Upwxu189nZ1VrDtGkD4RGADHh1S3zUgZ
         7ekLjQq6N0ZfXrAg5q3f/xScReTDD1J/nmUq7JRDyOem2MKioroesvA7YO5DnGSOHwYz
         T+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768335777; x=1768940577;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SEW+k25GxtoGpssMWcEBFy4Kv0XQW2KgqZU+s4uI3s0=;
        b=pNo4HHc7eWoUakogK1/TfrQTdkeKDThZ/gd1Xr1obT6mxpDAp+lmpr7L7yuHodg3hw
         O0DaiDWMPDlwtVZxCpwb0GaXr0wIIeql+zZ4QOK0SbW8kqbY6kGFQg8UeukVBqDeoSVE
         CtyHAu9naSMXD5Ez+Fqs1vLZnHOD4lgocuMqFJyGT3jKGvba+0+gBGbltAF+eD5Ydtox
         81WJncuWBW7ggVN5Gv8bWNf/p7sQlcYvwL1lZzWp/SojI78eer6jJN5t6VdtFvDjblc7
         QZIKnUn1d1aBYx/ZjDsHRzoEtRsnM54Bc/zmMF/XzIGAOAzX3zxpHcKv4f7Lo+cVbo5C
         9/ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXV2TrIHRL1d28w569a1lCX32RkmwEFWDVrMUs3VFsuP7QpMF3VIczXuh/0HhCZ8S4CmD26Ljw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwPMY/92pzWaxAEwuU/J1zF2T5GX33YvlcTgG7Ai3nPDPOkdm
	Rt87q0wWXJ9pXs4GSC1+n9RZlv+07be+dcQSlqKOBlr0kd874y5eCG3YmGB5ANQsO1bsj3aMAEr
	kcn6i+Es=
X-Gm-Gg: AY/fxX40HVE6txAmVBHv6uqUe9LJtTqXsRUAWLexee6FufloHdbY5iOF+Cx+j2FgTkm
	dtBrWaF6RzJC8O2cE8UAQ027WfphXa8ybplv/R/QxGl5jmrLPuj2dAFv/4RaW35OSyHHfjx/A0T
	ULpgSpUxBfYHCipLVmV7P80IrBCOHS8Jn6P6DMiTrVSzMyfbll5Y1QSxP0sfSQkyQIUG4J6Vxle
	8OkajFMDtTXD7lIblqHzDD6puR0AMUHh4Ps6GvqcInAWmGM0K4D8m2j4PC0UhyD+n2OcgQpVZ4a
	F0JOuAkUhezNzJ7uMIpLQoUzdWU7W8G1SOm81ChXApiTMVCZdLpyLLYWXkDG+0IjTwJcOtMaZLX
	Mv20xVdxfQ9T6uAGroKYoXVL6vHoKWxgU1uX8l0Nn+Ag827CKJ4qlWDH3aKJP15575bLouPEs/0
	NxAA8=
X-Received: by 2002:a05:6402:144b:b0:64b:7885:c971 with SMTP id 4fb4d7f45d1cf-653ec44348emr170193a12.20.1768335776737;
        Tue, 13 Jan 2026 12:22:56 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2969::420:33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf661fesm22541348a12.25.2026.01.13.12.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:22:56 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  Jakub Kicinski <kuba@kernel.org>,
  netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Michael
 Chan <michael.chan@broadcom.com>,  Pavan Chebbi
 <pavan.chebbi@broadcom.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony
 Nguyen <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  intel-wired-lan@lists.osuosl.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Willem Ferguson <wferguson@cloudflare.com>,
  Arthur Fabre <arthur@arthurfabre.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/10] Call skb_metadata_set
 when skb->data points past metadata
In-Reply-To: <bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org> (Jesper
	Dangaard Brouer's message of "Tue, 13 Jan 2026 19:52:53 +0100")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260112190856.3ff91f8d@kernel.org>
	<36deb505-1c82-4339-bb44-f72f9eacb0ac@redhat.com>
	<bd29d196-5854-4a0c-a78c-e4869a59b91f@kernel.org>
Date: Tue, 13 Jan 2026 21:22:55 +0100
Message-ID: <87wm1luusg.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 07:52 PM +01, Jesper Dangaard Brouer wrote:
> *BUT* this patchset isn't doing that. To me it looks like a cleanup
> patchset that simply makes it consistent when skb_metadata_set() called.
> Selling it as a pre-requirement for doing copy later seems fishy.
 
Fair point on the framing. The interface cleanup is useful on its own -
I should have presented it that way rather than tying it to future work.

> Instead of blindly copying XDP data_meta area into a single SKB
> extension.  What if we make it the responsibility of the TC-ingress BPF-
> hook to understand the data_meta format and via (kfunc) helpers
> transfer/create the SKB extension that it deems relevant.
> Would this be an acceptable approach that makes it easier to propagate
> metadata deeper in netstack?

I think you and Jakub are actually proposing the same thing.
 
If we can access a buffer tied to an skb extension from BPF, this could
act as skb-local storage and solves the problem (with some operational
overhead to set up TC on ingress).
 
I'd also like to get Alexei's take on this. We had a discussion before
about not wanting to maintain two different storage areas for skb
metadata.
 
That was one of two reasons why we abandoned Arthur's patches and why I
tried to make the existing headroom-backed metadata area work.
 
But perhaps I misunderstood the earlier discussion. Alexei's point may
have been that we don't want another *headroom-backed* metadata area
accessible from XDP, because we already have that.
 
Looks like we have two options on the table:
 
Option A) Headroom-backed metadata
  - Use existing skb metadata area
  - Patch skb_push/pull call sites to preserve it
 
Option B) Extension-backed metadata
  - Store metadata in skb extension from BPF
  - TC BPF copies/extracts what it needs from headroom-metadata
 
Or is there an Option C I'm missing?

Thanks,
-jkbs

