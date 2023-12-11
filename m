Return-Path: <netdev+bounces-55784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C3E80C518
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C0281771
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 09:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B55219F2;
	Mon, 11 Dec 2023 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gZ4IjniD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1E1184
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:46:21 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso394096466b.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 01:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702287980; x=1702892780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xei4Fs8F5vzG7GSLsaxIgBQ24qq9i/olJ2HxLT2JYFc=;
        b=gZ4IjniDQjdciQfHNjngC1T9TKCojU3kpUM4NftpZXepuEsqIo2LZ8OED0dBd/P6ed
         +zpSYAnSvvnWTePbTy1JL7ZGw45ddJnJUedR7/QOrczhdduZmSQ6rWd4uKbi3HfdBN2a
         rMWxEFPGEdelumNpGD4PzZKale0NmzJJFH4Q8iezgH7kpCbCsYsbK/J1N0tMBBZ8C9it
         H+k6dbPW4IxI3baEWmib0qqmulsm9/EEk1CbhXJomesw0JOD/mwTXoSJVGRI0bKS8rRl
         h4by6iJEe2k8jK5YwvHSEXjZmP6zK+je7ifYq3A1Q/wb9XuV5lVcluKR3dHKqJCsOFqW
         pfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702287980; x=1702892780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xei4Fs8F5vzG7GSLsaxIgBQ24qq9i/olJ2HxLT2JYFc=;
        b=dJnjJgE5IIsnWDZshhWFnu7gHdRb+jCqpN8etoZ9Gp7b2uy+mDzJhBr7L2vZEhqCUB
         AhAuqW8X4pVchxOIZRSwkUJEFqT2eOc4SwjwQC9S4/rWxYwhnkDmFkAOcbGrfmtpP8nD
         qlDfY/UF50zsBIGR/yTN7GGxfFGXwYR7QyXayqzsf0HfYcaKt3aLuR7Fxc41jjL9FW96
         KyPLmKA5770Z3MZMYriV2yZ7cUkjGot9A1+lg17YMpo4yHcNLqf1FfGvh5BRbP5YhzTP
         KxjYraHu4utB1AxzvlfX3VZt937029QpVhShr3zyVzo1lXgVfVDQBvfg3eDTCyD/E+3Y
         WY+Q==
X-Gm-Message-State: AOJu0YxvEWW1ZFINxpI/DZIbbscUwVHBqSkan9seuziSdK6GugH9CYy1
	lq5/lUfl5TI4nV2wHlZrtApuZg==
X-Google-Smtp-Source: AGHT+IH/K8msY+Sd8aEiV+oXlbYQSc+VUqKsR26+d+2xoowNlOE/ijN2E9cdEpChMNvpYfOGO0B4ag==
X-Received: by 2002:a17:907:6d21:b0:a1f:6644:602b with SMTP id sa33-20020a1709076d2100b00a1f6644602bmr1337675ejc.59.1702287979826;
        Mon, 11 Dec 2023 01:46:19 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a1937153bddsm4508049ejd.20.2023.12.11.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:46:19 -0800 (PST)
Date: Mon, 11 Dec 2023 10:46:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v6] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXbaauFOfttLCe78@nanopsycho>
References: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>

Fri, Dec 08, 2023 at 07:25:15PM CET, swarupkotikalapudi@gmail.com wrote:
>Add some missing(not all) attributes in devlink.yaml.
>
>Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>---
>V6:
>  - Fix review comments

Would be nice to list what changes you actually did.

Nevertheless, patch looks fine to me.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

