Return-Path: <netdev+bounces-175768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7FA67706
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F17416B973
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09038209F27;
	Tue, 18 Mar 2025 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vdv5yghj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8AC42AA1
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309778; cv=none; b=tl4R++BvUgOHfHn+TrCp3+aCJfYCaqi5VOPsqTrH15/iEL6vDnjzbeb2eJtbQ7tVmZ+ra36VrnlwyxR1nPGZGVOOEMvPV9oLlq7GIM+repZIeZsZHhL1LJtv6mlPf0RawUFowI2Lvn12BuHYndIGIkKuvLEb6CIbbAQaHwf5hIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309778; c=relaxed/simple;
	bh=w60ji892Y8UTdeWu++Okwf/bmgSc2cbzzpnulSKSbSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UhwYF0VR5e4SSQyHJaed0/FmwRya9RcW7vk6ls6Gh67y1hjuGP6iW6zmftr9irIGV6/M0BThus0zMz0NEwLnaXAdyKDWik5zrObGRdfYiXGO9HlwSkpKckSrqwV8w3nTxg/SuuA+WH5iHwzzLnefja2MiycSNziGyh4ASTARzV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vdv5yghj; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47692b9d059so73366551cf.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742309775; x=1742914575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w60ji892Y8UTdeWu++Okwf/bmgSc2cbzzpnulSKSbSM=;
        b=Vdv5yghjmDdHAIq8OHlhT/J6PUvamebxZ271a6tDpbXsNeDtuBWrcLhthIjWsXmpLV
         fCTl2Fk99/k0uH9zUKrtupIr/OtN2Px1MK3vzfWDmaSiDh6QWqw9Uills5sn3uC7D7Lb
         sZSLZ5ZNqTAHbxMxFg6IYgJN4oltCAIbjIcfb0F6+hcXGGPkvdyb6kY/+TrleEqPhMgf
         KJ8tLdqEoQEwPJs1MT24ZQRjvtJxpm2Qpm+PsVdqWfQwiJbPqm8s2cBJQIjxAoPjCql4
         OGRZJmSLMCn19VsgZ5//GlS6lg2qTCO6o9nKORjPirRNn8ATDnlmEll6KlyvCSXMMeio
         WQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742309775; x=1742914575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w60ji892Y8UTdeWu++Okwf/bmgSc2cbzzpnulSKSbSM=;
        b=ddHIWc2lCMutTrVd27NjRSnumHeJIZQeJiCs1vBuBosXQiLbhCKbquaLqYELT4a8Ua
         OxuBD4Af11N7Xe+loMskgGcS5fss+M1ScSuXh7TZHS9i+VktxbRBCKapTYCa4fnvTuRy
         u2Ui6uYrJVUyyjgtFRhA+c0GxcgSKGeqKSStneOPBeFNfNHK5DjVxUWOaWCKCPVxgiwm
         fIqgvYTwImVsnoE6+yqtDqHWAwsoLzJqTxcKy/4dZciHWsowCUnwkNZIyC3LWOGKuifv
         4GmKnM1bTnPSbPcJaZ54mYakzOiLMDD78IwbAx2xpew6+aFe6WdElXrDSW0sFH6YEghR
         W3Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX20tmq7UTXGML6Bbw36dTicrEcwIiySRF2M/NQYGAn/WrXp4pr+YDIc3DioY4jEOO5UZzzmnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/k7MDz/lRztSHv7IOOhcAS2yeQ9oMjfx8C+vYYRYYS3FCdqLP
	vRxE58eYJO7zxmoOPE3MwW74Cao9RWfBLYYeXo2bUbzHszWDXHE1JmUXz5d5cfENgTwm83xDxM0
	BYto83bq8c5NVBLYGrpDu+Drv1ko7wKH9V3GM
X-Gm-Gg: ASbGncsTZQ+IxsYNGC0++ArN9RFGml10vTGbNEZTmyQJp/+4zVgIpEKW7RgTpTOPha8
	zMhA4hFe0wPwelDhKFCL1BDdcTTSfaVUSnk3+6dkKWo/QHYE1W6wV0WGFtav+OBreORaDhwtPS3
	f+3nDMIe2o3oXLYdSbgGWysTcpkKo=
X-Google-Smtp-Source: AGHT+IFkyBfNsezUgV8MLc6B7A7fL0I4GjR/9T2UBjZHIjLP4VIgQ+akLlQmBZsXUTCuU9vnTuB62x39sGTK+0stGPk=
X-Received: by 2002:a05:622a:3ce:b0:472:1aed:c8b4 with SMTP id
 d75a77b69052e-476c81c2dc2mr236231581cf.34.1742309774959; Tue, 18 Mar 2025
 07:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317151401.3439637-3-edumazet@google.com> <20250317202751.24641-1-kuniyu@amazon.com>
In-Reply-To: <20250317202751.24641-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Mar 2025 15:56:02 +0100
X-Gm-Features: AQ5f1JrC8lElwNwyLq_WhgxZjBDbcWMXaFetvi7JRwwOVd4hey8xZcKIT9jwjZE
Message-ID: <CANn89i+t82W=WbX59b-kPVwcZFvd7=xuEE9BoV__5yXQznjGOg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, horms@kernel.org, 
	kuba@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 9:28=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Mon, 17 Mar 2025 15:14:01 +0000
> > icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expire=
s
> >
> > This saves 8 bytes in TCP/DCCP sockets and helps for better cache local=
ity.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

I will send a V2, rebased after "tcp: cache RTAX_QUICKACK metric in a
hot cache line"

Thanks.

