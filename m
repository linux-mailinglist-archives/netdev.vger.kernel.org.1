Return-Path: <netdev+bounces-60822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8742782196B
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 11:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38AA11F22186
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C4D27D;
	Tue,  2 Jan 2024 10:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ScwrrE9R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4ACA6B
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50e766937ddso7164222e87.3
        for <netdev@vger.kernel.org>; Tue, 02 Jan 2024 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704190101; x=1704794901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eAtZ/cLbKc8KrW9U/GX6Jr7XKhavaISbuyhZEe+m+eE=;
        b=ScwrrE9RawR3U0szKPvz4Cr6ti9gn3a4nHvZdQJYsnrU0nsGzrXpsvq48nqh/MshLp
         Gzb93kF87+ADMnq4WA8n8WJ62GhCFOfhONKi+oyO0YqdvoItMqE6SKAtuSAUeDToFINz
         4SVkPULw7K3r060t1hGrdOpX+xF27bTINB9Td8MRGV+Uyn7P53YsLKaX3WPUbPuxGALH
         1bmGS7my0cca/Yvo/F1BBz1wmFRvk8sf61MyDYXvupEE592Wqyfqm7gKL9+MzRaLL+2J
         8CxXepWBp+0q1y80XzhyweeJHBJwhzgJHWecLLQJ6LF64zys6iPqM+m826DB6NzkqR+3
         X5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704190101; x=1704794901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAtZ/cLbKc8KrW9U/GX6Jr7XKhavaISbuyhZEe+m+eE=;
        b=DUvsqazWa80kQm0I5a4WYQ5FqLPI5oWhVYTpcIlc5k9FhD0z5Qy2lxHRUOAi7AHlzd
         e84JVe4IlA8h36EFQX1n9o6mMJYw5DwfX/0JC8cTlWGAmqq3gsS8w8zrl/2KA+MYphYv
         rvhH8EbPD4hWjQ266AlM7QuEnRo9wo5JrbsaMCgTqZq3vTfX39qhFWEk9KNytnwBjLkx
         Y4A1zn0bFDsFleIdQzNlpdOnLl27QYySTREriqMs8sAwtDGD/wwascffwFWZuYu2jR+r
         XmIlcfWJTwMPnmVbEGJ0TkTmMYEwNNx8v+9v4QxOxrcx2zvIddNraCv8afyDxEjBaa6x
         0gSw==
X-Gm-Message-State: AOJu0YyPK5Fw6uSdMRlVggv+itpiWLpQrCluBH58oOdB22/qvEjDJQHe
	gGPUepu7IoSNu/YJPJdEcwDfikANL9IPOw==
X-Google-Smtp-Source: AGHT+IE2mR6lqs7hEq/27M1sc6LtwTkvrnGtnYSFSdGG+/HIgINj2ipR2TYu6xVLxoJFnjeDuHETsg==
X-Received: by 2002:a05:6512:473:b0:50e:70b1:9544 with SMTP id x19-20020a056512047300b0050e70b19544mr5825234lfd.111.1704190100956;
        Tue, 02 Jan 2024 02:08:20 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d15-20020a056000114f00b00337464bf71bsm1770277wrx.39.2024.01.02.02.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:08:20 -0800 (PST)
Date: Tue, 2 Jan 2024 11:08:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v22 02/20] netlink: add new family to manage ULP_DDP
 enablement and stats
Message-ID: <ZZPgk3mrEkciwI_7@nanopsycho>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-3-aaptel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221213358.105704-3-aaptel@nvidia.com>

Thu, Dec 21, 2023 at 10:33:40PM CET, aaptel@nvidia.com wrote:
>Add a new netlink family to get/set ULP DDP capabilities on a network
>device and to retrieve statistics.
>
>The messages use the genetlink infrastructure and are specified in a
>YAML file which was used to generate some of the files in this commit:
>
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    -o net/core/ulp_ddp_gen_nl.h
>./tools/net/ynl/ynl-gen-c.py --mode kernel \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --source \
>    -o net/core/ulp_ddp_gen_nl.c
>./tools/net/ynl/ynl-gen-c.py --mode uapi \
>    --spec ./Documentation/netlink/specs/ulp_ddp.yaml --header \
>    > include/uapi/linux/ulp_ddp.h
>
>Signed-off-by: Shai Malin <smalin@nvidia.com>
>Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

