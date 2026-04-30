Return-Path: <netdev+bounces-282888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCk3F1Fq82k72gEAu9opvQ
	(envelope-from <netdev+bounces-282888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:42:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B5B4A42DA
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C7243029AD5
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 14:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D1E42E017;
	Thu, 30 Apr 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puehe+7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38BA42E011
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560071; cv=none; b=uGLqsRO2mK7s7Bl0fvN3pWLgjSg7i56AeoFDi/4SH8/cxeT+EP32Dz9QRAvyjBrcdwSiwds7Cq4wJcTgBHh0dfW9bzlS7i+n+0O7rMUttO5PiuwNWXxy0158eJQ7w+bcz5VEwKA2dp8onaL+xa5lwtvtOnUFYgUvqZsGeM139yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560071; c=relaxed/simple;
	bh=sGdiOAdCa6a5j88iplXyfkWS9OH8VNTs7Cr5n3oEEkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzwmPZe4l7I8i7x29mvvQ3PqcrD54ku1YDyNNarUQKjO93Bj0YGM/BVITpru6rB3MjvQC5DvV76u4JCj2OwH9O/DRpLhbgUCKaKbxxxf7PPBBR7P6lpMz7L5uxr+cwPZV7F8LJcOYDN85Xe24aH5udrScVJRDOjhZxfvTvtekco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=puehe+7o; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso5993905e9.3
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 07:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777560068; x=1778164868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWwCZMRNrBohx6wiH/R/ajuzPFQYuehky0ir6Vh4LgE=;
        b=puehe+7omONo9JwVC896i2YriVJOPQp+3yVwce9qs4BdgRlC5hS7ygKqp/baTjgpa0
         YxOsehw4JfYNk4Unh12fcuxTmnQvOWQfOtv56iSMyR0mrSrrDv75esu670r+csorAiSB
         2c9tvgWiDWcaD0V0toz+2jybwN3VIDJ8uEuwde4RIaVOszUUX9SVJiQj/0D/FphHXjMI
         49cHbCliCUuCn9RRoFxQdJsaLL7P1GHCs9sxMM0Uf+urX70chNXjLcluzJMz0Flp9Y1k
         sJnn7heBNbdDD3uuLq1GOYmsgo3EmKMEwlFikrKOUnzH0coAn385/jwWk3oa4IxrRT5+
         hBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777560068; x=1778164868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWwCZMRNrBohx6wiH/R/ajuzPFQYuehky0ir6Vh4LgE=;
        b=SCpUfQEoHYgCFem6Z+8t5kjngtzymzVO2ppngeM9dp2j9z83IZL7X9p+SSoMp3Yv4Y
         RVwfITv7O46kLloODXtHN6U8D8FLM5V2yNChcMnqy38Qt2WcjslDw5uCzkv2Ka4FxcrD
         cnK8PIWtTt+mg8PaCq+tMMzO7DR5ci1BJuFLxnEn8/lq7G5SrzXOWQVLAfw0L4iDgi9x
         KXVAjP1UvJcJ3cffPAYmC3oOJzkqFoRmLSOekbQ9ZcgPTceYlPVo7yie5LlB7FRvZHxR
         G3FgyUSJB20ufU9e+neIRdE6J3TRN3Gbaq8N6JcttTrW0aHIIjImgTSpz0jyC7GcTsMv
         eZ0w==
X-Forwarded-Encrypted: i=1; AFNElJ95+1Y10tPg3lY4NSmFI/SVw8UiGtxiM1ZMzHaP6DDcqVW2mjJUlGr4S/ADn1wGXzNWcWBsQBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuEMZJ2wTyy5B7hzB2urRWG3abxFgCDlByg8NJxAwXl1YTQ3Au
	qvWAPBTXoc7G5oH6QuSf/adeRm7qIWRljEe94VPWtFdgqkNxIyvy+n3e
X-Gm-Gg: AeBDieuaKOoJiZlm5CWFqNHx9sUnEigSFW5YpEKaMW6iBLBPA+QVanBhcWbZM8HoyEg
	5K6ZV0ChfmPNzch5YppPa8++zGcdsOYOlT54DW8w+Y3T7KffLfiAD8mNHeciJOb9EuXj6MCI7Ps
	LUc3DJw6dVe5ihr08Z5LuacV6xqNC8kAT5X6Or81Ekti/oRVK2Rc6UihoNrmIhwjmiCM7Dx8nPm
	ISdaWSBD9oO6oXo/bYLDm9B/eZPk05joVZoaTJ7IMzFjbFU5bBFyzcQ4dZAEdnkV0pDMZ/++MLN
	QGV2whiC31FgOSwNAG+JYo87SBSq2s6Tibjstv0t0KD477dbqAVMvWfwbubC6AbT1axGYcUKeDt
	nwqWcxtRHoDNAmpl1P/NF16uFoZrcjdmpKJruj5ZuWO2SzeZ+VHD6xMFZ3ym+LbLRZiNpeXuM1Y
	n4bjnaakEXpOSok/279wzBXYH6Gsd3qlFRWA/p7XIi8xLeGMwoqjQBI4InADYHHHhN5k0gW6ykD
	po=
X-Received: by 2002:a05:600d:1b:b0:489:1f6b:6276 with SMTP id 5b1f17b1804b1-48a8445258bmr44879875e9.15.1777560067659;
        Thu, 30 Apr 2026 07:41:07 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301adesm65720755e9.10.2026.04.30.07.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:41:07 -0700 (PDT)
Date: Thu, 30 Apr 2026 15:41:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com, Faizal Rahim
 <faizal.abdul.rahim@linux.intel.com>
Subject: Re: [PATCH iwl-next v4 0/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260430154105.505739ac@pumpkin>
In-Reply-To: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3B5B4A42DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282888-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url]

On Tue, 28 Apr 2026 14:00:06 +0800
KhaiWenTan <khai.wen.tan@linux.intel.com> wrote:

> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> This series adds support for forcing 10/100 Mb/s link speed via ethtool
> when autonegotiation is disabled on the igc driver.

I'll ask 'why' ?

In particular forcing half/full duplex has always been a very good way
of 'breaking' a network connection.

It really is much better to restrict the advertised link modes and let
the autodetect/autonegotiation logic in the phy/mac do its job.

About the only think I can think of is to force 10M HDX when connected
to a remote system that supports 10M/100M HDX.
In that case you need to send out single link test pulses, not the
burst used to identify 100M HDX, or the pattern encoded on the burst
used by autonegotiation.
But you need to got back to the mid 1990s to find such systems.
Anything that supports FDX will do autonegotiation.

	David

> 
> Changes in v4:
> - Validate that autoneg is AUTONEG_ENABLE or AUTONEG_DISABLE early
>   in igc_ethtool_set_link_ksettings() to avoid passing unexpected
>   values to igc_handle_autoneg_disabled(). (Simon Horman)
> 
> Changes in v3:
> - Modify condition from "if (duplex == DUPLEX_HALF)" to
>   "if (duplex != DUPLEX_FULL)". (Simon Horman)
> 
> Changes in v2:
> - When forcing half-duplex, set hw->fc.requested_mode = igc_fc_none,
>   since half-duplex cannot support flow control per IEEE 802.3.
>   (Simon Horman)
> - Split the original single patch into three patches for clarity:
>   patches 1 and 2 are preparatory cleanups; patch 3 carries the
>   functional change.
> 
> v3 at:
> https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260422155701.7420-1-khai.wen.tan@linux.intel.com/
> 
> v2 at:
> https://patchwork.kernel.org/project/netdevbpf/patch/20260416015520.6090-4-khai.wen.tan@linux.intel.com/
> 
> v1 at:
> https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/
> 
> Faizal Rahim (3):
>   igc: remove unused autoneg_failed field
>   igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
>   igc: add support for forcing link speed without autonegotiation
> 
>  drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
>  drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 209 +++++++++++++------
>  drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
>  drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
>  drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
>  drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
>  drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
>  8 files changed, 257 insertions(+), 90 deletions(-)
> 
> --
> 2.43.0
> 
> 


