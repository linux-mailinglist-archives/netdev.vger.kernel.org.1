Return-Path: <netdev+bounces-48893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD747EFF4F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 12:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC421F23193
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE6107AA;
	Sat, 18 Nov 2023 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DPszGSJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2D8D52
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 03:38:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo4066758a12.3
        for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 03:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700307487; x=1700912287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwfAcLpPBP9/VcLdhWC2YYKbzJ5W2WwAWFFBT48SHb4=;
        b=DPszGSJv+/tGL68O9MV438e2U1IphyHA0fsDT2uxnwuiwt7B/0DLfpSDpbwkD3NW2P
         0zeUrhEuLencCLY0QnjWvHmylomF7ke4W5wXDzibQLR9FYuD55VhCIza49bY3kpMdy4q
         eK1e5XT5utNGsgO5SAPeXL0/rrj+MVCuePNvhHL03ZfDv5pT8l9WKTkcddPFd6MaaVaG
         D5tfc/OiNFvXaDYz8MoapDsutZAACb3N6em8x645BeuoB/OXb7H7hiN4rGzpkR3j5iEk
         GYME1/SpaQZXZlGMt5JoLFf1AkK4byirGEfA4vKNwZtWPmei53xP4bZrpXCJjHIboE0X
         dFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700307487; x=1700912287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwfAcLpPBP9/VcLdhWC2YYKbzJ5W2WwAWFFBT48SHb4=;
        b=dIbGsMLCht+6ttxf8F7QyDrOq475jZWy+3zHwcx5LBxIhZvAlZV5oqE1hrU8MuCGER
         KsBFav6PpdFZHI341q4kwoXPc8ikR+oxCebjNpThwfuIKhNXgx+bICMmstk39nM+2Yvy
         ozhYE2SUL2oKE0tfbyTjxRibBPSPHV2egrKj7tZED3ra5RhkSE/5xDsrZBBZZO3HE7bt
         Cm1fKbRallcRpne5TQxz0dDB8/QLcZQZAQ2s2osXHK494OeR3wMxjKlih8RAzokrEgJJ
         NHExDAzrP9WIfgWcwLgFlOU3lWCOKevC0lrPMSQh6rvwCq6pTGO6jKfqmr4lWDKXB9iN
         w+qA==
X-Gm-Message-State: AOJu0YyYEPoLWuWGNftR8jIAZ0VC85DylZcW+08k3iHWaGRK+gAfTIyU
	D5DtSsVpjSJpi6fFS2JFpwdMNA==
X-Google-Smtp-Source: AGHT+IE+gKa6JOvpcInpH3bQMumK5AwCQgXOXPQVa/fdX7kkkSyuYgD+wsAxlw24m1SQ73zpdAvBhg==
X-Received: by 2002:a50:9ec3:0:b0:543:4fca:cc91 with SMTP id a61-20020a509ec3000000b005434fcacc91mr1333532edf.20.1700307486789;
        Sat, 18 Nov 2023 03:38:06 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7c747000000b0053dfd3519f4sm1669355eds.22.2023.11.18.03.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 03:38:06 -0800 (PST)
Date: Sat, 18 Nov 2023 12:38:05 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sachin Bahadur <sachin.bahadur@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v3] ice: Block PF reinit if attached to bond
Message-ID: <ZViiHS0sYyoXHK+x@nanopsycho>
References: <20231117164427.912563-1-sachin.bahadur@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117164427.912563-1-sachin.bahadur@intel.com>

Fri, Nov 17, 2023 at 05:44:27PM CET, sachin.bahadur@intel.com wrote:
>PF interface part of LAG should not allow driver reinit via devlink. The
>Bond config will be lost due to driver reinit. ice_devlink_reload_down is

Reinit whould remove and re-create netdevices. This patch should not be
needed.


>called before PF driver reinit. If PF is attached to bond,
>ice_devlink_reload_down returns error.
>
>Fixes: trailer
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_devlink.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
>index f4e24d11ebd0..5fe88e949b09 100644
>--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
>+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
>@@ -457,6 +457,10 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
> 					   "Remove all VFs before doing reinit\n");
> 			return -EOPNOTSUPP;
> 		}
>+		if (pf->lag && pf->lag->bonded) {
>+			NL_SET_ERR_MSG_MOD(extack, "Remove all associated Bonds before doing reinit");
>+			return -EBUSY;
>+		}
> 		ice_unload(pf);
> 		return 0;
> 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>-- 
>2.25.1
>
>

