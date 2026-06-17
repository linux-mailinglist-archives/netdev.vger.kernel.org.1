Return-Path: <netdev+bounces-300175-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xSEOLS2bMmoB2wUAu9opvQ
	(envelope-from <netdev+bounces-300175-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:03:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F6F699F15
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 15:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ll0a3Z3U;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300175-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300175-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93A9D302AD00
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 13:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2907E406837;
	Wed, 17 Jun 2026 13:03:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928D5405C30
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 13:03:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781701392; cv=none; b=GSi90/M9i+ESaf4yXCxtB84kavTMyHApBqlqZQGDK1wl3KCOHNpyj4VjIhiC77omFMRMTko0mthX6fyutux0Ft5aTk16wX6vOw/ytOes/wFaKvdl6GMR0fwQURkwhg7OKvujyQzTWzTR/K80VFtCYB7PbixZNOeoFuUhC6EcsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781701392; c=relaxed/simple;
	bh=nBHc+nAaXbqkCN1Auq+xeGIYuNQc+PDFyURhkEUdQ0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTjfsp5CxuXM7GImxAEb2IPf0wxoMrEWy8ggepG/T3rEgEc5SfSLy7OtNQ+fBt0Ar+chCw3RMgMzQEXJ7b6t81oFwbRxMA8K2ZUGO9iNobRRdC9130bpJNMGSbKWfC4iTy3q9KJkslBp4f/zLNLEcKo29Y0KTsmPauWgH5FoAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ll0a3Z3U; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490c737bcafso4922455e9.3
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 06:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781701389; x=1782306189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3q9IDPhvD5G/4RLuLiDtZ9v/ljk662bU9xIY2V8ANzI=;
        b=Ll0a3Z3UXq2h1fyYJxHwtDWI3cJqAKF7rqV5Kx2jRXxFEIJMiK3iAWJwQK65WWHSIN
         E7o9RhUZf7NfH5FteABtogLsez8hQLdE0qS0omo1b8dE3RAiovI8lg2bAk1zMwe7UFLB
         E/0y22grRqv0qtPIo6z4B+2zs5Ixooles7BXbskiteZNIr5I4t5bJC9wZFujzGOrgxwG
         L3CV6ys6ptnvwwtvBA3j+xA0pY2jHZ2/AeLRlMXlPEFLPS549Sn7f2vAhtvIeyHY8HV/
         jeDgI05JJwnr1xTMa0u2k+d1GKsstdJJq0WIo/DHNSfqNsUIByFo2dUl+flDJs8xNWp8
         ha2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781701389; x=1782306189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q9IDPhvD5G/4RLuLiDtZ9v/ljk662bU9xIY2V8ANzI=;
        b=V/3wp2ahbeHjA93UpRuFIzKYY3r9Gc0ZsIuhI58NY1t3kO5KthrffBPJ5qI/NIoON4
         4EueWDmhJ4Dp5HTyO4AM6zwDVaEjWIJJCJ/m39GgCUXkBMrMlZByJBQy6OMHw9yTY721
         kIGgqA1/hqOLjR7tbj5wBQ5RnIxNgFrhszlsJspdjoYJJoTphUJVuzekPN7ehVmdKfl8
         JAnnXCjNnvN35ETDNQg8XATCc5JnyFJyckC7hwrLfru+lBM2rAyzCTxzIADrE7/upy1i
         OUAUE41Pj3KIK4d/LypiLypXK8M2fFZVOWZYp2pYmfAbx2CjbEUO9BuTZrajHaXi8Bdu
         nu2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+QSkVoWSPIRHRn9ZQFUmje71WKgmXa+TQExGeXWr9JRkpqcYVxOXGWGFUNnxrcjLPnFeuv/Pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1uCVqHyTQJqM9623cU/JhHWWnXRFCWIkhnlEfjduap+Ln/Enl
	q/QFL6Qhh12Kf+XxYSwo2JsB9Ipa7eZHl4gyQyBOjXyb+na9GzU0hShU
X-Gm-Gg: Acq92OHkqgZDBMv2LGAdhVE0MiBDfU7oh3fhlNfatzNhsRsAc6rJHI5pTy0rfW/nyJG
	WDe8ljGifExbEgNN5hnyWJ5N9m/vqTelsdqv4UHoK5JuPMX+W0YqA8PlmWKMK3AXYyAsZ+x7XWG
	xNZ+utIpHbyvq4JVnWLlKSyZPfyiW9Xrqfm7l5Me+lj3PoTLqlGYWTSlLljFMsSbsQfisb0VPa2
	Ve26Gh3ShsunLhbc9Wti3rGFwsGOIN+36Nkx9JG4R1fNcsqWg64vedlT9zC3+nrB8sEGYyxZH/4
	uZ1guq5HcSlS28RGk8Gv8unbqk1ytjPWZU19uZ/+d2TEQSz0LZ3LurycKRu11lXRWHvqb/LHtx4
	OPMQnVuS3HONNTMun5KfG87zH6LONhyrHu2VdcOZ89HzyxNws2T/UPrvGlXmxrfUp2nOGbemXQG
	GlpC9w
X-Received: by 2002:a05:600c:4e8e:b0:492:3555:b9a with SMTP id 5b1f17b1804b1-49235550ba9mr13236805e9.8.1781701388462;
        Wed, 17 Jun 2026 06:03:08 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d40e:d500:b560:2eb9:3ced:38e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f264333sm55914459f8f.4.2026.06.17.06.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:03:07 -0700 (PDT)
Date: Wed, 17 Jun 2026 16:03:04 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	George McCollister <george.mccollister@gmail.com>,
	David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2] net: dsa: Fix skb ownership in taggers
Message-ID: <20260617130304.w6pwxlrptnn4dflz@skbuf>
References: <20260616-dsa-fix-free-skb-v2-1-9dbda6a19e97@kernel.org>
 <20260616213728.xhja2net2vbjmgzb@skbuf>
 <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD++jLm7tvbB2RBV5FEo=mAkPpmUJEMemXV0+mhTvZ0oX8O=+Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300175-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:mmyangfl@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RSPAMD_URIBL_FAIL(0.00)[skbuf:query timed out];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,gmail.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91F6F699F15

On Wed, Jun 17, 2026 at 02:23:40PM +0200, Linus Walleij wrote:
> > - Has anyone proven that a real problem exists? Because dsa_user_xmit()
> >   -> skb_ensure_writable_head_tail() has run successfully at this stage,
> >   so we know that dev->needed_headroom bytes are available for writing.
> >   Because DSA uses VLAN as a tag, dsa_user_setup_tagger() will increase
> >   dev->needed_headroom by VLAN_HLEN for the tag_8021q protocols, so
> >   vlan_insert_tag() should not fail. I've looked at this function at it
> >   seems not to be coded up to fail for any other reason.
> 
> I guess what you're saying is that vlan_insert_tag() will never fail in
> ->xmit()?

Yes, I may be wrong, but this is what I think. The central idea of the
generic TX reallocation series
(https://lore.kernel.org/netdev/20201030014910.2738809-1-vladimir.oltean@nxp.com/)
was to simplify taggers by moving the failure point in case of
reallocation somewhere else. I'm just saying I don't see a strong reason
to complicate the tagger responsibility again.

