Return-Path: <netdev+bounces-196029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D075AD32CE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54DEA3B899B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807E28B7E6;
	Tue, 10 Jun 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pkud2SEv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6763828AB03
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549202; cv=none; b=M2hnrlt2dVg9fULTHOlpyhnJ+LNGmUCBzA/5MRavi9nfIXXxMfUtGCTFnyq7aexz2hlAAM200oveIU+yuRygki86QzJvnQZ12p+5yfecJrDNlPR2+c5D85Q/5gXr0w4dXuHspnQuj0hTchW7evCM4fggsuS4g7ZseSdOnsPldy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549202; c=relaxed/simple;
	bh=lf/Q0CP0+3JGF8skn4vJN8mCuS9rEjV0RqPQBwzodGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQmyathWlMhDpmkZptI1Na68YGzMUQq8guZc08ONB5U1FJY5bjd39EJx2WEsCy6FyQyXbe++rti46bMsOgQuuLiiMWzHvbrRJnG9qXYwYKPwA6reTnboNOtEgGgOOfIjohbEMtLPVnZ+vOmwZ0prPW/kYY74zq/hHTuMozvvrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pkud2SEv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so4254016f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 02:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749549198; x=1750153998; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IEkGDFBIs7IrBtufGEQ1UvIq45B77cgWp5iZKKgIpk=;
        b=Pkud2SEv4d5Zd8qEFxIsJJyS650FzgonHEnjoeteyOCLnwMNXSRVlxKjWX785MUMpd
         ISwCy07c2Xyt+xs2SKBEEBUXnSVsPFYI7QMzwMvP1hoDyWgDIDTSTXsgvj2vHiKkzleE
         6NYiFsKvp8XmTcSDh8RII1yggx0PS0yJ9tSlfOI1dmHE6UhO7VCYQ5yB72CJZZmQ/BFx
         dwi7ZZOtTRTNU5P8XdKAXRDPJvJEb8vnlPmLoTvj2TXv07o2BA+i/q1VQ2fvYVid3loJ
         exsJETJ1B+e6wctTjXtPfHGUv6Gm9NiTOe97p8WaLIBFxBvaGaQgABKn+nRHz71tgGdf
         N2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549198; x=1750153998;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IEkGDFBIs7IrBtufGEQ1UvIq45B77cgWp5iZKKgIpk=;
        b=gyF8pQYATiIfFvAmds1J1IzXI5/j28VrjRvZjk9HbYl7a+g2GagkFE24xsmL8sjjM9
         5wgOdeFbtHjnXL61ypmsH+n6UVECRVI+VRgJJoj6qiNFv2GpvewonXAUDNMpoqbvZSOw
         dP1Wgstp4Eb9NVQguDgmUNeCatMixXhQFnyXSeIdv1OrY/hTG6MRavLISj4OlQk8v0ng
         mFp24PpVgh6k2evXJ6SFVlfh65VBhHQcTNAaOJy1Y2WMFkukf87ccols5ipLWHdA9riu
         LaytLtgrQCdoDeFbpDqE7KljI02Z90qiSsm+q/2LnPiDdBV378xlImi2lyZa4nFTjAx0
         LAdg==
X-Forwarded-Encrypted: i=1; AJvYcCX3Sb0VqPcS9bDj3TP00TCTxM6y+/iSUZ4Ave4HURnlfQnfJOT0nrreeNqOOVFsN8tw69a3um4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3UtpLPpFxURyg8h8VsoUPf88+BLXslwmKFTgXrwI2HSYLe+d
	+41pVVNtyzAbVwQSpTOOwcd/xA1iKWKfa5vBjkJMy1zqd9eF+j78p61Gy3F9J36s0fE=
X-Gm-Gg: ASbGncvjXHqtlLWpSCLLIF+nW/LhnYJp1h6v4glA8/5IyPoK8NLb8tni1+6wHcvhpuk
	vROieA1yfASDlLrxUvkklaOTjfLXHHw7NfYsl/Al1hOzTvfzdzHiD2IjAoVKmTTovxJD1q/+ooC
	2QFvwoBQ53hHWnPNvH/snbwXFfs57I4RTip/XYfTiBUN8mBgPLb1UN2yS2jcBtOelxMI+nr4QTN
	/2bElpJewug5fEeMT1nfwGIxlAypRfA0Yjb4c0nNvbcqpQun48h+6nKI8+ImRPWaf8bqTRsBsDX
	igC/GDNpDb8JW4KiDiztsZQ12N/rtvgPRgWsjrQoMIhM+qw5k01dPAIFRf0zaK8WdKvfTj9OnXN
	QrlBjvIB0dooGyDyYTvnx3oGP4Y4o
X-Google-Smtp-Source: AGHT+IF43HoF+ckI+JNZf8sM8mBLEsIZIzrQldZAYBnhq+ZWk+6w2oq6oTjq3frqJQUO14CjjL46AQ==
X-Received: by 2002:a05:6000:40c7:b0:3a4:f430:2547 with SMTP id ffacd0b85a97d-3a55226cd6amr1466032f8f.6.1749549197729;
        Tue, 10 Jun 2025 02:53:17 -0700 (PDT)
Received: from ?IPV6:2001:a61:1316:3301:be75:b4b4:7520:e2e4? ([2001:a61:1316:3301:be75:b4b4:7520:e2e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a532131df6sm11612214f8f.0.2025.06.10.02.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 02:53:17 -0700 (PDT)
Message-ID: <dc4e3500-b5fb-4aa1-b74c-c37708146c3c@suse.com>
Date: Tue, 10 Jun 2025 11:53:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: Convert tasklet API to new bottom half
 workqueue mechanism
To: "Miao, Jun" <jun.miao@intel.com>, Subbaraya Sundeep <sbhatta@marvell.com>
Cc: "oneukum@suse.com" <oneukum@suse.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250609072610.2024729-1-jun.miao@intel.com>
 <aEajxQxP_aWhqHHB@82bae11342dd>
 <PH7PR11MB84552A6D3723B68D5B83E4BE9A6BA@PH7PR11MB8455.namprd11.prod.outlook.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <PH7PR11MB84552A6D3723B68D5B83E4BE9A6BA@PH7PR11MB8455.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.06.25 11:53, Miao, Jun wrote:

>> You can change it to GFP_KERNEL since this is not atomic context now.
>>
> 
> Thanks,  the usbnet_bh() function only be called by usbnet_bh_workqueue which is sleepable.

Yes, but it can be waited on in usbnet_stop(), which in turn can
be called for a device reset. Hence this must be GFP_NOIO, not
GFP_KERNEL.

	Regards
		Oliver


