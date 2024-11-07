Return-Path: <netdev+bounces-142949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6B89C0C01
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ED61F226F3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6A215F4D;
	Thu,  7 Nov 2024 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1cRntnZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E01DF273
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730998440; cv=none; b=JM7HDvrpPoucUGCY6gu8xDHL1+2X0K9fcniRMtte+QrJNbTfYYTBY6I/wjEi244ENS8wUYZXBXy8va+F5OSHgvMlN8IwtRSg6+vszB49QJk1Hqa+Y6e2tnOEsMcvomsMmEGr8tzGNpXTyULfL1w4VHjrfpvWy8pbt3Sx3Pejbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730998440; c=relaxed/simple;
	bh=wk2nOWwbYWifXbTxbWhgnDz6Oorh/sA0zXKSsliwhg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbE9UoqoFAuvx+prQj8cw23DATcKvWzuHDNRwI34cTGolq4yG774XwrbXGqWfBv39+qYIVuJGrNgntov9Ey3OnLDZyVhogfahBpBk9bEv0UV1W7rj4rmW64Tsx8i+pXhxdzhcgfsQVIM+t9TrnUjp6P5qKbIT3DV2/ZZV/BMOG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1cRntnZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cf0810f5f9so323550a12.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730998437; x=1731603237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wk2nOWwbYWifXbTxbWhgnDz6Oorh/sA0zXKSsliwhg8=;
        b=g1cRntnZfBFrlZ1qeDeSyidR3AZm6o2FUmHZK9mYskSxlrHNc4ZA4wLhsgg103sPOC
         w35gIZzz2bvEZbhHe7B9B7WYg1xBnmhhHsyzwvfcN1zsrzFCM0s5L0Kt3bwGbrMBvkNr
         FrAdM6RSGe83YzQdWaYVimYndJxsPvPhnoN/ureibQ1PXIxwaPim+EZU1AuUc/bF1djU
         8VSrJgsBIcnFOaZKLOu1OufBA7wjjtOa8brfNfKdj9ANBFSNA9a3sn8X/Wcl+A7t/nTM
         4VdhC007IWhbmVIHRSoziKfDV8dGRNUHcFhKnCPFYtCIaYJT8TjLJw2AiDiXokv3bn4H
         KeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730998437; x=1731603237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk2nOWwbYWifXbTxbWhgnDz6Oorh/sA0zXKSsliwhg8=;
        b=s9pVuApOv9/EZwQtySdS55dRgsm7pryI3/+Fjo67w55aOzCEpXb+ZSYOquSMukZzsJ
         J/sGlVvSbN9AvYxHRegN5LtpG4mNFV0hWibi1hQ8hhfNIa/ZRarpg5MG9FlO6Y6nWb1I
         TpP2texPirjIUNAlYEhuDSh8Zj6xecLxCEFMWUMxhKstqtqRSZfYlFe8EyoifRU6y/rA
         7nR57pdXI5bL9lTshlIixko+g+JoHBjQ3pw6igyPZxVqFwpnRGwpQKq9PHLtzPGh35Ap
         XroWpe6E7fvtnZotPZLLxDeQul+2qoviCngRex0nW/Du5q6vEdRr4JP0n7u8TKUsx0Mr
         EE1Q==
X-Gm-Message-State: AOJu0YyADKdKfDLXJNa20VDNWiad7tjtXM3gM0fsPFzWW2NVsJ8H4/4f
	SthYJ980J2DOd9G56SNTSI905NR0Ari5qXvNmrb8OJ47oWt+zNDDeM7JE9JrHM9ykDdxgIFnFyr
	WCR0Tx+R2J0qhlpI6MEsSbDyHYFfCGMhFvmgn
X-Google-Smtp-Source: AGHT+IFo8oy+eb/d0y+EGphpxXBEYlEvvrL19bBiLp1WZ/gTFgIw+AXiI160TZpqnYlzsXHsEXZXzoMMUCbgg4Uy+/o=
X-Received: by 2002:a05:6402:1d56:b0:5ce:af08:a2cd with SMTP id
 4fb4d7f45d1cf-5cf098d044amr83368a12.33.1730998436539; Thu, 07 Nov 2024
 08:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-7-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-7-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:53:45 +0100
Message-ID: <CANn89i+T-10-CmXiZ4bZ7oUhTfTyB=9G8u4imTTMfpRRpJq3AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 6/6] neighbour: Create netdev->neighbour association
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Create a mapping between a netdev and its neighoburs,
> allowing for much cheaper flushes.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

