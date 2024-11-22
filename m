Return-Path: <netdev+bounces-146778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831299D5BB7
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2FFCB24D9C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213841DEFD9;
	Fri, 22 Nov 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDTpZYWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BF21DEFC6
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266916; cv=none; b=BdELFlOTL43Ra25ytmzEscNAMfEPVozNNizg0XCJYqtPkrLeEfibhbzbqL+aIerDfZIYWt9iRcz44JUEMML132GjkenWFD1KBMIUxZpyjlzqQuLwFFXPG4kZH9O5RnSUuc+59Ogu3VWqAewwcyBc161JRLZe5xz6v7OMwd/HZ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266916; c=relaxed/simple;
	bh=uruwwJ50mXSVVEsekJ9ZUXKpUw2xOzm+RfNCYzA98Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVQ0hvBgp2ytt0/dwYq3GkY1Wdeqk6YVCL9BHY1F5D4kWNLv6dGndL3Gtno7N6FPwACNME+JexaLN/A/Fo9HFuDWkq10fYejfZvR+Eo6pXhWVRlnO+CA4ypAqdZcS4oZcGusmFqraHaHpnCss9rRiNb+aksazPSnN18rYkR5TIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aDTpZYWG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso32731566b.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732266912; x=1732871712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uruwwJ50mXSVVEsekJ9ZUXKpUw2xOzm+RfNCYzA98Gw=;
        b=aDTpZYWGd0ZaC7naXXOYeFDP/+UPM/Gm40M8KaOjl33KUUq87hin8Xy33oaT6Gn1oN
         Dx30Ujyf+n2o1LH1qlUgKqy62c/yXBTGDk7csTctyVrp5uXm6Pc0WmuBPRdd+lvyWxln
         rV91srbZ2czWwoO1C3vMidcC3k6KIbPO9jA+SmMSXirDDeRoqe8nE3yiFn/eLKfrDMpU
         q3UqWaHB8VVao33RgZwX/jzJz0BWFeXOwyYLIf23NkztloHEWFUvAYCYLH5nFuQg+2H+
         ejNHgRh5nHpQOkHPQTMf2II4OJDH83gVvaTKIduUQd+Id77e8t7aLc/Fk2FEegv0X0IW
         hMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266912; x=1732871712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uruwwJ50mXSVVEsekJ9ZUXKpUw2xOzm+RfNCYzA98Gw=;
        b=sYIfc8YpBsd5rjwkZQMIyj8fRCyrp5I41IAgErPbfOwQwYBR5DyIjlr/uwRs78j6BT
         8fFNrLxhfvIe6uizE0KFJ9tn0kowzBTiqg11hI9NgyHLsTGq98Naj5T3lSbzgMErK6Qh
         t2nvhYJC9Um/dHy9RQ5hme/SqNogkm/ujM6BmZ4f5tbPWo9lPzvWbRvqtkojmlC0jXGl
         WX3Wc0yQY9t+U3Tf94ufGXVebw+AgX1dUpJ4xoa3OA17jLxJFivCYCxstSDw/D4NVNWW
         J1H9GwmVDcuYnMjb7RG5T7VR7Q5BPTecJWAUd7jsZsfiOeZAtrjfgimrlAtx+gKx72eH
         GRCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ36WZuxhQWqyZTLF3rRWnQcRvoSf5TK06HDDP9cDospz12/8ni7O6nswDsuaoWqlDaETbAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cOl6fYlFlq8A75Qp7YelQmqaNVF5o2y+CUF+iCa+3pOhaNMQ
	gzhyWgIpz25oS1gZ5jZBN3EINFyvk3FPxawaLMffkZrFx6LLPruiu9BFp2s0greONH4sp6M7cgA
	X2aFnviHv+FteoQvPOuBzgruBPokxzvLlek+5
X-Gm-Gg: ASbGncuK++LLZeDr4PGNolYH7rz9w0t4DgqmQdCOOago5RFhlse873n0WeZ49nUThTZ
	oUTlD973NnkvZdrokP5sthc2QOEsdKp0=
X-Google-Smtp-Source: AGHT+IGTmF0Vb6HMZgp/sWggxOFXHOzHWtjb30jsvecLQAoOP//xdTjLFIAyhWQ16zUCCabgxDURLJTgCe1037OWug4=
X-Received: by 2002:a17:906:3293:b0:a96:cca9:5f5 with SMTP id
 a640c23a62f3a-aa509c06cf7mr125479066b.37.1732266912197; Fri, 22 Nov 2024
 01:15:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
 <CANn89iJeaaVhXU0VHZ0QF5-juS+xXRjk2rXfY2W+_GsJL_yXbA@mail.gmail.com> <20241121195616.2cd8ba59@kernel.org>
In-Reply-To: <20241121195616.2cd8ba59@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 22 Nov 2024 10:15:01 +0100
Message-ID: <CANn89iJZnpeus8neFYBO85iOP2vTT6QwxRKFgk07QnLwVGN+Zg@mail.gmail.com>
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer access
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 22 Nov 2024 00:41:14 +0100 Eric Dumazet wrote:
> > > Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo poin=
ter access")
> >
> > This seems wrong. This sha1 does not exist, and the title is this patch=
.
> >
> > We do not send a patch saying it is fixing itself.
> >
> > I would suggest instead :
> >
> > Fixes: c69c5e10adb9 ("netpoll: Use rcu_access_pointer() in __netpoll_se=
tup")
>
> Or no Fixes tag and net-next...
>
> I'm missing what can go wrong here, seems like a cleanup.

Nothing wrong, perhaps add a Link: next time to avoid confusion

https://lore.kernel.org/lkml/Zz1cKZYt1e7elibV@gondor.apana.org.au/

