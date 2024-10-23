Return-Path: <netdev+bounces-138200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD449AC963
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C0F1F21D80
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B0A1A7268;
	Wed, 23 Oct 2024 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFNkLmX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688049652;
	Wed, 23 Oct 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684072; cv=none; b=PU7aKLnf5MLq46Ff0PSAOJ/qkO7KjS01uWvQ9Jj2Lrm+ixvHFHdQYGHJ9e4gqwqGhbGe0xhqP0/4KDW+2TG6fLlIKkt1y/OLl+9PO9ZeHDCRadw/5cuJpxOBBlxiRjX65ii0ILSKo7rLduUIOOIbY+aP9JZa7MWC82aEtIzking=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684072; c=relaxed/simple;
	bh=0deRHzznx+iZr4akU3z18BynQFkdx/WcuNnlD5UetYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2ioagotfa4or2L5BGJo6cO3oEe6QVA6G9N4iufG7oad2VTWsjCjPwwV6IiAm4/62w75IcxI8Qi1FQV2JX60VdTcQhyx5Td7dCsl71swR8JhyG3M45qbo87rgDcfE+dBrel/7Kq24ZZ2p20RNXymAi6KpclPJR148NKYHML9B1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hFNkLmX6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43158124a54so9204105e9.3;
        Wed, 23 Oct 2024 04:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729684069; x=1730288869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OgbVi/i2e2FmnWnQxf8m0K4GdKARclUd2e4HuJyv40I=;
        b=hFNkLmX66luB2D0E7SG+77I5jVOqUGqI2ar5CCenjdK/aIYagLGxKQe5ZJ3YboBjmu
         ShNv8Q3L3yc6xgz7CB71tTUQFFnSwrYrGZcmoUOXWlHqhi7YDBpdsedEwrI5QToPo0Ca
         GHO53xuo6zZ2JF55zPx/waO1qntXSL1sy5SYaR2IPLo2qcC6oN6VJlssyJC+3LMiAGYI
         dYfoK0M8Fp40RiUFakkOyyjh82VnTEeIdID4eWTNv3My75Sa0yKWiYWkPx4JVHDFz6cQ
         PEygobIFBFx7Q9BLwYgI0+z843zRksFgdMGKIRJPl3RTBAh/sy8QkSm1Y/FVOi5uHZ8Q
         I6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729684069; x=1730288869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgbVi/i2e2FmnWnQxf8m0K4GdKARclUd2e4HuJyv40I=;
        b=uKJZC3dKZdz8IdJHBnL3tPQeZegJ9SbcPCRhI8BSVT5aZa6YoFl3jxz0MlS2nG4dxN
         Ys01bRxQ5GBRdKTuLEHethzrxoq6g0JFBBzAy1J74Ce3MYwB68BoiHaKp/V9SFYEctX+
         3ex7j6B/bDd9ajlZKyebazLkUMuMijt0ajS4zoH5EbXCK3jlCvfaiMskZvEblASQriy6
         eoazTnTApjdSfoJOtAYPaXNy63XbvTLg/3OffCLAWyODaN76+A0hdLw1tVq8SAD2KZ87
         0NdV9UMXV2owJ/8dSM5QD35Wux5AAaHKJZ4fX4IFWpVQkUNxGEBScLOhd7sDftqtGEu4
         J8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQr/WqNBobjlln2RBLDCOUQWsZ9rnIEgJwku9EnYDewNZHZDE42EtlxYmzz9zOMF7GDysHsHG59IkMfYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3KZT08r4lEzYUerMnfrvjHAezVgybPh1Kvq72xUn7/FUSmxw
	BUVHfHd8CUUoKpsTp4PPmkx/KuKzA4oN2nCpeaHuPPgqkLZvalTO
X-Google-Smtp-Source: AGHT+IFsl0LMOEc+eE6a6V7EEbrOWyNMM3oYwN8FcBYWoU6umXyuPcwsTMJnCTtKZSWtjLAMEmlNCA==
X-Received: by 2002:a05:600c:4507:b0:431:4e73:a515 with SMTP id 5b1f17b1804b1-43184144103mr9125455e9.3.1729684068910;
        Wed, 23 Oct 2024 04:47:48 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a48882sm8692867f8f.30.2024.10.23.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 04:47:48 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:47:45 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v3 1/6] net: stmmac: Introduce separate files
 for FPE implementation
Message-ID: <20241023114745.kxntjsjgzzaf4lvz@skbuf>
References: <cover.1729663066.git.0x1207@gmail.com>
 <cover.1729663066.git.0x1207@gmail.com>
 <49e20bbc94227cc4368dba01016df40dc711ad0a.1729663066.git.0x1207@gmail.com>
 <49e20bbc94227cc4368dba01016df40dc711ad0a.1729663066.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e20bbc94227cc4368dba01016df40dc711ad0a.1729663066.git.0x1207@gmail.com>
 <49e20bbc94227cc4368dba01016df40dc711ad0a.1729663066.git.0x1207@gmail.com>

On Wed, Oct 23, 2024 at 03:05:21PM +0800, Furong Xu wrote:
> By moving FPE related code info separate files, FPE implementation
> becomes a separate module initially.
> No functional change intended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

