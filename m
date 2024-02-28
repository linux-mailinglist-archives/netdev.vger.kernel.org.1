Return-Path: <netdev+bounces-75835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BAA86B501
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557B1B21027
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E146EF1B;
	Wed, 28 Feb 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Xa90Gu1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A557B6EF11
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137881; cv=none; b=ljKZ/A7NuSVG36P/fJNka1o8foWr3j50W2BawZQc+c8qHWlykbrkCLua6h+Sp2Y0s7H1pbeSE42zuh7u7BLhbkLdMeiaBDtbgTsK8A55kxwe0MC/rYI0XppNr3pgzYM3ZWHK+cARNNLyRH2LDcn+tsOYwk8JWFN5XKKFP2Q6lI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137881; c=relaxed/simple;
	bh=Zb0qiPi6+IKmYsXfmJ8ZpDv2w0U0cEduf5NFNRpaqpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBeO0iMVckJCOpqVHDlSZysmphy0NRbCw3IXyDK6PZNBKH7mMe32TVzlqeCVnjQQ8f5eM6rsBoqy2Y9YmCPBNc2jVeJ3UOZde9FEjoE3Nu97z2qPPZO4m8S9SBYyF2LeYqueYaLykhxQLW1lDRpHh2bVsYHujXRkjqwNKP+CUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Xa90Gu1D; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d95d67ff45so39530395ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709137879; x=1709742679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79kwpVMuJO5cQvJrrGHz3RQeCi3FyZACKTPne3xyWe4=;
        b=Xa90Gu1DWvtPpWEvInRdjGkjVzROmgpsjKy0ofqeAdgW0UbSqgVrR2Hs4tBEQ+SK9z
         C/ObKP/MT4d4cQNxef42S4jUMSvFqgPEYZ29OkYWy39abxjbYVmCEDijmfiI45cgHM2f
         zj374uLCdXN4Dfz+fkSsi8MlAo4ZgbBkhHjiMh3eGEHcOUyfK0E1vHr1y56BxHFfon95
         L1vcj30/lKEN7uNbbWXQB73P28S3yNSkf4wGXCppWXdhAoHj7ggLrceLAfM4rvw6WOml
         GlTLiBmxk5NAvcEbdNhoJx/0PIuws/31BzZ0qbZXmDnXW/PMru5hTCjzHpWOEzwFGo3z
         WNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137879; x=1709742679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79kwpVMuJO5cQvJrrGHz3RQeCi3FyZACKTPne3xyWe4=;
        b=ZduFfDO4IVOSF3JE+inljqU+bEu78vcDXNp656xIwryliolP/LR32Ry6ftsY1fP7wn
         QAyIkI3adUQI/NI/Vidb1MTzHDujWafMLUViYudG0W0e0PGUTlzkl8ua5hG3jFhpdplz
         iMBGbzB0rT8OMxy+MK2SkSfqYpLztInq1Q/Nc7N0uzyqXw/kkq8YPPD5Ua08UMuCYHG5
         DHK8g3Wsf4+Rc4CwrLb0k38lVzwe/GdsGiWYOtEFeXew4/0FtJB/TDxytDqTExNPfJnj
         5K8hF9PIRsxHmR7ToMnFTsypX6wTkHl4iPcs7Fz22RIM1zhLH/p14RQfOlJvH/6uPkOl
         FynA==
X-Forwarded-Encrypted: i=1; AJvYcCXD8SXOXaPwVEaj+WwEgAN7laJ95Fa0e1P7KqyWItZKEqWy2OgJn7tSeglEvFZGS+r565aopAEO4TI0DsLxfwIbdBApO3uM
X-Gm-Message-State: AOJu0YwFzE8IWFPgzIEX5R6xHOKcz222Iezuvbo8mqmvgCnUSt6m0eo9
	m6CbpACq4VIZh4VyzYx67Jc3KYJbWafEIK5c3jeIS60mgO47Kd1sycF+aUa1Z0Q=
X-Google-Smtp-Source: AGHT+IGGljHFACFDWCi4xMQJsuZ6Y+TBmUOWDgBjyWclrwPbyKFyQ3ScKPiEBStukIKaVQ6E8urP/g==
X-Received: by 2002:a17:902:9a4c:b0:1db:d184:c458 with SMTP id x12-20020a1709029a4c00b001dbd184c458mr11603722plv.44.1709137879025;
        Wed, 28 Feb 2024 08:31:19 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id kw4-20020a170902f90400b001db67377e8dsm3486829plb.248.2024.02.28.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 08:31:18 -0800 (PST)
Date: Wed, 28 Feb 2024 08:31:15 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Paolo Abeni <pabeni@redhat.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, Ziyang Xuan
 <william.xuanziyang@huawei.com>, Kristian Overskeid <koverskeid@gmail.com>,
 Matthieu Baerts <matttbe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: hsr: Provide RedBox support
Message-ID: <20240228083115.01d4c93e@hermes.local>
In-Reply-To: <20240228150735.3647892-1-lukma@denx.de>
References: <20240228150735.3647892-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:07:35 +0100
Lukasz Majewski <lukma@denx.de> wrote:

>  
> +/* hsr_proxy_node_table_show - Formats and prints proxy node_table entries */
> +static int
> +hsr_proxy_node_table_show(struct seq_file *sfp, void *data)
> +{
> +	struct hsr_priv *priv = (struct hsr_priv *)sfp->private;
> +	struct hsr_node *node;
> +
> +	seq_printf(sfp, "Proxy Node Table entries for HSR device\n");
> +	seq_puts(sfp, "MAC-Address-SAN,        time_in\n");
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(node, &priv->proxy_node_db, mac_list) {
> +		seq_printf(sfp, "%pM ", &node->macaddress_A[0]);
> +		seq_printf(sfp, "%10lx\n", node->time_in[HSR_PT_INTERLINK]);
> +	}
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
>  DEFINE_SHOW_ATTRIBUTE(hsr_node_table);
> +DEFINE_SHOW_ATTRIBUTE(hsr_proxy_node_table);

NAK
Do not abuse sysfs to be a debug proc style output.

Sysfs is supposed to be one value per file (or not used at all).
Formatting belongs in the user space program.

