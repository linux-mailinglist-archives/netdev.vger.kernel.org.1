Return-Path: <netdev+bounces-192720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A70BAC0E2A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453EF17C8EA
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDC628B516;
	Thu, 22 May 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wwIpVO7N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F528A1E3
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924403; cv=none; b=XX8ON97nYFC76RyhRiJVbrMlapivLC79acgb4nDRMCZmOmWPxn1Q1dzy2HGFz/ZoxG3LxDoXIFCFOspst0UUP7SZkVgSQyR2PwhLcXUijMFDSKnbwel+sDt4C+EPRQXNrjlEhZwtpSxzivJTwSxT2uvBYfAzSOlMet055mxG0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924403; c=relaxed/simple;
	bh=d2piDM9GLrAmeIJYrQZLumyLSebO3DlpWMd24K6c/iA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+FCda+1rYeAI9SVAZa+v7r4xJS3pHLD7gcaPbDh/L3SLiiIx/Qo25rZzjo5peIoKyP8ggojIZ6afAZTw554oC78FHhpUlyhwZYrSCFTrlhHh+8nD9v1/+4A7wNNLAKCgA61+WUMdYzogsZ6rqyWDA6hVKq7JQrvsvqmLGHgAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wwIpVO7N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a361b8a664so6278547f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1747924400; x=1748529200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dn1YShOA4dwqM9SaRXAzNfUfuOGOWEGpi5JTM9fUV5I=;
        b=wwIpVO7NYwFNpXlfWcI6DggmsVX9elTmGn9aIjdRwGcKUdNqFMog6pVq/oirKAHRcQ
         PYU30U8ieXi0omXBDsvbghA2Yig68WYku0vS4mkqZEdMRep0eye2vsOV24vb8WT+DYDr
         DBz11rRA1IZf68e4gtQo2Moefil7QOzj8mDNWEmijAFIKMUoYBv4UF1eaVooax2udESj
         55m/FX3OoVWbOtut7lgD8nmcLZj58xHyiwTWGOmcZbxHJ9HyJBcwm8SzguW7q2P6Fgq2
         IjSemuNL3mTGahTkXl2bkqVk8DMbYIrVx09u+b25kbU9KTQ/rhzfD+oTxHgHV90FNM+Q
         nSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747924400; x=1748529200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn1YShOA4dwqM9SaRXAzNfUfuOGOWEGpi5JTM9fUV5I=;
        b=RqEttwXsx4AWPX6XrlpePhip7zd3z6S82T+73wtRbTViNqMhtmHQn84RGcyhnVn5Zv
         C3zbPSNF2qC0MQmls9B0eDYHtz1C5l7S3HJvMAk65cSB1xStuAmYN8HyWS5CBcHdktom
         44k7ubj7bIYlADAdWCS7BF8rvPYn+9GeAvqDi0/ECDPNFsx856inv/U/afP9zL/EUm50
         bMyoEWNKls8UBcE0836kQhgfk4t9tq4IpmAfAJ4FP509WhLo3FejHp3dT24fChr5a1sK
         rzNhIY5A/CN9PB45caleBVEEpnfpbDWKW0oAjhOx/8HPfTvwLcbmrfSTxxglDfjSDyDs
         nxQA==
X-Forwarded-Encrypted: i=1; AJvYcCVEJfBi/GrzNbF8lqMatyr4P1VxI9cfT08ih5cjdH2eaQLdLPQ5XJvlk0k4pAQkPHHvRM4oUeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJnuAjf717d/ej0HVIoIF72P+aM59pfTBFBlWwVM5lMy4PZlAF
	czfiNmv5nmogWFLA+cwuRSty/UOyP4L5u+zssrlDxFCI7Hpd82bAw+URNXDNllv4NzQ=
X-Gm-Gg: ASbGnctaKU7NZNgzJFUmFaHwxdXFWL/BY1PPDzCv1AgSttuySlBzUC3mDOlcVTbf2jc
	9GR+nj2hqN9lYgh3sbJhRlliBFgRdjfyKKIZMaF1zOZJT9JP3o2415YbTAByfWROdOrQoznPPyg
	266mNQqfC35UWiKpMq/cgxoELLAsKgY7T60EuzxClp01mPuAbzTdqLcd+jxbu5OFcbCcn/eJCE6
	0d6bzIQQWF6gRPAEoUtUHRaPDIEzqWLju7T3PSRKMSZe7Dn2i9G71Fp1eBB3mFXyuPtSNmfQCqP
	5T/OKh0uNoWeN31DxRHye8/ZSHHmcqdsyMnUmVQC5/LD4KFhoHm+Czz8BojmMKCbF0dz8HXcfx0
	UThI=
X-Google-Smtp-Source: AGHT+IG0YqyMywpuUtAztd+lO6++AlGqehzLyXmmHccSsSj9ee8zH4u/jAiIgqS7pyQrU/DPZSt+JQ==
X-Received: by 2002:a05:6000:2405:b0:3a3:556e:1bc8 with SMTP id ffacd0b85a97d-3a35c847cdemr21846792f8f.46.1747924399597;
        Thu, 22 May 2025 07:33:19 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d26esm23653390f8f.13.2025.05.22.07.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:33:19 -0700 (PDT)
Date: Thu, 22 May 2025 16:33:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	"Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through
 devlink
Message-ID: <76xnvcmdkohjxui2e2g7xe4b4iaxiork5e3k4n6inniut63a5s@6voxc4okdixd>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
 <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
 <11eaa373bb894946bc693d9a1e112ca5@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11eaa373bb894946bc693d9a1e112ca5@amazon.com>

Thu, May 22, 2025 at 04:22:21PM +0200, darinzon@amazon.com wrote:
>> [...]
>> 
>> 
>> >+enum ena_devlink_param_id {
>> >+      ENA_DEVLINK_PARAM_ID_BASE =
>> DEVLINK_PARAM_GENERIC_ID_MAX,
>> >+      ENA_DEVLINK_PARAM_ID_PHC_ENABLE,
>> 
>> What exactly is driver/vendor specific about this? Sounds quite generic to
>> me.
>
>Can you please clarify the question?
>If you refer to the need of ENA_DEVLINK_PARAM_ID_PHC_ENABLE, it was discussed as part of patchset v8 in https://lore.kernel.org/netdev/20250304190504.3743-6-darinzon@amazon.com/
>More specifically in https://lore.kernel.org/netdev/55f9df6241d052a91dfde950af04c70969ea28b2.camel@infradead.org/
>

Could you please read "Generic configuration parameters" section of
Documentation/networking/devlink/devlink-params.rst? Perhaps that would
help. So basically my question is, why your new param can't go in that
list?

