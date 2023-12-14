Return-Path: <netdev+bounces-57142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067281240E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25B91C21489
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1180D;
	Thu, 14 Dec 2023 00:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjUWqod/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90648A3
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:45:41 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so1000722766b.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702514740; x=1703119540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsCpSdJ+cezQKITwB2sRH/SoiYOVwlKBRMvbzUnjpZc=;
        b=OjUWqod/+4ex60ObIykSoq4anSmBgDd7ntDDjhWPg/obpus8dF8uyi+M8RIB/AOZ8a
         Szm0qQFmzYe1C0kK1Q74BYT8+S2E3tgIzUF4TUM9928HlfO057KKl9GKi2pjE7y6dn4Z
         gFaJ+q5dA0bFMAI47F6RAbSPN1uBMc9gA7WNNZbXJQguIsTYjxpDujZkSQc9LJgKDwm5
         tiTkdNJHr+m/828UiTvOBfAJx7LCeDwCbxBHgLBg5fLLlvuR8wYnNaeOBn6YXozsDC3a
         NNgzL2RdFwPhvUKEtNf8fKf+nWBHprL/hiWKMNJeYBqlfhSIPFTK6CPZebDlgSHPe9hy
         D+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702514740; x=1703119540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsCpSdJ+cezQKITwB2sRH/SoiYOVwlKBRMvbzUnjpZc=;
        b=upDXSTf12TrTy6LrbTRo6Ecv01dvGN3UsHHvrwvCVqSMbtJpm7n0PmAbYjgsrLZuxm
         /dcrQCJj7sTtlyp9srb/3TPz8SROYjm1cZMzoGNzovB/F03YdI/9IcK6Mo3NYibhkPN5
         UBtnEAdW+D3C1nmXMdUB/0Mq8E5KYY8rurxqzKKfD5inPvTChmM6oeOE5pp1cTslXack
         +6AFIGLMqjpb+ZTsekOz6D4tJdSEHyA0Ivh/7fZIjG5M0BrG8Wt0mzRe38Ufb0Tt0kvk
         vmYvnJAQSv/XBZB1CvIRuBq2tpMvEsdAPM6Ux1eJsXJ1JmcKV2CVcEhJMQtli42Z+Ip/
         fvRg==
X-Gm-Message-State: AOJu0Yz1Y9F4spx7A27DCmh/Cnd2aiG13BUI4Y4rEgzbfprUF0YO8yxS
	UeA4EMn7t/nTcgzdwg9WVz0=
X-Google-Smtp-Source: AGHT+IHvrD7uXi/2BT8jhjvHBPyoHMCKtNXoveaF0F2Aw/2hQ0XlPTc8WcQeeojFuf80dMclCPXpfA==
X-Received: by 2002:a17:907:7f10:b0:a04:e6f8:3d6c with SMTP id qf16-20020a1709077f1000b00a04e6f83d6cmr6043111ejc.48.1702514739593;
        Wed, 13 Dec 2023 16:45:39 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906d00900b009c5c5c2c5a4sm8567676ejy.219.2023.12.13.16.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:45:39 -0800 (PST)
Date: Thu, 14 Dec 2023 02:45:37 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH v3 net-next 2/8] net: dsa: mv88e6xxx: Create API to read
 a single stat counter
Message-ID: <20231214004537.wx7wexdug7syekgz@skbuf>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-3-tobias@waldekranz.com>

On Mon, Dec 11, 2023 at 11:33:40PM +0100, Tobias Waldekranz wrote:
> This change contains no functional change. We simply push the hardware
> specific stats logic to a function reading a single counter, rather
> than the whole set.
> 
> This is a preparatory change for the upcoming standard ethtool
> statistics support (i.e. "eth-mac", "eth-ctrl" etc.).
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

You left this function prototype as returning int rather than size_t.

static int mv88e6xxx_stats_get_stats(struct mv88e6xxx_chip *chip, int port,
				     uint64_t *data)

