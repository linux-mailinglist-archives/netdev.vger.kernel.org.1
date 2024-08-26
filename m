Return-Path: <netdev+bounces-122067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC94195FCB1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 00:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7218F1F22928
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 22:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855EB19D075;
	Mon, 26 Aug 2024 22:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wx5hwXoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4664613FD66
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 22:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711097; cv=none; b=rZaEAlV0fGDG9NST4fPyfsDvr3aHmg0+ZdaLOHcnsnPnry81v1YvJm+7+FwqXU1oBQbEj1ovCVGwEsk0eCEjf9PMCo7+x/wrgtcj2Lm1OwwRBW/NKCNfTNE1/a9ZAcY19TzAa2ZT5+xOrHirVF4HSMBhVQp3Y9ZRr19AnsCRYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711097; c=relaxed/simple;
	bh=4UTNtLs7LGNXibjzKWqWHDbXqjgxjioqz3nwsCN9q8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En78ZgKSJ4J2iOhAYA4AeMm5GXst7ZOfnuR5pZ/8/RgEPkGzUIQIo/6IzdjnTJjrwIYc8/mx/vTiQdHMehZKsHQ/wdQr/1di4LMah1QLL83/6Y6ouHOVrf8UQFQFXE0K7at6VB4eX5j+jeHFt/xm3pV0mwA35Q1SpsQNHnBj2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wx5hwXoa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso3054481f8f.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 15:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724711093; x=1725315893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UTNtLs7LGNXibjzKWqWHDbXqjgxjioqz3nwsCN9q8M=;
        b=Wx5hwXoaNgJt1Goz/cSt7eTHisNeygC1ANFpZWt/eh6lOeM+9B9Tv1J7kSKZ3Wpp7F
         s5AP+3SDIkPqLrJsaL+VCz/02N15B14wDEFS5AdlN3qu03p4U7mRFFLNgt2jbtrIVP/t
         ml6mn4Z92kdKNnb+Qd1SFtTk4O+I9+Th9fQ4/AbIFEnjtRBPlprcqRpWfwEvC4yCS6Gg
         uM8hHhJGuRMoTl3nOHhEcE5bK0lTM7qFMKnOwrgiAOZY/2Fiogh/wx/ZAe4IeKyBI0KO
         nR0KuQ009qVYrgaL2AZinOVdeMaGUJa0/q/xDXs33KAmR0tdI1Ozx7l9QIJagS5ODZTJ
         nI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711093; x=1725315893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UTNtLs7LGNXibjzKWqWHDbXqjgxjioqz3nwsCN9q8M=;
        b=Byj8t9QH+TQ7skbR9z4FAK2vuqSNpaoBm/lUSDuStlRHfTMQkiWDYSDvEmMTNDYTMS
         vIgd0rRFiG9HrA7pZu7bwmVtuZ/MpSyg3QdgpXe0BM8EFnV5FGRcAIUfjjtWX03Dv1Lf
         gcqqSKAjUnSnwZ1pNvqRlsEDFBuITLdGihlwhCpTlX0O5gNPZ1U/HnNrP4RyvGBIX45D
         YSr78wrSjB8jRE3Lp4dyvULSZW55t2+DEefxY1zozZehj9aL612QorbyhWBKThDAj/83
         punZAQGc9iROFsmX5bhdBocq7Bdw/suo3C6w/aA/M7f1FXwGJtfhZi/wAi+YxX2OtUK/
         Hpsw==
X-Gm-Message-State: AOJu0Yz3fn3/PsUjQcPXIxUFGG1FB1qVyDHfRUkh9jXEoL/ne0xb09D2
	ELM9dSov4rXEvkmveok2T/XUWRuMnSCU6PWkAwXB5aYT/8dddjJqj8sb92ga9cP1iqWhRc20Vl5
	UuE86LS12ZR/zwha6lh6aPSXm2wwyBGYsYcKh2A==
X-Google-Smtp-Source: AGHT+IEHgC9SqV+MdNyFfbKX3S68MACIHZxKW7hMxFeh5od79ZNXMcKnEA67rAkBAWkokoplxM5KjkT5BjBp0XjHYgE=
X-Received: by 2002:a5d:6885:0:b0:371:8bc9:1682 with SMTP id
 ffacd0b85a97d-3748c7dcc10mr577790f8f.33.1724711093497; Mon, 26 Aug 2024
 15:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826182652.2449359-1-a.mehrab@bytedance.com> <ZszNJBRScwD6pXPB@tissot.1015granger.net>
In-Reply-To: <ZszNJBRScwD6pXPB@tissot.1015granger.net>
From: "A K M Fazla Mehrab ." <a.mehrab@bytedance.com>
Date: Mon, 26 Aug 2024 15:24:42 -0700
Message-ID: <CAJKDkqhpxQpMjsSBLb5hdbrN_uZJLAxf17A_JAhcnscTfEsfew@mail.gmail.com>
Subject: Re: [External] Re: [Patch net-next] net/handshake: use sockfd_put() helper
To: Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 26, 2024 at 11:45=E2=80=AFAM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> Hi-
>
> On Mon, Aug 26, 2024 at 06:26:52PM +0000, A K M Fazla Mehrab wrote:
> > Replace fput() with sockfd_put() in handshake_nl_done_doit().
>
> The patch description needs to explain why. Lacking any other
> context, I assume this is a clean-up for consistency with other
> sockfd_lookup() call sites and that no behavior change is expected.

Yeah, this is indeed a clean-up and no behavior change is expected. I
will be careful to add more context in future patches.

Thanks!

