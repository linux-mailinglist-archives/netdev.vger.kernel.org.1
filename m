Return-Path: <netdev+bounces-235175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCBFC2D075
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2473B036C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD130B528;
	Mon,  3 Nov 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2PushBVw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312F313E1E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185380; cv=none; b=i48NoY/gSkn/llUgq8Nau14tqVm4PoLCJIcGJFTdhm9XFibBnZ6Ac2sm0jp7CJFU48wYKEMWvTjI3OFnyzupToz16NZlinJV5quKoxfFiRYgXQ2CdBPq8X0eualTHkz/3u/BpsakyzqY3ZPBiMl0H7Bl/zaH7MqB6Upa/Vs0Zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185380; c=relaxed/simple;
	bh=gGXLHaF7e4fny82kAFdlsB4agfRdVFNgMNI/7GgMq5k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W+Y6ciwhnBXoZFJlfHEouETp+g45tG1KyJ/YSaEQd9sb9b4wbNGYpF8Sz1Q94AIhrKWbB98Zwr64MvPXpl17XjRzLUR5rRdVvUOXA8HnAy5cTimmCBIoXr5pSJyHkMRVHbiMWsyYU49YbgAgob43lRwsNf6VLF1XxkM272REl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2PushBVw; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93e7c7c3d0bso464872539f.2
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 07:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762185377; x=1762790177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9YDgAdU/uso0toOOWUSOOo+jH+xe/ikxmfGNGHyhpM=;
        b=2PushBVwbiEzifHC4nhDTf0jBKThaqjXPk045GxaUqihGRB2HjJ/sEILezLLGEGJln
         Nx4bYoPhaWSFUJ9cRUtj2wUSTXzK+9Yg41cKg9666DKVRH2BGe9g0sL9w2sZtF+ubDtB
         fxdnJ7hBubyrMQzKQLDv9j0kO7t3gg4Sd43xmRX0T4s/UQDNLp3UitJg4yJFgpTW71s/
         d1Q9prhfXYcnKHF4EXX1Pm2ispZovU5Q34vSOaPOWtj8gDcc1tD8EHoWsLdh/ii8ViT2
         tXQTUHU8xJ3oIJXBgsikgm3wDy/ZhlnZqogxhfC3V2gbT23a/VK497pMRoX4FhAFDUxb
         1a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185377; x=1762790177;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9YDgAdU/uso0toOOWUSOOo+jH+xe/ikxmfGNGHyhpM=;
        b=Qa0zhviQDDSP3O2m6M5woHDv8wBWK1ZKn8vkwk6Ee1FyonqgSF2lbogkMBBXF3qT8a
         YNOa10iqWIl75pKc2lBxwR8Y+0qWya9etT8degUjCv5C59uQHV+qd3mV90QSeDPfIf47
         dsjQ55BsZPLePJ/0rTmlCBYX0GyO4lsAfC/IC3mAwK1PwklIYfqhiG1MSFwacC7mtLUS
         MAT7TwJoZUk8yRQNP04c+531FYNyA1pv3YIPVpkeVofNg59G7xMm5vFNdW4NX+M9NSbu
         JuKzKzuDSJN7he5ImEOfRt9yWFuBdkVHNFcj6U8QLAeMjUJcm103YkAdQfizYwlLbrL2
         K75w==
X-Gm-Message-State: AOJu0YwRlh1dGo1AJsZEqF0K46RWAJQTsap+7KMNSviWV/NeA5OrCYV6
	z09dL09DBlKO1rDMQZIaWo6Y6qFOfjRusg0GI9GDbdsn4PJHkdDnZp8avByr+jdRo0S5/u1xmAZ
	Ts/HN
X-Gm-Gg: ASbGncvhNd1Nr+L03ZZ+Ul6pNw95TqYDtNcYj+aP+DVlfj/7zCzNL6wzpmlSsy2bVlT
	XznDmL8M/SUXbdhpu/eALHQdnCrZsvUurvDnOITsq5dBa8mCqlg+7Aea2LomKhikLXqmbE3HufD
	W/Wd72zZT1QCD2eerRH3wGOjT4dPrId1h29Th5jQx0V5BnVb3ZabVHaZgzobJEUexoXBJ4DiQ3e
	LDoU8M72KtLyt6lj+//v1hcd4beJYf+dcrmbq1ndBfWTiVgzDnpTeyOssONcIp1whXwIpXq8tHx
	cfZN8+Ttg424VL+Y4JsVuydYDjesGGJr1q2zdCIkqBli0+KFJZyS+GXA1IPmB/siHq5sKbnVLrS
	edSl8OL3H+M+CSvtm813zCpc0AR0kVqWem+Nw4egbB0oiq4iN5bhVBlrYiyDpJl8IPZw=
X-Google-Smtp-Source: AGHT+IGuFezsZMUJsTlRkPOuNfi4qef3irAedHsLZ3STySgCBrNbNoyGoUVxI8tg7r8d+lcYKpJNSg==
X-Received: by 2002:a05:6e02:b4d:b0:433:3115:fdab with SMTP id e9e14a558f8ab-4333115ff66mr40807895ab.19.1762185377383;
        Mon, 03 Nov 2025 07:56:17 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7226b9d53sm277148173.46.2025.11.03.07.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:56:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org
In-Reply-To: <60717dd76d7c38fe750c288a831e5d3a7379a70c.1762164871.git.asml.silence@gmail.com>
References: <60717dd76d7c38fe750c288a831e5d3a7379a70c.1762164871.git.asml.silence@gmail.com>
Subject: Re: [PATCH for-6.18] io_uring/zcrx: remove sync refill uapi
Message-Id: <176218537597.11358.6534904317135875615.b4-ty@kernel.dk>
Date: Mon, 03 Nov 2025 08:56:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 03 Nov 2025 13:53:13 +0000, Pavel Begunkov wrote:
> There is a better way to handle the problem IORING_REGISTER_ZCRX_REFILL
> solves. The uapi can also be slightly adjusted to accommodate future
> extensions. Remove the feature for now, it'll be reworked for the next
> release.
> 
> 

Applied, thanks!

[1/1] io_uring/zcrx: remove sync refill uapi
      commit: 819630bd6f86ac8998c7df9deddb6cee50e9e22d

Best regards,
-- 
Jens Axboe




