Return-Path: <netdev+bounces-99164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA68D3E47
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC5A285DAF
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C22215CD55;
	Wed, 29 May 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="f7fcRBJk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14519DDA1
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717007034; cv=none; b=jht76WIoPwu2aeV6kqCtti0bEAfH2Ae/iFMTHfWOKD76Ja7KI3qxT5Y/c+MjJ7rOh6wvar+3Vs+IZGXPqz0JZKy3jzajL+Rnc7xiQeJN8tGT5TvdurR0Y5BiOGrRT+yr8648Zq/1TmZRlfE4UrRJEVxLNhClPDYGoqBN0wJCDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717007034; c=relaxed/simple;
	bh=P1lQJCCWJB36JtINGvtohFfOKPNJ3aNeC8vHCVYHRpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQ8q7ZhfhK/TUD5iBa8qApqS4fafXSNEKPaFHZoKoUBo3DOkrzEnGYDsbsJc/2uWK65eU5nGXm+71N53i2cMvHDG5lHEPsq4xh0PXLwF0hAbh4K0HA7tNXdUAZVHM0w66gWvyuBQBKJ4Yn9WrZtHPcQkQghEJgHdESOQ4cCJ5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=f7fcRBJk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bff7b9503aso4888a91.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717007032; x=1717611832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1lQJCCWJB36JtINGvtohFfOKPNJ3aNeC8vHCVYHRpo=;
        b=f7fcRBJkOQ9IfDBoFW/KcqwcEI2BnNqzw8eSZFgIBcVA4R4rXB87rJ77a0IxH08dYV
         V2bWfrZBauAN0fDk9tpPNCOTnNjIlyY/BzlO1XjMmw2XWjbx4x0vf8BlB+XIpzp4p4td
         UYELid2htoBuoKaqfaXrTK8Xv57L//SJ+CzTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717007032; x=1717611832;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1lQJCCWJB36JtINGvtohFfOKPNJ3aNeC8vHCVYHRpo=;
        b=OJuXojE2pPO6eic5wspiyOiIlN7vmlGJX2uD4+nIvgKl7UBmfe1/yk9FbgnRx5Nbaq
         J3/I7wthJUvFfpYiw7+iP/GeJcx54ELxpioNPRec1mmHRvoyXRvRihULytlByZGgfkNl
         677tsBuZxt+M3WI53exu+7b3LC4FlYp/ci+ivUkqt7vd9BFAKopOoBGSMp59xKdoBBTL
         w3Bfcd0uNvl9IGOnvjosCdlxYiUwYgyzePknWkiuKJRWG6bXKVgtSMBDvklghrzh3u5h
         rSgQCnBDjJyORI3NfLK5w8buvLiQ0nf770J/DfX4etVowi0TFk2D4x0S/qaUosj/FDaM
         tqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfPUQ0YHRySSfbCs+A7vXA7lmZ6HexOfL8NusJadnohee49s7DdqqDIRpZ+IyaZeKOj5R1te14qhzxlA5cixoHXJPj3+Sq
X-Gm-Message-State: AOJu0YxL4akp41Q0klNGFvgnX2PpIdDUO+PZZBDrHq5M6/yacFR7BlGV
	w4K07nQscyJpX2OkoqGw830AzmYzy1KPNhTEP7hAOB3x7ipXtbH4Zy6sYASZ3xE=
X-Google-Smtp-Source: AGHT+IEBDluGc8h5PYa0B7js1vxoM5iBpn7Euleu/u6vRiePJYBD6TgQ12d0J+3qjJQMzF2lW1V9aQ==
X-Received: by 2002:a17:90a:c208:b0:2b4:3659:b3f5 with SMTP id 98e67ed59e1d1-2bf5f407deamr12951488a91.47.1717007032186;
        Wed, 29 May 2024 11:23:52 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7761d83sm79635a91.2.2024.05.29.11.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:23:51 -0700 (PDT)
Date: Wed, 29 May 2024 11:23:49 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
	amritha.nambiar@intel.com, hawk@kernel.org,
	sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: add qstat for csum complete
Message-ID: <ZldytYTJEU8yAJqA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, sdf@google.com, amritha.nambiar@intel.com,
	hawk@kernel.org, sridhar.samudrala@intel.com
References: <20240529163547.3693194-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529163547.3693194-1-kuba@kernel.org>

On Wed, May 29, 2024 at 09:35:47AM -0700, Jakub Kicinski wrote:
> Recent commit 0cfe71f45f42 ("netdev: add queue stats") added
> a lot of useful stats, but only those immediately needed by virtio.
> Presumably virtio does not support CHECKSUM_COMPLETE,
> so statistic for that form of checksumming wasn't included.
> Other drivers will definitely need it, in fact we expect it
> to be needed in net-next soon (mlx5). So let's add the definition
> of the counter for CHECKSUM_COMPLETE to uAPI in net already,
> so that the counters are in a more natural order (all subsequent
> counters have not been present in any released kernel, yet).

As you mentioned, the counters are not in any released kernel yet,
so adding it to the uAPI makes sense to me.

Are you planning to submit a separate change to add csum_complete to
struct netdev_queue_stats_rx, as well? Just wanted to double check,
but I assume that is a net-next thing.

Reviewed-by: Joe Damato <jdamato@fastly.com>

