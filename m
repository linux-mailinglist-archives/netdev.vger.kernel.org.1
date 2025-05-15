Return-Path: <netdev+bounces-190711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2CEAB855D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD330188F644
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F2E2989AE;
	Thu, 15 May 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/TOaeMC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151729827F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310086; cv=none; b=XAd9KodEIBGxoIQ0t7Ma80KxBuQGrO9mQnKVVuncnK5jNggxRWNfKT638agjVITohUwC41REr9D3FMTmpyWUFd+2fc3IDJgBz58sypl/kN7rSy7mi/Upgnj1FMfQvPMee4CCB8P5pXAbKdTlmXFSAw48KK5qY8fXv39vwqK2m5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310086; c=relaxed/simple;
	bh=epsWvjWHu9kmVNTaRRd+qtpyAjbj5OYYAn55OL3IWmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yn9w/9cEIXUsraZ13NDTLuwJf5tphU4YFgcVJBEmRmhQC/qqHLx25Staj2w8bFbZ5rsYPFxfPomkIGq26d3h3Smq3FlLD6fYFoBYyVHD1AQ1k+/kxj9QOTEFs3I6hd2ZP+EM8Mwl3tVzFHVY1C0inVjKTzq9+WleUIh4C3W8m7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/TOaeMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747310083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=epsWvjWHu9kmVNTaRRd+qtpyAjbj5OYYAn55OL3IWmE=;
	b=T/TOaeMCrvwW1KNA9hYC0Upw+XBlGV4amypHiHgzBRyKmnNiFIMy8kDxpkG3e9qDvihWx8
	jNtJJljcY8uYNd6oFxvhzID8EFBQsk+Wp85TYpVygcYgYgeIUIudD3m98vVnMJHJ8+yoY4
	cdtNZ3oBQFP0DGHstGm8x1zOHo9/fAU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-5I7PTCo5NHWqhnjFh0Jjlw-1; Thu, 15 May 2025 07:54:42 -0400
X-MC-Unique: 5I7PTCo5NHWqhnjFh0Jjlw-1
X-Mimecast-MFC-AGG-ID: 5I7PTCo5NHWqhnjFh0Jjlw_1747310081
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-440667e7f92so4753325e9.3
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747310081; x=1747914881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epsWvjWHu9kmVNTaRRd+qtpyAjbj5OYYAn55OL3IWmE=;
        b=aG5IOleekvKDO1drBj3/z+UZuny1O1n1SBDUKnKEcIw+Ag4FnGkLmsdyzlUz8zxhMd
         49axUmVIGtMuCZdmkhHVt3Qbe0TczMK71zSrBpg2XrV8H3BoxUVZebp+HcPc1kxtzG+0
         zNq1+Xmt/7ahQakCvmguKM+f/bUEY5Le99eg7P91MswkOYJjdc477WXoEq+F0vWdkmCk
         qmR0FbKudjJ/FDRGhd/PvsJ99Vdy/wh+WcPzTMprU/0CAjlTmHfscIFgXiwPtgcuJWB3
         7oeIQGLi5yvlmb+ltxuakn818PZa5KlTMEjW1jIkIAsu+QQlsi/kbYFyC2GZpbM5s03k
         Nkyg==
X-Forwarded-Encrypted: i=1; AJvYcCX9GmdJ/3DSQ+91bPGf5ccwHWaIP538T6IQZ0YfHKdmy+DYsYbUqyKzPyqFTfVRAZpCp1YMXPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFRdUz0QCyvZgzD7cI0hcKYmM4JGUqPY9UY2cFkMY83ph7Hcxx
	x4sQ91rBp3fS7KhlOxHmibTiNyC6NmWAGA8lOQRuGAf5XVC+xtwRl/kSHYl7KkMbZkvUAsubRrj
	N8SkD+IQvTtqMOyu0M9nqIk6v14zhkPr2K6IeKJuHGlO08bu1fFeR2Q==
X-Gm-Gg: ASbGncuc0O4mP1OEGSFzFbtpKr34PtO1hLC4OSD+OvxJquBi+O7SMkm3dre+go5YKDy
	bd2JbIHOBzxNfxJyFJY/E8B58JQXlCtGDR30i5zWYpv+nSUZKVDpQeWv/QsBEyawc3gu2r+EFtd
	86zmIryWf0RUnYdCqhrY7iOoAibHyv8tGuHfqxqjvYhfyX/MLWJRbVHBaWj8xNQBL6+ynxsXPez
	LObVvZYbL+Ez3Iw4Sfy+ORJ/zlZd8MULRMO3h8sGffrFdnSs1aoUhy5IMOIhXa3CxrGAGgX8+3e
	uUB+M3XLwmLCsgu5O1ajvFzsOmEURG5CDHZG5AsHboreEZ4KkuCvc426vXw=
X-Received: by 2002:a05:600c:c059:20b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-442f285da04mr40196535e9.2.1747310081296;
        Thu, 15 May 2025 04:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF94kl59CRKh8KcTSkw1SAiKI6cImxvIQTZSHoUW1IK/I8r2VxJB89xu8sNKWWPqxAdRF3Xqw==
X-Received: by 2002:a05:600c:c059:20b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-442f285da04mr40196275e9.2.1747310080913;
        Thu, 15 May 2025 04:54:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3368e3fsm67978805e9.2.2025.05.15.04.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 04:54:40 -0700 (PDT)
Message-ID: <1b1f8131-80e6-4671-b4f2-4cadf426d4fd@redhat.com>
Date: Thu, 15 May 2025 13:54:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/5] eth: fbnic: Add devlink dev flash support
To: Lee Trager <lee@trager.us>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jacob Keller
 <jacob.e.keller@intel.com>, Mohsin Bashir <mohsin.bashr@gmail.com>,
 Sanman Pradhan <sanman.p211993@gmail.com>, Su Hui <suhui@nfschina.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250512190109.2475614-1-lee@trager.us>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250512190109.2475614-1-lee@trager.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 8:53 PM, Lee Trager wrote:
> fbnic supports updating firmware using signed PLDM images. PLDM images are
> written into the flash. Flashing does not interrupt the operation of the
> device.

Apparently the bot did not notice, but I applied the series a little
time ago, thanks!

Paolo


