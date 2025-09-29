Return-Path: <netdev+bounces-227094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A1ABA8359
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EADA189BE79
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A211684B0;
	Mon, 29 Sep 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFQ8Q31n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE5635
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129357; cv=none; b=WA0Kd6+2HM5w+31TbtyQP/eaFCKjy+ds1BtmzTi+SBrQwWw70uy5q/i7nIa1R/QRFLbUr2D/UCElIdCPfLmlM6dTeVvHWABgOyskyAq5657k7DzmMl0ERwp5M6OGOb+jYj50750ZYDeoC6e4pKXh206qKArgl3qnxsJFD9PU1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129357; c=relaxed/simple;
	bh=CFa2o+Qi7bcL/SyPD0GyO6/ru0OqQo4csLh4goJ0HJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ3zH/kaNZd+fV1TrQSlGJOiULD8ApRJHoEyV86hWr4AiHxSFLyfXHpnvcVmq/P9V2H08lj/5iX9VS2G6sCEx3njqfNfCYxavjpb41dunyPv0DKywNdtZCg42o5RFM3bidiQNOBNr9XnfGgQTjdcx3xGnYa6gPrfcg1N3gqLixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFQ8Q31n; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57a59124323so4390757e87.2
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129354; x=1759734154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+idRAXHi7Bt2G/h4yU81t4RO8kpF2kCatHGuxrQQntI=;
        b=MFQ8Q31n17Uu3Crsw4B3wmMhprihatGi1DC7+6RUI4MLg3RbukZnlBLk612aSrM/VD
         L0w6BCE8lHELjdDRcNJ7N2O8TdLwbHmTCUqiH9I9KcCpq3D413Yb3c0O9dWJ/qIp9oVq
         5qjECDeuAjTNZji7bJpk3vAzn0JFcI3w8pVJW0BIJiXFQ5Zw3sfcPSYEvN4SgBKCFNwD
         8oS6/ut7sooBc1PlWXWc40B4jgTzJO7CNX2bA9wcMP6hK2bJR2QEEcByX1cUAV7catmI
         6KNxQrYxSuaUP3lzG1z/BRkSDQc6kYMGW/GSCncxJs+JbfPr9CUWygdcj3FQUHKp+QK9
         J+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129354; x=1759734154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+idRAXHi7Bt2G/h4yU81t4RO8kpF2kCatHGuxrQQntI=;
        b=t2T7dhSvdFSAnzaoZAJGC7FOSuZkmDg875ulAuX3zKz9uvB8EDs9icmjZKqGFeoHty
         7K1uhKbsQqNFoivkV904EZtQ8tNVVlL2XUtvSr85kXHb8/cSdXmVRy2Q01tOAfsMZO7Q
         0PtLjYNPiLkqPKgXuWSasP0K/psQNsS7hJ+Izy7/EFSQnU2XRnJdgyP+CCN6p+QzAoto
         nmaKeQhkT9OPXF7xm+DuklmH97YLGE6xp+397iltG4pR+Z4T8hB8eDThRL/ZV20cRVp3
         ZINk/tUuCWY+Q9DBaPrCV4Z2EJu1euMoOmaBjwYsT1wAAWg5RZEO8HMSSXbWZURDNJFp
         PBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8SFEBZbJ9oTLAWyYYFW5IAuUjeLy/8H0gF9RVl3CdFZQ+o8MKZgoIq0No23alhWeHQvdcoxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJxa1d0kFLNgfxCw63LXMsSERR7IhjdWcig5QEXzN6kdgHjsD
	3s6YnXoM0o6fZ8m1W4BnCb8aFSXwXG9JUA4x9mH7NAewz/BGepfGuv6i
X-Gm-Gg: ASbGncvcrbD0dR/mMczATZZMnaInwL4+TLgEhT1W3fSIXGsEb5SDosK6xNyIwjp5b+8
	AVS6DpNXUNOTd0i7hHxl/k9hKMLCLEYn6Qn3qHVkFSYE3ZSQblq3h6IE7o8NrhSl9kOknUT0EA7
	S12DW+YHaWouWz7sAGtEYyTK5zYV9zMQm5U1NsZMKdXovrZybE94p+Hor7hxO5p7KSS77fJFeq2
	nVnhVZFcDJdAgiHKSuaTHLV3J4Hflq8vGE+SVOMYjHk8Y7EAqtsgTlhGTpsO3uQLeYx2aWZf9Ge
	0SX4sHn6V575Uw6ZACgExQJ59F9yC8JJBSW9Lo2M+V5Q1ohvLN1gQMJyuILi5J+6gpkOyHNG0ym
	XnNjJ3KACd6tDyYdsiZX86WV/jc/oqy8WIFS6HSbduWghPUKZoQ==
X-Google-Smtp-Source: AGHT+IFPtrPQZPiy1ca2nxjQmwhnlaRMgJecjRwG32UKoNgKoyGvorgS/CknEXOO1FbjA770ZE+WNQ==
X-Received: by 2002:a05:6512:b1c:b0:57a:c67b:beda with SMTP id 2adb3069b0e04-582d12f13a9mr5332385e87.16.1759129353877;
        Mon, 29 Sep 2025 00:02:33 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58671254012sm1430460e87.62.2025.09.29.00.02.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 Sep 2025 00:02:32 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:02:29 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: yicongsrfy@163.com
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, marcan@marcan.st, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, yicong@kylinos.cn
Subject: Re: [PATCH v2 1/3] Revert "net: usb: ax88179_178a: Bind only to
 vendor-specific interface"
Message-ID: <20250929090229.2fa33931.michal.pecio@gmail.com>
In-Reply-To: <20250929053145.3113394-2-yicongsrfy@163.com>
References: <20250928212351.3b5828c2@kernel.org>
	<20250929053145.3113394-1-yicongsrfy@163.com>
	<20250929053145.3113394-2-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 13:31:43 +0800, yicongsrfy@163.com wrote:
> From: Yi Cong <yicong@kylinos.cn>
> 
> This reverts commit c67cc4315a8e605ec875bd3a1210a549e3562ddc.
> 
> Currently, in the Linux kernel, USB NIC with ASIX chips use the cdc_ncm
> driver.

Only those with a CDC configuration. Mine doesn't have any.

> However, this driver lacks functionality and performs worse than
> the vendor's proprietary driver.

Is this reason to revert a commit which prevents the vendor driver
binding to CDC or other unwanted interfaces?

The original commit assumed that the vendor driver will never need
to bind to them. What has changed?

Isn't it a regression?

Regards,
Michal

