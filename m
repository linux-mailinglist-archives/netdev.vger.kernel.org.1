Return-Path: <netdev+bounces-102256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4360C90219F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CD01F22F12
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4D7E766;
	Mon, 10 Jun 2024 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZaLsfXp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF27EDB
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022536; cv=none; b=lXmfI44pbM+zoTuSCXksLzXPlGS+RrZMJjyAlhOCS8Jlofq1R8Jrrg67kH5k65ujrC0MQowYflwDvNtzclXl68C278qmjsT34jUZW5tltZwvO4c5OhIyuecdJTlgq4gFbtOhSsDTG8Iyj3BcNWw1o2ZwiyjeEfpz47/iod4d3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022536; c=relaxed/simple;
	bh=UgM1kWUwZFS9ln9/V87GHBksz+HXr+yWVSscoTlkZN4=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HMHQrWQzAX+kgUQy1KaZFN1LI7pUAc7XpCPzD3pZJncC8wS8fjeqHAZtJARSuK7mtwSQ++jhaUiRNY/UEVS/H4ZG6eXdDllLCAXdpvHQUrBMkShPRD/nVq++7DlofxJnQW7x8gPnwcaPRZDW2/yTniZuzXVUjaI1458m5mM3xYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZaLsfXp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2c2cb6750fcso440369a91.1
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718022534; x=1718627334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5d2KLwaUnI1XirEuSpaMuJx5xfVXW5v4mfbHgauMrco=;
        b=GZaLsfXpGMfjioYEl6vM5Q3rX6kXzFLYfBl7yohhk7LW18YhV0gEHg2Ruw5i3W8rTt
         VVPU84WASH5xKUnrBeUpEvvEa/WUbBx+4jtSBp2NVpXqNArwbbzXtCUEccAHi0BuINHH
         7H79AxkZ1C9yTiXPPUMBJIQ2XX//r496pUwPHZphSD6xIUWvBFetTXTuHCxmwZcxF6QR
         fflVSsEHplcq+VGHDNb8g6PA152dxGTf43m4BdVa/rs2S3bx9uj1dSlKhepFoeQrP52s
         wzkheWpE2vEOugu80liPvNOcqoTDvKgaj5Tg7d1SxACdqjAQPPQCc8cI0zPXPmeIm7RN
         q6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718022534; x=1718627334;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5d2KLwaUnI1XirEuSpaMuJx5xfVXW5v4mfbHgauMrco=;
        b=Ub2ECYhezyj2S1D/tyrUOnLo6fB1DmFw06idh4xTL5+URLHhWudFWN6JVF+N+T4ish
         U3YMM1PWPinTd/5GMzNQzyhlfpYjAlvqZH4OrRXZSJY80OJ9d++cHtgXaMx8UgHRc/ea
         mEreor+KX6UxWLTxVJLm61QtXjieNTB4R7uqQqGzyd8VXV2HuXcFPAHfVQ3DZZom32z/
         s37Dza5hhcTkj/OPyn+V0f4KAtuPoNUikErMxRWtuv73QqwLsRueCDP3oJ9F9E6E8OCj
         hBN/Bi73SzmVoGBHn12c5W528DghIv9gRnjUC1KKOYmghzMby+FY9c+EoeaKgLfyf0zl
         h/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKz5yana29bINESNPTB7Bn1LwtNet7O2dCguvbTt94BlJpsIABSwaMh5M6DUFK88KjiLL0GLUuENWy3oWchF3k8DT0xyUx
X-Gm-Message-State: AOJu0YyrGpM+Q/FNzP6LHKw6jbtChrjSBhLSNsXu8EwYw3fSRhkr+pqy
	RQkPCE2XirLzD8Qbf7tcTC137oT4iC7ZpCIFRuGx7wvsd+DYYp3u
X-Google-Smtp-Source: AGHT+IEno3UyoLjgGFxRIgGPVupQPdjJ1mvTmjg/CgzA/rbVSSEBmx2r0f/YoKIfmlGh2AJQ1da8Lw==
X-Received: by 2002:a17:90a:5ae1:b0:2c2:c352:5273 with SMTP id 98e67ed59e1d1-2c2c35254fdmr8019169a91.2.1718022534243;
        Mon, 10 Jun 2024 05:28:54 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c3069c8ffbsm2297086a91.27.2024.06.10.05.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:28:53 -0700 (PDT)
Date: Mon, 10 Jun 2024 21:28:39 +0900 (JST)
Message-Id: <20240610.212839.896328411710328360.fujita.tomonori@gmail.com>
To: linux@armlinux.org.uk
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 4/6] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZmbObG9lRO8w0FkJ@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<20240605232608.65471-5-fujita.tomonori@gmail.com>
	<ZmbObG9lRO8w0FkJ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 10:59:08 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Jun 06, 2024 at 08:26:06AM +0900, FUJITA Tomonori wrote:
>> +static int tn40_rxdb_alloc_elem(struct tn40_rxdb *db)
>> +{
>> +	return db->stack[--(db->top)];
> 
> Parens are unnecessary here.

I'll fix.

>> +static void tn40_rxdb_free_elem(struct tn40_rxdb *db, unsigned int n)
>> +{
>> +	db->stack[(db->top)++] = n;
> 
> Same here.

I'll fix.

>> +	dno = tn40_rxdb_available(db) - 1;
>> +	i = dno;
>> +	while (i > 0) {
>> +		page = page_pool_dev_alloc_pages(priv->page_pool);
>> +		if (!page)
>> +			break;
>> +
>> +		idx = tn40_rxdb_alloc_elem(db);
>> +		tn40_set_rx_desc(priv, idx, page_pool_get_dma_addr(page));
>> +		dm = tn40_rxdb_addr_elem(db, idx);
>> +		dm->page = page;
>> +
>> +		i--;
>> +	}
> 
> While reviewing the rxdb stack, I came across this - this while() loop
> is an open-coded for() loop:
> 
> 	for (i = dno; i > 0; i--) {
> 		page = page_pool_dev_alloc_pages(priv->page_pool);
> 		...
> 		dm->page = page;
> 	}
> 
> Is there any reason not to use a for() loop here?

The while() loop here came from the original vendor code. Surely,
for() loop here is more readable. I'll change.

>>+struct tn40_rxdb {
>> +	int *stack;
>> +	struct tn40_rx_map *elems;
>> +	int nelem;
>> +	int top;
> 
> I assume neither of these should ever be negative, so should these be
> "unsigned int" ?

Yes, unsigned int is more appropriate for nelem and top. stack also
better to be unsigned int*, I think.


Thanks!

