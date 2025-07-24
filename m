Return-Path: <netdev+bounces-209809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C434B10F13
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 17:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB6516652C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EC271462;
	Thu, 24 Jul 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaLOYWmE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2B9EACD
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372094; cv=none; b=RgL9cWtVn+Fg0T5w8YK2xVcHjh+zyZECOtmMwhqEqIxGg9NDS1JyeimcVK0svuGCMbmDwnps3XZR8U+GZRM8/yuxsnBrgftU4tiXQG+RZck3N0DyHdgQw2kK12mXIEH99rNdRIWYOz17kkDzHbmyDF550vJfWvVY7ighB2tSolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372094; c=relaxed/simple;
	bh=LrI2GuYfECRArrafojflww3su9/SLOvl73/Mse3uH1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1okydQXBwG2d4N04o6yuqN2yMTrD/+FVUvjMzRkK1Mw0YFSgV7H50grQ5nFtiKaTVk9OLn9RqaqhHqD7qyFndQMtkJAOcNmM7mRTUM6qI7gfQJKVGy2j4WndpttKl/OUCb1L44P9z0XpEp/Rt2nYGQcHpjkSElCXQOE8XrLqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaLOYWmE; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74af4af04fdso1756420b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753372092; x=1753976892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVBJLcH8sm9mc1aPOqO0hyIXL+I1DSehIfnGndVoOw0=;
        b=VaLOYWmEwMpNyX8BgpCSN+atT4kSnF0cUsFtIVJhr4uSJPFbNGOsTd66n3H5gcZIpD
         M4uU/dheLUUuh9YsM8Z25kn6fIx8ET23hXWYw9nLsizzpjfn01kTmfohI8M/bMQSOiNo
         3he7LH2D1wdytKACsocEO26xG1czPISSOZvYhUJEt2t8s/Yo7AlHQMuIxFHj0Gtr6ygZ
         Iwv6a2FD/ueUqkoRKBtio3TBdf65atqS3smAba7xYiFPo6NHARapG4b+cM2goYkj0Glx
         NaBgpCY10y5iG+XIipiCartFC767/k/SGvdLz+axqa+oQPofQ84b/XkWYRBpeJZDoWd/
         JnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753372092; x=1753976892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVBJLcH8sm9mc1aPOqO0hyIXL+I1DSehIfnGndVoOw0=;
        b=qgJT4Wc3OmHRZTWvoMTk3LKFAXVhC2gFaBy3iRS9vaYS4AD676BoA1jmlGiit6K/8w
         H6ZwHeXo218ICfI3ma2YJxzchvepHo3UBptj1/UNLbfFVs12ZPpLF/hM3ejRsUBPLCiF
         Kg3iLTOVcuOnAspVv8fxpdfaUjbZNaNopQgtX7FpBzh8HAwjlmdJlW7D7l6Y2UfThqS+
         E09xF5l2g0vSRmpMvAYP03/a17Ofo6TCkIMHoBploQ7gM+c/XCQhKpFa53YVfOdCh73f
         xF6VfeKAnY6OQJEnsWY+EBPEdb6VULKjkvaBezlJpxEYfnuJ0GAijZ8nNZ5FLBLKmvkF
         G2gA==
X-Gm-Message-State: AOJu0YxLP/J7MmZfVgeyOOIjj2gKeK//OQM9poz+FKRrIHizbvvS0Z0E
	bRrp5C6M8AjJ+YQ9hatjKA1DXAPNk0Lm5UAzTd/6hlerwn0LH++s/+mr
X-Gm-Gg: ASbGncunqOuuGN5NCqKDFAXSoy6tFUIzU1jmjARNaZrs6cAY7iXfo2DlK96CmQ2m7mg
	UQjP6Dmubx+rKx+tvfd9HLilCTBoiax1Ieor+QhkFEPuLJb46zvJrdprlVrbfxtshb9InfYcc+F
	5EqTzDWB/gGzZ52g6p/qnDhk3T56xOtYZG28cSe8CV2ktN/OgSK6vDVoWGTIQwggjCmh9yZI825
	erWlY6NdXuNyWQJoxvLaAz5R6R4Hqb2p4v+Cfhdz33RcfxlZi6Byjxl5akdsAWS0nmERKy6q+Ao
	kQstbabByFHhHZFKokY58LBJbzWlGdW1SEquF8TGteGT4MYMi7kOg9ddg8tCnNIvQjt9DVp3yCV
	xeI5P5suYp4aPencSFKwGSkqnGrztIP/vA6QJjCt1CJ58dNf4
X-Google-Smtp-Source: AGHT+IGWrQY2VHkxmbOA3QXpWzKTbQLbaZAP9VSqEybeJ+suuPbNRn0rD9to99bNEdxEdnzpx0/k7A==
X-Received: by 2002:a05:6a21:32aa:b0:233:aec3:ce69 with SMTP id adf61e73a8af0-23d5b599831mr4193021637.3.1753372092141;
        Thu, 24 Jul 2025 08:48:12 -0700 (PDT)
Received: from ?IPV6:2601:646:8f04:30::d7f9? ([2601:646:8f04:30::d7f9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c10a0bfsm1647816a12.35.2025.07.24.08.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 08:48:11 -0700 (PDT)
Message-ID: <f6416f38-8677-438d-bd23-6ec0cc3dc84c@gmail.com>
Date: Thu, 24 Jul 2025 08:48:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 8/9] eth: fbnic: Collect packet statistics for
 XDP
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexanderduyck@fb.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, jdamato@fastly.com,
 sdf@fomichev.me, aleksander.lobakin@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
 <20250723145926.4120434-9-mohsin.bashr@gmail.com>
 <20250724101822.GJ1150792@horms.kernel.org>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20250724101822.GJ1150792@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Hi Mohsin,
> 
> make hmtldocs complains a bit about this:
> 
>    .../fbnic.rst:170: ERROR: Unexpected indentation. [docutils]
>    .../fbnic.rst:171: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]
> 
> Empirically, and I admit there was much trial and error involved,
> I was able to address this by:
> * adding a blank before the start of the list
> * updating the indentation of the follow-on line of the first entry of the list
> 
> Your mileage may vary.
> 

Hi Simon,
Thanks for the pointers. Let me handle this.

