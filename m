Return-Path: <netdev+bounces-245260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 070A0CC9E20
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0A6030255B0
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A021F9F70;
	Thu, 18 Dec 2025 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QILm+ujN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8511F5617
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766017772; cv=none; b=f+KbHP0qzjyLYD1g6ME8Y34A2yejM8AhW1O/uOCyTGtSJ3lX8h3LlPSjc/sGfB002Zgs3o+yhU58ZwF82gesK6xqkXgbCzHUzDcNF+x8PF40lsMROuZQ5Ow46NhZiJ6wnsZ4sJyuz8Lji2kp2G6nhrAH9zqN3TVba54VnTi1sDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766017772; c=relaxed/simple;
	bh=QGNO69MgeAtGsGvG/kmDKblruQR+fpI1WvlkskYfjN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMwlReax8l8E7M/2J1uJxKb6XSWpm8a8c9n+mFIRXzc0zGnbHlbzRtt3ehrtcPNTCstpu3ndGfJ4CpVXLh+i0ZWhjudWVxzM/BCDAgFsx330H6KzCvmrFe0EnxDPVKpnKdsQfH/ik9qmTynYWEP7214tydMFyKfZpEGWEiUeCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QILm+ujN; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6420c08f886so71950d50.3
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 16:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766017770; x=1766622570; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C/XFjxiHoDiapv3Kf9AQyXpz8iHUXFlH3+G4KBEH7O8=;
        b=QILm+ujNS17OO+MYV6zpc2/Cu1IdT7adBuQhlY8qYAdKGYqBHuXLE02uYTX+OW+Cgl
         LkxE7IznHz+Eydey9cYZ+28GNPAkHe+U6tGr2ci+I7kZM2qorUaoiHY72TqgISNM1wsg
         0CxtCDEQKkx7RNMw0fg9WZC93Cmvj9HkhcvVt1an1k/E7/8OCEil3yEoayFHZUKYMeqW
         A1Zbjv2KfqzClKwMsVjwYsVdISiXvlD6MaXAcsaQoUA+T5CeEYh3GkwDDNe9PJ4d+OUj
         LZ1+yxZjhmm2FXUemo1FQIsB6lpDpU9fNyQhyKn7XEJCpQQNgc6I/MgkPhBr/C/QXkR3
         iuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766017770; x=1766622570;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/XFjxiHoDiapv3Kf9AQyXpz8iHUXFlH3+G4KBEH7O8=;
        b=og8NNpKQKWElIzlculkNGFdiElsl9pot9gFTn4p8uB227rNMPB8X9fc7XAn57GzEM7
         cq7wE6vu8qZI4dXIylTq5wVpUl3YIHXh9T0AuM1kZxfiFb7IHUoPy+3kHInKXwmfrOmF
         9jGatAKjwnFvUKu/uysRjcRotKdmdtrZ51hjTYib6BWT6PHxEFGVIu2JuyCw1QFCV2Hx
         RqYFei9APSMDVWkKtJtMmSJPIwXzvdHWRTTZoNwCyHGmaUNW7Z5Pg2xjo/HkNnttWvzx
         3mYdWMDOhejzCLeM5dlvMusCFSCd0XV8v1RUA/PFRZscHEbHxzi5KDobVf210ou3QNxb
         hGYg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Ci9fEQL3BKPeOp66GSzF/5iTInNzw9ky/JwJBEN1WcC5xzON5oc3pfUPwkVl1FUjEGaBoz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCfOOW1pq092JKfAS2UxsLsHEeWGFOvd/rj0aTicFFyniFDtYT
	ChZxy9ILIwAiVqhQxtD3EJV5AWq+F6/cSVEcWge8mdUwMWZV6bgjyRRU
X-Gm-Gg: AY/fxX4OhCyKP7tci9/674sMPxWOTAqZ7FWAajmYst2ch1Dl0OsvKwrALPKZJtfj+5F
	EQM28GT4NqnAIt1PEM87/jV1FO/D3ruVtg22sJumGwLRoEUsRBMKZKzBweK6A3Q5LHuege0dJPc
	F/YskuEmAptC6qt7WYiwEh1Snsdkm89MkCErWGCxg6kOua1+8E7gA2N3TjMf7mdDQhXexgtapZc
	Ysi0hY7vH5anbXSIthHQ2jyLyqsxiXFDYfe1Yzosca62VCGtsVXr8F2Dv+XzG1Cadi5H7UZ3rEu
	le7Wu4mWdZCuUYN41ZbXcVXAsUT/utyZuR+jbYQCzlWtjYxGc2niKZxgxak4qlqv/5dgCqLdWii
	oypUd8lUzgK2of6kvsO75IaW/aCOZipo1ipeOHPAH9b5uVAVcE8a0jykLl0R48MufYzlczG4KL/
	QuYeMhGio=
X-Google-Smtp-Source: AGHT+IGaUOcONjtuMEsZ2PhCFhxICtR6n484WKwClXmFzzDNH3PajQrXjnW44s3ibrmjEhfM0lwLvw==
X-Received: by 2002:a05:690e:400f:b0:644:60d9:753a with SMTP id 956f58d0204a3-64555680921mr14798317d50.96.1766017769991;
        Wed, 17 Dec 2025 16:29:29 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:52c0:aec0:bf15:a891])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fa7289a29sm2595537b3.44.2025.12.17.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 16:29:29 -0800 (PST)
Date: Wed, 17 Dec 2025 19:29:29 -0500
From: Yury Norov <yury.norov@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH] i40e: drop useless bitmap_weight()
 call in i40e_set_rxfh_fields()
Message-ID: <aUNK6So7KzD3zngt@yury>
References: <20251216002852.334561-1-yury.norov@gmail.com>
 <IA3PR11MB89865FF35893188BDF61B7FAE5ABA@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89865FF35893188BDF61B7FAE5ABA@IA3PR11MB8986.namprd11.prod.outlook.com>

On Wed, Dec 17, 2025 at 11:37:32AM +0000, Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Yury Norov (NVIDIA)
> > Sent: Tuesday, December 16, 2025 1:29 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; intel-wired-lan@lists.osuosl.org;
> > netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > Subject: [Intel-wired-lan] [PATCH] i40e: drop useless bitmap_weight()
> > call in i40e_set_rxfh_fields()
> > 
> > bitmap_weight() is O(N) and useless here, because the following
> > for_each_set_bit() returns immediately in case of empty flow_pctypes.
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> > ---
> >  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 24 ++++++++----------
> > -
> >  1 file changed, 10 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > index f2c2646ea298..54b0348fdee3 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> > @@ -3720,20 +3720,16 @@ static int i40e_set_rxfh_fields(struct
> > net_device *netdev,
> >  		return -EINVAL;
> >  	}
> > 
> > -	if (bitmap_weight(flow_pctypes, FLOW_PCTYPES_SIZE)) {
> > -		u8 flow_id;
> > -
> > -		for_each_set_bit(flow_id, flow_pctypes,
> > FLOW_PCTYPES_SIZE) {
> > -			i_setc = (u64)i40e_read_rx_ctl(hw,
> > I40E_GLQF_HASH_INSET(0, flow_id)) |
> > -				 ((u64)i40e_read_rx_ctl(hw,
> > I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
> > -			i_set = i40e_get_rss_hash_bits(&pf->hw, nfc,
> > i_setc);
> > -
> > -			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0,
> > flow_id),
> > -					  (u32)i_set);
> > -			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1,
> > flow_id),
> > -					  (u32)(i_set >> 32));
> > -			hena |= BIT_ULL(flow_id);
> > -		}
> > +	for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
> You removed the flow_id declaration, but use it in the code below.
> Are you sure it compiles?

No it doesn't. I'll send the right version shortly. Sorry for this
noise.

Thanks,
Yury

