Return-Path: <netdev+bounces-63002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D6F82AB4B
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441C11C21139
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C9411722;
	Thu, 11 Jan 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX7CRGyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77229FC10
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336755f1688so4348688f8f.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 01:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704966687; x=1705571487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=crLTLrwPUJkse37ve0mHbSgy9s0WrDnEVwdFNH3HF40=;
        b=ZX7CRGyRid59KBUxVwNX8IBp9PgL9AxUGC9utA5hUpZ/XbAPVAlS1xXAVdCht1jrHI
         gI5t9a/YbWyurI3B7zJjC76FlVnFmK16xv5/t0hy8kGhvQmr4Fj4trHbirLlchKVmybd
         CvTSktkHo/3SbGK2L5QTNcx+wDumVZbQB3S+YI4pnB0aOuYjwmSca0v4pBGjsnos4Hsk
         GodNko4GJ/Pu1EE6SjBP/50WFk+OBSOfJmp6tbqJo+aj0pr9V+KfB9NQwSlFnljvFwLT
         VccSqTfybZRHBcgpozn95A/Kjik+k9SM7tBTsFaWPiMLH2vUi6lybIC0y0XpDBuNPIl9
         ldvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704966687; x=1705571487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=crLTLrwPUJkse37ve0mHbSgy9s0WrDnEVwdFNH3HF40=;
        b=ZMDwM/wkGhnJMVnUkFvSjz2rZGGW1E8viqnkq/k7TOQu4xCTYRAfsdvP+/vdtunCDi
         WkiII4MCxYKte28THfP81Lk/pVZeK2NgHDv8flQPMXjKqh93/WtqEgY0J1uLdJbU06zq
         rSHc1tZQsaX5q+LkHXJbsiBepXg0yCe5riJ8TR378MkELfxfxhuKE964DEoUwYTUAhhq
         gCHegIoVX3oMKdDZ6wLftG+9x+hFK3FaoP9LxEnTS0+vc6SVULyV3HSPFzVmmbnVxFOW
         NQOzaNzmT+sNb+C7uYF9uXaVcTG72ewfnvJmHWNbQZOp5jr1j48i+Gx4eYMcrJVDDnJG
         ZjQA==
X-Gm-Message-State: AOJu0YxW/9KyvRaMwZWd7+2LbUh5h2QsvB5iaDZvKcKQl8Vx3WVRi7yt
	x3YsTi0xUoQQ7290wRDc1Qk=
X-Google-Smtp-Source: AGHT+IFbKHRpKjPm6ukOqpCyzYFXvRgwXfae4C8P3fWeDHYNTA3DLX1B8YbYe4GgE4Kf3pApvAKm3A==
X-Received: by 2002:adf:ea86:0:b0:336:5e98:a231 with SMTP id s6-20020adfea86000000b003365e98a231mr463852wrm.52.1704966687573;
        Thu, 11 Jan 2024 01:51:27 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id cw3-20020a056000090300b003367a5b6b69sm753929wrb.106.2024.01.11.01.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:51:27 -0800 (PST)
Date: Thu, 11 Jan 2024 11:51:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240111095125.vtsjpzyj5rrag3sq@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-4-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:31PM -0300, Luiz Angelo Daros de Luca wrote:
> +EXPORT_SYMBOL_GPL(realtek_common_lock);
> +EXPORT_SYMBOL_GPL(realtek_common_unlock);
> +EXPORT_SYMBOL(realtek_common_probe);
> +EXPORT_SYMBOL(realtek_common_register_switch);
> +EXPORT_SYMBOL(realtek_common_remove);

Is there any reason for the lack of consistency between GPL and non-GPL
symbols?

Also, I don't like too much the naming of symbols like "realtek_common_probe",
exported to the entire kernel. I wonder if it would be better to drop
the word "common" altogether, and use EXPORT_SYMBOL_NS_GPL(*, REALTEK_DSA) +
MODULE_IMPORT_NS(REALTEK_DSA) instead of plain EXPORT_SYMBOL_GPL()?

