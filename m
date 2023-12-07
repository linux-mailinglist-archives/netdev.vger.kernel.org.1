Return-Path: <netdev+bounces-54955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9DF809011
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 19:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1F31C209ED
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFFD4B131;
	Thu,  7 Dec 2023 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SKcFclhT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D92210E7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 10:37:48 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77f3b4394fdso48256285a.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701974267; x=1702579067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=al8pLf1i2K3vW5QKeT3fYcCSCcUQxhzzcB4t0NAml9Y=;
        b=SKcFclhTJ2VdbK7aWehytEPETIk12t+WkDwniczn8Fn/rsH3HwUq7HVw9Q4eOY7tOP
         gyyVioP0UmHMFlSyLq+hsAyzD3/0TOPXukuDPEzND68xHuE6ZCEU6WJ5rb4jFcrTMKev
         LBmG1nZu0hW9Lyv2A6SIiei3r02wWK40VPxIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974267; x=1702579067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=al8pLf1i2K3vW5QKeT3fYcCSCcUQxhzzcB4t0NAml9Y=;
        b=ANWtT6YJ623IWAFFeQao2T7Y6uXveRoGO8nVy+zEc4DIjwD3R6a3tH92aFElWIqPXR
         Xy/XsdXaKVThmQo3K9n8DP3okiheDSqfJxPK4EUqgwrtgqFZ+dj29MjnehOiJoLFhBGS
         HfsE94q7YtHIzi5ESM0qMbDKX4MfhHInOfuh46Rr8tPRroN3mqt1WKdAXT+mnbGznRBE
         1XFBNNCubBSMf0HV2/1Swr+UpaAarntCUgrM0oPVwhyt1ctKXBTEplnLS5cHot3NrS/4
         xKWhj44L9srPfkiXh+H2+hajUeyseHb9OlNVZQ08qqgmMHGOvXug1aTOL4lPbeK8lCe0
         6S3Q==
X-Gm-Message-State: AOJu0Yzwp9Nj1/yND4hockwRiDEthfApV+zKB7vEAZVqdYKaowHB2VI/
	cVssISZd34yB+zjABzewuv0FrA==
X-Google-Smtp-Source: AGHT+IEENN9QGjrujgMo6+T217n+Z391k0/HjRzFfGT/Y79Pbi3Rta69sB4OnvBqmHVVfLZsN9TCUg==
X-Received: by 2002:a05:620a:858:b0:77e:fba3:58bf with SMTP id u24-20020a05620a085800b0077efba358bfmr1321465qku.80.1701974267493;
        Thu, 07 Dec 2023 10:37:47 -0800 (PST)
Received: from C02YVCJELVCG.dhcp.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id bk40-20020a05620a1a2800b0077da8c0936asm93148qkb.107.2023.12.07.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:37:47 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 7 Dec 2023 13:37:40 -0500
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: Re: [PATCH net v2 2/4] bnxt_en: Fix skb recycling logic in
 bnxt_deliver_skb()
Message-ID: <ZXIQ9FCfUV1Fvr_A@C02YVCJELVCG.dhcp.broadcom.net>
References: <20231207000551.138584-1-michael.chan@broadcom.com>
 <20231207000551.138584-3-michael.chan@broadcom.com>
 <20231207102144.6634a108@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207102144.6634a108@kernel.org>

On Thu, Dec 07, 2023 at 10:21:44AM -0800, Jakub Kicinski wrote:
> On Wed,  6 Dec 2023 16:05:49 -0800 Michael Chan wrote:
> > Receive SKBs can go through the VF-rep path or the normal path.
> > skb_mark_for_recycle() is only called for the normal path.  Fix it
> > to do it for both paths to fix possible stalled page pool shutdown
> > errors.
> 
> This patch is probably fine, but since I'm complaining -
> IMHO it may be better to mark the skbs right after they
> are allocated. Catching all "exit points" seems very error
> prone...

That's a good suggestion.  To take it a step further...what about a
third arg (bool) to build_skb that would automatically call
skb_mark_for_recycle if the new 3rd arg was true?  I don't love the
extra arg, but that would avoid duplicating the need to call
skb_mark_for_recycle for all drivers that use the page pool for all
data.


