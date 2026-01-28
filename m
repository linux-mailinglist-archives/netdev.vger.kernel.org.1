Return-Path: <netdev+bounces-254484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHKeAOuJemkE7gEAu9opvQ
	(envelope-from <netdev+bounces-254484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:12:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73566A96E7
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 23:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 164B930160DB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7073341061;
	Wed, 28 Jan 2026 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfOLogfe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sZ7QiAYD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3B0341057
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769638374; cv=none; b=BOuaj75Odb+PQ2qNObqYyS2B2rLqN+wNjvF06iWT0QJXb3iyjJUxlW+u3QXUgQouxSO3BIErQkSAUaWXWppiXiuR4ajPmwWgDND63JqShwbyAlPHAtOmGuJn2JxGSBoCYss/OKUg3F8fn4STQ7tCjRqktYbMzMM1OBNeS5bOvMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769638374; c=relaxed/simple;
	bh=3/ZGvrOJ/EeebmY/pHR1o5er+CrVigjVSeIWhExIpG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUI8M50Ectox1aDWPgcO6EKrrC/Jai3mpsOuIHyAgmB9IOj8iX8vpb/GBTeJUDv/jSqpUFlson7lAas/s1Y+TNNon1krrFafuw8nV8HEqYBcjgWpRT5Jaw3Geo6pyXFmWl8F3c7gmGSspBLzbmheqMFL106i7cVNm1z4H0t3GmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfOLogfe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sZ7QiAYD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769638370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KIT9CsTljwdnJ9erps7fcHJr49NIK4bTScEEBRZFMDU=;
	b=BfOLogfeJqxNbzxpCvjrhrXHICs+P+lxFSCA2oC76ChBfXCzbrH76LvGcYNO/V29w1/jFu
	5uLorL2Rajajc6NuZK+tO8NgWv+xaVeCRlTmAT4E6GGUWMrgYHHvJ/v4pOXpFabqhpRWYA
	BJwuqbq6zNuus1fLwtcgCqb0lsTJ7T0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-WCBAhYV8NISI2yk-pdsNTg-1; Wed, 28 Jan 2026 17:12:48 -0500
X-MC-Unique: WCBAhYV8NISI2yk-pdsNTg-1
X-Mimecast-MFC-AGG-ID: WCBAhYV8NISI2yk-pdsNTg_1769638368
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4359849d324so233301f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769638368; x=1770243168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIT9CsTljwdnJ9erps7fcHJr49NIK4bTScEEBRZFMDU=;
        b=sZ7QiAYDdnPEaKoO2RyiD0rLu9lqLrmZWRnDNPLtmigYAJQ61gKJm276jHRBuyGqPd
         OEsLYNJRigSQd5lRkjURodS62PyF0XXMxEi814zpOcJAW1xPqW3vFNcBVgnL+teE1bov
         pV3OqfdMLVt7AQQY4zcBhUMDNLCCe+J1vxtPb/Xsd2+6LVVpKCj2tqOVQ3vdojj7B2el
         XtVp2QvymixhKGmSl/JYNsEI/knguKNF+CjXYtXV77BtwQtu3xQfrWfOlVGR6YUI1UU0
         stLyptoEeF4HZhHECHiibJzJhnozZWI3cQJpCdnnNppixbuV5xtVSppk1jKdp6cPc+l7
         6z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769638368; x=1770243168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIT9CsTljwdnJ9erps7fcHJr49NIK4bTScEEBRZFMDU=;
        b=AcjRnOhhEywdSVkftuowE6T8UgAAHIXQQ7TDiqbeww/G0ucBVLuhvVb28H250BcBrS
         3sOcU648UeGS+tCNnWMiyYQEb3SLE5kivpiYQfuinj/FMhcnBFXMgNJ/h8Z9ceGB+fjE
         p6GlmY2QOGbScbHpSOQWTxAZlaNxzPIFmHOCdtE/ZKjmpdMC3UUbcLdZbkdgdaIZZcRy
         LlMR1EY/uUpgtcW1s/qtSqz7EBwAp+kwuXjfBwTBJpBDFZKPFALLHUQ5KAcIC+HEqznG
         CCvBtRNzj5njQ2By1b6U+WZJx97kDKvg2co+I/WJc6Wo1u3o4kei7zpLfDfpcGA4ptlw
         0R2g==
X-Forwarded-Encrypted: i=1; AJvYcCXpLCoGOC7+DuPBlQX8h4UKYo57fIyogr7rycGUOLIVV7/miglQwYJelnik7A1PrzbJTw2OpE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaHlZ2SVciRrxAo+baoM2Vf48HhSHInauKuq7/nzmICUCEVsNk
	sGWk6axX2lpkhGVc2mM03j3Y2QyqPqi8+SkVne6w3dMb7hQa/maa3iB8sz5A1m28WlrilPA1kfE
	2i0iq9OWFgONn43uZMf/2sTJm1lH4v/BEX2s/sX4JOa4lDzPJ5sMP5D64cg==
X-Gm-Gg: AZuq6aLti6EYAiIIlrml4ctcl/F6W1IRsn5B3x0X04X+fsYVYYOdJTmfZUIVePUYnYB
	DVkkgaFEUx1ibcLSn6u4iF9qgzaPPuUlo3n34IIVYzcUZtQc1Uh/FnBLGgHOSCDpLMSscgROJFx
	Mj3UsmA6zJTYgWfuuWtelpMIl3+Rr5bH+Cd1EhBTHvStWMD8d7bM5DA5D4Cb2XKnrnVAbPPGGK6
	ayP8s57RKR+1vH5nQ2P23TPMQUxySd2hJQLrcfYDt1Vx2h8y765O8198QFvaSgNxFm85PrPFQyB
	dG2S1dtX4oIdZl7yOLqv5T2kKVYUyju9qPtU3XJ8DRAqb6udd62pnsTgEezVeQH9lAZMF3/yWdB
	HGicg7I66Bas0zKPh95plifhpI0qIz/eyzQ==
X-Received: by 2002:a5d:5f82:0:b0:431:1ae:a3ca with SMTP id ffacd0b85a97d-435dd02126fmr11202398f8f.11.1769638367682;
        Wed, 28 Jan 2026 14:12:47 -0800 (PST)
X-Received: by 2002:a5d:5f82:0:b0:431:1ae:a3ca with SMTP id ffacd0b85a97d-435dd02126fmr11202370f8f.11.1769638367159;
        Wed, 28 Jan 2026 14:12:47 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e1322f40sm9362320f8f.34.2026.01.28.14.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 14:12:46 -0800 (PST)
Date: Wed, 28 Jan 2026 17:12:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260128171144-mutt-send-email-mst@kernel.org>
References: <20260128212031.1431746-1-vishs@meta.com>
 <20260128212031.1431746-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128212031.1431746-3-vishs@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73566A96E7
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 01:20:31PM -0800, Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.
> 
> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..c2c8023d2b92 100755
> --- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> +++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> @@ -6,6 +6,7 @@
>  ALL_TESTS="
>  	initial_ping_test
>  	f_mac_test
> +	buffer_circulation_test
>  "
>  
>  source virtio_net_common.sh
> @@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
>  h1=${NETIFS[p1]}
>  h2=${NETIFS[p2]}
>  
> +require_command iperf3
> +
>  h1_create()
>  {
>  	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,73 @@ f_mac_test()
>  	log_test "$test_name"
>  }
>  
> +buffer_circulation_test()
> +{
> +	RET=0
> +	local test_name="buffer circulation"
> +	local tracefs="/sys/kernel/tracing"
> +
> +	setup_cleanup
> +	setup_prepare
> +
> +	ping -c 1 -I $h1 $H2_IPV4 >/dev/null
> +	if [ $? -ne 0 ]; then
> +		check_err 1 "Ping failed"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	local rx_start=$(cat /sys/class/net/$h2/statistics/rx_packets)
> +	local tx_start=$(cat /sys/class/net/$h1/statistics/tx_packets)
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo > "$tracefs/trace"
> +		echo 1 > "$tracefs/events/page_pool/enable"
> +	fi
> +
> +	iperf3 -s --bind-dev $h2 -p 5201 &>/dev/null &
> +	local server_pid=$!
> +	sleep 1
> +
> +	if ! kill -0 $server_pid 2>/dev/null; then
> +		if [ -d "$tracefs/events/page_pool" ]; then
> +			echo 0 > "$tracefs/events/page_pool/enable"
> +		fi
> +		check_err 1 "iperf3 server died"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	iperf3 -c $H2_IPV4 --bind-dev $h1 -p 5201 -t 5 >/dev/null 2>&1

is using hard coded ports like this fine?
running several in parallel will fail ...


> +	local iperf_ret=$?
> +
> +	kill $server_pid 2>/dev/null || true
> +	wait $server_pid 2>/dev/null || true
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo 0 > "$tracefs/events/page_pool/enable"
> +		local trace="$tracefs/trace"
> +		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
> +		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
> +		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
> +	fi
> +
> +	local rx_end=$(cat /sys/class/net/$h2/statistics/rx_packets)
> +	local tx_end=$(cat /sys/class/net/$h1/statistics/tx_packets)
> +	local rx_delta=$((rx_end - rx_start))
> +	local tx_delta=$((tx_end - tx_start))
> +
> +	log_info "Circulated TX:$tx_delta RX:$rx_delta"
> +
> +	if [ $iperf_ret -ne 0 ]; then
> +		check_err 1 "iperf3 failed"
> +	elif [ "$rx_delta" -lt 10000 ]; then
> +		check_err 1 "Too few packets: $rx_delta"
> +	fi
> +
> +	log_test "$test_name"
> +}
> +
>  setup_prepare()
>  {
>  	virtio_device_rebind $h1
> -- 
> 2.47.3


