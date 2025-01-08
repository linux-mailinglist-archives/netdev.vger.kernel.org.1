Return-Path: <netdev+bounces-156376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D4A06347
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 18:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B2B16087D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A401FFC70;
	Wed,  8 Jan 2025 17:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KfuwB3OR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D518D
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357103; cv=none; b=lqufJ122I1dOFrxNGoY6fI/e/1+UWVVMLUEv+qQ6Ky+DYd7OVYz4dXegDwlkGGXJIJ0ya0ujduDaU5cByfTA56PDTm1a7sTGTz3bDhdAxw8x+NAaSi3mRnBCDtzJ/puKX7mt6BQziYuF1VVE78hyKRbSq4zwYJurb8jEKpscjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357103; c=relaxed/simple;
	bh=yRNvVFqPhMWRzi/KbLrkLxw8x8RSOT11oTmE10plhfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZayqMUmJG/CQymFC+dc8bN9AzBy+FkmuQzckYbtALaV2vBahirTFJ5PLmckPOh+7vEDrCRTsoMe9fLk8+gMY5SouuoliYm+Ethf8fS5FyAUQXOz4UZuLQFnvV+F2eJKRwnYOIXU9NJdW3zXngPqCBwv+D7m7T6issHI1SP6vyUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KfuwB3OR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-304e4562516so247281fa.1
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736357100; x=1736961900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRNvVFqPhMWRzi/KbLrkLxw8x8RSOT11oTmE10plhfw=;
        b=KfuwB3ORDHs/3HlcKUk0Wpeg2knfuAYNNjc4/KW6gkmUzlpF44RJvOIraRMXdK/3Ta
         NyPpijAs9d6i8bcdZrRQZh9tNVouJs3SB5/P8bmthokhLLJTFkKy1YnTnQaa1vvNKll7
         6ahVdJQ16h6gkHXPfUKW8JX18VDCghL68MP60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357100; x=1736961900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRNvVFqPhMWRzi/KbLrkLxw8x8RSOT11oTmE10plhfw=;
        b=aPfVF1ptgJshIcdCTomsutqwI9FGPAxlo9rN+aasUmlKmEHntkOnr+BhbFKAJSy9KN
         h7cgxTM3HheIQk59pdzRRVsgLQLd7VSG9Z64ZsjQPvFGGISCAZ1TLlvhoea09OtVqn3Q
         R1S5J47x4VG8vo/aQuFmGNIP1iueb4ggBDf7GKOQowGRWRGBEZkxjY8QJ8Kl7pvRLQZB
         DVYytGfTWA1OhZj3/mBUwWrp0hRZLRsbU89ARp6dZRVyEPq08ibAVM9zeZilbfjSLNd6
         irmYtuvjNHhZ36yLU9Ca8BoDwJy0x01G9vmYhxCXperVJnobwsBlmoY7t0TfvvwJKHSS
         n+ig==
X-Forwarded-Encrypted: i=1; AJvYcCWXf3/eZb+6gLZQXTXjieSxXDLlEFPQOcXe/Qpn30KUN+Kcd6QeO4BS5mc+dsKQin7D5yPRzl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAs4/y5GkN0lTHc+dsu6dkqEM+rO3L1KMEid0BJWziKY+gupUY
	xgOoDJB1N0frQEsH5+HwvIpkMtz/cjTq4OYmUc2j8E+QzTPnGgElpUvEv1TiQAH98BxQUWrG8YI
	MI/MKp3yqHkMVhL99+wOtTThCkSKc+fgZSSiVHD6NMqsp6rpwFxFN2SUn1yhiJbDurY8ea6ZwKO
	BS5CqGZ5NNCPkmDOjRFQ==
X-Gm-Gg: ASbGncsjDzpAQ4ZXnZKQUBXf30anGbX+Lnn91o1+Mr1BTqlyeywmc1YY691Kp8e454n
	1bWMtvQ8w+mdxjHYwpgWKwvwRouNkZ7buDNrGuV0=
X-Google-Smtp-Source: AGHT+IGvPYRme0fQyQ3G0E4/27vS2ohN+pn1erZ7u0IxAI1HxDJo/Z7EQpzmyH+f6ITeZXqI+Pvwkm/Bd/rSn9gf728=
X-Received: by 2002:a05:651c:1993:b0:2ff:b8f5:5a17 with SMTP id
 38308e7fff4ca-305fcfcd638mr436811fa.5.1736357100094; Wed, 08 Jan 2025
 09:25:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105213036.288356-1-atomlin@atomlin.com> <20250106154741.23902c1a@kernel.org>
 <031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com> <20250106165732.3310033e@kernel.org>
 <2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com> <20250107154647.4bcbae3c@kernel.org>
 <CAP1Q3XQ_Fubke4=SYrFkaiJj0RHB99ehdMedMVDTFtRS6R_RCw@mail.gmail.com>
In-Reply-To: <CAP1Q3XQ_Fubke4=SYrFkaiJj0RHB99ehdMedMVDTFtRS6R_RCw@mail.gmail.com>
From: Ronak Doshi <ronak.doshi@broadcom.com>
Date: Wed, 8 Jan 2025 09:24:43 -0800
X-Gm-Features: AbW1kvaT4vpj2C2Wax1_P6eksCuaLMSrK-0ALBseaNYTGAnBJ9b1bN50fBoSi6Y
Message-ID: <CAP1Q3XTK0kP0hE_f1Y-tsQdCSToW9gkQJA2TMJwFh4v+zAhM7w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bcm-kernel-feedback-list@broadcom.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 3:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:

>This driver seems to read the default size from the hypervisor, is that
>the value that is too large in your case?
The default should be 128 which is way less than max value.

Thanks,
Ronak

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

