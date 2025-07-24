Return-Path: <netdev+bounces-209716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E93B108A9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4EFA3A7F82
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F89D26C389;
	Thu, 24 Jul 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2qxjxNe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42912690F9
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355452; cv=none; b=ce/gvNXBA3UcdQmOkvwJ+6rCouqJlvIPKOQMGUdFfkKk9NgGZs82BINOW2gqzVWnEonQ4l4hWS3TrDN/DXHZpVseiR848WuHgO0W5o3oqHEfEZB0+XPmlcJrlUhUZ9os9XInCfH9hSolHCZ+P4yZywmtUMY8vDJtastJYQ6Txgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355452; c=relaxed/simple;
	bh=LK+eM7ri+qCxrNiOBSntEiCUbg9C0ThQBTKvjOhtdgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oqfo8cJgRwcBuw0mn9OiwVEsKoZh2dxlEZ+5LvyjuOkCbppXQ+NzN5mPK/GD9pRp6lPQKnaVorT3r2so8JAXBjgCr/QDiiqCAaqZZOOhoZ3f5YyTPDdPqzAOnbK2zyjdb2o1jiXoAgX6Gm+a2RxssPXl4NLNDV4vApauBdLrd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e2qxjxNe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753355449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2NCP1lrwfKiTcn3WuPGNaIgWCOJinwqwpt4Tm+WLqM=;
	b=e2qxjxNeJrsFsVtpnU4WV/13/HJ6hrU7IhZllh2Ov6UB3Tps4YZjm+l54la1WqaiO/iLRq
	KCMjfX4gvmNmPLskbS9CO2eiOU1ioSLQ0Zw1EmO6q0yn1FnOIdN4Xkz9QE6hMHwDi3R4OD
	XL9yk20czDC7kauIMx3YiDuVbrLNsis=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-uNcUOrMmOZWXZKYRoeVmTA-1; Thu, 24 Jul 2025 07:10:45 -0400
X-MC-Unique: uNcUOrMmOZWXZKYRoeVmTA-1
X-Mimecast-MFC-AGG-ID: uNcUOrMmOZWXZKYRoeVmTA_1753355444
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b76d51048eso645811f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 04:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355444; x=1753960244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2NCP1lrwfKiTcn3WuPGNaIgWCOJinwqwpt4Tm+WLqM=;
        b=RO8mfgNyhQ/IfphSOpvchL7OAdjDehwDObvOt1GlxcPhTc5HI2EvD/brKmQxBS6N8A
         9LtkPLcjeD4vFIHRxt5KhKa8Sq/it72JSMmhdx6ULXE9YKwSWAvDONW3IF3KrLu/Yqyz
         huvwsZ9wX0dKLeDwgBO2Uv8SVkea6IiXKSx+mDC382laZ7mxAlXK/JKNtT6UcI0jtHHB
         ABalvkalg1/4vE1N6aQA/FqEwgVLvoPKmit9+a4JIZMoBZEgCx7AmY3VMdJTzjk8Zzff
         KC1iPLOEVf3CT3e8HXGm0O3giNoMO8QRjD2TGAys9ggknmtt6ddl8WwuVh0gjAosZjdK
         kS1g==
X-Forwarded-Encrypted: i=1; AJvYcCXlk6EEaa0Mwc6xqFSBi5Bq3LX3vgUlDpZMaCgO1N+eDmSaxfEcV02phQ0un4y1SNSsuVELMPU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6+702+IVYv583dI7/pNWlUh/ht2p8Oq1CLNpvCsIdHotv174z
	9sv+DrQpDMWIYLoMTqEXZbwGvYPmEgEQ+1xQKL00nZT1d7f+t35NROyR9OdzQ/6YPRg/zUm/Hso
	kbfjV3GIiV8lKD2wWpyHnEIiuJVIObTQAemy4WRlSOfWgggsR402ncFX2tw==
X-Gm-Gg: ASbGncsQ6xUx+n8BgQmLlXexx8p1AyQecao7V9HFe3dhPOP2RhO1xwmwZwb7xxdK9Si
	XPx1wHSDceebWMewu9VNgrx3oVW+iwd+cgejJjGvvt++Yvlm0njIE/B4wxcxHmr2yW3eOp1cObM
	2QZ7xbuvDg2DuJZgyvvvOWhjaB4aR+YIrXKBDNQ6x1TA+cVapUC0flGTQpE1tz/Wdz5BVwRBubG
	QENJgkfcbpYRDcNLopkVbarClKb29r763fpR2v9qDw5UsyZjQw19uG2Q4GH3bcyrtuvI497h+9h
	VlDZSYbJFHAG2QkNwHcZj7wDJSVFZ9Se1GtY/LWqmgK13J503NkNqW+a4QiqaSbylDORKrIKa5U
	vzTgoZdxgWHo=
X-Received: by 2002:a05:6000:24ca:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b768f1e4eamr5530367f8f.30.1753355443937;
        Thu, 24 Jul 2025 04:10:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLgvu7WVeFYwOdmE9OOfus6okmx5qDI03XAQNzVJFNryVZLGLzJXFmX0HYKc8pK0SB7TCTRw==
X-Received: by 2002:a05:6000:24ca:b0:3b5:f8d5:5dba with SMTP id ffacd0b85a97d-3b768f1e4eamr5530344f8f.30.1753355443457;
        Thu, 24 Jul 2025 04:10:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587057797csm16591985e9.29.2025.07.24.04.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 04:10:42 -0700 (PDT)
Message-ID: <df9f3f4a-10be-40f6-8409-2ce016d8a4c9@redhat.com>
Date: Thu, 24 Jul 2025 13:10:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] can: kvaser_pciefd: Simplify identification of
 physical CAN interfaces
To: Jimmy Assarsson <extja@kvaser.com>, linux-can@vger.kernel.org
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, netdev@vger.kernel.org
References: <20250724073021.8-1-extja@kvaser.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250724073021.8-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 9:30 AM, Jimmy Assarsson wrote:
> This patch series simplifies the process of identifying which network
> interface (can0..canX) corresponds to which physical CAN channel on
> Kvaser PCIe based CAN interfaces.
> 
> Changes in v3:
>   - Fixed typo; kvaser_pcied -> kvaser_pciefd in documentation patch
> 
> Changes in v2:
>   - Replace use of netdev.dev_id with netdev.dev_port
>   - Formatting and refactoring
>   - New patch with devlink documentation

Since you are cc-ing the netdev ML, please respect the 24h grace period
between submissions:

https://elixir.bootlin.com/linux/v6.15.7/source/Documentation/process/maintainer-netdev.rst#L15

Thanks,

Paolo


