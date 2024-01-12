Return-Path: <netdev+bounces-63188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137382B907
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29F1287A98
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2472139F;
	Fri, 12 Jan 2024 01:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrKALpHU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FD01116
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bbd6e3795eso4610741b6e.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705022124; x=1705626924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoI7C0uSr0imX4rZL1K/Jhft2w5h7qReGETmVV+3S1w=;
        b=MrKALpHUDIeyeax3waI9RER5inVgYoGqvimsnUWTU98FGoOBO4YaHOSTpSeCnILDSk
         WpSm+4cV8MNXgSuLSE1rz+10ToTlEd1ZVPNV8UY0gLc9JoTjGbSzX1hqmh0sn8fw3e69
         7iV79uQBDu116pDI1TKUZCHqN+PVKqWTiHTKcXtJOGKRC+2nQBNjJUG7KDYP1YJwKnGN
         n8zfAMysc/pHw6tSyDSRUeP7oHOQOz218K1znJOMIYwK0Us/kOuA7GdxO3i+1AXmpZjF
         Rmc+ArGR6HcG+UbZvCMm/DrxCEtw1g2eDpcwdd4DsR5st12e+uGsiXWsPQ3eQFUZrLtF
         aJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705022124; x=1705626924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoI7C0uSr0imX4rZL1K/Jhft2w5h7qReGETmVV+3S1w=;
        b=UHdBO1cWSFof+QpikJLEn9pkNXGYgaS445oN8I0O8oStJ4c69+bI+bq6LzA+zEs14X
         VDShUPNCW/ugfAXYKd1YuakhjgfHUKG+zCUwAx518JdyVK0fliLvo/5Cz7bYqGimjE31
         nVoTe5NAzJw9G6U7lWHnqJLg5QTQ+hKekOx10LgS2ri6jjV1xJhmCzPwVFI2l1E62u51
         BorTpgM9uLl6YeoyjNoOj6UhTHMKTBQC8EklQwpa2xzzyFE7FPZVLgcfVRX33KQORniB
         0csjzoyBGj5CYeMvxWFGqYg9A+eT6xxphTT/w92zxldf5dtlDhT11P2pWkTxu8yf5ZVg
         HpGg==
X-Gm-Message-State: AOJu0YzeJFBhOnrWd9FIbaYpjTFsVUyXEPo79i3Nl/DPEA7i/EpAOXGE
	QVTcOhuUTrWAkeWDn6Fc5d9InvjcjmItDw==
X-Google-Smtp-Source: AGHT+IHdQRWg6XTEMx7EyO+S47FV0X9de+E0Aby0HOFUKSON/m4WOVhvpJvhmWfvlBz40T0ugjqWpQ==
X-Received: by 2002:a05:6808:3009:b0:3bd:4629:38a3 with SMTP id ay9-20020a056808300900b003bd462938a3mr228809oib.6.1705022124168;
        Thu, 11 Jan 2024 17:15:24 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ko20-20020a056a00461400b006da13bc46c0sm1943129pfb.171.2024.01.11.17.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 17:15:22 -0800 (PST)
Date: Fri, 12 Jan 2024 09:15:14 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v4 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <ZaCSog00Bj8GmOZ4@Laptop-X1>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
 <20240108094103.2001224-3-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108094103.2001224-3-nicolas.dichtel@6wind.com>

On Mon, Jan 08, 2024 at 10:41:03AM +0100, Nicolas Dichtel wrote:
> The goal is to check the following two sequences:
> > ip link set dummy0 up
> > ip link set dummy0 master bond0 down
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  tools/testing/selftests/net/rtnetlink.sh | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 26827ea4e3e5..bbf9d2bd3d7b 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -28,6 +28,7 @@ ALL_TESTS="
>  	kci_test_neigh_get
>  	kci_test_bridge_parent_id
>  	kci_test_address_proto
> +	kci_test_enslave_bonding
>  "
>  
>  devdummy="test-dummy0"
> @@ -1239,6 +1240,33 @@ kci_test_address_proto()
>  	return $ret
>  }
>  
> +kci_test_enslave_bonding()
> +{
> +	local testns="testns"
> +	local bond="bond123"
> +	local dummy="dummy123"
> +	local ret=0
> +
> +	run_cmd ip netns add "$testns"
> +	if [ $ret -ne 0 ]; then
> +		end_test "SKIP bonding tests: cannot add net namespace $testns"
> +		return $ksft_skip
> +	fi
> +
> +	run_cmd ip -netns $testns link add dev $bond type bond mode balance-rr

Hi Nicolas,

FYI, the selftests/net/lib.sh has been merged to net tree. Please remember
send a following up update to create the netns with setup_ns.

Thanks
Hangbin

