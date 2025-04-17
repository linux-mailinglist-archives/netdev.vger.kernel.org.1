Return-Path: <netdev+bounces-183682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF9A9186A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E853AFB05
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF72288CC;
	Thu, 17 Apr 2025 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kLy8IggA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1341B4235
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883744; cv=none; b=uOBzThQ/JbwvIdKPoIr859DmGVtf50yIHnrx39kVpz1beNyEmGV6C1ziGMp+DQVFA7ARb59+DmelKaTNn3eskuWaH68iY7IYx+C2PP/qESVZQRZKacaBnMPpFLp2BzenFuUOTac6ZI13z2NGCI0Ko27ObxzLRnsWHZvIniYTUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883744; c=relaxed/simple;
	bh=xxsIdljAYpjErYCzAnr/13dolIYliMjk/4F9ECcibgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxtRuk/rdqwUKPvR5z2180BQcLXdDaE1/MH/GEl4efYAXk/Ux4k4pbdvQJ4kTckacVpUtNjbQuhzQU4uxaLMGIEM1CTzqEDwPlJsQdXXWX4heSnw1PYjPK+5Yk7uVKG6OQvudI6nzUCWlsERm8aqUKdR7m2YDU3pp4/K6MLtWTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kLy8IggA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5f4c30f8570so1231649a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 02:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744883739; x=1745488539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lQ2mg/xbhZUudvvozY8bxjrUVYqrKSPwWo0JmfCbuZg=;
        b=kLy8IggAHF2lP0xsL/ZAkWhmDQpV5erQ4JpD8JYtNXTRnHFmrnWDZhwSp8brKg+bJe
         84Cu6f9N4gGj0429xeJHBNnm4HMd0/zkg8RuaC+3xj8vrh6xeIjD2zWCF+FYJRoP/1q2
         5hCS8o2S2eaivxjPGvzPQ3dyDBS1sc4+7R6ead/Rc+WB1/Q7xminD0mLq/r+wVQBBoMn
         zvl4kj6MWTxAD6cRT7fa6jM5RvjQulJ/O4lltYwtYnMnHmhpqgwDvmR0rnfAqPbAHo1a
         o9eIzpn7Attc6Ms8AJh5SoogbE1lTlPGCogoLf4M/ugwdPV4wu9qZZoMBFci3R4W2ndA
         VMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744883739; x=1745488539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ2mg/xbhZUudvvozY8bxjrUVYqrKSPwWo0JmfCbuZg=;
        b=RQvZmJWma2PdFzUOOE3FxvnCBqIgwNdEHHO5jadVpvM02g/XvCEA9QlS3oCzkR7OqC
         T5puaGFtEYSfloiWC7eupfsaSiCSg+fV2rn4L+HCN9w77OFup5ABqeUXUiGJ4le8iz1E
         5iPRNJQVdLQjKJbACgUfQ2sjRyr5X8FjqmGPLaPJTW06CoCn7j6ADFR+fHqto6irbQh4
         Khf3+vJ3R2YqlWe6L9yE9HexHfcVWy8YB31BYLfalH8TKzIBJRjSANenRPpzQ6X6AB0E
         Liwzz1n7ntAlnomzp0TDWeANlTQzhjhxeKtEpzuYTdiN9lo5znGGW1M0lsiCX+CEdeWk
         S28Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnG6eX8ud2W7uBE0TN3DSoj06JzFpV0ACW6f2E16JW59NcrDolQfzT3Gh5O6P+32j4siE+OGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJAj48bhVtz2HDC8hipAzrs9fkxun0iyHJjtLPWR2V8mz8vTys
	7czOtIWdKwBhAuoqdHZGF6A7E6IyQCk//qz8Or3xAZ0JP8EDHAWOmbOIwM/fZOg=
X-Gm-Gg: ASbGncudXVHAwQ/YptHiKKEkHlr3VUNxMCh4dC+ucA84X6YTzW/omIwyfcaJR6v8WUu
	MYuZXihy/qwxGsvW9w/dal0/RKcNlvJwSgTMkWbWOxONU5Au0oi3xAroCDHhTsI6lhBitIwMRvS
	NnAfxDYH7V31ohFovZ9G3vH7RG+0sfvBpzi9/GfzNZ1Q9/MkAlRtKDLoYjKDrRrCygQykPNNV5i
	wQS8E+B/sGj71RGwxpWfV1aNq0K8Fo2si6GrrQmy86AF0UMUWLla8+J3EffWqlLxy0s459FiET9
	Ern/BwlGgpWQXM6sJqNyuEOXcKUaQNszR2NenugeM+jN7723v+enGUu/BDKbJ9YjDai9Wvhx
X-Google-Smtp-Source: AGHT+IHiPcIRzUjZ9l/y3Kb1Zp9PXVFu+VjCeI3N8mu+9K2K1k0Y9An6INL7rP7SHCShGclwmsoHig==
X-Received: by 2002:a05:6402:4408:b0:5f3:26bc:4b0d with SMTP id 4fb4d7f45d1cf-5f4b75a72f9mr4730440a12.19.1744883739248;
        Thu, 17 Apr 2025 02:55:39 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f52a48esm10067924a12.79.2025.04.17.02.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 02:55:38 -0700 (PDT)
Message-ID: <c33bfc41-46e5-4a69-9a73-63ac24512e78@blackwall.org>
Date: Thu, 17 Apr 2025 12:55:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 iproute2-next 2/2] iplink_bridge: Add
 mdb_offload_fail_notification
To: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org,
 Joseph Huang <joseph.huang.2024@gmail.com>
References: <20250415144306.908154-1-Joseph.Huang@garmin.com>
 <20250415144306.908154-3-Joseph.Huang@garmin.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250415144306.908154-3-Joseph.Huang@garmin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/25 17:43, Joseph Huang wrote:
> Add mdb_offload_fail_notification option support.
> 
> Signed-off-by: Joseph Huang <Joseph.Huang@garmin.com>
> ---
>  ip/iplink_bridge.c    | 19 +++++++++++++++++++
>  man/man8/ip-link.8.in |  9 +++++++++
>  2 files changed, 28 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


