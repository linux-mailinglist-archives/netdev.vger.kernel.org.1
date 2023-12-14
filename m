Return-Path: <netdev+bounces-57328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48132812E43
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4848D1C21494
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619483FB29;
	Thu, 14 Dec 2023 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHJWHxWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD08DB7
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so77784915e9.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552356; x=1703157156; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slGVN12w7wfrx69yjfmPvEIpyv9TJGXkMd4EzFT7PFM=;
        b=HHJWHxWmTTMtTozRiBqkTkSBEE+3yKErTAKdjapdpQew7Pl3B8Xo8efdRyJjr7qZFx
         e7GWpnbnaLTRaj1MQ80VrjPP/hzhM0YpJE51s6IFHdmNW/I7kMgg18fudex2jEpNKLWM
         NWCBNRuB+cNA7lj/9vY4SsX/JFohuEO2RwW2/idNi/xQ6sxtPrJ6ddGmwOlBxR7cLCtE
         pIzbmAw8HAcN0vNpd81dricCuKhfFdxEz1+YW61JlCCSX0eFf1ErVB11nQdMQXRi4srM
         /yRtYFSu7DUPNiabOnrH0J4cPXpU0JN43YtUFmuMW0Vd8Euh+hM+MfjZbi777qzywnZd
         P+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552356; x=1703157156;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slGVN12w7wfrx69yjfmPvEIpyv9TJGXkMd4EzFT7PFM=;
        b=wfPYuhhQHV2c79XinhK5ALpRTudQcvkQQOUDFyiilFFFPHcR7IWXGmVn8XJrCCzUl/
         bR3pZ0tDKB/1s4m8v+7iXJDhDR7T6u4p9BGfmvodDm8ORnk2ftKRhNbITDEzSXFWp+Ib
         jra4p+WCWr/4NNRIH0B9TgXaRxTD9hEx/HisWZkRrHFhfETRBvElK4TfvwoURy6yfoG0
         m1wIJOwuDJWQKFF4FzlymVfDTAwojOnjgbU2cnBbCrhjbOP2XosHgyD8iRgmIICSJRMb
         wFtSatMoG+/Fcf/4b7z0OAk7DWQzauHMQx4EQxttEyH9peXRRlEDJXQfnigZoSrF8KR1
         X11Q==
X-Gm-Message-State: AOJu0YyHuYx6KqwYgZUqz7C4Fc1aIZ5hXaiWOTNCnGOARYw5mvNgm0XW
	8VECJmyuBAgt/ylbFQrEAd4=
X-Google-Smtp-Source: AGHT+IH9heH1FuWK7VMnjy/RHNknZ4Fr/vCEFwDbBgUUkPE9MJGCpavtogy2hJE4pTdFBFMIAgvfMg==
X-Received: by 2002:a05:600c:524e:b0:40c:3856:5df2 with SMTP id fc14-20020a05600c524e00b0040c38565df2mr5936058wmb.14.1702552356083;
        Thu, 14 Dec 2023 03:12:36 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b0040b397787d3sm20659466wmb.24.2023.12.14.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:35 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 1/8] tools: ynl-gen: add missing request free
 helpers for dumps
In-Reply-To: <20231213231432.2944749-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:25 -0800")
Date: Thu, 14 Dec 2023 10:21:16 +0000
Message-ID: <m2fs055bkz.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> The code gen generates a prototype for dump request free
> in the header, but no implementation in the source.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

