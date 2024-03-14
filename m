Return-Path: <netdev+bounces-79894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A386D87BEDF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5839A1F211E6
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 14:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82876FE1B;
	Thu, 14 Mar 2024 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Cka4dZvk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A676FE0E
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426542; cv=none; b=FCdanbmHW1cj+0P1Dy9Lf2RuSLadrS9120a+qtq48aMtbefl1xb8RICAeBS9R7+eJh1cx+Wvop26Km2fcwR21sf0yA5b2Aq31jvaUaIOFF+dogRGUNccL/C5Jr4Zxpd7nYRPBWY960Qar+tCQQ5sKCkIYsQoMrTg7l16928izEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426542; c=relaxed/simple;
	bh=9Yv6Aree4TG/ivjuMPtM10mosWJhqVqwsm8asGrUx7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nnv9kvFHEaKc0vv/ly0rzV6RHAMoYIi+ss7d97D097PMQnf8iZaHOauHoY19q0ygUNLOIqcylBEsN9a43QhaqEuVFrUkU5IbAi4flFXGtAJRq0y7JeR/Yr43vQj7KYUsbwcn3nXUSPiUCwBc5x/aDq0VZAI4HGfrK1vYjyWrfko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Cka4dZvk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33e899ce9e3so835329f8f.1
        for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 07:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1710426539; x=1711031339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QaLBzQ1QlX9T6SNKbYv018MPK7efX+zNaeNSfeAFsRg=;
        b=Cka4dZvkQh9MSw/I9eMz3XTQpqeCNHCuAPV4Z920gBFVDTpHfzrlFtnL9240A6R4Wn
         +IYaMZBmPs947+amJWqyO4dkdsvWuRL/+10agK6a10+k1mJlQW81IR2/gOwFdDwqcOsv
         vVtjcse/MwpWuNRBsQzTHTpoue56GqigRG+6NMaasNG2oePONitGGKqFH21ZLxW7jngj
         Ls/Ctq/0FVQRQJlQtAfwU4SMTY9qJGboDzFJPFlWxgMLKQ+y/5iS/wfRHKSWXGKyDYlE
         Gj54UJN3dLHLc6FJYFAamiyCtq2+deiBxmvI/aauNbFhkJrsGT4KDlbEcGNO/Sl3oMAV
         01WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426539; x=1711031339;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaLBzQ1QlX9T6SNKbYv018MPK7efX+zNaeNSfeAFsRg=;
        b=e67N0BGcIn8syEnhKzZbchCQbtplfi0XX4A9FqmVrZp0gQc01QsQUhTM8LoLpsPTWw
         wm7DO7xwnTOsrjNA8TfDIfbvhfL5vXNOvbBLncdiR/nNHMfsIgT58/kQKsa8HGulsuZz
         q33124r6RYFzgS50klt71ec4KNwI82jEMifRlnMEKdMyQkSFere/9c4rWKv5LzpsEOXk
         K0YVCRfj92q0NfweQT//X3BneRxpt9vmN+agVU1pbd58QjN3GlmeUhaZ0nlhYTs0EP48
         JlXS/syrUXIXX3g8grr6dPY7tjv8hzmfe3n/fFbpQHDl5DnzqhrlTWLctqeBuC0sZBJ3
         wtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzH72TGTDJRDmLC2G9EqRWzKC7mGqJF+8h4YM0NzdPCqcuy8ri9HIO4SExVpOYZJKge9o/JdrXQVfPHM+Ik205UJcjg4p7
X-Gm-Message-State: AOJu0Yycf59uNg2qf9IZ2/L3vMFOusHd6EcroDhkfZ/+jRaQiWQYoYur
	akY+cpFtk/HRjuKB4KLH2zEWH7ZOfafR18e76FR3QuP77XDv2czgextvWeywNa4f72thB/NdSg1
	w
X-Google-Smtp-Source: AGHT+IGapC8rJGxR78+FGsPud9Wo12tGBxdSlptoC76XzXA+vgDLYvJcs6XWEnAVRB1eNxcMDKdSNA==
X-Received: by 2002:a5d:4083:0:b0:33d:f56e:f867 with SMTP id o3-20020a5d4083000000b0033df56ef867mr1243384wrp.67.1710426538946;
        Thu, 14 Mar 2024 07:28:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:85f4:5691:4a6:3f3? ([2a01:e0a:b41:c160:85f4:5691:4a6:3f3])
        by smtp.gmail.com with ESMTPSA id je2-20020a05600c1f8200b004133072017csm5862174wmb.42.2024.03.14.07.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:28:58 -0700 (PDT)
Message-ID: <c2b3203b-fcc7-452f-88d8-1ef826509915@6wind.com>
Date: Thu, 14 Mar 2024 15:28:57 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [devel-ipsec] [PATCH ipsec-next v4] xfrm: Add Direction to the SA
 in or out
Content-Language: en-US
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: devel@linux-ipsec.org, netdev@vger.kernel.org
References: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 13/03/2024 à 22:04, Antony Antony via Devel a écrit :
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.

If I correctly understand the commit, the direction is ignored if there is no
offload configured, ie an output SA could be used in input. Am I right?

If yes:
 1/ it would be nice to state it explicitly in the commit log.
 2/ it is confusing for users not using offload.

Regards,
Nicolas

> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>

