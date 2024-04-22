Return-Path: <netdev+bounces-90094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F264A8ACC7D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A60CB23FDC
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695D146D7D;
	Mon, 22 Apr 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8xo5x/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D171448E5
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787759; cv=none; b=qORTJDWT9ogHajDo2a7MuMO/AXzAchfmzU9VesycZairZgzq34OF1J0HiddxIONGdvWw/5y7VnbSlsvy/qDS+NGKjPWEMZ2GTiSWnSR+whoB+kI7cUeH7vvtpjVJ4LNRa01q15XBerb2jcu8SkSfbZKonrh3LNYYwddbZTmrDVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787759; c=relaxed/simple;
	bh=di9sBsaIZg/SBOPjkTePgnH3iNpf7xSHnUD9plckD9Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QX6l+8fEuToLrZjVGTXQfi9/UImjuYKFKXX2gmkn94uXgdzxyHWe8Holtd8jCTiKyBnhxX+bLIACJH0ft3gvlVM2nYGnqESaiYj4J73raBY8nR+dbPTGR9+LSX134VApPLDaLktCrKnkg3gDnhEJw8AX/bIJ2F3BIaApGejNOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8xo5x/v; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-418c2bf2f55so28875885e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713787756; x=1714392556; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q85A1ZcmKJJIRH+TuaFh9yTmESgOk1vCrMNPOrJ0bCo=;
        b=g8xo5x/vOm5eWd19ZZa/fxh9cKUFQSAY1xGnPMC6Z4o6vhwYIfbN8BAAOnDI8/Cv8Y
         6ELCtu2gz5EhV7KMeAs+yVqSihfd9StqDDUitnaIPlmUjJj/RJOdNd0lwYfxeziJUbRO
         ch1iJJgkSP1ogyQAGUEcTtOCmasroqc65ro6t5+gWS6noJL95gQt8wMTRLGh/yG64cia
         EonhtMiT06Pe6XEMxNBOMyZGJC+eNUCNaS88mpz73JAmCXQBQBxrj5IvV+Tyr0zUg8KP
         YvICYcR+KUDze/W6Vza2qVVg/UEdQi4wpfw1RGZeu+bFM/7PJMaw5MeeXJwDTbfq8FbN
         xlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713787756; x=1714392556;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q85A1ZcmKJJIRH+TuaFh9yTmESgOk1vCrMNPOrJ0bCo=;
        b=czYn7SPmghucA1pPImDMyBSYKKPxx9mLYnArN6VOGiP/xenvTEy17ffRnPR8dm8acS
         j/DoFxgT3NGgOdbn6zlRPLquWjI4okX3GEj2E4SKBgopJIc2ofG/HWIEvOvy6sWrf4qA
         9/HGfzje7FdVnJSz5+IsD4vQl5ceFTvrUOBZj3FvIbM1KBKu9r1B6NLxbKhRMN3xQmIL
         gA5WlUT+JZtBZmzG/HYylXh5BQk16uCyvzIkyegPhs1RGrMz3vuhDEdlRdQz+N2YVSVt
         aA3FCgkaZizcw2n/ZdPHWgjI60to/tIwRbTG1d4dvuBfZeIkT4HRU3vC/ztyJzRzJNFf
         SAIA==
X-Forwarded-Encrypted: i=1; AJvYcCWNowMszilMk34kJRwIMJZjuo3kpiuo1iEEID6ZecMFwqWpXRntI7bXf6D1E51x+Vzk3p5Et7bwyrniExLqzzzvMWtxlhsl
X-Gm-Message-State: AOJu0Yy3aTmw/C8oBUTVBpekjz9xZgOEyfbf53FDCxW4057NwHLO8aCT
	o9OX9ss156VSAjTU96vpyCDLyXUZ3R3tG+t/mID3ONGstroHlBWmaBs+1w==
X-Google-Smtp-Source: AGHT+IE/e/Ok6/G1ebpGLGtjM3/GrFfPvc4KkpWSDzyMD0BUKVMKVjDI9wKgo6XB87dxkjWVGnDmeA==
X-Received: by 2002:a05:600c:3d16:b0:41a:3407:78e5 with SMTP id bh22-20020a05600c3d1600b0041a340778e5mr2633258wmb.12.1713787756399;
        Mon, 22 Apr 2024 05:09:16 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1c85:90cc:480f:645b])
        by smtp.gmail.com with ESMTPSA id c11-20020adffb0b000000b0034b1a91be72sm14820wrr.14.2024.04.22.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:09:15 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us,  sdf@google.com
Subject: Re: [PATCH net] tools: ynl: don't ignore errors in NLMSG_DONE messages
In-Reply-To: <20240420020827.3288615-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 19 Apr 2024 19:08:26 -0700")
Date: Mon, 22 Apr 2024 13:08:20 +0100
Message-ID: <m21q6xha6j.fsf@gmail.com>
References: <20240420020827.3288615-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> NLMSG_DONE contains an error code, it has to be extracted.
> Prior to this change all dumps will end in success,
> and in case of failure the result is silently truncated.
>
> Fixes: e4b48ed460d3 ("tools: ynl: add a completely generic client")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> CC: sdf@google.com
> ---
>  tools/net/ynl/lib/ynl.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index a67f7b6fef92..a9e4d588baf6 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -203,6 +203,7 @@ from .nlspec import SpecFamily
>              self.done = 1
>              extack_off = 20
>          elif self.nl_type == Netlink.NLMSG_DONE:
> +            self.error = struct.unpack("i", self.raw[0:4])[0]
>              self.done = 1
>              extack_off = 4

