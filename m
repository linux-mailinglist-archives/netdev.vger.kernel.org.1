Return-Path: <netdev+bounces-184086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEEEA933ED
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFAE37B439F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 07:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B8B26B096;
	Fri, 18 Apr 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="DOrtbsoa"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B5F26A0E2;
	Fri, 18 Apr 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962656; cv=none; b=gFaqfAbpbW2Fbbe+Lj5RjHc8kpTVBGGVq/Ul+ITcFYJB69jbEe1a2QOPxB76JrnKF1YqKDmt9A1ACdBDy+EPQBvOvdTUfQDlhHZPnKnk0M1npWbEu3vbYFyVVZ9QPpe8VgHmDqUq5xfHDfiK7141fzr5M0PqTnmpxN/u+zdlrkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962656; c=relaxed/simple;
	bh=tHGVvJy2qoA1zx4Xn00flkGhWOwqqEjyGe3hPkNQdYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsPaITATTEPeSVfFuQ9XIkYYY2VK1ewPtLnaXI7CGcb930gd9u6Z3p3DYp8EkVHEvxRha94gMyxsyxjnKo2/alSbrnXuXR2T80tdDRYPGVdklbqLmGkxRJKoJWzQq3FIivHKI2FV8A8ejnSGBB+HRuz0d9iNbXLI9+jCSEkC9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=DOrtbsoa; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.12])
	by mail.ispras.ru (Postfix) with ESMTPSA id 1954A40737D6;
	Fri, 18 Apr 2025 07:50:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1954A40737D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1744962644;
	bh=aQ8uS86dwx3oOwElkFa5V33YDOy0ATV7MK7htyWVhWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DOrtbsoasy/Rqrv7yCRPW2yxI7WusNsdZLipWiV6605QnzGifMrnBlxa/aBNMV0Am
	 /E5ZaTgKHQVNbEfHeLS+lORBJB+uWJUMY8iVYwviWbi8kFf3FCV62eDbFEgmGU8hil
	 ETUG/2hc2noeMzb01b1HPlaR1Hx97uknRC9ginYk=
Date: Fri, 18 Apr 2025 10:50:43 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
	Mammatha Edhala <mammatha.edhala@emulex.com>, Ajit Khaparde <ajit.khaparde@broadcom.com>, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Padmanabh Ratnakar <padmanabh.ratnakar@emulex.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>, Somnath Kotur <somnath.kotur@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] be2net: Remove potential access to the zero address
Message-ID: <mfcee4wujmaj4r7mkmd3xvmtjq5xl3varvhz4sxks66jid46w7@znt2ricbegc2>
References: <20250416105542.118371-1-a.vatoropin@crpt.ru>
 <Z/+VTcHpQMJ3ioCM@mev-dev.igk.intel.com>
 <20250417195453.2f3260aa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250417195453.2f3260aa@kernel.org>

On Thu, 17. Apr 19:54, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 13:32:29 +0200 Michal Swiatkowski wrote:
> > > At the moment of calling the function be_cmd_get_mac_from_list() with the
> > > following parameters:
> > > be_cmd_get_mac_from_list(adapter, mac, &pmac_valid, NULL, 
> > > 					adapter->if_handle, 0);  
> > 
> > Looks like pmac_valid needs to be false to reach *pmac_id assign.
> 
> Right, it is for this caller and there is a check which skip this logic
> if pmac_id_valid is false, line 3738.

Wait, the check you are referring to is

	if (*pmac_id_valid) {
		memcpy(mac, resp->macid_macaddr.mac_addr_id.macaddr,
		       ETH_ALEN);
		goto out;
	}

which will skip that part only if pmac_id_valid is *true*.

