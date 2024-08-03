Return-Path: <netdev+bounces-115497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0F946ACD
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4025F1F2119E
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9C17BD2;
	Sat,  3 Aug 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="phcVgSH2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7115E89
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709113; cv=none; b=ZXs+mGy4/hxuc1AQQfZ078sgS4k3J8l6e6bkQt+FnCsQKWkz8F3OJQIJepv3BwxBF26v0gqX3q30FVEjxge7PXcY71tN8i4k/i17ZM/ZHuTpEZk674e3Wibpp6ZZIgOj82q302LxbblvkUAW+ntnLjwDYyVy3ZRn+35XMVVcsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709113; c=relaxed/simple;
	bh=bQvTZmr/uykVnhZVM7v1V7Z5e/biSycFeJYtrfgQqeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDXBaM5PoG37iKMILErsrEUiUxYj1TJKYgFJmzGne3XPKGjrKyn9wIkJqX04OXzRtLzFM8VvarD5C0Ef60Q4yGAKHGRMWzx56/4XpmwWkUsZ9+ETWFcRCL8t93i8igZ3jpqIFKfPFpczNx6nBFp62JAb2yxzJ1OWz/JX7J2jUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=phcVgSH2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso4801018f8f.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722709110; x=1723313910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZS03gDzzwDpuuHIyXf/+fac47avntES7S+yK3X0TIs=;
        b=phcVgSH2KOkwXFsatNp6Q0ADLMS1eNuk24VZQfD7VJw0JW1+UmuvMvM+ovNcXxIFOf
         FuC+pFv31wJrgrhhgwM0dCPU3zxsE3L+RZM3t9fOFlmqN07nai36imKsgmBDgUUpnJKk
         4EidORM+B/V0EsAE6uB6GH0Wo2raU4cISt0V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722709110; x=1723313910;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZS03gDzzwDpuuHIyXf/+fac47avntES7S+yK3X0TIs=;
        b=qEWMMx4GhihbCPGLugBRyPAdq6iauIOiFX+c8NgQ1ocyzcMEOaMWAll9vIF3mnz92N
         NV+13xzrwxSSOVW0ktcW+iiPsJRa67JXQKaMIt3s5t3+lgeOafpMwNbN+KgHJDj4PlLu
         5phCJX05w9cv+amo4/ays7gfgmYdY8f1ENSwJxc3WfXirPTMO4vd+5rNcwd0lgiZjqVC
         PjWu8SHN/LKh29iLtYblFpHS4ZKN7xQA8N9pQiJFAO3qogHeuA5nBpjsiJO1oWwkoSf7
         rm3bKZbFhvy7eRdoMKUYHP5y3G4lb7c7DLRBWcTc8/GlvmTLAiAbXOWwFQg0HBpzILaM
         BhBw==
X-Forwarded-Encrypted: i=1; AJvYcCW7AqkaJeOWMZy4wkZ+dpujVbWLbcVUGTanyL4qkdieNYbblgp6VJ1jRIqGgcvVkLwfhmEao25bE5prFrk4/NQ/86Rce3Ui
X-Gm-Message-State: AOJu0YxRqGEwe0+yBBTWXk4c7AbRVDQhns7SAMQTuCAKfv0s8eB4Uw5r
	HaC6p9YflS69bSYglnWpvxVPceR8YEGj3iBJskSW4Cnx+HvHbRnFxQRx/Z0bXCI=
X-Google-Smtp-Source: AGHT+IGjI4UWkXCowWfslWJjcCGwswXREnZ0QJxjnuktNW/bA//TJdII44gIJpEiwYRpnurx1dJerA==
X-Received: by 2002:adf:cf0a:0:b0:367:991d:8b76 with SMTP id ffacd0b85a97d-36bbc0f3655mr3863302f8f.15.1722709109762;
        Sat, 03 Aug 2024 11:18:29 -0700 (PDT)
Received: from LQ3V64L9R2 ([2a04:4a43:869f:fd54:881:c465:d85d:e827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26f9c2sm4900448f8f.116.2024.08.03.11.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:18:29 -0700 (PDT)
Date: Sat, 3 Aug 2024 19:18:25 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 10/12] ethtool: rss: support skipping
 contexts during dump
Message-ID: <Zq50cbN7jFx9hHsR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-11-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803042624.970352-11-kuba@kernel.org>

On Fri, Aug 02, 2024 at 09:26:22PM -0700, Jakub Kicinski wrote:
> Applications may want to deal with dynamic RSS contexts only.
> So dumping context 0 will be counter-productive for them.
> Support starting the dump from a given context ID.
> 
> Alternative would be to implement a dump flag to skip just
> context 0, not sure which is better...

Neither am I.

While I personally like the idea of skipping an arbitrary number of
contexts when dumping them, I would guess that the vast majority of
use cases (maybe all?) will be to skip context 0.

