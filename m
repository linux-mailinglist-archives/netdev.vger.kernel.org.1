Return-Path: <netdev+bounces-143598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1959C32CD
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 15:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBE4F1F21241
	for <lists+netdev@lfdr.de>; Sun, 10 Nov 2024 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B9D381BA;
	Sun, 10 Nov 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEn3SF5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2F1BC2A;
	Sun, 10 Nov 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248758; cv=none; b=ePGJ9vcH4xaVSS6WjO5odLkjuVjx3pb68dSniEAYfUcXRzEvNg5/E9GqKMULQofMLXUsj4dOkkJwhvFAwelhkqz2uwL2C6+sTfsgL4zeh1hRC/cIxrScHDbo6XN3nTKERH2BHrLy/cqXucakEynqf3VKo894ph/Fk7YV7LurpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248758; c=relaxed/simple;
	bh=H6kkLRcCXpgXgSCHKLz+/8/hd+KsxQu+a+akF/jsTAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPaX2oTgg4UjD+gFoLVCVD9qDWOrNn+h6pib1gXwPI+Q6jKEVFCKlwBfp4lD0bmtFyOYi9BpbGKzmTJSC1tlmfctoHCvZ6log/h1/kGQVLXfhxbQTRrDkXz/NGO7WYvfDnxDlCntsRUzkeo+SJI4p63PaD23BMMedV9cCGIaszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEn3SF5K; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460963d6233so24542611cf.2;
        Sun, 10 Nov 2024 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248755; x=1731853555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6kkLRcCXpgXgSCHKLz+/8/hd+KsxQu+a+akF/jsTAI=;
        b=BEn3SF5KfH4O7E/sA69T/mzOmt6l3loIRdGxTd4KkpM1N6uRYXlfiLkZ02Sm+t/vUa
         Mmm66wNNxyHyy4ODsrFI9CfTpB7T3WDeDQALt5OxVe1T5bHwkAB09nOTSPlgH/iunQHP
         CUOozO72+KsQAEMmdU95Gm53x0mAJW1/sSmLv17IdE5UZF0kBuLIvEiY8kbrVkz9pRO4
         7C2bkM0sQfocuSNeFbZnQcrfzSjKavpmv7niVuEXxzlV8kDkgAUgUTsnQt3uCCDNI/3F
         OGnJ6D3SXS/pomShI3VurE2KHGNZ/mZ+gFlOBJgGgVLeIu6KVq4Wx9WWzOn7wR2v+jA7
         ZPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248755; x=1731853555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6kkLRcCXpgXgSCHKLz+/8/hd+KsxQu+a+akF/jsTAI=;
        b=s40Y44O49WQEPGejdMlJJ9e8SzlGMyKYwW0N4rolUumQMs+WamUa9WcaSGXlB1VtB8
         KR/lY9sLEG8U4azyJ0B/mm4ZBr+fep/mtlNPuI1QgDS7iFCmA5Ro1Pz4ttys8/FY+ScO
         cYfApl7d4AputT53XdmT+mr9ml3bQ4ew9xCLKSksVFDnSQBQZVaBV7X6rVq646W9GyrB
         DaY7ECnrcdySuoZoNwWHVoIyXHY0gQQI5BV99JDrv0fVftMznJhbK30ialHDnhjfa+ts
         zyik59PXbxw5I+IYSU9KVOJu6hGzjqhF6vSPYlLWaCtztKmrq2HdtQIjAE2zhCDXxcZg
         rmCg==
X-Forwarded-Encrypted: i=1; AJvYcCVPK+Dw18WkgFFWNlhyb/5k2t42azXKEtWT4Znpm0k6eJzEb+lzmh5B8ygBprgMD8U94WoUAMmZSKtsQwQ=@vger.kernel.org, AJvYcCVoH4Nzj3kDs7Y4bwhA62e3bdyfXDwEHUzmbMCeqGCpiCVFTgQvv2k2pZwypLlcRmiqgWgenlVP@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDfl6eFjlv+vc8X7FFSZECceBlKJOjFePmE0PeuhVq80MlH/A
	lGRk+7mbGYqw4MuyujYPMLj7z2QqquFSnh4w/Kv0zm2p95S68iM72J5JnwMdH+Y08siAWAiouca
	wn9wrt3Lnypndh9MeL7HkMJ3VN0A=
X-Google-Smtp-Source: AGHT+IGkQLLgn2HEodulrOeD6p6V4fTHRrJtR65Lt9rJEe9gs+IOxxbj0YOJbG4tjZ8xYiHxCYzb0iR26ZuY9IqtE8k=
X-Received: by 2002:a05:6214:5f04:b0:6cb:7e7a:ae87 with SMTP id
 6a1803df08f44-6d39e1b4162mr124681656d6.33.1731248755569; Sun, 10 Nov 2024
 06:25:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107151929.37147-5-yyyynoom@gmail.com> <20241107200940.4dff026d@kernel.org>
In-Reply-To: <20241107200940.4dff026d@kernel.org>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Sun, 10 Nov 2024 23:25:44 +0900
Message-ID: <CAAjsZQwhDeFEK2qEwy6b4-GbDUymiOz5xzrYwmMSTe-Jf_3oKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: dlink: add support for reporting stats
 via `ethtool -S`
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First of all, I would like to extend my apologies.
In the previous patch, the `get_ethtool_rmon_stats()` function should
have called the `get_stats()` function to update the stats
information,
but I missed this. I will include this part in the next patch.

On Fri, Nov 8, 2024 at 1:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> Do these macro wrappers really buy you anything?
> They make the code a lot harder to follow :(
I fully understand that these macros can be difficult to comprehend at
first glance.
However, I wanted to avoid code duplication with this structure.
For now, I will write the code in a way that minimizes the use of
macros as much as possible.

> nit: multiple empty lines, checkpatch --strict should catch this
In the next patch, I will use the `checkpatch --strict` option to fix
as many warnings and checks as possible before submitting the patch.
I also confirmed from patchwork[1] that there were additional warning messa=
ges.
I will pay attention to and correct these warnings in the next patch.
Thank you for pointing that out.

> We've been getting conversion patches replacing such code with
> ethtool_puts() lately, let's use it from the start.
I will do so.

[1]: https://patchwork.kernel.org/project/netdevbpf/patch/20241107151929.37=
147-5-yyyynoom@gmail.com/

