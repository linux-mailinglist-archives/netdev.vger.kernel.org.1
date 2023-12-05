Return-Path: <netdev+bounces-53922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CE80537A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F831F21514
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55659B5F;
	Tue,  5 Dec 2023 11:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Y+YoVLWc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668AA181
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:50:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1a496a73ceso539298166b.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701777034; x=1702381834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vAldGiFeFbPRKXSlp6m6UonxDt3/eyqKTxSoBbozjFU=;
        b=Y+YoVLWcB12It/eesAmwBRmpuU4v553U4fgZbnSy5fZ3wHy2tWnn6CBTmufZO25V16
         gYFcjJ9z0KZg38WyMUS05y1HNfyQRGP2YMJVT/0eGESNNZDZ5BpPoQa1NdLsGZLRhblf
         euAN+c9vFFgc69Jqr5ZBiG/v8HtU4uGZMoYY+gydr2KW8VDE8MXm2msTO33d1+dnVc9L
         81CEDW5xhhsRO9NvCy/2vjkQK9ppcxBi9MJqTbLnksnrg6Ix5gRX1zZmRFahGr+Mv0Dt
         xfMltyY0htpj84+nkAQadJhGTQSYhsciRPEzG1/yWIWh8SYKEL4ATCu20B5DaEsrdxld
         1bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777034; x=1702381834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAldGiFeFbPRKXSlp6m6UonxDt3/eyqKTxSoBbozjFU=;
        b=EXshgiiXU2PhxKKKMOP1beJAoDJgqQf3xcxu/XV6/f0p/XU3aOXXDmb8q7V50RHz60
         Se/E4yzemkJ+O1F4P0RLyz5Hjyx0MIlD3t9pQIfl3xwLop6joHrcsozfbiUxGmGVki0V
         tldpB3EBnBJCyx6hUdJ4+CTMVHQYsXl/qzmMfFDnsf42Pe/u5U9ryWS2jksWIuf5C8tX
         xpkkdHdNHhnAmhWZQqNcavDTW+Y8seX0r1Ace/m1SFCWp8Shv6/URT/CLygLoD1s4o95
         w3hrwKIQwP5zpPkp6QSV5UaueOVBLcMZbQ2VXZ6wHzHth4tHHslXiUiFDAshkhDQ4Kcr
         sWug==
X-Gm-Message-State: AOJu0YwfAkzWqZ+TJ3ftzSLJFyKmQQbaPqJfBwFlk2XD1RHx79G0ZozE
	UeQWxBBQdtqePOEJhQMzpEWjhA==
X-Google-Smtp-Source: AGHT+IH5+80yQ47HHsYrVMfhNJwQtDhRpw1a3jPCev48ud+9mlzx+KzgOfPFESMozqiO8BJD5FlYeg==
X-Received: by 2002:a17:906:ac7:b0:9b2:cf77:a105 with SMTP id z7-20020a1709060ac700b009b2cf77a105mr398586ejf.15.1701777033886;
        Tue, 05 Dec 2023 03:50:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id hs22-20020a1709073e9600b00a1a5f7bd1a0sm4274716ejc.30.2023.12.05.03.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:50:33 -0800 (PST)
Date: Tue, 5 Dec 2023 12:50:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, marcelo.leitner@gmail.com,
	vladbu@nvidia.com, Victor Nogueira <victor@mojatatu.com>
Subject: Re: [PATCH net-next v2 1/5] rtnl: add helper to check if rtnl group
 has listeners
Message-ID: <ZW8OiMjYQQClP+D1@nanopsycho>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
 <20231204203907.413435-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204203907.413435-2-pctammela@mojatatu.com>

Mon, Dec 04, 2023 at 09:39:03PM CET, pctammela@mojatatu.com wrote:
>From: Jamal Hadi Salim <jhs@mojatatu.com>
>
>As of today, rtnl code creates a new skb and unconditionally fills and
>broadcasts it to the relevant group. For most operations this is okay
>and doesn't waste resources in general.
>
>When operations are done without the rtnl_lock, as in tc-flower, such
>skb allocation, message fill and no-op broadcasting can happen in all
>cores of the system, which contributes to system pressure and wastes
>precious cpu cycles when no one will receive the built message.
>
>Introduce this helper so rtnetlink operations can simply check if someone
>is listening and then proceed if necessary.
>
>Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>Signed-off-by: Victor Nogueira <victor@mojatatu.com>
>Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

