Return-Path: <netdev+bounces-52686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CBB7FFAC5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 20:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55B2B1C20C3B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531DA5FEFE;
	Thu, 30 Nov 2023 19:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3kuHYms"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1797D48
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 11:05:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-332e40315bdso910497f8f.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 11:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701371149; x=1701975949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M18k0Gk1/fj/6yEF63zM2Yr67RGDEcrjdLvSk4xIBW0=;
        b=K3kuHYmsbPMhNW7XSVzMAR6c6XcyuUg0svDPzbkGgrjgoKbeMZTQ3nfLuoQaXS6qoH
         PT8otD3SZ80g9ibUfulFlTI4K0jfAUgCwS7XgNPfEusU5cDGH+664uHOC3Ke8QDuQ28Y
         n2j/tV09GEgdhD42bPXcjk2zSzoo/mPdxMJjfvn8M5ihHv8Ym66GKUDrB6gwAbBfWgXR
         MwT93UveFizZdTSKZwJG5Vms2IzINviJgUFz3WL/YWMLAH0P/nKr0VQL5VAgy3gX2xSZ
         eV1pbDpv59gkAYhjRzmgRVzxLmU/pcxgKD2yDXCfy3wI4xsnCX+vQnlVlVGnBgtTbXHq
         Z3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701371149; x=1701975949;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M18k0Gk1/fj/6yEF63zM2Yr67RGDEcrjdLvSk4xIBW0=;
        b=pE9ibJb+jwyKX/IP5wa6/4FL3VL/9d2rX1PKmv89eAsttZWnxyjLhBBI6y1kuNi4dt
         ITDvNfBFMNSFvJAVZT41SLdxKUOU8cl0WdCz8XOCqYElx5KahbvjKaspE+LuD3yaV5zP
         sQBzL6p+tzjt4ncSDaq2JF1hOLy+Dc8GsFjxPUUPNdlwHN81ftIiYh9+zcZe5+fOgE+C
         oslS70buweC05z1VdQRTVgkyS2PmwYpovih3CJxGX5ucv2I1whkPxBtX4u9NJGUXovha
         ITNC/YMINZoeZ3b0iL9dTS5RGQad0DxK1kzJg53JheAidSiCpq2D1dAW2GsITjQgNb7o
         hy2g==
X-Gm-Message-State: AOJu0YzL9CLemCNljc1JwWXrKuq/oHvHaeAw+QfWiTfsZZFbhpp/MDh/
	8jPL0h18e8aXmtvsB5CM7BI=
X-Google-Smtp-Source: AGHT+IEUsunArsGxLfXhuMZkCmM70250UYEM7LF6hhk2BTS8GvcnHeVeDuTfz9semeZOfCWvo6SmAQ==
X-Received: by 2002:a5d:50c9:0:b0:333:2fd2:51e0 with SMTP id f9-20020a5d50c9000000b003332fd251e0mr9419wrt.89.1701371136424;
        Thu, 30 Nov 2023 11:05:36 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id r18-20020a5d4952000000b003332ed7a90esm548518wrs.9.2023.11.30.11.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 11:05:26 -0800 (PST)
Subject: Re: [PATCH net-next 2/2] sfc-siena: Implement ndo_hwtstamp_(get|set)
To: Alex Austin <alex.austin@amd.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com
Cc: habetsm.xilinx@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-3-alex.austin@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <b8f3d504-5c0a-f990-4e57-7656611f5286@gmail.com>
Date: Thu, 30 Nov 2023 19:05:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231130135826.19018-3-alex.austin@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 30/11/2023 13:58, Alex Austin wrote:
> Update efx->ptp_data to use kernel_hwtstamp_config and implement
> ndo_hwtstamp_(get|set). Remove SIOCGHWTSTAMP and SIOCSHWTSTAMP from
> efx_ioctl.
> 
> Signed-off-by: Alex Austin <alex.austin@amd.com>
> Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

