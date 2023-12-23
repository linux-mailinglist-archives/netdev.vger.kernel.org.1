Return-Path: <netdev+bounces-60112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE0681D6D4
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775391F21B60
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 22:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C2171C9;
	Sat, 23 Dec 2023 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhn8PKZe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B319BD1
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7811c02cfecso170062785a.2
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703372075; x=1703976875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KaeD+ss18uYM5vcgJFHWDQY5K5ajxUDORa0HE5dva5M=;
        b=Jhn8PKZeSHKwXIG3lKXzMQgCLEPyZctmdFB1qYk3iyhsBJ6z+ZYIhfoUyUDUNP17sl
         mM4SY22dXeEGTQ/4iwmHOUdiXkUAfmzNbInoyx8bi1vMr2F4FTvshx2A1V+ot0XmqFpW
         PbB+QUZgDSwMGgB7cenaQcTxphS+RINSEVa2Yo4zNWfza8d5kjiKZb9pJOaxLtClE522
         ZtGMl7UToLHD763cDNpwpHrhUoGLy0zHn1Yn2teJgvonejh1v45dhD5LQoxvn0r3Jd2z
         qwnuk6lpqhKezejdZmV7uRLutGQK1nU0ur+f3E07mMwAk+MNLPYIIjlCtsYo33svQvNn
         gzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703372075; x=1703976875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaeD+ss18uYM5vcgJFHWDQY5K5ajxUDORa0HE5dva5M=;
        b=YJYp0pb0wFjyQmci57hJwreWX/BOF5RtL2Cyq/uH1z4nRBfc2CkOk8284EG/LnS3y8
         zuK1BkzjnRYkUNZD1cctHTiKp9GCmdtogyF+JSAfk0Nll+P7KScecte992TcZKgY5+LZ
         Jeabu1VTVkhDcM+MwSGmGZjOYlyZHU67sUfsE6pZ+MPPUDAIbsVtTBhrvXSiRQQHM0sA
         oRIr80UFY9P9GyAJ6nywl4FW4tcKdAuKitZyDU5Ai3TPX5qgBeXEgDV1uijWYEtePe0T
         Lb2Moa826As00bW98WChPvK0mf9qvyBECJIXOGvUVM0Xh8x6QNeQUu8NH7UqCrjhse83
         5MpQ==
X-Gm-Message-State: AOJu0YyEtj6l42bKGSBSdVP+4jTi/Z5J9DIj9W2IKRIrhNnU4jlUxxjs
	U8Bga7S3fmwUadicPMFAMLvLpnsjFBU=
X-Google-Smtp-Source: AGHT+IGTIkZt4xQ3sbvtwOO6eI8fz3ih3w32ANFuOjkBJHQgL2ejL8Oh3OI2LW0hZjkRa6gxlTjdWg==
X-Received: by 2002:ae9:c006:0:b0:77f:9fdb:2e3a with SMTP id u6-20020ae9c006000000b0077f9fdb2e3amr4033233qkk.150.1703372075496;
        Sat, 23 Dec 2023 14:54:35 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id a24-20020a05620a125800b0077fb0e09815sm2327030qkl.17.2023.12.23.14.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 14:54:35 -0800 (PST)
Date: Sat, 23 Dec 2023 17:54:26 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jay.vosburgh@canonical.com>,
	David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] selftests: bonding: do not set port down when adding
 to bond
Message-ID: <ZYdlIskJQhAqkBvu@d3>
References: <20231223125922.3280841-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223125922.3280841-1-liuhangbin@gmail.com>

On 2023-12-23 20:59 +0800, Hangbin Liu wrote:
> Similar to commit be809424659c ("selftests: bonding: do not set port down
> before adding to bond"). The bond-arp-interval-causes-panic test failed
> after commit a4abfa627c38 ("net: rtnetlink: Enslave device before bringing
> it up") as the kernel will set the port down _after_ adding to bond if setting
> port down specifically.
> 
> Fix it by removing the link down operation when adding to bond.
> 
> Fixes: 2ffd57327ff1 ("selftests: bonding: cause oops in bond_rr_gen_slave_id")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---

Tested-by: Benjamin Poirier <benjamin.poirier@gmail.com>

