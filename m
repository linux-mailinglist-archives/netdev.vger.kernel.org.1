Return-Path: <netdev+bounces-236425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B11C3C145
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0426421A78
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3AE288C26;
	Thu,  6 Nov 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcltzmXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF9285072
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442866; cv=none; b=XueWlgf4mZ4xyHPgufEWzXjg5h9ZQ1mWY78KrylsNuqGCfDT7NtJyY5ew5qjOesfRRYi8NAGDHaJGLfN47ZX6UrN3uetHoO5usQ/3jGz5k9Vh4Z/bIfNC+amcTCQHhrAkgdrwv/PnAR/fkgp2OWhhVXPoYNOXEG5yeXFVeUTeRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442866; c=relaxed/simple;
	bh=oW9tvfSaR+x1UFogeZoBERZOmVcHYvyFEYruvk2oe6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUKe1wzK/pn6dCoRdxnl9OlHKNCGGqb3v2azcomXeej2mabnY8V6mJFClLxiby+aYC5G8W+6vRZh2ODu0AtHKNwOd8OwGOXky0rPEPvOiatDWbvf9xTZCFz7L5kkrR+WEUjRP9Kax6gErBAxW3xHS1qzxL/CLqfb9Oz/Y6ehsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcltzmXL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477632e4923so272725e9.2
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762442863; x=1763047663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYN+3T29vDPQnHZypbeGR2Gd6Av+zqDSewkz4T8yjNs=;
        b=UcltzmXLStgO1hGRNJtN1S/sndhf3Ba19BZnOoaq6cMqkQcLd0yh+ZVYEdYEd9mVrB
         C4p/qbs2SY5zWYlQf3P1jqVhckmHQFlhuqtjWe1Shk3I2jY9rKrbm2QLHThMUFiknRpr
         qHoTOzQCSO6UovDocbCluU0343pZOALQL6DotVminqbKJtB6/YXHbeGQ1FM6ANb4PNA+
         o+VFr5lLLTVyOdZiAycEQMCgraWZO+NvyvVMLlfNHISuOLSffMYt+s9rlNDQk9+aaxjw
         pEmwg+o6d9wU9OH5MlYpD0gb63+P5JLeXq9WGXm0C1oFwz+/3xVr1hva+j8THtzh0UP0
         izdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762442863; x=1763047663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYN+3T29vDPQnHZypbeGR2Gd6Av+zqDSewkz4T8yjNs=;
        b=eD0y4xRaj1YKI9WTzCD7JlYoyIyopy/lyRY54JRsajgOTuPgR3mLm6Zx29YKRlfYxE
         LKW/hIwPHaIYCiOSTs2+4+kjE5kz6tx2qDAig6Ua3iBo6sL56VmvOu/9VzMqI3UEqJnP
         6jyeyGIqmTN7gElGm2FhAn7wUCmcZjKidEayUBkWAQYFA7676Ed+lG0RuNc6mqM6RWmP
         byHI1+thbDSBS2Dxwv7XVbxKgcXja4vr62YfK8ym2axSaerTB237UYS1mqIh7mzMUAqc
         3rzRM5bGiij26IlAcfmXaDU+S3EJzs9TOJ8OFqOVMDGUugpnVixpsUx1qZnfcdFe1rfz
         +l8w==
X-Forwarded-Encrypted: i=1; AJvYcCV4WaKwffJC8ZEmDVVWzRayQ/7b6z0DFpNh8gHQflTNOlB7AuCfuH6PTIL8MKe2oCg/owHXPNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLqFuuDzE4T/AXlSu50An2szlsBI+bl1KqO4bYGS/YnDRSwKfq
	jDJffThazPIwW1HLaZKW6nmitYu5Hf6kepypj9eiZml2cgSdn6jbgYSg
X-Gm-Gg: ASbGnctoxt+MTbVJtrC7Otqeu6LT34XOE20OSkKv1XIn1TB5x/Zuz0wb/U65m+yEZdx
	QSM8niZQeM/oRtl5mO9g9wSgx8PRSGYgzUQGBR/b5XrsTRgD/lebjRBPrVEVq0GfVW0zwhk+exg
	qowMxRgjT6tBrBSdy+s6sgcoL4yYuq1S52UHMRot4pJN2Qf51Cg1LtGyF1PpqTkhvqS/zpkDqOJ
	CGyKchl4Oi2ius0M/0XWRpcOVsa00M4MJahVRlH+7VTlwlDc0AteC4IHBmN9ctXhy7EspS6m8rd
	E6IpS+dsbsr5XS+OErH7P5L461JprJtzy/002ScvXf7VDvg1IZDL3JkiLPrZRqgkDLugdzRO/xL
	7XVpd6pXoIt/I6vcyqBWzC/9EyHJpBvPq9pU9OQTkHSqhG9B+qJTSNYPGi9xr/IlBXi1M/w==
X-Google-Smtp-Source: AGHT+IFHmcjtoJWxn3PX8fbkmyn1EIfTbGFv4nNriBxGgz2uXAa8bfekUcn3LVX7XQvTnLy9gtQ3ww==
X-Received: by 2002:a05:600c:358d:b0:477:598d:65e7 with SMTP id 5b1f17b1804b1-4775ce1e88emr40913285e9.4.1762442862460;
        Thu, 06 Nov 2025 07:27:42 -0800 (PST)
Received: from skbuf ([2a02:2f04:d406:ee00:dfee:13dd:e044:2156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329a4sm115564565e9.14.2025.11.06.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:27:41 -0800 (PST)
Date: Thu, 6 Nov 2025 17:27:38 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "daniel@makrotopia.org" <daniel@makrotopia.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"robh@kernel.org" <robh@kernel.org>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"john@phrozen.org" <john@phrozen.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"horms@kernel.org" <horms@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next v7 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <20251106152738.gynuzxztm7by5krl@skbuf>
References: <cover.1762170107.git.daniel@makrotopia.org>
 <b567ec1b4beb08fd37abf18b280c56d5d8253c26.1762170107.git.daniel@makrotopia.org>
 <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f36e6218221bb9dad6aabe4989ee4fc279581ce.camel@siemens.com>

On Tue, Nov 04, 2025 at 08:03:07AM +0000, Sverdlin, Alexander wrote:
> The remaining failing test cases are:
> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
>         reception succeeded, but should have failed
> TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
>         reception succeeded, but should have failed
> 
> So far I didn't notice any problems with untagged read-word IP traffic over
> GSW145 ports.
> 
> Do you have a suggestion what could I check further regarding the failing
> test cases? As I understood, all of them pass on your side?

These failures mean that the test thinks the port implements IFF_UNICAST_FLT,
yet it doesn't drop unregistered traffic.

	[ $no_unicast_flt = true ] && should_receive=true || should_receive=false
	check_rcv $rcv_if_name "Unicast IPv4 to unknown MAC address" \
		"$smac > $UNKNOWN_UC_ADDR1, ethertype IPv4 (0x0800)" \
		$should_receive "$test_name"

But DSA doesn't report IFF_UNICAST_FLT for this switch, because it doesn't fulfill
the dsa_switch_supports_uc_filtering() requirements. So should_receive should have
been true, and the question becomes why does this code snippet set no_unicast_flt=false:

vlan_over_bridged_port()
{
	local no_unicast_flt=true
	local vlan_filtering=$1
	local skip_ptp=false

	# br_manage_promisc() will not force a single vlan_filtering port to
	# promiscuous mode, so we should still expect unicast filtering to take
	# place if the device can do it.
	if [ $(has_unicast_flt $h2) = yes ] && [ $vlan_filtering = 1 ]; then
		no_unicast_flt=false
	fi

Because IFF_UNICAST_FLT is not a UAPI-visible property, has_unicast_flt() does
an indirect check: it creates a macvlan upper with a different MAC address than
the physical interface's, and this results in a dev_uc_add() in the kernel.
If the unicast address is non-empty but the device doesn't have IFF_UNICAST_FLT,
__dev_set_rx_mode() makes the interface promiscuous, which has_unicast_flt()
then tests.

Something along this path is going wrong, because $(has_unicast_flt $h2)
returns yes, so $h2 didn't become promiscuous when adding the macvlan upper.

Could it be that $h2 needs to be up for has_unicast_flt() to work, and it's not?
I'm looking at __dev_set_rx_mode() in the kernel:

	/* dev_open will call this function so the list will stay sane. */
	if (!(dev->flags&IFF_UP))
		return;

	... the code below is skipped

	if (!(dev->priv_flags & IFF_UNICAST_FLT)) {
		/* Unicast addresses changes may only happen under the rtnl,
		 * therefore calling __dev_set_promiscuity here is safe.
		 */
		if (!netdev_uc_empty(dev) && !dev->uc_promisc) {
			__dev_set_promiscuity(dev, 1, false);
			dev->uc_promisc = true;
		} else if (netdev_uc_empty(dev) && dev->uc_promisc) {
			__dev_set_promiscuity(dev, -1, false);
			dev->uc_promisc = false;
		}
	}

