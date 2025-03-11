Return-Path: <netdev+bounces-173934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BACA5C444
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20511895DD2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96F25D8E8;
	Tue, 11 Mar 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcxKHpPm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE9D1E3787
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704927; cv=none; b=LhjnkFq7fhxAYtojpOL4L4Fco6PX0JwomMzU2/T4bYhScKj2AaeIDt/tnRxBEYocoFSyU40dv2u8/8A4pMTE08+qgCHB6v2gjmkGMGMXmSVHzaqoYq5sB93COe/1y7icXXY5LROK2GPioCoicncLZsa50BXjViBWc+owPUQ7c2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704927; c=relaxed/simple;
	bh=LxjUDv/UM5tflyb5Wwci2kxKo+KfDqi/Ic90JGTEVGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwogY+8WbJcn46zCpl+KACHDUoKbGZo7ADE8pjRchQFtGVxrSVy3dwz13kyNQAgGn3TiGT91D/WddhikcEGy9mrSj2QvgbNw13K/qNynPcW2L/R8O9V8CfpNaDZGaoUXJ5RiJkilWvnigwEvtAnXOYwlKXC/esA1lJjBFRFtvQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcxKHpPm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741704925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPy3t2hyYp12g+bGKcjhtrCXAuWyoMvrseXBSI8ksqM=;
	b=DcxKHpPmmrV2oKOH3tOkyhQSr/tEsSVUx1HXJ09OQd6bp5N+0a2/DN5crefC6HBDsJRYdb
	eG5K+exn1XXc4cveeyzrylC6cfZ/SS7yuM8erJZxh11SS3ZnWAIciD94VqgCS660dQsEUp
	nDJuhyl/jVroxYPBec88uhOWI1+wzt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-_FxgTry3Mi2JKl0kpAtKSQ-1; Tue, 11 Mar 2025 10:55:24 -0400
X-MC-Unique: _FxgTry3Mi2JKl0kpAtKSQ-1
X-Mimecast-MFC-AGG-ID: _FxgTry3Mi2JKl0kpAtKSQ_1741704923
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43947a0919aso47653835e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704923; x=1742309723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPy3t2hyYp12g+bGKcjhtrCXAuWyoMvrseXBSI8ksqM=;
        b=H5vpc0dQZQzXbh1D0nTDe3uFI8CKzzZ1HuWKxKbSgEg1DsYnctfQmQ+GrIqr52SskZ
         t17PxYebBbLjo6v17YT1IhCEuSxSqWcsJacdm32bH5vRf5rn784Ijx44FY5JWjxTD5uJ
         asnoZghLy2E4MZEij77ySUCfKDQKXbBUofNZiNuOHjVKy53JXg/V1fniKmpLaKUWg3zb
         CfFhoj0IqJFIe4Kb7MVKO6LOYSQWKiZPU4DXpm/EZtVybhURG83qcQfzbKm9T95sFUBz
         Vvk0DNq6VU5jkfQ3IrAT7b4TAzDPujdd0PEcG0O9izOjxfzXL+Ox6VPaSn7hddwHRat6
         ga3A==
X-Forwarded-Encrypted: i=1; AJvYcCVH4Elqrao1MNHqgcEyRzQuRU24quBFjafMpPRQIzJaDg2VeS8So+IXLlxQcp3a1aqt51hns04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHOx3v64YZNmYW5DYTsO/mi5fh6v770uaeXLuQsy0cMVPJmR5
	cO2aeiMFKPGbzzSzFpYfe5boTkRw7OUkHV0pT12ratZyFCW/SwNw1hCqQzV8rtjUsLhwtg6TVyJ
	zpUCvSx87hAjlmdc6ffQD/K5i4mGAT+Bx0PK7eA7SKWO1BhQ1qLWDtA==
X-Gm-Gg: ASbGncu0qYK2nFgdJQZa15dLQjQYuTR/q1WL3g103XvgO6UiN3026PHSQIeiiegW9F5
	lV4rZyEjJSbkAWpHjaZtwHl82AF6JQvAk6yl4WG0gN/tkYwHwC+68xhAqBmiH9j+DFFy+F62QSZ
	uUReFzfrbjra16cpkzjZMa0h40n8NcGa5R19idpmmZeN1cMqXY0Z7tHHjV9kEgmG+iP2/FqH8zB
	RceM9m4NQ2TGXqeanz4/CMLsIGyXbLUPXn9FBxLvREy3TJX7aSK9R7ceyH3uvgSNBdapaYSE1iG
	jvCdn6mUHnn3gmX9YBSgadtv/3Nh7IHoad4p5F2D78M9Pg==
X-Received: by 2002:a5d:59a8:0:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-39132db1be7mr17487083f8f.46.1741704922804;
        Tue, 11 Mar 2025 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFfQ3FEGmyoS07jVk0z3pCPYaEtuw1AmA8TfNJieHbK/iCm4OuD5njJ7PAsd/RHkO9FkLycQ==
X-Received: by 2002:a5d:59a8:0:b0:391:2d76:baaa with SMTP id ffacd0b85a97d-39132db1be7mr17487033f8f.46.1741704922456;
        Tue, 11 Mar 2025 07:55:22 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm18264152f8f.0.2025.03.11.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:55:21 -0700 (PDT)
Message-ID: <a5366506-2083-4957-b269-71e0a343be10@redhat.com>
Date: Tue, 11 Mar 2025 15:55:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 02/14] xsc: Enable command queue
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100827.555320-3-tianx@yunsilicon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307100827.555320-3-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 11:08 AM, Xin Tian wrote:
> +void xsc_cmd_use_events(struct xsc_core_device *xdev)
> +{
> +	struct xsc_cmd *cmd = &xdev->cmd;
> +	int i;
> +
> +	for (i = 0; i < cmd->max_reg_cmds; i++)
> +		down(&cmd->sem);
> +
> +	flush_workqueue(cmd->wq);
> +
> +	cmd->mode = XSC_CMD_MODE_EVENTS;
> +
> +	while (cmd->cmd_pid != cmd->cq_cid)

If I read correctly, `cq_cid` can be concurrently and locklessy modfied
by xsc_cmd_resp_handler() and/or xsc_cmd_cq_polling().

If so you need at least READ/WRITE_ONCE() annotations and possibly some
explicit mutual exclusion between xsc_cmd_resp_handler and
xsc_cmd_cq_polling.

Thanks,

Paolo


