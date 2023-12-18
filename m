Return-Path: <netdev+bounces-58441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A98166D4
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 07:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F7412829C7
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 06:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2746FDD;
	Mon, 18 Dec 2023 06:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXltZkMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831879C1
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 06:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cd68a0de49so2006459a12.2
        for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 22:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702882376; x=1703487176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlYQofm1PJjw+H1JatxdFjT4V4raRi00vp6T/1jZtaU=;
        b=IXltZkMfqnjBR+0BBj7a83Fq8Xax0paEhCsQ21Ky7tx2WbRJ8oQ4C79yiPq0gNYttt
         rwklBOK5NaGGEGuZ9/QHsz5LYdP0MZhPvGMqe1Rf/KadlH60f5fPmoyiXCxdIpM563+8
         gR19DlCThWSLpuObhHEs7XpOB+nMHK1FfGRHna8nnotMsGnNUM2ayGUAlF1uHJTg23Sw
         f+qdceBurNTL2vzqQYyrGOSuv6yUHqWYU9sLsK0n43I5KxLmlgaDC1pTvG6670GlMFQb
         y0u+m3gfDvJKOliP67eXDuM2gOcesiX7/rf7n9Mko5+8kM4/hc1iDbd+sjzvK0mypX/I
         C8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702882376; x=1703487176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlYQofm1PJjw+H1JatxdFjT4V4raRi00vp6T/1jZtaU=;
        b=nM+ijaKOsby3p6GARBsfSjgdRUSY5v7XHbg0edwogg3Q/dAKNr6GcaZ3u3FnsE8O9H
         YTsCrkFHKOUQ2N+aMbbi/haL7rpWIdDR7DC34A5VXhiCeg5XJJY0v2Nm3VEW8fRXzPLw
         pRQbuaPH1hP6sz2Y5TAnZ7jKyFUC98lNjEFELOUqA//hDAH50PB6G9IFFXfYdoCcesNO
         PwM427ubjyPeaCzHTjzzlDbUddnnCg/RfHQVHtF8U4+V0IroGXs3sA0ZeZoT1JKLYCHr
         wWgx5J8LrepoTQVcl6YnfsfkEY9TQfAjI9ub7NGNZ02TcXGHSVgxZh5rs1l7qukfDFTx
         wOhw==
X-Gm-Message-State: AOJu0YzM9mNwbCEYm+xe0zr55Cd5u8wXAZYMquoetaJz+u4hBmtzsYKc
	Ehrc7iNvSZDVhXPocB8ctk0=
X-Google-Smtp-Source: AGHT+IGoeM8cKqMlkza1u6CJN0WApaR4vfpwJGpgjAv9hl1JW6m3Q7/US4J70ZVlKagX2FNQEMmrIA==
X-Received: by 2002:a05:6a20:9184:b0:18b:f90d:9d84 with SMTP id v4-20020a056a20918400b0018bf90d9d84mr20498674pzd.54.1702882375796;
        Sun, 17 Dec 2023 22:52:55 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p17-20020a170903249100b001cfbe348ca5sm18248142plw.187.2023.12.17.22.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 22:52:54 -0800 (PST)
Date: Mon, 18 Dec 2023 14:52:49 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Liu Jian <liujian56@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jiri@resnulli.us, vladimir.oltean@nxp.com,
	andrew@lunn.ch, d-tatianin@yandex-team.ru, justin.chen@broadcom.com,
	rkannoth@marvell.com, idosch@nvidia.com, jdamato@fastly.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: add vlan hw filter tests
Message-ID: <ZX_sQRJ2yRzefoKH@Laptop-X1>
References: <20231216075219.2379123-1-liujian56@huawei.com>
 <20231216075219.2379123-3-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216075219.2379123-3-liujian56@huawei.com>

On Sat, Dec 16, 2023 at 03:52:19PM +0800, Liu Jian wrote:
> Add one basic vlan hw filter test.
> 
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>  tools/testing/selftests/net/Makefile          |  1 +
>  tools/testing/selftests/net/vlan_hw_filter.sh | 29 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>  create mode 100755 tools/testing/selftests/net/vlan_hw_filter.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 5b2aca4c5f10..9e5bf59a20bf 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -91,6 +91,7 @@ TEST_PROGS += test_bridge_neigh_suppress.sh
>  TEST_PROGS += test_vxlan_nolocalbypass.sh
>  TEST_PROGS += test_bridge_backup_port.sh
>  TEST_PROGS += fdb_flush.sh
> +TEST_PROGS += vlan_hw_filter.sh
>  
>  TEST_FILES := settings
>  
> diff --git a/tools/testing/selftests/net/vlan_hw_filter.sh b/tools/testing/selftests/net/vlan_hw_filter.sh
> new file mode 100755
> index 000000000000..7bc804ffaf7c
> --- /dev/null
> +++ b/tools/testing/selftests/net/vlan_hw_filter.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +readonly NETNS="ns-$(mktemp -u XXXXXX)"
> +
> +ret=0
> +
> +cleanup() {
> +	ip netns del $NETNS
> +}
> +
> +trap cleanup EXIT
> +
> +fail() {
> +    echo "ERROR: ${1:-unexpected return code} (ret: $_)" >&2
> +    ret=1
> +}
> +
> +ip netns add ${NETNS}
> +ip netns exec ${NETNS} ip link add bond0 type bond mode 0
> +ip netns exec ${NETNS} ip link add bond_slave_1 type veth peer veth2
> +ip netns exec ${NETNS} ip link set bond_slave_1 master bond0
> +ip netns exec ${NETNS} ethtool -K bond0 rx-vlan-filter off
> +ip netns exec ${NETNS} ip link add link bond_slave_1 name bond_slave_1.0 type vlan id 0
> +ip netns exec ${NETNS} ip link add link bond0 name bond0.0 type vlan id 0
> +ip netns exec ${NETNS} ip link set bond_slave_1 nomaster
> +ip netns exec ${NETNS} ip link del veth2 || fail "Please check vlan HW filter function"
> +
> +exit $ret
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks
Hangbin

