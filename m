Return-Path: <netdev+bounces-150417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250B99EA2D4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8C81636A8
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95920CCE2;
	Mon,  9 Dec 2024 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDVpjbzH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8620C498;
	Mon,  9 Dec 2024 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733787064; cv=none; b=DyHMzqC980ONmlEWvUe6ZnndMLhelfzwyC25w/5YjGdPDF2Nax+52tnFmnK7q4oEB2yEYMISToTqTso5NSfBgJdKHcS62sjE3FQLolyxZcKCvjCH+c99vA3D7gVeLWe9l1iNphrdzvg6owuTbVxLiqwZatwISaxyI0Q1sVUFudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733787064; c=relaxed/simple;
	bh=QmlhME/OssTFIYR8OSNeJvT3kUSJM5fAAAKg3q1CAd4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GwH9qjwbwCrTBTPW56swpccLhoW5s8B6EuZt85DDvw86IFfQyNtx7iwbTuTyEgH7ZaxK4vlARiDgE8E5EuJM8/MAII5onxAnKwQZBmDR1YO3FqpfarQLqiJWuw1jh/GTN4hcZSTI9vZOb31KbCkY4BYQFik5Z1nn8iDSMOS+u7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDVpjbzH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862ca8e0bbso2722754f8f.0;
        Mon, 09 Dec 2024 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733787061; x=1734391861; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM1BIUJxJWmq2Gx77DpcWCsisqSg+qpocUXmazwli/I=;
        b=HDVpjbzH1Et/IPw6YZ9M4OVQsAKhATEOPpoFcp5qdI4k/0EDjS4owoZr+DMQZUA2L8
         qrGd3DXQa+rcyy6B5z3ITx4HGJwWZ2o6JsMU/lTOKRlMhBsmOsgSLPGq7H1mUAedVF6b
         2Qn4LCVYiY+uIJ6kDUpcNAIaebqjJaGReM1oYd23Ey16UKt8GThbaMBwnZh1hLQTL+uU
         pw58rYLH8BVATV2muFyTKlwf+4/nltOQI7JivwEOmPe50iKSzU2dfCDLFm3Y9UGBWXIA
         flnEHitjgh2kJlhNc8IrQYxj1gX+Y57d/Z14stWAdaLQvMAPYmxwbBW2b11lc0HUKlp4
         4ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733787061; x=1734391861;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM1BIUJxJWmq2Gx77DpcWCsisqSg+qpocUXmazwli/I=;
        b=rqPVRybhs7/zx+wttfEUYBdMOEuEaWE87AQuR/QWGmRhjqC6Ubla9LgJ8+dUqe4DIM
         ocTgVZOj/Zb4+tNvOeSHNWFEl4mtgMaKKDbBWI8KOcDwRFPJnf1YF5nDErOP037EihiM
         aTeRESLV/l2I2d0vNCgqslqcxcsSKy+ywjU8R92X4ZhdY6e/wGW/7+Tikb7uZXonGpOB
         O349tP+5ITxHa5xylIEvF8Pu4AeaFV6nFkQhaKdTf40BC5gO8h7gujvhkQ7wJKQqOz+P
         UxgsDlKxCA2yPlgq7KeI8NeAfVkxMZMwD6uo9HWT2Y/vOVoAh8me24eo9xe4EGsSdT5q
         minA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVo1AKOgfXaBgTdvlqZXLyisyhdQPqOziODuG+d0ClqQFE7gATBi9N2wjz7BKi3BgrilEz0RZ@vger.kernel.org, AJvYcCXaRf5KgQsxkYK+PEyB4m7jmB9u2OuXmVGyglToKuXmNBuMg4wz4uV/ldQhfkgFUF+/8zMTUr1Kkek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFINvFajlgD8as6NBIPK9fgTtBxetClYDXfvge3bCAoF5/QBN
	znlDS8VrFm8UdPewV2V1eg2OAjVDpDPKmwW6cgkOTj8EoP559fWc
X-Gm-Gg: ASbGncsCb4lP5LfxfFUp60Uzt/iv9ry1Wkg6V9fLDpHLO0aE8jDacge4zNqhZhah6ac
	UBSnT9UWd9agw5pses+b+eWGX5uD1F6nFYcmPAqo+JnDvsGVlJU37aMVXc69TEsGTudGHU661vf
	zpCrLyT3J9FDykawG5pVK1/hC7MDQehrsbLYmoyh8u6HwRiwiO2Hmwn/B10mT1v/0LtrNItYX20
	cwJuNVLUGkTP+DbCldv2ewQps+NfY5PLaBHTg0sFOlYvgotxKKRCe0xfTcHFFvv+9Bt6xxN+iGL
	GZnIux8irjIQ+B6L6Mv/adqn8msPd2aVhZjaIpzVZQ==
X-Google-Smtp-Source: AGHT+IFCdtoAeC421JshkUGeVL4fzCWBGs6zDVyAoo0KkFMAZ6rLJ7d9sa8PXy/J0kZA1zB+SYkJrw==
X-Received: by 2002:a5d:64a1:0:b0:382:46ea:113f with SMTP id ffacd0b85a97d-386453cf89cmr2302460f8f.10.1733787060785;
        Mon, 09 Dec 2024 15:31:00 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862c611242sm11413839f8f.36.2024.12.09.15.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:30:59 -0800 (PST)
Subject: Re: [PATCH v7 13/28] cxl: prepare memdev creation for type2
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-14-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ff0d8ed4-8967-1482-c838-3b3498506914@gmail.com>
Date: Mon, 9 Dec 2024 23:30:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
> managed by a specific vendor driver and does not need same sysfs files
> since not userspace intervention is expected.
> 
> Create a new cxl_mem device type with no attributes for Type2.
> 
> Avoid debugfs files relying on existence of clx_memdev_state.

Typo for cxl_memdev_state?

