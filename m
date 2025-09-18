Return-Path: <netdev+bounces-224597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71CB86A4F
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5666F1898BDC
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A062D838A;
	Thu, 18 Sep 2025 19:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8HKOKoC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5CF2C11DF
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222903; cv=none; b=aPOpXL+t+J03kojgkJQLvCXIiIPWT8zJQAjz7ePfu2PGwfW2Rq8MYa9WU37IoRWsQTd+fg2sFVZ4PfTP0GhSGBGPA2dlF6XEwza3mFLBwJGkOv71bdNJEU4r/Ei3XhhXDRSiL8dLMMOWI2OjiowEd6pF04gjafVRcjcI+d1bRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222903; c=relaxed/simple;
	bh=2A7x2om531suhKjYaEk9Lo+RA5yvlnX1jFfByz0rnZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrrSTvgl6abPX/tQ1l5hzzZP82gT/KtYB6GanmCSQm4PCy2WBsH1L0uNKE1UfDxFSl8E7wt9mBb5jXl4CV1yGrX4wihbmAfw1stAgIV0vTe/pnrgQpsf19WIFD/Bw1UQxyrvGaAEIKsmUMtB2xecT8aa9hVFq3MGEdEG1L/WBhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8HKOKoC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so812306a12.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758222901; x=1758827701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2A7x2om531suhKjYaEk9Lo+RA5yvlnX1jFfByz0rnZo=;
        b=A8HKOKoCHYitqftvcbVr18wJHUqUyqkYTvgaWQarBaXBHZBg1QO5mSZysgQ4iK8wOF
         lTICTq0Axp+9wanI8pE8JTV00+JPe96B9waSl1Mshh1+9Fw3qumLAsofrNVnYaJG+w8l
         dcGYkJpUniMG2uKPWeM08lEYlUb6NNCP8puNcvZ8hCQG1uM1eq5iyrqfd31fjd+va1Ea
         5Nx0lIpds4x9pX9sJ1i8RRON0gFPDuJPsVoJMtNrgWqIckpSlebVKbk3qSBrd3V0ie2Q
         xmdisOWWU3HavBjvaqxDdSk4WOb2Wv0wmqbNz6LuOa0bM+ovpBL8I98wCi9wG/l1lAgt
         acdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758222901; x=1758827701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2A7x2om531suhKjYaEk9Lo+RA5yvlnX1jFfByz0rnZo=;
        b=ZuSR/OGpsrp7DTKCFaTR6bHBX/AFpxHbtmHac1cap401Oh0ujAR1hBwTTB+HdXfNcL
         zqmlPk0KsUDKoifYTEssAiYkr3KSz7Sct/qKJERSYrQFHrheReN4zIR8KPc16SAlkz6l
         Y2lEbFa6+asxFJlwjHe+QQ99+WASozlec2OdOdWaps+A7I/8EUajsrlbTn2SuaFhHuFO
         bfqyaY+b8Q7qAYgg1vY4I2DXd1r2mf8CbTntH1zh+0FDMuSUYwI13U5hSiRSRnJPMk2o
         3RkVz6d/u0o1r4f1C47lUr/VuSHrmHaQHO2VBJmFJj7CRm2F4f9dfwFBdE/PDbIpltLG
         9Yng==
X-Forwarded-Encrypted: i=1; AJvYcCUwd7iAnSI3O7HGT5m3jNdpbqhbXjfGqT2JDX6qzr68kxxadPk+Ta1ZTDzgXi6iEGluAQ5HSS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPUlt3ly90qoYLY+YPFC3bNB9tFp6sTx6CeYcoR0G9IBE/tWpe
	aZn5KJ2Aft6ZNwLq6ZALrXm5rbtYPvc8JKgcMrcWHVEcdLuBkhPlpmf2xgoEf8QaI/KxBPgfyuD
	UJivVrsnRLeNWO9BIDahHrABPGh3VKVi4EHaywcIR
X-Gm-Gg: ASbGncvv/Tupl1KKlhOB708qdYHVjTi7VoxrDf1yaEavboo22AwNBb4zudC9K48xBPF
	NbIzgOflAIpzsiGvPCWLNlxCYf7SApJYfLIVUFsVA7BMjysEf30+EXkL/6s1+MS2JgFs7p0rPCO
	1LZoXIh1Nz7VtILq0tKAVtUCLQsjahCW/ugXCk59su6PoIubcJvsqJOabcfO3ZOCRNYLmtN1BBG
	WAKitLMMyhL7wpP15bh1l+E4qKJfCnU/UIkJGl8SRXXtMVKxx1MJNa0blB7Q+C+kA==
X-Google-Smtp-Source: AGHT+IGDNF1kc9s+6ecfdiFfRrBlK6UBLUNleNi76iPFCVb10wnLCjl8w68eSNFyA4GsASMTSRtIKP0U93gHb0Pv+oA=
X-Received: by 2002:a17:902:db01:b0:24e:7a4a:ec59 with SMTP id
 d9443c01a7336-269ba466966mr7992625ad.22.1758222900836; Thu, 18 Sep 2025
 12:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132007.325299-1-edumazet@google.com>
In-Reply-To: <20250918132007.325299-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 18 Sep 2025 12:14:49 -0700
X-Gm-Features: AS18NWBqf6dPlS7q7pG-qcXs48W7C7hlbCacPHrIkro31UvnTl1xPUeVE8D-xlg
Message-ID: <CAAVpQUBK6_KcGcHypDXk58kzmkTBtrTE_7Uxt3Krd+S=GkZ7ng@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: prefer sk_skb_reason_drop()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Daniel Zahka <daniel.zahka@gmail.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:20=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Replace two calls to kfree_skb_reason() with sk_skb_reason_drop().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

