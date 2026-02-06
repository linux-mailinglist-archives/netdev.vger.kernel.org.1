Return-Path: <netdev+bounces-257505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBhMLna2hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:37:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B84FC1E5
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 73AB33001A5C
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B1E35E53D;
	Fri,  6 Feb 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="muPmwwzu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEB29B8FE
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370674; cv=none; b=mU6P45aNtHCB2lo4LNZk9RMfhHKnJe2wYWuq4FBBek8YHkPfH2l+v07JKn1WNuBmUpjAxq3nhplTnvp6iluAqicqLhVGuaoUrs2MQMtPmw07m27enWiUy7cszt/5Nb77Q526ljd8uB04kkJE20Ty4Tfs751SBbLXKf7R9odowb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370674; c=relaxed/simple;
	bh=a6WHFOsQ0XLpXBz9nVNPRhoAOYofYpq507RpRUTDNVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLjxFqMOzTaQgPFP2vKmHBee2t4V7pCIqJJEibbL9zZ7KgAhe2FSiHWr13iBfKllADAFIa0y0X+StVKqFP3lXygo+Y1safBl988LvNiQRtpljNAPwx4Qu9Samc11TrkqJgVDkTqIXHG5nGWXYFRDJbshEfCI+4T/PIPewEm0III=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=muPmwwzu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so4851875e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770370672; x=1770975472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlRYgpRsjcg2ejK1OLntwoYIyfilHOYKa44N62R1+TI=;
        b=muPmwwzueX6ChKrMLIUoFIuPthLqjLgti/xB4Kj9EoFbpNIvzKFy2b19Ux0lUxQ8aR
         PS4QM0bwvXC5fYZW36TtrJ86G7lfyRYSLyFLNPKOafnSVHcjD7VoPdsI9h6PvGQy+A1p
         9pG2Qjm6hx2+DvLoBPMo2U0fdmtytCIJK4Mt98UnHcMckvf8TOYjzUCq0oIEPLv4H68j
         gQFdUThrQ12CgQE+5tITcOUEYR+MYxOhy5Pa0iLesVWBxWGQZN7scP6KnBvv758bZUr8
         XLDgn1vu3zFI69+zeyrQKo5RDMmkgrHIXTcmlHJvHYiC9MGpRVpqVQs63+Etg/ftiLYd
         dsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370672; x=1770975472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlRYgpRsjcg2ejK1OLntwoYIyfilHOYKa44N62R1+TI=;
        b=nXgf551CaFft8lyrcJW/BFT61fjhuAsec+4kkI+WohiIT7F+MXc6MSH/QJAKa6kRMU
         DpsdhtvooedNHBvRb6Eu4csKLDKxworV+XNkdq8zJSSAxNLJrBrs8rJzXp+miOMvWSqQ
         2iUpDAzfbTCZpaSbUQ/XU89uGTBDEs0IgSwvPcYGnCZyfx37iAjsGtVtsaAqsrT5+W2x
         1Gtlmh+RTovqfZAOz2CwCF8X7bQNj/q41Kes3rARrgDLI99Y/P1hi9ji2bi0W5D8+vJf
         y1h4L3lXBRziakKKqpH35QIHfYRtNLnOtrcdU4j7z2vmN4iJnHMtNVP1StKaqWxCC2rI
         /ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi+/W2aCc7PyvMDbdnc3lIKIO0O483BL1O8l/qdd/SSt4nL81zxnS84OZRgrbfSia59kVxfRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2YUCqMNv9K2+FXgmsoBN0KtHE1XwIMEAIOlxpxog9m7G6Yo4
	mCcJ6wyTMTgnitfnmffFN7MdlVNoHZa9oO+/k+pLm2wZxNVSo8ZCKQpw6ZuwqNV3+dY=
X-Gm-Gg: AZuq6aILcCLMa4U0JYM65DT1J/Xk59IO9zcZMjdL9EWrdM30s8jcV7iikihoZV6oQgW
	iUcb0dVrIZF336Vdcmo+Mjg7AxfBtYMmTYRby07ekMFTj+lW6iMfGlhXnuYRXszBLKjyUZi1y2K
	R4NdAf3qRbAObKsRQlvKbszp8zUrHqz3PbBK+/D8yDbhCbTEFxM57EMYzVcXB2qGY46OYRGojcD
	kD7NT3aVEZTvy9pvULdI8KwD0KFZIk3U65bA+KTrZ8k5HiP4s3qp9IGkLaX+Fp2T8wJOnXZpGTQ
	Qah1Di9ROdQqUcKK3y1oyGKTTx/g+emK1VrjeLYgYS0OEHo9O4SGD1bSD/FG7zheIotVicYizqV
	JZ52AX+8yUrPBlNeqsYE1WobwoPSIjwTBcMq8/QOglnfVtOGzs2CP0rEGFUElsUPS9kQzNkIz9G
	MPdPdo8zB8WCTUfx+U3yk=
X-Received: by 2002:a05:600c:8b88:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-483201d9fa8mr30397895e9.6.1770370671772;
        Fri, 06 Feb 2026 01:37:51 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483206cc7d3sm37505745e9.5.2026.02.06.01.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:37:51 -0800 (PST)
Date: Fri, 6 Feb 2026 10:37:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Or Har-Toov <ohartoov@nvidia.com>
Subject: Re: [PATCH net-next V2 6/7] selftest: netdevsim: Add devlink port
 resource test
Message-ID: <eakcy4lgflnovn64jagsilopjst7xvmhcfujbxwlnphh7pdf5f@jkwcgn5e2ujr>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
 <20260205142833.1727929-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205142833.1727929-7-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257505-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,nvidia.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: E3B84FC1E5
X-Rspamd-Action: no action

Thu, Feb 05, 2026 at 03:28:32PM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Add selftest to verify port-level resource functionality using netdevsim.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> .../drivers/net/netdevsim/devlink.sh          | 37 ++++++++++++++++++-
> 1 file changed, 36 insertions(+), 1 deletion(-)
>
>diff --git a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
>index 1b529ccaf050..272e60eb7bfe 100755
>--- a/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
>+++ b/tools/testing/selftests/drivers/net/netdevsim/devlink.sh
>@@ -5,7 +5,7 @@ lib_dir=$(dirname $0)/../../../net/forwarding
> 
> ALL_TESTS="fw_flash_test params_test  \
> 	   params_default_test regions_test reload_test \
>-	   netns_reload_test resource_test dev_info_test \
>+	   netns_reload_test resource_test port_resource_test dev_info_test \
> 	   empty_reporter_test dummy_reporter_test rate_test"
> NUM_NETIFS=0
> source $lib_dir/lib.sh
>@@ -856,6 +856,41 @@ rate_test()
> 	log_test "rate test"
> }
> 
>+port_resource_test()
>+{
>+	RET=0
>+
>+	if ! devlink port help 2>&1 | grep -q resource; then
>+		echo "SKIP: missing devlink port resource support"
>+		return
>+	fi
>+
>+	local first_port="${DL_HANDLE}/0"
>+	local name
>+	local size
>+
>+	devlink port resource show "$first_port" > /dev/null 2>&1
>+	check_err $? "Failed to show port resource for $first_port"
>+
>+	name=$(cmd_jq "devlink port resource show $first_port -j" \
>+		      ".[][][].name")
>+	[ "$name" == "max_sfs" ]

Test resource name not updated.



>+	check_err $? "Unexpected resource name $name (expected max_sfs)"
>+
>+	size=$(cmd_jq "devlink port resource show $first_port -j" \
>+		      ".[][][].size")
>+	[ "$size" == "20" ]
>+	check_err $? "Unexpected resource size $size (expected 20)"
>+
>+	devlink port resource show "$DL_HANDLE" > /dev/null 2>&1
>+	check_err $? "Failed to show port resources for $DL_HANDLE"
>+
>+	devlink port resource show > /dev/null 2>&1
>+	check_err $? "Failed to dump all port resources"
>+
>+	log_test "port resource test"
>+}
>+
> setup_prepare()
> {
> 	modprobe netdevsim
>-- 
>2.44.0
>

