Return-Path: <netdev+bounces-127111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A1974258
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 20:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57ED1F267CF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99161A7063;
	Tue, 10 Sep 2024 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nqk+Nvvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595311A705B
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725993485; cv=none; b=UessI5Cc+CBjCs6Qw1n//aCLssKp9N5VbVc7FDhX2OPZuQDW93jteOUVjbSUqUGVDovh5lkDEkMmJ8p8eQR6uuRejbg3P+W8Vg4cBA2QZNJIcWQi6RBGZNk7mLcVgQzFmrBbd/jc6p0NLt2IvKzHj5eM7LzT8AmqMu5COHikZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725993485; c=relaxed/simple;
	bh=/G60LDplpiUOLNtczH8pAta878ub+rGXfjbZSVUnOso=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHjfspS+qbXdFqTFaiq/FScVNFnGZKSJoHh2vVBbiLbIFMydc6W48jgH0BrhbCtxe/gDASMcnjBZK8jX0eVqglYv4XibgNCDfdYmS2Sz/FFYaaZWh/9ozbOaKy71s6yMyecUSasHwjHd/ohpOpz8huUrEbZ/VxKw1eTDopm+BKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nqk+Nvvg; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa7c3b3dbso197512139f.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725993482; x=1726598282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=Nqk+NvvgFAlKvXjhElvxjHhTLQpNSEED3O/0oPRQbyN0Q+bdkY71XyVi0P+oVBfd5T
         OrZt7Ntol2v8pLyfCLV+8kvdogyF3tkF4hsBdKmhPolLXlrzfoGDkaPuWu+2lBjGhz9R
         jMNHaPf+UWr5Fq9l259RBL221igjsQqrhVJM0J/D+h7i88p+HpHsaOG4TptN+8Rr1/CK
         ou9Jh+8Zp95tpN/fWNWjfrZrjvYxnhwti5vOvmTMZWrXogVWQLkoi0bqXLErgjkF/Xzn
         z4Da2pgpHu1tyk/e8K6e2GaeiNTF3Bu0ernmyO4frj5kpsPj1xJ1qh/+UpEfE7dY+lZx
         Bg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725993482; x=1726598282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+b5/+gHoJMj6mYLwHoTTL9tiXX7JbTcTJlobOiBur0=;
        b=SiTVEBHPnY20M06AOApjHuobxchwgkDtttpeCaXxf2hFKN/PawI8oAel+f0OY0psrj
         SIQnP/DT0ADtdD7mtbQZotMu9KSdkstpu5kWACqokv2Y5uCPIEDJM2PsbYHfNTm5JWTn
         9XYGqVgcxzoEaL2kxa3NOeCleiPmwIy6U6S3xl0hZ+S6HMfrHaA9iuupmwgSftMkhZzW
         cJjOYW6jvPpHvvAl6Y9ejcBSYGmC2IkgRalNH3l/QfLkTOKHPMloN14zeSrLSHfMfcwy
         UBExEXXG0WwF/4NpVzqbIEHr+wm1v8B3gToqwoKS23WEf561MHuTqx+lSYKXgwVkZ83r
         YqYQ==
X-Gm-Message-State: AOJu0YwuFZH5RgMNvdlXBVc2aZ6y5LPrWlyOMvG6iVJqYaP/R4SvWUVR
	ZEdHrX5fYzg+4EZIHlBzb0wWb8YRWfIrrVXKMdy2Hywl0HbWNY8HRSCVlsAJwmM=
X-Google-Smtp-Source: AGHT+IH+WdV06g96c6VJrsu/wXzo0TZ/o6LkDv/UbED5p/2cJsQduOZpv686J9OeofJrMhIYG3IyTw==
X-Received: by 2002:a05:6602:1553:b0:82c:f05f:6c8a with SMTP id ca18e2360f4ac-82cf05f9d19mr666839139f.0.1725993482337;
        Tue, 10 Sep 2024 11:38:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d09451dbe0sm1732226173.19.2024.09.10.11.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 11:38:01 -0700 (PDT)
Message-ID: <c9096ee9-0297-4ae3-9d15-5d314cb4f96f@kernel.dk>
Date: Tue, 10 Sep 2024 12:38:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression v6.11 booting cannot mount harddisks (xfs)
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-ide@vger.kernel.org,
 cassel@kernel.org, handan.babu@oracle.com, djwong@kernel.org,
 Linux-XFS <linux-xfs@vger.kernel.org>, hdegoede@redhat.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org>
 <d2c82922-675e-470f-a4d3-d24c4aecf2e8@kernel.org>
 <ee565fda-b230-4fb3-8122-e0a9248ef1d1@kernel.org>
 <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7fedb8c2-931f-406b-b46e-83bf3f452136@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/10/24 11:53 AM, Jesper Dangaard Brouer wrote:
> Hi Hellwig,
> 
> I bisected my boot problem down to this commit:
> 
> $ git bisect good
> af2814149883e2c1851866ea2afcd8eadc040f79 is the first bad commit
> commit af2814149883e2c1851866ea2afcd8eadc040f79
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 17 08:04:38 2024 +0200
> 
>     block: freeze the queue in queue_attr_store
> 
>     queue_attr_store updates attributes used to control generating I/O, and
>     can cause malformed bios if changed with I/O in flight.  Freeze the queue
>     in common code instead of adding it to almost every attribute.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>     Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>     Reviewed-by: Hannes Reinecke <hare@suse.de>
>     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>     Link: https://lore.kernel.org/r/20240617060532.127975-12-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
>  block/blk-mq.c    | 5 +++--
>  block/blk-sysfs.c | 9 ++-------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> git describe --contains af2814149883e2c1851866ea2afcd8eadc040f79
> v6.11-rc1~80^2~66^2~15

Curious, does your init scripts attempt to load a modular scheduler
for your root drive?

Reference: https://git.kernel.dk/cgit/linux/commit/?h=for-6.12/block&id=3c031b721c0ee1d6237719a6a9d7487ef757487b

-- 
Jens Axboe


