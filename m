Return-Path: <netdev+bounces-271038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLaUCVSJwmkLewQAu9opvQ
	(envelope-from <netdev+bounces-271038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:53:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C1308B73
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C09331A7B67
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE633FBED0;
	Tue, 24 Mar 2026 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wGvFuPpF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A593FBEC7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355449; cv=none; b=cMmX2J7b6Lb4AnG05bNCPUL+KT9nGVxuRx1GiBoOYA6p2EUCEjPR7PUwEwk5GRvw3rrOWQ3joIX2rNgRQZwfh8YprzSRSqDvUZs9qfiJeefI7XE0Aw4CqjyGut/7YPVX76PIRm4+qw2/m2UplsUdDC2nu2d0uCpqGBsjhmi1SKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355449; c=relaxed/simple;
	bh=kPbtBPPqa6qiIBKdA2aE5ynH8ryoYXd5xSPnEa57yjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoVXR5uqHmJtdUbYW53+ItHq5iB1NBjjzgYV/hBGeFXV/SQQpTMGtsaU0DrSXwbqUEyLLoqPnf9y3NxHltgnYklaOO6tDEv8mQZiCA+3XShJ7ZnIrW2hddxlF/eajKhDNvTaWQvLq5aXvjbpkYrxtNtzdYEYY6aZgXk1QgTNV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wGvFuPpF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so36561325e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774355441; x=1774960241; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=650cxGRTwGdCgB7/1Uuk1bSKY+xLpPUDI9BTHKCNycA=;
        b=wGvFuPpFruTdERbK42drlw4gZwix1mh5LWkYB1iw9sqOFlkiFbMAl3MdYysYrPCWw1
         EeF28u2K9iLbS5a54quGbUjDciE69MVABAu/Ql5ksQQJatNM6ZV+4YT5idLNIVWjuEb3
         ++sg3XItWcb0VDwiOXAkScAzkV7QDEoYjeccZ9sIg7/uuJbPdv5gD3JuUezDuJTrH2Yf
         mTvRQWQn/yYyAbhHzILGnc+j2cJHiuwwE+s6cV2KdeJrgvFHWTD/+6UpKyThH4ezDvQK
         vpv18lt28/2Q12BCH+i8+PqyHd7A2jsfxA6rVo5bVfsf+xNFfN5kkMlM5YEjbHnE/06Q
         uuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355441; x=1774960241;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=650cxGRTwGdCgB7/1Uuk1bSKY+xLpPUDI9BTHKCNycA=;
        b=dvRD/aQe/Bnl88jj2RMYuIDcMXako3HggssoaGOCWyvSUX5fFkAElG8iH4o/PzYwNe
         oXmnAlcqca9LACvshnU3AtiS4ABorHNt5+039GEMYBSxecbX1RNwh6fAW8euDJCnotxH
         9DncZ7509JrHLJESd0VuYMdFChEoGU1Zg4mG/W1J2nfES9GM7YNmykmwAoiqv81W0bn5
         KaaEP0ixSPB7njVEanFvMO6SMguHuv1aOjaZHb2pKelWZJpbszScb9aETNiZ7lAqgqi+
         A0ow3qgVL/heY+zN7A1rSJBHN3z330yrg39dj12JYGrjHivygre1OG6+qi7KK5bwO6/7
         JMug==
X-Gm-Message-State: AOJu0YwMWMWb4DF4uABZcAs0s7/aIvOD/A1mi4YfGjXJMYuIgb6EbIAs
	jZDXGnJHSv1XnNaxqckrY7X+GiwqyV+Ie4A+x/hKuEIVk2xAzm9BHFHoK2Tus/W1Pbk=
X-Gm-Gg: ATEYQzyqYGXOg/EnZTyUBz7zINxCW2tIfe/CqyYkRBrksneHQX1ow9WKYVfOW0N6pQH
	PJpOFyjURJC/zZ18C5KtaUnnomxjWcOSpr8k/3rCNGv5OxbWzSYz01q8IBfCSKjIOqjwVdigUhJ
	WL1ZZIK53fFWs2t0+62RgiFqY6Dw6vv1t9y1jQ7rQezhi6zQPNEi+ydJ4mw6sL4/OoJq8Tm+toE
	gYkCP0s+R2kyb0/UhqtF14d5l76TQV2R2fvBfr636/Zm/2C4Ui8efbnt+QXjjA3EDP5f5CiHbg4
	OmUYS+/GaIPR3GOIZUm5Wu5Q8sd0J4NVt/j9T1cYyWKqtjalpR1CKbfHZUgcLs9qCnhiaamIowI
	50eyhX+pVop8Y/NmjaWV/1U36i5iKhY/wo7iKF4JLc8vgMZ8Zm7wd+fJuQCsbjAoBSNbzNMqj4r
	T4+My+n9OSrWySKrdvYti8zus4Es+Kervvug==
X-Received: by 2002:a05:600c:524e:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-486ff01efd8mr208630005e9.30.1774355440868;
        Tue, 24 Mar 2026 05:30:40 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487117077cbsm45683595e9.6.2026.03.24.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:30:40 -0700 (PDT)
Date: Tue, 24 Mar 2026 13:30:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, poros@redhat.com, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com, 
	Prathosh.Satish@microchip.com, ivecera@redhat.com, arkadiusz.kubalewski@intel.com, 
	vadim.fedorenko@linux.dev, donald.hunter@gmail.com, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 net-next 3/8] dpll: extend pin notifier and netlink
 events with notification source ID
Message-ID: <ose4zofbqvlzfhdina5nlolbj64inrhkr3nqok3dkheav2s6px@warnjuzviid5>
References: <20260321222627.1193603-1-grzegorz.nitka@intel.com>
 <20260321222627.1193603-4-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321222627.1193603-4-grzegorz.nitka@intel.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271038-lists,netdev=lfdr.de];
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
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 640C1308B73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sat, Mar 21, 2026 at 11:26:22PM +0100, grzegorz.nitka@intel.com wrote:
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
>  - pin registration/unregistration use the DPLL's clock_id,
>  - pin-on-pin operations use the parent pin's clock_id,
>  - pin changes use the pin's own clock_id.
>
>This enables richer event routing and more accurate state handling in
>user space and in-kernel consumers.
>
>The current DPLL pin notification infrastructure does not provide any
>way to identify where a pin-related notification originates. Both the
>in-kernel notifier chain and the netlink notification path only carry
>information about the pin itself, not about the component that triggered
>the event.
>
>This becomes problematic on platforms where multiple DPLL devices or
>drivers share the same physical pin via firmware description (fwnode).
>In such setups pin creation, deletion, or state changes can be triggered
>from several independent contexts:
>
>  - from the DPLL device that owns the pin,
>  - from another DPLL device that re-registers or rebinds the same
>    fwnode-described pin,
>  - or from a pin-on-pin relationship (parent pin registering child
>    pins).
>
>Without a source identifier all these notifications look identical to
>listeners. Drivers cannot reliably determine whether a received event
>is a result of their own registration/unregistration actions or
>originated from a different DPLL instance. This leads to several types
>of problems:
>
>  * risk of duplicate pin registration when a driver reacts to its own
>    event,
>  * difficulty suppressing notifications that are merely internal
>    bookkeeping side effects,
>  * inability to implement correct pin‑multiplexing or cross‑device
>    synchronization logic when pins are shared across fwnode domains.
>
>To address this, extend `struct dpll_pin_notifier_info` with a new
>`src_id` field that identifies the originator of the event. The DPLL
>core sets this field for all pin notifications:
>
>  - pin registration/unregistration: the source is the clock_id of the
>    DPLL initiating the operation,
>  - pin-on-pin relationships: the source is the parent pin's clock_id,
>  - pin property/state updates: the source is the pin's own clock_id.
>
>Netlink notifications now also carry this additional field.
>
>With this information notifier consumers can differentiate true external
>events from internal ones and ignore the latter when appropriate.
>As shown later in this series, ICE/E825 devices rely on this to avoid
>reacting to the events that their own registration logic triggers
>when a shared-fwnode pin appears.
>
>This change only extends the notification metadata and does not alter
>existing semantics for drivers that do not use the new field.
>

This lenghty and verbose AI-generated patch description are so annoying.
Care to cut it down to something like 1/8 without unnecessary things?




