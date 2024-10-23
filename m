Return-Path: <netdev+bounces-138309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A089ACED9
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236531F24836
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7161E1C75FA;
	Wed, 23 Oct 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X7kgBsPj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C481A1C3027
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697540; cv=none; b=JbAi5vbRwLeiZ4Gc2FOCW3WVaNJHm6wr3tQBqR8XfQLGWf7YV7wHVsgDF1F216hNi9KKeSLfgpF5fS+lwAs+ndwtUCTE1Wra2RC1Ca4AEeQ5JCXn8RjB+Htk8fETgeDOj3oiDjxhuUyAcFFc4mx60Th9FFwW3/YAYmVU5a5XH3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697540; c=relaxed/simple;
	bh=GOL/laQ5Z2E1PZd6zADjxM9SQG4+l1C9L0o5Gzf9SmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V2Blv363p7DYipHZNn9L931V0u6c0RR8q4rw/tk12KMi2YiHpj/P862RAsIAOna0qh+aoXuxrHLh3xClKoWf1eLKhsb4QOZNNb9OooI91MRf9lyDMIuKC41diqwNbjFhoJQw87SnpzsIB0jKNBrhJ20s96PXlE3ltCsXR3wjkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X7kgBsPj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a99e3b3a411so184395566b.0
        for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729697537; x=1730302337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOL/laQ5Z2E1PZd6zADjxM9SQG4+l1C9L0o5Gzf9SmY=;
        b=X7kgBsPjBiw1VnyPcFUKrbO5mswDr4KgsDfyf3P9LF1eb1ZxWXyGxnKp5PjhFIx8R9
         kxxU048zDxwSNbd/k6yRFrjfRVTVeOfbcGfZWEsCHcv2/Szcuh/U1NU+O46ptT16ruCM
         G8d4e6WchTmRXZmW8UzwAZ6tPFDQUmXXOP6rk5PRoAu0aQLI7J0g8MzsMB/TvSUphKyA
         8VpyrBBsBxPV8iVUji7RkFJU/ZYUKLXZAnr8mzgmubQJ4EtOodTU66UytXHkx/NK4yXW
         Y+YyyNsfU2J9CWl5LTpJTJfDIVZl3VDwziHY/X/EsGshRMuncCGlJuAr7SGfVRRnSgcj
         FxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729697537; x=1730302337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOL/laQ5Z2E1PZd6zADjxM9SQG4+l1C9L0o5Gzf9SmY=;
        b=YvZhIqzCE0lGZYFoMhnDybg39WBeB/Sudyx1OTDXFOMTywEvsDJVmiExr0zgY6h6GO
         DZlyDq1z7hnSQ5aErSt/uFvgv7mq5PezPzSpFRN/zLbYhBgRwSI/oCAJLwYll31HQuqA
         czw1us7r5uvVEuWK15FmXBlIJ2J38SpGvWTple4hUWloCkp4Xneuxg3N0q54Syy+m0yR
         UUCnVs+MJ7wN/RNEhMBkbRQcyZoAUWaUVXu4XdbVJGAPWPegV/Ivt9kSnIipQB5T7LIf
         bBjIAyLyjD0ccrkbXUHSWhLMGVhOqVHGcpewpS/i4aJcBW6pG8TacnBzNc1r5ewgWHKu
         oKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUisZp3atT6KuufZPdhcuZ1pzEGBDYwZH63YAPgoXdbYHorKJBCs0CMcmaLWXww2tSSYfNNBkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfTgApozrQD0pbH/BU6Aao+ejZZb2s1Hq/SFt1vQRtPFZZwH7w
	WpA3AbtllJJnZryDbOh4bF91Nq6vUroT+ovtpRpuBR1wqbiq/7oZQ2irRmEEb+JkwKyGdLX+WMS
	ITENS6mfjjrAhJ3iGQ+rvdlZ96Non2Qr5YAd/
X-Google-Smtp-Source: AGHT+IG5tuXt9ex+D1/5KB7NhDpTVY/7qYvwAETkplDtBT+URL+aF8QIWE4yidcmU+CB4fypej7ytJweqUc66xpNSqY=
X-Received: by 2002:a17:907:cca3:b0:a9a:cd84:b099 with SMTP id
 a640c23a62f3a-a9acd84b120mr6715066b.34.1729697536861; Wed, 23 Oct 2024
 08:32:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017183140.43028-1-kuniyu@amazon.com> <20241017183140.43028-8-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-8-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 17:32:05 +0200
Message-ID: <CANn89i+TkNyfb1kiD6DaJobE5D=oudwO-kgAzWtFMKSDyQe45Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 7/9] phonet: Pass net and ifindex to rtm_phonet_notify().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:34=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Currently, rtm_phonet_notify() fetches netns and ifindex from dev.
>
> Once route_doit() is converted to RCU, rtm_phonet_notify() will be
> called outside of RCU due to GFP_KERNEL, and dev will be unavailable
> there.
>
> Let's pass net and ifindex to rtm_phonet_notify().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

