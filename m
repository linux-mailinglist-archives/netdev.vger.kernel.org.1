Return-Path: <netdev+bounces-87520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D51B8A363E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 21:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B4B2875CE
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79014F135;
	Fri, 12 Apr 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDMIMApr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C52148313
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712949302; cv=none; b=r5psjCy2+Oapakhi/EASJuTNFb5XuMpBuclHSJWITNEHH77SHhNOAjoc2K9UWqhVr2quILCvbobDBly0/DpYNUP+goicIRQdp6qcJ5IjM1G7BWtFXfNviPl5o9JAfr0TLnzWVehWPShEg8VA8Vr9HE42Q2KvQ7hCDewZKDK8qqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712949302; c=relaxed/simple;
	bh=pqafSQ/pUMO89hdQchOjzmgCRrDtM8Pii5wIB+LMc2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujTZLxhgmcxalrNLt9ctIM6TVlTfs8moDRuPKdjM+lCFLOTyosh3BFe5r3DvKjU/Qb19Ly+jm/QxI5K6LeivaOcRUkylv/FY4gFUG0/vztyoS8663LJOaObu5k6b3QQM2k3tVsOHfd05KigzmaEZUTVlGR+nMC8o5vWU7fdQqVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDMIMApr; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51a80b190bso69728766b.3
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712949299; x=1713554099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fSILvxffpq5e9ruXIZsNeix7wzL0fUMenyurSYzRHIg=;
        b=YDMIMAprJE1WUl5F9vstbwXP+SvnClZaQzJOc5k20W+f9I4O4g41mvKwXizNOv+xWw
         UpN6EAPsIoN1iia8GRVbyiD/e2piWZTon3bQZi/iTj6lfiQ3XtdRF/qpLQ1jziCU+iUo
         wyu20U8l7SlSPA8NoZcXaa/dfCmMx/sc+r1yMzKWI/4BHChEyjZcPQx4POuwDgWoy5Fa
         Af5NNmD1QARrLbADL83EU9dEbBmQbS/w8spH+g8Bb1EalWva0EY2/0u+vXsOSKk6iWUE
         prswPPaw0DsrpGjgwjyNX0MvOthIdFwmB5wjX/CK3w7m9gqiP0CCBIKfu0FemHtv7Kcl
         D0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712949299; x=1713554099;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSILvxffpq5e9ruXIZsNeix7wzL0fUMenyurSYzRHIg=;
        b=dVM4uHw95hf4lVF8xKt+IN90m1rxmpD+y7QjRfvuzaAE89BTQUoHE4Q5Z2mLCzZjWi
         ZVbvqRbVWuHzjGVZvyBirGUcRqGF/AxjKBc5Fbz28Z8A95rKEbKWbwyRkcuY2omgMUM5
         pJh3v9+5C8oU8U/W1riDIGud9jdYagjfxml8PU10KqNnSEZ9dGuYCION0d2zQLyrO+ug
         yF5/Q9UeSIsDWxjS4C35rFiELRVXtI9OV5SrqOs+2/hYR6YyKtdDFbJgBnkUBzsaeiMp
         wjSNi7AZbgoe7yERIp4ahamQ1ngVK8l3FLt5NTKFK+LhC6U2Zv1ZOhSDS3qnwMnmC5gK
         UqOA==
X-Forwarded-Encrypted: i=1; AJvYcCWRslaXhSurAxmbFsNoFfkd2d75ey6h/H1u6cr52DaIrsh4Bc6Rh47nnsAeugRlVw+ZxQAlmIa/2QW73HK8Q/dUNPASiAmt
X-Gm-Message-State: AOJu0YxUo6XRFk6WAgYZTjow5SFtOxqCphkB1GdOtYltm1zIyU+uZHwo
	MacdQcJfueYi4ctdbDmz656PzrvsK1eVbeRLBLGvCft9+vp+jK2Y
X-Google-Smtp-Source: AGHT+IGsl7QkP2LiQ5SaoBZOh1DBkoJHsNWpkhWT2E4BCzrC9Gc6CnH48QAFUQvI7FTLUhdWo+XfKw==
X-Received: by 2002:a50:d599:0:b0:56e:57f9:8c83 with SMTP id v25-20020a50d599000000b0056e57f98c83mr3346442edi.19.1712949298973;
        Fri, 12 Apr 2024 12:14:58 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a91:3c00:98a7:a367:3d10:2fbb? (dynamic-2a01-0c22-7a91-3c00-98a7-a367-3d10-2fbb.c22.pool.telefonica.de. [2a01:c22:7a91:3c00:98a7:a367:3d10:2fbb])
        by smtp.googlemail.com with ESMTPSA id en8-20020a056402528800b0056e2432d10bsm1955671edb.70.2024.04.12.12.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 12:14:58 -0700 (PDT)
Message-ID: <97bb7495-7bf7-4511-8d30-ba9d47b6065e@gmail.com>
Date: Fri, 12 Apr 2024 21:14:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: constify net_class
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <1d59986e-8ac0-4b9c-9006-ad1f41784a08@gmail.com>
 <20240412093800.4d2521eb@hermes.local>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240412093800.4d2521eb@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.04.2024 18:38, Stephen Hemminger wrote:
> On Fri, 12 Apr 2024 12:17:57 +0200
> Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> AFAICS all users of net_class take a const struct class * argument.
>> Therefore fully constify net_class.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
> 
> Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> PS: net_class_attr can be const as well?

No, this results in warnings, because the const is at least discarded.

struct attribute_group {
	const char		*name;
	umode_t			(*is_visible)(struct kobject *,
					      struct attribute *, int);
	umode_t			(*is_bin_visible)(struct kobject *,
						  struct bin_attribute *, int);
	struct attribute	**attrs;
	struct bin_attribute	**bin_attrs;
};


