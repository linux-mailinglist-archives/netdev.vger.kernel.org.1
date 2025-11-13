Return-Path: <netdev+bounces-238266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A14C56B17
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77445343097
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA182D73B4;
	Thu, 13 Nov 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtKs+27c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE162DEA68
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027507; cv=none; b=eVNi9PybKYCc7kzzR29Ve28r4sXa1oein+xLWVgQtGqOKsdSIvQIFvqF8dxxn4Egv5v6aD9TGYHKmHAmsdPlK4FfWaMUSqYSB21lhc/bhF4MYy3A+NgFPXq2gLAGIYUGc52oLd92eGlX2hYMscmGnxjajzm/AHqyQYqAx5nleNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027507; c=relaxed/simple;
	bh=RgjktZv2XAhgwBN4ptBHoJypVzDYRsIVI8dgfPnlX+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HS6U5OOD30tGwtHZxOGk3K+4O2ZER9GH0b/8WRDOeFtg1Wel7CrWzG0kcnr1k6Z52AQ9lBejpF03WDD9DftiEDQmhxbxAtMoTT2JcW4kfhStV9D7+0L1pQkCxuIcn5n6MIgbzgZmJ3kHubGGrmuIjqUddtWgWvflB952xgmUJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtKs+27c; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso532404b3a.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 01:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763027506; x=1763632306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=siCDfFiAG95kFP7N45GNHMX61vGB9DFLFR0iWn2XmbM=;
        b=HtKs+27cjdO73vAQf+PaK2asf7A4igkCHFg9tkk3ZTgIDy0+nZ4UKPKM0oYlQDHYsz
         QYtYxyMKT/8wsfkDOVUSonJpVbYTOvmt+HpUoXlWFt1hvRpZwwOF141ETtq5bI8SA6KU
         tr3E1yXYBuaMW9tUrAQrrNAmN+MH8JnIkKOD9sGM4zYE4PYqcG6soEHa0WsJdQ0Npa1W
         K4SfKVJ3/DErTMMXqnWilYx2zwO2OTNemb5jk0mTB4I3a+hJw39ArNmaASaQ3rrPYpCm
         v5gBdiOLhLR+6Gy4dQmHUTec43qCng6knlbwszBhew6FoMZsyhuEdC3fNNJB7QPFrMw7
         vbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763027506; x=1763632306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siCDfFiAG95kFP7N45GNHMX61vGB9DFLFR0iWn2XmbM=;
        b=w+nRf0aZx+evupvuhI4Ru9MCsY0GzUjhPiHPFpRPpw/cDSwVmc158WgNhbM0GdL8pm
         dbH+AOvCVe6sNObqv8aZVDaA4xiLIze4u4KWCQ/zuOFbFrcKD8UerKS901JMqA8TZUmC
         IOBBO3548KOBxF916yW32lI+mjxnt8gAx+jeaDhWWYfO6+nRMjdk0zfsV3rmHpv9Y+Lm
         a9/yklqmGUaK2QbaCPEAJvrGRPk64U2LUSSKg8w3Dc8HJcuCqAf+XGDE/54xget5SQCs
         nhdWdi03XiXNIed70OvNs1MsFDRvgFWsTBjBdnLLu/Fo27aJYbF9LwtIUKCO9nRoQunK
         TIIg==
X-Forwarded-Encrypted: i=1; AJvYcCVUa9WvnpStG+W6VtlQ8twB1TO+CkbtYF4Z57+J54EgxxPDMXk8KRoajFWMGvhi135rUzitBtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEDTU+cZD/RhAiMVHvtBYSIxD8ph/W/pQEWHFyfvqxZm0u2y2
	GfvfNgesWUNVz1uPaBFC/feO0LzWaaGS8QQSJWOVFFiXWw8e6q5r1ETR
X-Gm-Gg: ASbGnctaS++63NFJxs6DLlaM9dpT6HjvXv2poqzmVchaUlpJulOzkmizZhvIRTG/1Zi
	WFDPFbpa+8y6bw/Z2ys4JWuJRc0ZXo+4DMq3NRJ2ErQcrpbMoKlr4HgA+Gk6qeKT8IT+X+SJOHU
	UkcwjggYjTQ37UZhZOreswFGXseasFNEGJgR/yrIQvHA3pIS3RcpAuLz/HyTddK4DYSbPNSceEm
	t/gOISVp4bKG+s/T+dBYW/BlVAntwLYn7TE6uuvqBUjL38QQYZ0vwsItAGZvUGdcbDxS86o9oCM
	1U+crlb8MPOAXTiArHmNyxj87agheB2U7kViN4pGUcQdtoqmtnsy9cFeWw/8l5URsevbbhl3RVb
	2OJjCWQo/hdV5dPanmOmW59YeVzdIW+IOCAWXfRIytIfFGT+7XL8p96VVL/PGHEb+9hbq9Zqh2f
	gUrR9f2UP9eRBAgo4=
X-Google-Smtp-Source: AGHT+IEESu891JGUYwEk4W6LBSJLnxH5Ousz16ZwXeLU9xCltZgkaA+jE357xBq8+VIA2pG1XPRC7Q==
X-Received: by 2002:a05:6a20:6a13:b0:343:5d53:c0a5 with SMTP id adf61e73a8af0-3590938402cmr7881067637.16.1763027505603;
        Thu, 13 Nov 2025 01:51:45 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36fa02c42sm1701983a12.16.2025.11.13.01.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:51:44 -0800 (PST)
Date: Thu, 13 Nov 2025 09:51:36 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv3 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aRWqKA5nUAySkJFX@fedora>
References: <20251110100000.3837-1-liuhangbin@gmail.com>
 <20251110100000.3837-4-liuhangbin@gmail.com>
 <m27bvwpz1x.fsf@gmail.com>
 <aRV1VZ6Z-tzbDlLH@fedora>
 <e63b88ca-ba6b-4a6f-9a57-8d3b2e8c5de2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63b88ca-ba6b-4a6f-9a57-8d3b2e8c5de2@kernel.org>

On Thu, Nov 13, 2025 at 10:21:41AM +0100, Matthieu Baerts wrote:
> >>> +	if [ $$failed -eq 0 ]; then \
> >>> +		echo "All tests passed!"; \
> >>> +	else \
> >>> +		echo "$$failed test(s) failed!"; \
> >>
> >> AFAICS this will never be reported since the scripts only ever exit 0.
> >> The message is also a bit misleading since it would be the count of
> >> scripts that failed, not individual tests.
> >>
> >> It would be great if the scripts exited with the number of test failures
> >> so the make file could report a total.
> > 
> > Oh, BTW, do you think if we should exit with the failed test number or just
> 
> I know these new tests are not in the selftests, but maybe "safer" to
> keep the same exit code to avoid being misinterpreted?
> 
>   KSFT_PASS=0
>   KSFT_FAIL=1
>   KSFT_XFAIL=2
>   KSFT_XPASS=3
>   KSFT_SKIP=4

Yes, that's why I ask about the return code. I also prefer use the same exit
code with selftest.

> 
> If there is a need to know which tests have failed, why not using (K)TAP
> format for the output?

I feel it's too heavy to copy the (K)TAP format here. I would just using the
exit code unless Jakub ask to using the specific output format

Thanks
Hangbin

