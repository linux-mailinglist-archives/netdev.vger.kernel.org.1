Return-Path: <netdev+bounces-136695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B39A2A9A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E232E1F21D8E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27271DF987;
	Thu, 17 Oct 2024 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET0sK9qG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B41DE2BB;
	Thu, 17 Oct 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185538; cv=none; b=W8xlvzNSYmR1QAuPeT8Dc7Hi4aiRJ9UGTP9mBndlXRBh5McCnh7RatN4Fr8NOTE0bim+5EVknQRrVMyFl5/Sw+G5IinovnabpEVkhqhzmOi7yRS+I50Nj6x/nYsdI+uJzJXctzgInlnkS0j9vULbKUSNJoIdOSzwkYIw1F7V/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185538; c=relaxed/simple;
	bh=KBXxLES1UKH5uA9AJvbfpuAaNETf6INZbjudXTT6Dio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN7Lff+gAjUw9alj4qrReeh2CvT0MVvG59Hint9XHk94sUgHPH2ZVytEU3VaUcDqpZppY2RuAlpYabMfD+ridp2rnXdntvqHrDyBYCGIqDGYWlrhsiAFkkujeaM3O74CRn7wohMK2SJq44RffYHiGhW2DiEfFmauqqRGi//m8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET0sK9qG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1476275e9.1;
        Thu, 17 Oct 2024 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729185535; x=1729790335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruAjioQ9k7jbFZfBIq4ftH/WHh/CcrYyuu9X+EyIj3A=;
        b=ET0sK9qG21FA2L3NPn56rEMNZc4IkqZ9LxgsWwzH9b1dje8MDVSvL47Ls05BaNMI7o
         5HncNcwc9o2DmOIaVwesmrFlYOJq2yT3tBM+iMCSrZvPijP17O2QA/97K5glpew+0eaU
         piPOIcCRpTPZ0NqCBH+sjZVZvyK33qV9KRGnRrcjaZr5dN9feqCsh58f3WJousaPbLTc
         XxE4ZaMLOC99f/nDpa2YXmxiAYNte6m9l7IAF4reJ09ap41M6YPRvZUZJoOkVfzM61Lm
         egQr+HB0CByuF41+NVeiLTB42djvXAqKavoGWgUiWyNlMuaFVMtsWzTLOoBpQCy98Upa
         KDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729185535; x=1729790335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruAjioQ9k7jbFZfBIq4ftH/WHh/CcrYyuu9X+EyIj3A=;
        b=ZBMt2EbySixHhCLDHYqJ1gjabP/xaN0E8szQSNcHmm6vEgY9j9dT5hdNN2HbeB6TEJ
         djraPZ1CupKsV+x+5GDJTcgSV4fL4z/Nx2Km5lTl5eeiraE0PGdu2aJFbQf8edxvILWr
         2kq7zZyWDUkHHYuaGYT+a4TT453U3GNBcV69CBpNIRHS0yLHSQdbrFOU3VNUTf7fpqV0
         8MWZ9gHKvOTkwa7cTaWoN6o1AA/2a2T/rE4UGEzmxKnuYQB+vLd6kBO6KWM7aL2Wwv3h
         bjC/GLhdA9/VlyiO8rPks5IsAemKeDQkWAOeAueVza0/vQmd5uEuBNayTZD8EN6XQ1bl
         bF5A==
X-Forwarded-Encrypted: i=1; AJvYcCX21wyHDJ4M6CdMK7ilyjNP4ahZaU5vloIhGbOfXiwQMYdwTGZVNEoP/5DslIJnrpXnlkIfcaYGQuy/4X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX/FZRMj2lXMJFk2ogT/XfhbIQr+6BR1TLYgOBa+kLEmmLBySA
	SZJKBIxnqH40/BQiMb6qcXW5W9vWfIVZIw7QHc1zH8+CeqaMQkCF
X-Google-Smtp-Source: AGHT+IE9Eb/5bNteKLsSum3xN8R6ddBqz1cPduAZYwClja5hPYbrIk6zbmBICf6aIECSo0fli7nLvQ==
X-Received: by 2002:a05:600c:4e8d:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-43160ac6141mr11155e9.8.1729185535159;
        Thu, 17 Oct 2024 10:18:55 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160682d0dsm1694105e9.8.2024.10.17.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 10:18:54 -0700 (PDT)
Date: Thu, 17 Oct 2024 20:18:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 4/5] net: stmmac: xgmac: Rename XGMAC_RQ to
 XGMAC_FPRQ
Message-ID: <20241017171852.fwomny3wedypybhx@skbuf>
References: <cover.1728980110.git.0x1207@gmail.com>
 <cover.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>
 <4557515b4df0ebe7fb8c1fd8b3725386bf77d1a4.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:25PM +0800, Furong Xu wrote:
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> index 917796293c26..c66fa6040672 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
> @@ -84,8 +84,8 @@
>  #define XGMAC_MCBCQEN			BIT(15)
>  #define XGMAC_MCBCQ			GENMASK(11, 8)
>  #define XGMAC_MCBCQ_SHIFT		8
> -#define XGMAC_RQ			GENMASK(7, 4)
> -#define XGMAC_RQ_SHIFT			4
> +#define XGMAC_FPRQ			GENMASK(7, 4)
> +#define XGMAC_FPRQ_SHIFT		4

If you made use of FIELD_PREP(), you would not need the _SHIFT variant at all
(though that would be a separate logical change).

>  #define XGMAC_UPQ			GENMASK(3, 0)
>  #define XGMAC_UPQ_SHIFT			0
>  #define XGMAC_RXQ_CTRL2			0x000000a8

