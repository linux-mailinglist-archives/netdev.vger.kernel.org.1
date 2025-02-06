Return-Path: <netdev+bounces-163564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E2A2AB57
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B556C1889E54
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6935A1EDA22;
	Thu,  6 Feb 2025 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haJp1Btf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD31EDA1D
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852152; cv=none; b=i/Bx0sIdQqMHA819eUY4L91U1Ncay1sTdh0yE8e0lXzSTvV890gk4KQJ7Uqth7evCpZpiPnnn9OpduPXbsCUJnuoPp8kidmRdE7zeRSPfvlhg69LS1M5YU9idFEMLyHPnkdzAlWwJpxepMVwfzzXfrDapxX6trGy5sw17RU3ti4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852152; c=relaxed/simple;
	bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u7alIIPjQdSoDsdHGylIItupaKM1OFOMyHiG7xxXONIFm6f71wIftSgTzjTWncSyN+EzhFKlTnY6oBWBaAO6BZp5a9S99pwSCjcWWqIxfW06/3KFDkltrHzhj8dqVxzVUfqIjUCs0bXvywiYRzssi3KbMrMsGKQ0wN2KQNvCmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=haJp1Btf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738852149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
	b=haJp1BtfttwiP/CxoVaUjhRTSWmwKFW6y5zRxNoX8vH4SIDkUIja+zXddLkPfbZPT3rNHS
	dhLezed/pwLpaZfIx9CihrtrKIfdt1kA5zsVLU4NPzFxQaGG3XKCjStLMwKU+XpBAl9jwp
	psW8kq5VyW3rJFB7ONCy2CqXWZug7b4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-raFCqsu5Pmi3VT6AIAOIRw-1; Thu, 06 Feb 2025 09:29:06 -0500
X-MC-Unique: raFCqsu5Pmi3VT6AIAOIRw-1
X-Mimecast-MFC-AGG-ID: raFCqsu5Pmi3VT6AIAOIRw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dbe50b2d0so341243f8f.2
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852145; x=1739456945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/9TL5ICETEExIkNfaa1Q8SGkOy65DRMnd4GpUkgGHY=;
        b=fNFio4eaRtKDjklweTFnuwR2RIa/3bMoW7YAOlQIyZX+QIA9uT8hwHB6zKPTuM7/81
         t84oSzqKi3+bogyUZT7JLA6z+fhfSym44nHOUSTqjCFqI+un+d0jM4TsJR2hGYh0iXwM
         cFgd+w5bnCTciSaK2x5GR4vsy/e7ucWDtWWzhsD6ea9V/FNoUCaIQ3wRkDJ9lW7V/5j5
         MQgyz1/3SOhLe8SXMj26GTZkc/oRUWwNwA5OvejrIXQ/VqcvQTw5PcjT4ZB0Nqsa4zaK
         9Y9lfTQbxE1Db+h/WSr1Gvb6gZ51nhBjLz1MMIe2AsHCTDk669blPTCvVFtZlDMj3y1j
         Pkig==
X-Forwarded-Encrypted: i=1; AJvYcCWHln/XqEnfxRD7AHx+KKNK3EQHR/ezJZUcRCXPUfaQ49pRX2gB0ZPwA7IIQbryTL70zYBcqRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuSFNocAZSH6yCUqQG2dQ1EuuDpR89awH5lcI+42AB8QMfFgm
	5TA0PMtk1Ax+OQQ0tB+GlBmdfUKlOFVecp0FjqZr7fovelkubpgJd83f+e9YtXwYaZJfMnZsgyD
	1invvU7i1pCDUtO5BZl1o9OIlVWNt8sWjXWYot2BoX3t+DKtERaAcBQ==
X-Gm-Gg: ASbGncv5uICPLS7kUmI+0VJu/x0d8FU1Kr7RKBO5+s4E4yW1PV+uSMjD0CKbcDwHP/l
	znc/EyWNUcSpy6B3VJ6m6ugGbKBF5v/9RV5kV6pXcAEqEAlyC6wfHz/eY22sjxUlr3RucADOjRZ
	dfkMwjuIOglIRPkxxlzgIYtKPcbBU673gffPKrJwUYB7pj+CXo39HjoJhLE3Oqqv9HjfCDvHCBP
	POFoqS1dAcvpPAzcqB6sp8JFHrHoPRg5tOTV/YpAT5YjPW5uyJRAvO6smYwXU8dwFKAbgCF8UWY
	1yCsWHyodY5fxauSuqgo6ttC25GZrntJLNA=
X-Received: by 2002:a05:6000:108e:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38db48abdd1mr4886388f8f.21.1738852145336;
        Thu, 06 Feb 2025 06:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/IoDleFwxPd6VvG8B+XIzOXHnma2uT1uK+zVdE4JBcY5pP5LJxIbY10dmEvpunLfzdoCT2w==
X-Received: by 2002:a05:6000:108e:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38db48abdd1mr4886367f8f.21.1738852145009;
        Thu, 06 Feb 2025 06:29:05 -0800 (PST)
Received: from [192.168.88.253] (146-241-41-201.dyn.eolo.it. [146.241.41.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d94db77sm56725485e9.15.2025.02.06.06.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2025 06:29:04 -0800 (PST)
Message-ID: <efd3dee8-5a2d-4928-ba1d-ddccb2f29fbe@redhat.com>
Date: Thu, 6 Feb 2025 15:29:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v7 1/2] netlink: support dumping IPv4 multicast
 addresses
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>,
 linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20250204091918.2652604-1-yuyanghuang@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250204091918.2652604-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 10:19 AM, Yuyang Huang wrote:
> diff --git a/include/linux/igmp_internal.h b/include/linux/igmp_internal.h
> new file mode 100644
> index 000000000000..0a1bcc8ec8e1
> --- /dev/null
> +++ b/include/linux/igmp_internal.h

I did not undertand you intended to place the new header under the
'include' directory. I still have a preference for a really private
header that would under 'net/ipv4/' (IMHO the possible future divergence
of inet_fill_args and inet6_fill_args is not very relevant) but it's not
a deal breaker.

/P


