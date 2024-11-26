Return-Path: <netdev+bounces-147349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0059D93BF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F628B274F5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34771B6CFB;
	Tue, 26 Nov 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B33Spuq5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D916F27E
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611629; cv=none; b=RGOMGv6pE16U89++FDTHlgMhMq/YNnr4LA2VLfk50BbzsjcUPitYXFdarm9J3VVhlTfXkTTNaXyYmimSqdcZFfUoBOfBgKAeAUo3zYCfQdFzPF18Ize6H1XgjKdBW9CypXITCeT420o2BtuVIr2dXyDETFcDvCPOdddO5W0eiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611629; c=relaxed/simple;
	bh=+7SpuMcrjwJ/YiLx54TrDaZKnKyyL7xaMQsuKK66MEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p77lVpDbaRgMhdBDHK9awh6vQNxwzGrKWtHdweRMH/eiG/Xs1NYSaJ92KyiXcifALDGH7yEZ4gydOenQxqLTQOVKdczE73bPpYhdTBAACju0UfrvJrdy0SaaotIOfKz27/GZZqb/rs2+NtFw+rZNLQ0gl+YP8jWnVMSTyIAAi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B33Spuq5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732611627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAEZZmA0v1k80nlOysurYutIwKXMOWMnay0WZ+kcQrU=;
	b=B33Spuq5Rk8LCDh3ujhY07lP8oBfouL7UrW6Ob15hV33aZQPirCZBefuANn9zh58opDthU
	8wKPxs7uJz0mk53NjAQH0vV10US6IyXADbNOTjwPnRgLgDuueO0Tvup9ss4B5kq6tOoiOe
	xKoKvxA53UGfUMrqdTAZp/aTN81uUPY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-cPZzRBDaPdOXeZJ5L7H3iQ-1; Tue, 26 Nov 2024 04:00:22 -0500
X-MC-Unique: cPZzRBDaPdOXeZJ5L7H3iQ-1
X-Mimecast-MFC-AGG-ID: cPZzRBDaPdOXeZJ5L7H3iQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38240c98b68so2724719f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732611621; x=1733216421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAEZZmA0v1k80nlOysurYutIwKXMOWMnay0WZ+kcQrU=;
        b=gLs5dPAbu7REkNZlg+V43XxZ2AFvBxs+M7/4fWqjPynzX5u40uJXIIAIOAJyoLAVFa
         +J3yNLwSW1zzyI7fAy/pi6+5onrLg8YMKE5OTexNXzc/evJYph2hj0vv+9TDdxEAC9S4
         TxkLQA+7bRI+0bno/1ahMB1QdmgmmzFpHz0250MH0put3m8Pd7PSq/nSud/k+NoDYhDQ
         DNakeucHiX1GwDq5sEF9+8wTIQdpouIAKQBukLSc88wwUrVXC7u8jttPHGOVTRgYI01A
         8EfBsVlyGgRfTB8uQozrLOTLm3vctRK6YwxfkUm1LzP/eT8/pWwL2fvTioeyIf+I+MHf
         yTkg==
X-Forwarded-Encrypted: i=1; AJvYcCUtysSacTEQgIo5KmqiU/+aAdu98eDLGfcS/boQrZAwV2ED8XLNm3fRENCFPNX19jOqBdn/Rqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2sTmmOJh1B5pbgF85m44FNRt19X81SJ/xzU/nNhXmALIzlloN
	p2msLXRRdkjQbNS0fE+R2nVBu+yFJVOcgl2DonIAXwO2S6zLqtn0LI8dLnYOHmeNw8u4sT1rJeC
	fCn8dm4k1tL2BuCUO4ZcydXZO0kjkSvm89xDiwBZ3kfkardOckVbhDg==
X-Gm-Gg: ASbGncvSpnWPiSeuxScP8qlaKz39e3/dAkFk5udAYH3Lh4WE/iuADXKcPbqMzwCANbI
	sFySzsZh9N/WE96j50+gzB/C+LoOkCs8KjZ2vQdHO0q8xwGOxtxoM7/VP0udSTHbe8b5CnWV44K
	z/gkmrxQbDaLEEFli4Wbw6tyvSm5dqjL0ZHI+mo8GwkwVLmHIn8XsSkwd6GwJPp1+tR55wbmdYH
	uKmMqzW2/MMTwn2PF01/GMCI//NqhjHiXNsYrdWArFn2bRV1+9gfebadFl/zKxypysQM3hwm5Uw
X-Received: by 2002:a05:6000:4802:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-38260b69dffmr14125799f8f.26.1732611621649;
        Tue, 26 Nov 2024 01:00:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8jYA0GTdG9hgUI38n8Ov8NGoouv5zqqCEPjjl2QpgvmIaQFxgpgIbKOkHE4UlowpkKNfIEg==
X-Received: by 2002:a05:6000:4802:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-38260b69dffmr14125762f8f.26.1732611621303;
        Tue, 26 Nov 2024 01:00:21 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12643663f8f.59.2024.11.26.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:00:20 -0800 (PST)
Message-ID: <7f968fde-8a41-4152-8b39-72d5b21a19a2@redhat.com>
Date: Tue, 26 Nov 2024 10:00:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
To: Michal Luczaj <mhal@rbox.co>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 David Howells <dhowells@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Marc Dionne <marc.dionne@auristor.com>
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 14:31, Michal Luczaj wrote:
> Some callers misinterpret copy_from_sockptr()'s return value. The function
> follows copy_from_user(), i.e. returns 0 for success, or the number of
> bytes not copied on error. Simply returning the result in a non-zero case
> isn't usually what was intended.
> 
> Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.
> 
> Last patch probably belongs more to net-next, if any. Here as an RFC.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v3:
> - rxrpc/llc: Drop the non-essential changes
> - rxrpc/llc: Replace the deprecated copy_from_sockptr() with
>   copy_safe_from_sockptr() [David Wei]
> - Collect Reviewed-by [David Wei]
> - Link to v2: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co
> 
> Changes in v2:
> - Fix the fix of llc_ui_setsockopt()
> - Switch "bluetooth:" to "Bluetooth:" [bluez.test.bot]
> - Collect Reviewed-by [Luiz Augusto von Dentz]
> - Link to v1: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co
> 
> ---
> Michal Luczaj (4):
>       Bluetooth: Improve setsockopt() handling of malformed user input
>       llc: Improve setsockopt() handling of malformed user input
>       rxrpc: Improve setsockopt() handling of malformed user input
>       net: Comment copy_from_sockptr() explaining its behaviour

I guess we can apply directly patch 2-4, but patch 1 should go via the
BT tree. @Luiz, @David, are you ok with that?

Thanks,

Paolo


