Return-Path: <netdev+bounces-54608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FD98079E2
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 21:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08E7B20B49
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0C47786;
	Wed,  6 Dec 2023 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="u0eAYeqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA25135
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 12:58:32 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso290928e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1701896311; x=1702501111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hkBTFydFN1nOSzt1n3Rcusw0wfyqULgHkbuf/PZSmKs=;
        b=u0eAYeqIhbe/rA1Lo4nDnm0RBi6nWm0/IYD6WEbWO68zibTH1SStvAO4sjGVZ/djcq
         MBSXsACH4PdSUk8n0oeRmRItEtOBxsrJ+mrNcid+meii/NtV2A3w1h1nAa/CcOjcKS/e
         3yUXJC64w7wYnmlBV28GKOCC2paB4RNlcil6ZtaWUnnl9+AiajopsS7fvugTHxYoo5Rn
         ApyWXOEXiyr+6MLf3yPMiQLLJqZyiMvoB7BG3nDwyFPjJEYktwwWZqTDbRJK7KiTKdb/
         cfH/pBR0tqhEXN3vSwPYVSiFr58kBhI7jIS8QGIsLKq6yi4ttSmfZTIfnpV8QefAgA7p
         HM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896311; x=1702501111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkBTFydFN1nOSzt1n3Rcusw0wfyqULgHkbuf/PZSmKs=;
        b=o7uA5p69dypmFZ41YNymeNX75FCd1+egebq7trK03A2h4vekDxbIHtb16gx6Iuz9jA
         vmjRlm7VNDaFT110n0p37vyIQSeA0rMqwHHNlHzBCgZurBJc4meOLsrJCsKyi8bL5I5n
         GZvtXIk45ANH/DtpOwXHrqlhAMxOepdDbI65dvN/V6oCMxyxeSBamTSV+HOZyzroDQnM
         jcUnpfcBvXQ4H2JXVKc7uqmEupmWqT19KqybQxifIxwShIRe1wEDroN/U3WGplZ6m23E
         gk7H2FE0QcZ0BkxtbbMWk9jc7n2rWerwkwmK/cQFWWrG7U/Klyl7o7NI9QnsiNUi7If4
         WirA==
X-Gm-Message-State: AOJu0YwWsIc3PJ0UxkT2v7guPyyAb6eSPg+R0QwsJ6GPR2kYKwxZCU8y
	dVOf4ERur6SsDiYYe0h+itMoJg==
X-Google-Smtp-Source: AGHT+IFTNDQW2rib02jc7CQw8isgEbt5aN4TJbPLvy4HkaAkT3eMJ8mpiMj6cBZIaRTQ2B/WpzMAiQ==
X-Received: by 2002:a05:6512:ac7:b0:50b:f038:16f2 with SMTP id n7-20020a0565120ac700b0050bf03816f2mr3063941lfu.6.1701896310846;
        Wed, 06 Dec 2023 12:58:30 -0800 (PST)
Received: from debian (c83-248-56-68.bredband.tele2.se. [83.248.56.68])
        by smtp.gmail.com with ESMTPSA id g34-20020a0565123ba200b0050c05ad6252sm581412lfv.283.2023.12.06.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:58:29 -0800 (PST)
Date: Wed, 6 Dec 2023 21:58:27 +0100
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: =?iso-8859-1?Q?F=E9lix_Pi=E9dallu?= <felix@piedallu.me>
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re:
Message-ID: <ZXDgczrh7GznTOj2@debian>
References: <f25ed798-e116-4f6f-ad3c-5060c7d540d0@lunn.ch>
 <20231205102039.2917039-1-felix@piedallu.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205102039.2917039-1-felix@piedallu.me>

> > So there is a gap in the revisions. Maybe a B2 exists?
> 
> Actually, probably not. Some search gives this datasheet:
> 
> https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/DataSheets/LAN8670-1-2-Data-Sheet-60001573.pdf
> 
> And page 2 (table 1) shows only revisions A0 (rev0), B1, (rev2), C1 (rev4).
> Not sure about why only even revision numbers are released ?
> 
> Page 193 (table 10-1) also shows only B1 and C1. So you can be confident that only those exist.
> 

Thanks for clearing that up!

> @Ramón, thank you for your work on this driver!

Much appreciated
R

