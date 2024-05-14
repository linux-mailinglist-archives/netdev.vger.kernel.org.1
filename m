Return-Path: <netdev+bounces-96252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6D8C4BB4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 06:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578BAB23822
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 04:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E494111A8;
	Tue, 14 May 2024 04:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEu2iQ9g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4105ED8;
	Tue, 14 May 2024 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661283; cv=none; b=Rf+CGiK0XJcRUzTPmaZCZjyQVHWiZh7vRk38kiub68rgW95S5xRQ6rAc4K22W+YDj9a0fBr6nhSihJBvlQRwqVwSY5if6RK57BAQvgtNImNkIq8/PLE+VtFHxhI0/USuzoiMqaGQQ+MgZdjqsBvmXaOsJlWVKr2SOOK8+vNL2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661283; c=relaxed/simple;
	bh=dGUECzmT71vk7yUXupEDNgZTgp6YkFQ58WJ3CImg2IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AfegyeJYh6PRNX68x1CUHlFfMhdwp06UkY1D3mJckTNVch4Xlo6c4j1XstQlUvzyuKnqn2BkfBKFY5FsiBa7rKX/3wL9Wgu1SPqzBh+EU6nIU6ExYXPqs5jqrS6wh7LcWB4lsMhgZFRP/c+rerIqeLec8kvTRO0Yf7F11Y7JoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEu2iQ9g; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4dcc3eeb3so2814338b3a.0;
        Mon, 13 May 2024 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715661281; x=1716266081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpL9ckhM2YONgCKwIgIxImKCVVLS7o9hHr+mnWRzhqs=;
        b=dEu2iQ9g55Z9YV9Ohov6goV1vUFgnKJZDcjMLjCczTscmPYQNmVfhC2uBBl6H39hs9
         OSDs7I5g6hOOHQ/Dy9+DKl+Z+FEjpIIZfos2Yryh//r7uaWm7WebaSm6X9sLWTmG3h1r
         wlBoDJMOAdmcuDJWhMvw5IhQd8oaKi13SUO5a1N7ftQdtL2qnT7moKd/EfcgV7Glceg0
         FfqH1ZsVUlLqX3I/Dv5Io/X9coukuY84zWxrWxuEK0YukcL+6Hf53qBOcE23/tc7isiR
         HZFMmp8rULObtvdoESlCp7AJ10LvO/LYcNigZuOJUC2P1Jr5PWSsc+gNjR5AIJQeAL5n
         +dBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715661281; x=1716266081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpL9ckhM2YONgCKwIgIxImKCVVLS7o9hHr+mnWRzhqs=;
        b=C0jTcKr+cMW9pFgn+oJivc6XxRFXdOLJX6zwqP0DIpdEt0qGPhWHP7h5y08rXPIZCk
         Z2j3xA9YGV+xzdt5xDa8+v718pm7S1zN5Zwja3wGkwSCDu63SnOm6xRE7wGAuHCBFMJc
         elEaKT+vYdscgd6NvZFFQleCLi91l+3jpfX+Advz93MrXsQqeMlB/dxjg6L9gtms66Ef
         wfPkgsx9hA0tb31AWbXlOak08C7lXP3KuGRihjOP9dBPityhDn3GIhCD30/Kh+zIIZeB
         fw7j1sblzE5bm921NOyoRr8/nuyJbxPfcmUnmNJfKkuV95DrrAs8MnBVFB+tXyx0OMNL
         koJA==
X-Forwarded-Encrypted: i=1; AJvYcCXewyysZyRXXEGKAVDlAyYWukIs4qT5+r54J41YTZH09xFcSmjv0k9GiQR3PV8BTOnnV59THCMbco5Thk8GAfWJCP0YlxWR
X-Gm-Message-State: AOJu0YzBJXLWq0SfxNW1sBALR01QuzTt6olnwgLb1YOOapZD8+VR91mZ
	hpjzemiIego0J1JyStddjQdxFL8RdDsznCsrOkVBNMmX7YWfZvH0SzLyUQ==
X-Google-Smtp-Source: AGHT+IHXgL9debFvWZAoCQrU5U3M+829xjnxkEz0F7kqoip4AF5ZVEbhUB6ydMsOHSFm+eW2DZtPlg==
X-Received: by 2002:a05:6a21:628:b0:1a7:9cf6:6044 with SMTP id adf61e73a8af0-1afde0dc45cmr9412708637.27.1715661279888;
        Mon, 13 May 2024 21:34:39 -0700 (PDT)
Received: from [192.168.0.107] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d47e0sm87638805ad.5.2024.05.13.21.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 21:34:39 -0700 (PDT)
Message-ID: <56463a97-eb90-4884-b2f5-c165f6c3516a@gmail.com>
Date: Tue, 14 May 2024 11:34:32 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression of e1000e (I219-LM) from 6.1.90 to 6.6.30
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>, intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 lukas.probsthain@googlemail.com
References: <ZkHSipExKpQC8bWJ@archie.me>
 <b2897fda-08e8-40de-b78a-86e92bde41db@lunn.ch>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b2897fda-08e8-40de-b78a-86e92bde41db@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/24 00:17, Andrew Lunn wrote:
> On Mon, May 13, 2024 at 03:42:50PM +0700, Bagas Sanjaya wrote:
>> Hi,
>>
>> <lukas.probsthain@googlemail.com> reported on Bugzilla
>> (https://bugzilla.kernel.org/show_bug.cgi?id=218826) regression on his Thinkpad
>> T480 with Intel I219-LM:
>>
>>> After updating from kernel version 6.1.90 to 6.6.30, the e1000e driver exhibits a regression on a Lenovo Thinkpad T480 with an Intel I219-LM Ethernet controller.
> 
> Could you try a git bisect between these two kernel versions? You
> might be able to limit it to drivers/net/ethernet/intel/e1000e, which
> only had around 15 patches.
> 

The BZ reporter (Cc'ed) says that bisection is in progress. You may
want to log in to BZ to reach him.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara


