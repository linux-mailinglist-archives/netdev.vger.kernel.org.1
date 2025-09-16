Return-Path: <netdev+bounces-223483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB51B594F4
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A24E109C
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C82773C3;
	Tue, 16 Sep 2025 11:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB5AOso9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE052D46B6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021548; cv=none; b=KSbwSjTQCjSW7ho5zH1pbDH7RdRbJjhsxcqAWFoZmbsjxTVj4PO63gSYSFUFvtQabPecI71/v5FMAT1wquYPfKx4NzZsiueaCWOZCba/m0IRWOawxf81Aba8DU2gVDnc3TuAwikCmNq3VuQmwAjnAafyVV03rx8R1+zmKRDo1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021548; c=relaxed/simple;
	bh=7KGYjWiXiKXmun7VUQ2f9X/YYk0LvCFcqp24eslylI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Awu02kVy27BGGXgXFrjeHCKGlHoo6+pxQi8FHr0vOATO5DFsBTwqC2RFZZ7WW9XFleIyv/I017333taIYPsrEcSX63FaMwsAOZBRmNjyGg18sTSXK5AS043p/VZ5AouFRpM4+xHU4Om6/qZw5amp8lHYjZ77VRPfCxWtn5+ufr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iB5AOso9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758021545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IS8n9uYlFFSXnUjoe1JWooB2+BzMcNeziCMro/A1XgI=;
	b=iB5AOso9O7pzjhujEc0M7FzTDvEfkCdcvwyhKHFmpKCLg1fqiAVzEli58zKB/BUv9xGvhA
	ymewJXrZ+MPBuJZ5IGkhZ+4OupygFTLYCwhdYNxt6IIt7iMBhab69utleiIfO9+oRg/BXC
	3owt799sIPFeEa1B7KmW6dY+IZ15hNc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-Ym8zl_SVPCeD5UVhhTCkfA-1; Tue, 16 Sep 2025 07:19:04 -0400
X-MC-Unique: Ym8zl_SVPCeD5UVhhTCkfA-1
X-Mimecast-MFC-AGG-ID: Ym8zl_SVPCeD5UVhhTCkfA_1758021543
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45f2a1660fcso21621625e9.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 04:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021543; x=1758626343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IS8n9uYlFFSXnUjoe1JWooB2+BzMcNeziCMro/A1XgI=;
        b=Tr+v9WBEfGSHr1GT3azEIbRspOcKAFHOzJ8eWJA1h4f4gkI/LkRWOs++wtfJxRkerF
         TdaI8YfHwvw0p9Tmxl1J1NKACePh4IWy/TT0/JQpPylOe4Msb83GbtrEIlEganszo4xt
         8M2Q5E5kdjHxB8K6jUuPMH3OlhkOWqqTN+NMOFjeSMuXGESWAXzpBl57KhhA/GAYdxNW
         +Mo4xiMo4knLFjj65PPCifRAEW6ohKIHmAkSc0czairgGoDC5LJNd3zY1M1JdEd0ZzRO
         KaMyUXM+SDUdphtt9uoycGHA/wvqj++aPRVNDNlwBktueYuXIkcMvSpaLxZ9wfKVmAVC
         uIDA==
X-Gm-Message-State: AOJu0YyiCIarp5u20ZyxyyCLTVGkVhQq6QqcEi+sBBNL2cqsbSytNS/A
	bBJlVCi9hXhZkGD9Bu2Z0ITtaDpSwN3QZuUjVR0k6whBrzZvOcc9M6wY7fAU0H9YXkiTuSQ3ihf
	K8MrgVq/BZt7OM+EyIgeuJ9NP4OiZaURS7VINoPgk/6uTyGDHOFE7lfVS5A==
X-Gm-Gg: ASbGncs1aHePdxTPP6AstfZe7jIp6AtqJhvaEVKiMv1xMZ1XVPagBhPBBFrOBhhDgnv
	EhO4ryO7/NElqPMUkVXh6+zy5HfpzgUU3G+i+L2WOF/5oghtRCVXO8PoP19StYmXHLp/GKEzw3f
	a5KhsYt6sS45N8P4H+Gxhcr2NOGEKifntZLCq2N1sp5Ah/mmDZg44lqZwR7G07hefpH99g6t36V
	6ODBS5LXDCjn6H5HleHNHDOYdLdEfBsEGJYFQIivZd5/TSI6BbPzC704DRJqcaiguJwPC8UadrT
	ZXIJUvUiBTPpBApqjGY8o/StTsoBLerdUspsMhvmv4q7qabNLN7XvK4x4ADray4XiYEWyV69E88
	aJwGbeMxUxBlr
X-Received: by 2002:a05:600c:4ec8:b0:45f:bef7:670b with SMTP id 5b1f17b1804b1-4603e312349mr9110565e9.3.1758021543212;
        Tue, 16 Sep 2025 04:19:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE592p4dJ/0uAmy16i9ETUMUp7PdewEIvfyZ+B9o+2zbED8kyKYWcYuCqElseMELYKid/5UpQ==
X-Received: by 2002:a05:600c:4ec8:b0:45f:bef7:670b with SMTP id 5b1f17b1804b1-4603e312349mr9110155e9.3.1758021542778;
        Tue, 16 Sep 2025 04:19:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f290d1512sm131091765e9.16.2025.09.16.04.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 04:19:02 -0700 (PDT)
Message-ID: <7effec89-1f94-4313-b68f-c653ee07a6b2@redhat.com>
Date: Tue, 16 Sep 2025 13:19:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 04/11] bnxt_en: Improve
 bnxt_hwrm_func_backing_store_cfg_v2()
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
 <20250915030505.1803478-5-michael.chan@broadcom.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250915030505.1803478-5-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 5:04 AM, Michael Chan wrote:
> Optimize the loop inside this function that sends the FW message
> to configure backing store memory for each instance of a memory
> type.  It uses 2 loop counters i and j, but both counters advance
> at the same time so we can eliminate one of them.

The above statement does not look correct.

> @@ -9128,20 +9128,20 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
>  	req->subtype_valid_cnt = ctxm->split_entry_cnt;
>  	for (i = 0, p = &req->split_entry_0; i < ctxm->split_entry_cnt; i++)
>  		p[i] = cpu_to_le32(ctxm->split[i]);
> -	for (i = 0, j = 0; j < n && !rc; i++) {
> +	for (i = 0; i < n && !rc; i++) {
>  		struct bnxt_ctx_pg_info *ctx_pg;
>  
>  		if (!(instance_bmap & (1 << i)))
>  			continue;
>  		req->instance = cpu_to_le16(i);
> -		ctx_pg = &ctxm->pg_info[j++];
> +		ctx_pg = &ctxm->pg_info[i];

`j` is incremented only for bit set in `instance_bmap`, AFAICS this does
not introduces functional changes only if `instance_bmap` has all the
bit set.

/P


