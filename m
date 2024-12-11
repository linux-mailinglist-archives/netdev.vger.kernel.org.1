Return-Path: <netdev+bounces-150943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC439EC252
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3318867CC
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C6D1ABEA5;
	Wed, 11 Dec 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYuaM8iJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA91BD9E6;
	Wed, 11 Dec 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884749; cv=none; b=X1TuPxGX5SU9xFUZQvpBgG//j+XNGYmruYISzvXQSlJFBN7tvSjQvOOt4EyzM4N803+k3U4kdDXVDLYsKCNoyGLjyoys1d88dur8I6LdIo0ju08+YcsAtYoKZjU9hZp7JVZMki34r0ANuLHE8T/JQ4/z2/voM9guMEdAGumgZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884749; c=relaxed/simple;
	bh=WW2fYYtlYBnv4V1HXkIJ2jTp99f9NU/YQLPghs1ruCU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SVpnhDlQLgiX0vCc/vEtEp/hpRHSVNpcyUuSgF4r7hZZ5P4eu5yPLrz1X/2NpCgrU2bXXsZf6kUQEKDrITOqbYcmRElJZEHfqr9dOlEO8VrpSzXzPdFMVTlMZWFYlYKBWErd6okooFWi9VsNKlpt02Bu1w8rS5Bg9bS6xVj3Lkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYuaM8iJ; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-386329da1d9so2163271f8f.1;
        Tue, 10 Dec 2024 18:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733884746; x=1734489546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MprqPbQtFII4SFxP/htwJEt3wmgHvKrzKJj+g2KsEI=;
        b=SYuaM8iJi4bkMGCs3Ywnzumv9GL9fT5qkOzVXXYJLQkcJqSRHzLIMwL6qH8Imwp5Br
         F0IVZNmGTb+leSjtmFTRX73D88KVoTrV9bdJoDJQi668mhR7uB9EisxHSKTwlh9hJ3Wr
         iUXuS38FmF+O9q92/HL4HXcNuHVsmbn5EepRE/GDPkso/KEQdyc4ISV3M6IBqDLeg9nD
         sNemxwJUWbkhFJQWX0/4NmFBlUqHqT3WyhEmxlmpK7NlMh+7tLYHf6QscyEFMvzHRjRw
         9RgigZ8pmIqF06BuZ+/wJOZMPXQb3hy6lcyWOMnUr3Ga5DzX7/45lc6hfCAAS9YQjEOi
         45aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733884746; x=1734489546;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MprqPbQtFII4SFxP/htwJEt3wmgHvKrzKJj+g2KsEI=;
        b=Hs5ol2gvvy4X0uyeVEMVB4tkYOYWusO4V6RjfwrgvVBP2MZ5wJG2rJMSM8B+/yVBxA
         qI5GrzMQAO5kG4IQTkEvX/mhMqdOiXFNR2FlMst206JvUsaCbve0pjhlkmXvjvdwXMtL
         efUwSqrUJgifuuEgrqMgNi/rV733/Zd23Unvji1KgtS1xF2KxfQYuLijhEHT+J9WyXjA
         cZcTfJmgiTTqEWedfdRZXIYK75PnktlF2vMTP0TY/W2XqH9/Ke1pzO3rawfl947PpZ3d
         Sn1LeHc9q0gcDuPJ/qXcd5xf/xpizJY3kSV7V5yAU/XbPHTJBlPpUa4Tl7/NHR5b56Ey
         xoyw==
X-Forwarded-Encrypted: i=1; AJvYcCVQR6qbAfB494+ZW9AR6P1K3vhTtj2bf2eK0A2OWxGJb0/PI9o7KHwHX1yLzCsHUFS7GsvCmJ28KyE=@vger.kernel.org, AJvYcCWL2O5ySTHJaB1nlMKQVo9F2sK4o9lCNgTKfbED0Uwu+sK2JH8IBpTBsaZq/BbW3XYWlP73lhmy@vger.kernel.org
X-Gm-Message-State: AOJu0YwPsmCbDpLIi9kDHJxHxQZ7rXTQZiSg48VIUfdNF4OgmcPnbP+/
	rDdcL78q7gP6ac1F3osZWFKewW1APK8HlIV/sCKrWXBKUxdL8Lt1
X-Gm-Gg: ASbGncvmGGF1LkY0OfsKWjGOlFmAXRmlhqpfYq0r1egFmzWPUmRUb3oz7c7J3uSh7FF
	V1S/aguQanv1eFGupgLy7aOJRXG0KLaZMkM8UDS1PKMhoyd7rfnZOLJfL5OZNUAIzr6OqeE9d7n
	TAuLhkTSPFgmPUw6KFkJIW9spVPqd46d8xAdPfpbxtFtW8CrmvGzn8ZslTMlg/hrpyqjXqUtEKz
	WDZmeR0NvgSqEpGIaQW5sQj66tbJ2fmWQFllqoixWoccneNGsWUOzoZagQK+n0BZ7pUDUoiWOts
	2RrFFO9ZK6dO7IAJXhkPvaiiTm1pnAMzBlRxKHWi9g==
X-Google-Smtp-Source: AGHT+IG+9/O1Redh7NSGK6oiq5H13ydVWpd1sybSRJwJqzl6YMrlp6SBb5B77Zh3o8k32nGVXpcFHQ==
X-Received: by 2002:a05:6000:144d:b0:386:1ab1:ee34 with SMTP id ffacd0b85a97d-3864ce4b02cmr734171f8f.9.1733884745637;
        Tue, 10 Dec 2024 18:39:05 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38782514dcesm132155f8f.65.2024.12.10.18.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 18:39:04 -0800 (PST)
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <0f2c6c09-f3cd-4a27-4d07-6f9b5c805724@gmail.com>
Date: Wed, 11 Dec 2024 02:39:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

> @@ -1263,8 +1281,25 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		goto out;

Maybe this label ought to be called something else; it's not really an
 'early exit', it's a 'skip over mapping and linking PIO', which just
 _happens_ to be almost the last thing in the function.

> @@ -24,9 +24,10 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>  	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>  	struct pci_dev *pci_dev;
> +	resource_size_t max;
>  	struct efx_cxl *cxl;
>  	struct resource res;
> -	resource_size_t max;

Why does 'max' have to move?  Weird churn.

