Return-Path: <netdev+bounces-107727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A991C2B9
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8721A1C22385
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 15:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FC91C688A;
	Fri, 28 Jun 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErYawyqE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277511C2308
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589019; cv=none; b=VUP8r5JPPPs5OYyKz/R28KdZspe2Kg+7qzcTZLIfhq7SQZX7eh5rkQ5OzQIju2Tr/8ANaFgfcS2NK9Jt/zEvET1mEo+epB/PfkyvSvDQ1nWAdEyBaBjWOesNtAe5RyRLYBvcc3fkBCtbAFMutaycXUk8NQd6lryKLi+2eKcMVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589019; c=relaxed/simple;
	bh=vVe+4jTOm8nlo+0LfhR7fN86XbPqgypTTTNch3DTBwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=geq1ETrL4xXxFkCojsd5ZRiFUubQSYX63/44osw6dN58l8fYzPl0jmAb7COygmlV7sPIUnVLPTZ1ehtya6L0R1U4qqayaMFezhFkTweh6HVn54fgmRQKp20XMnbuuYoO1bMBPvp1FqnKWhZ1Q3d2ROspm0WYxhriiRjBkh2PKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErYawyqE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4256eec963eso4959345e9.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719589016; x=1720193816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tknJFnUHG3joxntL6RdRtT/oRy/rOVZFUIMBHQpvxhs=;
        b=ErYawyqEquPcFsxSJfEMBT9lAOXXyTda1PycW2qAvy8f5TjS0otsS64DB8a0E53DBg
         HO38aYAmtSRc68KAyIURjnU6llX5Ro0/6TP3nFOkl8RzL2cPekNl4ZcVzcAFGFYquX/P
         KQCNkENQddYT9TpVnddphjrQWcSxk4ZXEQZr+DZQB1kCnH0CKqLqw7vUVkGKW8ABfJ+A
         8NYVRGiBU/8ybphtnagNkB2IbQ90AJzdzKG32eM6B8wLkeqZ3DuSZ1l2w1Nktqbb68AW
         TjR704vboUw9njVG5y7llzVe2AHeh0u0TrLHjCuh6I4hBD4S1dYnDd+4Ui5dtCRpUHhJ
         VYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719589016; x=1720193816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tknJFnUHG3joxntL6RdRtT/oRy/rOVZFUIMBHQpvxhs=;
        b=q7j6rBL/UBso1uUCk8bSlIba8ms6mpB4jmZdE85RUbdH1NqaOZK7GUTz8s3vYOc55m
         +lGW331hWSy6xgX9yysRTGM2qbnEG9OWtzDQ8yui0FVMYSr4lGijxNPw9vmVqv8v+X/L
         OQbdBRnasRNmI6oPJt4cS54UENxqjUWhJZCQcEzCbJgVqDUs56EFbr5/IAlgRHp3KlZO
         XefnNoU+bDyHoW3Hw06ZKcGW6hpWvWbvQ0IZaNpFfCJRUpY7M/mxLKfxC+Oe3QjAjRva
         FkOjaL+I9YqkIRKzk6L3dcBZICTMzM9CMRPHtJ9ZDDsJCaeCjsnCYnG2U2a2o9XUCFSU
         hebA==
X-Gm-Message-State: AOJu0Yyk1YARtuPCY3wg1e/oXZlsIliIRWddbNbLq8+c0TGDO2VsJoSI
	W4Q+Ze2dwpMtqjG4eYHVGOO4rrbU0C84gkjNMovp1fpcbdoKjvI7+pgglt2u3RBFteq1U67uiGe
	aj+iu6JRE4mvm/XsJtO9/rPpGPOhdNQ==
X-Google-Smtp-Source: AGHT+IF6Wre7qDXAxrSg6RE/z2buzDo6w6ZZb4VEVOIBII8JTKlmwFo9jvuyv6RJiBWAYOaItqXd+7ju0FklJto9Sr0=
X-Received: by 2002:a05:600c:4c96:b0:424:addc:c79a with SMTP id
 5b1f17b1804b1-424addcc882mr52865175e9.7.1719589016242; Fri, 28 Jun 2024
 08:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171932574765.3072535.12103787411698322191.stgit@ahduyck-xeon-server.home.arpa>
 <171932617073.3072535.8918778399126638637.stgit@ahduyck-xeon-server.home.arpa>
 <20240628151452.GI783093@kernel.org>
In-Reply-To: <20240628151452.GI783093@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 28 Jun 2024 08:36:19 -0700
Message-ID: <CAKgT0UcRSmYWzdv9HHbo5rha8Ey+VavtcHqpEanQpBHMSVO74A@mail.gmail.com>
Subject: Re: [net-next PATCH v2 09/15] eth: fbnic: Implement Rx queue alloc/start/stop/free
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 8:14=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Tue, Jun 25, 2024 at 07:36:10AM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> >
> > Implement control path parts of Rx queue handling.
> >
> > The NIC consumes memory in pages. It takes a full page and places
> > packets into it in a configurable manner (with the ability to define
> > headroom / tailroom as well as head alignment requirements).
> > As mentioned in prior patches there are two page submissions queues
> > one for packet headers and second (optional) for packet payloads.
> > For now feed both queues from a single page pool.
> >
> > Use the page pool "fragment" API, as we can't predict upfront
> > how the page will be sliced.
> >
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >  drivers/net/ethernet/meta/fbnic/fbnic_csr.h    |  103 +++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_netdev.c |    3
> >  drivers/net/ethernet/meta/fbnic/fbnic_netdev.h |    3
> >  drivers/net/ethernet/meta/fbnic/fbnic_pci.c    |    2
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c   |  480 ++++++++++++++++=
++++++++
> >  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h   |   33 ++
> >  6 files changed, 615 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/=
ethernet/meta/fbnic/fbnic_csr.h
> > index db423b3424ab..853fb01f8f70 100644
> > --- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > +++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
> > @@ -16,6 +16,37 @@
> >
> >  #define FBNIC_CLOCK_FREQ     (600 * (1000 * 1000))
> >
> > +/* Rx Buffer Descriptor Format
> > + *
> > + * The layout of this can vary depending on the page size of the syste=
m.
> > + *
> > + * If the page size is 4K then the layout will simply consist of ID fo=
r
> > + * the 16 most signficant bits, and the lower 46 are essentially the p=
age
>
> nit: significant
>

Thanks. Will be fixed for v3.

- Alex

