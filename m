Return-Path: <netdev+bounces-256982-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EClXKbc3hGn51AMAu9opvQ
	(envelope-from <netdev+bounces-256982-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:24:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3AEF00C
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E431430071CF
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38667350D6E;
	Thu,  5 Feb 2026 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibrkM/IM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m3IhX9zp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714934A796
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770272686; cv=none; b=XOPnkwPWGeZzuIV1OkJiCcuoJEwVbGQizOOSLg89Bmf+RbWBfxKdjo+hVNEsLa6vAzfIQMDPWLcNrE30tMYZuZKSt3SVC5ZgC4nFg3uALK1ya+xerAI5CL2jcP8PYO37/yKf4fKGLUzAG29QduzRMEkQKnTeNFwzM+yS8Ko9H+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770272686; c=relaxed/simple;
	bh=Mh730ABqeOHc+soxt/YN15a26Ao35FZi4KBbK5G8SHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxRvW4qHCCA5Rl1A38sBq1qOthQNGZ/z46u24MCH68FDsK5mNrwzpDZXpmtfbfw1slFVoOLYMRnuMXJWqux1YlIiWhRtDWPc3lY8ltHJ8tMl8E1TRMz6eL4YIQtPXunofHi+5ebcclmyzWyazOxE89HWh8bqnLrVrIq7MDV1pCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ibrkM/IM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m3IhX9zp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770272684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18afiwTs2Q1K1O6pkKB+aeDkBjoxoyzyrBart1C+0Rw=;
	b=ibrkM/IMY7f5gV7ftjT0mpVtgI5Nn9u21gayKf6HVwjrg+3WgfHxDI+uWTk9VCqG5g2CJ+
	OQYo3wNPvN7I7YOa+63xd9EF7rHqqdyjt3A0B05hMqzLvs2UEGRDEs0h7uxDxBpBTV/rHg
	/wvQagSD+IX2T21d/lpHanlpoza9jlU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-EFxbbSL1NGOWZALPS5w_Cw-1; Thu, 05 Feb 2026 01:24:43 -0500
X-MC-Unique: EFxbbSL1NGOWZALPS5w_Cw-1
X-Mimecast-MFC-AGG-ID: EFxbbSL1NGOWZALPS5w_Cw_1770272682
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801d21c280so6460365e9.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 22:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770272682; x=1770877482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=18afiwTs2Q1K1O6pkKB+aeDkBjoxoyzyrBart1C+0Rw=;
        b=m3IhX9zpxYz0WcnMrYcSyPjz14f8NH9vAONV33bLuV9pJw8oKZqt6QXB+JPNO0Zptz
         Xm+43fNiSJ8TuL6meENRrLT1qu06ZCRtu9ulgLz5iXS3d5vHRqulHOq0ZpOXZLTjU/cr
         XXRXgtfaZKRbaQ53cATuzc0JNtWhccnoDygitvmaEvJLYqmZ6X7SG1buYJSqUnUPbBKK
         4Bi8nYWVR3jtxXj+NZ3/C9l3N4lJUwxjSqc+WuFjAWu+5l/7LBjRBBwr0UfAyunsCSB5
         hvPHhcxLCm1cIGsAqnubAmaC5w3HFEncBVWfDgK1dhC8ztgr4HGnxOT+v/AKeXDmidgV
         jaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770272682; x=1770877482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18afiwTs2Q1K1O6pkKB+aeDkBjoxoyzyrBart1C+0Rw=;
        b=B02sZLcuSHZjX6fjJw5Q6ZXUmN+c+3cEmU0rNWdqmDoMSlDi68Af1SrxYB4/HquuIs
         Bf1NUkHWJUrQXMRAqrMq7Ujso5SHqK9Ykq0mtDjyn2JDA4NEy+qF9l9q38mskiAVarQV
         /UvaRKoILHcP35b4PsJirdVl5ift334HJTI3TPRnfIjcWyAIv75OAvxqbgjW+FSrUGEi
         Hz5s2d6WefLX6mlLJqSpvyYAinHfX7D+je50hE+UBuCctxU3zLzm5cbxqJ5QA2iNl/e8
         56/vRfO7jPUPDBhJVM8kUCAQs0sZBQjlHPIMsvJ92w3PAlXx5xMqXIezXgq3Ic0wnMU9
         5+ug==
X-Forwarded-Encrypted: i=1; AJvYcCWiAUItirsDzla2AjBFG7CScEybsZSm/WrUN0HEoGV3IAf1YDNA5EcAnkvW98vtUIu2Xqsc24E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5u0JNvt0897Hegn6V9uNNAIzBO76l8HUplJ8gEgyX3TjJ4DD
	QqcgGzVeqsmD/ThhC8TjD1s4aeyYCEQklA19ZfAlCWZKRuG3BDFswB4G8gZvHgrNypprW9nQKXC
	rlsVkgfHCn+CuQdjzsu0Qi3inc1RrpgyyCo53zToEj9x/4naBuMXjTiJ9+Q==
X-Gm-Gg: AZuq6aKzCVrlhJxAcgFOPs5c2yZFTJjiPMPMq1SCghfm2UmNGnZzE9QH+AJKERO72Ek
	Ks00BCBYNoRAU5MDJoQ4odEPyBavcFsxK5VJQXLEaqmpyfjhi2eOkKY7y8TVZ4G+j5kYg0yeg4F
	OQaxHu/7oiCCApqLNaJQwgUqsyibrnRBX5TYp75W8r0zmRO1hABbO47/KIOQquWn/shZOd1w6Xm
	W1fuwAbWBgLhOfN33FhExk6VCHpDtwTDtN6v6qRM7jlV6i9I67q3DA7dE5jGPFi7S+qwWyYNrFf
	umoQXKWKLknVilHh3p/o18UteC6tE91SWno5hqk0kxwgxkACDUlJg5mTdP87fxcddcaTz9lff0n
	fhCP0QKXc2tj73Q/xombECK96Jw6NTNMczQ==
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr75710965e9.22.1770272682168;
        Wed, 04 Feb 2026 22:24:42 -0800 (PST)
X-Received: by 2002:a05:600c:8b30:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4830e96ada6mr75710645e9.22.1770272681559;
        Wed, 04 Feb 2026 22:24:41 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d299bfsm31921785e9.2.2026.02.04.22.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:24:41 -0800 (PST)
Date: Thu, 5 Feb 2026 01:24:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>, Matteo Croce <technoboy85@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v4 2/2] selftests: virtio_net: add buffer
 circulation test
Message-ID: <20260205012145-mutt-send-email-mst@kernel.org>
References: <20260204193617.1200752-1-vishs@meta.com>
 <20260204193617.1200752-3-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204193617.1200752-3-vishs@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256982-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,virtio_net_common.sh:url]
X-Rspamd-Queue-Id: 04B3AEF00C
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:36:17AM -0800, Vishwanath Seshagiri wrote:
> Add iperf3-based test to verify RX buffer handling under load.
> Optionally logs page_pool tracepoints when available.

but it doesn't verify/validate them - it's just a generic throughput
test. so what is the value add here?


> Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
> ---
>  .../drivers/net/virtio_net/basic_features.sh  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
> index cf8cf816ed48..fa98505c4674 100755
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
> +IPERF_SERVER_PID=""
> +
>  h1_create()
>  {
>  	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
> @@ -83,6 +86,84 @@ f_mac_test()
>  	log_test "$test_name"
>  }
>  
> +buffer_circulation_test()
> +{
> +	RET=0
> +	local test_name="buffer circulation"
> +	local tracefs="/sys/kernel/tracing"
> +
> +	if ! check_command iperf3; then
> +		log_test_skip "$test_name" "iperf3 not installed"
> +		return 0
> +	fi
> +
> +	setup_cleanup
> +	setup_prepare
> +
> +	ping -c 1 -I "$h1" "$H2_IPV4" >/dev/null
> +	if [ $? -ne 0 ]; then
> +		check_err 1 "Ping failed"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	local rx_start=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
> +	local tx_start=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo > "$tracefs/trace"
> +		echo 1 > "$tracefs/events/page_pool/enable"
> +	fi
> +
> +	local port=$(shuf -i 49152-65535 -n 1)
> +
> +	iperf3 -s -1 --bind-dev "$h2" -p "$port" &>/dev/null &
> +	IPERF_SERVER_PID=$!
> +	sleep 1
> +
> +	if ! kill -0 "$IPERF_SERVER_PID" 2>/dev/null; then
> +		IPERF_SERVER_PID=""
> +		if [ -d "$tracefs/events/page_pool" ]; then
> +			echo 0 > "$tracefs/events/page_pool/enable"
> +		fi
> +		check_err 1 "iperf3 server died"
> +		log_test "$test_name"
> +		return
> +	fi
> +
> +	iperf3 -c "$H2_IPV4" --bind-dev "$h1" -p "$port" -t 5 >/dev/null 2>&1
> +	local iperf_ret=$?
> +
> +	if [ -n "$IPERF_SERVER_PID" ]; then
> +		kill "$IPERF_SERVER_PID" 2>/dev/null || true
> +		wait "$IPERF_SERVER_PID" 2>/dev/null || true
> +		IPERF_SERVER_PID=""
> +	fi
> +
> +	if [ -d "$tracefs/events/page_pool" ]; then
> +		echo 0 > "$tracefs/events/page_pool/enable"
> +		local trace="$tracefs/trace"
> +		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
> +		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
> +		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
> +	fi
> +
> +	local rx_end=$(cat /sys/class/net/"$h2"/statistics/rx_packets)
> +	local tx_end=$(cat /sys/class/net/"$h1"/statistics/tx_packets)
> +	local rx_delta=$((rx_end - rx_start))
> +	local tx_delta=$((tx_end - tx_start))
> +
> +	log_info "Circulated TX:$tx_delta RX:$rx_delta"
> +
> +	if [ "$iperf_ret" -ne 0 ]; then
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
> @@ -113,6 +194,11 @@ setup_cleanup()
>  
>  cleanup()
>  {
> +	if [ -n "$IPERF_SERVER_PID" ]; then
> +		kill "$IPERF_SERVER_PID" 2>/dev/null || true
> +		wait "$IPERF_SERVER_PID" 2>/dev/null || true
> +	fi
> +
>  	pre_cleanup
>  	setup_cleanup
>  }
> -- 
> 2.47.3


