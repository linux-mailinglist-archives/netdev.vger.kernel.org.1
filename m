Return-Path: <netdev+bounces-65739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA683B88F
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 05:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6506F286D6A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 04:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F148B6FB2;
	Thu, 25 Jan 2024 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KamnQTBb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC487460
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155498; cv=none; b=vBfbsSplUUA5fHJb2I915CszucHXcD5viUHG3Z4gO+h8hDLo7rEOmU2clBWNUNCxcL6PJNHfBNIIyYqzsG1lqxD047TyDr7Coh1/vWbcWYOAbHxx/Asc33q6pFH+dLAqN8qX36qM6V42DbSk9MKusin7f9Wez3G8pvK3FaQ9Kp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155498; c=relaxed/simple;
	bh=+jJjIFs8DOwvqfpOW1gw01spBl3d5Ep0Q3GEcLHTE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UatHq65PJzeHbXhr8A8rZ/Nb7QLX5EAiLgtjjXdYEC88YkOY91G69fOy8lR+SXkN+87yjVsgvQ76cT7rcxwFxtLS8l8LhEmRUGQWv+F87NHGTGvYkLE0O3sq0qtoH4mlco8HdoEHZOQa2N1WTk56D/VxdfBGWUlLfoVe4wwdIMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KamnQTBb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6daa89a6452so4477971b3a.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 20:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706155496; x=1706760296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ykM1Gs7MCEy5v3PBMwDlq9kR8DEgFgkX/LUeg+tQdQ=;
        b=KamnQTBbHpKfLi/xU8YS6y+8tnMejZdEI3BfhFzzOTZJZFhZyyqQkroPPrjktrtnHR
         +vyxY3jPZWWXrH7yhQwsM2rLCuTOqK1MwIbZylLNAQb3GhfPeMaw6hOtKY6nub+inkdp
         3ni6y+TzZXiSk8VocJBur4zYT3/KZv0i5pVf+1jRT3AuYDQeOK/arKPTelp64V2+mXjp
         lr9Xvc7ghLwbMcimQZ3ggqlfmju4BcifMsOrwVhAbfy646KvVLIPFGpUY0bAflc/xdQ1
         AJr6xVVl+7U6dxCh4ShBBREwaPBMTu3OZXTF0QIcqI63K081f1rW5/BzhwuELFWfjtl2
         kghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706155496; x=1706760296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ykM1Gs7MCEy5v3PBMwDlq9kR8DEgFgkX/LUeg+tQdQ=;
        b=rSV6scVtsgnKlEntgTsTCeWqeFkBPyOnoCSxmSp6IGGtnOBPA5VTbsp1v8oVGorvIf
         4pemt/T2+Qoc0Cg6VQFS8s87zLmInER/JP6GN73/KQ8I1zTWTNptsfv7zmVqDd/Dme9w
         XQ9+APh/NCTgRIMyxay2IxXXRXMQE0S0GvdhQDBo0v48vQNn6yxisHISgMBqCklMnhjF
         0TwI6WHxbO6wNaBI934GEhFp7iqVvLkE3XQPeUrCe+URtLWMp0Z0IOoERSdjDzppOc5H
         nfxKNadnOeEOJSrsaZSydJiPTmQVpMbQSrew0EnasGN1psRt2HdJI+qF0LUj5icXlju2
         2Y7A==
X-Gm-Message-State: AOJu0YwpijkBAPNFDirrwEkWEsMbh5kdzaKp67hp30ZbXhAzgf1vdHqn
	80nheJIrLeCeUQk8gvGYsg4t86wGpU99cm9+QQQkttAIuhJVAGbbHEWg3fa3+Q6zVC5I
X-Google-Smtp-Source: AGHT+IFDGD6KIY/ZJuybIgcU53IwPJ1lIoYfP/JAGUm3DtWARwu670xA7RfMNYjh0sJ9HxaBRtng3g==
X-Received: by 2002:a05:6a20:4387:b0:199:3fde:1226 with SMTP id i7-20020a056a20438700b001993fde1226mr405287pzl.46.1706155496360;
        Wed, 24 Jan 2024 20:04:56 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id lh13-20020a170903290d00b001d7393f6917sm7014181plb.86.2024.01.24.20.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 20:04:55 -0800 (PST)
Date: Thu, 25 Jan 2024 12:04:52 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next 2/6] selftests: bonding: Add
 net/forwarding/lib.sh to TEST_INCLUDES
Message-ID: <ZbHd5LuVs4-CjWiw@Laptop-X1>
References: <20240124170222.261664-1-bpoirier@nvidia.com>
 <20240124170222.261664-3-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124170222.261664-3-bpoirier@nvidia.com>

On Wed, Jan 24, 2024 at 12:02:18PM -0500, Benjamin Poirier wrote:
> In order to avoid duplicated files when both the bonding and forwarding
> tests are exported together, add net/forwarding/lib.sh to TEST_INCLUDES and
> include it via its relative path.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  tools/testing/selftests/drivers/net/bonding/Makefile        | 6 ++++--
>  .../selftests/drivers/net/bonding/bond-eth-type-change.sh   | 2 +-
>  .../testing/selftests/drivers/net/bonding/bond_topo_2d1c.sh | 2 +-
>  .../testing/selftests/drivers/net/bonding/dev_addr_lists.sh | 2 +-
>  .../drivers/net/bonding/mode-1-recovery-updelay.sh          | 2 +-
>  .../drivers/net/bonding/mode-2-recovery-updelay.sh          | 2 +-
>  .../selftests/drivers/net/bonding/net_forwarding_lib.sh     | 1 -
>  7 files changed, 9 insertions(+), 8 deletions(-)
>  delete mode 120000 tools/testing/selftests/drivers/net/bonding/net_forwarding_lib.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 8a72bb7de70f..1e10a1f06faf 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -15,7 +15,9 @@ TEST_PROGS := \
>  TEST_FILES := \
>  	lag_lib.sh \
>  	bond_topo_2d1c.sh \
> -	bond_topo_3d1c.sh \
> -	net_forwarding_lib.sh
> +	bond_topo_3d1c.sh
> +
> +TEST_INCLUDES := \
> +	../../../net/forwarding/lib.sh
>  
>  include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
> index 862e947e17c7..8293dbc7c18f 100755
> --- a/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-eth-type-change.sh
> @@ -11,7 +11,7 @@ ALL_TESTS="
>  REQUIRE_MZ=no
>  NUM_NETIFS=0
>  lib_dir=$(dirname "$0")
> -source "$lib_dir"/net_forwarding_lib.sh
> +source "$lib_dir"/../../../net/forwarding/lib.sh

I wonder if we should still call it lib_dir. Maybe

selftest_dir="$(dirname "$0")/../../.."
source $selftest_dir/net/forwarding/lib.sh

But this is absolutely out of this patch set's scope :)

Thanks
Hangbin


