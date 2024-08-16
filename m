Return-Path: <netdev+bounces-119182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C837D95484B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 13:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D041F26309
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57F198E80;
	Fri, 16 Aug 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C6LNqUoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF95143757
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809170; cv=none; b=j+XTKXRwMqWbdcHckYLsbuOOABHfeK+95eNtoGuDc21apLYZObpDDFnSBXsmxNtS6bRpiLbSyRYHLn4zBZuufBG6m+bVQFUhhHXZEjkS3BbyXbEdASxfKY6fBEvbfs+HdJ+P4fpM17KAtN0VIzfo1Mo4C7YEsXoA37O4eF41VrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809170; c=relaxed/simple;
	bh=Hcj68IX6vD9/2vrJdBIyy2s7cD09pYRCPDwYK45+mTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U681Dxy2fua5oq2dQYBzAG/hgSVaBAfZyDnZyPiKqdslPOI4VyjK9PjyIBUpmKx5XcbjNwHLbXX06J/WksC112wLf4n0OyIS7ri4y5WovzP3RICc2k61l9FQAkidm5PuZD+R0TSRZDP+RdY+10g0WbIRi5PWWh9nbYY8y9nEyic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C6LNqUoN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a80eab3945eso215567666b.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723809167; x=1724413967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZXbpERELK456N5YAwkU6fmWfb1JBSdvncpOvwCw75k=;
        b=C6LNqUoN44CufXsLNB94gO7OIzV0sOiB9oNnVz6jDTHUhvry3CtFDX+h4fhHxEkgIv
         0svgapaxYz0nms9rujsriRTj5KGUOCDzu+Sv3Dq3nc6YKuGFkgvEHBqa7gS1dtYxOA0o
         sigAaL1R8w9xMKdMgOzUdtWpwSguxjAhWLlLR4ZwlpSiDB3mMbEGOPt00jlhl/WzqnjH
         yjW+r5zkf2efMmVcah9/DCIlKuBs55yPv7uDUd7EUUoB67oKrN8DobEBOUTjsllTPG5F
         s/sRmFm+sPPARGSPX8RIAvOy0Ocr2yCZWYda6keQC/qoYbblDT3WmfHmU/2O3dvBeJWr
         LA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723809167; x=1724413967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZXbpERELK456N5YAwkU6fmWfb1JBSdvncpOvwCw75k=;
        b=PHNdyUJTyaEn6Ai96bubjsiuSuCU+mEUINBhudb2LiY50aY4fub7ptrdp/vbElJOle
         TCsq04jn/8KxxzNVfgBTNslqr/HiVviH2pX4J8vRwHYrq+6Vgs68FUdk82U1V9v9+pNg
         VYy0cCqEb7XGBZo5OOr0yW0ddUWG+d8MFqkILegogsIljzxCACVxMMKr1WxCFyZOroju
         64rIQ3sXTppo+FCgLdEBaSZ76EFdA33jGk+ZbzicOlwXFFzZF7XQVY22v0Advcw79+k4
         JF8MzuqHd8WplmlJDai5gFchYbHNpWIYk72BF8f29gTC1mzocvyqQMk2RCYUheyst5av
         0P/w==
X-Gm-Message-State: AOJu0Yynlhle0MaRLCbk4IBWj56XAnSQzPTUB9WxUGMvUwewL3BJ9w81
	HnOQ6JVur9qdO3tDLG/ZXvcjV/kTyUQZloLTml6HC9ffa9D6O6x8JBGeEs5ZSH7z2AXoiSyJI+k
	h
X-Google-Smtp-Source: AGHT+IHV6GcT0ZlxVwOJXg0Ual5nGdbLtNVC5nbsMp0H0LtXetDeRRCyaF7vY1atbxezs6b6jxb9LA==
X-Received: by 2002:a17:907:7da0:b0:a79:8318:288f with SMTP id a640c23a62f3a-a839292df23mr147719766b.16.1723809166523;
        Fri, 16 Aug 2024 04:52:46 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d0232sm243186866b.83.2024.08.16.04.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:52:46 -0700 (PDT)
Message-ID: <ed22b013-cec1-49db-a64f-1c16f2920239@blackwall.org>
Date: Fri, 16 Aug 2024 14:52:45 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/4] bonding: fix xfrm offload bugs
To: netdev@vger.kernel.org
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, jv@jvosburgh.net,
 andy@greyhouse.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jarod@redhat.com, Hangbin Liu <liuhangbin@gmail.com>
References: <20240816114813.326645-1-razor@blackwall.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240816114813.326645-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 14:48, Nikolay Aleksandrov wrote:
> Hi,
> I noticed these problems while reviewing a bond xfrm patch recently.
> The fixes are straight-forward, please review carefully the last one
> because it has side-effects. This set has passed bond's selftests
> and my custom bond stress tests which crash without these fixes.
> 
> Note the first patch is not critical, but it simplifies the next fix.
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (4):
>   bonding: fix bond_ipsec_offload_ok return type
>   bonding: fix null pointer deref in bond_ipsec_offload_ok
>   bonding: fix xfrm real_dev null pointer dereference
>   bonding: fix xfrm state handling when clearing active slave
> 
>  drivers/net/bonding/bond_main.c    | 21 ++++++++-------------
>  drivers/net/bonding/bond_options.c |  2 +-
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 

Oops forgot to CC Hangbin, sorry about that (CCed).



