Return-Path: <netdev+bounces-256237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNEoIEDLgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:17:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE219D777B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AB753052370
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4152F313E3E;
	Tue,  3 Feb 2026 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3tS6Jc6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZorrZ5s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A92309DDB
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113818; cv=none; b=erfgJMf7m2jOKxtQSmADBHqyTbDgtOQP5D4T2/GyysY/IgtYIGhJCmZQGhtwlku1PG7nEzWH6y8SC9+I+KQt4ZbD9RZi+74kG+cqjQz+pgAiywHVz3G5NaCmKcqkTBkFcohIWMqTUxujfa1Rv5cER7utiG2/ttBH7XKikpqXkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113818; c=relaxed/simple;
	bh=zzrjZPXfYdNR5ur4+DAFLb38Y57K+9PEFWBPSbmtPds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d64FFuZeweyeR5E9QDnV1GDh4Xog4eoch3BdBmTB7jmING5jl/PH7OqOLHV6RlIUWv943XHYMQE3tVdr9DKRTpvp54oBLEKz8YGqZJHFDtBaUTxgd9VMAfzxYBGv63Dijc5mAQ/kn1MChTVYjFnS71N5TdnHJhCSWU2e6GZYdCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3tS6Jc6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZorrZ5s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770113816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
	b=H3tS6Jc6ZLhP7mYlkC6vF7mFAtmNNS1jwoTAQE/Au1BFNjAgetMo8RschsZVzNePmzlKGL
	8KWdAjhb+os3hogrpWgPuEz1Kdi1TihkhpBN7k6M5dLvN1jahx0ycj8F7MQE83rrfRa1k+
	1Ogz/0/rkUv0a19bxgDrjK15od7TM7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-DlfD67Z9PNGIi8DxtpSmLQ-1; Tue, 03 Feb 2026 05:16:52 -0500
X-MC-Unique: DlfD67Z9PNGIi8DxtpSmLQ-1
X-Mimecast-MFC-AGG-ID: DlfD67Z9PNGIi8DxtpSmLQ_1770113811
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42fd46385c0so3430678f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 02:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770113811; x=1770718611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
        b=WZorrZ5sXghZyCstwYDVxGn/NNSD+stCSM7fCSmT+ZCg4OQJRIFql2rrnL55Xdj70H
         VAvxlw9E41FKVBWb0J/r37OCzbc2HUiK2h+q66/bvPUOG99Qca5voqbe+4qDFXhqyco0
         tgfEeLadXSpjD4fE3z49eoruA4VKz/hUM8ZdAzRP3EexmewG9SdZfLcagMs0TA+zY3cO
         UFwr84jXbM9Y+4MBpzS08yLeepq/8Nf7lpm1D2yFC43FlUiRjqbbH8QUutSqCdGc+jZD
         kPsxrxxtyCAfszKZRBksDTASbfFLxH/CxFYBRHzdkeSrRAVTUQn9yb/2vThgJgYKQwkq
         cPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770113811; x=1770718611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgOiGNLBCV5ZuGn9jd9GSFwjMR0aHZj7c6CyZV90AEY=;
        b=aZYzf58ag56OP5i3WLe8G5r84o+Mx8WhSKI5C/rGzNZcyKWdrq90K3uw5avNNbchYh
         y1dSUQNIBNOY7Bt+sElCjFYoJUcgaB3zZ4eJXZkYA8AizntAdf8P35znMwsDulhJYUQT
         FKtG0kmNOkMevvbm+Z3Q8SA9PADYdQOHvIxgViv2kQpVvWF745CjRAf2KWqVaQzchKXt
         QeZrWB/fMMZp0bO2nO/Udh6Qc6XT8aH8Vj8yIeband7x0iL0yyls+kCuP9A5EwE8zBPm
         KMGXdB8ENi5scbIFGkUhu501fvGckFElwcL9JklmG/Kzj4b7AnSAo8dJRJ9he8daHRiR
         WW0A==
X-Forwarded-Encrypted: i=1; AJvYcCXgtW0Dd/83BlYzBtXfhgavEIpx57TlizXyLj54/k3p2XdjKWYFboL1FfkXweOgmWm3U3E9myc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDBHlZmSj4YnQlLZrWFTBIXcXbrXi2K2+p2CSTl9ayd8njorp
	mv8+jhfPT1QsQIFLt2H9m/mb4OZldzg7kjqm4k8bnlS+sE5EIBRKTf3xaBfY6iPJkWvkHU8fhSK
	29JmPd/QEid1DJWg2N/dvm5sjecukvRD/lNxrXvxxOcp2kuUNExoPEtuTUA==
X-Gm-Gg: AZuq6aLbO0rBXL90o5snoTI2ErfL1tYL02b7ymNzC0zPdKh2jxg2DhpMBtM+EerNTLP
	CDBacBRUb3kWT1DyAFFlc3uhJG6v0lazHWNhBd4YA/O1Hygz9YAtRQB+CpLqU9Fn2rkSb+lpogK
	GN1Msu6Y5EhvVfqAz5rawwHFQVvRwuI/FpqKUa+aMHzpAJWoufovQzy3kOSjrulgRoCX/rZTDpN
	8cqKuBuwjwL1kTPsmnBUUgcIrxrnLkEj21UW5Yj4f+472NUNmrJei6VziZ6+9GxjfsuEhidSK6V
	Xzcxe1JcCMejgWkJFJTXg4tqbDBjaonzxVVb6AH3Vgt9MIcyWZvkfbPtyAM9ViQAPy3XspQsKYa
	Qbff1SZO00MU=
X-Received: by 2002:a05:6000:1862:b0:435:729b:c390 with SMTP id ffacd0b85a97d-435f3abb192mr22523242f8f.47.1770113811387;
        Tue, 03 Feb 2026 02:16:51 -0800 (PST)
X-Received: by 2002:a05:6000:1862:b0:435:729b:c390 with SMTP id ffacd0b85a97d-435f3abb192mr22523181f8f.47.1770113810888;
        Tue, 03 Feb 2026 02:16:50 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edfccsm48741670f8f.17.2026.02.03.02.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:16:50 -0800 (PST)
Message-ID: <ce09e17d-2b74-4bda-a8ec-352c92659a6e@redhat.com>
Date: Tue, 3 Feb 2026 11:16:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/5] selftest: netdevsim: Add devlink port
 resource test
To: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Or Har-Toov <ohartoov@nvidia.com>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-5-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260203071033.1709445-5-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-256237-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE219D777B
X-Rspamd-Action: no action

On 2/3/26 8:10 AM, Tariq Toukan wrote:
> From: Or Har-Toov <ohartoov@nvidia.com>
> 
> Add selftest to verify port-level resource functionality using netdevsim.
> 
> Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> Reviewed-by: Shay Drori <shayd@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../drivers/net/netdevsim/devlink.sh          | 32 ++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> index 1b529ccaf050..674f0e981ab0 100755
> --- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> +++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
> @@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
>  
>  ALL_TESTS="fw_flash_test params_test  \
>  	   params_default_test regions_test reload_test \
> -	   netns_reload_test resource_test dev_info_test \
> +	   netns_reload_test resource_test port_resource_test dev_info_test \
>  	   empty_reporter_test dummy_reporter_test rate_test"
>  NUM_NETIFS=0
>  source $lib_dir/lib.sh
> @@ -856,6 +856,36 @@ rate_test()
>  	log_test "rate test"
>  }
>  
> +port_resource_test()
> +{
> +	RET=0
> +
> +	local first_port="${DL_HANDLE}/0"
> +	local name
> +	local size
> +
> +	devlink port resource show "$first_port" > /dev/null 2>&1
> +	check_err $? "Failed to show port resource for $first_port"
> +
> +	name=$(cmd_jq "devlink port resource show $first_port -j" \
> +		      ".[][][].name")
> +	[ "$name" == "max_sfs" ]
> +	check_err $? "Unexpected resource name $name (expected max_sfs)"
> +
> +	size=$(cmd_jq "devlink port resource show $first_port -j" \
> +		      ".[][][].size")
> +	[ "$size" == "20" ]
> +	check_err $? "Unexpected resource size $size (expected 20)"
> +
> +	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
> +	check_err $? "Failed to show port resources for $DL_HANDLE"
> +
> +	devlink port resource show > /dev/null 2>&1
> +	check_err $? "Failed to dump all port resources"
> +
> +	log_test "port resource test"
> +}
> +
>  setup_prepare()
>  {
>  	modprobe netdevsim

This test is failing in NIPA (adding some more context beyond the
failing test output just in case it may help):

# Error: netdevsim: Exceeded number of supported fib entries.
# Error: netdevsim: Exceeded number of supported fib entries.
# kernel answers: Operation not permitted
# TEST: resource test                                                 [ OK ]
# Command "resource" not found
# Command "resource" not found
# TEST: port resource test                                            [FAIL]
# Failed to show port resource for netdevsim/netdevsim10/0
# TEST: dev_info test                                                 [ OK ]
# TEST: empty reporter test                                           [ OK ]
# kernel answers: Success
# kernel answers: Success
# ./devlink.sh: line 614: echo: write error: Invalid argument
# Error: netdevsim: User setup the recover to fail for testing purposes.

/P


