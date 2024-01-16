Return-Path: <netdev+bounces-63744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B268382F22A
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 642EC1F23CA1
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27011C698;
	Tue, 16 Jan 2024 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VOUjuzYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637C11C68F
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783148737d5so895068685a.2
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 08:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1705421548; x=1706026348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GYVcrkJ7KuMFZ6qAST+C6p9cSzy1v/oz/ZHC0vRo148=;
        b=VOUjuzYJgBR3iq2BYR3q22bSHziz1R+aGKqxMuzlMJbfv0KKKLtM3TNw1eG7a9vx4f
         oQue3KmOoL0WoU1yOn8I6xTQXK6xUDElBgJciuHpLmDxhnC0TV8yzecjeh8i00XWzEHn
         sjbTgHCD+YE8CAj+BINHTCwJmuRaZNbEHc6Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421548; x=1706026348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYVcrkJ7KuMFZ6qAST+C6p9cSzy1v/oz/ZHC0vRo148=;
        b=KJnSUDWf1EzUaOrs5CuVCG0GbTLlJMhx5aQVtMuyzW0vLXwPaRJVbpd3gQ74OpCX/5
         zacNuI/ufHDMFBpcuE8kRC1knDwZycHFJQZC7qcD2+sQFiZj/HM5KlLTkEGV2puYCSe2
         6zCB1sztnwpCDJeTeNbpWijz8R/VFsEJpF27fq3ffEUvuWXtjXz4NdQeG+Wp8Wzih1QX
         4OvZe4gyYYnL0DZD/tTCkvrpb8yzhc+sg5FAQjbQT1GJmpahPgJOjtH4U7GmP4JaSYEa
         zJjBe5styzDieXrGe6iWKCEh31rBjJYLtRu/B7Ce2xGGt3Oq8XjvjJaTsQP0qbj4tTdf
         K3Xw==
X-Gm-Message-State: AOJu0YwW/d+3ZU0LCVT6fQTvgVU0wToeZtLurGbzNm4uPIBm6NboyVY9
	nEgt1Debv6/W4/D7eDmIi6AsvfKxMqn6
X-Google-Smtp-Source: AGHT+IEMC3itLb0of0y15kNTqU3DEY2kvNx2OOJq12Stx21XCw5zcfoNRd2Pk+UbiakFixwPUv7WNg==
X-Received: by 2002:a05:620a:2206:b0:781:ab42:88e7 with SMTP id m6-20020a05620a220600b00781ab4288e7mr8271692qkh.60.1705421548278;
        Tue, 16 Jan 2024 08:12:28 -0800 (PST)
Received: from C02YVCJELVCG ([136.54.24.230])
        by smtp.gmail.com with ESMTPSA id w14-20020ae9e50e000000b007833008dae8sm3830480qkf.98.2024.01.16.08.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:12:28 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Tue, 16 Jan 2024 11:12:26 -0500
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 16th
Message-ID: <Zaaq6kh1IgDdy9SW@C02YVCJELVCG>
References: <20240115175440.09839b84@kernel.org>
 <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
 <65a6a0cf8a810_41466208c2@john.notmuch>
 <ZaapI9zDaP1YI7AA@C02YVCJELVCG>
 <52a1f5ed-37d0-431b-8faf-b2e5bbb659f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a1f5ed-37d0-431b-8faf-b2e5bbb659f7@lunn.ch>

On Tue, Jan 16, 2024 at 05:10:31PM +0100, Andrew Lunn wrote:
> > Thanks, John.
> > 
> > This one is a bit odd what happened is that by the time this problem was
> > reported (on an older kernel), the code changed out from underneath.
> 
> Hi Andy
> 
> Talk to Florian
> 
> He has dealt with Fixes like this in the past. It generally works out
> fine so long as you are explicit about what is going on, in comments
> under the ---. That, plus correctly marking what kernel version the
> patch is for.
> 
>     Andrew

Will do!  I know where to find him!


