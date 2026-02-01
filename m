Return-Path: <netdev+bounces-255680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +YGqDWfRf2kWyAIAu9opvQ
	(envelope-from <netdev+bounces-255680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:19:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2CC75B1
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 23:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C612300538F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 22:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36B2EAB72;
	Sun,  1 Feb 2026 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6NYKWqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C12E7BD6
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 22:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984354; cv=none; b=g5qPmH5GznE5rMSBicy1MCjV0mypLkrUoScI/hL+hZLMAZXNt6D8x5fxW6abywN0XL3lnnMIK3TNiGnfe1I3mludGFOOKBmrevrKctbFxzWaTaaKHna+PANy1JANZbms5mTZU9vM114OegQau7aklxgX/hUyWeP3FCntxXAdOWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984354; c=relaxed/simple;
	bh=FW2IFjug0wipIm+wvKJOEqF0GHSnAGPr4QuVJ8hWyfI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=diJxXJaZ10KgWb4Y1erYnNDby2Oc4l36FWHKRhw5SizpvRGcR7wTDluQ/FzLhu6AS38WXZXR1ZEBa1t5W2oGrZexVYDK8a1daE1oksOYp0/2t5mtyDbAhabYtHr3uBAhIjqyVaX3Arzz/4g9V0k2eKzJTqmuWYzAR5NoROL3u2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6NYKWqs; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79478ec4cf1so36136017b3.3
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769984352; x=1770589152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoRg5azkP2+tD6BZ4JF2O1+QmNtK8W7tl0pO+XrNBaE=;
        b=P6NYKWqsOy9qX+e7w4NE9FscgrQBIIGXQX4E+27ZFhSsQRv9QhibqXjn/LRdpzZ7EZ
         DKitMTfUIqYgux3xm2WqZqK5aWJtzjq47K+7nrPwLi5UCf5tWoczGQylJDjL2Q7djErH
         uxHi53pPf2E70xfEurQQ6tyySQ1iMO+LtrZfP2SqgYV3w+jTVvHDd8uoDqOZvBfEwqWg
         lvgTfYX4SB9bxfn60EogZyJtVi6wtk4S31dnoo1lW6sME09D7IVwb1dshrWyk+CN6jko
         biBXyWwtzPGpY6x7KMRcWH0hR+ragbLJQ/Wi0Rbry+szWWG0eDkjXjlxYFq95Z/sYlPV
         MkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769984352; x=1770589152;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoRg5azkP2+tD6BZ4JF2O1+QmNtK8W7tl0pO+XrNBaE=;
        b=EtEBWQZikjSdcvNZvaUfVzJ5uRsgJQFilMzUE1mCbCRTi9M0RCRp+lZVwnx2m/mMII
         IjNkTClTR+BNmMQdNmq13Y1bjGIJ8kVmYuQtB1M9Mj5+LoKpWTdrcA0+z/fo1IaK+MjG
         8y0z8N4Y+1csSHvorcIeJOBzJivEeQqQzOdn9G5qyzRYAZeafkPKPDZbWxYhp9N4woTE
         34Ur27A7ycSI28kE1mHtA+z9HaEp/F0AiInwhIXKnay4H7B+d9aW0bH0Hhnvr91knemP
         RSBvtbbBdkRaZM/EVoTXQzQCCnZsMZx5V31VTEK/9r5vRzxUIrlITSa7GG7V/z5cMqX+
         W8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXuX9s6xcXb36D9tDES9wJ0vY1GsX8CnKtnR9Ajgftvc1BslVUx10hEIZHycrXAj52JoJiN1hQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMe5+g9CTDaxKjVvwsDr1996f5tTAQ/MZEYRIe5RdbnqOamm+7
	LT1YsLgQp8aEWCaA6J3kI+Rg7Qz1azSmx5I3wW3+XGrCzm6OPi+ggt5/
X-Gm-Gg: AZuq6aLEiLiaXd92f/vtOMRK6mrL5V/sYXOP8NP/TTmCK0YJc9z3PmQJVFTZiS+QKWr
	XdBL36LtKbENMKjegDfAk/pDREIp+2daUCb3IIdRi9e2KZfJoWgp2UJHK8YRKw9x56H2u/BwTgN
	a10lGjG3G4B89fsuuX6mUR9QKLhj7a5nDi5+nYX7aoFL76uBe+pelEqW+Zb05D7bwvS2cQF3d6/
	xzm8YLyPlbAWax8ApNFh4h4buWHNlpMaWqvuMOhLCm1Uqv+a9yaU4wN6k+1qqJEfLTNx4bdnurP
	PWd9qJFxEb2Je09aNdJkjuKDVBI+y7BykElhWmIyEGHrRzPVyemQyeXjFWAMMkxdKGU60QyyIG7
	1+HMD2USoEcsvGO49/AhODwrDyEJjXKSlNAyDv3vTi1otdTVMrEytaWfzAaWecT/H/xtPpkoNGi
	kq5xwBRHlLuh9/7qXcIFTLvW9GpV26ayq75SdZXDnPi4V7iYKaP4uqcRuV3Nw=
X-Received: by 2002:a05:690c:4b0b:b0:794:c810:6c4f with SMTP id 00721157ae682-794c8107296mr21604887b3.34.1769984352322;
        Sun, 01 Feb 2026 14:19:12 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794b7356db4sm30204627b3.20.2026.02.01.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 14:19:11 -0800 (PST)
Date: Sun, 01 Feb 2026 17:19:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Richard Gobert <richardbgobert@gmail.com>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.14968a7a11ed8@gmail.com>
In-Reply-To: <276270cf825431817e46f6744d9b26d3ea954869.1769771825.git.pabeni@redhat.com>
References: <cover.1769771825.git.pabeni@redhat.com>
 <276270cf825431817e46f6744d9b26d3ea954869.1769771825.git.pabeni@redhat.com>
Subject: Re: [PATCH net 2/2] selftest: net: add a test-case for encap
 segmentation after GRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255680-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,udpgro_fwd.sh:url]
X-Rspamd-Queue-Id: 8CE2CC75B1
X-Rspamd-Action: no action

Paolo Abeni wrote:
> We had a few patches in this area and no explicit coverage so far.
> The test case covers the scenario addressed by the previous fix;
> reusing the existing udpgro_fwd.sh script to leverage part of the
> of the virtual network setup, even if such script is possibly not
> a perfect fit.
> 
> Note that the mentioned script already contains several shellcheck
> violation; this patch does not fix the existing code, just avoids
> adding more issues in the new one.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/udpgro_fwd.sh | 65 +++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/selftests/net/udpgro_fwd.sh
> index a39fdc4aa2ff..f2c1f0630b77 100755
> --- a/tools/testing/selftests/net/udpgro_fwd.sh
> +++ b/tools/testing/selftests/net/udpgro_fwd.sh
> @@ -162,6 +162,39 @@ run_test() {
>  	echo " ok"
>  }
>  
> +run_test_csum() {
> +	local -r msg="$1"
> +	local -r dst="$2"
> +	local csum_error_filter=UdpInCsumErrors
> +	local csum_errors
> +
> +	printf "%-40s" "$msg"
> +
> +	is_ipv6 "$dst" && csum_error_filter=Udp6InCsumErrors
> +
> +	ip netns exec "$NS_DST" iperf3 -s -1 >/dev/null &
> +	wait_local_port_listen "$NS_DST" 5201 tcp
> +	local spid="$!"
> +	ip netns exec "$NS_SRC" iperf3 -c "$dst" -t 2 >/dev/null
> +	local retc="$?"
> +	wait "$spid"
> +	local rets="$?"
> +	if [ "$rets" -ne 0 ] || [ "$retc" -ne 0 ]; then
> +		echo " fail client exit code $retc, server $rets"
> +		ret=1
> +		return
> +	fi
> +
> +	csum_errors=$(ip netns exec "$NS_DST" nstat -as "$csum_error_filter" |
> +		      grep "$csum_error_filter" | awk '{print $2}')
> +	if [ -n "$csum_errors" ] && [ "$csum_errors" -gt 0 ]; then
> +		echo " fail - csum error on receive $csum_errors, expected 0"
> +		ret=1
> +		return
> +	fi
> +	echo " ok"
> +}
> +
>  run_bench() {
>  	local -r msg=$1
>  	local -r dst=$2
> @@ -260,6 +293,38 @@ for family in 4 6; do
>  	ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
>  	run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
>  	cleanup
> +
> +	# force segmentation and re-aggregation
> +	create_vxlan_pair
> +	ip netns exec "$NS_DST" ethtool -K veth"$DST" generic-receive-offload on
> +	ip netns exec "$NS_SRC" ethtool -K veth"$SRC" tso off
> +	ip -n "$NS_SRC" link set dev veth"$SRC" mtu 1430
> +
> +	# forward to a 2nd veth pair
> +	ip -n "$NS_DST" link add br0 type bridge
> +	ip -n "$NS_DST" link set dev veth"$DST" master br0
> +
> +	# segment the aggregates TSO packet, without csum offload
> +	ip -n "$NS_DST" link add veth_segment type veth peer veth_rx
> +	for FEATURE in tso tx-udp-segmentation tx-checksumming; do
> +		ip netns exec "$NS_DST" ethtool -K veth_segment "$FEATURE" off
> +	done

fwiw, tx off will disable all the dependent tx offloads too

> +	ip -n "$NS_DST" link set dev veth_segment master br0 up
> +	ip -n "$NS_DST" link set dev br0 up
> +	ip -n "$NS_DST" link set dev veth_rx up
> +
> +	# move the lower layer IP in the last added veth
> +	for ADDR in "$BM_NET_V4$DST/24" "$BM_NET_V6$DST/64"; do
> +		# the dad argument will let iproute emit a unharmfull warning

unimportant but minor typo: unharmful. Also above aggregates -> aggregated

> +		# with ipv4 addresses
> +		ip -n "$NS_DST" addr del dev veth"$DST" "$ADDR" \
> +			nodad 2>/dev/null

nodad probably only matters on add?

> +		ip -n "$NS_DST" addr add dev veth_rx "$ADDR" \
> +			nodad 2>/dev/null
> +	done
> +
> +	run_test_csum "GSO after GRO" "$OL_NET$DST"
> +	cleanup
>  done
>  
>  exit $ret
> -- 
> 2.52.0
> 



