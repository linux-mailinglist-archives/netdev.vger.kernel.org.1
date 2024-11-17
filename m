Return-Path: <netdev+bounces-145612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48F9D01DB
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 02:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79DFA1F229D4
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4D76FBF;
	Sun, 17 Nov 2024 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXGGadIb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C0F161
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 01:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731808419; cv=none; b=TYyN1922SEWcMomPUV2a+80nsw3e2E1Z+u60zwdnDqwDXfHHQlrZc1EpgOBRigQ7vxwEUBNzeq0/wmWBpH03vgcH9rYojJW4Az20fvfyiy+QQdnSGqilnEl490Feo6fN/E2Kyw5HQE4KziEst/3ug7E2ztgGaaD2aNRf+bp6frk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731808419; c=relaxed/simple;
	bh=tnoq5yJhGaiJyFjdRSuzDVq5/uXK8U6W/kO9J8icV0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSnhL/oWnmAGaFn0IGA7r1fb5NhZAou+4rFtVs3God/A+z967FCV1EkF8GcLiPDV325wkJoudqMRc8fQGTUKfnSU9+kzoA4SJs3R3dJZXZCTXO8G/KGSrCFBjQ4Epu8SXOOvy/pmMjaxKhPUe57yZa+sigkfAKrau6vDy0YM2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXGGadIb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2207569b3a.2
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 17:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731808417; x=1732413217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qE2rcyDPCh5EGDbRlck7t1LA0nBX+jv/M7kuWUzXvSI=;
        b=FXGGadIbSC83RKYUfw6NM8wL7WCGZ15+SxUwacg5qGchye+oyk0yXEVuTXYTOick9Q
         w/owGx+sk7gvNErlf3HBcxfTXfdEq87mYx89OQbP3d+aKlPnOYUQTYFPjJTedrOzixeS
         /xLZjL7/a0fmBZkWBy3Krins5tAWJyv4fpF1cOCYCPmBpBtfej8OMf3gmAyOLKSSPpcS
         419DDSjqhL3CdxyI2O0gbDsCESWgEkkEK3gDu2ikha/U7KGojnnkDQZrC0dbd8nlSVKm
         1BRMM2s045QQihdsRLkdrCRxzeZYvRw7ENeRWkz7FBxSCptMkhhybcUuJffUpmC4sI9q
         Fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731808417; x=1732413217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qE2rcyDPCh5EGDbRlck7t1LA0nBX+jv/M7kuWUzXvSI=;
        b=byUmawPY1XI4yw/tnzgThuiVHnIQdDcM4eGi4L57X8AL/zlngA68xJFnhH2ZKZWWdn
         Q1eVkl3CBbWl1F0/7q0Ja6Zz2gU0+LsspICGU7XACq10q8jfyrlbO80xfsKUNBd45L8n
         PYhhx6dkhRLSOPu8vaFlwJZCnw7fqfDr/lTEzseIbirx7qM1Fl6jazGaS7pjbEdnYTgt
         Ygpfj/7N27fvYIyeEqkCwNH7N9QXsMVbsgPgyuEm92Re5XSF/Mn4xsYeFos6kOGrthHX
         WGNWLQOXSkutFJJ+lI7dA8KGwK0pZueomLyz2lBlc+j12msGZL7bBv4lWowaVCpguF7e
         +Y/A==
X-Forwarded-Encrypted: i=1; AJvYcCXd/+jUTd6FxIYlphDtiFGH9/iEMorofLpM0jhtmjbONRyO+FO2m9cF3m2kOuPqquFwCqDBmXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQi5TM6YwepJZv5rzd7hL7v+Uk9RKX8hEygfJajbbkVLHdsl7
	lZvP3STZ7V/e394p1pCcH9+o8FqTPSuDg/amibGqH/REg42VKdbZ
X-Google-Smtp-Source: AGHT+IHjjPY/f/X+pVN1Fgz/9jSGwXu6xnLBt7fj36u20+8glhqnmLzyu5HUku/m/Ci+sE9RVng8kw==
X-Received: by 2002:a05:6a00:238f:b0:724:6cd2:cdcf with SMTP id d2e1a72fcca58-72476d5bfdamr10996511b3a.24.1731808417498;
        Sat, 16 Nov 2024 17:53:37 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247720120fsm3643027b3a.193.2024.11.16.17.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 17:53:30 -0800 (PST)
Date: Sat, 16 Nov 2024 17:53:26 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Message-ID: <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org>
References: <20241114095930.200-1-darinzon@amazon.com>
 <20241114095930.200-4-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114095930.200-4-darinzon@amazon.com>

On Thu, Nov 14, 2024 at 11:59:30AM +0200, David Arinzon wrote:

> +**phc_skp**         Number of skipped get time attempts (during block period).
> +**phc_err**         Number of failed get time attempts (entering into block state).

Just curious...  I understand that the HW can't support a very high
rate of gettime calls and that the driver will throttle them.

But why did you feel the need to document the throttling behavior in
such a overt way?  Are there user space programs out there calling
gettime excessively?

Thanks,
Richard

