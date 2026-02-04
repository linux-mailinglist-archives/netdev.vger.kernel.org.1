Return-Path: <netdev+bounces-256656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H96NzwYg2mKhgMAu9opvQ
	(envelope-from <netdev+bounces-256656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:58:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D290E42E6
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A82A5301F794
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB93B3C198A;
	Wed,  4 Feb 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yQXnBIkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB53BFE5D
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199017; cv=none; b=cwbcvwXwCVHG/byr2D9V+KRJtPS+aBwAb9CsEpkKC9nEcY3wpo5QOpOjVGCxE/aIk58O7i6L7OFxBN9lqHSq+/jqyyvdtl4vOUdaAz/hk3K9Uf74UHtDnyALRKj6ZxU3neuPwMCH6VEWPc8wfyRPynU0SnzgO7KBdZcUjp21gMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199017; c=relaxed/simple;
	bh=c0SSiNKESavwRZtHeDYtsFbwwGk+w/EGhOCZVlQW4wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYyrJIjVT1mRNb89pntbsBAYIlZ9iwA1+qtytdAcate8kHvakNol+Q+nO6wsodNCQS6NYvDvxF9PUSqC9Jms8ZHYlWP8DbnYygjT/V0/ZjkmkVm8qVRAeV1qtMkcYR+tf3hQT5qFvccwyjEwE7vJtL7xLBD9fCx1J0T9E0kDarw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yQXnBIkG; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so47732955e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 01:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770199016; x=1770803816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaBsez7vELTsNb/sMEe0+EHGenrpZkeztrL57KkgMuE=;
        b=yQXnBIkGW0ElIC/OXWcyplPwOOU0IIyJdg2coACLZBwEAL3kAFpLZpCqnTmfDTPtiG
         2zVbqzDrgzqlUL7Ja9XWDQV0ujbRrO5KZL3G5M0n+dPQwbNMj3+CF+EZfFliCM6N5Txa
         rJDqCgzxoFgzjS0did4KHpryRo02BpSKDJ5y5T0VqSbZTfwlHO0/fFwwV2T0Vf4EIVlY
         rIOegYO/OE1z3Su9rBc5No3IDgGWqcEHRb9NeGDzU+kEenwKqvCoQoQKtdcWRsUgtQPp
         lisED1YCVMCvDSG0056FrhEsGYv8OwiFcsE5MZXwmgR35UH9O7JhFcEvjVLyvS3s3WjO
         DT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770199016; x=1770803816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TaBsez7vELTsNb/sMEe0+EHGenrpZkeztrL57KkgMuE=;
        b=Hvu/SPnUiiD8rRAHduOLqNiDEXhc0SibKYq3IqtIdiioPavLBMnQi15qjMjtq0cHKz
         /ppidqLRuf3oLVKDhoZ0PuX6E5oCclqBZcCAkUnwE2kl8v59EUw53q5KjgY7yR12xRKc
         VyNuLue914pHloJwPH//Y1N/pnAG4FXx7fCT5V6ZBBPfINcJym2ONDjcATVJU0hjn0fO
         tgeb24aGl4zTbgJ0JA1Qn0kMudCFUv7aQk+jp6ppI6WupZ0nUL6Oy+ftGf7OEJG29nZg
         4596D90+E6oBlhNFN8heMQMmQP7Dc7L+WVaYRWCP/8i5Vdi8IF4gkkI0o0fPxTLiMdcm
         UiIg==
X-Forwarded-Encrypted: i=1; AJvYcCXi4jbEg0ebQY8dws15eNUAiE6pwxJlEm6voOkr8tHo+yaJnqFCjcy53awg9AwrcfWfydTW8lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvhYy/8m/4vTzbTDzgnDKF/n0lnTfKG6iImktw5bUpXU8sYLOn
	x6dqJ5+dmnhRiipTZgf493Hq7bbbDk2vgK1/g60b6IADf2p07XsaZq3sAWa3fiYBED8=
X-Gm-Gg: AZuq6aLzm5HCSzvuJDcIOToMWKkMqA6kn9Tw17YLmnp0uYWALb+OOeMaL02Ygs/i3Bm
	ugExO4C/QHYBPzhN9MFuc29g1bavjmQkW1HuaBkDryitlLEUI0A+kzRIbsdOrlx4+jcqkohodtX
	Ia4DGD8MtrptWyxxCUK5Bn8XDS9iM42XH7onjQiRX5Wsw8x6CseV4RYbX1QU9b6syr9JMG7h3H/
	rqtKL16gCZCbshxYgu1DZiQq7F4axIdbhjuKj3d8FtSfAHvBe1wadIPUAWY52KiKGB/NX95xdrX
	iZdlBccieQIKX1T+5Z72dnRBdRCgGo3mEuLvYzRXAej8Vd+FoROy4VTfzRGK7z9jqgSE/lTlL4a
	7TUOnA5+t+uYZLha4kLArOrJdIf0jqQLae6Rx/Br3277VGaR7DVoIQpfIKTdpuXiX8Haf9G4H/H
	V1BPTZum8MR2TFI9twGO4=
X-Received: by 2002:a05:600c:34c3:b0:480:1a3a:5ce6 with SMTP id 5b1f17b1804b1-4830e93ddd9mr31664665e9.14.1770199015702;
        Wed, 04 Feb 2026 01:56:55 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831089d547sm44206485e9.14.2026.02.04.01.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:56:55 -0800 (PST)
Date: Wed, 4 Feb 2026 10:56:53 +0100
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
Subject: Re: [PATCH net-next 5/5] devlink: Document port-level resources
Message-ID: <ew6f3nuo3u7cwegwadlmqotxl6ns7c6pa3h4ljbuxkqbq3xxe7@sy74qkffcpze>
References: <20260203071033.1709445-1-tariqt@nvidia.com>
 <20260203071033.1709445-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203071033.1709445-6-tariqt@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256656-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5D290E42E6
X-Rspamd-Action: no action

Tue, Feb 03, 2026 at 08:10:33AM +0100, tariqt@nvidia.com wrote:
>From: Or Har-Toov <ohartoov@nvidia.com>
>
>Add documentation for the port-level resource feature to
>devlink-resource.rst. Port-level resources allow viewing resources
>associated with specific devlink ports.
>
>Currently, port-level resources only support the show command for
>viewing resource information.
>
>Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
>Reviewed-by: Shay Drori <shayd@nvidia.com>
>Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>---
> .../networking/devlink/devlink-resource.rst   | 36 +++++++++++++++++++
> 1 file changed, 36 insertions(+)
>
>diff --git a/Documentation/networking/devlink/devlink-resource.rst b/Documentation/networking/devlink/devlink-resource.rst
>index 3d5ae51e65a2..4cdfc1dce180 100644
>--- a/Documentation/networking/devlink/devlink-resource.rst
>+++ b/Documentation/networking/devlink/devlink-resource.rst
>@@ -74,3 +74,39 @@ attribute, which represents the pending change in size. For example:
> 
> Note that changes in resource size may require a device reload to properly
> take effect.
>+
>+Port-level Resources
>+====================
>+
>+In addition to device-level resources, ``devlink`` also supports port-level
>+resources. These resources are associated with a specific devlink port rather
>+than the device as a whole.
>+
>+Currently, port-level resources only support the ``show`` command for viewing
>+resource information.
>+
>+Port-level resources can be viewed for a specific port:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show pci/0000:03:00.0/196608
>+      pci/0000:03:00.0/196608:
>+        name max_sfs size 20 unit entry
>+
>+Or for ports of a specific device:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show pci/0000:03:00.0
>+      pci/0000:03:00.0/196608:
>+        name max_sfs size 20 unit entry
>+
>+Or for all ports across all devices:
>+
>+.. code:: shell
>+
>+    $ devlink port resource show
>+      pci/0000:03:00.0/196608:
>+        name max_sfs size 20 unit entry
>+      pci/0000:03:00.1/262144:
>+        name max_SFs size 20 unit entry

"max_SFs" vs "max_sfs", be consistent. Better to copy-paste actual
command output :)



>-- 
>2.40.1
>

