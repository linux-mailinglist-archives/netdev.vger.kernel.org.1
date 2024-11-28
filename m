Return-Path: <netdev+bounces-147697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BDD9DB3FB
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 09:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287CC1646C7
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 08:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785414C5BF;
	Thu, 28 Nov 2024 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkB9MwKy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15114C59B
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783485; cv=none; b=qIsXNCxTvbv/xZDODAV5j3rZ1+fkZXtmEg5BDd1xfSsLZMmTSSvBmEi33sc877oTwNLTJ8FQzQn93B+k8XSJBU+4m5b/5BA0oy8Frn9CQxHA0eXmGeTzGqhXvIHmX2UFG3wXpflXeGo4Fta6RUsoqsPlvEJ+F0CZDfbDgNXUkNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783485; c=relaxed/simple;
	bh=z6dSAxTCoGwpeLaeKD6UwZtBvUZguLwF0psS9dF6NDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GsIclRvyt8qXAdCSWFYIUpKce3ELd7KV3+AJsqj2OGjusW/jLq2yG9kn8KYj/VNM8ij9PYHv2wGKXhFw6w1rRrj/yiNjR0taEzyasSWHGwDZszzyDjb+8vZ90CEFUfE8PiUmaffgOfUGx3F51w01dZHXq/UbHTei1qHi8Huz69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fkB9MwKy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732783482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3xYQmL/kJPyGibrWvcAhkVuAXbD7+oBx5V8aAxel9Dc=;
	b=fkB9MwKyhW72/O9Gnln7L6Ek+69bLM0zymuoGMXnAZ/871VMi4LXGxlUTpzRH+raYZAo2Q
	VPkwq0JGaArgnHj/E/oYDf53Ki5Om7NjvIPRd+ILgHlvoTcIk6AeB7UjpfmeUmlTYTdPJ4
	7vW8CCHsX72X7ab+4mTE1veAYmmvLzc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-88EHCDGsNfiO-_eWxyemWw-1; Thu, 28 Nov 2024 03:44:40 -0500
X-MC-Unique: 88EHCDGsNfiO-_eWxyemWw-1
X-Mimecast-MFC-AGG-ID: 88EHCDGsNfiO-_eWxyemWw
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38245ddf59fso521240f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 00:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732783479; x=1733388279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xYQmL/kJPyGibrWvcAhkVuAXbD7+oBx5V8aAxel9Dc=;
        b=nSdhnI/slpc58F3KSK9Fmr5/kJSWapd0JDEgqPxHcURvMKnS4lK0McAl2ryPMxp5P6
         XGDP/hKBDmG6qWdoRAZj85+IqHcsFKTcsNPVlK81BuNVrUsi3jAdxcYJBDnNsWfxbogT
         xsHh2sUHL7jK4HHfkJnAypElZxcltCWgb+D/GaTEMDIU8oMvZDLdrBafvLPu6nMToOau
         zX/8icp6xx+4ArsTvb8XSALrLg5//NZBnCQgZFD/hDKKhYI5jV0GF0M6yXHSb6lrBXCs
         PaUaR3gUaBgC0CAwA8PQMxuXCmQ+79tyKiZKwPBhp4ITqhSNWG9tcAInAsnEZBZkpbYh
         aK2A==
X-Forwarded-Encrypted: i=1; AJvYcCUEprxGKzcpY7hpIbRmO8aq+3NeAyrnaN0mi+rKmpz1xh2BseIpbHBr0AkaT+IffIX3431QDX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqh+zH4cxCOx7CgndPfEn5x8irYIyAQRGw12MBoRiicIZsk4by
	qrSwLDdCuGk1cjyM1kySHqD0MMLSh4tqHYNzz+h+B2nw00/SIriDuJ78I4KzTv/EzwfwakHsbXu
	3MWK4TJdtSdoLE3lG+/Nq81XTvROUVXd+m/eYGW4nQFJBCk/ZZMCrMA==
X-Gm-Gg: ASbGncurWb2t62hlz/R66YXYVMgbXr9Fsz1z3RvpzuRc9Ky1sUMeXS48iNcg8MUZEbA
	BI3pI55qEoimx873tArnEbYFIL26gecX1Sib18ayjjN7mZJpO2l/eHShk/RzCHil2+t+F8v7VSW
	51AOEER4/6jfTxFvZwmWo6HZ1OmC+YCoi+jjEyJn4PvagVSO3R8eVb+PrCengs1LHy+zeE1YVda
	8MCTpsy68CGHYA5gnO9zKZ/dso0OGCBP/RLJYgF3ZL9nJeSiuHuOaH8FzU65iY1c5TPUFoQr2cC
X-Received: by 2002:a5d:6d0b:0:b0:382:1cff:2e6f with SMTP id ffacd0b85a97d-385c6edd784mr4533906f8f.37.1732783479623;
        Thu, 28 Nov 2024 00:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5rFebua0JRlNymqOZ+vBJY95XKmZ/vKiRD15ohZpVhecgbEJxDERPXuJeZuRQvlDUh/tp2A==
X-Received: by 2002:a5d:6d0b:0:b0:382:1cff:2e6f with SMTP id ffacd0b85a97d-385c6edd784mr4533890f8f.37.1732783479296;
        Thu, 28 Nov 2024 00:44:39 -0800 (PST)
Received: from [192.168.88.24] (146-241-60-32.dyn.eolo.it. [146.241.60.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd7feccsm1024472f8f.95.2024.11.28.00.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 00:44:38 -0800 (PST)
Message-ID: <bedf2521-dcbf-4b5b-8482-9436a54a614f@redhat.com>
Date: Thu, 28 Nov 2024 09:44:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: phy: fix phy_ethtool_set_eee() incorrectly
 enabling LPI
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
References: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <E1tErSe-005RhB-2R@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/23/24 15:50, Russell King (Oracle) wrote:
> When phy_ethtool_set_eee_noneg() detects a change in the LPI
> parameters, it attempts to update phylib state and trigger the link
> to cycle so the MAC sees the updated parameters.
> 
> However, in doing so, it sets phydev->enable_tx_lpi depending on
> whether the EEE configuration allows the MAC to generate LPI without
> taking into account the result of negotiation.
> 
> This can be demonstrated with a 1000base-T FD interface by:
> 
>  # ethtool --set-eee eno0 advertise 8   # cause EEE to be not negotiated
>  # ethtool --set-eee eno0 tx-lpi off
>  # ethtool --set-eee eno0 tx-lpi on
> 
> This results in being true, despite EEE not having been negotiated and:
>  # ethtool --show-eee eno0
> 	EEE status: enabled - inactive
> 	Tx LPI: 250 (us)
> 	Supported EEE link modes:  100baseT/Full
> 	                           1000baseT/Full
> 	Advertised EEE link modes:  100baseT/Full
> 	                                         1000baseT/Full
> 
> Fix this by keeping track of whether EEE was negotiated via a new
> eee_active member in struct phy_device, and include this state in
> the decision whether phydev->enable_tx_lpi should be set.
> 
> Fixes: 3e43b903da04 ("net: phy: Immediately call adjust_link if only tx_lpi_enabled changes")
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

This patch did not apply net cleanly to net tree when it was submitted,
due to its dependency. As a result it did not went through the CI tests.
Currently there is little material there phy specific - mostly builds
with different Kconfigs - but with time we hope to increase H/W coverage.

AFAICS this patch has no kconfig implication, so my local build should
be a safe-enough test, but please wait for the pre-reqs being merged for
future submissions.

Thanks,

Paolo


