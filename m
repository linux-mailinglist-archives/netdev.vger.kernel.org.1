Return-Path: <netdev+bounces-125589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7B96DCA1
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381CD1F22685
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C193199938;
	Thu,  5 Sep 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et8hE3DS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCD745F4;
	Thu,  5 Sep 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547958; cv=none; b=dFA5iUJxKK5r8HIK2Y+SnuIayXMzk6PByqbhKFz1qjXvHifw9FXIgIOiO5QbiBcl1YL44S3CFLmrArEORXIku1oLHUywSzuwOJvnXr35s7oDZWm1cY3bC9qNIEnFBQw9W0WoAm38ciLGQ17rT81KbzQhwiWySt7gM+HNX4ehBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547958; c=relaxed/simple;
	bh=M6CSeiJ7opw+fpxk2DZWmDkszDb8GF/2XZJzVPGTeUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djKu9XSOoUDUKgTGWF0MlLL/RpMKgKadWjztRT5F9Qr6VG29YYqq20aS5ObezX9hrRmf7pda0BgA9J02Kxpsa/NW1MBnmkYFr8E1KJOyhg7v81jPcGs+RUQnTG4ttpu7Fe3aGhI5sa4x90rUABCQ1BXjeOgwC38idRSq7lVQikM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et8hE3DS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c26a701185so144354a12.1;
        Thu, 05 Sep 2024 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725547954; x=1726152754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2g54gJr7dWkd7+x+HAWM4aabzzENjq1zl97emHDcyg0=;
        b=Et8hE3DSnFT4FWAaPJoVoSQGP+mGFJZam8u3BNpmS9IMzZgUZEjvwtmOzNpJ3Zz/nJ
         WoJ4fdmXT5DnzE32eRGfWpbAzeOABuz5qS0ZykgftzAWLRf1QF1ecj2p5s7Fxne3womJ
         8JuCNclo2z0anmKO7mvZzDpL8+mlx+NJu8/L+/nhMaMAJF8Gi7PwWss9Z98gSzrAYGQJ
         Nz5w5ZlMwoLJpsmNXuO8gJGCm/JHZHLMD+wLiFtQUrhPxx9sAl09v9M4DLeXdClnByc5
         coTIYBLOoFQSsnCY51usn+aqfD+enAkf425oUY0sfvtsculpiEd5NG1W7RwL7aGg3/0d
         CuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725547954; x=1726152754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2g54gJr7dWkd7+x+HAWM4aabzzENjq1zl97emHDcyg0=;
        b=as2Qw1gmMU2WIFGWtAGGded1VKJLUYy6AmBTs4FmxmQJUCvdE4s7EN1C2KFOrQH5oN
         rLOCI4o93kLjJ6K6aLpA+Rnz2SL20QQPjqIaOpICaZR7UAqh3gmRP5okYZu6r13lffso
         hzW8jhJV4c+0Gj96MPWbs/fVECOSETl+55qdNRVHEvtZTI4vwqjvERrvXYuETSwwtP1o
         TEHSUgx/zj7yAqld2APt+WuJlLy0DWDSih4yqrcJE/EY08/jm9ytfiSi6PE/bJYZTDXh
         dTOsPm+snmDmBYFV01yxY0V+sB81UBGQBvrGAhpXAPlQMfZ7fugNRbmQv3CAEiDeTXli
         VzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCB+l4cOpgWGbKJ19HNZuScYY7Z31yZOBC2An5OCon+bUdhZudgTByOYFTuoiJ28tAbum54AlmJcCQBBE=@vger.kernel.org, AJvYcCW6WCnUObmZAQzWah3ivgcE4R3G6ymOo0CLTjQjxmoBlabsLIAIjmVGPiLcs4HOCmXsGxQ+GaPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGhxszqDOrW39M2dv06kBfEc1SKcZTRfrA/iZyrNJzWlZedJD
	id2Tdgcrxz/jtM8gFrCBWpG2TGX0zVIMTD1yjKxZ+Cdyivf79hQ8
X-Google-Smtp-Source: AGHT+IEgYP9p1NEcW+b7LA2SeKoblfl5T6ojFMNpFfgzLYg4QChmu3Sjk2pZhSKhLGsFCf2S5rRTOQ==
X-Received: by 2002:a05:6402:1ecb:b0:5c2:67da:9742 with SMTP id 4fb4d7f45d1cf-5c267da9903mr5148025a12.4.1725547953042;
        Thu, 05 Sep 2024 07:52:33 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc551234sm1303917a12.36.2024.09.05.07.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 07:52:32 -0700 (PDT)
Date: Thu, 5 Sep 2024 17:52:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com
Subject: Re: [PATCH net-next v8 6/7] net: stmmac: support fp parameter of
 tc-taprio
Message-ID: <20240905145228.raglhbpikfxolgrw@skbuf>
References: <cover.1725518135.git.0x1207@gmail.com>
 <cover.1725518135.git.0x1207@gmail.com>
 <55067bfa505933731cbd018d19213b89126321e3.1725518136.git.0x1207@gmail.com>
 <55067bfa505933731cbd018d19213b89126321e3.1725518136.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55067bfa505933731cbd018d19213b89126321e3.1725518136.git.0x1207@gmail.com>
 <55067bfa505933731cbd018d19213b89126321e3.1725518136.git.0x1207@gmail.com>

On Thu, Sep 05, 2024 at 03:02:27PM +0800, Furong Xu wrote:
> tc-taprio can select whether traffic classes are express or preemptible.
> 
> 0) tc qdisc add dev eth1 parent root handle 100 taprio \
>         num_tc 4 \
>         map 0 1 2 3 2 2 2 2 2 2 2 2 2 2 2 3 \
>         queues 1@0 1@1 1@2 1@3 \
>         base-time 1000000000 \
>         sched-entry S 03 10000000 \
>         sched-entry S 0e 10000000 \
>         flags 0x2 fp P E E E
> 
> 1) After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 17837,
>             "MACMergeHoldCount": 18639
>         }
>     } ]
> 
> Remote device:
> [ {
>         "ifname": "end1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 17189,
>             "MACMergeFragCountRx": 17837,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

