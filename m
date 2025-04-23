Return-Path: <netdev+bounces-184947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CBA97C39
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07F117D8B3
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5174262801;
	Wed, 23 Apr 2025 01:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PLbjG1Ev"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562EE1F1927
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372660; cv=none; b=l9DqJ54h3nzzIjT/07i+EpY0zuVYkZ8toQImI0wsOXuZCO1K5o9sL6IO/8rrqu8LNBd1scR11Gb4nnSlB2cMmxW5pWFsL03Xj97z4lWicMjsEWPV4WianM4VEMq8oLB1JoogJc8PdAtcqtDW9Z7000FQSTzQPo9WE3CeeFW42zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372660; c=relaxed/simple;
	bh=k7xhLka69j7sTzhJDUUiZMNXk9ru9y9Wyn49mdryqfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhtZHTrQlsKo4pz4of+2HW2Cv5bqdlR/VVm4wR7fjgASpbXQJ1mJA7EN1Wfz9i5lL0k7RXFJij5njG8XxfmxNmG1g9j2rV3PIYdK5gDI3V6hdPhqlZJYXG+32iDkYN8WgmzMeQyuZpg8lsWbigFAUBqFBwAT7zvPWOu0ct1y/mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PLbjG1Ev; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7398d65476eso388367b3a.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745372658; x=1745977458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbEA40JiWe2vQnJH+i6oSJcxA4t53eWL9N2doPzGsO4=;
        b=PLbjG1EvSqSgQEeKktpHkHjWqhhvtaHSIVU6ido9rZttrIJUyWQmr5JTQf+YK1dR9/
         aatYZaphJnzeDAeSKphzoAe1fxoOmWzEMgZDAjyatvO33EJiRk4ee6kPwvEKdQFD1Rgu
         5ZDKDupSSPRmrNS18yHIC+ue6UchQECRbWK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745372658; x=1745977458;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kbEA40JiWe2vQnJH+i6oSJcxA4t53eWL9N2doPzGsO4=;
        b=S4ZYYAROCP0sL8jyhODFQcvK/8VihHZkV9plgL/zsugkiiMWYq6cyIBOE76H752zcV
         eXUzMyOXpnEtuln/aPF+XCavHHqLo52l8rDdQh+iTX8HIjstV7qVAHWp/l9zn230KHwU
         cftxfCaPFBx7Caz4g3zLklY2uxT/h0MzlL2UCCMIiyR9vBWPSu+iGro5xdASwwepjyZ9
         gXSiQ3S+lZMS9O3+WdkDnSRGisCPXo3qz9wtTFLQNcWs9IT/IfKpvQ7D5bZRHsPjeCzq
         238G2lfKKis2+/siwkVV7Gxkmjr45ebocQymIJl5HsFRUQZWd8qJiOFQaMJvcx1e00sJ
         0u5Q==
X-Gm-Message-State: AOJu0Yxdovk/qMiStZgBcac4n+5J6goTXCbwXAO2RNLhO2JuuLgCBBlv
	jYkZcMtz6Gw2Wv99B3MelgkfqYhMC8x4yxWklZBuJEQ1lxoJA+VtPIZ64L/EYsg=
X-Gm-Gg: ASbGncvWaQ1dAQLZWoIF13un+K9S6jPiTJqpI/MYBW98VZ/gbTUfATFo2Am7Favr7rV
	ZOwHMGTrEDoqXPSHh5HTk15T2scyaOvTPUSjyBUVg66P91u6rG8MseLdfcYPo88y24CZff1y9nb
	CqG3rG5pG14sULcKHcRum9PHX8FdW2GLNxqc4cYO9TPm+JpAgsLS10QmZVGOHQi//gKluvIyi0B
	TQ3H63ch/HZxMYiulABfT8pVItCoXuBkOt1elD+RwZG/y9hBKpO+9FQGhpQybbbUW/Q0zmSZSTV
	bblN3qVLomDB2Lz1QMTZjKa4V0qamMut5lhZ2ZYfGmC7V7xHEsorqx9SRTA8VZYClUG7wZij6KP
	iUNaIpfE=
X-Google-Smtp-Source: AGHT+IFva546HHvH4CG42JDJiYADC+hOqNU2QGJEhgjEEKXmiz8fBGmZo6uhAfd4IeYT66Mzc5QfLQ==
X-Received: by 2002:a05:6a00:244e:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-73e135a5f1fmr1603978b3a.6.1745372658539;
        Tue, 22 Apr 2025 18:44:18 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaf4c2sm9322873b3a.152.2025.04.22.18.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:44:18 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:44:14 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	Jeff Rogers <jefrogers@google.com>
Subject: Re: [PATCH net-next 2/6] gve: Add adminq command to report nic
 timestamp
Message-ID: <aAhF7tvKPwvcZ5h1@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org,
	Jeff Rogers <jefrogers@google.com>
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-3-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-3-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:50PM +0000, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> This patch adds an adminq command to read NIC's hardware clock. The
> driver allocates dma memory and passes that dma memory address to the
> device. The device then writes the clock to the given address.
> 
> Co-developed-by: Jeff Rogers <jefrogers@google.com>
> Signed-off-by: Jeff Rogers <jefrogers@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h         |  1 +
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 20 +++++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_adminq.h  | 17 ++++++++++++++++
>  drivers/net/ethernet/google/gve/gve_ethtool.c |  3 ++-
>  4 files changed, 40 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

