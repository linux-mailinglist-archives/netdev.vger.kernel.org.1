Return-Path: <netdev+bounces-148605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D351B9E2979
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C21286164
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 17:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232D81FAC49;
	Tue,  3 Dec 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKCgqcW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9331F76CE;
	Tue,  3 Dec 2024 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733247512; cv=none; b=JJ75HhQqCsrvnJq8qG9uwPr43Z1T35zEDx2FJfMmIpskubNkyzAcD4csos6Dly2aZU/nkrZTZIPbe/CnsE35YuEfIJU0O58IQ3as8AEcylARuY1eN3CnHjvANCq7cBQGJ+NTAO2iTMFf1mwdeqSLaLI20MRM9zV8I4x9rMf/ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733247512; c=relaxed/simple;
	bh=7BrpCZ2JaT8Bn4r+/fZpw3qYVx7AsWh4zajkUXq+CmM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c4qseTbrPqfdty+E8JESMDsLzbhAfLRkB4XJu4k8bPNmUShUfGrzkP6j/9cUrcDasbpnXMer3U9Y/LTx/Xh0v0BUTOqmAUHJB0p7Ckmx2a24w/N/RHSBCacx2syVZKR35EhqjaXLgq7HZba5cEXVHvPTM7WWsRzOvHj9fbEFyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKCgqcW8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a90fed23so49293075e9.1;
        Tue, 03 Dec 2024 09:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733247509; x=1733852309; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i0QYGRPe31dft8XawdbTPYP5t//UlFP6kTyw2o6LzE=;
        b=hKCgqcW8O6/q1Ep6u8TXxZShGmePw0sRP3W/V7HgXCcVA0T6ijRLToVXLqU8bKXWN1
         cr8S6T5VU+gAeO7mL545jKs2pKM/2i0v0v9b+seBHx9m8txUkII8mjRayBGrF9OXssIB
         XVSRcaUf0VM50hwWFbolSomH/ONmdJcOmzrdV/0jfDW8ddte33Ju9+lU3GLRFHDgVrks
         YtlJN/npennTV+fvk9mD81OvvVlhgnSJC6Wb9cK3v7FS7H6vJT1LqiZanxQO6APKMLfj
         iwzAlkiVsnIaAf4Yi37USburfYhqme+J5kL8b8I9hUutxDT4czF5e5JEquo6KLesvm5L
         NvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733247509; x=1733852309;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2i0QYGRPe31dft8XawdbTPYP5t//UlFP6kTyw2o6LzE=;
        b=ItGh2mW+hUrFdKBWonH+vJjQPRvC/DXTHnpR+CES6SqfX6QEJE9txn901oxQ/dnMDF
         WdU7K+RnmF583OAs1dtBF7JFm/VXXIezUfksGPiZQCcHzIoS8H5FeXJFW/tvCTZAByMt
         +O22lR3NUsMd2ZYIlYaC2qxPeDBighCuxRaTbOaJo1rrG4y78E8Ndd5wQZpkI2lo/Ll+
         RGBwGTt9R2Ve+Hi7EezwwVDY8Zzx5jeNqz5+nQFDJgRE6n8C1C262A7O+BtuNcySna7p
         N9I8R/VnwgWOQQbDQxEG0hnaCkDCKOxusIoVFpaeehZ1RHwTEvom5DYJOslPf1hUg614
         M73w==
X-Forwarded-Encrypted: i=1; AJvYcCV+N+GRyWmY15qXk6Vyhm9WUWwK+URQQ5F+IFgAZBHjCQUPthCy0TIlPG7AMfReL3rYHkkf9h9R@vger.kernel.org, AJvYcCVPqC4wK4Fr0hlue+kEqy2K6ifRlHpK7U8NwC6ydR776001MCOVr4A4gCc0QpqTBVyoN47ZIF/idOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/mmACQkbTYWwHG4C8iTs6RVSy6Z53fWTod24iPGU2EyZtT5S
	uOcfYcTNT8lZjF6GiKFD8lfBzKKUWcrRAuhKBbnoKzl8qGqYJXsO
X-Gm-Gg: ASbGncvIFHTZ8u/AW/Yj3yOGySkG5xzDLklulMwJRj9c0AJnqJi5zoCeN1FxH2zTlhU
	ilHxlG235Z/cwc4uJ0jDImJMbs2fmnqTJ9Nzuyuu6vxDE+VdMOXVGvLk7r1qrT9MvT3uwTReOnL
	Qcsg0342BBEDbYANxDFImhuVz+oF4C0TnK+tMz4owa4e1r0GwvqAYEKhbEd44dk91off8SA+C/O
	VFXMLJDn0II7c5oJoJBVAeKY/WBYK/G2RlIm7IWUtqwIBRZ1pO4m3TOzFIKgKUo2f4/InUfbohD
	zGTvhkpuwyM1szggnj9KsrhbpNDMqDZg5jUZIA==
X-Google-Smtp-Source: AGHT+IELfk/rqiYQ2xFCsty4Po/RDV1kpoZIfmvqPBOS1OiRE8cCwmsd9kkcQ9OLbFX2XtV2i12P0A==
X-Received: by 2002:a05:6000:4013:b0:385:f638:c67b with SMTP id ffacd0b85a97d-385fd3f774amr2815948f8f.35.1733247508378;
        Tue, 03 Dec 2024 09:38:28 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e5b10478sm10474748f8f.73.2024.12.03.09.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 09:38:27 -0800 (PST)
Subject: Re: [PATCH v6 27/28] sfc: update MCDI protocol headers
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-28-alejandro.lucero-palau@amd.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8e43ec5e-8ca9-43fe-eb91-f35388a03c1e@gmail.com>
Date: Tue, 3 Dec 2024 17:38:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241202171222.62595-28-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/12/2024 17:12, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The script used to generate these now includes CXL definitions.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Thanks.

