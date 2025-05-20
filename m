Return-Path: <netdev+bounces-191881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8067DABD918
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10BC3B5B77
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B939A233713;
	Tue, 20 May 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G73Rzmqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40236233158;
	Tue, 20 May 2025 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747746934; cv=none; b=mF98z6MT3plRcASAgiPQe2EsR4rVAbhJzFtQ7yE3Qk6HJjp7m31OM9hnTPlFEhjXhKSpRAhGHzSSoqjswe0KKAcJVbf279h2WjljTP5+fHLFSCoDjarAjN74TLzSTLdhG6G3JmiID7qqIIfpVJWdrn5LB7nHAhT7EY+QWlUX+RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747746934; c=relaxed/simple;
	bh=eGBVGsNUyL/zdctIeW6YFnpPx4Mvwnhao4BWU/2HB74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adqz6Ghphqf/8fBOfUIHnaqVuWXZkgX7qVnOitP2OrU6AT1tHIvAXyv6y0FexFNakvWMCMpJH+8s1IzXcYFZu/iGVRmEeNai6ALzTiwgt1YUOeAlu4II45jxIHMktHspPUlZSb9zlP8UEZD4Nr1Mt3wjRj4uF8cJGdRDYUldubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G73Rzmqv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30ea8b7c5c2so2960579a91.3;
        Tue, 20 May 2025 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747746932; x=1748351732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2slTZBYuy532hRPOCHbFViHDs6iyGn7xyCftK4p+0VQ=;
        b=G73Rzmqv5vTOnsiBovWPhekc6sIfC8kJjn53YjqeLt+iMEXDI5zuf4QV5EeMl1Vxtt
         EwG4BxZwI8irAZef4lCO6ijfZNngizGGo4F0ORkkkWsJxEfADZ7ygFgf0QGx1SClW5Fn
         CKwckY76KiHHH0wbWtuCbQ7WCdg5YnaKHYHueerqd5oeHqVDw5gjbrlHqlpJGqNsccT7
         U7lPzQWWsChcsgYWdo2qPA3knu92wytZObG2M+LMkkZa9lfRQL70vF54jw4RECR+y0OF
         3ZZsIfXuMkE9Mgnu6ELyGjM+jMBnxZ0lFQakYrLdKGxaWJ9qtEsuWJCv426weNkZZh3i
         nrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747746932; x=1748351732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2slTZBYuy532hRPOCHbFViHDs6iyGn7xyCftK4p+0VQ=;
        b=SSaKhMbVAFLq2jLc2z7wFljYT/GR7x907pS3Q+TPt+RcxSNXUUDFms7yb3G1aCgSEU
         5UKiMCkVsAUq4Sh0ENMw/kh7YnJ0jodlsWSjX0eoPQfcy94GmZqXoVSaIByv3EJ7Xidg
         HCcfyMcYpoJTsnY5jYPJPxRhczktYmn2kd7nW7BV9eOQIx2EVmlOdGmBjtKr27XUjleS
         /YIF8V+pGtzhqheQ7moO+hwgWClgRL8M8sVfz/ErzJ7nh8B2pJb5DskMyb+DkY74kBCT
         KS8Dpks9Ms4dnHRaW+87Y/6l1cYOb9lyQHcQUsahqVcsyc9k6wVWObnYGoYGcgf7RELr
         rrwg==
X-Forwarded-Encrypted: i=1; AJvYcCXP6ziOk0KtUwytefoL2oF1/4TluzXq3xHNVuwK7xzHCE584vUNxudDypSMkraLUOHZFhIvi4+X@vger.kernel.org, AJvYcCXyciNA9rulv33jFCZNShFJPR/CKWDyC51GC8u6VEfPwvhvEdaBuuhqcwjbJoS/7zRiXj2r3dtPOIaHX3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZ38dBv0+cnkM4KlaqNLExZCFs3sLi9JX2l5W5Aggx25Fd/Ar
	tSa2719cJtWFUqpWtENu2Q5+X0tQzcbG5xfaDiUrhmSC0t1VwrT1t08e
X-Gm-Gg: ASbGncuUA9OhtEi5sYZI/3tskwI4SEMciEB+nKeHC8GOTkuVbhb1zJJHXNAMDx5AiG6
	LZfnUYpdIbCveVc5t1gaejvC/IOqynVlgJC71KAjXRFxq5rKsTlhOQFA5oG8mAnL65/chCAHunh
	JR1pmBpKJy+1nWkRdO3k35CZ7bLD8N8ru8xSprg1iC7gd3v3ihik1X4C2cImxK+rYiIKrvzb8Kc
	9V/ZBDfhNdCx1J8eXS2aYBgXdk4XLld2DX4QMiIfcMIkDAmyegr4XfNdAU/oBbCCsnpA52PRzsz
	1uuq1zK2FqdNer+LaWa6wVXDztEjz26fXFgGYp/yqhTAbXLBMK2a7Pg0Z9xYbRr9N7sIGyc=
X-Google-Smtp-Source: AGHT+IEJtNiwcn3oWwFHyZWV7+40ijEV4xe+dL0OmaEu4W0lh00EsRAe8w98Fc2a3NU9eTRdHK1liA==
X-Received: by 2002:a17:90b:17cb:b0:30e:9349:2da3 with SMTP id 98e67ed59e1d1-30e93493205mr19147311a91.3.1747746932238;
        Tue, 20 May 2025 06:15:32 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365c4f84sm1759071a91.14.2025.05.20.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 06:15:31 -0700 (PDT)
Date: Tue, 20 May 2025 06:15:29 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, yangbo.lu@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: remove ptp->n_vclocks check logic in
 ptp_vclock_in_use()
Message-ID: <aCyAcbNqKRlPnadx@hoboy.vegasvil.org>
References: <20250519153735.66940-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519153735.66940-1-aha310510@gmail.com>

On Tue, May 20, 2025 at 12:37:35AM +0900, Jeongjun Park wrote:

> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index 35a5994bf64f..0ae9f074fc52 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -412,9 +412,8 @@ static int unregister_vclock(struct device *dev, void *data)
>  
>  int ptp_clock_unregister(struct ptp_clock *ptp)
>  {
> -	if (ptp_vclock_in_use(ptp)) {
> +	if (ptp_vclock_in_use(ptp))
>  		device_for_each_child(&ptp->dev, NULL, unregister_vclock);
> -	}
>  
>  	ptp->defunct = 1;
>  	wake_up_interruptible(&ptp->tsev_wq);

This hunk is not related to the subject of the patch.  Please remove it.

Thanks,
Richard


