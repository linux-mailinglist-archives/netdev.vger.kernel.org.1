Return-Path: <netdev+bounces-56303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0E80E752
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AE91C2140C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07D1584D8;
	Tue, 12 Dec 2023 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxT400n6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE03DB;
	Tue, 12 Dec 2023 01:20:20 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso75163131fa.0;
        Tue, 12 Dec 2023 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702372818; x=1702977618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rksCD0YvwRVPdr9cALicJG1jtcdwoAy/N1wXuToJ/sU=;
        b=JxT400n6Ifdf+AWxMyE2fNIf0sFC3S0juv/30GItoXMujRL7pnYm4cDdxAUesZVbl2
         hw4j9f/6kl9jBUmaOZE9grImZ1G7Eb8HJ54U0q0w1c58sjqUPOJ7pTFToeQT2EUO279A
         S1caps9sVMdkFBykM0usmt8MxrHjOyYXdHEffNle9p9KjTw6uJP2EqIFR8I2+m8bX1nP
         e6TJarUqrDbc5tv0+3HsisfuVoyF5c7hZwwX4tghlMSRXJcKmL4cwlp3II/UlfI25nOo
         uiIt8s/kWDEJZfuS9YMnUHRZEkh0ASyK6kq4ZTDcVHW9ZzUZMn5H9KZKg1yy9I3kMk1i
         Jkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702372818; x=1702977618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rksCD0YvwRVPdr9cALicJG1jtcdwoAy/N1wXuToJ/sU=;
        b=SFyuneQOKeycOFV3BqrXz5DeklizPaDf20zikgRcqULlHllEBACsuk2aEl4zN7Q9oG
         RITroujbCZXYRiyh0sU7bQrGwkxoqSuuI2kvpHuWJBdWuHHjtikbyPYSm4f2Z43CEqmE
         US7DQqZ3NyBie0uzgL8N40/ennXDOzOXcen+5HUd91CGTSOl2B0VHXEoCj8Mh5a9Q5lt
         zOO+QSwyABSW2e9oVRYXVDfO/isPUTCxJpN4PcqXskHWZxGK5uRRQ74VBMWEoN5xaMLF
         eDfJquyBcERx9nKIdhfsUv5dJ82gO/dDZCJYIn+s0/BNqKfR0XhG0LLohFq/EPfjOdwx
         /ZNg==
X-Gm-Message-State: AOJu0Yxm3oMEEPr4T6bpvoIFFtmQRlaGP9hFfHpi1b+12Rq1OPHhAv+K
	aIJWg2K/F/heqmatImZZClQ=
X-Google-Smtp-Source: AGHT+IFBfXFN9YMbampOxy4UlOpmDcj+w/s3WuIJrPWhqFQHlOAYZA7vdH0HKg760a+7o1+41h3Taw==
X-Received: by 2002:a2e:711:0:b0:2cc:1dc8:af0b with SMTP id 17-20020a2e0711000000b002cc1dc8af0bmr1600707ljh.36.1702372818014;
        Tue, 12 Dec 2023 01:20:18 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id ce26-20020a2eab1a000000b002ca00b027ccsm1447690ljb.123.2023.12.12.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:20:17 -0800 (PST)
Date: Tue, 12 Dec 2023 12:20:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianheng Zhang <Jianheng.Zhang@synopsys.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	James Li <James.Li1@synopsys.com>, Martin McKenny <Martin.McKenny@synopsys.com>
Subject: Re: [PATCH net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <edfg5hbcysvah5lnxoeygjn3qz2243c6o5ilt4uyeggegu5wzd@t2ngy4xikpio>
References: <CY5PR12MB63726FED738099761A9B81E7BF8FA@CY5PR12MB6372.namprd12.prod.outlook.com>
 <zx7tfojtnzuhcpglkeiwg6ep265xpcb5lmz6fgjjugc2tue6qe@cmuqtneujsvb>
 <20231211145944.0be51404@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211145944.0be51404@kernel.org>

On Mon, Dec 11, 2023 at 02:59:44PM -0800, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 14:14:00 +0300 Serge Semin wrote:
> > Although in this case AFAICS the implementation is simpler and the
> > only difference is in the CSR offset and the frame preemption residue
> > queue ID setting. All of that can be easily solved in the same way as
> > it was done for EST (see the link above).
> > 
> > Jakub, what do you think?
> 
> Yup, less code duplication would be great. Highest prio, tho, is to
> focus on Vladimir's comment around this driver seemingly implementing
> FPE but not using the common ethtool APIs to configure it, yet :(

Fully agree. If that required to refactor the currently implemented
handshaking algo (looking not that safe and clumsy a bit), it would
have been even better. Although I guess refactoring the code
duplication could be done as a preparation patch anyway or as a patch
which would convert the feature-specific callbacks to be suitable for
the 802.3 MAC Merge layer.

-Serge(y)

