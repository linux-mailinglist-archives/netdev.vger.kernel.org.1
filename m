Return-Path: <netdev+bounces-81212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01F188696E
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 10:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496291F219CA
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111B208D1;
	Fri, 22 Mar 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F97KFLX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4790C14F
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711100456; cv=none; b=n08wWOYkntQ6ul3B1y7pxUs+LNaYp9D8bet5TqxVKcqx6wODM5VmJCLVlM15uEOamnuX7f5ZzrA3dA2rMTgoxHOQudSqx5AQFLwMmAmnPNI1hUK3AIZ6A4deQXcbC2nOtrjKKvt2k8wnW87MexEZqEArb/NQ4X8h1rygq/Xhb8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711100456; c=relaxed/simple;
	bh=wHl8vui89YbwiD1z9uvsu5ZySjOCx+53uqMcWz3icBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Goo/ylA01VnTZtTDCE4TRvjtExbR+v1B285B+ubvNRtStq+fmaoSbX5IvA5UxN96gZE9ePjEcSSbqv+FPOYviBR+Bo+jnn1lC2LoXEXomg2zqinsEslaLAIL5kMaJn+cdasBgLKgCFMd+4IkDqBX5uZLk6M2YKD4Wm3WXukl50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F97KFLX6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41477b68cb5so8222165e9.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711100451; x=1711705251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyKiO2Vj+ML9FOel7cGcYwp21WMR0LrM/tgUEPI6Y4E=;
        b=F97KFLX6BurrsG+QhzB8GwRX8knfk4mswHUCOi2LsjuJw8asbzxQTSpPrBBUuBPt74
         ssPJ0QTOfgFQ+R9+SmVeJDSw3xHJKnXp5+Sk40TM/9V2OjnduN6aX7l0v9ATLON45VbK
         Q3lwbjnZVBYebmrCj/je5dLTama0he2u+7F0khMgNd5J4445cTi053Q2/uK0jEcp9ggj
         B2k5z0e3lKTTjaf6SG7sb66kOLl7wGP20cSYKnfJvXHZAj3z1tR7Z4s/CXgwNOE+1I2C
         M11CZTiZJ2DlBx9xcndToZq9P11+9dKCVl/HLhvVO+8eTjcylTCYKsFt6OFMAKWlvL2M
         8k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711100451; x=1711705251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyKiO2Vj+ML9FOel7cGcYwp21WMR0LrM/tgUEPI6Y4E=;
        b=wzUNFOhBYo3wGon9feuNHmorrOdBEXY91mwY7fTEyxqNzlsuBZxpA313sAQB81SIlC
         0KoRm5OzqQAOPs7OQN7qdJz3phwpLSvV6MHdEaUCMpTFSbgMjtosTge/hoyJGNt23uWo
         zCo8p4X1ekhxSSMX05grXJmtqgFy48tP1cyv6O0+dHvBeTVLkRvDIVzNuJhVut8yW4ly
         fJBA/kxNcdBmQizTQwXJcvN0XhytZo5R2Mr1MuIdNOgxMPR6Mglv+Uo9Eo5iJ8i4l8/0
         ADMtd0DkBtoejWP8Y2ebYLT+6RfXncWSQIiot/3MNZtg0JbIPMbuojU8EDeY+H+wTSZd
         B+qA==
X-Forwarded-Encrypted: i=1; AJvYcCWF5zOYvR9qP8tQCmdfNZ09v8+Z1gHPm5a4Kla6bgYrVHUFKNMrmbe4kszU1In0HfR1+dpjEFvjsPdTuwZDfspmYnCpLwrf
X-Gm-Message-State: AOJu0YwqIZLLYEDkKhfku4y3tQd1HmApwHL+QvWrjMWDB7nIq5D56gx7
	dPIVG4kwbI6i6a5ilcQ2UqRb1EbSWMZAsOR3J+6LLYoNHGCPmBVUWwshyooonXA=
X-Google-Smtp-Source: AGHT+IGqHip+JS2pa8/GSES8Ac7KwcNaaejk7Lf9W9r3Xv2znkC9L66RhStPkDXM5V/GQOd6VE/YSw==
X-Received: by 2002:a05:600c:458c:b0:414:7431:6983 with SMTP id r12-20020a05600c458c00b0041474316983mr1072784wmo.25.1711100450943;
        Fri, 22 Mar 2024 02:40:50 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fl21-20020a05600c0b9500b00414674a1a40sm2522768wmb.45.2024.03.22.02.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 02:40:50 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:40:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org
Subject: Re: [PATCH] bridge: vlan: fix compressvlans manpage and usage
Message-ID: <Zf1SH2ZVfBG6O2EE@nanopsycho>
References: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MAZP287MB0503CBCF2FB4C165F0460D70E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>

Fri, Mar 22, 2024 at 09:56:29AM CET, tjjh89017@hotmail.com wrote:
>Add the missing 'compressvlans' to man page.
>Fix the incorrect short opt for compressvlans and color
>in usage.

Split to 2 patches please.

Please fix your prefix to be in format "[patch iproute2-next] xxx"
to properly indicate the target project and tree.


>
>Signed-off-by: Date Huang <tjjh89017@hotmail.com>
>---
> bridge/bridge.c   | 2 +-
> man/man8/bridge.8 | 5 +++++
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/bridge/bridge.c b/bridge/bridge.c
>index f4805092..345f5b5f 100644
>--- a/bridge/bridge.c
>+++ b/bridge/bridge.c
>@@ -39,7 +39,7 @@ static void usage(void)
> "where  OBJECT := { link | fdb | mdb | vlan | vni | monitor }\n"
> "       OPTIONS := { -V[ersion] | -s[tatistics] | -d[etails] |\n"
> "                    -o[neline] | -t[imestamp] | -n[etns] name |\n"
>-"                    -c[ompressvlans] -color -p[retty] -j[son] }\n");
>+"                    -compressvlans -c[olor] -p[retty] -j[son] }\n");

From how I read the code, shouldn't this be rather:
  "                    -com[pressvlans] -c[olor] -p[retty] -j[son] }\n");
?

> 	exit(-1);
> }
> 
>diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
>index eeea4073..9a023227 100644
>--- a/man/man8/bridge.8
>+++ b/man/man8/bridge.8
>@@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
> \fB\-s\fR[\fItatistics\fR] |
> \fB\-n\fR[\fIetns\fR] name |
> \fB\-b\fR[\fIatch\fR] filename |
>+\fB\-compressvlans |
> \fB\-c\fR[\fIolor\fR] |
> \fB\-p\fR[\fIretty\fR] |
> \fB\-j\fR[\fIson\fR] |
>@@ -345,6 +346,10 @@ Don't terminate bridge command on errors in batch mode.
> If there were any errors during execution of the commands, the application
> return code will be non zero.
> 
>+.TP
>+.BR \-compressvlans
>+Show compressed vlan list
>+
> .TP
> .BR \-c [ color ][ = { always | auto | never }
> Configure color output. If parameter is omitted or
>-- 
>2.34.1
>
>

