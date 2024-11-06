Return-Path: <netdev+bounces-142236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6709BDF38
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1585C1C20EED
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D71190662;
	Wed,  6 Nov 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n16u35qQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF751016
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877484; cv=none; b=ZVBhOZejWx/fzhMqorjFS8AXsm8PCBe8Qou04cGZR/xMuZmCFuQPPx1kdb8/QC+H5LPSbMOWAPbR2oQJH/yyfVktxR1VyPiB1aDCjOhyVWoov5bFBrKyJS9/gwKgfz9TChY57MtdXN+aoIijgMItd4L/j4a1iUss7R2hccqD/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877484; c=relaxed/simple;
	bh=PKgfzheUyNSsrrjiPKIHYUoPhyE4D5A590Krsl4nkns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbGsGhcfPFFSqDmZMKwhE7CMirrho4Tdv0ltkAWDG8B3/iUfyx44qBT1z/pMrxfxyVIJCcBfvXnOYAayT4vNjtuilkXLAPEP6gNtRGJqjxBLOGzUocJBU8jyWpcTbzLxHvR9PNR/03Tx8UyEs5CGcgBYTNUvvh/kQl0WIuvDoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=n16u35qQ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 592853F2B1
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1730877477;
	bh=G+MzOZXfDVvVfVLGNe8HGTPb9KTW95XMpmekn3Jk6sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=n16u35qQLRWP0B+UfH7WSdGdBfAbPo2wKd09B73q36Q5No2dj3b1s8SjBdHkO5Tyn
	 T/qnwXufRVaD2e4R7YqBSWGrj7dGQxySTzwc09GibRr+GTsuMfeTZNo605KQhwHtv0
	 nLTmRBsmeBsORq6WBmff0JLqUxHlZp8x1oathNqviEDLNoeneJnaGSMNqBVWf1fCnQ
	 kwa1kzRHFa8y8ApA63LX/e6AD0pMahG1bZGyYbnvflrPxcXbQFrbLFTqcfSh7Uk7tx
	 8cbqgGWqYKYx3Q8pN0+uA4MuwWp1BIflEgJ/H7pU1WsVnB4QoiVn25p1zsKXC00TiA
	 DHxVJ4Dfc6flQ==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7ee07d0f395so7260110a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 23:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730877475; x=1731482275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+MzOZXfDVvVfVLGNe8HGTPb9KTW95XMpmekn3Jk6sA=;
        b=oeEePfnaWq/RKM1F7W4iX1uajtkh51zTeNof2QYFuzBlApnIhRhZ6wyr44fWjlgimu
         nX7hrz8aolhBcg8gqm5FMm+Zzl4S6bB0YxN02Pbz88nlJwwdzBZeo7cKU2jolVR50CRN
         kp20Rz0nNoPm6lOGxft8jDgVSHjwDA35Bkv6PsFk74nuqI508UyfsJFwes1lfAe32S96
         CSsZDfq2CIbUcVOPkaz4ip7gF8v6+5yvIP4E2LuA2GjpqxICl+LaTTPd5b3kC65k9qik
         gl21UTt0mABWc0A56Xg5UWP6y6plq2w+MjTs/D6Q7vcjk1kk9goe5O2772qx2aZoe31L
         VPUg==
X-Forwarded-Encrypted: i=1; AJvYcCUZJXQB9wHElXNzmaajs/dBDO4th7vqGiOW2lnxRNgdt2E/1Z4qjMQQiGz6QGsEange8XLB7EA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnjkirTBE6glrjYaf6LPWcpwOHRxP69njFixpn8xoWXg7YGWI
	sHjiV8/fCd1+HDyKZIVUk00AOT6Qext9UtF3uZP6Y7/AnbGvlB/4OjvKIYigVqoeyzgf/NYZMfV
	b39JpMWdNEr27INjeVQmbWoZqTu1ETh2RJtP1mv0KCn6gD4bFaj/0FNfx0FdOjm46tw6W1Q==
X-Received: by 2002:a05:6a20:72a7:b0:1db:ffb6:ff00 with SMTP id adf61e73a8af0-1dbffb6ff0emr2595883637.46.1730877475560;
        Tue, 05 Nov 2024 23:17:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9tUelPVJWzdT9m3bKFH8hdeibtsRk1QiOwfHeBD4NMbCTVFMQ94vNoTPRLcM3wjmu2yzAJw==
X-Received: by 2002:a05:6a20:72a7:b0:1db:ffb6:ff00 with SMTP id adf61e73a8af0-1dbffb6ff0emr2595872637.46.1730877475248;
        Tue, 05 Nov 2024 23:17:55 -0800 (PST)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c4b64sm10915365b3a.113.2024.11.05.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 23:17:54 -0800 (PST)
From: Gerald Yang <gerald.yang@canonical.com>
To: Jianbo Liu <jianbol@nvidia.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Levkovich <lariel@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeed@kernel.org>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Gerald Yang <gerald.yang@canonical.com>
Subject: Re: [net 09/10] net/mlx5e: Don't offload internal port if filter device is out device
Date: Wed,  6 Nov 2024 15:17:24 +0800
Message-ID: <20241106071727.466252-1-gerald.yang@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <660b6c9f-137d-4ba4-94b9-4bcccc300f8d@nvidia.com>
References: <660b6c9f-137d-4ba4-94b9-4bcccc300f8d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>> From: Jianbo Liu <jianbol@nvidia.com>
>>>
>>> In the cited commit, if the routing device is ovs internal port, the
>>> out device is set to uplink, and packets go out after encapsulation.
>>>
>>> If filter device is uplink, it can trigger the following syndrome:
>>> mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xcdb051), err(-22)
>>>
>>> Fix this issue by not offloading internal port if filter device is out
>>> device. In this case, packets are not forwarded to the root table to
>>> be processed, the termination table is used instead to forward them
>>> from uplink to uplink.
>> 
>> This patch breaks forwarding for in production use cases with hardware
>> offload enabled. In said environments, we do not see the above
>> mentioned syndrome, so it appears the logic change in this patch hits
>> too wide.
>> 
>
>Thank you for the report. We'll send fix or maybe revert later.
>
>Jianbo

Hi Jianbo,

Thanks for checking this, since this issue affects our production environment,
is it possible to revert this commit first, if it would take some time to fix it?

Thanks,
Gerald


