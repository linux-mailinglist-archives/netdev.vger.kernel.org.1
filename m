Return-Path: <netdev+bounces-129042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 699BC97D1B5
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3196D2833D9
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857EC26AE8;
	Fri, 20 Sep 2024 07:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsnIQRpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0890D55887;
	Fri, 20 Sep 2024 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726817247; cv=none; b=VnoL9VhiEgv7i5B9H4RXaWztAVSwPJ/zGWgr1QQ8gZVZc0YJfjFPXe3/l4V71DnKbr37jWgELAVbjXFXS3G7Y0IJJajKqW8ISfypIPadN3+zLFGJtHfJjbDV9cD3kc+Y22XEaNxJXqz+WUsobAEc2eCGKJhkr6/NS1Aa8MbUL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726817247; c=relaxed/simple;
	bh=MZlGKaVHHez6qS5kEyhcLN0JjdWKG50+esMk2Rg17mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U5i+mY7ssldX/e7VMwLoThLSxZTpzHlnOuAWH6VBwLI3GcWXPZCvelMlaNYWwE6o2DAgTOTtL2dgZ8KpjL0mAYoDHvzpmctAZoU1oJ1llTdYwFm7eMrKDJBfmfyWmwbYMsedBBEFrHsOSmPMXhQwrVdelmb6s8l0Hi0y2lLGUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsnIQRpN; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6c35427935eso9128806d6.3;
        Fri, 20 Sep 2024 00:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726817245; x=1727422045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZlGKaVHHez6qS5kEyhcLN0JjdWKG50+esMk2Rg17mQ=;
        b=CsnIQRpNL3pFf8Iwq5ogixtiBZaasIHT120wbQeDuant2NKsTcFYoI6facj6beHKHk
         wV5l6o4UzcUU+/LuL+iCwpiE/MP9pL2+fq2Il3RW3jjWIVDf7zLaejqoIYS+XkKy0x2q
         Uj4jMtg6ZmEH84Y5L9CPj6esrCqtTWJP9fACDlsxoZgsobo8XCv7/a7BI9RTDcGB1aBi
         6kt73WI+MC3I2IZHyIE1Cqmst1onNcq2cYvoKcEXBA1mUUaO5CMC2U/J3R9s6ZDamTzG
         VfjpeCE+XFMjbXmDCIYi1HvDN/GPrOvnAavNq1Cd9dPysV/3HyhyS2q2A8XQtoHh74QV
         K4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726817245; x=1727422045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZlGKaVHHez6qS5kEyhcLN0JjdWKG50+esMk2Rg17mQ=;
        b=qVwyGhpqr71crUDgYp0R9Y6FT9r+xxECu+yWRgEs8NGGe0WeaK3NNuZQ4BUVRQyKvy
         YQepQJv/i0hYPi5PdqJ6Ouw0/TXITkaeUtUdQptVVOBlA6pJo+pefr+sKelE785tEeYQ
         EBG5ujpbvTBpXGYMyOzh796UI51OfuBmLcR3Dz+DYtsRzQmaMzjVPWcc1qTeyHELwPoy
         /yy6WgY7BqHMwc/rKSvOjpW5qwYAA91K+O0e3oQRMQFbUFr36XGdOOpSC+i9/n72IZWJ
         Rs7O0Lm6TndeBlQeLm8F6VXTAIgpPbby5SZr8Bfqi0pqNDe33wSsp5daSwCw0KuEUNbB
         s3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWx1OdSO7eNlA3qmHCwZlkdd6BULQyeX8LdeNrvJZynlkz0JIJgIR/79xQ15/Osrii8jIU0Np3o5SokbJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBrSFLS031yoenU5hzn7l4pmqESyvUQuNXLIBG5WgUGhLRX4rn
	xF2gwZoNHA//RnS/SbuqAC0Pl5YKjyB2FXyAqBw9p00Crq/oRik/A+8l9l9Fa5H9lWpdPvsqIJb
	u4CgvJfVllG2Aq6nJPQXcymXRX6M=
X-Google-Smtp-Source: AGHT+IEodLpDLNCLAZ214FMIY/ZpxKFDa31hRkHoWZjaY3f+6FzzN2bDnn7OxHF2bmy64U7Mkbpsr/2M6MHJ3ToqQ2E=
X-Received: by 2002:a05:6214:310c:b0:6c5:517a:56d0 with SMTP id
 6a1803df08f44-6c7bd4c8d45mr26801766d6.13.1726817244831; Fri, 20 Sep 2024
 00:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240919142149.282175-1-yyyynoom@gmail.com> <20240919145609.GF1571683@kernel.org>
In-Reply-To: <20240919145609.GF1571683@kernel.org>
From: Moon Yeounsu <yyyynoom@gmail.com>
Date: Fri, 20 Sep 2024 16:27:13 +0900
Message-ID: <CAAjsZQyruuyN6VC5T=xQHFVWeOLhz4D3H0vBrwTRoqQHDbtsEg@mail.gmail.com>
Subject: Re: [PATCH net] net: add inline annotation to fix the build warning
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 11:56=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:

> Hi Moon,
>
> Without this patch applied I see the warnings cited above.
>
> However, with this patch applied, I see the following.
> So I think this needs more work.
Okay, I'll fix and update. (Of course, patch after release `-rc1`)

> net-next is currently closed for the v6.12 merge windows, so non-RFC,
> patches should not be posted for net-next until it re-opens once v6.12-rc=
1
> has been released, most likely during the week of 30th September.
Thank you for letting me know : )
During this time, I'll read patches, docs, and code to increase my sense.

I appreciate you reviewing my patch!

