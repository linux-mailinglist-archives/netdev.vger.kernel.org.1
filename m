Return-Path: <netdev+bounces-180045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C6BA7F411
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 07:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67611898D88
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 05:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687B3253342;
	Tue,  8 Apr 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ycp8js6V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C497320968E
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744089613; cv=none; b=hTF205ntaDl3VAtjNoWxZdjnP20gWz3Dd5RfmLYFRmwcg97UoRhNoFBXiV5xJJsAdKGcQDSBU7fhFXdTjW4d7Eh5RW5vTP1LqCM2NznTVK+rP49auCQ++4qcC1T935O7AVENR4nOojcFawVs/u/g4DSqi7zueVxrRplxa7t7zdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744089613; c=relaxed/simple;
	bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDbxqi/nBPhmkb+7M6sfsXi+6PmnQMDxBJR7iXnhvd6xaioMNf1WR524Gpvu+NxsSwwpiz5/wYEde40f3kArC4KHdcrXZQt6XChicY5Eo1q8CAK79rK2cwpRxgMmmTeMUQN1s5hNmK2zLt2X22CGbXYea9LvTI6+0n2QSGZHHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ycp8js6V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744089609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
	b=Ycp8js6VGyZT5BefndTNG8mFNiRC/GRFYarA5FTXwJq2A2bHQbRpuPHPRlzP2Ro8gxGR8P
	ajX/97ZaXNM74o5/0gf5/Woeo5G5CvkkOtkdy45Z2C0oKoVUS6bCuyQWR9vmTX2oF90JL4
	MB9+teaFTfJvxqFkAi2JwRIrzYMq3ws=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-jVQq7dv7PZOaZhSEErU8XA-1; Tue, 08 Apr 2025 01:20:08 -0400
X-MC-Unique: jVQq7dv7PZOaZhSEErU8XA-1
X-Mimecast-MFC-AGG-ID: jVQq7dv7PZOaZhSEErU8XA_1744089607
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-603f3a4c58dso741650eaf.2
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 22:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744089607; x=1744694407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPWwWnJ7ViDkLl5MW+qHSwW3GfvvX0QdfidKESl6o9Y=;
        b=aaGgNEBhBoEHYcNGJ7CLcpOTf2VZhevGXW4McJUYPj3Keudup1r6ZWEFyAVDO5vy0V
         YZ3Aoy9tRSm/m/X0IdYQ3mbLR6HOM6oelEDolvktSZ9OsrhjQPSOA+Bbii2j9QoCLKQt
         baYFCkOx3gEtTyEd6sM4dVjiisTMFt4BYpLjn3rmkpSasZyvsvk5vtoTzqHMc8DkPTGC
         8CoXQNJbQ03dKjbNjZth/eax1JSrTwWQe6QvBj6Z2ru5/cyIY2GHmMlyeAUkZTeGpQtH
         qBqY5TgijUchbptg3LC4UNgLm4EvgTBrN+DYHU682IqFyFnPltjNTyKn2U1uc0Nhryh7
         /wig==
X-Gm-Message-State: AOJu0Yz4CJH7byMDKBcssadggUctu1g/8tikbpVVTkNO7dSZq6IeWjGS
	J5iLZKI1x+DbbE8bnvMVIzM3kod10JfocqiNeIxQ9RqC+l8+61rN4QyPnm1ciDH/GYIcV3TQwP1
	pZI0NEpVNm7JycHMRBtwMnBi+oETo4OHS1qFzdT0sIQakCnEWC5qcwjbeL1FR1t9z9akDFCsQ4c
	ygWPj4yXd3581b+ekCTM8zZB/rSlYm
X-Gm-Gg: ASbGncvIhpxpynuDT7iQtC8I/WUpFbmP4yizvnBCEJx1bbSN/WHr+253TyXfBnO7GWf
	wT48FwVWFHIt14TrjcUuwEote0r/1OfZ94s6cVQxJ7IwL2LChHmiUQR8qQ5SBl8Y/YvHtQsM=
X-Received: by 2002:a05:6808:158d:b0:3f6:6dea:55ac with SMTP id 5614622812f47-400456a460fmr3391082b6e.9.1744089607266;
        Mon, 07 Apr 2025 22:20:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFndQwFQTxqQbhh7/1XO26yh+0Bql7sVDUgvChNzviW902Do9tUiMP8jbpkd2ikbG9OPRvnppdBsFKJDjF8szQ=
X-Received: by 2002:a05:6808:158d:b0:3f6:6dea:55ac with SMTP id
 5614622812f47-400456a460fmr3391067b6e.9.1744089606990; Mon, 07 Apr 2025
 22:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407172836.1009461-1-ivecera@redhat.com> <20250407173149.1010216-6-ivecera@redhat.com>
 <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
In-Reply-To: <74172acd-e649-4613-a408-d1f61ceeba8b@kernel.org>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 8 Apr 2025 07:19:55 +0200
X-Gm-Features: ATxdqUE8CZctw0bSKyYLZFAm9WOiGKPiK7Kqb-GLiHvQfp2TsbW9P7zTG2qlt-E
Message-ID: <CADEbmW3Byn8a4otcHqHr_=p4s5kKFq2D9N9xouWVr_0VX3ZikQ@mail.gmail.com>
Subject: Re: [PATCH 15/28] dt-bindings: dpll: Add device tree bindings for
 DPLL device and pin
To: Krzysztof Kozlowski <krzk@kernel.org>, Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Lee Jones <lee@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 8:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On 07/04/2025 19:31, Ivan Vecera wrote:
> > This adds DT bindings schema for DPLL (device phase-locked loop)
> > Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
>
> Did this really happen?

We have been through several iterations of the patchset internally. I
pointed out numerous bugs in the driver code and suggested cleanups.
However, I know very little about DT, so in v2 we should omit my
Reviewed-by on the DT patches.
Michal


