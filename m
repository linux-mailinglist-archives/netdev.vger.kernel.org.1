Return-Path: <netdev+bounces-129514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C659F9843DA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024D61C20C19
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE9D19C57F;
	Tue, 24 Sep 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUHEyvQT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF75D19C573
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174618; cv=none; b=nTXbe7Fi11K6t1vDAcPIay4TA2Axu2YmmJsG47Bug77xtG5inOylPC+qEZ25LJb4V/GCLaQS20PkoavacmCKjjRG/7q85IIR2H6K0ViUtsUG/sRvu/e0LZ0RCkctLKdrVFL/v+DV4sNf6fNM8Y1AISjftyvpqyDYSPgTlEIbd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174618; c=relaxed/simple;
	bh=pS0OnUnMHt3x+dQfCCd9DYG82rNOAah6rAoIW93soDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GgAsdiQ0Gg0eemp/yeolk7cnmxY7yssLyBu/BhdG8H+VNPdG1CGLDKxw4Wio8ND7lMkf+blGh16A7liQE0qaCTbhZj5m0MWo48BxxtezoR2GAtcbjyPhZVjK9SXCY0p2mXlNYkEcUGHk7y85AP22sHHJgIn3isytLD1aPvJSz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUHEyvQT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727174615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
	b=iUHEyvQTk/yDm5C+DISNvP6D61b/pv75EjnEWfLa/1FN7KAZX4MdCk1d71JqSFgMkwsQL/
	rH0tBdUjLvw9FBKJ+1xcqa+8M+N3pXWAmsT0cU0nf/1o1fVsp1h5GLYFbng3qKUxm/Kx1C
	xveS9ieW0nzcvz355ZQece42A5WKiKc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-A55BOffLOc6lDkouSwEWKA-1; Tue, 24 Sep 2024 06:43:33 -0400
X-MC-Unique: A55BOffLOc6lDkouSwEWKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374bb2f100fso2379761f8f.0
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 03:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727174613; x=1727779413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNkidy8tP2V0t8BDHsPRxDHfoz+Gz1VvYutaJSQeq0A=;
        b=ube7wKjfFvc9sMt0q5TpICqelZ90qdVG2dA2CO5wW0pHrRMI40uVXd/CIDOQw+KLGk
         R5duJeqwqTpYMYzi5lz+gajspSCkFBHiv7r/031oRxmCpEXKk2pdCNJIPaPguawxhEmw
         D33erOT7CeI1eFpunyM0kFRSbwkQLYU0BDtSdLLhetcotcxQo5iQTZY7485dN2h0+3BZ
         PO/d7ijRBWoDUOPIiW49ORdcwQXv3ezf4aIn1i3cS5/yxKQ9PZAz24Uj2t1NcOKkEWEX
         oedakFsLX1kPXHnPhidGHgPahfcZN61MNQ3rTBIIkCtc6waQ1sygXNuiMHuibTHaOJlu
         u2CA==
X-Gm-Message-State: AOJu0YwT9SEL6KPEW1dN2uWsj5jdUN5hHvN7TH1/veT+WXQQzE3n3/Vl
	HNCDz52ldoWsdQOmkh/cuHrTFMS4hqNFnMJLoIwqHFvEAe+Izv8CyJMNE3gxANygj549ojq9Cny
	3tpekqYBoLmRFCwvktiuS+UjFaFUo+9u4u4hLF4L3mx3hnsyJknLl9g==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608147f8f.43.1727174612668;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0dKgHWPlUM08f7dDvngustiUt9pe6+/LWynepDnxeXHhHsyb0kH/Zt/TQc3YFg2cXenoicg==
X-Received: by 2002:a5d:58e2:0:b0:374:c5e9:623e with SMTP id ffacd0b85a97d-37a42354020mr8608130f8f.43.1727174612216;
        Tue, 24 Sep 2024 03:43:32 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b? ([2a0d:3341:b089:3810:f39e:a72d:6cbc:c72b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2a8c37sm1230316f8f.23.2024.09.24.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 03:43:31 -0700 (PDT)
Message-ID: <0667f18b-2228-4201-9da7-0e3536bae321@redhat.com>
Date: Tue, 24 Sep 2024 12:43:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] netlabel: Add missing comment to struct field
To: George Guo <dongtai.guo@linux.dev>, paul@paul-moore.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
References: <20240923080733.2914087-1-dongtai.guo@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240923080733.2914087-1-dongtai.guo@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 10:07, George Guo wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> add a comment to doi_remove in struct netlbl_calipso_ops.
> 
> Flagged by ./scripts/kernel-doc -none.
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>

## Form letter - net-next-closed

The merge window for v6.12 and therefore net-next is closed for new
drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Sept 30th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


