Return-Path: <netdev+bounces-229274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C02CBDA018
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 16:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D23E1C45
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911682C0292;
	Tue, 14 Oct 2025 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8rUVAsv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA595289367
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452316; cv=none; b=DJLBg3wYhyx0XuSnUXrkYyiHAkfigf8LdvVjfcuYKzz/yS6pmEk2gTQ2k7Ag6Z65yg+UvZcjDZwX1sPB2UTVmNoHNjjcfCIi7jKi7OSk3X0SSKuWXWPjXF8L5Nu0oStTPy0EdGTuPshijzjCFxsS+9rIgEajlyOEpT2G8vD93lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452316; c=relaxed/simple;
	bh=6LNc+vdwep4BeLENBR9hSs9PbKUdEngRnpluAWS4E1Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ao/YhKSak2bySi9cBTkQRzRe+dGEYTw4V5zNnmK5vsb+DqDlPZhxlzf2LNr42XlVQ5fzoF21nfsE/gYqTcW+FuI315ubvcRycVLf7mVJMgRmcqxaAl9fk4PiXkMEVUI/O+lhH6k75b9ojmG77/ZJq29nMPYvCL9bs7O0w9GqaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8rUVAsv; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87bf3d1e7faso20740116d6.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760452314; x=1761057114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=k8rUVAsvTfBEyERHFc2Wo7Pf0nSM7acG6HfqjLNm8QoPC5/yhxR34pd/fZzoGSh6DW
         7CzUmmamkVAjRp9cB5WVaYZO56jsv/6LEzLb1fX/vtOv89KwvDs8iWQSXZrtVj8RCVvQ
         qJ5yCETx9wvGPMXMCzsGMu6bcf+YgBZDEMtfQfLu6KyrXpu2ThdCBNAE0w0YID+/1dX/
         Rwp7+U5JeIozpcs9pEK6PlB/5gR6pjQpTH5yeArA2ZaEtuCi4iJjT7UdjqZvJdC8D3hk
         rtZaByVhIBrD010vY1rTKy7e5i/60UofCGK/QJCCqVmsmvPuvTfIf8f0hXK/Tdf2HM3H
         9Kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452314; x=1761057114;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/p61iaYEVvkcgojxCMrhZrvkUbphBlulNRGVFmSL1YY=;
        b=FAsMzhFXQO0QgXnJ92+tylCToLLDw393IfZW0edo7xz1yZl1p85QB/GX4EPLdVa6ST
         4hCD5Rldm9eHc4zvFgEEDmM4MdtKhMRhKUttweIkEQcY6H4xRKwIrWHlt+eRgtxqQFSm
         LOkmknTMBdmSKRXU3MXBvugqExRhfq4IzdxggQSw7A6J+4UUPaa7hJ4atgOrFjx9PyTE
         n81kpFB2/u+XG0nCPnTrjZIkz6DpYL4PmHUCsNTN3OMOGfGh9M4Q5677J+2MiosELPY8
         ZkPqcz6b1aadngsBqHKItb0NpWYnGIvTclv4u7MbroYTgh+ZXHxlzrdW9Btq4R8t1ReD
         G99Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjck4c9CADxFTSlpK/0pyVVh2/Cjmsr9OkFT1jd5UTtPjyAYaH6C5v1Ek0SLV8oi8oQZbMfng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97RG4mSV66yk8B7e0NEQQ3SFiQw+rPC1jpv3UG1+akcmwyvrh
	wweXgYWRSivrwTUSf4O4uCUC3lpweatu40WZCbDjR6tKYfFg1lZbkYse
X-Gm-Gg: ASbGncv73KF/gQdaApxENIplKOccmqCRJsAlP/y4y46GmzaOOCqyXYLkABK1GyOypQZ
	GzmOe1JINrg0SCHuvHFDmYONQikMOAY7HG1OGKYHsvNOYmTGXC3FKVcfFo9DQ6po2OcYSgM1A9Z
	wt95OtumUpQ1b26lQrNVldB0W7NzxkMwo1SMCc3izjg/+7lEJXdqBGCGDu/PN5UhFEX4sGLRoNB
	Nfv3aHPJ3P8NiPcFM2G0NEfNK5aAcx8bf0Qj7hADB4BFVw21BD2fV6j0dB3MUMWzJbIDIQAwG6b
	W61evDQu19MZpKU9rUQ3uc6y/Eh692/kUvokGRacRdKmF2kR0KE4K0EawFpiT0xEC8rMcXK/jyH
	+OQm+aWRUfXucbeHjIeoTM5N3AujI8Sr0BZ8Dzxqegie9Nj0Ox/N4zQYCcy5UbS6LdaI62gun46
	q9sTjJBvtSo/ZXGRKTtD+mcPk=
X-Google-Smtp-Source: AGHT+IGwNwmXjeWv8Nmp6mkj0A5dZpoUF8uBRl0oD8iLD5gvHZaccJu0fCjSAdWukmLgkyib7kmZUA==
X-Received: by 2002:a0c:d785:0:b0:87b:b675:c07e with SMTP id 6a1803df08f44-87bb675c178mr190769806d6.64.1760452313618;
        Tue, 14 Oct 2025 07:31:53 -0700 (PDT)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-87bc3570c11sm92598796d6.31.2025.10.14.07.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:31:52 -0700 (PDT)
Date: Tue, 14 Oct 2025 10:31:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>, 
 netdev@vger.kernel.org
Cc: joshwash@google.com, 
 hramamurthy@google.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 pkaligineedi@google.com, 
 jfraker@google.com, 
 ziweixiao@google.com, 
 thostet@google.com, 
 linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.18f9d84fb2f05@gmail.com>
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>
References: <20251014004740.2775957-1-hramamurthy@google.com>
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not

nit: weird line wrap. if setting had been on the line above, no line over 70.

> hardware timestamp the SKB.
> 
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

