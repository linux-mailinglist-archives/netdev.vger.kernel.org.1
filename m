Return-Path: <netdev+bounces-224313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3A3B83B3A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927134A5344
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377B2FFDEB;
	Thu, 18 Sep 2025 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLZwD3nk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E31E3DE5
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186719; cv=none; b=Zokd0h19ByFmiE6Ye+aXWpKoZc8FgN/FZz9AswQEfBYTmUNhn56BCzKXGKBJFZwlLCdPeswVynjNbntJ1tAzZoQ3ZrcwNauklYWj+eoDjmicmY/gYv4i2DXxiA2pMizL43rcyjat9aN3Jh8XAAaNlInLmUUt1va6hSo+iwQvcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186719; c=relaxed/simple;
	bh=YehKDSxyn3BbBA6CQ4vbBJf8xzzXSHHNCC7si+BTARg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juF8VNdJzwdAdjYa3FJ8d9ROMb5zRbvrpV35tXoqjghAYOKtuUF96ZVn/LdRcqx/VerV64OAnUhn2wp4kL5QB0XKyMUCb87C1nPAYcnCVEIdWGzLOeofWoV3AXVn9dV+uEbQszLiEGU5a20iaYqX8b7J1LY7uvtr4qaM6l0jplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLZwD3nk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758186716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fIIhFJxvx8zBwtE+pqWyod+Uw5u+tNDgcJScnd+oTIw=;
	b=aLZwD3nkAX92Qao2m8Sv485XZwAcVaH0c6sgF8eZRSmJ4VndPW0y6zmWsWtOAUU0tBRuc8
	Ncn/aOK0/KI2ew7WUcLMajT8xYT9mWKMtmNdI7vRAiX93qoCqZtrleAbX4g3pzDPxNaE25
	8nDoODBypbuQVQ97G+u/2g4ttW4ZCQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-p7wexdssPS-XrchSELCeUQ-1; Thu, 18 Sep 2025 05:11:55 -0400
X-MC-Unique: p7wexdssPS-XrchSELCeUQ-1
X-Mimecast-MFC-AGG-ID: p7wexdssPS-XrchSELCeUQ_1758186714
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so143263f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 02:11:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186714; x=1758791514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fIIhFJxvx8zBwtE+pqWyod+Uw5u+tNDgcJScnd+oTIw=;
        b=p+W3G7NJlAWceHl1ehbdtwG9hoEmvZnWn80fhhisZsbVwvdtmDiKx+A9CXBqULlqRE
         z/JRr0lbalkQ3w0jXouVvkeRsycgFLsL4RQCmnpahs6YTl2XNH1SSbdX5Sl23SRJwB4S
         wQnvaG/a5FrRa48vmnsJL7QRQ9dXC27xFdjsXJHs5bsqnY9oinW7+S3/h/WjTXfNzjBI
         atKeLO8eLxpqjqfYnzf8P18aQ/EiLNg8JIlq7yM6kuFBL497WFWZCtFZ2pYT0P8ox5UV
         HyZjekkREkdynCrGHE/Udd/Y5ADoKJOR1ZX5gsYFW/3peoG6cq1k8pdQgd+10uKAXEpz
         oDCw==
X-Forwarded-Encrypted: i=1; AJvYcCX1AxiUFvCVWTNSwMoC79/GZrWE521wm9+y0+JrlzMDkITfbPNlofsnMUojSwU1GuzqlyJsiJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOEQmyl/c/EWIn3UefJMAYuXUX7V+sCKkKYXsTdsW40qMSQzby
	vQGfs62EHCYJKbgvRIXNfYoNHQZ30KwWgQ7td2jPBU7oY/L9W4oaTDFLLimRTPqdB6qd1HpG90B
	e9oWiMX/qrSkqAlsZBHA4cBKYn8/4tTjWxiRUkLwLNYuMIhz2SZYSYOA9SA==
X-Gm-Gg: ASbGncue+dzSYgYBM6Jxmzpv/mOkKvl922/6hepSUve9g3CWB/8N4a4VNH4j+gvxC4z
	0UIiYPWAemicPS2S9LcSxyQof8WzC/wuUW3yPt/us3juMxhLj0CQCy/jD6PaFOtOG065YDcOfTt
	A75LOrEJjbxeRviZVXo1zGIbdlLkXtKm+uOC2JqCQHTiB1w6QOvKNBJ4L8X9xiX3QuW5vXs684U
	UZPYdXXeQ3GDjl6OlFOCTzT23epV8exrMo5V27sr2bjQEwCl9HhNIe1xrtPZMgo7roywOsd5wOI
	kbHfQ53bRzRYm/lRG9Uk2e0YqNobuOaA1B8ysENVDWqP4QH1CMx0/JpW83uzIXckfC3uEBLTiN0
	WzjW5BWkR7Ccj
X-Received: by 2002:a5d:5f95:0:b0:3ea:3b7b:80a8 with SMTP id ffacd0b85a97d-3ecdfa7499amr4439730f8f.52.1758186713956;
        Thu, 18 Sep 2025 02:11:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxFTvwkHZMTFVNF3/CKJIFGtDCQS73vdlDAWGqmaZ0EEiGh4Dz51JVsx1rqLeCvLq5fLFaw==
X-Received: by 2002:a5d:5f95:0:b0:3ea:3b7b:80a8 with SMTP id ffacd0b85a97d-3ecdfa7499amr4439705f8f.52.1758186713547;
        Thu, 18 Sep 2025 02:11:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf3bfcsm2785767f8f.58.2025.09.18.02.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:11:52 -0700 (PDT)
Message-ID: <68baf2d7-fe76-40e9-a255-a9dd41de129b@redhat.com>
Date: Thu, 18 Sep 2025 11:11:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/7] net: sfp: remove old sfp_parse_* functions
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-msm@vger.kernel.org, Marek Beh__n <kabel@kernel.org>,
 netdev@vger.kernel.org
References: <aMnaoPjIuzEAsESZ@shell.armlinux.org.uk>
 <E1uydVz-000000061Wj-13Yd@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E1uydVz-000000061Wj-13Yd@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 11:47 PM, Russell King (Oracle) wrote:
> Remove the old sfp_parse_*() functions that are now no longer used.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Very nice cleanup series! LGTM! Waiting a little more for any comments
from Andrew.

Just in case a repost would be needed, please consider:

sed -e 's/sfp_parse_*() functions/sfp_parse_*() and sfp_may_have_phy()
functions/'

in the commit message.

thanks,

Paolo


