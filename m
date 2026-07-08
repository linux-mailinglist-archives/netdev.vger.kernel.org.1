Return-Path: <netdev+bounces-305979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n/haJ2iyTmpYSgIAu9opvQ
	(envelope-from <netdev+bounces-305979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC572A310
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Nx8Dr/ya";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305979-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305979-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D63B4300DF4A
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF903876B8;
	Wed,  8 Jul 2026 20:24:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FC439320
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:24:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542266; cv=none; b=s7thu65s+Atwjd/JaO7i6HevsINc0GpFRJxwoNtVuFcobkCn3WbW4J76V5Mnyz/Dyk1TE9Iry94pgigLRKAxE64NMmIgG3sQk1JhPGvvsukYMYQUWmAdIfel5r7DEVduVj7rev3E68IIdXySt8FNatOwMbir7iGHyB2l3oO2Bis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542266; c=relaxed/simple;
	bh=TXXbCYEXpC+9kfz5SYw/H/+O5UyHxNvVsZaiufM/gfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saVPgHy4+cxPUqrbTomWIhOsVtvzr4uZJ5srEoutz6V2jtDSFuU0g45vQuNWtTxE4jRyBIDg+LHKD9zJs8xxj+meu5URt2hW++Ml774CeiRMeTIlL7Jn3TRnGHjdH1FvZSMz4R7flaiZ1mSEG6KMATsHFHJB/i+HRf03FuwwnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx8Dr/ya; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493c52cde9eso1478685e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783542263; x=1784147063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Hqm+SrTRL+/Dklgpg/R/6ZCv3REs66MksaYhdwdmzU=;
        b=Nx8Dr/yaRyePKQXOircY3Q9LMIG9zAKBVGsn6XvlqPf12gzwh26mQ57kMmx69AQ3R9
         d2qDjMPa7kMTeNz28ZPQec2WUhIVUR74fI3+watgu+xB+oog1H+347Ld4jyQqx7fkY4n
         LNgSCpX3GeqQ1Xj/IIqGBYbBw9Dvnvxv/0VRlVuAV+WjZNpgEHU83dq0NAXE77Wsa20A
         5lwiltGCMZmgiOw2GjACWq9TW7AOLoGngQ8wWGxoyvPNzXl3TLxaLzF65xRScEmrH/85
         kstVBblOVXOm3SlBPgFJvnCFMMsanxVYg/WUXbfE1pbq7SHewKFMcT8y216R01jt6LeR
         9wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783542263; x=1784147063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Hqm+SrTRL+/Dklgpg/R/6ZCv3REs66MksaYhdwdmzU=;
        b=gH0W0ruFimWZZBhUGcz7meCm3mrHZZzDQk+fcYkG1szhPppOUC/GWR5ItqM787Rri/
         bt/1XkfCDEd+At21It/OAp+aHk/50RKT1iRCKUWPC4vg0/UsesOoUTginut+2tm235DQ
         N6wAoCG/9rYg5V63X2ML1D5oSgSs/hCizKJjXFYcNZOBOEsVrlQ5OdD14nzQLzqnE5bG
         ln7oZK4ODeeFIdm9fVzToYbpfX4YemXKJpn6/G296f+r+PN67Js4IajHHyCGm/1omDcu
         ED4DTs+yX4gRt6fXWbhY/ZMC4+wv0zNMaKwR15gpMnh+Id4vAuJ8YRplSk6m+DxuvEbJ
         EpSQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGhmNHR90ldJ4SXIiLe+pJtAHBoz7jqsESb4+S3f2gqzAuTaa5ogJDDloFG5667UUAarsO4+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxduSsl5dRn39MiEpCtTFcigE9Vrd4gmD6UDD6DLzq4EFNNgEgI
	IRRnhhMeNp9iOisAMLk08qHOmH7s6e0UfIN3zZkxMp13yhDuH/FmRgJz
X-Gm-Gg: AfdE7ckltdWNfIorHMJxk+ovt75J0KaeqoUs+UFz9lxTItpKTUVbLU2R0xta15+9OlI
	zh0RR+fK38QVzFOvt4/B5Q/H0Q1shJfxAo+VZpBLQ3BFcZmes4G8Vr42tu6CvmsWMf9gIM0nw3P
	I5C+B3INuE7oqX3VcF64vKVR6XSAz9n1rIZ4dSOucHopgfTrVGiZUyDnPpv9WsUHX1ZTjUG8pU6
	NUmM/6kP0N5XGTojVj6rQ7hoAsvLorLgqepyVUqG7jtbhAzlFf8ofSKC026x+Gz5nHVMZcpewq1
	9E153Fs/DQt4Gci/DHJwE15gOsYcceAVE4Y13USjA4pJe6jnHoKXKP/qNITAmZidPtF5VeyBezw
	IRnbiE8LaDZJg+1exWKAxpUk1qc0443RuumLyG4hCSyrqww2DghWmoB0Z0R9j2kq8zq1ATwVLMZ
	+p8IoGLvz9YMA580BYDztypdn402k7c3r0zPy6u3lo
X-Received: by 2002:a05:600d:8445:20b0:493:cd3f:d097 with SMTP id 5b1f17b1804b1-493e68a0f7bmr32761835e9.12.1783542262863;
        Wed, 08 Jul 2026 13:24:22 -0700 (PDT)
Received: from archlinux ([143.58.204.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df417sm4407995e9.8.2026.07.08.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:24:22 -0700 (PDT)
Date: Wed, 8 Jul 2026 21:24:20 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <ak6jtwbct3C5lZPA@archlinux>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
 <f398373e-2cb4-4649-a491-9763df94d98b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f398373e-2cb4-4649-a491-9763df94d98b@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,archlinux:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7FC572A310

Hello Matthieu,

On Wed, Jul 08, 2026 at 05:50:53PM +0200, Matthieu Baerts wrote:
> 
> > +function trigger_reactivation() {
> > +	# Add back low level module
> > +	modprobe netdevsim
> > +	# Recreate namespace and two interfaces
> > +	set_network
> > +	# Restore MACs
> > +	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
> > +		address "${SAVED_DSTMAC}"
> > +	if [ "${BINDMODE}" == "mac" ]; then
> > +		ip link set dev "${SRCIF}" down
> > +		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
> > +		# Rename device in order to trigger target resume, as initial
> > +		# when device was recreated it didn't have correct mac address.
> > +		ip link set dev "${SRCIF}" name "${TARGET}"
> 
> When I execute the test, the "ifname" bind mode works without issues,
> but the "mac" one not. From what I see, the socat process doesn't get
> any UDP packet when expected. I wonder if the problem might not come
> from here: the interface is disabled before changing the MAC address and
> renaming the interface, but not re-enabled at the end. Is it normal?

Yes, the expectation is that the target would be automatically re-enabled by
netconsole. That is why we don't 'up' the interface here explicitly.

The problem is that the test has an implict dependency on interface mac address
changing when we recreate them, which is why we have to do this whole down/update/rename
flow to trigger the reactivation in this case.

> If I add 'up' at the end of this last line here, or if I remove the
> whole if-statement block, the test passes.

For cases where the mac is persistent (e.g with systemd MACAddressPolicy=persistent),
the actual re-enablement should "just work", which I suspect is why it works when
you remove the whole if-statement block.

I think to make the test more robust to such scenarios, we should skip the
if-statement block when we detect that the interface came back with the same mac
as previously. Something like this:

if [ "${BINDMODE}" == "mac" ]; then
	CURR_SRCMAC=$(mac_get "${SRCIF}")
	if [ "${CURR_SRCMAC}" == "${SAVED_SRCMAC}" ]; then
		# Interface came back with same mac, no need to restore
		return
	fi
	ip link set dev "${SRCIF}" down
	ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
	# Rename device in order to trigger target resume, as initial
	# when device was recreated it didn't have correct mac address.
	ip link set dev "${SRCIF}" name "${TARGET}"
fi

Could you confirm if this fixes the selftest in your environment?

> The "network logging resumed on interface" seems to suggest that the
> previous patch of this series here, commit 220dbe3c76ed ("netconsole:
> resume previously deactivated target"), managed to resume the previously
> activated target, but not in my case.

Thanks for including the logs, this helps quite a bit and I think confirms that
the interface comes back with the same mac address as previously, and is indeed
resumed, I believe the down/update/rename portion of the test then drops the target
and causes the failure.

> What I don't understand is why is it working on the Netdev CI, and not
> on my side. The main difference is that I might be missing some
> userspace packages -- but I don't see what can be missing here, all
> other netconsole tests pass -- a specific kernel config, or not applied
> patch. Or something different on the host -- in a container on my side
> -- but there shouldn't be any interactions with the host here,
> everything is happening in the VM. Any ideas? :)

Netdev CI executes with MACAddressPolicy=none (which is why I added the if-statement
block [1]) and I think it might explain the behaviour difference.

> 
> > +	echo "Running with bind mode: ${BINDMODE}" >&2
> > +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> > +	echo "6 5" > /proc/sys/kernel/printk
> 
> Can we remove this? Without that, it is hard to understand what went
> wrong in case of issues.

Can you elaborate? This is typical for netconsole tests and I think required to
ensure the write will show up on netconsole. I'm not opposed to changing it if
there is a reason, but we probably want to make it consistent with other tests too.

> > +	# Send the message
> > +	echo "${MSG}: ${TARGET}" > /dev/kmsg
> > +	# Wait until socat saves the file to disk
> > +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"
> 
> In my case, the script was stopping here, without any message. I can
> send a patch adding "|| true" to go to the next instruction, and display
> "FAIL: File was not generated.".
> 

This seems reasonable to me.

> > +	# Make sure the message was received in the dst part
> > +	# and exit
> > +	validate_msg "${OUTPUT_FILE}"
> > +
> > +	# kill socat in case it is still running
> > +	pkill_socat
> > +	# Cleanup & unload the module
> > +	cleanup
> > +
> > +	echo "${BINDMODE} : Test passed" >&2
> > +done
> > +
> > +trap - EXIT
> > +exit "${EXIT_STATUS}"
> > 
> 
> Cheers,
> Matt

[1] https://lore.kernel.org/all/20260117092227.741cba3b@kernel.org/

-- 
Andre Carvalho

