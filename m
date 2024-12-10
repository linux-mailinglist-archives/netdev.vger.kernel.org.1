Return-Path: <netdev+bounces-150821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B230D9EBABC
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2F21888187
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C1821423C;
	Tue, 10 Dec 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3F/WwR9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359523ED5E;
	Tue, 10 Dec 2024 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733862064; cv=none; b=vDvj94zw+NusH5HUuDBDKqf8z7EeFNtJMQfJDf4AAxHaXGA9JDHsrObIGqPhLKGbLmPAGi0Gg2kYJ+og8U0EPp9axR3GrcDcw3+1HGjsHxXwNjoRKqrqefXl4YiGN5NURQ6vv6lgOiXT4EIblSTKna+/2BURPttRWEfTiysH6bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733862064; c=relaxed/simple;
	bh=lkz0uC/DOtwC1sGq2Mz4VnOrbm4a84YkgoZEiPPEj7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOwZoWAYLPJGtU1VvnvmJP8vpU/V6eIFpQ+SIg5lxR+meN1y9Avwr+FS2bn6Ak+ebF/vm3J/abOZ4lu+az7EZHQxYN+hvOtQJLtoPtzit4n+cYNOmUVusGhhZSlS7vsW4yGfFpVmL1tVIc6Oox3oCUGjpXpfmldD1Tgg8ZtWpqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3F/WwR9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa65f707419so67944366b.2;
        Tue, 10 Dec 2024 12:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733862061; x=1734466861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WudyUJe63c8JFxkj8fmVFDLqePx04Jr1Dyl2u8hD8a0=;
        b=k3F/WwR9Qa9exkXlJomhVL6TEXPYXYsdbbfwGcRTR/XPkVEAvjpalc1emmjQBa4d/Q
         S4xKsBlIkdiKhLxZWjsOE0qcMV6TqtfLabq8aQtaCkssBy7dy49MDehIspd4hXb0BhXA
         McG5FezSjkAy0xHRACKE7+Sft6tsj1+QYmPgOJjhCk373x2zuUre8437G5i0ZQO9m68P
         y23WHqNJk7o4PYIhTyyVXGWT8ltMpsw4rPaEr0c+MBpZGVFsd5dSkvkchBXFfK/fN1wq
         vypee9QFN7gOSDP2YEki0j6+d6wCKQ1pV3VjbQ8Jq+ztz182pLo4U95CeQ6gycyCHmOY
         jhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733862061; x=1734466861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WudyUJe63c8JFxkj8fmVFDLqePx04Jr1Dyl2u8hD8a0=;
        b=YsuV3mGnE5wVfGizdW79bjM7+ZbLJCTIg2OFdupBzQnUJRfDgMenrIh8vNtw6zBhDI
         5pRiiV4f/uLdr2iaQR2G4lvnA+pfYBW5omUZDzskdcM8tupbxwtXPsmmmHS3MGojAKUS
         XiF1dDBK/6/O9PKMrndRLl4bwq+Lpagh4MSPXPSGoV/gEzu7wkIzjKgYFrT6YZQB5sH0
         SK6KQ7Dv6apeGszz4JpO49XFo5ukLDBVjALL3viHg0UFjhSKSpIQ0RbolW1PW4k/P4A5
         wizl+J2EkxwzjSWqfPGSO1nvG2UCBqggOSe7xohHRrYLOgmybru/CWT0+QD7N/8Rl1aO
         cnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5v9ICoRgxqrIJtATFbWS6417uwQjINa9j3j7jHr0/33keniiOTKAjq1/oWp9K1LQ0hyOoOGae@vger.kernel.org, AJvYcCWHGtiYk/cXce8k1X3rGHz/qtMv8KCCN5jECh0lVDEB1SpCfTeRBzefrKhz+h5gp/Txv07eZR+1XVgEmAZ0@vger.kernel.org, AJvYcCWmP1qTXCEv6LvntlsHS58dGMAJPKVfpz5dHgfuRM4h7YKu9p8Pmc2ZUEMpTDNWSxWs31+EO4tWq5JU@vger.kernel.org
X-Gm-Message-State: AOJu0YzihFEJMepEFVCgTKWXHIrAIeZOqIXwS+aYIs7/kU6xWYstWrgb
	DyNy3iQ7BSoscIk4ItiLb8hpDq4fAEgq73uLtGj4qnsU7I9YXwTY
X-Gm-Gg: ASbGnctMC1YIAdCfIN28/BJJplSqUpD8h64R51KY7/UEFwCANuClGp6LP6jUwnqTYjO
	3jQQ0raqZBIonGYPAjQ85ECzVgBjKzqFP1C/rnHxXGGYY9ukquSq+8I2gvE0qDCd/BjLR5HrRqA
	i6/RSRE+Q0QFipO/uX2YIyNwJYD1Fk37KBT3sDPFTbnWrnK6a8cXozWasH+SJyFwsr00ohz+pTz
	BR/cvXD+YUSmm4xrNEmWufXVgBIqmzVtWP73U9eUQ==
X-Google-Smtp-Source: AGHT+IGjcxHC/a2dd358/yErtbhd4ej5DXUjk12poPR/JpWsRTPDUnrfaJH4uV6DTzTNXMcURT/RxA==
X-Received: by 2002:a17:907:1ca7:b0:aa6:9407:34d3 with SMTP id a640c23a62f3a-aa6b133c966mr3485266b.9.1733862061023;
        Tue, 10 Dec 2024 12:21:01 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6696acc74sm540561666b.134.2024.12.10.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:21:00 -0800 (PST)
Date: Tue, 10 Dec 2024 22:20:57 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 0/9] net: dsa: Add Airoha AN8855 support
Message-ID: <20241210202057.x2tds77popzdcak6@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>

On Mon, Dec 09, 2024 at 02:44:17PM +0100, Christian Marangi wrote:
> TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
>         reception failed
> TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
>         reception failed
> ;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
>         reception failed
> TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
>         reception failed
> TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
>         reception failed

Why do these fail? They are dropped on transmit? Could you see with
ethtool -S where they are dropped? (DSA conduit, CPU port or user port)

> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
>         reception succeeded, but should have failed

It is unexpected that these fail. The vlan_over_bridged_port() selftest
sets has_unicast_flt to true or false, depending on whether the driver
declares IFF_UNICAST_FLT, and depending on that, sets the expectation on
whether unknown packets should be received.

There may be a bug in the selftest, but I doubt it.

I haven't looked at the patches yet, but from this behavior, it looks
like you mechanically satisfied the requirements of dsa_switch_supports_uc_filtering()
such that DSA will set IFF_UNICAST_FLT, but host addresses aren't
actually correctly handled, or CPU flooding isn't turned off when it
should (ds->ops->port_set_host_flood?).

> TEST: FDB entry in PVID for VLAN-tagged with other TPID             [FAIL]
>         FDB entry was not learned when it should
> TEST: Reception of VLAN with other TPID as untagged                 [FAIL]
>         Packet was not forwarded when it should
> TEST: Reception of VLAN with other TPID as untagged (no PVID)       [FAIL]
>         Packet was forwarded when should not

We discussed off-list about this, a special configuration needs to exist
to consider as VLAN-tagged only those packets with TPID == bridge vlan_protocol
(i.e. 802.1Q).

