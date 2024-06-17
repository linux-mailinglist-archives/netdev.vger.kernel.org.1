Return-Path: <netdev+bounces-103999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2612790ACFF
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 13:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA78228A707
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F2194A76;
	Mon, 17 Jun 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xk9Nq4I4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D69194ACE
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623882; cv=none; b=Hla4MF2lbjH9uX30YEaOOVWFduJizUkWYpk45PbEx76pssuT8dnD29R6MRlxQ68oX7OxMy2h/jFufffmAR0WIKlqPyNpNtzi7IrRVRGjj2ts06ev2iMcWTO9SHywM1BbfFxQxwdKxS6mmdXYsM1wdC0rQJblCfn7HDELrbqZEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623882; c=relaxed/simple;
	bh=cCoXQV3kYF7W4zbN+zvGdFQuynk8VUtSE0YxweJekic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSQl1MzTfGcqHxaHdqCMyvr0OvRtsIoYBHwxWFZ+9a3dpje4DGRziO9Uny08MoQWc3jc+MijKqtpt6cSViPUQhde4qJuclunQQvD1LoDMEVeOOd4METkM0LEbk3Pyi4MulM/Umb0cQgGYkcPigUdA/tLFqV3GrDldnpsuvhEvGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xk9Nq4I4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4217990f997so30846315e9.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718623876; x=1719228676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TgVC6xwTMFPOUKFAMsWw+F8yDLHqZOwZjG2EMVIlrFk=;
        b=xk9Nq4I4Pmhxl05WUMPKxHg09v1+PVElruoTgX+hyaAPFW4E2PrbOfF/zsf30lGy/Z
         g3KNTg+umlONiMtgXaeghp6ZRMNSSyc3uZoUqrGaLC2TowpeSo4FeBOYiOIj+8sRfKO7
         fohT3pmvg+vwgwObQZ78ADhN9I+atIRiVcRRfvi3cfUa7VNLBoFRszq4KP0aiEMN8p/G
         2LFoCknTELepfWWwqQejcOZdjikD1RKxvCFwp4pNBkWrrsuOZ1kRuMWb2DKZhOqAfrUq
         abH7c+6+Cc6P2cCL1zKMjSKSTo4rYkh47f1yC3u9k8n8xvWCtKFYpXRgdaiPtutR5lpT
         0zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623876; x=1719228676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgVC6xwTMFPOUKFAMsWw+F8yDLHqZOwZjG2EMVIlrFk=;
        b=d9lhJ89xxnod0IFAE7s8Zq6iUcXGK1NvbcEGlKlyDHvRvyH8Ok6fiN4g5C+vc6Mkxo
         OpSAE/V4an34uoRsm8AIbhDX41Q/mqRlzQR7leTaqRXRykv2HEC9t2OU2BU2L7pPFjPj
         jkvMrG4+JMe/Yk7jMCnP/ijx33KFn1klk9vLwwc5d1gPmGKdbpj2NvX+tTBkingt7h6V
         ntIgQ/wHJhqYr1bYVZ/lhU7Xyf0iO5k3BvwzdIdMey13LlW1RY1CkhYzMns4cUhoY9Ce
         Fniz54gQgxy9pXC5oObbSyvdmquuHZ1gJn0N3oF31x25hy4+cUyavyQsUSX8cvYTzzmR
         BZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXtqsKE8Eo3P589o/DiTJAtbe2QTjBX40Y+pdSy9BcWh5NsVeDq6CG8k18Fo90z+VJ8RL7bhPNFYZWkQ4+3/RndAfOJc5Un
X-Gm-Message-State: AOJu0YxZ72zy1Hsd2Etnlsih7gdIrBqXscsO4duojC9Y/i/ty6ZqCubh
	AHYmt+Sj70pW/ZQgu41jOIBqlPmnpT0hceSkDobt0mOAe8uNSs0Ga3eo4+0Pjrc=
X-Google-Smtp-Source: AGHT+IFQdNTBFMjluYuYDNiSDw0jBvXyuET+DmpHPyKJrukjPXm7sadAvuTx8wiCI2gh9SgZquoIXA==
X-Received: by 2002:a05:600c:1d07:b0:421:7435:88d7 with SMTP id 5b1f17b1804b1-42304844106mr87253345e9.26.1718623876032;
        Mon, 17 Jun 2024 04:31:16 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eefa63sm193971445e9.1.2024.06.17.04.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 04:31:15 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:31:11 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: luoxuanqiang <luoxuanqiang@kylinos.cn>
Cc: edumazet@google.com, kuniyu@amazon.com, davem@davemloft.net,
	dccp@vger.kernel.org, dsahern@kernel.org, fw@strlen.de,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	alexandre.ferrieux@orange.com
Subject: Re: [PATCH net v3] Fix race for duplicate reqsk on identical SYN
Message-ID: <ZnAef_DSlzfNP0wh@nanopsycho.orion>
References: <20240617075640.207570-1-luoxuanqiang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617075640.207570-1-luoxuanqiang@kylinos.cn>

Mon, Jun 17, 2024 at 09:56:40AM CEST, luoxuanqiang@kylinos.cn wrote:
>When bonding is configured in BOND_MODE_BROADCAST mode, if two identical
>SYN packets are received at the same time and processed on different CPUs,
>it can potentially create the same sk (sock) but two different reqsk
>(request_sock) in tcp_conn_request().
>
>These two different reqsk will respond with two SYNACK packets, and since
>the generation of the seq (ISN) incorporates a timestamp, the final two
>SYNACK packets will have different seq values.
>
>The consequence is that when the Client receives and replies with an ACK
>to the earlier SYNACK packet, we will reset(RST) it.
>
>========================================================================
>
>This behavior is consistently reproducible in my local setup,
>which comprises:
>
>                  | NETA1 ------ NETB1 |
>PC_A --- bond --- |                    | --- bond --- PC_B
>                  | NETA2 ------ NETB2 |
>
>- PC_A is the Server and has two network cards, NETA1 and NETA2. I have
>  bonded these two cards using BOND_MODE_BROADCAST mode and configured
>  them to be handled by different CPU.
>
>- PC_B is the Client, also equipped with two network cards, NETB1 and
>  NETB2, which are also bonded and configured in BOND_MODE_BROADCAST mode.
>
>If the client attempts a TCP connection to the server, it might encounter
>a failure. Capturing packets from the server side reveals:
>
>10.10.10.10.45182 > localhost: Flags [S], seq 320236027,
>10.10.10.10.45182 > localhost: Flags [S], seq 320236027,
>localhost > 10.10.10.10.45182: Flags [S.], seq 2967855116,
>localhost > 10.10.10.10.45182: Flags [S.], seq 2967855123, <==
>10.10.10.10.45182 > localhost: Flags [.], ack 4294967290,
>10.10.10.10.45182 > localhost: Flags [.], ack 4294967290,
>localhost > 10.10.10.10.45182: Flags [R], seq 2967855117, <==
>localhost > 10.10.10.10.45182: Flags [R], seq 2967855117,
>
>Two SYNACKs with different seq numbers are sent by localhost,
>resulting in an anomaly.
>
>========================================================================
>
>The attempted solution is as follows:
>In the tcp_conn_request(), while inserting reqsk into the ehash table,
>it also checks if an entry already exists. If found, it avoids
>reinsertion and releases it.
>
>Simultaneously, In the reqsk_queue_hash_req(), the start of the
>req->rsk_timer is adjusted to be after successful insertion.
>
>Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>

You are missing "Fixes" tag.

