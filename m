Return-Path: <netdev+bounces-243833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 435CDCA85E0
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC2813264B89
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E58336ED6;
	Fri,  5 Dec 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="WKAepucB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B6E2FD1C5
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764950876; cv=none; b=XAbgHYKuW/P6NhKlxqyCfULZ5+Aw9jxuurBQ6BfyxLq0/QHZTfCp3/KNWYTRJLB8kZ6gLg+seEvJfG6L5aeLdqENu4v13Q7fIDpdAGh3tveEb84l3z0hMLvstvSSS5QDjU++UoW55qeXpVHvv4hmV2Yrwwj+gbcTUeG/lVYwfDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764950876; c=relaxed/simple;
	bh=MynNtNJgtnnzbcoXkUDn4jNURoAbq5WcACoFTQrlNOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZda3JXqsajwYrDGhoOejh4Z9KdCiWZVwKpp6gdEVrxW4F1MtHwMK/qVB+7BcgULIDsFctLVuRcQmmwdjvcY5ZKPLbJ5Z3hL+wxYaJw9Z+WRSaf4dghpWeG3fxzVjdWfr1jwLL4qqEG/Ds73aJOup+4aj1sqsOVODr34cluYwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=WKAepucB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b79d6a70fc8so364789266b.0
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 08:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1764950866; x=1765555666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y9LxxRSAb/4U+NvNgfVaz9K7EtTPAjQ1rfgaORSEfA=;
        b=WKAepucBq2/gqmlviEbP+dksemsLvqln1Eam+bqEyJ5e/fhncw9nO1PcOafd0Pm1bz
         wy5Xne1QkfGOru8AQOJOuYuIphhVi2v+UKn3s+m6mBoK2VoVWTOhCL2jwzHQ8REnjgj3
         1FjAObamEQ2MlpFDWoCZ6ekLqzj3YughSc8BGqbUAsHUzL3qLLkPPnddOAS+Pzfi1hoh
         zJY9I1Z7/zMA5ZHNWlCy2ApYrNOZUcJ93yGP2SjH5CHnL2XKAfqE7vGGYacKqGtjr1NS
         0lc9aS2TT6kRkpEH3I/RNg9Tjtk2diaKc9wAaM8wxADkf8iF4gAwIEKOqqkp8eG5Acva
         8bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764950866; x=1765555666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Y9LxxRSAb/4U+NvNgfVaz9K7EtTPAjQ1rfgaORSEfA=;
        b=lScxFQqPps2o7Rz72o2AAF1fWzrvOX0lLVHbGW7rT3Vulqf5whGCfWAMkDOav62PeO
         jcotUDGYmbGGprUo9oxjf+cmMY9SE0dTUzZ3TI6y79I0XKsUTFIYdr1HcK6p+8OKaD4d
         QdFVaSuPvOpuqdZtD7j82zI4wqdRmNCrSdAaGzVWdB+UEhnkXvsM5oetvD9zjHLteXIB
         vBlk6mjVbftNkS63gZMIM+63HVYJv9KO7uTJxTNjjMPkc4TQ0VHTDd4s+8ZhzqV2rdxC
         NvoQ83YUBar828Dh4Wr2kpPRF/7+E4bud4k+h2KJATcFL6MVigU5UjEzObEKvQOorwXE
         YDZw==
X-Forwarded-Encrypted: i=1; AJvYcCW2u5f0DaDb0kDzzGex+Fyd+NOp0iRxhErncZWmXvj/KRpL88Omfybk/Fny82sFX0WdReSkGl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/K/SYVkY1TwIpZuL/5ssXkAHNYupXeOdl+BvM3YKgX/qsjzJn
	rqZ6vDXFg7i5kHl69/3NMvtNPQAeLsKdY1IeT9Gw4yddEnZv2RklzShB1X7mciffry6sWX1SAV6
	wMV9LV76Y82+D42628ZLFftukOmktKNLV3v70oEWqWqM+DBXNSpvLFw==
X-Gm-Gg: ASbGnctFRrJqoEcXlM9/IgjkE4DQHd5OrKwr/Aur7rtEJ47BFgbkj5PY54sudfGmAYT
	D+MrSKThnn9/2ejbb7WW4Tv1LfwneTOKugrX0L2XvVnnQP3bC42Y9YmojdlOq/OlbfELc8pdlJb
	WDCWTqrnAhDqoXZT2EFcMFsjPiLP1VNbCs+fFgxSxHx1EMPOfW3kuYmN4KmH2NyZtHzoqwuT1Ch
	gCgZTsZ2nE+TbbPdzAXDLASt4EjREQwD0JMt6DBnMotL3dGbA99pO6EjyJwU0MUY5JYi+50l7uh
	39G7FoL/n8DlgVoxlDcDjjS+ph6KfC2YxKYHJD+2CYojc83auppjr11wx0nz
X-Google-Smtp-Source: AGHT+IFi0Xzp2bAdmBQuvBKFYwHHgU6sC9jICuhfw4YwcGm6mPW34kekN4hQTNQg7vjxfJD4Q8LjJ1sF3mGomap68j8=
X-Received: by 2002:a17:907:9816:b0:b7a:1bdc:aab5 with SMTP id
 a640c23a62f3a-b7a1bdcb0e7mr67804866b.62.1764950866162; Fri, 05 Dec 2025
 08:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201185817.1003392-1-tom@herbertland.com> <20251204160841.70fafdba@kernel.org>
In-Reply-To: <20251204160841.70fafdba@kernel.org>
From: Tom Herbert <tom@herbertland.com>
Date: Fri, 5 Dec 2025 08:07:34 -0800
X-Gm-Features: AQt7F2oTVUFPHXDiCpBLtPgNwvG6qwHrwsqzlJ0NAcaFM0KpmcbkdAQ9egeZIwU
Message-ID: <CALx6S369WYsHP2cWw6gv-B9P8ATE32+rJm9AFwvo=mPS=Xxx+Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  1 Dec 2025 10:55:29 -0800 Tom Herbert wrote:
> > Tom Herbert (5):
> >   ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
> >   ipv6: Disable IPv6 Destination Options RX processing by default
> >   ipv6: Set Hop-by-Hop options limit to 1
> >   ipv6: Document default of zero for max_dst_opts_number
> >   ipv6: Document default of one for max_hbh_opts_number
>
> Hi Tom, the patches got marked as Changes Requested by someone,
> not sure who. FWIW they are all missing our S-o-B.
> net-next is now technically closed but I suppose you may want
> to argue these are okay for net (if at all).

Thanks, Jakub. I'll resubmit when net-next opens.

Tom

