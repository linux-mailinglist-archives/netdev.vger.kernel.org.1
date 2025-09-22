Return-Path: <netdev+bounces-225398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D0EB93718
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8941F3B7982
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821092820D1;
	Mon, 22 Sep 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PQzv0NPl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB12C187
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579353; cv=none; b=CMKVqIe4zG6UFTrWCk8w1s38yj+fyEEJVndqbp8xFcl2pdBENkvkfcIn8BDAr0LIYYCYxXV5efQYr1aRNi04FR1Lz3lMcYPbB6pO+55+m13sFNK1bgEazCXQTzj891Xs2lJXbZYmALeBn4zLVBRtnPkBhlpjOjZ0epwcdarse+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579353; c=relaxed/simple;
	bh=Kar4KQgK6laY1Dmvo/+Ydw/T/vl/yNch1cTqbQw/1bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEAOq1sVutmWwU6sUk7ZNHqFOIKjt8wdJFiuRTfuy6Ywh1d8fFRjUID5l4JoHvbHh012LghzlnZQm7PgtXpZtOvBgywCckenAtSkTCbYYcB+6cA8+hPzFk6Bqa5eqcYeGTuPakkuNp7di/FH8SrbE1n8yOWffG6C28rjfzQxAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PQzv0NPl; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-4256f0444caso9900815ab.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579351; x=1759184151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kar4KQgK6laY1Dmvo/+Ydw/T/vl/yNch1cTqbQw/1bo=;
        b=HhCo/oB8FYwcx/Bxp09jxi5Jvv6O27+HS7rHG3V/TwOVW4yELi78p0gBNf1QR8ILpz
         qBLjxqejUE2QKZHB/AsQzZ7pSy4LKrha76ffvsQjTfzuKyEnQsQ/eUkKfYJiz9cTFrgL
         AOoh8/HYeZAsCbrPHdK/NPoEtEdMPTLLsVSrq4FQvWbDV73IZDfDxN0xmsDX/rkKFJcs
         j5YB7OptHygbTOh81ySNiPAX92DLxxMpAw+VnH4qWnC0+n2fE6GL518NK+jGcrunGi5m
         q+eDiyrr2HlDqhQ1ZzBkiidES1b2/f6pjKsCmozTsvVjDcJn8u6x38XkXsNLiOAIhaHn
         HbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk+aS8lGsvruYLuN8KyU+c2Kq7wopNft5sr2kjtJkOrsSo8o9qED6O1edmTbjVw1ILlDwh+kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPRYQY3zs3TO6ohLo163cZFYwVvrTrnrVXpo/yMBzuHq5XQZn
	BGlorLZ9Dn8NxiO2Aj9OHCvMUYJcjkPioXd2mOLZs/f+/sHqopeUlLwspzLemedGD6W8fCDPDBd
	l168z/ltkCtaxkdDO1ZxLcVcLN0y7u7vzks70V+eDYjQ+43CelNdwv8pGTxvsaMc0EVjKES+xT6
	nVgBwgp4CPsiUZLEh3QaQfB/yzImANZanQTS2OoLQoB+d61Z37taTO8tLnkHvvaAbZKvAeieYgJ
	Yrxr/TUI6M=
X-Gm-Gg: ASbGncs4QZDSlxhgvUwWO1Xd9OH5Mm6sclWrqJMGamqdwjmv5cv9sTeRQDydJSNaRYg
	8bFyam6pBKXqOvk0Hh5/vLMzh8D9YAwioYxV/CiE1CEzlYns+FzrDHrI3TR8l6SMv1pvICAxnEn
	RLbORpe0ac1h5489QsSrv4yAduStrEbQb+4EnBkNOgCSZvXhGzSRbzgiiXvlqj5IDPMqX/rIqJ7
	RbZoZ4MoFcedoR9OiU542LuokcPnO0kabeDQz4mb3TnwuFuYOx7lk2sfNMptvQEnx/GKSPrE6fk
	wJqYLn/tkjZlb2EDWzTYJaLJYpeQybDm4lqU83kGFTZDzL0vv5VsoMS0V8W65+z2N45gprgxnIk
	my0oxPauvpL/nl4+j9S1ZiSslwCwFTaco392Qp6IOcSK+Jl5yukrxnSP/90r6D92ex+s/DRVFFB
	c=
X-Google-Smtp-Source: AGHT+IFTfSsiNgTe95pAD0cgInsWG58h7UWE4XWNPjzbN4dAe9GlAcvfxlJuktQfxmskPpgRPxVAePfK+nsE
X-Received: by 2002:a05:6e02:154e:b0:424:881c:3bf7 with SMTP id e9e14a558f8ab-42581ee7ee1mr7208855ab.31.1758579350842;
        Mon, 22 Sep 2025 15:15:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4247cf941f4sm7018005ab.38.2025.09.22.15.15.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:15:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6232f49fc79so5128281a12.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758579348; x=1759184148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kar4KQgK6laY1Dmvo/+Ydw/T/vl/yNch1cTqbQw/1bo=;
        b=PQzv0NPlRD5ygABb+RUUz/KnPK4mQ6aUD2tMe+ANC1uBd/kmTYSx3VIBYhyiZS8wLI
         dClAHY3vGg7eEps9ESlEmxUdzhpxpaOn/2+MGo6GZjDBHdTwJHFF6N9SKNBfYncoCUJo
         YPl0sVtATfSsa0E6yafMDSMyFyt7V9Rw2zuuk=
X-Forwarded-Encrypted: i=1; AJvYcCUT3OnLT04TLBfCI7kgqcrvQQMLPY9aJRbJCzEyny4ijjEaaq3/32Dykoef01YLLhxIzYQXJ48=@vger.kernel.org
X-Received: by 2002:a05:6402:27d3:b0:633:a4b8:e9c5 with SMTP id 4fb4d7f45d1cf-6346777606cmr333278a12.9.1758579348170;
        Mon, 22 Sep 2025 15:15:48 -0700 (PDT)
X-Received: by 2002:a05:6402:27d3:b0:633:a4b8:e9c5 with SMTP id
 4fb4d7f45d1cf-6346777606cmr333264a12.9.1758579347767; Mon, 22 Sep 2025
 15:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922165118.10057-1-vadim.fedorenko@linux.dev> <20250922165118.10057-2-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922165118.10057-2-vadim.fedorenko@linux.dev>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 22 Sep 2025 15:15:36 -0700
X-Gm-Features: AS18NWAnPDf3r-Os0-3gPwp-NLNzJ3Ih9kj0JAj_IgKkz5pl00a5Y0qXNERMu9M
Message-ID: <CACKFLimzJ-fq2pT5ctfd1Q5Gg8g=AgvvbWqoKmUv4DwmcOsicA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tg3: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Mon, Sep 22, 2025 at 10:00=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> Convert tg3 driver to new timestamping configuration API.
>
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks.
Reviewed-by: Michael Chan <michael.chan@broadcom.com>

