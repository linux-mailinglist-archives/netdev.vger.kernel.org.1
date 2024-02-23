Return-Path: <netdev+bounces-74448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D99CC8615B9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90DF1C2497C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C084A2B;
	Fri, 23 Feb 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRQb9SJZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00818287D
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701949; cv=none; b=NiVG0JuHr+Acc5++HS0RAz/mkobDf/aXSNCw3q0TuBpeWG1uY1STEyVGT4dQqbVGxXrH9AnsW7phRMJgxHBD0GhkE7x4fg/EZ7MNjMB0njgW/B+sQrLO2rKFvsLiq1DQVahpcaoXjkFE8tmQj86VfG7caoPsZRCHQtH6L3JjhWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701949; c=relaxed/simple;
	bh=0k/h1yRRRDAnMUJD9usrSdlevjtmvQpA6Jg9AeExQWQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FUheN7jD4iTSWZGO/Cc8yyh1yDnUgFBSDVtxbxZ3sj+8sLHcvaoZTk6jCc+J3zx5B1yLaWpf8TdO2GZeagF+zufaFh1vuYYZ6D680s3f7ylh4HH+RpmautLtHhA7u2OuRztiMrQjGy9O/C1CnodtsesqudWvh1rpcN+/3HLZlUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRQb9SJZ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d243797703so12503101fa.3
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708701946; x=1709306746; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y89c4YfnFnCcMVOXKEn7lIdF0LyDNwzfLDyBlKJGPlI=;
        b=ZRQb9SJZVQlH3HEqCamO3r4Y8YVLE3UEXAP75394d0cBjFDX4mFjDk/l2cd1jmBQaw
         hl7UX6H3ub+xS9fW3SWwFMJhiDYzjFrHBXMbzmUs+RC1AX7ttGiZFmsks0Q8iRp192lJ
         CvDz/SmWduKjz5jWypNQZkN3QDKrVLkR6XsHUwGhlPuBZQacM1OzcwApm1DAviIUzr49
         MVLfJ29V/1LZnSJNY0bNDjPcZBvv24NVCzfh6tgNTcqaP03qPO4/UUavttLs9YVAoWPp
         Lt2FcAy3+ahifEnpE0B6HaU4DM0MbDCzEvWo/BepeeGHCAC1vkSlV/9XhvdPBX0N7HD7
         acwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708701946; x=1709306746;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y89c4YfnFnCcMVOXKEn7lIdF0LyDNwzfLDyBlKJGPlI=;
        b=QcdUMHxD75wVvHZgGZ6c2gHyHZG1bBRHH8f31vQLLvQmRnZmCp5mip/+gd3FCDNEtn
         yVP6HV4NYIdpvcnueSMpyPhu3upkUTmpvNBnYzUDRWqw4v/TLG3Ap7kFRNH/bIPdSEQF
         Q6Uik9+NvgsZ3OgYDR7yizZBKo8yYTJkT0FxEUVqyfFFW7HsTgo5/btTtpVnoyjGv63O
         1jedNcSMZXCa1baWirpe0w4QLCF5mkVHSjm8qSGMnNUSrcXcOSirp+r9DjRk1HO96h7R
         o9xsdgpCABHqqeOtw4AOYFQ7+Mjpsec56bXha2SRwmLkhDVu9xVdw+G3MQL0QklDj3eJ
         afEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuxtsKsP57/5kFI9nIx58ieYIgqBakA5dcmIGxNOGISgRratNysskN6i5B9wt84ov//ax3gN+D8jRobA+TAeCncbpU5LEC
X-Gm-Message-State: AOJu0YypcNVH42qjNOXdx8c9Qd+WinmDkqzY8B0kIwOxlmIDtPol3O3B
	kgYUKuIHoooEYpqPIMhmbjxSnAlka20hsnMZ4ckG3zfHPCx6nvzG
X-Google-Smtp-Source: AGHT+IHVB69R0ggZookyMnTzmgqpjBLOLwNJGj66aDvWfgpngh0p7smrhA7pUwaUU5V6kB7nsFertw==
X-Received: by 2002:a2e:8784:0:b0:2d2:32b0:c88a with SMTP id n4-20020a2e8784000000b002d232b0c88amr130267lji.9.1708701945628;
        Fri, 23 Feb 2024 07:25:45 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:e821:660f:9482:881c])
        by smtp.gmail.com with ESMTPSA id e25-20020a05600c219900b004128c73beffsm2656410wme.34.2024.02.23.07.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:25:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  netdev@vger.kernel.org,  Ido Schimmel <idosch@nvidia.com>,  Jiri Pirko
 <jiri@nvidia.com>,  eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: make
 rtnl_fill_link_ifmap() RCU ready
In-Reply-To: <20240222105021.1943116-14-edumazet@google.com> (Eric Dumazet's
	message of "Thu, 22 Feb 2024 10:50:20 +0000")
Date: Fri, 23 Feb 2024 13:03:55 +0000
Message-ID: <m21q93s56s.fsf@gmail.com>
References: <20240222105021.1943116-1-edumazet@google.com>
	<20240222105021.1943116-14-edumazet@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Dumazet <edumazet@google.com> writes:

> Use READ_ONCE() to read the following device fields:
>
> 	dev->mem_start
> 	dev->mem_end
> 	dev->base_addr
> 	dev->irq
> 	dev->dma
> 	dev->if_port
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

