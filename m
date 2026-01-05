Return-Path: <netdev+bounces-247149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC4FCF5103
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE1BD301EF81
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090392874E0;
	Mon,  5 Jan 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0nV4QuE2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7955D2609FD
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767634929; cv=none; b=Z1nERLx1J7msHKP+imeAxCWoQghfX8jspn+A3mqfr31o/krLv0FoRIDr67mr3yyrIk4cXShNbmZ8iZEhOT0x6xrk88mYCinLcpdjQCp6OKKmap2QRfXfzx8Tp2dTlyPesv93PPVqLAE6eyl8DNcGYFexzwxGVdVaYxIIHEQbOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767634929; c=relaxed/simple;
	bh=XwzKHSopkwkmU5ZA0VtSAjG1qDFt0TMlUbx2N4qf6Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMxWTo3fnp0hoXb4yEijzoREW6nD25iI0phXeqfnOthnHl1fHfKqC6npoEL6v+/imu9PuRpveb2o0IPhCUDXy1sOQRoHeKVdYG8iVZ82/G7cdlG5HWz2Dw7kDg3xOrIRNBA4rjssdiBnE3GigZdEbBYCwBKbW0GZ9jnn1t7F9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0nV4QuE2; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-459ac2f1dc2so114284b6e.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767634927; x=1768239727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBPDyBqIJ9DSHP/Ign2dVffJ3+KXedZ9m/saCPRLW6M=;
        b=0nV4QuE2tbl9nh+FRmr2p0ZJBGefT3cUQ+aTayK+AH/dlMYiCpeCUMcaXJJswoGmbK
         5ozPRtwS+yWpf9z6nm9U2n6wgTjwgslA7ns5u44ihj+FgbHGe2XUMS307y0QpjDXdI8S
         NXq02skmeC5RxBvR1+xDRKVZ+Zu9kVEw5Rw8HTjJ+75QrUyzM0g4wgN2qCVr1u/UI0zw
         B2K3Y6j3i8RU2kidXDGZ7h5E5jUA3Evm6ywtd1HGGh+BcpmuySMq35q7oITgOwqE5I9O
         Uwbhqzd7h8A6CscKtQXwUqYlFDTSLD4AahiYJuCOer3GxP3pqX1PUY18bId+0FntXuIF
         zurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767634927; x=1768239727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBPDyBqIJ9DSHP/Ign2dVffJ3+KXedZ9m/saCPRLW6M=;
        b=HIMgF4u6/9B70v5AENZ8JaoC47M4JB+yOBtY4XL/COXflZ2JRxWZkhmQvO+lEYY/du
         p3QBWU8rq/cKbyWUOljqPy6Gww2R7LKbWBrKTFsmuRLcAkDIt551dO0Ne5fol7rVA96r
         thhH9P3kjfa7twPG7EmpfJp9+EZ8f/qKKnPKZK9QaBrPut8xkrK1d1lJ2oJ6oX5s7NgE
         a8MV9yBge9e/CP6kEHvAWaclWHAuCY+jiAM86wOog49Ufc6ve73XFoV0R38j6trg2p+U
         kklY1wDMi+yhrHkFPF7kgy5hNlYJaGSAUCtGDqJlQ8gmelnwdzMHkVmjchIO7ymtLscc
         /Mlg==
X-Gm-Message-State: AOJu0Yw8JO7kAvIDTp/7xUTdnCL1IkI9IOadq+Wh5ZakK8+Z9rYKCn6/
	XTXfux1MIq1sB/S9SwEQ8MTjJE647l5YvUeWkGId2nWWfhxnkoDWDcoXXRdMmudGQik=
X-Gm-Gg: AY/fxX68oC6PIMA24bOjO++7JIsgtQKG3d0Bn7NvFNbT2PEZWG64PvNQBFDX8H6Rg0J
	YDdoHAFfu/uXAlIXilj101/C6ZZLOFs1rfZpC1z/+mnZRKxnSIjjawONvGHAfkYeF3YoMBfIQRY
	/XMzJszmgKQbil7FKR8sLkZzvV0d03piZTAwO9YRxf8bU91yl+dofIJh/tkd3QF3lIIVBssvVCo
	KbYn3eLsLILnKpRf0g5Ym8ETG8hCRPBYaESuThwHpC9C8iZXcUw7ln7y2pIiMkzceLUR/p0AvlI
	rUFj8ATshEMEIeZOey+MKZs9RZ24sXY/LS4k2VvD3pNfYFC/Z9GTQSuTAXjrMmiADuWng1/4eTK
	9IZq5Hzt8qRV9eK/85AyCpb7cijOSuqjw6bTpKXNfTBJ+VqIqrSctcSJyfmQ8tmAd25JKFANWRr
	QLEiUNQKhN
X-Google-Smtp-Source: AGHT+IFD2wQWqXdTt6EI7BDdVd7wK5TmVmcQtg8HICN3pK54eq5klvJnXDbthxpWpsqA7u5/T1uwng==
X-Received: by 2002:a05:6808:23d3:b0:44d:ba5b:ad34 with SMTP id 5614622812f47-45a5b16980emr235201b6e.65.1767634927353;
        Mon, 05 Jan 2026 09:42:07 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5bbb764esm89345b6e.3.2026.01.05.09.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:42:06 -0800 (PST)
Message-ID: <80e2a631-5073-4864-b485-fbe426b91edb@kernel.dk>
Date: Mon, 5 Jan 2026 10:42:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 10:21 AM, Eric Dumazet wrote:
> Also, unix_stream_read_generic() is currently potentially adding a
> NULL deref if u->recvmsg_inq is non zero, but msg is NULL ?
> 
> If this is the case  we need a Fixes: tag.

Good catch - might make sense to queue this patch for 6.19, then?

-- 
Jens Axboe

