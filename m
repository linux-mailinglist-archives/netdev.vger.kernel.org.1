Return-Path: <netdev+bounces-237554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8755C4D119
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F0F4274D0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5A2334372;
	Tue, 11 Nov 2025 10:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBC33B969
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856878; cv=none; b=dVDYqW+d9chDDeg4Qqyw1kV0pQ5gzMY220ChJGUgImP1i6coAspTuI7EQTWujnNpziznRrIIfuw7oUjqV+m/AXBJ77aGGdu8Kw5odQgIOjcZ7SrNX+wfklUSAMlVUyYX4KpnU+AUGGKSLWG9M9C850Z1X24dKqhmZF2/lOrIJCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856878; c=relaxed/simple;
	bh=/8CzXfuHcEJlSJRA11zs4FnS8Nv46Y0bC/+D45XIcAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB6vZFezCsXH2HyVtAuuq/SfoPWJywgJ3x779iKFcCVsIMqTaj7kbde1JPYgen3iDAMpgG3Q+mMW4FFTL+Koxiq5y83vgBaU+AjH5nPJRlNZYZ8YslPEpW24ettJGEgcXrFjgGz03/7AmN8lLyYl0Wb4BUN0Cmp//d9WA8I6bSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-3c9859913d0so2262245fac.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856876; x=1763461676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXcNh9uEcUlM67NldM+wkaR6qeKY7aCoNzjVAfRE4U8=;
        b=mgGzTFpP6Kr7kcErkyvRISqpehFE1x5FEkwD8unBGnGoYj6GLn2Ry9bunmcVVov3Tm
         4WL6RFDgBpUwJuc/EKQ/6N4Zw+Gm8m66JSo1V56+hvKDug6S/OpyR1lx6XFphXFcTgYz
         wQAjZGxVuW7JiC58/2V7XfuasH1fHABr1z+6fGRjF6G5kMkD/FTf0MpcrWUbKt/NbGQE
         rtuf8Og0urJx7j2uGih9izLNP7ZDyKsY/MuzSkCvr5dt3QWxzVQtgFnxPeRneumb2i+t
         vWV6tcgQgAITlQG5o1fRZ3m1rBsRwQpJNbWFVrD34TzrXkjKX+is4LyaGakh6cQ4fLIs
         PQHA==
X-Forwarded-Encrypted: i=1; AJvYcCWL5pEdphnASSUFnS1GcBHxs5z7C75lowRXZMu4SLvlSw85v3g1/ZmBKvLYWLe8/rLCGYa7ono=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxX5dnrCznjk/BPaaLAf64uNSRFZeaPRE7G5oULK2pkFFq/uc
	Cp4g8rmw2IZRxNJsxJc8W2VFBxSEcFVkxT4BbspWXqSamM5FuNrnASO/
X-Gm-Gg: ASbGncuuumuFTgPcmBept29bhIcngWk0+WZzY6wFvVrmArqsKHZf8QB+G9surquvjm8
	iDpjUWtI5hWjb5HNd3k9yuJwHuMqGCbp3pj2r2E67D7uSfmQmloj2NKw4x2UoST3y5gO/n9DTqH
	UdaVGR8jGIyO5VgC73oT3q64oa9BVT13IZYJsTSzP4B0yo2CNx7b/vPO3XrNJjJTRdRPd+EJOyg
	tVQQIKJ3aYMw8kk3VH/DttiphXAz2IS3T4kGEspL2Ux12OiLGY6tJZ3cvSLoRkfeYWceVO+2dst
	McjZhZjLSAaHq/WXSiQcGhErljZAwaLcEi0rx0y03zAOlrkj3JVQ0GYGiX3/dnxewLJZI1mJa9X
	cXc/r7Pz/KrJ5RBDnydk/sNA+MBy80ulAii1VIDduYw1NxSuD6SRkFAjc1JxwjZhN+y2L/SyYuI
	7s2Q==
X-Google-Smtp-Source: AGHT+IEzVtMODbxRkCJvy3lTstnvvwHWNG9lfiDUwJA7fVsJcqlAOniXiPB2G6BGunxf9fRFY+u0kQ==
X-Received: by 2002:a05:6870:8123:b0:3e8:172f:da82 with SMTP id 586e51a60fabf-3e8172fdfd0mr1103253fac.19.1762856876015;
        Tue, 11 Nov 2025 02:27:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e41eba8ce5sm7616709fac.4.2025.11.11.02.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 02:27:55 -0800 (PST)
Date: Tue, 11 Nov 2025 02:27:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>

On Sun, Nov 09, 2025 at 11:05:56AM +0000, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/Makefile       |  1 +
>  .../selftests/drivers/net/lib/sh/lib_netcons.sh    | 30 ++++++-
>  .../selftests/drivers/net/netcons_resume.sh        | 92 ++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 68e0bb603a9d..fbd81bec66cd 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -17,6 +17,7 @@ TEST_PROGS := \
>  	netcons_cmdline.sh \
>  	netcons_fragmented_msg.sh \
>  	netcons_overflow.sh \
> +	netcons_resume.sh \
>  	netcons_sysdata.sh \
>  	netpoll_basic.py \
>  	ping.py \
> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> index 8e1085e89647..88b4bdfa84cf 100644
> --- a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> +++ b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> @@ -186,12 +186,13 @@ function do_cleanup() {
>  }
>  
>  function cleanup() {
> +	local TARGETPATH=${1:-${NETCONS_PATH}}
>  	# delete netconsole dynamic reconfiguration
> -	echo 0 > "${NETCONS_PATH}"/enabled
> +	echo 0 > "${TARGETPATH}"/enabled
>  	# Remove all the keys that got created during the selftest
> -	find "${NETCONS_PATH}/userdata/" -mindepth 1 -type d -delete
> +	find "${TARGETPATH}/userdata/" -mindepth 1 -type d -delete
>  	# Remove the configfs entry
> -	rmdir "${NETCONS_PATH}"
> +	rmdir "${TARGETPATH}"
>  
>  	do_cleanup
>  }
> @@ -350,6 +351,29 @@ function check_netconsole_module() {
>  	fi
>  }
>  
> +function wait_target_state() {
> +	local TARGET=${1}
> +	local STATE=${2}
> +	local FILE="${NETCONS_CONFIGFS}"/"${TARGET}"/"enabled"

local TARGET_PATH="${NETCONS_CONFIGFS}"/"${TARGET}"

> +
> +	if [ "${STATE}" == "enabled" ]
> +	then
> +		ENABLED=1

Shouldn't they be local variables in here ?

> +	else
> +		ENABLED=0
> +	fi
> +
> +	if [ ! -f "$FILE" ]; then

	if [ ! -f "${TARGET_PATH}" ]; then

> +		echo "FAIL: Target does not exist." >&2
> +		exit "${ksft_fail}"
> +	fi
> +
> +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {

	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {

> +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> +	}
> +}
> +
>  # A wrapper to translate protocol version to udp version
>  function wait_for_port() {
>  	local NAMESPACE=${1}
> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 000000000000..404df7abef1b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# This test validates that netconsole is able to resume a target that was
> +# deactivated when its interface was removed when the interface is brought
> +# back up.

Comment above is a bit harder to understand.

> +#
> +# The test configures a netconsole target and then removes netdevsim module to
> +# cause the interface to disappear. Targets are configured via cmdline to ensure
> +# targets bound by interface name and mac address can be resumed.
> +# The test verifies that the target moved to disabled state before adding
> +# netdevsim and the interface back.
> +#
> +# Finally, the test verifies that the target is re-enabled automatically and
> +# the message is received on the destination interface.
> +#
> +# Author: Andre Carvalho <asantostc@gmail.com>
> +
> +set -euo pipefail
> +
> +SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
> +
> +source "${SCRIPTDIR}"/lib/sh/lib_netcons.sh
> +
> +modprobe netdevsim 2> /dev/null || true
> +rmmod netconsole 2> /dev/null || true
> +
> +check_netconsole_module
> +
> +# Run the test twice, with different cmdline parameters
> +for BINDMODE in "ifname" "mac"
> +do
> +	echo "Running with bind mode: ${BINDMODE}" >&2
> +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> +	echo "6 5" > /proc/sys/kernel/printk
> +
> +	# Create one namespace and two interfaces
> +	set_network
> +	trap do_cleanup EXIT

can we keep these trap lines outside of the loop?

> +
> +	# Create the command line for netconsole, with the configuration from
> +	# the function above
> +	CMDLINE=$(create_cmdline_str "${BINDMODE}")
> +
> +	# The content of kmsg will be save to the following file
> +	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
> +
> +	# Load the module, with the cmdline set
> +	modprobe netconsole "${CMDLINE}"
> +	# Expose cmdline target in configfs
> +	mkdir ${NETCONS_CONFIGFS}"/cmdline0"
> +	trap 'cleanup "${NETCONS_CONFIGFS}"/cmdline0' EXIT
> +
> +	# Target should be enabled
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Remove low level module
> +	rmmod netdevsim
> +	# Target should be disabled
> +	wait_target_state "cmdline0" "disabled"
> +
> +	# Add back low level module
> +	modprobe netdevsim
> +	# Recreate namespace and two interfaces
> +	set_network
> +	# Target should be enabled again
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Listen for netconsole port inside the namespace and destination
> +	# interface
> +	listen_port_and_save_to "${OUTPUT_FILE}" &
> +	# Wait for socat to start and listen to the port.
> +	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
> +	# Send the message
> +	echo "${MSG}: ${TARGET}" > /dev/kmsg
> +	# Wait until socat saves the file to disk
> +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
> +	# Make sure the message was received in the dst part
> +	# and exit
> +	validate_msg "${OUTPUT_FILE}"
> +
> +	# kill socat in case it is still running
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> +	rmmod netconsole

Why do we need to remove netconsole module in here?

Thanks for this patch. This is solving a real issue we have right now.
--breno

