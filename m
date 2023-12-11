Return-Path: <netdev+bounces-56133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 926BA80DF3C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13329B20E27
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22FA5645D;
	Mon, 11 Dec 2023 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE0eBOH6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDA3107
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:05:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d069b1d127so30092475ad.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 15:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335907; x=1702940707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I02V6rvIajVGAEjcHPw3lZTI3OGilJIL4N4mGflA1E0=;
        b=lE0eBOH66PAnV5vxi4B2k3sQMJ6yc7tj89ZrVA+b1uaKultXjk2O2yAQCEektVkni9
         iXON+A/VyjzEceUKGdHVVfjeBL0VMUiWfBoZEz2zmeRgM6MN9W4/GP88BxhAreSQsFjN
         yTE/4jSbx0Py79IcXR3yt4sU9iBJvsbXOpf4Fy7MGrsoSxCU3l3XFo4gyAm4gB79iW9u
         kcymzjPcIwtTH8QX+phrcw/aT3vq4w7k4pykI0hrHbOdNHIPF6L0FWcH/AW6U28pz0zb
         mDzeI244YaNMiMKxL3scDLX7cm2mRnWpLlaeU5UyHB88qVDLAVrmdNUuDkC2gXb++qKA
         dWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335907; x=1702940707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I02V6rvIajVGAEjcHPw3lZTI3OGilJIL4N4mGflA1E0=;
        b=LP5eAbv4TsW+BM+SzvxQIevBBtjEAfllndTDEgm+chkl4e/jG8jHAFTLpoEiK/iUDM
         ATb0mj5c//WugYxg+AGH+iujHnagK94ay24XyDvsKC6z8HlhSM7dvX6nStEcaze6wayT
         lISBpsz0Hab4l+qOVatkCzQISEpKT8gYbgRGgF9fwQ1YJNpu/5PU9WeqlywT1WnSqkjb
         059JjyUczGRpfFNt/7laQTj232tgB66JCLwByt5FzkS+5/m1CbyaX/nOFXxAk13BWiXM
         RvbbXiK8QU8cBvLZcbRl68+5GcWUcXNQrvPgZMg+fzZoryhzg8dI+h5k9pwd7Yw9ygp1
         OUVg==
X-Gm-Message-State: AOJu0Ywz4apC5Q2fFQMw4qBDXFPmiUZRVTFq/FhqG+x54x85SKwXARKD
	ODFf8PawDDv3FlQ/SrhvZkA=
X-Google-Smtp-Source: AGHT+IGqrPiicLKQ3GfGU5iPIVuntH6uM6Q3yEuepvYs9ewKkCWM7QBvWRZzG8MXX7BER2q3LmaUNw==
X-Received: by 2002:a17:902:704c:b0:1d0:6ffd:f222 with SMTP id h12-20020a170902704c00b001d06ffdf222mr2717974plt.120.1702335906590;
        Mon, 11 Dec 2023 15:05:06 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n2-20020a170902d2c200b001cfcf3dd317sm7224203plc.61.2023.12.11.15.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 15:05:05 -0800 (PST)
Message-ID: <164b6a7b-f52e-4ea9-8d3a-bf51d9f7cbe7@gmail.com>
Date: Mon, 11 Dec 2023 15:05:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 8/8] selftests: forwarding: ethtool_rmon: Add
 histogram counter test
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-9-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-9-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> Validate the operation of rx and tx histogram counters, if supported
> by the interface, by sending batches of packets targeted for each
> bucket.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


