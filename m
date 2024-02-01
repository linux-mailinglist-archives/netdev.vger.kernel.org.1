Return-Path: <netdev+bounces-67890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F4845419
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F52287898
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C117315B992;
	Thu,  1 Feb 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DDbGd/sj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7815AADE
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779966; cv=none; b=gxNX9mUtk/m190oMffPCKSliTYS4cVBWjub+lAof1titYSiLnix6eUpJ81y41s/NmX3okTZD7BkOlLLbiZYacbThVH12zDbTtCggCttTq9y8qgtf0KWg5b6e/ghZJzbWPYF5Xa4s9dpJW6kGjSHus8VIlIR2yjpG8YYWZdmyOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779966; c=relaxed/simple;
	bh=OozUtw8zxG/Vf7BKUHDm5A616p59OTJECXHu3qpShQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKfSoYuryQvJBpxuosPykKmssGYW1JiK3ZSBz+umTHGmJzJzPusbPO5KuzaZxgIL/bn5/rHy4YXP4uA1+55qmwq/A1ZOJxCMKq2IWuxTi2WRixAHi+HuFnW89gelnfPi9GsWxcM2hfXDkEJoHSu3ifNvUVtooxe760vuKo7kyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DDbGd/sj; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511234430a4so1100107e87.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 01:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706779962; x=1707384762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OozUtw8zxG/Vf7BKUHDm5A616p59OTJECXHu3qpShQs=;
        b=DDbGd/sj0x5p7RWUdI9r0wX7moBk5SkOU9JvZIoyc9SMo9jYOgi1Mg6jINz1p22ouh
         ZLoq7pBVun09frPERGbsGwKCogLg3Agk7+Nd+RE6A2rao4Am/zjDrAUg0EXmFD4SsG0d
         /dMDaXuKT/40cwWrO5UHwIJH7sgL9fCDMty4VcW0XyNqsMn+tEhvZRd1fOEwL3wPbNy7
         4ccugEOa/P3fghdoe1773MTmZETbFqvZWapc2MixY1Q4aFwa5Js6KjZ6xjWGu9myPiUj
         q3DuOeciPSyyIuUIlpIfk/NOJ1eIzffWefSQKR/YZcMF8KTzD83TPl0OLgxsOeqZxlsL
         GAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706779962; x=1707384762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OozUtw8zxG/Vf7BKUHDm5A616p59OTJECXHu3qpShQs=;
        b=fxWqZqSzjXoluzNij/ZZNeiMTJN7nxlYPYCJbc6jNEMjCwEEPtaSkDjwjPkhgv34IT
         oNVxWqUKomScImaJsQa5TQkvuq3Yyf4syeRKBci/7inCBlwRSaYBIJzHmUlPmy5Zu2QL
         2hE1PnLRIlD0Y0REfzf7jxnE7IE69In8jazHzuN26Q27c1rhlhyuuEHmlzFMX8ellYme
         GPhjKPdACDdATevmomPiyqlHwwO1ULl0ApFR6WAuL5kt9Wb3CSUvhpfsXLD4QCaEc7vG
         i0l92FzebcoEPsL52ZIS2dB4aoPMShjMaN576jGVPAOKwyeGGvchnuipqXho0I+etkdc
         yuQw==
X-Gm-Message-State: AOJu0YxaGzevdXq4aOrj0ouEL9x7dNNEW1pufQOQnsy3NoDljjklSHQO
	o9O2ChsMzAXOy1P3o+chr/NcPg9GlcoeMVjtX9JCI7/NVlv5MqtqUvdga4sxPhc=
X-Google-Smtp-Source: AGHT+IHWFU4AX7xFvFTWTbfep2pfZ6I/DYM1qp3ASbW7oJjFCHus9Cts12w7TrGzvaHtfdn79D91HA==
X-Received: by 2002:ac2:5d25:0:b0:50f:fe72:2c0d with SMTP id i5-20020ac25d25000000b0050ffe722c0dmr1314765lfb.56.1706779962425;
        Thu, 01 Feb 2024 01:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV99CobyjHtuf0H1poT9i9PegGw0xgQbbPZAT7YGK3L+GNKQ7cOaWCMjlbd5lsmN+eg+g4XQQ3dW2uLm/ZffjFX
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d2-20020adf9c82000000b0033929310ae4sm15664755wre.73.2024.02.01.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:32:41 -0800 (PST)
Date: Thu, 1 Feb 2024 10:32:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] net/sched: netem: update intro comment
Message-ID: <ZbtlN0YR9ZDVRF_J@nanopsycho>
References: <20240201034653.450138-1-stephen@networkplumber.org>
 <20240201034653.450138-4-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201034653.450138-4-stephen@networkplumber.org>

Thu, Feb 01, 2024 at 04:46:00AM CET, stephen@networkplumber.org wrote:
>Netem originally used a nested qdisc to handle rate limiting,
>but that has been replaced (for many years) with an internal FIFO.
>Update the intro comment to reflect this.
>
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

