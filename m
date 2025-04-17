Return-Path: <netdev+bounces-183710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426CA919AC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43AF516BA16
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B522FDE4;
	Thu, 17 Apr 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYj/IJ4R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1025233141
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744886895; cv=none; b=p2Ttf90S0G7CkzpvAbZekWthGsXEEXhy+03rP8cmO45e7fREEniI/GRxraqj8w1xPKSYw8NIcdcLsRas5BnqcZQfeH5c+c/+P5X51TV6IBcf4JB7Nhem9ZH+w1+XbAgXwuuVzfQmFhc69dPxiFZJn7YNfLM2dcy9pKISY37ayHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744886895; c=relaxed/simple;
	bh=XhGacwTcE6A+IWJQpQyCMN16TVH3Z6owtk1R8JSA4+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kqJu5YxaUuB9eoPs6IXWBPOUgm0g1FTbgHHO6hxg5boOGX2wCrCProuMC7q0wtnJirHhSPrN8UeD+L4XNKgKg7LlT4WZd8of87TLaC62DFpTDgl5BUSkasD0dCxMKOwehfCXivZTm6mmyNO06n6MkQw6I5thbPRiLWyolsmc/ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYj/IJ4R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744886893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OudEsC2htuXU3a1BRgDOXrN8cqmum79c1G5XjX0b0Ts=;
	b=CYj/IJ4RRldEBDBj1ag7dWJmTek3U/cRZlHlufqdrMALS1eHyQnNNvuFvVfrRX26Zo3DWY
	r0etfLnaxRq+pV8mDDyXMJINocfR006S+Zuki1ietbPTpampz201MIXfC2kfTjG+0+TUG8
	Ozmk8oPjZ32B+HZhfwb6KamXaN4/caU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-0FOoV0CrOgGhnIMxQmLvcg-1; Thu, 17 Apr 2025 06:48:11 -0400
X-MC-Unique: 0FOoV0CrOgGhnIMxQmLvcg-1
X-Mimecast-MFC-AGG-ID: 0FOoV0CrOgGhnIMxQmLvcg_1744886891
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ece036a581so12502726d6.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744886891; x=1745491691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OudEsC2htuXU3a1BRgDOXrN8cqmum79c1G5XjX0b0Ts=;
        b=pntIVLGFDfR0movxfv5r4dNpZ/D24GKjmRFKwNp5LIatHhn7uIrM95w/3mO8L0MK1S
         2511cc8hcne+b6aazB022exukTuw7+KivMep/UAf2hXMBYoj74KARwSVJBK/fYYlxC7o
         4AEz+qPRMVN0ImjJHgzR6UnyL1N1XHshkkPok2ydC/5cLtsi53IaREVwBlcwmVfmLqIN
         8qI2rlBTFaUf8hb3CiKtRoa2d2IjSkXiAKcDvE5HBNz1lpZC35AvVsOHdOcdrk3wW68W
         51NxG20JEta7w7s+kAUs0t7etH+j42cNhan2ReR9An0H+aE2C905SG3+L4z4ZuGu+Ajl
         8L+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1rQRhz6lN2JdoGNaS1rWAIo3syDMyZWbq/N/Ht0W1qh96VQAUnyBVrm7sIGd4571Bo4dLk7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjV+9ZzCpJP2M1ZqJGR89IkhoBG0qC12ABFzSlBCJu+QgSd4A
	OAGvl9O2uwXHVjoKpDrsGGrAjYlQzqsk5Ys5xkSPg2z8q7I5V245SQHm3eDX3Phc5zANo0+cHoA
	6Co37F3OjFYEmXNA+5vT4ARFpMpgUkweA6y4aco0foQynBGGL9+eurw==
X-Gm-Gg: ASbGnctVJUevhvwxVfrxIRnZV1lOEY4cJlqy5aF+Wu7AIlqdLTEAvhqz+pTUQquvaVw
	7Nxf8Kj33AauXEr8eZa0/GYgUu6TFMSRbvhIHoKF4hAOcPj55JYo1cBcVMxxW27I1ssT4gUFU9q
	vzxcCI6jFij+CkibCTGYB+IlfX53uhV7KPIjkc58qU1amPD4hEDzii3y6qbUUDWBR+iXkWqRK/s
	ZfOyG9piggc5+9zy5kh/TaZ7bhwTG5pkQTDc2bOSLDtbuiDDPfefpMxvxIliA9Tehiq97XYPSHB
	sMr584h3PptLdsmC1zpHATqy+QsD8Ss0ZKug6jaUcQ==
X-Received: by 2002:a05:6214:3008:b0:6e8:fa72:be49 with SMTP id 6a1803df08f44-6f2b2f421b9mr65124526d6.12.1744886891276;
        Thu, 17 Apr 2025 03:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRD2S2lNf87+n5j2F4wP6+GtOIfe7KgdYGkxqrRR5TEwTDQjpW1zM73oytFXas9ITp16LLpQ==
X-Received: by 2002:a05:6214:3008:b0:6e8:fa72:be49 with SMTP id 6a1803df08f44-6f2b2f421b9mr65124216d6.12.1744886890999;
        Thu, 17 Apr 2025 03:48:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de982274sm125717616d6.64.2025.04.17.03.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 03:48:10 -0700 (PDT)
Message-ID: <8bfc6c5f-4bfc-4df4-ac52-b96d902a9d7f@redhat.com>
Date: Thu, 17 Apr 2025 12:48:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v26 00/23] Introducing OpenVPN Data Channel
 Offload
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250415-b4-ovpn-v26-0-577f6097b964@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 1:17 PM, Antonio Quartulli wrote:
> Notable changes since v25:
> * removed netdev notifier (was only used for our own devices)
> * added .dellink implementation to address what was previously
>   done in notifier
> * removed .ndo_open and moved netif_carrier_off() call to .ndo_init
> * fixed author in MODULE_AUTHOR()
> * properly indented checks in ovpn.yaml
> * switched from TSTATS to DSTATS
> * removed obsolete comment in ovpn_socket_new()
> * removed unrelated hunk in ovpn_socket_new()
> 
> The latest code can also be found at:
> 
> https://github.com/OpenVPN/ovpn-net-next

I think it's finally time to merge this. Thanks Anotonio for your
patience and persistence and thank you Sabrina for the huge review effort.

/P


