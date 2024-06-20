Return-Path: <netdev+bounces-105329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D75791079A
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FAE1F2232D
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E71AD4B2;
	Thu, 20 Jun 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpz7G1r8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B71ACE61;
	Thu, 20 Jun 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892590; cv=none; b=ao77hIjevOcXY6/0ofgC/41zb8CGRkOHIwEJCiFO/7cVf/AHPSsqouDCxQy62AND+Qf1qb9JlWdzyBoYX/7JFZfSLmuq+wPAw2YN7U1jBJXDGa2P+HKGUC+1/pGyQGUEzuUAXw5eKVS5p4DBz7UgiwcsAo5uBGqO0XrqyZntSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892590; c=relaxed/simple;
	bh=MaL1HNismMFRj5V1xO8PvU3IeJoQu1q+GsN/P/n5/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOt70ne0eotwDysaK2RQmcQU4CM0N8741mAYSupwt80yD6TjiAt7lVSNBlU6Ffl8IgzezRDqgmrJMK6B1NJ0fsWkSzhlhMvbuiecDU+mm92/5rLlK7oMzje9Qpqmvp3nrpp+q3rFOF79cJLfy4hCeSY2xc6EnsTCXf0YPJyTZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fpz7G1r8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a62ef52e837so106137466b.3;
        Thu, 20 Jun 2024 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718892587; x=1719497387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=THuvS6W+kQpi7zU478X8LJN/+VQClEr6PfEbQXSTbZ8=;
        b=Fpz7G1r8dYrGFrpU3QuL95R7bqvCBoLns4mLOEjYFILPA8Vd8olwXvcL08ZrYiZOCP
         EuYlUXZEWAiLeiwawqcmum8gfXy9O9vY0GHxQ8UYRRXq6gDqHwR3lOCxcAvuorlHwI5p
         3ZpOmXNV0mBhNwg0NZH5GgT5EV8XQwEH8l/dDzq98b1wyBMlHqrbeyz9wvH3PwtpcEYz
         WOrFmzT8qhiSrT84/DMAKCrpwAxu6T3D4hRmAr9/q4av0qh2iK0sdKnegPXtEIrgCJMW
         XTuOUMNBp+UCgok1/SJO6oZTjTL8CHi3Nit4vCo3xTdn365tQIQ6/fWehj/7lZ4bmd7J
         243A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718892587; x=1719497387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THuvS6W+kQpi7zU478X8LJN/+VQClEr6PfEbQXSTbZ8=;
        b=HsrCNwqZXufP+CbT6IM/LGMiDoon7c+OVEeMRq0lkwL4lGrL0LsCJJqEcpWcwUYlda
         la7Pvr32iR4hAuMzswVr+yxWVW3wUtD1FYWaoOS/MD5g6kYo6ulRgjvVup64EgGVKcjO
         NzzayWMNoLIXliY3ET3WiChFItzlBrcdbCo4bEFmtiKtXhi2aotmNQG2zGpbm+X2JEld
         z+XAQIP2mloLoNHxB0Ip44wA1KkeUv7/ULjPreGVf54/lZl87UCujA+GE2RLt19ke3t/
         CQ9WSm25lq6zBU87m1culdEkmXswuE0zQ2KG5yeqtRf4rIcT6tTZs2eQgb9JxzRuYB3v
         FvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi9q9dmjawaKD8jdaGP5QhOKi6sg/EItb0tEGeShhKY+d546XMuF3mGIYw0V8YDFyNeL4JkBYwrnBp5zXahQ+tfiaeAVFqkof/oQZH
X-Gm-Message-State: AOJu0YwZO+00j5FMQHHO4ER3mIs7W6Q9ASNtDXuuvqD5fsbyuPGLYZgd
	xltFUTr2bexT62OMx1JnUUo9wjmIqa9UANlN9GqsWv9siPCIHRR/k+XAKJKc
X-Google-Smtp-Source: AGHT+IHUCBCbC9FxRDBgiAMVXFrFdhKaLLsXabPYmMKlfmKbcDURx96oeGsEzvzbpqbBGgwZTJg87Q==
X-Received: by 2002:a17:906:4412:b0:a6e:2a67:789f with SMTP id a640c23a62f3a-a6fab647f53mr331394666b.40.1718892586505;
        Thu, 20 Jun 2024 07:09:46 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db67c4sm772838866b.60.2024.06.20.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:09:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:09:43 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/12] net: dsa: vsc73xx: Implement the
 tag_8021q VLAN operations
Message-ID: <20240620140943.viiqlzgcmneyywdf@skbuf>
References: <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-1-paweldembicki@gmail.com>
 <20240619205220.965844-9-paweldembicki@gmail.com>
 <20240619205220.965844-9-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619205220.965844-9-paweldembicki@gmail.com>
 <20240619205220.965844-9-paweldembicki@gmail.com>

On Wed, Jun 19, 2024 at 10:52:14PM +0200, Pawel Dembicki wrote:
> +static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
> +				      u16 flags)
> +{
> +	bool untagged = flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = flags & BRIDGE_VLAN_INFO_PVID;
> +	struct vsc73xx_portinfo *portinfo;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool commit_to_hardware;
> +	int ret;
> +
> +	portinfo = &vsc->portinfo[port];
> +
> +	if (untagged) {
> +		portinfo->untagged_tag_8021q_configured = true;
> +		portinfo->untagged_tag_8021q = vid;
> +	}

This is something I don't really like, but I understand why you're
doing it. dsa_tag_8021q_bridge_join() first adds the bridge_vid and
only then deletes the standalone_vid. Both are egress-untagged.

The fact that you have storage in this driver for a single egress-tagged
tag_8021q VLAN makes it awkward if not impossible to track the deletion
properly from tag_8021q_vlan_del(). You just record the last added VID
in tag_8021q_vlan_add() and silently discard any previous one during the
VSC73XX_TXUPDCFG_TX_UNTAGGED_VID setting, earlier than the deletion API.

I'm wondering if this isn't actually a self-inflicted problem created by
the data structures in use. I see that when the port is in VSC73XX_VLAN_IGNORE
(which it is for tag_8021q), VSC73XX_TXUPDCFG_TX_INSERT_TAG will be
unset. So the port is egress-untagged for all VIDs, and there's little
point in tracking any one single egress untagged VID coming from
tag_8021q. No?

Wouldn't it be better, assuming that is the case, to just return an
error if this is a user port and tag_8021q is requesting a VID which
is _not_ egress-untagged? If you also respond positively to my comment
about returning early in vsc73xx_vlan_commit_untagged() without doing
anything in the tag_8021q case, then you can actually get rid of
untagged_tag_8021q_configured and untagged_tag_8021q from portinfo.

> +	if (pvid) {
> +		portinfo->pvid_tag_8021q_configured = true;
> +		portinfo->pvid_tag_8021q = vid;
> +	}
> +
> +	commit_to_hardware = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
> +	if (commit_to_hardware) {
> +		ret = vsc73xx_vlan_commit_untagged(vsc, port);
> +		if (ret)
> +			return ret;
> +
> +		ret = vsc73xx_vlan_commit_pvid(vsc, port);
> +		if (ret)
> +			return ret;

Hmm, here I notice that the vsc73xx_vlan_commit_conf() call is missing.
Am I right that if you add it here, then the entire vsc73xx_vlan_commit_*()
string of 3 calls from vsc73xx_port_enable() becomes unnecessary?

The tag_8021q VLAN add operations are initiated by you when you call
dsa_tag_8021q_register(). So you have good control over when the VLAN
configuration of the port for standalone mode is done.

> +	}
> +
> +	return vsc73xx_update_vlan_table(vsc, port, vid, true);
> +}
> +
> +static int vsc73xx_tag_8021q_vlan_del(struct dsa_switch *ds, int port, u16 vid)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +

As a matter of API compliance, I guess you could add a snippet:

	if (portinfo->pvid_tag_8021q_configured &&
	    portinfo->pvid_tag_8021q == vid) {
		portinfo->pvid_tag_8021q_configured = false;

		if (commit_to_hardware) {
			err = vsc73xx_vlan_commit_pvid(vsc, port);
			if (err)
				return err;
		}
	}

Of course, this is not to say that tag_8021q will _currently_ configure
ports for an operating mode without PVID. But it's something that the
API permits.

> +	return vsc73xx_update_vlan_table(vsc, port, vid, false);
> +}

