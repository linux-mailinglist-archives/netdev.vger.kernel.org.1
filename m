Return-Path: <netdev+bounces-172274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45933A54095
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A22171FA3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6E1624D1;
	Thu,  6 Mar 2025 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYp7vSc0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435AB42A99
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227648; cv=none; b=TZCB1TCpHkyfaEZBO49q7FnEgoR1X7pJHH3BQoK5HExWdxfg1jks5NMMXA6ERg1i0mblQhPsAHG3AaZMkCgv/lk0jVoctSGDY8hQfyLP/LAEREYBaDQLjzqMFTl0VcOamI43dogOAg0UKLxfkaJsCmRG/71EqP8wQtMTGSAFsyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227648; c=relaxed/simple;
	bh=ta9MpR+5cxayg6sVDQ9fYSScVl8hDjRBEHDxRB6F8K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n19JBohU9N+FMx74A3fu23eswNcNHCRk12KEncmOa1caHgttDBv9qITtrQJiEz8PBdtQgvqqhSLvrQMkpjsHPxs6Eo09kxXCN+Cht0/Fi+ZY5JYUuZi3gRcrk7u7mXpASN1HsAutTyK/Yzs9EtyI55PsUvcdZ3WNcoMKdfPQk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYp7vSc0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239aa5da08so1464865ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 18:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741227646; x=1741832446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2hivNpIs9Yw9hGUFhjmLsY68kEzvfhce8DVHWNRyC0=;
        b=iYp7vSc0fETVoSEfpz2lXjwA+68nxHj16Jg8ukGntCcIGR3xj9U+HFGYJObe+gW3W+
         ZqZ8nhSCyq+ymkIRDa6M+JIvK8qWfwpwjzmCp9YrjckJdEs8G1RfDLimNeBYdnVSGB1H
         14E8dODOBtfQJ5w1+OiVrSZYVPmswu/YYE4+MZxmLEF64MpO3wNZ60VVWQ0vJFJDSeYq
         GF9vwZFUCUL92AuXpz8nXeOBdFGfSZOd2Q9BUPLr6385ZVM6s/ta6NSY87nuzZppPC94
         9frJtu4VOX1NJn7eSxA+sXgA54vMMarzsQUw3hJY6hg1b9NIkUHVjVFM3UpjnHi7eOXy
         80lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741227646; x=1741832446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2hivNpIs9Yw9hGUFhjmLsY68kEzvfhce8DVHWNRyC0=;
        b=Z1uDMKZgdf1gMDHhA93W1gI/POMuAtqU5pBXi9aCpvL+6694IEJm2sxtGEfOx8gUgY
         H63diSoVOGwiYKCZiCQ6doGOz0VsYgS9kiCe2aXpskpi8gtns+S22uNYg4oR9KvUb7Qk
         FmdtEZtJGFksMnvyY4BOrJlUYhZOMXMI6wbdikwvjKb3xMYMoPaTjwhN5sxcp89mPo16
         IkXgxri1QMwgwEvgWIV5iLmhQ5s2e5CvI0Ja35hM0l7mcbmltFJ0ZtoqtjauvnaqFFkf
         Sv1lpAXfgScg0Y7gN4vt9BKwYFbdkvHU9MZKpwCD1QZXlZdwsGBzn2Gy5qg78c5Tmx5B
         vAwA==
X-Forwarded-Encrypted: i=1; AJvYcCXVYa/4vYx6sAjFT011tKi+tKaa6SPKa0MONyYnTX+Xaxzx/xzlAgVGmqiNuwbO8xuAQwdgyjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqwgwifRXaDRSGIlw59hjZLOT8V1fNNaSy+8J0W/VdQ0Ibbup
	OTH4UcDULC0p+kEdh07GkJrek7+1bqDl3TxhKZE47PuhNRaowRLt
X-Gm-Gg: ASbGncukOaFPL6EjyDKhTuH6UXmozqZAn9t7lZNVfqGjJIt4+I7I9Xe2dg/0G4SUFXA
	Gurmvk36kOB3lTw+praHKu5tfu0rHcuyABiAa2nXvX4x66s9xcBPhD2zd/70R9f+tMukW7D4hj7
	xDRyuVgKsSs4+iTKX1gJJtcrTfe3J2PSL9Me4NzEVIrXlpv0RfwW3GnPAItkebppieG5/xHQUEU
	LBEsc6JdxNS15PdK7QGIStFXNMu9tAiKKMryu5bkxvBpZCn5jzOmuI4HswXEkNUqrDJ62vfWZEj
	DroMdoW0NaHKcBawiDXtOqhKequbS86DCW/DEQ==
X-Google-Smtp-Source: AGHT+IHkLXtXH1Ai+gYOOPrG6bG0WcyyOkT8w2yuVJZyzRqP4bS4nX9Piol8DXMXXfkC08Bx4bmSFQ==
X-Received: by 2002:a05:6a00:1788:b0:730:9502:d564 with SMTP id d2e1a72fcca58-73682be6b5bmr8585186b3a.14.1741227646199;
        Wed, 05 Mar 2025 18:20:46 -0800 (PST)
Received: from localhost ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736985387d3sm147939b3a.172.2025.03.05.18.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:20:45 -0800 (PST)
Date: Thu, 6 Mar 2025 10:20:37 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: mostly remove "buf_sz"
Message-ID: <20250306102037.000007ab@gmail.com>
In-Reply-To: <E1tpswn-005U6I-TU@rmk-PC.armlinux.org.uk>
References: <E1tpswn-005U6I-TU@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Mar 2025 17:54:21 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> The "buf_sz" parameter is not used in the stmmac driver - there is one
> place where the value of buf_sz is validated, and two places where it
> is written. It is otherwise unused.
> 
> Remove these accesses. However, leave the module parameter in place as
> removing it could cause module load to fail, breaking user setups.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index cb5099caecd0..037039a9a33b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -101,6 +101,7 @@ static int tc = TC_DEFAULT;
>  module_param(tc, int, 0644);
>  MODULE_PARM_DESC(tc, "DMA threshold control value");
>  
> +/* This is unused */
>  #define	DEFAULT_BUFSIZE	1536
>  static int buf_sz = DEFAULT_BUFSIZE;
>  module_param(buf_sz, int, 0644);
> @@ -218,8 +219,6 @@ static void stmmac_verify_args(void)
>  {
>  	if (unlikely(watchdog < 0))
>  		watchdog = TX_TIMEO;
> -	if (unlikely((buf_sz < DEFAULT_BUFSIZE) || (buf_sz > BUF_SIZE_16KiB)))
> -		buf_sz = DEFAULT_BUFSIZE;
>  	if (unlikely((pause < 0) || (pause > 0xffff)))
>  		pause = PAUSE_TIME;
>  
> @@ -4018,7 +4017,6 @@ static int __stmmac_open(struct net_device *dev,
>  		}
>  	}
>  
> -	buf_sz = dma_conf->dma_buf_sz;
>  	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
>  		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
>  			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
> @@ -7973,9 +7971,6 @@ static int __init stmmac_cmdline_opt(char *str)
>  		} else if (!strncmp(opt, "phyaddr:", 8)) {
>  			if (kstrtoint(opt + 8, 0, &phyaddr))
>  				goto err;
> -		} else if (!strncmp(opt, "buf_sz:", 7)) {
> -			if (kstrtoint(opt + 7, 0, &buf_sz))
> -				goto err;
>  		} else if (!strncmp(opt, "tc:", 3)) {
>  			if (kstrtoint(opt + 3, 0, &tc))
>  				goto err;

Reviewed-by: Furong Xu <0x1207@gmail.com>


