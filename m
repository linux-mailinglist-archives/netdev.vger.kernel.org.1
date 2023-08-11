Return-Path: <netdev+bounces-26723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BA0778A9D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A571C213F3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFC6AB2;
	Fri, 11 Aug 2023 10:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B1663C3
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 10:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8CAC433C7;
	Fri, 11 Aug 2023 10:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691748339;
	bh=XJBi7RicqQxuh8Je/sFptxR9tPKlatLCcxehTcXio+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBXRM0WJbFvD94h4fBkehs3FeBtbgs2HX8wSNG+2Dpa243lQ+ueARrkyKwySSYXIB
	 yVjzm3h4bDxD4yKX18M0pYTI8udXgMyTMgsTAjoDU6u9JdGCg0T5s1OqYmItYoWvKU
	 OVNmd8tYMn9+7ImaCyxKKRd510P5AYO7LUxaYoTO4ahmMAx0/Qx/ib2bZSI3GA6XTz
	 GQU1exVSN737/6qinYK71Mi0TEXTpkV0WXEFnRTpM4CMv0NvE85ey3l6BZWwBZC7Pf
	 JSYbK6zWo08Js4/oaeu1xd26zz4uRaqjA2mrYrjLAL40KUb4P3bPd5yKE3hMUsjg9c
	 Liu6xTYz6uYmw==
Date: Fri, 11 Aug 2023 12:05:35 +0200
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	jacob.e.keller@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v2 2/5] ice: configure FW logging
Message-ID: <ZNYH705yA5qGxnvJ@vergenet.net>
References: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
 <20230810170109.1963832-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810170109.1963832-3-anthony.l.nguyen@intel.com>

On Thu, Aug 10, 2023 at 10:01:06AM -0700, Tony Nguyen wrote:
> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
> 
> Users want the ability to debug FW issues by retrieving the
> FW logs from the E8xx devices. Use debugfs to allow the user to
> read/write the FW log configuration by adding a 'fwlog/modules' file.
> Reading the file will show either the currently running configuration or
> the next configuration (if the user has changed the configuration).
> Writing to the file will update the configuration, but NOT enable the
> configuration (that is a separate command).

...

> @@ -5635,10 +5653,14 @@ static int __init ice_module_init(void)
>  		goto err_dest_wq;
>  	}
>  
> +	ice_debugfs_init();
> +
>  	status = pci_register_driver(&ice_driver);
>  	if (status) {
>  		pr_err("failed to register PCI driver, err %d\n", status);
>  		goto err_dest_lag_wq;
> +		destroy_workqueue(ice_wq);
> +		ice_debugfs_exit();

Hi Paul and Tony,

this new code seems to be unreachable.
Should it go before the goto statement?

>  	}
>  
>  	return 0;

...

