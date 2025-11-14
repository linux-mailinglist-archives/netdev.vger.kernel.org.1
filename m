Return-Path: <netdev+bounces-238780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1AAC5F54F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6656B3A9AE8
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145622D061B;
	Fri, 14 Nov 2025 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNgINBUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF02F291D
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154936; cv=none; b=HOH0o/a0xQHOpGwVYxV+TfWlXeS2+bmuh3TA7aJe4Zbopphsnw/A9WZU0N7nYu+vBzdnISAH2SegyaW2KwUGiBy5p28Q9VbeN083z8pvfHAqzxUwFmrjYH4FC2j1M/j186I7vBWpsapsLZompLOQBqOKoUR1jVQO2mX6ekiEIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154936; c=relaxed/simple;
	bh=S2hUy3Ctr/nVXiml4FIcnxDR6mmMkdBEWRWlQuhE/N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Grgbqb9sjqhVKlBTKkAeUOdUcNwqJvtG8sfL2xqmXXsRnGIingP3vb13wa9LfFACHeDjWASLaTFY7av7uD3jig6c+AygmwJlszZyHgc8AIxrz42mEcfEjF/COVmlTBh2NLzbb4ed1HH2ZjOWGbyTxApTHGE46IBCgRBNFF8hrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNgINBUx; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5957d86f800so2445463e87.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763154929; x=1763759729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sML4jCyYQoTJ1hmfrsxIfxATPh36unBrgaeWLVCadUw=;
        b=SNgINBUxYGf3o+au8RY/5EaTKycLQVe1ph0zeymnfsKSLXTz6Q4+7izsBm8sBI1GON
         vBxCz6vIKpoRBjTo1hYhV7EzzGQlxA0PvGjz5wkt8JRbOPVre91Z8MtBsowjEoOKLIk6
         YrLtGvI62WAgt0Fbw0q9DdJ3JBgZ0nf29879+JgGM65lfjau7Rqgs1Nemn17VDAMxmmg
         UMCoyOjmxzwyRgPnJ2SKMwq6rBaSKzIn2aKXtk4h/rCYAiGeO8mvAhAAk0cabopMHPtm
         NXk4hIutvzF02jEzt0r0ORw+Dkg0X9kHpDSGZshAnJqg4q6WCDt8Pvb9qzxC1RvJENJh
         /9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154929; x=1763759729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sML4jCyYQoTJ1hmfrsxIfxATPh36unBrgaeWLVCadUw=;
        b=g9hFrGcoryA5wrEB50st89CmsF2OugUTWrrRfIEu8uR8+/5ljY85QbDhDBUOYetMA6
         p8nPK4DDA1zoRR+fvi9CXwQG4EPURBW8qkr5osiX93f1Zmqea2TxFpegdWBEl6YdhIXS
         kQknxLurO2p9ttgaxeMQnneBhAE1ilgctPmXx1I7zh9QTig6OgWprCd2SusK1aTyu/+6
         GvYiyLm+jooNOEzBYdwwVXd0OSodQGkwAH2YdG+/YdC97zUnRTVHikKOiuoIhAf/Tor9
         jNa5QtLMWc14GyA36aZoE722GWpWtAIu4l2hw9+7GtB5gtqvFK++hCwky23q083z/tJ6
         Y8tw==
X-Forwarded-Encrypted: i=1; AJvYcCUvW2qxKV9eSg93SWb0qxBQrqEqyxGAKnlujqn9dPvYt36gmkwFMrLjnr50dQNYm3nJ0XiAJTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOnbWR8UhcPQ2ik1zwHjXXifMEZpDA5a0PMiJG+E5EZXHohI4
	wpfdrKp58jRsiw9+grbm1gL6zXh3aG5iDa+tJZkEiOhxOvK7OFB+J5jGSsfieuk7VtzWKF79WNf
	36mXevH4obFcPmnBJE7e22SUP/ho62uE=
X-Gm-Gg: ASbGncscAP+nwqhUfpkDVDt7A+i/GMeVAaRsozH170xQO/5n7GbkfqLSOIcGCvgv5h4
	0mcgiNF+ghBUqOO1XNvY2q9STlsOYlpZx9SSHTBDhapUDc2JQ5cd7jw3sWqpPRrDezsqYvl2Yzm
	CXpa/ruCGdAaC1Af29r8mYjDV9Yu013SrErjjEFmq8jv5z/peTjWMUgNKZudUUScAS2A+Dxd7w7
	88StOj4Iv6ZWgOkMwfRysvt77884YzsPOPCeNaPe3g6MGPRrVMwZOIKtq2F6vk/7Du3vfeae61v
	omQsbpzpuU47O52HADisHEteewTbKmcXlseRPg==
X-Google-Smtp-Source: AGHT+IFBuwdPXj5SibNQKOEi78+J8kw+6qaz9v5iiH4ORuZCSFfnCXhPeJEBxTCSyYp6XvvUwU+pSqoMC7FwQ2flN5M=
X-Received: by 2002:a05:6512:39cf:b0:591:eab5:d8dc with SMTP id
 2adb3069b0e04-595841f096amr1467850e87.35.1763154928299; Fri, 14 Nov 2025
 13:15:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
In-Reply-To: <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 14 Nov 2025 18:15:17 -0300
X-Gm-Features: AWmQ_bkVAsAcWwKHyK5E7HQ3bnRw9GSNPmFn-yckL_xYnS_95F9O8LG6rPXf1-0
Message-ID: <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on i.MX6Q
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, 
	edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Nov 13, 2025 at 7:35=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:

> Maybe dump all 32 registers when genphy and smsc driver are being used
> and compare them?

The dump of all the 32 registers are identical in both cases:

./mii-diag -vvv
mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Using the default interface 'eth0'.
  Using the new SIOCGMIIPHY value on PHY 0 (BMCR 0x3100).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10base=
T.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised cde1: Flow-control 100baseTx-FD
100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

libmii.c:v2.11 2/28/2005  Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #0 transceiver registers:
   3100 782d 0007 c0f1 05e1 cde1 0009 ffff
   ffff ffff ffff ffff ffff ffff ffff 0000
   0040 0002 60e0 ffff 0000 0000 0000 0000
   ffff ffff 0000 000a 0000 00c8 0000 1058.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 Basic mode status register 0x782d ... 782d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Vendor ID is 00:01:f0:--:--:--, model 15 rev. 1.
   No specific information is known about this transceiver type.
 I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10bas=
eT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is cde1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT.
   Negotiation  completed.

After pinging with the Generic PHY driver:

# ethtool -S eth0 | grep error
     tx_crc_errors: 0
     rx_crc_errors: 0
     rx_xdp_tx_errors: 0
     tx_xdp_xmit_errors: 0

After pinging with the SMSC PHY driver:

# ethtool -S eth0 | grep err
     tx_crc_errors: 0
     IEEE_tx_macerr: 0
     IEEE_tx_cserr: 0
     rx_crc_errors: 19
     IEEE_rx_macerr: 0
     rx_xdp_tx_errors: 0
     tx_xdp_xmit_errors: 0

Any ideas?

Thanks

