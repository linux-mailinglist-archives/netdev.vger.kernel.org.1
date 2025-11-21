Return-Path: <netdev+bounces-240781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B3C7A4BC
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5E8135833F
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171D34C806;
	Fri, 21 Nov 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USc0mjoL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IByppNng"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0E7331225
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736201; cv=none; b=OMtH5lUnqrlL8+o8vkKX50wcCUWR78ZToUgwrtdOgxe+iQo0uZy9y/8TWyyYOIGd8ewovtG7eYgw71t3Dj76zv5FTZGyeGc5glqPi30uLZS+J0Juo7cJ63fPCQeZMBTUmoPIOHTTkVovIczJ6KzdMzCyHvBe84KGyMCenmxuAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736201; c=relaxed/simple;
	bh=PszHgCmhtccWSqI0eShhC4jyc/2aRHcMziGgYPJttHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9VILB1KR80Zx8j1fYh3R0g7LDd+4BYiAW6vViCW1JZbU/a8gDLv+0nroB7jUvGH9P9lUN1Rei/cJ3KlchUiRnJbQ+egsEcWrJF2hisEgKf/dL/pEF9/sPqxeg0A2hmetycljj6KE7p7qc8Z5+ztwnHxbt/Xw3MWqRYg8V/CS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=USc0mjoL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IByppNng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OBmGxeL2mYyQ8HpRUGAyaocZQhEEGSfR+zrR8FYGGGs=;
	b=USc0mjoLY9qk7Rh3onM2fAJj20mL/dIfx6f/5YKI0cvY+b7XXsAsBV2VaoN42/oCSHOs1F
	5+3j7Po3mj5fEqYNtDudne1tz2TONvyE9HI4Fr37pP0tmdLvRl8MzEV99hSfCtFRYta08F
	dufFkEI4TbTLw1zDXrydHHWINicT610=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-BIlXM0FcOkabgEcwGj-xNQ-1; Fri, 21 Nov 2025 09:43:17 -0500
X-MC-Unique: BIlXM0FcOkabgEcwGj-xNQ-1
X-Mimecast-MFC-AGG-ID: BIlXM0FcOkabgEcwGj-xNQ_1763736196
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so1693884f8f.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736196; x=1764340996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBmGxeL2mYyQ8HpRUGAyaocZQhEEGSfR+zrR8FYGGGs=;
        b=IByppNngUzS0dRctiu+puXIM40t8xi/Dkm7/fQ8A1jvF8XvqxgOIzhVKJOrUSJoGQv
         VLdvbAzT787Bo7g1YGmUoAfB4WVOCSA1Ip2XXyL6xE5spazVv40mKQpwxK3dWgmQbnc6
         Z+5ow8dSWxpPSEmkcSZmg516G+y7VZTnzzAIExl69+EuKCPCBTUmJQKYLKWNwEbtrgO3
         gzkz1oBoexau1T0Dr3RoWleaZteo79kOKgq8SMXmatWz48oo4d9ZQ4xiZvfma5gfibzf
         AM6PAlk4mfhnSz4cWQzhPx9svCnpmXx1AO/dMdlm/tWUQBw1JYlQVlIrXBfa5CZnQ8nO
         tJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736196; x=1764340996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBmGxeL2mYyQ8HpRUGAyaocZQhEEGSfR+zrR8FYGGGs=;
        b=FTpnubvtuJlBK23yC5coO+6JH7iFeFnkeN1EV0KwUCh+Ruml1QCRYojwYd+2gh54LV
         fPrlkgIicOXyH4GducvzI2U/sJLDPZqk4cj2JE2d/nMgHao0CXLHToz98X61R6EApSdl
         rp1F1zt3fByz2xxbzhMXTmjRbFzDDpTHEBoHnXHM+BdFFQg/gR3+SrilSaK8ECasKG6S
         wrRVM1vpF35oSotahNkNBeKg6HVwlxjBom9xHovcw09Y3fde0DEdg40Z8FJt+awztZOc
         Kppga+IAQFsJvFSd6JTM5XIp2rGUeu86vjo4FMy598vkb6zwHHDYWsNwTDlPCTEYMQj0
         buCA==
X-Forwarded-Encrypted: i=1; AJvYcCVevzOBogGsIgf++HfhMm6E/rSKknlPJaYJ56xcOHGDqp9WBANpzvoeAYb+4UYC6UtF6Ao06+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1pXxKczNUbiGPBfOjhsh3fQbWLp2AJ+gToEwOhQ/ozEEm7qx
	iu9sVnPpvtPTHgTJBOSAb+SY3lGFH3bEpNfEZbGvd2X1hLc9i4dcqiyk3z9fcT/tmhgtfTInNDk
	I4pNurbJ4FLjWywyajGic46YZLPzJk9xwQfsLSUtzV/CoS/XkpHRJaCJTtg==
X-Gm-Gg: ASbGncsj/nphxtsQR7NJDDVr/bOZmH4/kJ5zYS9z0JeCBS2GNzZTQVIrKCva7vjbKbW
	fw4nTN8AI5i8vu8iDUJaaRebwLaPNbYwmj/wqUQCvs2nWCiqnqJyqNF9PHzEBtalLgTGNRrL51C
	6ECPG8kF8uR6nCcfwtMyDMy9XFTO0jVLjWSWpRmfnwXV2IpCtP7Pu41Xb3sX7zleEZbRx8335Bk
	CiSx1pVgVRnxtK592toIueOk3XCvjiNKCnRGLhR9PJBxDhYmFR0cuXvcnJRWmiOZEbvsIr8YiLu
	t2o9DPisCeTeIHaSbgVWBkUI1y1TPkKdUY8K81pvxLo62ws9vXIhyHxjdEUrtm2QLPAJDLxh61Q
	ahZQvjJLDySidX/GJv/lUpQRunvsc6bloqu9tDS0qKCgef580ieUQywrn0H8aaA==
X-Received: by 2002:a05:6000:2309:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42cc1ac93f4mr2817374f8f.3.1763736195501;
        Fri, 21 Nov 2025 06:43:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVXLVg+JpBLsM02kGG0z5u+UchXN/0lwnkDZob5QhAzEG71T30I0VsCqdgircvn6smhqXRBQ==
X-Received: by 2002:a05:6000:2309:b0:429:b525:6df5 with SMTP id ffacd0b85a97d-42cc1ac93f4mr2817326f8f.3.1763736194935;
        Fri, 21 Nov 2025 06:43:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fe8sm11445022f8f.15.2025.11.21.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:43:14 -0800 (PST)
Date: Fri, 21 Nov 2025 15:43:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 09/13] selftests/vsock: use ss to wait for
 listeners instead of /proc/net
Message-ID: <cmi23sbmgpmphjldjgsrronysce3r7zyptcrsqwqa6j5i26m4u@s5wscydfdgpo>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-9-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-9-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:41PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Replace /proc/net parsing with ss(8) for detecting listening sockets in
>wait_for_listener() functions and add support for TCP, VSOCK, and Unix
>socket protocols.
>
>The previous implementation parsed /proc/net/tcp using awk to detect
>listening sockets, but this approach could not support vsock because
>vsock does not export socket information to /proc/net/.
>
>Instead, use ss so that we can detect listeners on tcp, vsock, and unix.
>
>The protocol parameter is now required for all wait_for_listener family
>functions (wait_for_listener, vm_wait_for_listener,
>host_wait_for_listener) to explicitly specify which socket type to wait
>for.
>
>ss is added to the dependency check in check_deps().
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 47 +++++++++++++++++++++------------
> 1 file changed, 30 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 1623e4da15e2..e32997db322d 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -191,7 +191,7 @@ check_args() {
> }
>
> check_deps() {
>-	for dep in vng ${QEMU} busybox pkill ssh; do
>+	for dep in vng ${QEMU} busybox pkill ssh ss; do
> 		if [[ ! -x $(command -v "${dep}") ]]; then
> 			echo -e "skip:    dependency ${dep} not found!\n"
> 			exit "${KSFT_SKIP}"
>@@ -346,21 +346,32 @@ wait_for_listener()
> 	local port=$1
> 	local interval=$2
> 	local max_intervals=$3
>-	local protocol=tcp
>-	local pattern
>+	local protocol=$4
> 	local i
>
>-	pattern=":$(printf "%04X" "${port}") "
>-
>-	# for tcp protocol additionally check the socket state
>-	[ "${protocol}" = "tcp" ] && pattern="${pattern}0A"
>-
> 	for i in $(seq "${max_intervals}"); do
>-		if awk -v pattern="${pattern}" \
>-			'BEGIN {rc=1} $2" "$4 ~ pattern {rc=0} END {exit rc}' \
>-			/proc/net/"${protocol}"*; then
>+		case "${protocol}" in
>+		tcp)
>+			if ss --listening --tcp --numeric | grep -q ":${port} "; then
>+				break
>+			fi
>+			;;
>+		vsock)
>+			if ss --listening --vsock --numeric | grep -q ":${port} "; then
>+				break
>+			fi
>+			;;
>+		unix)
>+			# For unix sockets, port is actually the socket path
>+			if ss --listening --unix | grep -q "${port}"; then
>+				break
>+			fi
>+			;;
>+		*)
>+			echo "Unknown protocol: ${protocol}" >&2
> 			break
>-		fi
>+			;;
>+		esac
> 		sleep "${interval}"
> 	done
> }
>@@ -368,23 +379,25 @@ wait_for_listener()
> vm_wait_for_listener() {
> 	local ns=$1
> 	local port=$2
>+	local protocol=$3
>
> 	vm_ssh "${ns}" <<EOF
> $(declare -f wait_for_listener)
>-wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
> EOF
> }
>
> host_wait_for_listener() {
> 	local ns=$1
> 	local port=$2
>+	local protocol=$3
>
> 	if [[ "${ns}" == "init_ns" ]]; then
>-		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
>+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}" "${protocol}"
> 	else
> 		ip netns exec "${ns}" bash <<-EOF
> 			$(declare -f wait_for_listener)
>-			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
>+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX} ${protocol}
> 		EOF
> 	fi
> }
>@@ -431,7 +444,7 @@ vm_vsock_test() {
> 			return $rc
> 		fi
>
>-		vm_wait_for_listener "${ns}" "${port}"
>+		vm_wait_for_listener "${ns}" "${port}" "tcp"
> 		rc=$?
> 	fi
> 	set +o pipefail
>@@ -472,7 +485,7 @@ host_vsock_test() {
> 			return $rc
> 		fi
>
>-		host_wait_for_listener "${ns}" "${port}"
>+		host_wait_for_listener "${ns}" "${port}" "tcp"
> 		rc=$?
> 	fi
> 	set +o pipefail
>
>-- 
>2.47.3
>


