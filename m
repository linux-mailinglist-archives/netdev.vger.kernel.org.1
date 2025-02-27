Return-Path: <netdev+bounces-170372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEA8A48598
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97D97A6250
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ACD1B0403;
	Thu, 27 Feb 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJ2PPmPp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C411B2EF2
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674844; cv=none; b=UFpmkeb1I62qjN1KULpCW0ThOvMg4o+2R7og/RDWmZxs0deW82VjJmhQS5hxlEWa+07Wm06pjOV4H/s2dBjSwsddMj8BVQzwwP3jcj+ldhbs7Bcscd+R85QU6Zu+eSEuBfyBGEiivbPRZiuu8RyrydoVg0NUjaEP02PE3S7FbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674844; c=relaxed/simple;
	bh=/rzMkWJAJfPBL06MbEDSnPfJRdf/brP5QbGIBbcaSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPiX8EiXmVY2Nco9qSh6m+yHSSJrqYo2czCQfcj75bTv2bKq6PEUyLkRBG4GW43x7slo9MCaB2zTh8ICUHY+bU8+bEBrkDL69yp/vvTebYE0pBKtrLrw7Rb/tW569ayvC0yE1XyQbJMIiSO64asMK8wBrX3Kfj2ia2n84rk2UbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJ2PPmPp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740674841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKnxbPI1FQ0JOzfyVUQu65LhGi5TuooQmZLiovmQwPM=;
	b=SJ2PPmPp6Std6t++TqThl8nskTSYAfzEunNTYO7vdPDZce2KeWTR2Eo4+BQlV2ivKuLjG/
	CWH2/DUUQyeJvkIEkKtmtZb/v0SH7Nn33bs41H3WJaxK3/l4M5686vOdPCnIwa4iDK2vwo
	qS1k7J5mCxLH24y1BrbJ+31LUvP/HNo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-4bxsMxyDNzulgem6WIYXVw-1; Thu, 27 Feb 2025 11:47:20 -0500
X-MC-Unique: 4bxsMxyDNzulgem6WIYXVw-1
X-Mimecast-MFC-AGG-ID: 4bxsMxyDNzulgem6WIYXVw_1740674839
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so10612555e9.3
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 08:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674839; x=1741279639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKnxbPI1FQ0JOzfyVUQu65LhGi5TuooQmZLiovmQwPM=;
        b=lVUj+dG6Z4mq0iJlZOveOdNvrojSxSQODUOEHqp2/C9xRaA96LYJB3J2IOq/6CjQTM
         BKs/sZbANAScVZxrIF8VfyWjudYFdSbmgrks9f6Q31gBuPzYSo0EFcLNbq/7gpJ4iet0
         +QdHjANZT9JfRsREuiQvEEdWmYCjggy0MGttZtfK9VoGbTeduvtg/H4/e9oEs9/ssSgm
         WJXwFdzI28tgs5qBxziBWUSbfGZUw6XStg7usP3Vl2scbw03Fh2rGF0bsxbGYonq/cg5
         f3tXu9ljF4kAvGjISZQTgxN3iAoU6MCACsRwxsS7ZD3bqYN+ZGGGDax/56VHpBg2Vy9W
         lSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+fLQltcf4CBZGbAOfO3XzMaWDYjKpoyPVY4aV5//xhbEzOU0HN0jwyFQMt8dehXB+BJQgUpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhkx5rIkfbvdqNAEzfUqdeqHzrZV1AVbZpETyLi1vF0XH98b+u
	zq/JFwbPAVXEAqS4tLxOudUQKhmnPxya2fRoqWLbP2kLfuan6a2FmSKWORjj4u2s/K+UyDRitN1
	oJwmWtus1LoFo2SyE48YKkcULlYNdZXU6YiC0et30qzm7o+MNxa97Ng==
X-Gm-Gg: ASbGncsGwa2NwafG8j56gknal2cydL6UYuGHfYYU68VhzNPK/s0sDfBpe1no6uaim/L
	tV5okvA0vSYGHOUjMQSmyvKgAGOnXcBotSh072weNqCl1EP7DkOkcz8wsIn67pUtUlnCtAMLdzC
	AKwTbyaVA5W+XYxYlTGbO7ch2OYI/loKawB9cP+loa5rhxx3dmfUI3Vdb27L3u50tpvLSZJ788H
	dR/QryeMB2+EnkDf8kMuQxwcQfbvIi8qy4rNrf5OBy/5IBA5xnW601bqunZFV4mclly3oighIAo
	H9M=
X-Received: by 2002:a05:600c:138d:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43ab0f2db6cmr140034245e9.7.1740674838858;
        Thu, 27 Feb 2025 08:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuM4os2STPuZZOtQ0V7eMIsECWwNUGSnbIx/W83MBBhQHvCwJp9gqEPGIvMnNahEJ0x5/QfQ==
X-Received: by 2002:a05:600c:138d:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43ab0f2db6cmr140033875e9.7.1740674838420;
        Thu, 27 Feb 2025 08:47:18 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm62402435e9.39.2025.02.27.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:47:17 -0800 (PST)
Date: Thu, 27 Feb 2025 17:47:14 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net v3 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z8CXEngzSuTuWylx@debian>
References: <cover.1740493813.git.gnault@redhat.com>
 <a05174174b9fa6a79a9c3ee32e7a5c506d8553aa.1740493813.git.gnault@redhat.com>
 <d1e3d6a6-90b8-45bd-a57f-c8175d0bd906@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1e3d6a6-90b8-45bd-a57f-c8175d0bd906@redhat.com>

On Thu, Feb 27, 2025 at 01:33:25PM +0100, Paolo Abeni wrote:
> On 2/25/25 3:43 PM, Guillaume Nault wrote:
> > diff --git a/tools/testing/selftests/net/gre_ipv6_lladdr.sh b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
> > new file mode 100755
> > index 000000000000..85e40b6df55e
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/gre_ipv6_lladdr.sh
> > @@ -0,0 +1,227 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +ERR=4 # Return 4 by default, which is the SKIP code for kselftest
> > +PAUSE_ON_FAIL="no"
> > +
> > +readonly NS0=$(mktemp -u ns0-XXXXXXXX)
> > +
> > +# Exit the script after having removed the network namespaces it created
> > +#
> > +# Parameters:
> > +#
> > +#   * The list of network namespaces to delete before exiting.
> > +#
> > +exit_cleanup()
> > +{
> > +	for ns in "$@"; do
> > +		ip netns delete "${ns}" 2>/dev/null || true
> > +	done
> > +
> > +	if [ "${ERR}" -eq 4 ]; then
> > +		echo "Error: Setting up the testing environment failed." >&2
> > +	fi
> > +
> > +	exit "${ERR}"
> 
> I'm sorry for the late feedback, but if you use the helper from lib.sh
> you could avoid some code duplication for ns setup and cleanup.

I considered using lib.sh, after Ido's suggestion in v2
(https://lore.kernel.org/netdev/Z7sw1PPY48pkEMxB@shredder/). But I
finally decided to keep the selftest as-is because the small gain in
code size reduction didn't seem worth and because lib.sh makes the script
slower as it mandates the use of bash
(https://lore.kernel.org/netdev/Z73dm4P+Ho4EiprQ@debian/).

> > +}
> > +
> > +# Create the network namespaces used by the script (NS0)
> > +#
> > +create_namespaces()
> > +{
> > +	ip netns add "${NS0}" || exit_cleanup
> 
> Also no need to check for failures at this point. If there is no
> namespace support most/all selftests will fail badly

That allows to fail cleanly, with the error message about environment
setup failure.

> > +}
> > +
> > +# The trap function handler
> > +#
> > +exit_cleanup_all()
> > +{
> > +	exit_cleanup "${NS0}"
> > +}
> > +
> > +# Add fake IPv4 and IPv6 networks on the loopback device, to be used as
> > +# underlay by future GRE devices.
> > +#
> > +setup_basenet()
> > +{
> > +	ip -netns "${NS0}" link set dev lo up
> > +	ip -netns "${NS0}" address add dev lo 192.0.2.10/24
> > +	ip -netns "${NS0}" address add dev lo 2001:db8::10/64 nodad
> > +}
> > +
> > +# Check if network device has an IPv6 link-local address assigned.
> > +#
> > +# Parameters:
> > +#
> > +#   * $1: The network device to test
> > +#   * $2: An extra regular expression that should be matched (to verify the
> > +#         presence of extra attributes)
> > +#   * $3: The expected return code from grep (to allow checking the abscence of
> > +#         a link-local address)
> > +#   * $4: The user visible name for the scenario being tested
> > +#
> > +check_ipv6_ll_addr()
> > +{
> > +	local DEV="$1"
> > +	local EXTRA_MATCH="$2"
> > +	local XRET="$3"
> > +	local MSG="$4"
> > +	local RET
> > +
> > +	printf "%-75s  " "${MSG}"
> > +
> > +	set +e
> > +	ip -netns "${NS0}" -6 address show dev "${DEV}" scope link | grep "fe80::" | grep -q "${EXTRA_MATCH}"
> > +	RET=$?
> > +	set -e
> > +
> > +	if [ "${RET}" -eq "${XRET}" ]; then
> > +		printf "[ OK ]\n"
> 
> You can use check_err / log_test from lib.sh to reduce code duplication
> with other tests and more consistent output.
> 
> > +	else
> > +		ERR=1
> > +		printf "[FAIL]\n"
> > +		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
> > +			printf "\nHit enter to continue, 'q' to quit\n"
> > +			read -r a
> > +			if [ "$a" = "q" ]; then
> > +				exit 1
> > +			fi
> > +		fi
> 
> I guess something like this could be placed into lib.sh, but that would
> be net-next material
> 
> Thanks,
> 
> Paolo
> 


