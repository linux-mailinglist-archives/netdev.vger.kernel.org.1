Return-Path: <netdev+bounces-121054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E3195B82E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A41728215C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811EC1C9EC6;
	Thu, 22 Aug 2024 14:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rU6YTcWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4211C93DF
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336425; cv=none; b=k5wX0jH74J6P+zOib5v2AFv3tVrESw9t4YcvPLCkqMulUeAjNQZraIvfEEo5Daezk2Eu6IMvlcFddIK6bcSWIYYBfL7N7K6lat9/wlo2MWP3XQGWefosas8/xR2lfFuEgQ5mPngn0fhbLiltmr9Moqav0hviZ4/3SqPKlOq7uts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336425; c=relaxed/simple;
	bh=whjgBiyxi6MmtxaOjvj+SRLizXDZrlMD9otXWsU4zBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVCVNFT/dyUMq1DX+1/bOwmdAC78DG6V0AM9f1Qs2PHRWV6V5orfdHDrahVXQcUV4d+0PDgWKGOntuuqcI7hvDWMISH+lNCg/C/3V3Gk6kZIJSHgMyGm7VgXYx1fKwspAok2scHZyWrs+ncWG3f6YyFAcscuPOxsi7Ztn2jfvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rU6YTcWE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso1252617a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724336421; x=1724941221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjwzNkhWkLSrcaz0fPPI/Jh0hc+EeCBzFrJ7U1N2F6s=;
        b=rU6YTcWEE+3BW04cW7LBmNpGgf7NhRf21qT5xQYxlUFh9dGZYNVGVi390hOKitfVdD
         dzgQHmIrdgzu0+b2eGCUVf/CR1peurdwffp7ZVmJ2V7s4QQSDsmXdsF+xtGLv6u3z3SL
         9xowRYsUw5p3ETCzVwA3F4g+jqpSOauhJp4pa+vooE/tzpMNcQAZ86+YGG77rJ89qvSs
         DN5qWRHiLaunfJ8ltl91lhjyY78fRHbEyJG6SzCCVBYXB+uwFmwsmse0p2DEBRlByw2X
         G12RDpz9xQ5rOApV8VNbwivtRpGxhoemdGsIPBz3krFIxBy/7/6yHeRnofdxWH+zUVUJ
         0+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336421; x=1724941221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjwzNkhWkLSrcaz0fPPI/Jh0hc+EeCBzFrJ7U1N2F6s=;
        b=uk10Rk8xpzf0LuAb+Y8n7Fc3OfAQvWxPSdYNOek3kNtZhovUdPZpUIrUVQuyZv/Oyg
         aa0Kzd4ViClSZUkL/G1j/SoyPFZ1wxlFpVCrNI7eEwIUwSqKUnrpZlpCNqBte7Rjkd+B
         4dzcGNj/EGEYYSvAigC/Vmwu7Ri0A8hnDaJChOYPG/YR0kIbPALIMKhz3pSKRyOyw+Gx
         /XeH743fxfku7vJFG/6RkexHwu1D124N/UgivEvqGBm1/Z9EOQQgjPdXW4pZ/58TU0JN
         JW4VudbuNcLTCVl/cS24fe9EnUqaMdZ5WPjbSguTYdTwI2oXsiu8TpX0etZmdtQ0X37T
         WB/w==
X-Gm-Message-State: AOJu0YwmYusR/+cE+Zo0P0k+p/op8amvrXI+VrWfpSW1JX6PoVrTKaIV
	auNSv1JOrS34zYY6entGQpMGQQCyfzx8w2LAysp5uSIc6k42e7Js7hM7DTpBNSw=
X-Google-Smtp-Source: AGHT+IFIQM4hEmL0SGboolNLNcmWaUUp9r0kk1Hm1LtA02ZHsJHtYHEvJQ3Pmq1lQlDnPrIHE211pQ==
X-Received: by 2002:a05:6402:40c7:b0:5be:dc90:d13f with SMTP id 4fb4d7f45d1cf-5bf1f0a34b4mr4222083a12.5.1724336421435;
        Thu, 22 Aug 2024 07:20:21 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0515a91afsm966726a12.93.2024.08.22.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:20:20 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:20:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 03/11] octeontx2-pf: Create representor
 netdev
Message-ID: <ZsdJI0nAj5QeVHoM@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
 <20240822132031.29494-4-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-4-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:23PM CEST, gakula@marvell.com wrote:
>Adds initial devlink support to set/get the switchdev mode.
>Representor netdevs are created for each rvu devices when
>the switch mode is set to 'switchdev'. These netdevs are
>be used to control and configure VFs.
>
>Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>Reviewed-by: Simon Horman <horms@kernel.org>
>---
> .../ethernet/marvell/octeontx2.rst            |  53 ++++++
> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 165 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |   3 +
> 4 files changed, 270 insertions(+)
>
>diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>index 1e196cb9ce25..1132ae2d007c 100644
>--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
>@@ -14,6 +14,7 @@ Contents
> - `Basic packet flow`_
> - `Devlink health reporters`_
> - `Quality of service`_
>+- `RVU representors`_
> 
> Overview
> ========
>@@ -340,3 +341,55 @@ Setup HTB offload
>         # tc class add dev <interface> parent 1: classid 1:2 htb rate 10Gbit prio 2 quantum 188416
> 
>         # tc class add dev <interface> parent 1: classid 1:3 htb rate 10Gbit prio 2 quantum 32768
>+
>+
>+RVU Representors
>+================
>+
>+RVU representor driver adds support for creation of representor devices for
>+RVU PFs' VFs in the system. Representor devices are created when user enables
>+the switchdev mode.
>+Switchdev mode can be enabled either before or after setting up SRIOV numVFs.
>+All representor devices share a single NIXLF but each has a dedicated queue
>+(ie RQ/SQ. RVU PF representor driver registers a separate netdev for each
>+RQ/SQ queue pair.
>+
>+HW doesn't have a in-built switch which can do L2 learning and forward pkts
>+between representee and representor. Hence packet path between representee
>+and it's representor is achieved by setting up appropriate NPC MCAM filters.

Isn't this documentation part talking about bits added in patch
"octeontx2-af: Add packet path between representor and VF"
? If yes, move the docs to that patch. Please make sure you add code
alongside with documentation. Or, alternativelly, just let the
documentation be added by separate and last patch.

[..]

