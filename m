Return-Path: <netdev+bounces-66876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCF8414CD
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 22:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A653285F07
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3114156967;
	Mon, 29 Jan 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wCueI4yl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143C157031
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706562165; cv=none; b=oPPYJchlk/qQxiVgNyMvgxV/Cw6jzqe0HFHlPBSnpDNQy/PvWtBd3q2xiGsHCjGgpQi5QtV5rA+iwHW+wEkFdpbGjTHBri1lvodtDBP2L1nKCXVEzD5eqJr13gshW8Q1MCJXpiA15RJYwD3VJWmagi7Ok0BVUBP/gEad12OzHsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706562165; c=relaxed/simple;
	bh=fuQJHSmAUN+N2OcFxlfNt1MSlNVIOxigAXiIzDiMPQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0koxhg4z6iqoD//mgDTEGSVfG1sX+m4jTlVrI2vEcIZruFAM9NGQrf4ohK8VBKpS9m3xKa4GN0kuRkTn3D8Xt5rgCYgnkBWAdKDknD1i58Rk+ZjaSTv89SQ+DekFEtyiDibByf+eahQCN4vYP+rkIGgRjtc5Bx0o0PpA5aQNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wCueI4yl; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3637e2c3a66so1377035ab.0
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 13:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706562163; x=1707166963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fPCKzHfjOljFne6umdciFLk1CUCJlgyTBXyzSfG/jrQ=;
        b=wCueI4ylT8YiCX5owZL6GXvjj6OjU7HJ6K6X8oyryjjNWG2flfQ1r9Iysvd1KjJ/P2
         OSe+accJzQmHhdk2cL3/szgtZaUKQbiAMf/KPcdm93mO+9UvtvtZ8fuBI1NLf1afCaHL
         5TJsc1MVE0qZWNCzyfYi3tvpUumdI8g2uAR1PPndk6ONdUEPPTBTUyZFDXURzd6+tZnO
         pcOW8zhlo6E8zImmrpCdmKTEYFsqMC2jDeoww/9wqhJi9zn87bJDs6dFNlEcfuRsB5Oi
         ReSryWjpYgpcxZN66oou79sj7T8IIx4k3iOMALmxc3OJDUCaOT5p6XWNsqgr60BNf4Ud
         1fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706562163; x=1707166963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPCKzHfjOljFne6umdciFLk1CUCJlgyTBXyzSfG/jrQ=;
        b=WJXmrR3LnEar0XlkGNOFfxi85ig/bZhqeNcxGP2OknLUdy6HzDUg5aBOnDmJPJlX/e
         xqkuOVbdxEje/JTiXvBz4vyEc7mIuH34iqVLu/pRDKHGS3TtY/JkyIfGwgnq09w5CkQg
         9cmo5qJC93EMRwAIh6ej7PGnxqVi7fjLvSiJu3HJLnMBv9Xq/Lx39+lGSDSd50/MRAPk
         Fb1/7Kf012SR1Q4YbWh6aHFqdKWKSOpVL22nNyhpsNlAbwMVGtkPXgVegdima1wjz9Bj
         BGVSNCLXMZ6tb3JSozKE+CnYYJXt1zVlDJnQ1Bh4pDdDADBgB/+Y1yoQiSGwyZ2l8nax
         a4zg==
X-Forwarded-Encrypted: i=0; AJvYcCULLl1nR+aSMoLUpQnByNnNLEJ42lnimbGPiQ+0QE3t5VwDNLlcVTfP/I1VNidRFtKnx5y6piNDcUwh+ppCyHw7hifF572O
X-Gm-Message-State: AOJu0YzcxBUFSi9IFN9LohJ61WO4Xr+CJBInW4/A4tnOEPecWu1Xkd05
	cjb0Dj8FSZfYt0iDaSSRfAIU8NBGZjjpfcyiaBU0p065IL/QT+mD24IYd7leSVo=
X-Google-Smtp-Source: AGHT+IHE3XsCbka4MQnp/FDsiFvrgCkZBkB7Pd+w0wif0yAgtaT+aSrVgnRkVCIHK26IyaZ51pR4oA==
X-Received: by 2002:a05:6602:2352:b0:7bf:dfac:316d with SMTP id r18-20020a056602235200b007bfdfac316dmr6699714iot.1.1706562163158;
        Mon, 29 Jan 2024 13:02:43 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h21-20020a056602155500b007bff0512bbdsm955274iow.52.2024.01.29.13.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 13:02:42 -0800 (PST)
Message-ID: <9ac6ec6c-9d11-441b-bbd6-235befecab5a@kernel.dk>
Date: Mon, 29 Jan 2024 14:02:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 0/3] af_unix: Remove io_uring dead code in GC.
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20240129190435.57228-1-kuniyu@amazon.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240129190435.57228-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 12:04 PM, Kuniyuki Iwashima wrote:
> I will post another series that rewrites the garbage collector for
> AF_UNIX socket.
> 
> This is a prep series to clean up changes to GC made by io_uring but
> now not necessary.

Didn't look at this in detail, but it looks like it's just reverting the
changes we had to make there originally to accommodate io_uring. Hence
they are fine to get reverted:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


