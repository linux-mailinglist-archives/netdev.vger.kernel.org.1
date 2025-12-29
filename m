Return-Path: <netdev+bounces-246240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565ECE7400
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 16:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37751300C140
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B95329396;
	Mon, 29 Dec 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePfAWcQJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSQ+6qi8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DC30F55C
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023400; cv=none; b=QP+DvEf5wlTdpAfrNhYlApJxUYZ+2LQEbVj3NbnesOwhSSxjSVe8YJX9RZnZRdbi/xMgYV5vDZZUp5AQP6Ws550vQcPROy+c6tVU3HbdHLVqHcxBH87TpH3d4NKOfdxSugf8yzm9elaqIiXos4zVibCTjnJWpX2hKXUeqJccjKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023400; c=relaxed/simple;
	bh=yMKiGiJJxuLS8kqQNhnesIoImT5Lp/V/bhJzTXfWqEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHq6o4i3NY4chC+pBqOK61aO4ueDDz1nWhe4KWdqSEg/YzgrQBXhxAu/k5HsgZC77Iyd2hlETKrx71PbRDQ1siA6djXtrHVQbFpehPpYYDfDEEA3ybW0iIVdpwNuEB7VPp3uJaG80+UQVTFPHlj8q5JfKHCHTXUrtd2vDXF3lT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePfAWcQJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSQ+6qi8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767023398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj18/my6uVxomwZqbIiVl/L5IVwA7o6fFfXKTmyhCxY=;
	b=ePfAWcQJyVh8Ho0ga28+6C3dZ6wref0GOVwMeBi2vieUhkQ6ZbzM70RE6KvpB1N7T94whb
	l0UnW1ZtFtr7G70YXgtNIsSlTE0DRlL80oMNVbNv6Q7MhtfU1CgNSwMgtB7sHXHePzrwLl
	DnzgT1AsfFefSzfbhjBlGxFr4ytfDY8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-nFg2k2UkMHu0qieqYViSWA-1; Mon, 29 Dec 2025 10:49:55 -0500
X-MC-Unique: nFg2k2UkMHu0qieqYViSWA-1
X-Mimecast-MFC-AGG-ID: nFg2k2UkMHu0qieqYViSWA_1767023394
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso125173695e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767023394; x=1767628194; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yj18/my6uVxomwZqbIiVl/L5IVwA7o6fFfXKTmyhCxY=;
        b=SSQ+6qi8H5MvJXIhA+oW8qVOe2FmOTE/ImY7zO4uSrtsiBfgRH2Cs3RWYHkgacxbNX
         DqVuuc69gzWYiEqVRQEIalwR0tt2xMT58n3GTe7pD5JMZJ2dCdh5B0yjIclK/5M+/1Sj
         GMfF9qwrSGI1DRLKW9mcIr/R4T7AoJyqTsHe//kdY2PWwXuo13OMGfIABMfwup0kzg4s
         7QsqXnGPMiKQkxWC2a6P/HDwDNCWYn/97uG4k1IgwQ8VIJXjSAjK/aJyG8KIggiF88Ej
         gv+m4Kr3Yq4DQdmKwUEMQ5pLS8kP95UJ8EnuTPCnQy7Y+1Tx9eyXkStubyd2ODSsc+az
         VQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767023394; x=1767628194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yj18/my6uVxomwZqbIiVl/L5IVwA7o6fFfXKTmyhCxY=;
        b=FNyQP/ofwVJCaIMDJZj5YyNemS9Eyp99yhuYMDEYSAoeHDLf6dv3iXKdsfaWrG6f5C
         W4Huq5YWV+x8ChebynU20lzhpnHvCOoVqWhk3F5XGsH71b2iGx0PAdvDnPNQnH4isXsF
         cxWuVoxlTJvSbtG+E7Qi3mbsOQX2ZwRqdFLoa8GZr/K9Eb8r62xsvyriP+VUW1+jGp4A
         R/4SjnAK+U6Ed7YPXo8gm8RVDeWGcoaWW1e/QbQyPp97ZMIeDpcrAuNkMIxw/Eu7Rh+U
         xcR35bW1VwxHJsyB4iHQWOXeEZ52cQMjPwiD7NFsK3vpKK0Crblf7p9GVUxY46ZWjM3e
         aKPw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ30wdmg6k2P9D0vl1nMdnBkk6W6ccKwS8W7XpPKcETxXZM9iJ+6GRwgAvrOfIiZk2On2En/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0gleIHMav3hcEieCK4fJOlnQvRa14RdhDIagvyAIMEIggUOGG
	69rIdeMmQVKDIRkinX3FN11k1E26FFF+4u8YY9WyOEfDFNvy/HKuJnGiHLScmIGNaJYt/ez/azd
	R6ZCYkuHpITFZ28EVn9byFkFZUFXMos9t6bHeSSEOGnNsvycv5XvX0Hn27g==
X-Gm-Gg: AY/fxX4hO4oGRNgS7DlW3FuO/ONnhrrxKTH3uruoo/DYWwE3JAyr4rWzj0Pnm1gkfMN
	L1Bv8anVjFSh5mMb2wftKLQeKYIIkLMMZzgaPDdW1ztCRpS5Rn8t7R6+RNy4pd4CbpxRMCPy5G5
	EwAXkkNDHYoEzIxd1THF4/ifwfpQETAm1/hq8Rb1GUbanmDHlE7bFOsxqdZTWFH7b8Fp4zfqslE
	MD+n9aVBfiFpjqTQ/jLhMqKP6U/PSmHNRWHfUA3iDTl79jd+Rbld67ZYabLA7mxMlm8TCrkt3us
	Fnn7hgDbLGCVkgpAakGGTYjr1BDUe+FPbzIbvkDt7TYdl6ZfOXmpQ84GYanY43bElAwDdKrN4Vm
	+FCp5Z2hBFpGE8g==
X-Received: by 2002:a05:600c:a016:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-47d19594e57mr357663675e9.24.1767023394452;
        Mon, 29 Dec 2025 07:49:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfTpCjqyJy84kW7i8l3Woyc3392zb+r8k2GWD+lM0HDOgiT7tTmjdSbD1zCvF1lHTrSsDJRg==
X-Received: by 2002:a05:600c:a016:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-47d19594e57mr357663405e9.24.1767023394077;
        Mon, 29 Dec 2025 07:49:54 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a210e7sm232426785e9.3.2025.12.29.07.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 07:49:53 -0800 (PST)
Message-ID: <75205c09-7adb-4770-b551-de3c4f7a2ab4@redhat.com>
Date: Mon, 29 Dec 2025 16:49:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
To: Anshumali Gaur <agaur@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya
 <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Christina Jacob <cjacob@marvell.com>
References: <20251219062226.524844-1-agaur@marvell.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251219062226.524844-1-agaur@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/25 7:22 AM, Anshumali Gaur wrote:
> This patch ensures that the RX ring size (rx_pending) is not
> set below the permitted length. This avoids UBSAN
> shift-out-of-bounds errors when users passes small or zero
> ring sizes via ethtool -G.
> 
> Fixes: d45d8979840d ("octeontx2-pf: Add basic ethtool support")
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> Change-Id: I6de6770dbc0dd952725ccd71ce521f801bc7b15b

Please strip the above tag in future submissions.

Thanks,

Paolo


