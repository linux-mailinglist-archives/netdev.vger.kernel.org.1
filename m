Return-Path: <netdev+bounces-197941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5184ADA6F6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6029816799A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102DC154BE2;
	Mon, 16 Jun 2025 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="200ex0Wp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E912E11CF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045883; cv=none; b=GZYhL2DTIeGkgEGlrqwRRYxXJVfIkqTaUZJ0EitxmSDAzurOedSicVudAm2uoUIAEYXaXdGOJwWPqjXEQJ0dNDgmUh8G1kqkhelC+Zbb1J4GXDh04mqyMR2nYLnc6lwGe4VNjKK1cm/7+NJMVwgmH5a8ckid5zdN9jpBz2WDA80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045883; c=relaxed/simple;
	bh=dhD1skn7PoH8/u+8NEnliIX6n+XOJETj5i6mmcuQoEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPpDAleQwDq/2UHM2aoSvsBLDHmHMNf1v34niDoq/7iiLQgtO+SCS/1hf3wR9Qtj2ViLU3Max7LIcR6Vz0byN1aDlV6ytSHJhtjuxRNmFwJ05FReFLnBAqf2/8bK0Sf+uIdD4dKIStbutuDd3cGKflj3ETduFBXDohDnQmsyx4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=200ex0Wp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235e389599fso240775ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Jun 2025 20:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750045881; x=1750650681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlxPriOv4EC1AtCRTHKwJM8r1Wg8vi/BT4w2IpoGYm0=;
        b=200ex0WpgP0L8dnypuuVwElCXdMGID4Hql/zBoW8Ssu6VbOK/gyQBjyeD58+14HVbZ
         64L5huO0aECua8/xcvvDJxt6/cml7wDwK8VRoH3X9s+7NKTKDCLfFOyxpUryuuvjzdNF
         5o5uq3fEh4BgTC4k3Ge3E4mXT/bwE2FGg1XitVLJdhzRTI0uoX2diIBhAk2i6wtNTlC+
         snotvyuvJJkfLRtPg1qx0P24Uy5kHwUD+NyoRnkyqznIhzRaaWMMrhep9iVkvjgPaVQN
         LZdPRWadcdfUE6UFNOSKdnEaBVk3675VX7B+OEZ3bkdT4hxaNloBeoOn0ipwmSulFtQ5
         vAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750045881; x=1750650681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlxPriOv4EC1AtCRTHKwJM8r1Wg8vi/BT4w2IpoGYm0=;
        b=OcHRoE8LSF90Czkl/GiBpq14KK8+otFs1U9yrj9C1IlCjQLQM46TQIioqmbpVJnkZn
         4UzbGE3TMiX2d7RJigXT9ZWmFf3Kx8RB9MGAC+XWr/M2+6h6xkPJfE/jbXPgMg6Kw+Au
         zQzQM9C7dnwOhfJTx7md6tC3xg9wJga+ZPSADruL18K8lXn7RywhMimHAMEv/rslinde
         e9Z8CfZrbZh7IZ4L4bQb4JGKcMXHINLlJ6VJ2mII8chRqTb3ueq+aEPG2OAQnqFLh1GY
         04hWiGjL0oMVUxSx2BPyBesEu1s7weT7tPUvjVw7lRL+IjbeSdcN3Ikrnx4ljCZM7lWk
         ZIAg==
X-Forwarded-Encrypted: i=1; AJvYcCWbNiTcEG3x2Khl8CbmDMzHOxlvAIeYL0q818uSfxFZ0VxwQip9w2RfOUtwboz1lpSgIiuY3Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvICTyKOEB6z8ylim4A9bGv4fJYzLfxTD+lUKOE7nSRO8K3W/
	zDdi9ZmESfU1+8WC48CKrv41ENDI4U17sb44WKTRxoVxWKLlwHVfI+7eO9jFNU/cS1kALj58hA2
	Rj7LzEGL5aeJ9kUK2RR0LSctZFrbQwEpijbDVoMGC
X-Gm-Gg: ASbGncv+Zw+VzrE6+JPmsd4ltV64S1fW5nxxi4qpvNFojvynUvuKPZUNiqoZuX1lKS0
	scOiuyGlhiVT42CPm1k1SVH3sdoImM7HvIJ9WEAuRQ17MY3rPXsUFon+DDU8vkyHdlMD8iOYJUO
	yDSskfCjWN8JOgLKtB+savfvQwRn237/UG9YgC7yxzHLAL2ne/JGn6GHXiSbJ0hV7o+ThIYVXyU
	DTy
X-Google-Smtp-Source: AGHT+IGhl+eFWMhGTTmp3o8Z9twg93fzAYmGRqJDp5XvOmTdxKe6XogKbocdW91iHe6A6YhrbgCFRhsEBrxm+nYC3Ug=
X-Received: by 2002:a17:903:2f07:b0:22e:1858:fc25 with SMTP id
 d9443c01a7336-2366eef4f2bmr2470715ad.9.1750045880565; Sun, 15 Jun 2025
 20:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613191646.3693841-1-skhawaja@google.com> <20250614131018.6d760d19@kernel.org>
In-Reply-To: <20250614131018.6d760d19@kernel.org>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Sun, 15 Jun 2025 20:51:08 -0700
X-Gm-Features: AX0GCFvvcu3BpuZcY2_ASyQzu-iAoTUNTL1fsyBBDmhafzkDBfa_bS8cYCDR8Kg
Message-ID: <CAAywjhQWG2t31MrBiy95OT4ZpMCteWCG51Uwf1G1si5z1TMRqw@mail.gmail.com>
Subject: Re: [PATCH net-next v7] Add support to set napi threaded for
 individual napi
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, willemb@google.com, 
	jdamato@fastly.com, mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 1:10=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 13 Jun 2025 19:16:46 +0000 Samiullah Khawaja wrote:
> > +/**
> > + * napi_get_threaded - get the napi threaded state
> > + * @n: napi struct to get the threaded state from
> > + *
> > + * Return: the per-NAPI threaded state.
> > + */
> > +static inline bool napi_get_threaded(struct napi_struct *n)
> > +{
> > +     return test_bit(NAPI_STATE_THREADED, &n->state);
> > +}
> > +
> > +/**
> > + * napi_set_threaded - set napi threaded state
> > + * @n: napi struct to set the threaded state on
> > + * @threaded: whether this napi does threaded polling
> > + *
> > + * Return 0 on success and negative errno on failure.
> > + */
> > +int napi_set_threaded(struct napi_struct *n, bool threaded);
>
> nit: missing : after Return
+1 will send an update.
>
> but really, I don't think we need kdoc for functions this obvious and
> trivial.
> --
> pw-bot: cr

