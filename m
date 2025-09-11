Return-Path: <netdev+bounces-222022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C59B52BFA
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1244817C31F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD32E283A;
	Thu, 11 Sep 2025 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9agry21"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33162580E4
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579985; cv=none; b=pydt+HMeE6q3M0cKprS2V3+xqHai2mv+ql1UeHRd5ipYU85mh2aIFRoAqc4kz4FO16um6i+lbimxDzhqXBIMG+reWGugDeKTylKwrFuR3ywY4YqVLAGAxXhBBB9Bp7pBx+D/EcdjPCofEqhafZ72MtUThCYGWMdVhHwj4msgZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579985; c=relaxed/simple;
	bh=5fLQKzUBk6RyhfaKfLwu7XTN1/mvrV+n4NQwIOYScvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=halPv0Qg6h7lmXKwY+VuQiePJOEeO5AkjGieCys6wNYenwJCNMnk2fDYxwhhIs0ZLuwMLeJ0nnRnj1WcSCQZJDw5P+bga+d+J0VFOTaAZXUOqBR+Pk6nMEOYnazyL6y+y/UBydHmeya0ifgWR08rpgH6I14tD8WzzPmvXHZqc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9agry21; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757579982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ltet1DEkl+6/W/mA/mh0wSx+0fdNt6OLAsr0v/vtsws=;
	b=D9agry21rsLb5H6MMgLr/H8o6H6rTaAPFYnCKJNHOFpCuSfd4X0x6zVRA2SlM1dH0EzhQ3
	ekjmXC3B8Qbi8Tz+8KGcxs4nsuLha8GpqUdwwk5Kb4Wtj3hc0Jor0KHSrs6oK9qpXH3SGw
	WgFJEI7UUY0yjZa7cPnTF6W1rRj9ikI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-FeEWFSl8NouHcdLWEaKw2g-1; Thu, 11 Sep 2025 04:39:41 -0400
X-MC-Unique: FeEWFSl8NouHcdLWEaKw2g-1
X-Mimecast-MFC-AGG-ID: FeEWFSl8NouHcdLWEaKw2g_1757579980
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45cb604427fso2751655e9.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579980; x=1758184780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltet1DEkl+6/W/mA/mh0wSx+0fdNt6OLAsr0v/vtsws=;
        b=ASa1SjFx0kIcDa9Lb8ozNkwcPT9Bo+bnJ/Q4pOcNWSRMXWvqYjlrySzX4X7l8NSgWV
         9KC86uNTnEixHZY0yPGslM2w68l5uv1JLIOOVmkQB3Tp4hzgRBwgWcv6HnPvdn36leQy
         tyj7WSYWfelGyTmeozJs1wXMVxCtI0pWTFJj8DacUAp2mpomfbQzpeRh1Gbz0JWjvLGj
         Xz3Lc0mDqaLY18RIR5SUBw+wXyqEY0l8j2ztBOzfWM2g3pA+bPgT32wcZmSmVFhloi8U
         +xB84Th8nYDRphnsLR5vUhqM7LnKOxhz2jhZslPEVKtIGL7IJwdoUzjq7ZQjK4/VW50I
         pUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9zjpyRZvhCfVXcx+pRuomZaECMt7dR5Nikg7LJ2GjSn0qd/w3gEKJHDWWSyMcvZ6EG3gVmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfNn7eBFOfZaMmvIs9DA3/9pXiJtHz3u+wHW3QPihIfD1A3RQb
	qGZRjFaWHyBPiKtaVRy3usBXDKYI3dO0ByywjiHZCxxFhpm7BT9lI2wYZ1/RBbAqM9dnzlW+K+U
	1Gq2OWAiLC/nDSHkuNUTT6MrYSfHU9bmIzaKj+DALzzocdNKPYeG6qhEcEQ==
X-Gm-Gg: ASbGnct23Ua3frgs41uaDDV17mQg7HnRr4oTGESiiuLSTO9XrlCNM1pjhLd27reWKjq
	2pDP6scMzaIYlZF08Ba/wxWpP5KZpRfrf/Le3sus5NeL3zLb8GGvnYQ1IxaXBJ9JWMS2j4jErAY
	bViPv3gW1wwjbos6UkiYtEoTbrV+p6c7N3tEP2SDhxBgz7Jw5iPwa5DfQevkWf0pQTp/w90CFsO
	JwZ0Sc5g/MDQeWQSwN9RGfu9jR2t+Lr2XVoq/6x/eT6VjN5YGI1v+URfGjuGOrpGc418S9B2r8u
	1wLQBeXRJ+VHN7Id4VvnaXOQmEeLTyyWjOiaXYTwhVA=
X-Received: by 2002:a05:6000:1ace:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-3e7610b8754mr1087216f8f.39.1757579980044;
        Thu, 11 Sep 2025 01:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKiL19RoayeKzPbOlZN/BIKP343mirP4w1v2R1K9mBR+ow5apdnT52wvVT2ZVXAZtbgB7Mhw==
X-Received: by 2002:a05:6000:1ace:b0:3e7:610b:85f6 with SMTP id ffacd0b85a97d-3e7610b8754mr1087200f8f.39.1757579979640;
        Thu, 11 Sep 2025 01:39:39 -0700 (PDT)
Received: from [192.168.0.115] ([216.128.11.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760776badsm1589169f8f.5.2025.09.11.01.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:39:38 -0700 (PDT)
Message-ID: <8f52c5b8-bd8a-44b8-812c-4f30d50f63ff@redhat.com>
Date: Thu, 11 Sep 2025 10:39:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/4] ethtool: add FEC bins
 histogramm report
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
References: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>
 <20250910221111.1527502-2-vadim.fedorenko@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250910221111.1527502-2-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/25 12:11 AM, Vadim Fedorenko wrote:
> IEEE 802.3ck-2022 defines counters for FEC bins and 802.3df-2024
> clarifies it a bit further. Implement reporting interface through as
> addition to FEC stats available in ethtool.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Not really a review, but this is apparently causing self tests failures:

https://netdev-3.bots.linux.dev/vmksft-net-drv-dbg/results/292661/5-stats-py/stdout

and ynl build errors:

https://netdev.bots.linux.dev/static/nipa/1001130/ynl/stderr

/P


