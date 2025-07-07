Return-Path: <netdev+bounces-204723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B57AFBE2A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 00:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE36177845
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 22:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739828A40D;
	Mon,  7 Jul 2025 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIsadeHy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2522882BC
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 22:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926405; cv=none; b=AbLrkpXDRMJgLorja2ZQC6qqwgJcLBJFP+09A9ntuKtBqWW9ILVuyIF30TAAEhLHZggxZ33Cu1KOhVCiFVzpUjoC5mRaaBNu1BlExAcjkr0oeQAX1b+zj+0N/e8YXj7R/hn7S1T5Eno9aTAkFPHqf1VHTthP0mXJQtmQkKocIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926405; c=relaxed/simple;
	bh=QvpQHkMnkjtMGKhs20DXiyjA7ajOSZprDdevxftK+2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udfOnK7jbMNmxPMlRMb6QC5j7ZKxtCiAwrssTjyDgSnSCmZF0/XgKpWsyMBznItPBYVDphHHJHTRgg1OGrmdvQBhSvvCiBfUhlVUDoz3j+zhRGRtFXruJtg0Kf35DSt5FnPE8/XD0mBAswaTzeyvzNOIix9gnvOOvemSNiyQtBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIsadeHy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4530921461aso25653455e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 15:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751926402; x=1752531202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OpSCxJW7OHgNiv5KsdwVOuLkSWy0H466/2ujnHYCl18=;
        b=WIsadeHyvdtE+qDKyPCtcIlzpmRtspSDo6ezrZpuCIpix4v5BHpHTkg5pU3vMjG2lX
         OrsDHn7ql9OoQ5Gs23I6/tliBC7HT4LgaUzIkLg95rf2odEteZWlTKBvg9YLeVsZsOca
         S0XvGldX9m738i7FvsKGlFzZ++9riH89nM3M5AsL2Z0bJxGS7NmjVz8VbYbkAqojozal
         ei+PNUXHup9ufWfaI/Um6Xy4GNjOcnGbKhjtVgY3i726qOUS5InvoVo+H+96PvgMRWB3
         6udXo+21Y/rrU1N/PpiHtcECDKLRuRezm5f1G363nqV3chxrVxFf05yOzwyfwqhTXZUF
         smrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926402; x=1752531202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpSCxJW7OHgNiv5KsdwVOuLkSWy0H466/2ujnHYCl18=;
        b=ok1jW6IJ6STyqE28lph3oqGP215Pg2nhcZNa3nQc2tUx/QMxfIkJXgfpukBRF9bgNu
         SAJsMCF4ajLoc6RgOCXg9FAVjKHKhcAaiHv2VkgpTvI1yVmqLu/0PWjsZmLjS1ZIfuts
         mM13owBitq+zh92gWslSrlLhW0WowexcMK+VOOJoLcnKlXQkNSZ1FtHI1HawzTJCpUIQ
         7Su1/9pmyn7ZIdw137lNdyYzf1MNplfVWvtEjrusKghn5NBs0MGtSDkcvkuK0dQMQtNO
         ANGRM+jxcc4arOrg+wiUGUbWHdIhxqa0Un9qJULBgFV2xe8c/S4Q3NaFTdYcrYYpXGOg
         247g==
X-Gm-Message-State: AOJu0Yzvn7BtiXbY30O0BGjGs2qMKhA6psc9Oys0lQbHUYv99wZpipN0
	+p/3ml9H9mvoRWq/h6uqojnn9dE6HiSWG0AakL8KxHvEhoK1h070wIQp
X-Gm-Gg: ASbGnctROlvIAhujcSux0//q+mfIHDBn6/u0rYQCFwA4HAJmjQIDKKYNlKWh6V+DzY2
	V1b9NtdxlPpeC9BrVNqSKxfhy8oZ919jH1RyxiHHn53ZEasIbrRTr1G9GF9P+WebO4ny2CDtADv
	caXJPwMkQg5CEnT6EhqmKpM59VMwZ+/30sFKI2/xzkBYo9ETjYsMCdcZhKPyW62z7lEv1Crvai+
	tvGYgFZDbG2XQWelXsMDoiQdfmhlf0kUCoobU6sV5BH4HGBJowHbwuj7hvaAyrz/05Fx1UPD52F
	hJz8Vfjf7xINe9vig/Y1c8fhFg4NHtKOMAkzR2azHHRJjNscnZtHAtYCJ7US5vggW59rj0oLV+z
	yMILL/rbRuIEWK46vYaVZEd3bh2kxZY/DBUGwn2FayEtov1ZH0Q==
X-Google-Smtp-Source: AGHT+IHmA6eSm/7Zw4VVgS7G/XNA04dghn8oHZjBH5UPZqnSJMpJVy1gaVwl7L+/dkYi5DjDN0cCMg==
X-Received: by 2002:a05:600c:c16e:b0:43b:ca39:6c75 with SMTP id 5b1f17b1804b1-454cd5168fdmr4733915e9.16.1751926401715;
        Mon, 07 Jul 2025 15:13:21 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd49e738sm3467615e9.32.2025.07.07.15.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 15:13:21 -0700 (PDT)
Message-ID: <b3e06293-0866-417c-bf5d-7d6f1b541125@gmail.com>
Date: Mon, 7 Jul 2025 23:13:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/5] net: ethtool: reduce indent for
 _rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, gal@nvidia.com
References: <20250707184115.2285277-1-kuba@kernel.org>
 <20250707184115.2285277-6-kuba@kernel.org>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250707184115.2285277-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/07/2025 19:41, Jakub Kicinski wrote:
> Now that we don't have the compat code we can reduce the indent
> a little. No functional changes.
> 
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

