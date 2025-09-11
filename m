Return-Path: <netdev+bounces-222309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5010B53D5C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6461B4883A1
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5062D8DAA;
	Thu, 11 Sep 2025 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZWATZEC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A32C2364
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624244; cv=none; b=oo7v/6PdyCU1ESF4eq71bv1wDIJ/Txf8Cw1a96RVYPDJiVeOEbNcbyPGOkFT6fjYtGbYyOTq8K59T71v6cwpb/hwxZRCazQNfXlK1UkyFpgS6+wJ2P8pNcNACFjpjkeDt4mNQsGC0xR8jFCR+YAW0asDMrrZJSoJAonUsu1JW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624244; c=relaxed/simple;
	bh=2F54eBISNoz/weMvGCXTYmYj3Yuhqu/Tzj8vj3qhN2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+fR0Q/EztRGgTSBFfTYAPtRCvzdlf1G5phoYLK8bKhlhQ89No69owsFl/mbepVdAXWMomawvbOX/d49zpLaT5779wr2BW11ODY1sLEeW5oxDH2CvdKgweF7E3jdqo0HbM6SgaDPziMLh2a5afLA6nJ5dIv/BX9pwkknNskprDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZWATZEC; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-88c3361f16bso95580139f.0
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757624242; x=1758229042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ANM7Pz1lKIaQALJ2EhQx8VCi5TMEwW+Jj+1yu883UU=;
        b=SZWATZECLrQZ1qf0t61Ox5xKIFxoRNVv4eN+yZ+zKIJKSHtHEr+Da90Lzc7GPskQol
         IceJ2EwsnnfYNfjFRuci5i4aHkXCBFDb4mDl4hCA3vh3drzhhcFmJ5sOyyX94hVin6hB
         0M5Yxep3zm+y9Y29kYnCVjFv7KSFiE9mDisxDl0wju5nzXvfhabd1hUhqr29B5XnF1I+
         Kkx3lP4bNI5Kc6Tnh/RymUVda6obpaQIS1DNwA3LGGSNqqC4QUpkNKOzERUCbgxZZDoH
         nj22FAmeP27Erb9TkBkYWwIlmLvlsEIFm4ZCY6VhnmWebumWToy5gX/tnOO4HMz3godZ
         H61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757624242; x=1758229042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ANM7Pz1lKIaQALJ2EhQx8VCi5TMEwW+Jj+1yu883UU=;
        b=DvoCKMzZmi+FWzRJgHlQM9ok4xU70leFEcmof80cDVzbWRbr+C7UqzpWzsvbPNSZFL
         GbETN+LUuDyWwKVMP0Xavt8PHbBNUHo6VzOyVFqFyG8jp+aDV0Bn9+nqXhczkmUChVny
         vQ7/qboBYqPODc+YU9N+Hq3GXFPhmRyWOkM3qPHlKy7jeiDVy759TaNFp2GzDrCz6BNL
         iZj58k+W8Gs9EimrE9gGqSF7rGFzjDch4jMRKzS1pwmN7imsj63zsjkwaB2lwgS+roB6
         dDElgUgTSIVoeBMJ78zUeNqomvcIq54pSyftN/F08Uf+nsPwwqukv1Z14mNDoktjmhxN
         bGkw==
X-Gm-Message-State: AOJu0YzCdHTWE6ClaHPx96uQFE9D20fLeUbQ3pSvGNDN6jLnWCFNHw3c
	5V+/NY5JsIv1o6DpewLDP8njggDS+UOSFW9FKWlSJXpTC85/EQGz09Ox
X-Gm-Gg: ASbGncsAbY5MLnkMQ/9IqotcIFoBIwjza++dDM2AeWdtSWfYanYpUTQzWLjBXkF0BjC
	Jneo0FT1NGtv8vzTE1yTFnZcBNO8DxicsYAcnazUR72GpyfRSYD+vtqxqAS3l1SUaoUOBBAu3FZ
	nZkOsvuX4/+XxE6rzNobimqb4Xqo2MsnrTKkcheyarASViPS2+278Vdd8jBgH7d4jLNmzEWWyd3
	hKHWV4P9drrziRrdGWwp/a/ZOlQcg26fwxfQe38dLAbjuoa0KslWap5qAJCFq01DUXR1gQdTE7f
	uxknLZyQsBnDMp0nF395o0f4jaKpExqKROrV22ItodDWDM/MtvuzS7OWXG0rO/p+XYbwnggjDRq
	iZFVAtsHEM2EOVArMcxR0d666Sr7Kh5GhL+fC5TQ6q/aWgjo5ubBzgIc6ClYGHfmQvTL1+IOIaP
	u0eHyPj0YW4j2dG+/WW2I=
X-Google-Smtp-Source: AGHT+IEYGQUXVILZ1X1fbd3yEhNFQf7W7xYGsiFi00tsygyKRjSZRSixUmZmCkjEPxGN9pIakb/XJg==
X-Received: by 2002:a05:6602:6401:b0:887:321e:a52a with SMTP id ca18e2360f4ac-89034dcf458mr108921539f.16.1757624242033;
        Thu, 11 Sep 2025 13:57:22 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:d54b:8f4c:6b97:7d20? ([2601:282:1e02:1040:d54b:8f4c:6b97:7d20])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2a7db2f1sm96823439f.0.2025.09.11.13.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 13:57:20 -0700 (PDT)
Message-ID: <90c0b0e1-8e39-4026-9643-63bfd9c3dc4b@gmail.com>
Date: Thu, 11 Sep 2025 14:57:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/2] scripts: Add uapi header import script
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20250909-feature_uapi_import-v1-0-50269539ff8a@bootlin.com>
 <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250909-feature_uapi_import-v1-1-50269539ff8a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 7:21 AM, Kory Maincent wrote:
> Add a script to automate importing Linux UAPI headers from kernel source.
> The script handles dependency resolution and creates a commit with proper
> attribution, similar to the ethtool project approach.
> 
> Usage:
>     $ LINUX_GIT="$LINUX_PATH" iproute2-import-uapi [commit]
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  scripts/iproute2-import-uapi | 67 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Stephen and I have scripts for this, but this one is fairly easy to use,
so applied.


