Return-Path: <netdev+bounces-201380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0831AE93D0
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 03:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23EB1C27C9D
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 01:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137601B4F0F;
	Thu, 26 Jun 2025 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSwLnspQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DD71494A9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750902148; cv=none; b=d5e3cfw0bxWc47i2eNXA6cSGjQnYfyrsO0rahUZEk2hOj1+2rknTIdaO9oPU2CiOP2g7l12hn8g775Zr+O2RjZ8ajWvJEUTmaqGrAMg0D6qh64GXxizlkMY4GKdqjO4ZgBtGVk67V0Z6Z0lr71X0/owOUdTFt3rdYmB59TZjyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750902148; c=relaxed/simple;
	bh=bLnNswPcdJVhKHtyGWztPgng1YI/yEryH3w5ziqNK6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FRZ79twGb9j3oI/SjzwBd8c4zW1acfFRDTYdnrwIskl0T2cG7Duaf25Pf75hQiSVR3Z8glx88n6L9hxasDPN8ydHe4Owk3yfneXXl5h9nYs9kZSQBShP21rcsSYihzPmKFbb7Kl2G25Weq49HSEZDoZj5AZ32OuQjxxW+YvRuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSwLnspQ; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dddc17e4e4so1956805ab.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 18:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750902146; x=1751506946; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAUHBPi/LW/N7cCiZz3Tu2w2XTOPN/tJjmEUSscoZZc=;
        b=hSwLnspQuWOKsHONYECB/2tSsBEBgczRuuW0ZS0lPO7pQKyesVx51jYMaKaOE2q6ux
         9hg1tPCTYcol3gHkMt4ZXNCvERgt7Xh/idwsMe8T9fp4oFEOtE3yMkaJX5YwM0C5ChzY
         wDQJHM20tD5O5rRd6RZeJo6vqq3lvdrFTjTfcZx5BjArE7MA7Y0XwdLk9REwvGCu7fkH
         nNRPyKPheThGqwK6EEh3HsYmP2Oizebzg/Z17TRYStfvel/nUQoPg76NqCBiNfoWt52r
         NVwZHFmcQXh99oTJv8N8eQ7KecY4C2iN4tvlq05ZRg2XMErmu8lZjXyLGGQ5iSOrQikz
         eEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750902146; x=1751506946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAUHBPi/LW/N7cCiZz3Tu2w2XTOPN/tJjmEUSscoZZc=;
        b=gxhQo9r6caSqFQwW/l12lD3kcFHcLeEBZFpQ9EN2fTfq3XLpu9vagVT5ghJS5x3v/S
         WlkDtvVeg6h3jqubuadd8b8oOSUQDDsK4nS1WI//u3q9FVI+tGKmIgc2c13C8KDfll2M
         yUEFhXBwqCiSu3uQ649Z1CFzlJEtXy8q61yqfxzzUUlpXSeaXBrAPi5PP3wauKF11ivg
         YV2lgPpcm/eLsvqSDFO34QJcRPt19YmUcSbiGqmkNuZ9mmi09A7tmYnYhpsz+2xbYuy/
         JiI7+RwNibVPFLhqiek3zMFnOlGxeAg+Mq/t/OJimR4G0FRJnzaGKp1ly7x6g4GoG/8N
         /IlQ==
X-Gm-Message-State: AOJu0YxW13LQ1z8lJQ1gD7wvgwaEkAZxtMLZqKPX5e7cRpjZPPG0uN5i
	sMIr5VaMAsEXwo8jXWazArSYFaCVbZ3mGRwsKAjXPbrk9qqa3pVdtsA/
X-Gm-Gg: ASbGncswr+Xq1SOHL0Z1XfY0iNRG8HtS/ohAmNKnilSj/bNCDafA/pxib1416F9dcZB
	usjMqWtHoGXO1WHe50OfWqwzzkIJMnHJpEeefZ507AcE1TXpElVCQzC/6vOlFmUj2SS1mcwTkQx
	LKFDtYESXZCHpkkrU/P/lQlnJ0DCTA0L78NW6fjA3DDROSyLTD3D4HT0eWL2ylL8kJDh0UH+z+s
	nE5i/2ywODmgIqDpn7d6bIDymckgm73VO7PQwELtEbRRPSB5hjSNjBjwX2Sxz54PQbZ+YA1b38e
	vAbvY4rZC1Yv5PzbIxjm4/01PpavM7gVYz4gX4lO7gcUhYLlc668HA/RP2Eugs+KENOfRDWt1KL
	ZFgZHrg4dHSS9wVMUpp6FMTt8KI1+PkYA1Q3S5fJVFcB46Bn0
X-Google-Smtp-Source: AGHT+IHH1ET26pgBVnNUyAf7TF2O6xPJQ4RSEaqfKSH+cGywwAfRWAfo40TVb+z6x9m4Tiicb4LRzQ==
X-Received: by 2002:a05:6e02:3091:b0:3dc:857c:c61a with SMTP id e9e14a558f8ab-3df329ed357mr73216645ab.17.1750902145654;
        Wed, 25 Jun 2025 18:42:25 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:78d1:e7c4:6f5f:cc96? ([2601:282:1e02:1040:78d1:e7c4:6f5f:cc96])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-5019deee54fsm2978937173.34.2025.06.25.18.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 18:42:25 -0700 (PDT)
Message-ID: <da9eb3d8-a2ce-4042-ac2f-9d0a0cb84fbe@gmail.com>
Date: Wed, 25 Jun 2025 19:42:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH iproute2-next] devlink: Add support for 'tc-bw'
 attribute in devlink-rate
Content-Language: en-US
To: Mark Bloch <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Carolina Jubran <cjubran@nvidia.com>
References: <20250625182545.86994-1-mbloch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20250625182545.86994-1-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/25/25 12:25 PM, Mark Bloch wrote:
> 
> I've incldued the header file changes in this patch for ease of use.

uapi updates should be a separate patch.


