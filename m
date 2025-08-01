Return-Path: <netdev+bounces-211338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8748B18116
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E017E5437E8
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA5248F5A;
	Fri,  1 Aug 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr2FMdlM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2F248166;
	Fri,  1 Aug 2025 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047615; cv=none; b=qKYqhO8t3cOAPcw2OOHwIP5rmAL5ZSt8D7ILAvfGEe7AXf774t7jRyEsPKLaaF4P0/KcEZvdQey+J0843mxGkLuG6y5HfQNfjhPM4eWFCVsDRHV6N4EZMYS+SIc/imKK5En2ls5u1+zgTdu0ysfYJaID/UbirZn4uc7w27pjDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047615; c=relaxed/simple;
	bh=xopXglTVSzoxtlkp1CzCI9Ne6YMngkltK4/0Kn4sNRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghdfr+b/N6fYYY6rjQbPv7dm3ykJFaxbemYqIEjinxcqnosnVLTI7fmApeEAQDAwIqJnS9DIzN8Wz159E4yrsGDqEMU3ICXK++yXERtyU6nEVr749tzHkr/ZWUu2sSd4EvBCiP/6qPRQq1/TlPU+fLcJT80jUKQn263s2PoPXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr2FMdlM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-456127fa3d6so2854615e9.1;
        Fri, 01 Aug 2025 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754047612; x=1754652412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+npt/FpkzCI5+eJtC2Iqcg6Gd9VmgmTPnWrlgifmjzE=;
        b=Gr2FMdlM+VWCLH9M6wW0Qmi8o5ITtamrBVe5PhphnJcR8TuDr3qlT8ROUv6KU4FK17
         X80n59v8PrOKGzQbxH+mpSRO5AGwAwabotpjC3Vsvfzd+UZi7MDZ0TN7iNm0LVczRCY9
         pl4JqdTK/W2yYfBYhWxtpSoO36+7I3eHoi7EDMC7XtbN8Bn2wYX6dz03oqCsU190dAUm
         WRXEQqDxHMCIlui7C7Cq1KBzZo5hE8aUN0v0xvaKtbF+6I+kBP/iRJq1Gh/h1Qnp9n+E
         CbmlMSFZvkk0scNeavtVJVUGAfOlPiy9NuL0pHbcZSXGg3/qfyRCE0hO4sRrfGStiwGN
         Lb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047612; x=1754652412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+npt/FpkzCI5+eJtC2Iqcg6Gd9VmgmTPnWrlgifmjzE=;
        b=D88cEIr1LBanMoC6m07NAypHPKsmdLkEQMzZrKG5YYtOjrXqP9pROh/sKWcbFWVdks
         znoN5ZRq2WYqiRR6075LvZAENPUVRpmq1oqgH5+MX6JTsI6ksJgwlD4QP0LtIh0dkCuu
         ZhT8QUbsE6j7hI98Z+CnK/PvCG2ojR/sxuJKuZRQawwRFeqP55sI2XGSX9cJxt1wBNDH
         LR7Ys2lo4dEtk6bAcXjZLWXSsHx3vUH8KFMUBXCsU6LqA7VVAeVCShhNpaWb+b24zz60
         BwKZIz1u5eJYVIkFGqfylfRttj8rbPkTZ4sP/Q4IH4Q64eIQlPRC0Ez0+zJuYtM9xsux
         UZvg==
X-Forwarded-Encrypted: i=1; AJvYcCU+oMtnpnWyxKWle+wBC3FLzNBMFUuhyos/DVHfnevyEJ7YIbTNnkPkQSQJIlU5/d5+vQTcJTY/@vger.kernel.org, AJvYcCWsDpmzajp8l6/maCCTc29KJvPZOH9qGaPja4xs2a4Zqt4MbVeidZKCyqa5gi4y80kNw3ZcQJ+5ivXOTjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/23SCgu9LJC5pmrWQ+ClzcHpok0KWa+V1ei8W39wH147LqVzQ
	CFmnOvwx4p0xqgBpRtvBIHxU78CDPKtkz8iVarS8tJAdVOIqLs94aKfH
X-Gm-Gg: ASbGncuYR5W1jHXxjwf7nnL9tDwrftHpnV96Du/+vgvTh1Oy/XC5Nf14FuBOsjfJQLo
	N5IYzkLvILaabZWI6tTeN4RHbe8cgjyrgZ6WU2otEVXWLqDfb4nwGuC/cDffajbrwd7AZ+EIm8g
	lgMMz8QYEU01S+8JCCllIBkLzp/ZyoJMhfNOji18IGMmWSMaW4eOIM1QL7eYNsY+fC2K8A0usLi
	THuhJXIL21gZwy3L0s2QIDNAalhaAputVOyjXw38d8vTTrXVnssNOAacrDfTNJJauLqwdds8Gn/
	tFGn7wh/NHuMlk6kfShsSWrzlHFwFN4y8AJfmViW7sopIuj/xGP/AqRC65hDxASTBTF3tf86xpN
	v5gYquz/m/wXyVmVraYhDzaOkKA==
X-Google-Smtp-Source: AGHT+IH2vYjvCvKNMUF/+990SlXtwrfdORcA/Rbla7r8xKkmZqTuw8hBBUjJ7Yc2umBNtBSP2iLcIQ==
X-Received: by 2002:a05:6000:26c4:b0:3a5:28f9:7175 with SMTP id ffacd0b85a97d-3b79501113amr3774930f8f.9.1754047611489;
        Fri, 01 Aug 2025 04:26:51 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:b5a7:e112:cd90:eb82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458af94d941sm9260935e9.3.2025.08.01.04.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:26:50 -0700 (PDT)
Date: Fri, 1 Aug 2025 14:26:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com,
	viro@zeniv.linux.org.uk, quentin.schulz@bootlin.com,
	atenart@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] phy: mscc: Fix timestamping for vsc8584
Message-ID: <20250801112648.4hm2h6n3b64guagi@skbuf>
References: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250731121920.2358292-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731121920.2358292-1-horatiu.vultur@microchip.com>
 <20250731121920.2358292-1-horatiu.vultur@microchip.com>

Hi Horatiu,

On Thu, Jul 31, 2025 at 02:19:20PM +0200, Horatiu Vultur wrote:
> diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
> index 6a3d8a754eb8d..7281eea2395bd 100644
> --- a/drivers/net/phy/mscc/mscc.h
> +++ b/drivers/net/phy/mscc/mscc.h
> @@ -362,6 +362,13 @@ struct vsc85xx_hw_stat {
>  	u16 mask;
>  };
>  
> +struct vsc8531_skb {
> +	struct list_head list;
> +
> +	struct sk_buff *skb;
> +	u32 ns;
> +};

Can you map a typed structure over the skb->cb area to avoid allocating
this encapsulating structure over the sk_buff?

