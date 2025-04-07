Return-Path: <netdev+bounces-179837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E240A7EB15
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB394421BF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788426A1AF;
	Mon,  7 Apr 2025 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncetSlKo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A526A0E4;
	Mon,  7 Apr 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049735; cv=none; b=IGMEw8z9E6wvLBiZVtVemc7PKwb6hUwyd3qkx0uNciSSbOMYpoWbDSGzyLUBhv9e9Ly1+bBINqwQW4SEeDwKrHNUgRAjMAMSmjjrGj7VK6v2m78zOs6O/Jw0EiNVVG5d0xwFgqtQy0OLzxSh+fXAULbkzZ7Z+p0IiXeY3uyrC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049735; c=relaxed/simple;
	bh=0DGW2GtE/wbTFy6zNvPW1hLpO8FevOBzZbFxsl4xPjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cb/F3/4ST82D2Dyjt7BWZGJoWlD6BOKA7E8qBus0EDJREsg9e7IQrd3W4LzNXIfqWpP0oz6ViESAa45BHmKMXWjM7TliwLke/466x/GADmv4WSRaBTHqyRAtM+4Ha5dwzO0JvgRZK+mfTWo7vFKEPpbVpvsus1pguHQH7pAu4Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncetSlKo; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-6ff07872097so42695127b3.3;
        Mon, 07 Apr 2025 11:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049732; x=1744654532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W+y7j0d94ESJiQTrZdM7W+yXTrmSLOAkjPT20fXhISA=;
        b=ncetSlKoAU6LPDlx3wYCW5Fe02RWX7yhDHhFRsnDBSb3lhPuVoY0p3zSoUUN0RdM18
         QQO2/omYiPD4cNFNmtiF+3PBXXD4n4s7xPkAzpL/RUdgPVSxcu4SWiR5nZDnIsh61AGE
         XjENQ868zn+mfS+jXYCM+s13SJCvk5s4nnfUajK8Tcq0qAGxOpdQRoY/njXrnOW3MfgT
         ndA/iaZJYcdn5kY6obNyyXd7DzEGstpkMLdi4OcxxHrh5xUTSQmnYeLyOPpG7x2wbDLF
         1F8JKno9jm7zgIoVATu1EPDiFHqQnw14SaPEkb9YurmbTksQkA8kRSG1jQv1JmtyAKm+
         0LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049732; x=1744654532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W+y7j0d94ESJiQTrZdM7W+yXTrmSLOAkjPT20fXhISA=;
        b=qZhwTGwl743jab2YK4sbsODgmo6R2po/RoGSaUfG7ZTElqVcDBuy+EeRkmE3RBc7iM
         fQaUfkWiPvPxkoRiZwu7Chd/e7qICyy76pZff0ONC34P6/E8PO3doD+4EswyVnf5zqwA
         h6YYEMUaFMr4iGZjLxE2P/MQLkngRO/SODxuDOfVqmyBBlpX7nsakVGhXAxBn4oHyHYf
         fs6YYk5Oze9wrVMWe+ZCKnmgrKLM7/8bopVeuyLqqlVlMOdh9GJAoIBKxSsD9h2L0xJ7
         3toFaYH29cKsEDxcloNc7fa5kayqcotGyDgvptgq99ULKWTXMCIVzLXF+tnUFxDN+uaf
         Hzsw==
X-Forwarded-Encrypted: i=1; AJvYcCXmn5TiM5Jp8D8jXYiMDFB57uWHs3En1FTDxoUadWKx/m3cpxqpi0tUfFLLRZEVGW+2vaG67mtYPgE3J0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxuBHQoqcsjLc45rYm7r5yCn3VbYfJA88Bf7HOs9jrJNW1+Zk
	/FI3m+1gWNYj6B9MdQL7qhQE9dLAUHmrK5512jbyS1soMhgrk+Bb
X-Gm-Gg: ASbGncvnY3RsSBgouO0ALOJqan3RydLZ9Lnmjjj8L0+L2IkaWDPStuset/sJqwrdDl6
	5dO/IvxDLr9+3sUziqFgb1Fu6VpWF3oW7Q14nZ6YLgUrCwkqicWRs5Nl+LX8h9Ex423kokn44X5
	EEl7tBpT4yAds9hdSMIb7E7YmtEETdpjNOiehDzZ4rDX8IKaeAAw3lMqDKe1tTKrO/hPs/EBBLW
	kUq04xBev2UVN10VouXib95wcqxJ9WRV5caZ/Urri/s41ZMFS+L4vvT9mLK3VT1elFAZ7RkCwrb
	7S5o6RIX9In/83Vcn3xcXtaEMmZ4o8FRB0Yo2LoOoQbV26+l/1SNxV0qso3tfYP+QhhcDhmRwXH
	PLQ==
X-Google-Smtp-Source: AGHT+IF2uFzNJUA+HFuJSyLd8tdsQvhlIigDoTzGOxEQtLXp81AorTYnwP7QptlT3IUmR4B0WPnQ9w==
X-Received: by 2002:a05:690c:2506:b0:6fb:9389:3cde with SMTP id 00721157ae682-703e14f8287mr237326997b3.3.1744049732407;
        Mon, 07 Apr 2025 11:15:32 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1fa6f24sm26502997b3.98.2025.04.07.11.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 11:15:32 -0700 (PDT)
Message-ID: <af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
Date: Mon, 7 Apr 2025 14:15:31 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
To: Jakub Kicinski <kuba@kernel.org>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
 <20250407102941.4331a41e@kernel.org>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <20250407102941.4331a41e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 1:29 PM, Jakub Kicinski wrote:
> On Fri, 4 Apr 2025 17:29:32 -0400 Joseph Huang wrote:
>> Currently the bridge does not provide real-time feedback to user space
>> on whether or not an attempt to offload an mdb entry was successful.
>>
>> This patch set adds support to notify user space about failed offload
>> attempts, and is controlled by a new knob mdb_offload_fail_notification.
>>
>> A break-down of the patches in the series:
>>
>> Patch 1 adds offload failed flag to indicate that the offload attempt
>> has failed. The flag is reflected in netlink mdb entry flags.
>>
>> Patch 2 adds the new bridge bool option mdb_offload_fail_notification.
>>
>> Patch 3 notifies user space when the result is known, controlled by
>> mdb_offload_fail_notification setting.
> 
> You submitted this during the merge window, when the net-next tree
> was closed. See:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
> Could you repost so that the series will be re-enqueued?
> 
> Thanks!

Sure thing!

A couple of questions:

- Should the re-post be v3 (no change) or v4 (bump)?
- Do I re-post after 6.15 is released? Around what time frame (so that I 
can set a reminder)?

Thanks,
Joseph

