Return-Path: <netdev+bounces-263232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J02A3Xwpmk/agAAu9opvQ
	(envelope-from <netdev+bounces-263232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 766FC1F17B9
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB8C031163DC
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FF642EEB0;
	Tue,  3 Mar 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WGCDdDEA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164F42DFF6
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547655; cv=none; b=LaHDrTiz2xCfYqeEUxtY1SgM4CO5wHvmHUcDLSYAvQ99Z6Q0e2clacih43eRB92U1MwUR4/N3MfEwsb1wqdyf/6aMT6DKtF+m43gYqosoEyBrrT6ZwJSuCWKcAcGSBDGEC/iNSLiKRF2Zq2+pl4jeaT1l2okZ/2oVkQXIk5c8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547655; c=relaxed/simple;
	bh=z6a6uRQ8wtShsN3E7YVwR9uwCYt6TJ30iqg9Sv2IcDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCukHnRybe2MZEFyNxKWBj3mjZClNIJAMlkJyKtx/1kbMoxyycIQL2A7IbWUzgusQn4YE59j/dfK/yq9bL+A0gL4QY3BnCa5iPQB297dmg+lJrq+Nm51C8p4u4YWlxGX8PdshLV7x7sI+rOtI5rjvkLfy3YOzgWrIRR/zjWQdc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WGCDdDEA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4832c8f9d87so6150645e9.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 06:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772547652; x=1773152452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z6a6uRQ8wtShsN3E7YVwR9uwCYt6TJ30iqg9Sv2IcDU=;
        b=WGCDdDEAGwYS2PoVGAr+yonc2ISJE9/Zucm7/Sh9cbQ80Vx+VX2cTAyJqKnSsUvAiS
         +rUcJKThJBR6ij8cJH+9zE84OYd6JRVDIUdJhgFAoqKtqMhNOoddb13wHnjpp3wqqWcw
         kdU0nCPI4jHm26yqBU17U0Vdokfmm5edINR9wrNwoenHTchAzoJISDnA2Fqdh22+T76S
         tCYwPS0llvMsfQUI6SlxrWdiKnFFD2n1YOzRdNRfC7UxZafqUFS7g+cwDZS+Xeh8DBwj
         IXaUyqIQv43hhxDRHJU6aJfIUZ9Whinv5ISqKYlfTjyaCzOG5y7uWxIo278u2FGRPUYf
         c6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772547652; x=1773152452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6a6uRQ8wtShsN3E7YVwR9uwCYt6TJ30iqg9Sv2IcDU=;
        b=L8xp/wbxhUYw36Xqj/D9fYFcCj4Ho6e5keuZyd8fH728ZjlcCAzpxfbq0+qoonFhrW
         dH0ZOMzuRevH6sROEAeIc9jMTwSUyhd4EOpXCxf5ToXxjeuZploRKlfuFLTYClKeaDm5
         EQohU3DYXxM0eBkFfOeCQ4XCWd36ZYGcGItITVU/pFqmrPmnfroSeeKf3pilLwQb8hlh
         Xof3lOVIQnOncQGlHg2EJEQ8CIK9p6vs3/trJ+kIe5yp4AhfeA2FkGwv5003sU5Di7gk
         i+otdd55Cqa6et/tveVUaNU7bgPa2GiPIttXTxUTPIyovlND/qMx4/vHpcN6RHwaiXW1
         CtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqcj/wlSZhxh9GmZwEdY3hjkd4nS6z3dMt+GBWjCzhU7VCTEac/Q+QpvOIjweC8yYkzE2mqM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9D+obSxqzH6IoRJaQYxb8OlizptGwBZo6ubs5JuFkKjoA9mW
	Y1O1/nPe5pCCZFdrQadUIOY78Zrr6P7w18r/TCcbWWV3YRUYjMOrHUCs
X-Gm-Gg: ATEYQzwCk36HU+iSxKkmHWElnwxFh8/A5PJeCsDh9xfa/qY9oMW5rfSxfeLZuUP3RKA
	TPjQVVqnhVEfQS/lNcgie4hLIGfhAmB4W9GyyEWIG7hA7/iKMLDtg92ietzmLLFGQPgbO+T5GWv
	oSlJep2zDIoLksio9ZZWEccapJ8wq2aD9MmR2WrwzNQskWe8Jv80OMXGDm79RuAeM7GqEWXINwa
	QlxTvQ1GB3KS8CtGKipTyNhGRIwY2NMO8LggBOo42aRnh76YZ/GzaxDLQx5mFY595lmyYEkj3Ky
	1lyawlziol+x1DJcMLOSoQRutEmozXRZwOE9iGmDHiuI9x1A29QabhuL/YiOTFLdjA2sZvvDqWx
	3/0MWO1fZGXFjV13VfIHfXmSyQJn3pzxoMOk04dVvx0mQ3w8xStMuFSBPPZwaVdscscuFmVZm4c
	XA71cT+SLWSzAs9j0=
X-Received: by 2002:a05:600c:6388:b0:477:aed0:f402 with SMTP id 5b1f17b1804b1-483c9c0b02cmr152245625e9.8.1772547652221;
        Tue, 03 Mar 2026 06:20:52 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:2472:8e4a:cf12:bb30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm19496735f8f.39.2026.03.03.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:20:51 -0800 (PST)
Date: Tue, 3 Mar 2026 16:20:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jens Emil Schulz =?utf-8?Q?=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 5/8] net: dsa: lan9645x: add bridge support
Message-ID: <20260303142048.y4vu5i57daeuezxm@skbuf>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-5-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 766FC1F17B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263232-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 01:22:31PM +0100, Jens Emil Schulz Østergaard wrote:
> We support a single bridge device.

Why? I keep seeing this from Microchip engineers. Having two
VLAN-unaware bridges on different sets of ports is a perfectly valid use
case. On Ocelot I took the driver from a state where it had an identical
implementation to yours and I made it handle multiple bridges. I don't
see where's the problem.

