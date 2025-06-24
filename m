Return-Path: <netdev+bounces-200630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F664AE6575
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E63177E76
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31962989B4;
	Tue, 24 Jun 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="MVy5FOR4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E6D298CB0
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769474; cv=none; b=PhHOqwlx1yRCGbAApCCcYtr8yWZI9ZYmo59ukAOW9WLNH5T50j929z66sirayM4n94qGB3Y8IJ1rE/7ZkhTuUInNEF54eBjo++yhkx6TlyOPgb3E6wiP14jDy13omv+6tAmGA8wkqipqO4B2g+K4uY2RDUt3008ze4/HTli0yqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769474; c=relaxed/simple;
	bh=jkT6mfH4uJfqYwc9rvEhzIqTWfZ6q1x0/wb+MeCmz0w=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ntwwcgYxXG6GZ6IknKVeNqL5HmhFdKoCJFv7bFHEI9OJy2CAVu57/aAS66d+t06bc8aXfh2qXP0GKBculdkc5q4FaOEbX6YMkhHrTzYDB5+N2c2D6U946WIFETXcqR3QleG1QFcX6q8zI2O+NZZjjPVUZuJBdrOq77JkQIv3S7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=MVy5FOR4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-607b59b447bso7949937a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1750769471; x=1751374271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R8j08AxL8zlJOltWi63caQrmz1cFgG6v1E8nzEyRGUo=;
        b=MVy5FOR4pHJiIGCZa9Eix15tvZdH1JjvJUR/wWjnsmbfX8HSYQGen7+KGg4NK5AIjN
         9EKRujwSDBTBa4grQeFUvxr9JELV6Tos13K74Zl677p5QLsqHCu1qgIGcA6evI1ZbVLv
         U7AvKU4e9ZLsUEaE9yFchujiUdIG0WAy9Xx9QEToAS0OcRRRcRgmnJ3s/R5xZJr87SAI
         sqsWF3AhF/BrCNL95mTozzBDDHwJfnBkhO745MBW4x2w2ezK45cwEXNyaNErpnahuG2N
         N5j9CsmtYPbWZ1sbG55QrO3fE3ZyHd9fzEIOwk/z+GofoSpXKPbES5fMZE4LsZIr/Z32
         WTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750769471; x=1751374271;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8j08AxL8zlJOltWi63caQrmz1cFgG6v1E8nzEyRGUo=;
        b=FS/9EF8nVH6uR1fRyalLjUHoo46iMXkUcsI/iXZ34HQLRYbJMJJFOnWrx+po6tHKh7
         ewCumiAMv8dZYUUqkdmey9JuqR8I8iAhmUNd4e0PdeRWbyHjZIcQE9q+xhExjjaAOC2o
         Y9O4Qr63QrqiqNriT7lWyTOX30PoUC0pIeKACZlC4k5WWyvWCvDRwsU/UhKqag3atdU5
         +irsDYBQwJJDmAGORxFqaTbsjAzv1eb5TC4SlGNj6GlYkJnwmS+TGT1YHstzNGllx2mp
         vpP5K75/DcWbUo7dILxk7rXJsYSB7/6KhoI9HBLxn74T/TCrdceWw2CRVVRHscdjXnev
         lGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVs8TJslAj/kMzWLBM+2qa4Xn4d8U2ScFmz3qin4wMzAwGDJLNUMidBNLAzG+EsBApXlANFAIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUnkYIKQM4N5v1G4goEHeSeP8Z4dr3B5SZYCWidASH0DM1L8WF
	+5yyNNwwedq/sk19oos9efEsTt66B8WmaIOn4YpnBG9sc+4Imc8q7qFWCZdHg/HHtQ==
X-Gm-Gg: ASbGncsbF1/jiHO161HMw8gvrM6SJlXjg+BZi21WxCm3xcReXKEsYUAe5pdLK8e8VxS
	hpNO8GKB7OcSnorcLNETv9ZpelkTs+4BamU+pAOwDecX4Kln2SC9+OMxBTSWzuM/L5l/wdk/ZKf
	VHE5qV8hEvAebbWrhfjwavt8kdz/9gq8g50t50VLnU2Mnq/zUehGcAnUsSF5YuUo+k4bnj6Lfk7
	V8mf2QKNu/9hTI/pCkUO6eiKlqCKz9ebc70oTmb4t85T54RXb/ErmiycCKbHrEETHVrDC66akRp
	052/F6+LZ9hWJ7OjlWpetjFNeXnx0sPXrZsShCChgu4pWAo95JEJqMWlFLfo27lO
X-Google-Smtp-Source: AGHT+IGW7ORN9PWnJJjgW+cZ6TowqoJ7MmszMOr+J2FbInVvd3xL3L9vT7lM4Pbi6amiUEIgd5D6GA==
X-Received: by 2002:a05:6402:4415:b0:607:f31f:26de with SMTP id 4fb4d7f45d1cf-60a1ccad8femr13331076a12.1.1750769470446;
        Tue, 24 Jun 2025 05:51:10 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1ae7basm1003980a12.25.2025.06.24.05.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:51:10 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <cca5cdd3-79b3-483d-9967-8a134dd23219@jacekk.info>
Date: Tue, 24 Jun 2025 14:51:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] e1000e: ignore factory-default checksum value on
 TGP platform
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fe064a2c-31d6-4671-ba30-198d121782d0@jacekk.info>
 <b7856437-2c74-4e01-affa-3bbc57ce6c51@jacekk.info>
 <20250624095313.GB8266@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250624095313.GB8266@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +	if (hw->mac.type == e1000_pch_tgp && checksum == (u16)NVM_SUM_FACTORY_DEFAULT) {
> 
> I see that a similar cast is applied to NVM_SUM. But why?
> If it's not necessary then I would advocate dropping it.

It's like that since the beginning of git history, tracing back to e1000:

$ git show 1da177e4c3f4:drivers/net/e1000/e1000_hw.c | grep -A 1 EEPROM_SUM
     if(checksum == (uint16_t) EEPROM_SUM)
         return E1000_SUCCESS;
(...)


I'd really prefer to keep it as-is here for a moment, since similar 
constructs are not only here, and then clean them up separately.

Examples instances from drivers/net/ethernet/intel:

e1000/e1000_ethtool.c:  if ((checksum != (u16)EEPROM_SUM) && !(*data))
e1000/e1000_hw.c:       if (checksum == (u16)EEPROM_SUM)
e1000e/ethtool.c:       if ((checksum != (u16)NVM_SUM) && !(*data))
igb/e1000_82575.c:      if (checksum != (u16) NVM_SUM) {
igb/e1000_nvm.c:        if (checksum != (u16) NVM_SUM) {
igc/igc_nvm.c:  if (checksum != (u16)NVM_SUM) {

-- 
Best regards,
   Jacek Kowalski


