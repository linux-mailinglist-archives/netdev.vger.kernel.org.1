Return-Path: <netdev+bounces-238485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A2C598D6
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 19:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63B064E90B3
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2A311C1B;
	Thu, 13 Nov 2025 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O9r/HWM9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAAF30C355
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 18:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059116; cv=none; b=M8vhAYoCY6xMyAoSP+m0qTrU4anN268WaLZww9hk7Q82978iC15XLy6pKng58BE+6m5tk0MAvZ9farnYuhPNJGV9c9oTj4YOlL7Uu8b/t155BR+JQwJQE7+rQzpVqZidVqROC7XfqdXAN+WGPWsRMrMTsffO5+iYSHEH3GyHcC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059116; c=relaxed/simple;
	bh=kDlvCsYHY4PvuvHz4Fjw0LJZR1qUoiBBqE8f1OArKqo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R/jnvZnFSE2ZXKugesKEe1hcLMMZ6fx9rLmwM025+Jhsq9PcfqajYTkKliut3+K2GDq6llUYDzsgjE7XvZg+FksEz7rUXDfmmdUfXLU8RC4BxoCumSmf62xves9/hnotE3Wlr89DprlSyabdkQIBDf29hbwNjIJTx9NTk9MDAfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O9r/HWM9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330ef18daeso4826515ab.3
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 10:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763059113; x=1763663913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZ8asn9TjK0YeEsuLaSIUS5dAjmbIUfOXXzLmksA6k8=;
        b=O9r/HWM9LndA3mAiCnPSApeEIqrfrZz4BvzOxj/7uYcBKca2W0T9HDOZDdVgrmxIX1
         FHa8pceOfuEYrX7Vzm3Phz+4+uJs7IhVVpUqeaqBMT9WY9sS3U5N2yPOugg9CT/A0uk3
         q7h56zoqeEY11ATn+SmEVMlw3uqygEV+9pTtmjZuZOS2jPkyBaJQ0vLt2KLmFi0iJ4d/
         HkQtCJpjSHjsgqLSkI2Zv7//jiMg4x9weqkE+VDJJO0bCt5hl4Bb6SvxsZ90f3VfCzAG
         Dw5d3Hn7FmXt6GYjXLx6nhAFyURAp5lUvhEIUH5aMaMxqROtLNXpDBaSRNlTDYdriikt
         3JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059113; x=1763663913;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iZ8asn9TjK0YeEsuLaSIUS5dAjmbIUfOXXzLmksA6k8=;
        b=txf0gVEy3GLveB9D3anfuizreO9JaUV9TdhAvHcNeFQg1zNi8IBo00YypJkBwRn5lT
         Zsm6NsiQr4UTHi1NK+5PwvaNTR4u7eahKHBetyymsNTi5+LfJIjbZ4FyeLHBgQN4XC9O
         CmnToTNUA3M4jZA7hsDfwiYAdW7GV28v1os8aG1Ud1Upan2SWDAGAA4VmhbSRCpnrlQx
         W5gH44fFI6UmkS9mW7Y9TK3CJ6r0/T1xU9onpEqLftl0mcdLLlpgJVUpvau5S8GquiFZ
         G+wQkoRIY+zcVfwC/ByTe2mSbp0jxzhM9XL7d7DchxU2MHFQROhgwnW8gC1gknAs9f3V
         Ad5Q==
X-Gm-Message-State: AOJu0YwEpOKFy9EWDfVyW6sAwGOM1DPZfis+3jukT6FDr+5UnDCQeSqT
	ZDZnj6FA9Yp17tpKqQ0m9fRwVbgvkzLNwzUbjOT67zW8WZuKj887woPprClmtwpEicM=
X-Gm-Gg: ASbGncvbtEObHCLlYep1aIZ8Wn7o4RwprhtEXmT4pjWT5xpOYAJiSmdN+ky7lA/pwaf
	7k2jDW24DC1wbFpUm2ACocvX4+97qvLt24hVh3a/KocUtTdmh3B6wzOZCZFddU01ygJnFa1XEm6
	xReyASJwt2MMLRu3Gw+R0qk+lOqSncuT2Wo+bc2sFvFmxoAaB93TB/i0KA5+YyLU5xVTKoqs0Yh
	reqD3amaeHHID/Cwmz6/v7PPGcCWNq2Rj0fgAMMHT+4avv13M5SchYbqFg+ZGvior0PWv5XlEr7
	hRXnu6xg6JMk6g1NbCckn7ctMIZhGq0NNEFFaYhZesLef9Q0OlEGPvFhuPO7lUZudeILShMLTdT
	8cwebNQbf20l59fRpHdBcf/Redq3vTc9fr0VGSGFdmsWG94Uj+d7UUP1/ooNEhUrfrxI=
X-Google-Smtp-Source: AGHT+IGCjKM/6jCsPjIma3yFg9HI/bh4t6XuS3tXvIAYJC0incS19SSSBq9E0QD9vcVhxjpMbYUaLQ==
X-Received: by 2002:a05:6e02:214f:b0:433:305c:179d with SMTP id e9e14a558f8ab-4348c953130mr7549145ab.28.1763059112775;
        Thu, 13 Nov 2025 10:38:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24d922sm955030173.10.2025.11.13.10.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:38:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <cover.1763029704.git.asml.silence@gmail.com>
References: <cover.1763029704.git.asml.silence@gmail.com>
Subject: Re: [PATCH 00/10] io_uring for-6.19 zcrx updates
Message-Id: <176305911172.263645.10047071731407422586.b4-ty@kernel.dk>
Date: Thu, 13 Nov 2025 11:38:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 13 Nov 2025 10:46:08 +0000, Pavel Begunkov wrote:
> Note: it depends on the 6.18-rc5 patch that removed sync refilling.
> 
> Zcrx updates for 6.19. It includes a bunch of small patches,
> IORING_REGISTER_ZCRX_CTRL and RQ flushing (Patches 4-5) and
> David's work on sharing zcrx b/w multiple io_uring instances.
> 
> David Wei (3):
>   io_uring/zcrx: move io_zcrx_scrub() and dependencies up
>   io_uring/zcrx: add io_fill_zcrx_offsets()
>   io_uring/zcrx: share an ifq between rings
> 
> [...]

Applied, thanks!

[01/10] io_uring/zcrx: convert to use netmem_desc
        commit: f0243d2b86b97a575a7a013370e934f70ee77dd3
[02/10] io_uring/zcrx: use folio_nr_pages() instead of shift operation
        commit: a0169c3a62875d1bafa0caffa42e1d1cf6aa40e6
[03/10] io_uring/zcrx: elide passing msg flags
        commit: 1b8b5d0316da7468ae4d40f6c2102d559d9e3ca2
[04/10] io_uring/zcrx: introduce IORING_REGISTER_ZCRX_CTRL
        commit: d663976dad68de9b2e3df59cc31f0a24ee4c4511
[05/10] io_uring/zcrx: add sync refill queue flushing
        commit: 475eb39b00478b1898bc9080344dcd8e86c53c7a
[06/10] io_uring/zcrx: count zcrx users
        commit: 39c9676f789eb71ce1005a22eebe2be80a00de6a
[07/10] io_uring/zcrx: move io_zcrx_scrub() and dependencies up
        commit: 742cb2e14ecb059cd4a77b92aa4945c20f85d414
[08/10] io_uring/zcrx: export zcrx via a file
        commit: d7af80b213e5675664b14f12240cb282e81773d5
[09/10] io_uring/zcrx: add io_fill_zcrx_offsets()
        commit: 0926f94ab36a6d76d07fa8f0934e65f5f66647ec
[10/10] io_uring/zcrx: share an ifq between rings
        commit: 00d91481279fb2df8c46d19090578afd523ca630

Best regards,
-- 
Jens Axboe




