Return-Path: <netdev+bounces-193566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA014AC4819
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773693A5968
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 06:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC421E3DF4;
	Tue, 27 May 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ach95SFY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A6119E96D
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 06:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748326139; cv=none; b=KSkO0z/IjA/a7r8AWNKWQt78s/ZfSOuPiLgidR+xJ2cTaqbgIqQyii24nLN4s2GvoLWefZDhT5t6I/FwFe5VlnB5P/NSJ6kU1vi9uYJfFuI7CBTZ2pe5DQlqhZ0YTIcn6JgnJZ3zYCkCwruPzbcTY5TrxeSinUOyJ86GnjBxMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748326139; c=relaxed/simple;
	bh=61jbQ6fa6Y3o4tynXM0JiWhjtIWbokyFgJb882cjQfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rf9tRkblBY1FhHacLHgNkuFjhS1YeSMsqzAdC6V/f88fKDi9JdITir2DLKAQbXJ2Is37NPHVZlGLpq2cAa4n5OFsBgzcltzvtNBeeYqMG3lgHSteXb3SOFF1wYO2ge2dXj7hPZLnV91asYqbjIjtDTtEluUpnTA3Y64/+tgbDWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ach95SFY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748326136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yr/iHE42lciAZJuWsNNhCZ1eCfByYTSyjML/1uGKARw=;
	b=Ach95SFYnS3eIkGgZIbMS6atkt736gFRaCxPhMDka9hikYMCPg8pIc/FcY5Y/AWxlxAvAR
	MnCdcI9BZkT4MCjaicMk0L8eF4AUFbf5HllTl9oUzey5OAH1vXMpzbuI+TXoVaH5tjdSsc
	HAen6N+/nJngO50VeB2VDIA/a9hZq0Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-EDuOqcqONYaGEja1Y4uZVw-1; Tue, 27 May 2025 02:08:55 -0400
X-MC-Unique: EDuOqcqONYaGEja1Y4uZVw-1
X-Mimecast-MFC-AGG-ID: EDuOqcqONYaGEja1Y4uZVw_1748326134
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-440667e7f92so15216515e9.3
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 23:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748326134; x=1748930934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr/iHE42lciAZJuWsNNhCZ1eCfByYTSyjML/1uGKARw=;
        b=ncNoEDrZloZOsUMAE52ONH9YsLv4BAUQ2qsKyKfOQzRMFTb7R60Gx3iboa1zFESkyR
         bVHG3z73nxno2rmavmK9GOqO38AbLf3kIp9wCT4mfRO25h/eD1ux3JU+SJhOmcYZdCop
         eTJehF51ouXQW4kSJZ2X0Y2UDOvcWZ0r0RfEt1AT1cixadeap9OttiAjD2nbeSF9wy4p
         LlCtbtbmEUoA3+ulT7AoarrPeb+CWgqYZJICN7Y/mgn1n2qwPmKATvzniHayc8s6E7db
         OSMHoTr5qLki3KqNyYcRlkStza6Nj9EL6V0PRCMPku2+q/EjitI1TIdQkDPSBfcMLgog
         DYlg==
X-Gm-Message-State: AOJu0YzMz0oj+VyP4D2nuVerth3q0FqI6gvwyJ5F1f74FB7IRrvl1Xq/
	x23GpB2q9MN3eeD7HRBOtBnp0coKsKo5YeC7gHR1doBWTMa1ik+v3RrjCtUlNocKbDqY1kEge/R
	+Lm8si4f1qYLtYoOS7ErJfKhwVkgfT6qFi3VThrsU1zaRM1PbdhiPjME0uzPASws3zw==
X-Gm-Gg: ASbGnctjfUfKp3JAiKYSfL/rbpkw47vPUNloymgAatIcsG1I2r9K2MVVSbdVN9cY4qj
	hGBdcl5SkO1tQU/ZhMh+jeSGKHuzSESBRmlSnfZAkMY3EERoeQdfRokrBJXNSAvjZnXWJMyxIG4
	4RrvZoWoBcRqv750rLZ3zCXjLhW5M5aWeDIqIzhwyUR0UVmm8tbJ/VWCPNWxd6e9dpnKeuieOc3
	XBDbD3qU5QCroprZ/qgx5kXtl0BalcfCK1vRYG3ZIiKLHGACeLd9m2ZItVz1ebxfgOR/UGyoeuZ
	imNRGUcTASB0zV6KNuUG2V+eubOlXOJIIGW1QrHWCTwhFGN+FyCZ33qGSiI=
X-Received: by 2002:a05:600c:8012:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-44c92d3516cmr97440695e9.22.1748326133815;
        Mon, 26 May 2025 23:08:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtEENZYkJ7PmbK5PzUATkfuQAjGiCkwpYW0D71exXRVvHMfIITt9n4VT6TFIbYDLgAOtnPFg==
X-Received: by 2002:a05:600c:8012:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-44c92d3516cmr97440385e9.22.1748326133458;
        Mon, 26 May 2025 23:08:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062fcsm253027875e9.15.2025.05.26.23.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 23:08:52 -0700 (PDT)
Message-ID: <10a15ca4-ff93-4e62-9953-cbd3ba2c3f53@redhat.com>
Date: Tue, 27 May 2025 08:08:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: sysfs: Implement is_visible for
 phys_(port_id, port_name, switch_id)
To: Yajun Deng <yajun.deng@linux.dev>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250521140824.3523-1-yajun.deng@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521140824.3523-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 4:08 PM, Yajun Deng wrote:
> phys_port_id_show, phys_port_name_show and phys_switch_id_show would
> return -EOPNOTSUPP if the netdev didn't implement the corresponding
> method.
> 
> There is no point in creating these files if they are unsupported.
> 
> Put these attributes in netdev_phys_group and implement the is_visible
> method. make phys_(port_id, port_name, switch_id) invisible if the netdev
> dosen't implement the corresponding method.
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

I fear that some orchestration infra depends on the files existence -
i.e. scripts don't tolerate the files absence, deal only with I/O errors
after open.

It feel a bit too dangerous to merge a change that could break
user-space this late. Let's defer it to the beginning of the next cycle.

Paolo


