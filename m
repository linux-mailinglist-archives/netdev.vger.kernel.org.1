Return-Path: <netdev+bounces-142305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7C9BE2B8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A232824BD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454061DA61B;
	Wed,  6 Nov 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="YOcV5DRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E61D63D2
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885772; cv=none; b=nyScfybk7+Xxx81tdZG5vNlf5QPNNnm8mfCqfLJSpHanrK+sZYMmwYSfwDvfdSoGD/bS1PzDngYMQbZs2pOtOJtsAx5WYagBsQMtdzeSyXhJctSZcxNUreZeTJ0U6zBYuYwUOfb5/1hOxBJ445gnxAzLUeozQPA1O1LJW+mnpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885772; c=relaxed/simple;
	bh=3vOUKvnOfreuFAxHGPUcHTCrhg6SWNX1a08DlVUzJGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pb2I1sX39HNqLEwA/gas2QUImdam+6u2W8lmEEbmiIQeHgNQwuhfceljjS5CDPYiJWHzvepNOJEscpcOsGxwjFh4b/XyVIwHEAHKJwiRaEqVS89PBqEtGvjxcNaK5UDsty4NfuFHI1Ex2hulJWjMBDzu7sd+4kOERJUBj8r61E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=YOcV5DRv; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e607556c83so3647674b6e.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1730885770; x=1731490570; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/l5vH8OJnrqRXgkQA/vYQVnL0JscbhG9csXji1nC/4=;
        b=YOcV5DRvCBlhn3+10ibksZzXYkOv2ThrYTK6JyFe4j/DKVMZWcrzFtYmkwureWUi4p
         KAIEciPX5DiQNZ862UCFPYq493wYD77oKKE1iq2cvqr+nZ23guV7bU1xcIYjj2i0Y5QG
         TeVOmbzLIO3LZhAe38xclsU7LzLI3zaJmnaxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885770; x=1731490570;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/l5vH8OJnrqRXgkQA/vYQVnL0JscbhG9csXji1nC/4=;
        b=KKffR0Xpn3IzqfPOq9UxTrqcNbWc5zqG3qBlaIKTwkZc57DQe0/tou6i2aaWCH/JII
         lm92kcg06Pz8/5ZmCyBTSipVS0XlOP0i88FOJPJv4072sN5Pgei56VypNybMfPibmYtt
         08URSGkG4nVk2ze0y2sXaet4ATOwSt/EOaCiYSX6nFWgYyTElEszYGbCEtUxrGrl2sXU
         ylzx14fSFa2EHS6TVANwdN8d7g0qR4o5qOHknPuTiuYUo1k4Z4jqpkNI8LBwwLWxdV9O
         B1IoFimekSwidBYMp5t8bwIp/1zRAJCT/yjSCbZO+gElo8NMv0OyGKOAzNH63sSasfC7
         /+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEWHoqj7+0hiN8UiNfAFHArrj6cnlfaniZVledVS8BcJcRjJO6deJuLvQrFSkxxjBiyIjAMBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cP97l2mU+yaEoc8Fml0130E6EAHLG9IIiCBeP53VwLQYgNvT
	mBw5svBc+5WJr+kFTwCpcArK+bO339RoiSO3sXFThs+TRZHXm/+WYKsi60/Ab0Y=
X-Google-Smtp-Source: AGHT+IGnZVoXgrwerKZgrBNt1b4IWnW5Xukz4laU24ynvt1xYZWptXEc1nUA2wrR6Tk6AjrbeFK86A==
X-Received: by 2002:a05:6808:10d0:b0:3e6:25df:2604 with SMTP id 5614622812f47-3e6384432c6mr34382974b6e.14.1730885769706;
        Wed, 06 Nov 2024 01:36:09 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee459f9050sm10850494a12.74.2024.11.06.01.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:36:09 -0800 (PST)
Date: Wed, 6 Nov 2024 04:36:04 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, mst@redhat.com,
	jasowang@redhat.com
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When hvs is released, there is a possibility that vsk->trans may not
be initialized to NULL, which could lead to a dangling pointer.
This issue is resolved by initializing vsk->trans to NULL.

Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
v1 -> v2: Add fixes and cc tags
---
 net/vmw_vsock/hyperv_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index e2157e387217..56c232cf5b0f 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -549,6 +549,7 @@ static void hvs_destruct(struct vsock_sock *vsk)
 		vmbus_hvsock_device_unregister(chan);
 
 	kfree(hvs);
+	vsk->trans = NULL;
 }
 
 static int hvs_dgram_bind(struct vsock_sock *vsk, struct sockaddr_vm *addr)
-- 
2.34.1


