Return-Path: <netdev+bounces-215417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA55CB2E89A
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3131CC4325
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 23:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106812DCF75;
	Wed, 20 Aug 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQnKoPdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448CE2DCBE2
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732162; cv=none; b=DimnBdUFLWxfADTKdxKgVX9cSP/feWx9X4xDmnpYWWCkXVyfHY4dRAAjo9J33BfX2t6jXo9hXU5aZYxSjWmH7yCee6szDBB57MmIMlJNVJCH8wwEzndOpQgfloiVEMtDrpi/39zviQEyd1qj5yrc+tDSxhQ2iYyBBVNCOTjhQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732162; c=relaxed/simple;
	bh=3ns7PDPn1oAp+dJ/eGemiLfeXIUsvFxi4A93rjEHTd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZ6e1pznI3CoLXn2QzYcZHt1jGlPE0dh9EiFosgo2YW3SnJ42nyxmuwiByp004aSaxVVyCcQzO1ob+lD20Jn/CUItHeGBohlkw2HJI3G9FYkTbe0vrAFH7BDa+H57k4DU7715OCl8jv0oUvXmgme/ZA9ToIAevHLwvAlOmVyPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQnKoPdD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55cdfd57585so1733e87.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 16:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755732158; x=1756336958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ns7PDPn1oAp+dJ/eGemiLfeXIUsvFxi4A93rjEHTd8=;
        b=VQnKoPdDI3hP26lv3s8FDFhE46o2MWxdGgk5nRj5hL8qxKxWWd4NDOTpXC2K+MqLSp
         DRqRkCea2umf3zwGBI12E+qD48mz8MzxnhWdjLeENilHZ6d3khnS9cCZ2M7DyOCEgYFE
         Nn7pGvhodD/jj6y7paNlUPan9rup6TXgMcb/HOB0oL05PRGNwqwzx56Osnleo/kjZSW2
         +lJv7Jjw8tREdoRUMSFsivrOsHitmTFGvXbDKvsc1i8niwKxHd+ycrJVRUcj3g4I9VOF
         E3Q1bnVX+bOrdPVsy5Oj3F5Ow2H4w9FV5L4r/xdCm6CZklWH/ETW4yvICwE/RlzEnB+0
         /M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755732158; x=1756336958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ns7PDPn1oAp+dJ/eGemiLfeXIUsvFxi4A93rjEHTd8=;
        b=mOmJAISZRoTIwZYJ4pDTXcSF7EFsMTnItuYnHsNIbgAD78ZOcXcSQLfXnwPjx8VxUG
         reJExzRFNqHMkQnR7n70rU/9WVrv2nB5kvWu88F3vpYNYU1wJEd9E3IelulUI4FsHbtT
         WfVh4ZiQgqcE5cmSOT4/WTcy3XyHXzq2PAuLsQ6cdaO25NVYTg/kTHStbkyQWhOaHxYr
         xqwboeGpt3pYJG9oEvupVuBS+PazPx3IwSVfBxDLY0a7FWU8ueLYtPro6vKMXnRH5ZIJ
         Jg/nS9W3gawDBLB3nNICSNcLuI/9MXr5RoMsceNlkaq59VAqz2iJfY+RfzsQKok84iO6
         a7vw==
X-Forwarded-Encrypted: i=1; AJvYcCXh97UUJGEsmJHHgwcSgYUVAySsU/79k61qeNDQw7wXS55Zzm8Subw1Rb/jONNhGUXAvzjSho8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbdps5kkqxLCs/6FQGVGd4RB2QPJ56YbtW53FKb6YM5Rb8u1Q4
	qDdICrNaNC58hvrgfRAq4A26Fd/3FIQXuPZib2Uy8lsREUVI80jGEHl0YsiQoH29vjtnUUstGrS
	kiDhLhrcGrecWJYK17tBGmTz1duix7CsNQnLnNqKS
X-Gm-Gg: ASbGncv923uxSrt1ODMbS5/RxuSyGcQ8maArpv8oCiFOsflxQBicoZIk/1xhsECiPuO
	HS9+A19kXAmjOXhdzX3bZIZwWe7ShP8CEevVgx2gpBdNXGxBzQ1YQc3LvKDBseg05mOaHlny9+J
	AREVFs8Fa3Ky6Auf2kYOk3oUqREYEIRgI2m2OSW1IyNGSgj3S0dllr7D5e6csgOmAlMcvauhXRH
	e603Wy+80ShThpzYs+ysXM1Yb0RCNon2B49x0nzx7E9
X-Google-Smtp-Source: AGHT+IECFpnVCn1bxSBonVVARZ3YYEygNbA40Zy4ffHs35nCGs3CnDol7hQMPn45F7N5fb82oTDqrJsUiKxffpI9FRk=
X-Received: by 2002:a05:6512:290d:b0:558:fd83:bac6 with SMTP id
 2adb3069b0e04-55e0d8000ffmr70616e87.4.1755732158166; Wed, 20 Aug 2025
 16:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820025704.166248-1-kuba@kernel.org> <20250820025704.166248-6-kuba@kernel.org>
In-Reply-To: <20250820025704.166248-6-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 16:22:25 -0700
X-Gm-Features: Ac12FXzpP6UwohZ09_4cnFkGySgBbG2GDjgsFy8c9QO_KlzNWU41tsB9Xk2WY90
Message-ID: <CAHS8izPRqiaCmjsLG_tZRo-7W3xJ0QQmSQTQbYK-nkxx=9jmxw@mail.gmail.com>
Subject: Re: [PATCH net-next 05/15] eth: fbnic: use netmem_ref where applicable
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	michael.chan@broadcom.com, tariqt@nvidia.com, dtatulea@nvidia.com, 
	hawk@kernel.org, ilias.apalodimas@linaro.org, alexanderduyck@fb.com, 
	sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 7:57=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Use netmem_ref instead of struct page pointer in prep for
> unreadable memory. fbnic has separate free buffer submission
> queues for headers and for data. Refactor the helper which
> returns page pointer for a submission buffer to take the
> high level queue container, create a separate handler
> for header and payload rings. This ties the "upcast" from
> netmem to system page to use of sub0 which we know has
> system pages.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

