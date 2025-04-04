Return-Path: <netdev+bounces-179368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447EBA7C1F3
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 18:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D47175719
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7C20ADC9;
	Fri,  4 Apr 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="u6nd506f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783D1F181F
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785985; cv=none; b=E8vbJnq25qJmMDr0BsbDa30mx474VAqreG6fyX7DPkJZ2EF9bw/2K0NuKKpoh1HrHJl4BEMSOYYbqKVH5Nu1AVBaphBMHMyu63TeqvOtKf0cvpGoHgnb8c8VdeLZrq9S+nm38rXAkHbSpPWIdQFCAvoQaamAY+E/oTS6FSPRO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785985; c=relaxed/simple;
	bh=WNGr8NcNaILBz7SPiTjNuzZmb9zfNZJv04IHA+DNVwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG48iCYEKBYKuXgW9l5aMJzjwIv/v9Vwi+lBAnB/Q4b/3nc98i2qbbMV8gnsKw9HsRr0jKlGcr2kmJfs4AIPGyYwZiJaFU1H84nj2MFrXWCqeH1LKfqkHQAd861CJN+4NUuGMpVcNVg4tMaBvkV7xw01r7AzPrPPS1pxJ/FNoRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=u6nd506f; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b34a71a1so2807868b3a.0
        for <netdev@vger.kernel.org>; Fri, 04 Apr 2025 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1743785983; x=1744390783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGAD//dH6YuCj7lauDr1TQ+gnFpbnCtOW43cFXY5p4U=;
        b=u6nd506fDkEXIiQneUqrjPph0uVrbcbURpOCoN6YI7iy6MMH7clf8RhlbFirQzB8hm
         vQLV9x2fk33HtyJbaGvX5yaX55z4yONwSKxqQlXQJZ5EzpK7Zqv4t+VH+Gqtn20rDAu4
         j2/3NyDRmO1XmlOsODuOI74ybTEqIvGjKMU8ZkgcBF1NZb1py/HX4alwVHfxavAbP++d
         wMHnqhys3ACDNnLRDf/KQkr4CYyK9T2VtHq8XpZiut4ZnDv4CB6wDwvecA1D2QXQTNPZ
         mdB6KhKiVhb1nUGHiNaKT0UA/IrTRaHFaSRMjqjvy8w2HA0gBbXMM3IByloDVSPGedmW
         r22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743785983; x=1744390783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGAD//dH6YuCj7lauDr1TQ+gnFpbnCtOW43cFXY5p4U=;
        b=oC7DsPWLcKkZTnB+ZxW9YllrxdJQkdoYJ1IvpH3j530mPpIcKVeyJj63QKY81Vgk67
         MHhy1JrF2ZlgZmrNNK0HGm3rd86YJj6ZlRDyhUl/delPOejG3WoUP9Pif/SgBKIxipfD
         UIxkdsXj55C6aaWYekCgoYcTNEhpTEkZqdtEBszBwATsUe3cG4hfOwjMhtxOqoX+g1Im
         bA2PR474rVvCXGVZotjp2S6TUZuO20ZFJvpCOW07/OnAnyY1EF7znz8xGIG3KP0GskSe
         3aY11alZXqsRv2AQpnqT+nlBOUrfAPb9O7hOpLHsj5Nz17IBa0kvbXflfFRZmp717yBh
         HQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY1L7glU0EIJIqMzKlDgc4BkOuXIld4E0aaSc2E8BE4BdxE96O8pWmZ1hf5zuvSydsLEAFnVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2po9+wY8q/wbUJBl+va++tY2Yve3ID4OEeYzn/k7x+vxue4oN
	NvgTJVRf7kk77fU5IGZM0/zIhB1Zr+wysZsGPeSaPIlluFLtIqzvEdzBEiou/g==
X-Gm-Gg: ASbGnctL4LXpoEGpZ+8p/M1PNECbCBXxdmCyUqooXO5Fd0AdgIKwco1PitfiUN4rAYG
	Rqjw85wJ7D6Svg3ZcEqjJquvhurohf/k/ci3ddJbeTPIuS4xe09RV6/xqZXmo61W/Oy81nwyfU0
	SIV5PMaV0aJgP080HN0Y0gh4WVUzZgyY3j+nFpiwQfNCn8h/Q7XtNqM4R//A77qCsi/qt5x+ZCX
	ugwcLIiOYNJ9jkwxrk5oeBCkDmzBkXE3/pcsDThIbtecPtQO8wzW9PBUI6kjK9pO6PGk3m9cRTA
	UyiHm1Aejvm00JEvD4Z1nM7lTTb1VfpiFImv4QRf5Lsd9kySqbp3EGDRImIEFQk7+uD+mo+XxAb
	vIt07D3BWcRVoxtI=
X-Google-Smtp-Source: AGHT+IGFCdlv0SoTMKrSosySD6tapKgpp9OxMOkVFeep0/R9JNipOieWtx5yM/T6YtUlYE2FePw9sA==
X-Received: by 2002:a05:6a21:9013:b0:1f5:58b9:6d9b with SMTP id adf61e73a8af0-201046044d7mr6188935637.12.1743785982681;
        Fri, 04 Apr 2025 09:59:42 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:8485:ad62:3938:da65:566f? ([2804:7f1:e2c3:8485:ad62:3938:da65:566f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc34fc97sm3114036a12.42.2025.04.04.09.59.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 09:59:42 -0700 (PDT)
Message-ID: <8bd1d8be-b7ee-4c32-83a9-9560f8985628@mojatatu.com>
Date: Fri, 4 Apr 2025 13:59:39 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net v2 11/11] selftests/tc-testing: Add a test case for
 FQ_CODEL with ETS parent
To: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-6-xiyou.wangcong@gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20250403211636.166257-6-xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/04/2025 18:16, Cong Wang wrote:
> Add a test case for FQ_CODEL with ETS parent to verify packet drop
> behavior when the queue becomes empty. This helps ensure proper
> notification mechanisms between qdiscs.
> 
> Note this is best-effort, it is hard to play with those parameters
> perfectly to always trigger ->qlen_notify().
> 
> Cc: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>   .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

