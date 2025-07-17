Return-Path: <netdev+bounces-207930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B01B090DB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F1D4E796E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2172F0C61;
	Thu, 17 Jul 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdprGg7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BE135963;
	Thu, 17 Jul 2025 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767285; cv=none; b=TFiMEo9EYYv1yIMZmM4Jewbq2EXPyd5KovLxegnQS8JDIKUMCFvCUeSD8DsHAZG8Jey7L8n+Lv/DDWMbY0JxvZ+4qucFDyd4XXrtsw/lJ9m8nvftVG1bG6b7jwpzG63/KfLdjfbAwu7DvxlKkGCG2vveeiqYrb5j7BxWHiq1rfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767285; c=relaxed/simple;
	bh=OfE8znsgzLAscLOB/5tyPmFGM2y2PcyOzlU2wR7OELo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bB5Oe5xBg/7OpnE/NbVL7qepS++KNDbYfKQaAeMTL1Hvr0gj00WN6Vztx407Zdhh4NyJI1l+7zKofMZQGm3uxpBmvLuUgaGOA2H35Op4D+pqFvmL8TvYn5JFd+NEtfHhSPVNbDg74qCAScJ1KheHg+lhjLC6G7SQTlzZw0bmpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdprGg7H; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-555163cd09aso944548e87.3;
        Thu, 17 Jul 2025 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752767282; x=1753372082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5oZN8AKAZsvHFL9rwr9nKGdeMEi2sbS9c/718nDOV8=;
        b=HdprGg7HvOBftZctpQl2F+xO4jPbvphIW+AzKr5Ac1Ap8JRNmMQlIeptjgX9pbVWfR
         3oDYGzLfgT7If37S10El1Wbfe9ZbSoCPrS1ngIf5yL3FK0WMyO5n6XGedSDvbX5TUSOb
         QUCGKyPDFPEIx/8UTpCVujcjiZO101gLO5Z5pUjqGSqheA8oqyWkOSAhjdfnRmrxlUv/
         cTVrampUhwQ+TDG/iw5k2i5sC4MrkrlQKSGZNVHiCCgl8nooC9kHV1xUUxm3hZn3JbC3
         8f2v3PN5hUwSuCGkRx/MXZy1E0e/R6Wa7Z7k6T9WH+VwlqBX6qRHQix+v3/DC5UhaTdU
         +00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767282; x=1753372082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5oZN8AKAZsvHFL9rwr9nKGdeMEi2sbS9c/718nDOV8=;
        b=p9lvCUPpF0QlFtGnfLnZrKbO2oE7WUqwsPFeNtpSrcAO7Gm5/pvcKx+DfdTJfkTswI
         V8V3/qCBZw4GxFs4ZxS3XC3+XarH6iqEy3sLYvOuv9NzKqyix5OwpzXVZLQLIyADwHGD
         frpTILOkLdTZxToGWKtJ2rLBXNq/hDkLcDRaeShSkc9p6wc1AaLZD92EdPXHOyk5/pmW
         gGt3JWZFGBH3FrEz8eFQ5lnXmx8Mb/ynpbbekEFkqwdaggkYjrxjkih8E6E/pgnB9FIS
         UJ4aKknxLDnWPVWiKM3VmRaLtSKqAYJHkbO+XntAJsx0CPS+sdoAYiJSNG0FLZZqZQob
         qong==
X-Forwarded-Encrypted: i=1; AJvYcCWRMLHXw5quc4fAhXOX3CYuw/LfoYBMYANDa8UZvGhWDmvK3m+en3VZGVFMQCYFe1xOvjkjOWDHtGsSnZ5VpDw=@vger.kernel.org, AJvYcCX/AxqegEJAyrpG44ZQmILmmGCh5zYdJron4NyKr8pBUpN64KGL6vula5we7HFXGNqpv+H6T+H0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UqJ52hCEtOE+pDXVEh4gFQ6uJO5759dQxRIO18rAJfz8zJZy
	YQSE45DirrdWCMHS/HZwNvSTNLWu9rdhQSGWB8DDxxuWYoYmCktaEBIjBQx0ijN1EcTWYS3WUhv
	GQVrC7udbtLqnm0uJbRsC4xeH3wQXfBFEVv2n
X-Gm-Gg: ASbGncuLFsz2u+tvaA6QxwNl82kzk82W9ZLywXpYlkZmyG4LqPWEeoFMa8nMjeXiXW0
	Sy6xbJvLchPfObjm8kTeCxDnwZd/qIn5vVj68giu0/9HVOe01rlneAgrSlCUcH0GxdH39jo8WRM
	I+6JgLxM92ufostqGIjiQG7BY41gB3TUN6WSFvWYmae5PXlDycO//YseU8DjOT2ETyN0oXN8J9K
	3KyXg==
X-Google-Smtp-Source: AGHT+IHebl7pHemxLOC6HcPBjnCrEs4aU7DXAAyHdkbMFoPZtVifEZ96/EKsDI6KaIYbpVZAb5S+ld1aaGnTdAXuET8=
X-Received: by 2002:a05:6512:3b0d:b0:553:acf9:c430 with SMTP id
 2adb3069b0e04-55a295a080dmr1037374e87.17.1752767281306; Thu, 17 Jul 2025
 08:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717142849.537425-1-luiz.dentz@gmail.com> <20250717083857.15b8913a@kernel.org>
In-Reply-To: <20250717083857.15b8913a@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 17 Jul 2025 11:47:49 -0400
X-Gm-Features: Ac12FXwO3XErC6gJGcfaA689efmIjy2mTC83eLnKwwBa4iU165HTZlkEbnrVmVg
Message-ID: <CABBYNZKW8aG=sJP+iwk44ozvJwiv0wPkrPrOBrnFZ=39rA7-CA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2025-07-17
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Jul 17, 2025 at 11:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 17 Jul 2025 10:28:49 -0400 Luiz Augusto von Dentz wrote:
> >       Bluetooth: hci_dev: replace 'quirks' integer by 'quirk_flags' bit=
map
>
> FTR this rename and adding the helpers does not seem to be very
> necessary for the fix? I know Greg says that we shouldn't intentionally
> try to make fixes small, but there's a fine line between following that
> and coincidental code refactoring.

I should have reworded that commit, it is actually a fix, not just
renaming, we run out of bits on a 32 bits system due to usage of int
as storage.

--=20
Luiz Augusto von Dentz

