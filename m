Return-Path: <netdev+bounces-112473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDE939677
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 00:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A1A528217B
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 22:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BA93FE46;
	Mon, 22 Jul 2024 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2espImN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4B381B1
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686902; cv=none; b=sugI0VCW31lRn0M/27jYrWaS0KN6B76/tfavXPelTTPWrNmBqLOS0AwVUOOTix6N8T9Ges3oj53BXbrLfJT41U0ggfJY9EMQDzVIPlShZm4Tp/FokowocvJ/zqzEX5CTOxqFkfznBsezXu25wdDTVT376+tIjIqFs4GtFI3aw3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686902; c=relaxed/simple;
	bh=34HtSC4duPhf+8JCQbGf+fUCRFdJigXMf/wWHTIHDeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nF4xU+dqT/wyPGBpWG+w8gywNHQqwK2dUcQ/Yb+BJMHigDRjirG1RQ2sofF4w/l1QxsloA8mJM1/gbft0UjxWA0TQ3uSutbq1eqZIqz1tuJZMK+yXAemA9Akh6fcfWQg0q0i3N5mZrag95kN1PUloIZYzIaAp6HkVsZfwMU46PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2espImN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c386a3ac43so37890a12.0
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721686900; x=1722291700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=U2espImN/kPsCHZbznGWrO8qY5uFiuMkyF5juS6aLqDjSgJ7FJzi7fEJ1Dy0V7PAVi
         gBfSnQgp30/hARg/uio5lqpLqJVaPmlFBRUMFBv8+r+Hm6OJmyeX7YI9HwqgXlymjx4S
         c5LN5YKsrMOWcTi+v2ogYl3Vo2F7oxhzKtwbzAttGrdux8szT/DebBdBjuBD7XjZt0kP
         J2TW30lvPN6JfO1C6w4ELbER3oszH5Sh/PePfCrYaUo3xUs4nz6iqtib/PkmAEVTGiJE
         ARHqFEFBYeAh6TkTwknAigQi9Rbo9ucwor2WorhalcwIiHbA6wQNKh9s9Mz1iSdgFokq
         hHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686900; x=1722291700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=dMXUcdhMVe9TuoBfK+1LrPZ5KADCpPWNPIxfX1JNcUezwXWAcy8P7Xo3ztsCD0wa4d
         oSYBLhW43lnlz+EZ5Zt0rs+RqTsq9kf7CpPsrtm5u+ZwOuTaI2r20p5QcpGA5QlxBPcZ
         737Bd2OUnbGm4fQMguLiVYxl3iV+zMfrKZgeXVqky21IRB3hWSYvgTX9R3O7sgKD72uc
         7oLQS/I5d1kgboBKGx2b8BU2q0kXv7xPNCFtgBU1IzqTJ+j9hObv62YxOm0nOufjXinm
         ceFQMv8wKslF9lhs8ga/q0aDJbtAStW42lThsuzagJnih8nFBQrkpGAUglJ/XtdHcJoL
         9+hA==
X-Forwarded-Encrypted: i=1; AJvYcCV34avU35/GQNp/yaGYVWhMJ/BMNkawafYiJmB5AEzid/yMU9srpH6C65jfyXJJ8APWsFydkvkoJ6UCHnYYnv29YOPtwa1Q
X-Gm-Message-State: AOJu0YwDPTHUO5M79lxAH63R5IUU9BvPv6o9XTr/6C3B3QIpMV/3CpLY
	t7FHKDTEjxXUgG0xYAaWZLPGCx5FyJKFbQ2ob3UEMHc5SV6bnwpfdONa4IJ3k/4=
X-Google-Smtp-Source: AGHT+IGScHD6XHoPrstmVFPw+Xo8947sWS5UFvpK8ufwAvqfdOvxadY9ZmmXoO25QdpiwaLvvRLgSA==
X-Received: by 2002:a05:6a00:6006:b0:70d:2cf6:598 with SMTP id d2e1a72fcca58-70d2cf6127amr2260050b3a.5.1721686899902;
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1fc869cdsm2974888b3a.170.2024.07.22.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Message-ID: <0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
Date: Mon, 22 Jul 2024 16:21:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Who's queuing up these patches? I can certainly do it, but would be nice
with an ack on the networking patch if so.

-- 
Jens Axboe


