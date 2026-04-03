Return-Path: <netdev+bounces-275005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB6FBGeqz2kPzAYAu9opvQ
	(envelope-from <netdev+bounces-275005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:54:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8C8393D31
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 13:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFB52300B77D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 11:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893CA3BC69C;
	Fri,  3 Apr 2026 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="wsYXyIz4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8272537F8DB
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775217243; cv=none; b=lFwcZlcVBxX7zz9sC0twT5F3zHJQ1tVFibjHj7SiJ97dotLQRMgYeHcXX4no8l84x61cmpr0GvS83heepoQ70un8KOhE+5nDULrQHPxTkYQzUGJDmLjhPadWlDXTSLZQ7wNcOFZ9w+rC2ayS7+8ZsTDbwQQcTy7HuzbG1f0OGiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775217243; c=relaxed/simple;
	bh=Ml/48AoKVgk/lM2IqSkjZTFMh/QvR8o9ecnoDoyG1pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYAa0Jb99W3kgFXiRrd8yDeBjj6oH9HXAynNskovW/0EDzKYCZwqV8FZiybaqZ0Uz5U0j0eOu1r5Hwc8f9lqspzjWHYbkFnTK0GmTxoiSrYicBjcRnnsYMNzn/MTEg7oiLuh/a2xSijWSWMuaPYjtLXvKMXzXADi9RcTVJifyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=wsYXyIz4; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b8e8e7432so1525464f8f.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 04:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775217238; x=1775822038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/P3PGVnIBtbptqa66WcAt07NfhQIaerWQ7Q/aTRRjCU=;
        b=wsYXyIz4HZQPcUq/lsywkFbTCHM5Rn6wJ1anlgGRLhgN9RsvmzKduJ5Ab1JqGL4dz/
         fJc8T/e2L/1Y6CiozpQ9z2zBuHys10/JsgEnO7Alew9PJF4wjxqsNjt610OWv+y6bH6F
         TIrvJTDu+e3LonyPjkM5NHXUgZWauhldrrd8wDhxCo+ns2GnkZGw3Jee805Z1NCNNkwi
         PGTYUN4L59wmp7/7WxzlBx5z7RL2lrrpG+DVNHcSM2sYTystyoCoQJ2y66BVDtAiXO8i
         McqsFu5TZE9Xmy+zKo80WtpQitn4OEo4Ky9PRn9e3qx8wCXosBhyDCth/l7DFDyx+cNw
         7Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775217238; x=1775822038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/P3PGVnIBtbptqa66WcAt07NfhQIaerWQ7Q/aTRRjCU=;
        b=gpjuc/AVcSGisIeixpgcL0bskhgQ/rFeQzbyLub8jKDZfCfzh6mestkQ1zYZMtRE86
         7hh1jb/ndlHDzazsqdPk+TIGS4MDGmM+TZK5BdjrLJ/xKR/4O9NhgyP/4nBmRhQSUGoq
         gDLll0jEBpz6xdeLcoCTMTvSOnleZ8nmCncTweuz2ZKO8JZqTNaakszEpqKPDCl8Hk0D
         o/ZYM3EBMlWt5dH7PPJIoGo/xvlKdTuQ/LVUC/pRHLWeSfF8/u+IzVsYx3AcutpppGcE
         UCtaZXqNV6DJz2/ps8Rt3LJQplzB4QNB6lQC8U80K7fcn3SrY38mFTRLfb9hQaCqpEbz
         ZgUQ==
X-Gm-Message-State: AOJu0YzpI9LbkW78ZLH707U0VRWKoj4CEaQ9IDZ6g2sLJyBoQgH7msSo
	5QymJJ7YeMN9isWccZf3CZHNY6SdzCrjgf1PZRT7G1tzkPd7Xtprf/3aXDH1I+0BlEg=
X-Gm-Gg: AeBDieuT/q/oyLtboOE7lUGT1cztDbkrVJnQTUye2iXduuNQM9qAJNE73kBVdKAkHOz
	3oN1wLvAIxJP1eDq+ZjnunHqv7Vl7PvfaEtZKQ59n2hLD7y2EVTzhYYDJQq8Ibg5OhN7nDq7Vgo
	3PbClU+9bocepu92AiYdOG722xasDZBleenuB/9rPXnRZviOGdx7L/O/x7ChNZGQrTzN9iksTj1
	w9Kore3uD/mt8cFFRnwloc5QjKDYItRqh5h5m5pNQ26dHeTR+TZfbytn1mMrTlE/YcPO5i2m/9a
	4I1Ne5UKuYDGiGCBpP2pmmCxBnJIR5ti5vKMqs6yxXbJLyJRs2T3udto5PpCcKAmo0HEEmwfdst
	IEb1H+tMg3CMlYndIuJ4undneY10SgDz7FjgZ9UyEGvQMnbAu/CZq+0JJSDieYshP3H8G/SFYmy
	89HigT/d1zBpmDqANYTjhPUC7ysM0oD6kLdb/+9KD9YQ==
X-Received: by 2002:a05:6000:2586:b0:43b:8f04:2ee1 with SMTP id ffacd0b85a97d-43d292daa45mr4482680f8f.27.1775217237109;
        Fri, 03 Apr 2026 04:53:57 -0700 (PDT)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:dc3:ce9a:4aaa:6bb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f843dsm14846357f8f.37.2026.04.03.04.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 04:53:56 -0700 (PDT)
Date: Fri, 3 Apr 2026 13:53:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v5 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <5wacj2o5m7knwtc7vxws4xct4ogpitrwnmrtvtsdn73blddsql@natpxrbsaske>
References: <20260402230626.3826719-1-grzegorz.nitka@intel.com>
 <20260402230626.3826719-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402230626.3826719-4-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275005-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,linux.dev,kernel.org,davemloft.net,google.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 6D8C8393D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fri, Apr 03, 2026 at 01:06:21AM +0200, grzegorz.nitka@intel.com wrote:
>Extend the DPLL pin notification API to include a source identifier
>indicating where the notification originates. This allows notifier
>consumers and netlink listeners to distinguish between notifications
>coming from an associated DPLL instance, a parent pin, or the pin
>itself.
>
>A new field, src_id, is added to struct dpll_pin_notifier_info and is
>passed through all pin-related notification paths. Callers of
>dpll_pin_notify() are updated to provide a meaningful source identifier
>based on their context:
>  - pin registration/unregistration uses the DPLL's clock_id,
>  - pin-on-pin operations use the parent pin's clock_id,
>  - pin changes use the pin's own clock_id.
>
>As introduced in the commit ("dpll: allow registering FW-identified pin
>with a different DPLL"), it is possible to share the same physical pin
>via firmware description (fwnode) with DPLL objects from different
>kernel modules. This means that a given pin can be registered multiple
>times.
>
>Driver such as ICE (E825 devices) rely on this mechanism when listening
>for the event where a shared-fwnode pin appears, while avoiding reacting
>to events triggered by their own registration logic.
>
>This change only extends the notification metadata and does not alter
>existing semantics for drivers that do not use the new field.
>
>Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

