Return-Path: <netdev+bounces-57140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C220E8123ED
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FD24B20DFD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B038E;
	Thu, 14 Dec 2023 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iukQudKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF58DD
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:32:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so877289966b.1
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 16:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702513931; x=1703118731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40hwYgV7cDaxKN5Qa0UorBr3xPgDWVjeZ94cUd3m8mc=;
        b=iukQudKcyKRoTDfmLS+vDBy84DPW4zrQVsR+JTPn8u2+poYqqhI3M6YVXo3NEEnApf
         2gcEGgoW1jRG8pyruUnRrCW2ODLcYkgURlhYPQ+bGKKziv0dfD2vVpboWiSesuw6mPfI
         7lb+WCD9oc7rpbjwIhUkbNithBkGHEfnjEV3J3B1pN3nwl4xOwRc9kiyx7+CTxYqfnMC
         v72wSg+WBWw4D1nZ0C480ZWdXbjrYhwY2EchRAa9B9BIyZ4/sf3me0YNSqpDVrimYVNx
         zI2t+CX6GS7FQn33CN/+oWv0gAM+BaUGfabtTpsLuDj5h35rYogZJTRsGxM3K+FCKTja
         Q6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702513931; x=1703118731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40hwYgV7cDaxKN5Qa0UorBr3xPgDWVjeZ94cUd3m8mc=;
        b=MMWUqQQ4UjNLF7ubESLUI4dfYYDI6TBEK8NgUqYhw2eOYzVpcnChwePYJU7ZCl6xks
         s7/iFJYUyDD2D8pfl3Wgbu/4n63Hb2B8SnMbNVPlxvOSFE3sJ5KwH7wXJirPWKuHh48M
         n8U/OWx01fCd4LW7u/3yzX+RDstZ3n9wCXbps8DLA+xgbxKRsRkWJkuXTz7Lxx+i37pJ
         wCpmZmfmE0YfuxDEW/asATujJiy0qXauO7+0t2QXt4Vzp7UK2TgYTyoczs1tr1QUDNn8
         AXOEukbEPTlPJQ/cegWYKjWkkz59NwwI8n8463aDM2TudfIGMq4r2NjuPNS18GYumvyW
         WnRw==
X-Gm-Message-State: AOJu0YxML2PU7v5QpUx+budbRnkAZTBSfQtbiFN+FQ0EwayjUFTlwUpI
	ohT673UETkp86C9vcbIrDU0=
X-Google-Smtp-Source: AGHT+IERtVNFWvuyX2GhKTkgkBkh90toVFLlKrczAMp76GnZIExM6LvqZBJoyuSP9B7bMv7lyGZgEQ==
X-Received: by 2002:a17:907:6190:b0:a1f:6761:c8dc with SMTP id mt16-20020a170907619000b00a1f6761c8dcmr3937144ejc.124.1702513930610;
        Wed, 13 Dec 2023 16:32:10 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id sk13-20020a170906630d00b00a1d232b39b3sm8657099ejc.145.2023.12.13.16.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 16:32:10 -0800 (PST)
Date: Thu, 14 Dec 2023 02:32:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 8/8] selftests: forwarding: ethtool_rmon: Add
 histogram counter test
Message-ID: <20231214003208.onzo3zmref35x7q4@skbuf>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-9-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-9-tobias@waldekranz.com>

Hi Tobias,

On Mon, Dec 11, 2023 at 11:33:46PM +0100, Tobias Waldekranz wrote:
> Validate the operation of rx and tx histogram counters, if supported
> by the interface, by sending batches of packets targeted for each
> bucket.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

Thank you so much for writing down this test.

I tested it on enetc and ocelot/felix, and I can report back that I
already found 2 bugs. One in ocelot, for which I've sent this patch:
https://lore.kernel.org/netdev/20231214000902.545625-1-vladimir.oltean@nxp.com/

and one in this selftest. I hope the logs below make it quite clear what
is going on.

Before the change:

root@debian:~/selftests/net/forwarding# ./ethtool_rmon.sh eno0 swp0
[   37.359447] fsl_enetc 0000:00:00.0 eno0: PHY [0000:00:00.3:02] driver [Qualcomm Atheros AR8031/AR8033] (irq=POLL)
[   37.370906] fsl_enetc 0000:00:00.0 eno0: configuring for inband/sgmii link mode
[   37.387399] mscc_felix 0000:00:00.5 swp0: configuring for inband/qsgmii link mode
[   41.478974] fsl_enetc 0000:00:00.0 eno0: Link is Up - 1Gbps/Full - flow control rx/tx
[   41.479119] mscc_felix 0000:00:00.5 swp0: Link is Up - 1Gbps/Full - flow control rx/tx
TEST: rx histogram counters for bucket 64-64                        [ OK ]
TEST: rx histogram counters for bucket 65-127                       [ OK ]
TEST: rx histogram counters for bucket 128-255                      [ OK ]
TEST: rx histogram counters for bucket 256-511                      [ OK ]
TEST: rx histogram counters for bucket 512-1023                     [ OK ]
TEST: rx histogram counters for bucket 1024-1526                    [ OK ]
TEST: rx histogram counters for bucket 1527-65535                   [FAIL]
        Verification failed for swp0 bucket 1527-65535
TEST: tx histogram counters for bucket 64-64                        [ OK ]
TEST: tx histogram counters for bucket 65-127                       [ OK ]
TEST: tx histogram counters for bucket 128-255                      [ OK ]
TEST: tx histogram counters for bucket 256-511                      [ OK ]
TEST: tx histogram counters for bucket 512-1023                     [ OK ]
TEST: tx histogram counters for bucket 1024-1526                    [ OK ]
TEST: tx histogram counters for bucket 1527-65535                   [FAIL]
        Verification failed for swp0 bucket 1527-65535

The change itself:

root@debian:~/selftests/net/forwarding# ip link set swp0 mtu 9000
root@debian:~/selftests/net/forwarding# ip link set eno0 mtu 9000

After the change:

root@debian:~/selftests/net/forwarding# ./ethtool_rmon.sh eno0 swp0
TEST: rx histogram counters for bucket 64-64                        [ OK ]
TEST: rx histogram counters for bucket 65-127                       [ OK ]
TEST: rx histogram counters for bucket 128-255                      [ OK ]
TEST: rx histogram counters for bucket 256-511                      [ OK ]
TEST: rx histogram counters for bucket 512-1023                     [ OK ]
TEST: rx histogram counters for bucket 1024-1526                    [ OK ]
TEST: rx histogram counters for bucket 1527-65535                   [ OK ]
TEST: tx histogram counters for bucket 64-64                        [ OK ]
TEST: tx histogram counters for bucket 65-127                       [ OK ]
TEST: tx histogram counters for bucket 128-255                      [ OK ]
TEST: tx histogram counters for bucket 256-511                      [ OK ]
TEST: tx histogram counters for bucket 512-1023                     [ OK ]
TEST: tx histogram counters for bucket 1024-1526                    [ OK ]
TEST: tx histogram counters for bucket 1527-65535                   [ OK ]

We'd need to raise the MTU on both $h1 and $h2 to $len - ETH_HLEN.
Note that $h1 - the device whose counters we are not looking at - may
not have the same histograms, and even the same MTU. It means we may not
be able to test all of $h2's histograms if we can't set the MTU to the
appropriate value, and that should just mean a skipped test.

The initial MTU of the interfaces should be restored at cleanup() time,
and only modified during each test if necessary, I suppose.

I noticed that the test is asymmetric, so I ran it a second time with
the argument order "swp0 eno0" and that passed as well. It's probably
all too easy to miss that it leaves $h1's counters untested, though.

The test also passes on mv88e6390, because all buckets start with a
value smaller than 1518, so the MTU never needs to be increased:

TEST: rx histogram counters for bucket 64-64                        [ OK ]
TEST: rx histogram counters for bucket 65-127                       [ OK ]
TEST: rx histogram counters for bucket 128-255                      [ OK ]
TEST: rx histogram counters for bucket 256-511                      [ OK ]
TEST: rx histogram counters for bucket 512-1023                     [ OK ]
TEST: rx histogram counters for bucket 1024-65535                   [ OK ]
TEST: lan2 does not support tx histogram counters                   [SKIP]

> diff --git a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
> new file mode 100755
> index 000000000000..73e3fbe28f37
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
> @@ -0,0 +1,106 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ALL_TESTS="
> +	rmon_rx_histogram
> +	rmon_tx_histogram
> +"
> +
> +NUM_NETIFS=2
> +source lib.sh
> +
> +bucket_test()
> +{
> +	local set=$1; shift
> +	local bucket=$1; shift
> +	local len=$1; shift
> +	local num_rx=10000
> +	local num_tx=20000
> +	local expected=
> +	local before=
> +	local after=
> +	local delta=
> +
> +	# Mausezahn does not include FCS bytes in its length - but the
> +	# histogram counters do
> +	len=$((len - 4))
> +
> +	before=$(ethtool --json -S $h2 --groups rmon | \
> +		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
> +
> +	# Send 10k one way and 20k in the other, to detect counters
> +	# mapped to the wrong direction
> +	$MZ $h1 -q -c $num_rx -p $len -a own -b bcast -d 10us
> +	$MZ $h2 -q -c $num_tx -p $len -a own -b bcast -d 10us
> +
> +	after=$(ethtool --json -S $h2 --groups rmon | \
> +		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][$bucket].val")
> +
> +	delta=$((after - before))
> +
> +	expected=$([ $set = rx ] && echo $num_rx || echo $num_tx)
> +
> +	# Allow some extra tolerance for other packets sent by the stack
> +	[ $delta -ge $expected ] && [ $delta -le $((expected + 100)) ]
> +}
> +
> +rmon_histogram()
> +{
> +	local set=$1; shift
> +	local nbuckets=0
> +
> +	RET=0
> +
> +	while read -r -a bucket; do
> +		bucket_test $set $nbuckets ${bucket[0]}
> +		check_err "$?" "Verification failed for bucket ${bucket[0]}-${bucket[1]}"
> +		nbuckets=$((nbuckets + 1))
> +	done < <(ethtool --json -S $h2 --groups rmon | \
> +		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high, .val]|@tsv" 2>/dev/null)
> +
> +	if [ $nbuckets -eq 0 ]; then
> +		log_test_skip "$h2 does not support $set histogram counters"
> +		return
> +	fi
> +
> +	log_test "$set histogram counters"

I'm aware this was probably done on purpose, but I felt the test was not
very interactive (it took over 10 seconds to get some output back), so I
took the liberty to log individual buckets as their own tests. And also
to stop at the first failure, rather than continue the iteration which
got me confused during debugging.

diff --git a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
index 73e3fbe28f37..b0f701063822 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
@@ -53,7 +53,13 @@ rmon_histogram()
 
 	while read -r -a bucket; do
 		bucket_test $set $nbuckets ${bucket[0]}
-		check_err "$?" "Verification failed for bucket ${bucket[0]}-${bucket[1]}"
+		rc="$?"
+		check_err "$rc" "Verification failed for $h2 bucket ${bucket[0]}-${bucket[1]}"
+		log_test "$set histogram counters for bucket ${bucket[0]}-${bucket[1]}"
+		if [ $rc -ne 0 ]; then
+			return 1
+		fi
+
 		nbuckets=$((nbuckets + 1))
 	done < <(ethtool --json -S $h2 --groups rmon | \
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high, .val]|@tsv" 2>/dev/null)
@@ -62,8 +68,6 @@ rmon_histogram()
 		log_test_skip "$h2 does not support $set histogram counters"
 		return
 	fi
-
-	log_test "$set histogram counters"
 }
 
 rmon_rx_histogram()

> +}

