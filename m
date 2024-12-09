Return-Path: <netdev+bounces-150413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4FC9EA29F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC24280CF9
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5F19E804;
	Mon,  9 Dec 2024 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKF9/uT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F119D092;
	Mon,  9 Dec 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786565; cv=none; b=luCZ29QJCuM+PLYlMWNGrnV2pLZoyfWMY7hKAa1t/drdPIly0CuIzIWMs1Ev8FLFMKVOsCFfl0WeqMEi6/4S2fNfnQ3DTXVRn8uJn95/U+zqcn2yK0xiXzD1O2bFXB8DNE7tUXpGHoBL0f5xowGpFRM3BuFuEoHLb+1w8SYCxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786565; c=relaxed/simple;
	bh=b+wz2LiuF7QMtQ/X555e2zqxnsLp43IzdETgVMlOMTE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mIfw+yfnCWwkjKfUR5tNmlNbRm2QS4d2xQn0O0n3JO85membWB27nLbDMD2LiPIIKp11gjQtMQGAHS/WX1B6qsHdbjfmQNODWiMEse+GeTY9JPog2b9i2y2AcedmicE1u7OkFVBrsEN+E7n1Eg4uc2tvLP1Ax8lko04f+dBBp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKF9/uT4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38632b8ae71so2105791f8f.0;
        Mon, 09 Dec 2024 15:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733786562; x=1734391362; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV71zIGkn324vRClbAXWfoC6iqMb3r6XscAGkMqwBEA=;
        b=mKF9/uT4ziL6EcY2LzvS2CFH0kFRrNuFwUMfzNPyN7TUED04WY+yeeSdj8VEaGf2lQ
         l+VOMcFJuk9bZD81xg721JGHRtMIjpiglsfdV6s5NauJDQJTviag1zDZDnbNYZv/HtAc
         DnEnVdwwDKwzFf83Wld26tL9G5eS1Hp5d5IpjxVJzWw4Hm1SKL7aqPNPi7MhVHXoXMQK
         hZ08/Yl+Hs08dMrgKrpOeLTUNjCUClRd+4l9gOXZEwcT48RveZ7CZcztXLjzUwMcrqaZ
         sESyvR621dH5FXTg1g/6xBmoMsQRLk84ent3uEzEbybzTRzCRV6m0deeziy73EZ5okF7
         SaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733786562; x=1734391362;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV71zIGkn324vRClbAXWfoC6iqMb3r6XscAGkMqwBEA=;
        b=e+5yttmodveVEuZqoMZcfy/tUMKigC9HaipHDKORr597ql0oZvlR+XJsrhE0aFvd1M
         mx/RdAu2zAldnzObYnIXQS2y9B3Tc9LE1A005xm0JKSjCFFerBHVAYFQ1nU1G+DGsxuQ
         6GocjivF9D5PAJ7P8LQr0il9pXnEQU7GPHqOjJEenUOmmGCebhdtO3bU07Y2kZKFJgAS
         qAmy/Va5lIm/BNUHOLo2yzj1vVfZmnX3TVkpwk/9oGq1ckGNJYzxXGOVk0/9PVDFGkOx
         ENxOXW6nwcjhHMMFGk645v+gJ2glQxQF29Pm54HPb6cG5qkyiyf43q6FQBKBVZD6d/GN
         95yA==
X-Forwarded-Encrypted: i=1; AJvYcCX2JJRYix4q/2TmDso2xKJwNSwaDmX0aO6+KcNLAuKOGTeELIkB9fovkfEdTgKsjP9/x2EXfHRk@vger.kernel.org, AJvYcCXM3jltI6EEimWpC8iNcb6LA+k2jGXaCwPEcx5RrhPIRAQIUGDZNfi6C5TcHbPi/Bd1NRRB3Zy6/0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLNQAh8ZCzNjoYow3ZgQMRypw1p7ioGc92KKjQQtd+X9Lzi/3
	3dsvV2/ZiZ+xJWsNePK/+szt/OWN6BVUUvaAg00F/xdPaB4Y1WLa
X-Gm-Gg: ASbGncvozclkzDUb8YtEOOCnmfucq5jrVQg5ObcW1VB96ZtowYpglMZhF8XpN5CdCqm
	QFpRnzIKI2IDiMhFk6emsKkuLnTzmjk5dQ8nmovczV8WeJ0WiTmuJ1TWLOgG1IKXGiVZ9F87p29
	jA7eNc/1rlBWi/osMrI/o7GdKRDdxdA1tKbTU57tQmUKWpsQLm6j6Tm/EmFHLVmWRo72oqj+MDO
	Rm8BRBzgR9QAs7YouCm/aTr9xVplnRhkjhHaXAl/hyZcGR4I85DFK0lU14KXHfYdggUt+oKhLju
	Vcj43maG83nBrCCUd3nPQF6PrZCeN68hu3644A3xMw==
X-Google-Smtp-Source: AGHT+IFwQjvAk+nmCAjZ0bp4PB0BASla6Xo7uKxw5Hic7ds8sQYVJJexKlSnhQsTZvJYUgpYlpqdsQ==
X-Received: by 2002:a5d:6c6c:0:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-386453d5135mr1159481f8f.14.1733786561541;
        Mon, 09 Dec 2024 15:22:41 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cd35sm14194132f8f.31.2024.12.09.15.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:22:40 -0800 (PST)
Subject: Re: [PATCH v7 07/28] sfc: use cxl api for regs setup and checking
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-8-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <ae9dc6bb-2462-fdca-db74-1bb074a53fdb@gmail.com>
Date: Mon, 9 Dec 2024 23:22:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241209185429.54054-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl code for registers discovery and mapping.
> 
> Validate capabilities found based on those registers against expected
> capabilities.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Reviewed-by: Zhi Wang <zhi@nvidia.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

