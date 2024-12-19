Return-Path: <netdev+bounces-153386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F17E9F7D2A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB61188DD49
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363A225787;
	Thu, 19 Dec 2024 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+s9eAbq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD01805E
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734618562; cv=none; b=GehPRsfmDV59iCFZ5l5i+LCPWGQOsfWhkVsXnXa6GcQIiSKt3tE15/KFbvxleBtI5OQqivBVupZxFgLtEhiWiefaDS27FOST2RP/H4EyILULKTTThen1llMJpArpQidE0gsTgjw7ullop2DQsp85GtFC3pCV0QD+fD9DXSjrREU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734618562; c=relaxed/simple;
	bh=5fUTxj70T4hYejUCaFreyVE5EInfryzddRpIVYJRJ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ivzY/ALDAEP8UJWoaJUuIKj0jIKtKEes/ygrwK2CrEPCO8CbEWoqNpIqcSL+ljk3D2G81vW9cNdrO8TeQlrTUz7EpDTROY+gRHLzT6jJic7tYxZn4f8FmNHAGBg49kAYHyps+DLa+culcM3jFGVwi3QdVJsRtxEshdPbXK/+8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+s9eAbq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4363298fff2so1288095e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 06:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734618559; x=1735223359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/U3NMH05bORdahy8HjiqIo7GfW7BCvPSgl/UhJG8yrc=;
        b=e+s9eAbqX8d1HKr8IPt5OW41q5Kxyi6z5Y9zAL8AhasbTxRb6tykwKAvvBihCvUbm4
         ku7c3pUixsZchgjNW8jBd3Kf6Yu8DH+aF7tAlYCU32/4CMSf1m1Zj/4ERuzzfdyTjzLp
         ARE03lXkUj812kcRdcBaFGRZmSzTWxO+FqDb97auW8OS8kfgx6Pos4uND6eIKVu7vJ/1
         HKmQRVo7u3kD5cD4YlCHA6Pzaw3PcEhFe6bZ70wxw9bvey9vO34VTnBm1EEm2xsAJfxx
         EQQpQa9Ta/ekAt2clAkb8WoCmi3a+ZlUDttUVLxO9iqCwjkgxOiu4XcnyxV/l4edSsWL
         dlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734618559; x=1735223359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U3NMH05bORdahy8HjiqIo7GfW7BCvPSgl/UhJG8yrc=;
        b=keYQAnNXqPhhWY2HwLnxVPto1ZOb187oUjaoOt4cpQNzsInOzY7tEuTDysriRUlE9k
         I9bqQl3r5jy6QS+QSNuW8lL+HQR8lDThZVwFAcxaQ+QMePkO8qu/YPoPkvSOBMBUZ88G
         RWirSb5qVkRnfIyjqK7JxxKSfueYCDs+GE12gVIEb4iCTzgS5msBikHLNx/Uj4Pz3MWt
         zjYHWihnXs0xV6V8gToi6yI85WYEHt1BFKBJiDmvYZQ4oL7FuzU7CQFbx2FjlOG3q5mt
         j04XkmVcb6t8ycfic5VFWXA0ACPi5t6XWzIF+Qq5lK4fRtUvEQH0oWo3cORdlosI5Fx2
         T5yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwebOvrqirlk30aFttVHmMj3B6hGig/8O/9k4z15AT8wUCtijEscQXRcMRBSiuQTOo4LDlbzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxwTrA5evLGfBJoKbN13z7K+PMfmI/KsIuy81sQHue+qQFYOjI
	nx+yz8oGsVSEPLndXONN4wR4cp+w+TiPIghVP/Uo0wgYlcPl8h3L
X-Gm-Gg: ASbGncuQi9+nawBKtvpiD26zf87AO2+LTFipzundn+xWrtC2PVn0ZtYtzA9WiaHvgbp
	roomv/sCPVIWijtJ1AkDgzzHVDvrO3yq1REcZheU+LVOzLHuSof+Iw6z9gV9kYsVDDFPQJqgTSl
	g1tFV6TJVKEunSztCPmbl9zf2RbWmnJwspPDn2nnEMTiTmTULaTDsaV4UmZDpclfs0P7NbzmuPH
	L93DkTwDl4Q/qxzRq6ubXXStSiRf07/qCJrRmCO3LnH
X-Google-Smtp-Source: AGHT+IEjgdP1RD+EW2eh3DXl8bWPSEDGRjEePILVCBFqahy682q/W1RPPwZDMKGjMoaSK4ChW7+6yQ==
X-Received: by 2002:a05:600c:4511:b0:436:1ada:944d with SMTP id 5b1f17b1804b1-436553f5667mr25688715e9.4.1734618558458;
        Thu, 19 Dec 2024 06:29:18 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea42esm19776405e9.9.2024.12.19.06.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 06:29:17 -0800 (PST)
Date: Thu, 19 Dec 2024 16:29:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch,
	f.fainelli@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
	chris.packham@alliedtelesis.co.nz, pabeni@redhat.com
Subject: Re: [PATCH v2 net 4/4] net: dsa: mv88e6xxx: Limit rsvd2cpu policy to
 user ports on 6393X
Message-ID: <20241219142915.didcxxlvxvnfhori@skbuf>
References: <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-1-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219123106.730032-5-tobias@waldekranz.com>
 <20241219123106.730032-5-tobias@waldekranz.com>

On Thu, Dec 19, 2024 at 01:30:43PM +0100, Tobias Waldekranz wrote:
> For packets with a DA in the IEEE reserved L2 group range, originating
> from a CPU, forward it as normal, rather than classifying it as
> management.
> 
> Example use-case:
> 
>      bridge (group_fwd_mask 0x4000)
>      / |  \
>  swp1 swp2 tap0
>    \   /
> (mv88e6xxx)
> 
> We've created a bridge with a non-zero group_fwd_mask (allowing LLDP
> in this example) containing a set of ports managed by mv88e6xxx and
> some foreign interface (e.g. an L2 VPN tunnel).
> 
> Since an LLDP packet coming in to the bridge from the other side of
> tap0 is eligable for tx forward offloading, a FORWARD frame destined
> for swp1 and swp2 would be send to the conduit interface.
> 
> Before this change, due to rsvd2cpu being enabled on the CPU port, the
> switch would try to trap it back to the CPU. Given that the CPU is
> trusted, instead assume that it indeed meant for the packet to be
> forwarded like any other.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Is it fair to say that commit d82f8ab0d874 ("net: dsa: tag_dsa: offload
the bridge forwarding process") broke this and that we need a Fixes: tag
for that and not earlier? Prior to that, I believe that rsvd2cpu would
not affect these forwarded reserved L2 multicast groups, because they
were sent with FROM_CPU.

> ---
>  drivers/net/dsa/mv88e6xxx/port.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index 56ed2f57fef8..bf6d558c112c 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -1416,6 +1416,23 @@ static int mv88e6393x_port_policy_write_all(struct mv88e6xxx_chip *chip,
>  	return 0;
>  }
>  
> +static int mv88e6393x_port_policy_write_user(struct mv88e6xxx_chip *chip,
> +					     u16 pointer, u8 data)
> +{
> +	int err, port;
> +
> +	for (port = 0; port < mv88e6xxx_num_ports(chip); port++) {
> +		if (!dsa_is_user_port(chip->ds, port))
> +			continue;

Can you remember to convert this "dsa_to_port() called in a loop"
antipattern to dsa_switch_for_each_user_port() in net-next? I wanted to
ask you to do it now, but the blamed commit is in kernel 5.15, and
82b318983c51 ("net: dsa: introduce helpers for iterating through ports
using dp") made its appearance in 5.16.

> +
> +		err = mv88e6393x_port_policy_write(chip, port, pointer, data);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  int mv88e6393x_set_egress_port(struct mv88e6xxx_chip *chip,
>  			       enum mv88e6xxx_egress_direction direction,
>  			       int port)
> @@ -1457,26 +1474,28 @@ int mv88e6393x_port_mgmt_rsvd2cpu(struct mv88e6xxx_chip *chip)
>  	int err;
>  
>  	/* Consider the frames with reserved multicast destination
> -	 * addresses matching 01:80:c2:00:00:00 and
> -	 * 01:80:c2:00:00:02 as MGMT.
> +	 * addresses matching 01:80:c2:00:00:00 and 01:80:c2:00:00:02

Is the comment correct? LLDP is group 01:80:c2:00:00:0e. It doesn't make
it sound like what is done here should affect it.

> +	 * as MGMT when received on user ports. Forward as normal on
> +	 * CPU/DSA ports, to support bridges with non-zero
> +	 * group_fwd_masks.
>  	 */
>  	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XLO;
> -	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
> +	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
>  	if (err)
>  		return err;
>  
>  	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000000XHI;
> -	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
> +	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
>  	if (err)
>  		return err;
>  
>  	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XLO;
> -	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
> +	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
>  	if (err)
>  		return err;
>  
>  	ptr = MV88E6393X_PORT_POLICY_MGMT_CTL_PTR_01C280000002XHI;
> -	err = mv88e6393x_port_policy_write_all(chip, ptr, 0xff);
> +	err = mv88e6393x_port_policy_write_user(chip, ptr, 0xff);
>  	if (err)
>  		return err;
>  
> -- 
> 2.43.0
> 


