Return-Path: <netdev+bounces-77068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD7087008B
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0751C2108C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186883B790;
	Mon,  4 Mar 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp4k3BGN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F1239FF5
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552488; cv=none; b=Fd5fztQ4ALaLGPJ8u4WV+epOBk+JUA95MnPCxo1nIFrjadiphjD3DpDGD5cSz+jnnUUIVKaViyUZDKS/g+HrGY/cZ6ivNwLGoEgPEluVZ+QsTmhL7UfLSmWwrEVZo8fTWa3WeMeFhUNUIYyui341/I6TfvU6/vxGF7OW1IpDYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552488; c=relaxed/simple;
	bh=ECOOOlGq8QxJSGHW+TOeLI6WOndQjKzHe4+Y3ZdOI+I=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FfPR4aHT4+4gIhrXXb4XhOs5Vaj5hhJe9/DIMn/Zf6OaZduNI5voxzHV79KoWVvytR2PZ/MJVFk7E6eXlRHLxEQiUdlxNqncGMb5/yPE1hVblBY0dWZb5ZdHQiogMRsjzIBXSI0GYqy1RCsvdlkeDIGZrXJBn2CcjD4xd9wacsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp4k3BGN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d29111272eso69170101fa.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552484; x=1710157284; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ECOOOlGq8QxJSGHW+TOeLI6WOndQjKzHe4+Y3ZdOI+I=;
        b=Rp4k3BGNFULPgAlRIGXJve8DRZQB6jjUticvwanbehaELCu/WmheDi05mZF95IFejd
         N0fCUa/YdbJaaO7+SKSNYMdMhG4rED28TPVXdNYeRpye6HRZusIXfGMm4KnA5smxzivl
         nSJkTFDuMEzYmF9VB7ilwSrF2dnC119mSU4huCQCZpDIJV+3ijPgtBFBKEavY6t4Xeg9
         TqmdVAwMbRCyDre0K0thzxV6dmpZnC5874eh4NA4QJZMjEi4JWhNOhWRgtXB+hTCWHDF
         oAFfapQZURHJNk98bZIlv/+JwN6NvPhAiI4g9lZdO1sIA08tf3HMjPvT/Md51L/Alb/C
         NdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552484; x=1710157284;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECOOOlGq8QxJSGHW+TOeLI6WOndQjKzHe4+Y3ZdOI+I=;
        b=OsVjbFSLc0jtlQEv28T8A798hFHJ5+a1oHaRd0eP9dXbuW8rejL0zlXU+0LJH7E0PK
         SNBLH9JIWLGigtQq9lxAWzMKG8rjIDrEkazJPYhvMU6vaTA/YXr26sZx65PuJu2P1dtI
         IW2pWmjU5nPQaa7tVoxwEYFlNma6c7iOaDwDXxxAovScPWgD+D+b5Ak5STTArB7oPLPT
         WoAXDc4tv55gOsd+UoMaOnETcwxghtApSJ0noxxkAlw6bL88EFBphN4Yzij4TqWFD0MZ
         oBFkWDGKO5MrjMgSGiLf96AYu5XGRTMqaeUKN0ef1rWn3EXoxsK96Cw87i9CQ919Uszt
         RDyg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2AeIhyg2tN1tOsmRKs0ozfNCRPeZyzX+2xYr+JZZhhtle6unvOvd+8p60LBq0dZPFjuKqqDO70GZx7yBV6Tzda+du/uL
X-Gm-Message-State: AOJu0YwgJA9Vi45YP3ARcK8MDyV7btDRJyQk58v56V+W6+o2KZi0jBWE
	nl1iHRIsWN/vWUM+grCPakJpZ2IQh7FJ6n/lLO8ztBUhzdklf5zDF5MlvszJ
X-Google-Smtp-Source: AGHT+IHByD1hPH5LXrwUYKHWCbtAc60i30sXNQurhEZHLsRNA3HDd6by+sOir0YSB8HWaIHUsp7qrQ==
X-Received: by 2002:a2e:8e93:0:b0:2d3:7e8e:de23 with SMTP id z19-20020a2e8e93000000b002d37e8ede23mr2282718ljk.23.1709552484117;
        Mon, 04 Mar 2024 03:41:24 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c458900b00412b3bf811bsm14295073wmo.8.2024.03.04.03.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:23 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 1/4] tools: ynl: move the new line in NlMsg
 __repr__
In-Reply-To: <20240301230542.116823-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:05:39 -0800")
Date: Mon, 04 Mar 2024 11:08:45 +0000
Message-ID: <m25xy2l0ea.fsf@gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We add the new line even if message has no error or extack,
> which leads to print(nl_msg) ending with two new lines.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

