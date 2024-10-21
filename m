Return-Path: <netdev+bounces-137577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1879A6FA8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFB42868A4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889FA1C3F01;
	Mon, 21 Oct 2024 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b98IisYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359F2F4A
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528598; cv=none; b=Th3T6Osrq6gZNF8gZS3ePJFX7wI7/5LBwSpmbmKaVu8CdqwVriHto/mibzsUA+7QBM0Xw3JYo6E23svKrwP14XV0zqk1AxKCfLq5AU12qtcWIVEKZ1z8EExX63mXyNgI7GcdgjcrrlpiVgnd4Q1EyQ63LRU9UFfTWgS9Y1BABGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528598; c=relaxed/simple;
	bh=LF/v2APQUH1XNOf6nW5RuGpUkrh2C2KCHmydIhInUF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9UOkhbgAVdZWoNZJq+ELKub6c7nfUpIflV2bddCYAd8SWWk9273XJ2kxTYdGFDVtoj0SPn8MdpSjjTmAB9AV0QdoTSQnW4PrvLrF3nRSrW9MWzl0BK9bbvtzJCklHCMlj5jFBoS5+c2Vg4VoI4tQr85bsbCv/EX/s8OGc6q6NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b98IisYM; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83abcfb9fd4so123421639f.3
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729528594; x=1730133394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=b98IisYMoDYKIMCEWfa1BBvRcnhZPARN609lDC/X/ujP4oDniAF3VDcuyo+2yAXPGQ
         pffp5+v9iWxEhhSqIgaX5ZAD6KS2gWxOHOrIO6ErPF5M1iv3Ajst70Lt+yGtO+3v0i27
         NHlWjSMkE9keS5fGeif85XsD539y9rdvTQG9xY6Xg+H8+VVMRhwJOh/o2eP+ROM086Ej
         r5cn17/yaztZGpF3I41+4kCYGlwrq10uvh9eaWOv2vJIVpWj/QgjsxzqEz/OkrX++H6w
         nKxYvQvCijR2aDTtj/ARKZ14RC+Izn4KVeploeI6iSlezuyoeGg1nxogw3KX298XPhMa
         1XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729528594; x=1730133394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpdiAit/JMF1gHPpQc8Fla49evuVYP+pTUnVRIxMK3o=;
        b=qBOIkzPXEz2BAaf/vQ6CBz+CgFXg/Mnsu1T7LImPZLNg4CQ9wvEkgimLDu8o5ZABpM
         LuQCVl6cg0fScQofrSxOBhvhly2CH+DpZTYJrmuta6jXnjlFzhBSsji4ZFitPPoLAACn
         SRlN5NEScpBKCxbrRj4h7zttr9utMFsHb8FaI9Zg6mUb7oTBlW0RjeqzMGRkLNh3Fgdq
         g+DLZExQni1GZTUFvzxuTp2yhVxx+cXUOrPkqDJyu2oyr551e1SEIkCgJd1LtR0MBulF
         CH9zdjX5MXgC+Nz/SnQlrVaM9lqGETomZ8dJZH4k1K3NG8KRHlCO+WeZrnOiKG4Z+G5v
         YwZA==
X-Forwarded-Encrypted: i=1; AJvYcCU1rKfxNuwDoFl6Rs9QPFLIG4HO2saep0ic4nj5mUmlVdqlym5T1ZZYoT3RT3+of/gpG3biaS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuL6wPumwXNOt1F2KfmjDiTEgNKNYkn8loeBlzPDyizzUkLThe
	72UjojowYZY+Fk1XYR+pGJ/sIH1bo+1W6zmKUQNDlKVt9cC7XyjGknD+vxAYKxw=
X-Google-Smtp-Source: AGHT+IH8sxT/2fAb5kxlReNE++mbPam1BiFBGzt9LmVdzUVOqPu5mbyUeoikCKAH7Uj3d+kmTueS4w==
X-Received: by 2002:a05:6602:6427:b0:83a:a82b:f861 with SMTP id ca18e2360f4ac-83aba678bb8mr1156493539f.16.1729528594557;
        Mon, 21 Oct 2024 09:36:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a63022fsm1096005173.127.2024.10.21.09.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 09:36:33 -0700 (PDT)
Message-ID: <440c7c15-22e8-4782-9faf-0e9412bc02a4@kernel.dk>
Date: Mon, 21 Oct 2024 10:36:32 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] io_uring/zcrx: throttle receive requests
To: David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241016185252.3746190-1-dw@davidwei.uk>
 <20241016185252.3746190-16-dw@davidwei.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241016185252.3746190-16-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Looks fine to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

