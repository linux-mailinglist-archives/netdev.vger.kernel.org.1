Return-Path: <netdev+bounces-130910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074ED98BFE4
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EA4282237
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335D1C6F59;
	Tue,  1 Oct 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SLkMJ81U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C61C6F56
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792950; cv=none; b=rZstvplE7297lg6W7mQ5jhW59Ur44BmdMpo9l+jD2d8s/QnY4zEtmVYrcbHK9bC4ga5HD8fBgs2DvWr3jE3c53vWKoxx11gBYrpmmrIqRBwjGHf7ZOvR0o3e/Y0XzSAn9Xznj9x47wzK2akKJNcyy5qpm0eTgorUSy+UDqIIrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792950; c=relaxed/simple;
	bh=6y2Ko37c6bZpyzZJw8yX8vnCdLYkmaxrmJSko/bOA8U=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=KLb6E09DQqRiSEZ68TsigT/Kgqn0/M6oKMFkNlP4q+ud2J/o3VqkP+/VR11TNS1H/Uswb/Lec8UIQPnZWLWY5Rm6jpd8corIcz6A5phhZraRBuRWoXnDJbsNBIDjzNH3Nmb5Ih97pwHJzj2+5yVmu3on6h1i6tgb5vK171eJ1hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SLkMJ81U; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cacd90ee4so8097495e9.3
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1727792946; x=1728397746; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:subject:to:from
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6y2Ko37c6bZpyzZJw8yX8vnCdLYkmaxrmJSko/bOA8U=;
        b=SLkMJ81UsoFIdNG+/wQJ/XlZRxntQfnFknX9fPjZxJMJpSEB2g0IxUv3QVcTer4tZU
         jQBcKt2KybyoO167F9HMhsRNVXdCMzDYSH5mKtdeT5nvCWYTU5cQNAegpeyUqJm7B+j6
         fgnbcBKFDqrQka2IzekVH5/+YHT1+yaqUA3QOh1vwgvkcqc+nJ4vVwmURcgwtq3T1vun
         ZZxfBQWketx21e+IV9qevP8gkNGbQRIf6oFkRxgUeXllyGT3P5jX/fe3VyUXp+LOsROY
         9nWoWAl5tpJbrOMulJLr7gCls3IJpe9whIQz3dLz6U+Ssyv6i7yRkk4sedJ73r2Iv0bc
         SMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792947; x=1728397747;
        h=content-transfer-encoding:organization:subject:to:from
         :content-language:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y2Ko37c6bZpyzZJw8yX8vnCdLYkmaxrmJSko/bOA8U=;
        b=ayikg+R5zKFvT8XZGsswuxqRUBo1dCCPSQNki5V36/qWFOqE/kS3WKNtzbmeSpuplR
         ROLb5P6gARDtZViBHJoiBx7hLeKIPFWS3ww+VcngpnRTwUyMnByLUd7sfFDtzEaWbUlu
         aN3yCCffZZxs3JJdw0/ISCoMLZMPSFOB3sJAKP4SFrjCbMQLD9/nEYb7DAPfwEv2wC/x
         cWjVKZbiD8/taEKvqqIOGq6Pnir3R/mn8tWB+ur+xxSlbTYMfX9XRHkgSEk//HbJymYU
         8kgDuOgUS57E+N+uEUIsqeFdaCEyL51qFatuvKa54SCaGd/IZX1bjgSd8/n1PxkwkuAv
         E38A==
X-Forwarded-Encrypted: i=1; AJvYcCXqdLCEJ6n0wrwnbQ/vq3vwx5wv4bwNMQmVxJtULuHccDqWQI9hHYbl3LVXxLi0DMxsn9dWt60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHpac0e1n3XIYu0sMcc9g7lANmcrKlNhndNhuy8gwVPuZXHDN
	DOH1BVfhQkEWQZTbZpq9K8OuVdQEWULsgqlyxlLaBVM3Oc8x++9hhBEQtO/kYf1CXkUPSHkD3tF
	9
X-Google-Smtp-Source: AGHT+IEswp/VLXYGpONUE2dR+kC/owevEtpsf5LTOMd+ouPbbYYYmhdwL9aP3Jq9SMizIWmZZF6Q4Q==
X-Received: by 2002:a05:600c:4453:b0:42c:aeee:e604 with SMTP id 5b1f17b1804b1-42f5e3c4bc3mr43088755e9.8.1727792946574;
        Tue, 01 Oct 2024 07:29:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:aa9d:4d55:f3bb:3405? ([2a01:e0a:b41:c160:aa9d:4d55:f3bb:3405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e1392fsm136805955e9.31.2024.10.01.07.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:29:04 -0700 (PDT)
Message-ID: <4d6edf70-57fb-43a1-bf15-330bd5f6405b@6wind.com>
Date: Tue, 1 Oct 2024 16:29:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
Subject: Doc on kernel.org
Organization: 6WIND
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

I'm not sure to address the right people. I wonder if it's possible to remove
some obsolete docs from kernel.org.
For example, the ip-sysctl page exists in two versions: txt and rst, but the txt
version is obsolete (removed from the kernel tree 4 years ago, in v5.8):

https://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt
https://www.kernel.org/doc/Documentation/networking/ip-sysctl.rst


Regards,
Nicolas

