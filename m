Return-Path: <netdev+bounces-140681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3EB9B7910
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824FA2860CE
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178B19994A;
	Thu, 31 Oct 2024 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htv6evck"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37490199FA5
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371964; cv=none; b=uaWkaTtg0j8m/eBCA874JiaEppkOXwhsAjEdDIk+Df0yx7+6KwgE+DZoHR47S4MswF8WOV67xYXXhL2OdGhZuz/T3/Wo6f2NTKYPjjpxXGhjHffWdBprpEL++ZiXZGSQaQtEpOnj47tU3MxceLNXnqk0cHZ/VmkHHJCxtyIseSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371964; c=relaxed/simple;
	bh=SwFBwBIvoXU2RBsJI+u4fqOerMpUc8/ZRMR6yScOJXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9z2Y4q5YJMgR9IclK3UaR1g4399yiSpYx5zLSrxZvyxFRI7F9XYCcfbvmYHR91ClOv1+EZ2P1oRb4pppFBMPSRZSWkUhBmazB7C3r4HYMTcajzpXRaiu4DzxShb1ODsGNPTauStw1PrwW5mUFvZPDanIqSMRmQvI4240w/K6TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htv6evck; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730371961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV7sOo6UpzuMwB4bSnPkKngFzqbItuEk4sjaHJSnab4=;
	b=htv6evck16ItV2lv836Jcfn15UWopTYLSMgba+o1ALmulCFMSogwGp7dTi4tFXTpD5o4NF
	bW2QGU2t80Pf0VLbDGn/RDAvIaYmxAbjwI0HmpiLzdRzJofvGFwAisfOPkd+bCus9pYiVt
	Xj6d6N2Nk1n48ZsdOfp9b21kQ8Mhchk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-r1wB1DT2ORa4DbFWzi98Gg-1; Thu, 31 Oct 2024 06:52:37 -0400
X-MC-Unique: r1wB1DT2ORa4DbFWzi98Gg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ea3d778dso549076e87.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 03:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730371956; x=1730976756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV7sOo6UpzuMwB4bSnPkKngFzqbItuEk4sjaHJSnab4=;
        b=VQ8QsW4AxWGLV6jgP/1Ze4767hXzxG86Yr6z7XFkTvnc1QKszSHSE0OT+vqo0884ds
         S/ZlzEOLhokuMWJOCWdSiDJfZ1RK5IABO8kxob09CB1mL2YUvJJ2gKRWABZWB2y8fhLn
         sYOqSqEJe6fdPCDQWEWSAfAJsM7mwXH+JnxEVmh8yi8I5MLGDvsUKJ9nNFkABLNbLJyU
         qMeAgPJ0JkU6xlFHDGDq54CkHTLGmV/Z9z0T445ReRMmrNIOECs6N7rwvsDcVWnfpHep
         Bvdn9fCWzPu29IftstO5rgjeYyqPMhr6yOrwBxm9sJimBdfzrI95rvsppU2E75QwTQVo
         BcEg==
X-Forwarded-Encrypted: i=1; AJvYcCVoXgF35K2ayXlP+WTzUqpvClQmlBPFeMGLW5N35YJ9XqgN2XebSXtuMqAy2d4cYhTdwHeRknw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzs2xmbun7QHjDKPxCrgcFi1Dz2kEJbJF30bk3EIp7pN0Atm75
	WrltMVUqYua7tWXOdnqlWoEKO5+Vz7UtY5vaBJuwabCxCGmmyHclTSVXTN8DlJAlOakMUr2VPJc
	6S73fAvJjzQiyNYyod/h2jjkaOayxsReEtdUwGpSqesUQwQAPYZSk7Q==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53b348cf0c0mr9561679e87.14.1730371955930;
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPlkn+SJXy7w6iV3YfSGvZYFvBYxL/Zq1Ot5wHRbcZsYQnie+vd2gCyjPL4AYwHUczW0kRzw==
X-Received: by 2002:ac2:4c41:0:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53b348cf0c0mr9561661e87.14.1730371955465;
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5abfb1sm22089285e9.9.2024.10.31.03.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 03:52:35 -0700 (PDT)
Message-ID: <1c19403a-e192-44bf-9158-9ac132174c40@redhat.com>
Date: Thu, 31 Oct 2024 11:52:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-10-30
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241030192205.38298-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241030192205.38298-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/24 20:22, Luiz Augusto von Dentz wrote:
> The following changes since commit c05c62850a8f035a267151dd86ea3daf887e28b8:
> 
>   Merge tag 'wireless-2024-10-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2024-10-29 18:57:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-10-30
> 
> for you to fetch changes up to 1e67d8641813f1876a42eeb4f532487b8a7fb0a8:
> 
>   Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs (2024-10-30 14:49:09 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
>  - hci: fix null-ptr-deref in hci_read_supported_codecs
> 
> ----------------------------------------------------------------
> Sungwoo Kim (1):
>       Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

FTR, there is a small buglet with the tag area in this commit (empty
line between fixes and SoB tag). Given we are still digesting last week
pw, I think is better to avoid rebase and repost, but please double
check such things in the future.

Thanks,

Paolo


