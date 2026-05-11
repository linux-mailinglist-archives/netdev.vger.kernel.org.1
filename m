Return-Path: <netdev+bounces-286561-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECA5D62jAWpKhAEAu9opvQ
	(envelope-from <netdev+bounces-286561-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A894950B0FD
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64CEB3025494
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC7A3BE644;
	Mon, 11 May 2026 09:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="vYxxJc85"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78ED3BD64E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491304; cv=none; b=pOQVySti60fQyKTD7k00RWT55JWI7Dohbp+C1lRinxN3Vjv/7pMUrs73/PWZERpV94LZ8nPAT7l/TDKCtjTFhgeL6iPaXqnaY9NEYMY1cSTEAq0HeJY3Njm3n+TwLLHsrZvgVBtOOQThAfE5mDGo8PtLd4em6CEngzgOp8Va1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491304; c=relaxed/simple;
	bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqRXAeZFNOk1lGMyuFJYtw6mAQW/YBltxOvUUcd1OuFFdRrZbyY+hMqlulK+kV6HJE0SEYAQJ0838eIPvd+xMDhbUZI3RMOvurm6JFGTTHHTII7w56bNTezScV46p6J+2hizHynW1BiSovs2XB5nKblorP1wRpipSYBBadyoDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=vYxxJc85; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso35138235e9.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778491301; x=1779096101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
        b=vYxxJc85V/35JiUXFNYmo0LerbGRF5e+QTMsSTky/PLHoHIXcQfhHeEmbjWBQLjGGj
         srHQ7Hor7sJDV69koBiim96BM6DEtzFk1x5lmFs8xXLmiTM4A8tZN+sCE6j/fpqZRfbG
         BbqT8abivpaCYn1MOxRPGCJL3tKCnvHEX9I37FvzdHLKlR9csX5LywataW+c1TMTuA37
         0nToyUBRw/8kCdFEAMVvNrZXBoy68PJAgBxSciwUkAMeXTVYngR6zURWuVjgiRl+vLyp
         1AzXruTSGaRmUI3xjY7I86b5FES6SMPdVhgTGpuqMDLMBswvmBeu1b65y5xgDhNb1Z16
         rOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778491301; x=1779096101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTA3EfMFNqWtw4mwbSh1QoSBedE1rcjpYMGPIfcrLnU=;
        b=dNUAb46gJcYS3FLPSs2iiDX0BsZ+7EkOTub1NND00Rc0tEfXeCjsgwwscdWb/fOyL1
         Q5oxvuQDS59P2TNopbs8JtPxbeuVL5xhmEVtj2WI/ZH0V/KduUV1LIjvF+uqOBpvyq1h
         HcMvZmNnh+YbKLFqylXGjdBqgrPfE8eTJxje3RhJHI7kaQ2VU44AjGj+JFfP4F8OBoky
         jOaD3QAc/beDruZyZYHlgW4P4OiCIJeVzDeWSEBUZoGBoxiuYQwpRrsoA6j1s0MzCmFp
         +KDmIxAu96CPuUqrOahEDXu7NAbn2SofVNjeQirBxBK9lDGAhkFvCSFZC6uiTb45eDSh
         2PUA==
X-Forwarded-Encrypted: i=1; AFNElJ8Qvov/Lm7MRJ6QgrtTkM0jBd28h8RDhQyT38phfPHl7wQm9mglxarRy+EN0GfyZsrYcEzNUew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBR9J/FA7y6Qbzk+5OG4ElRR9stlzJn9TT/qedkhVOuGQppI10
	Wgr4CM3AWp8sa4PT1Z62RTNofyhbNU/2ZUXFifDVWbPyzrVX/In06N4adpdmZYLWMz0=
X-Gm-Gg: Acq92OGPZxECjVtJ15ro2/xRDHvyRU0WAarKZsJVoBDaDI5FghPA0AGQBx8to3i6mLo
	N/w5uEy1ZF5vkFCJx5fI5f8o7Ic5gg4U1ztOJ+H2YIcXCp/kg8cnKRZbkcOAOEfC6BOsT65QSh3
	EiPueAczOIV+QUbsOJQ2dSGLWzvbnkWsUgXMhU3oO8vw7xAh0WFQLmVbKGGBh4yqwBzLkn26Adn
	Yhb/y4hkTuJQeRV0nqm9roGEmgm9Pn4hDI2yc766cq+qvboeRjupd6XNpqFlZQp84ph4aDe/YrW
	JzVRW+OYjWTlWHNqZIPHTLGCvlYKITUggKSYihR3C0Wz2CB3b3Q1LUrMG/teOQN6AMofB3CRur4
	HgLKMjt5c4Ic0VTDgBXD0/SsizldC4DYvlbxwqCO1S/phljsiwDdLHTQkU2GPUzKhC1+229nuqo
	Q7PujR4kfaaqW3OAue2h6VfeY5EdF5HlftkMeWvj7RI2aUUxIh8gBM/ADvpAAsolg5REzYL0ZDc
	zNzHMRrLOsjzVg=
X-Received: by 2002:a05:600c:b8d:b0:489:1fa5:997f with SMTP id 5b1f17b1804b1-48e70691673mr134646165e9.9.1778491301044;
        Mon, 11 May 2026 02:21:41 -0700 (PDT)
Received: from localhost (p200300f65f114e0841c796eda31a14b3.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:41c7:96ed:a31a:14b3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48e7041c4e8sm167443115e9.14.2026.05.11.02.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:21:40 -0700 (PDT)
Date: Mon, 11 May 2026 11:21:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Michael Grzeschik <mgr@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Steffen Klassert <klassert@kernel.org>, 
	David Dillow <dave@thedillows.org>, Ion Badulescu <ionut@badula.org>, 
	Mark Einon <mark.einon@gmail.com>, Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
	Manish Chopra <manishc@marvell.com>, Potnuri Bharat Teja <bharat@chelsio.com>, 
	Denis Kirjanov <kirjanov@gmail.com>, Jijie Shao <shaojijie@huawei.com>, 
	Jian Shen <shenjian15@huawei.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	Fan Gong <gongfan1@huawei.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Yibo Dong <dong100@mucse.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Jiri Pirko <jiri@resnulli.us>, 
	Francois Romieu <romieu@fr.zoreil.com>, Daniele Venzano <venza@brownhat.org>, 
	Samuel Chessman <chessman@tux.org>, Jiawen Wu <jiawenwu@trustnetic.com>, 
	Mengyuan Lou <mengyuanlou@net-swift.com>, Kevin Curtis <kevin.curtis@farsite.co.uk>, 
	Arend van Spriel <arend.vanspriel@broadcom.com>, Stanislav Yakovlev <stas.yakovlev@gmail.com>, 
	Richard Cochran <richardcochran@gmail.com>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Thomas Fourier <fourier.thomas@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>, 
	Zilin Guan <zilin@seu.edu.cn>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Marco Crivellari <marco.crivellari@suse.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	David Arinzon <darinzon@amazon.com>, Yeounsu Moon <yyyynoom@gmail.com>, 
	Denis Benato <benato.denis96@gmail.com>, Yonglong Liu <liuyonglong@huawei.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Yicong Hui <yiconghui@gmail.com>, MD Danish Anwar <danishanwar@ti.com>, 
	Nathan Chancellor <nathan@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Ian Lin <ian.lin@infineon.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Double Lo <double.lo@cypress.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, linux-parisc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, oss-drivers@corigine.com, 
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH net-next v3 2/2] net: Consistently define pci_device_ids
 using named initializers
Message-ID: <agGfbyxlKC8WcEdm@monoceros>
References: <20260511090023.1634387-4-u.kleine-koenig@baylibre.com>
 <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="26wz6vcj2wzkdd5i"
Content-Disposition: inline
In-Reply-To: <20260511090023.1634387-6-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: A894950B0FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286561-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,thedillows.org,badula.org,gmail.com,marvell.com,chelsio.com,huawei.com,linux.dev,intel.com,nvidia.com,mucse.com,realtek.com,resnulli.us,fr.zoreil.com,brownhat.org,tux.org,trustnetic.com,net-swift.com,farsite.co.uk,broadcom.com,bootlin.com,seu.edu.cn,suse.com,google.com,amazon.com,infradead.org,ti.com,infineon.com,cypress.com,baylibre.com,vger.kernel.org,lists.osuosl.org,corigine.com,lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_GT_50(0.00)[80];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action


--26wz6vcj2wzkdd5i
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v3 2/2] net: Consistently define pci_device_ids
 using named initializers
MIME-Version: 1.0

On Mon, May 11, 2026 at 11:00:24AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> Forwarded: id:76da4f44d48bdde84580963862bf9616bee5c9e9.1778149923.git.u.k=
leine-koenig@baylibre.com (v2)

This is my internal marker for tracking mainline submissions. If someone
applies this revision please drop this line.

Best regards
Uwe

--26wz6vcj2wzkdd5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoBn6EACgkQj4D7WH0S
/k4q9wgAnNsetoJQuSPdcsRqTfhJ3nvDxBsfxvsce6Raf4aiAs6sa5jJlBrTa5h3
nEaIsI15hqOx2W/FeLUG3/e0pnGua3DO4qsTmtY+G74jweYDfLDdXlEHlt9zNS6x
lDrxCXGPT97KmN2CifwJILefl8Lv7jTwROdpFGiVt85DXbiZtFIL/frdeU6leU+1
FdE6JY7j/Qx1jjdXNf0bWzAYX8PJ8ocHv+b0BcV8ctfX7hsV/vxsLmUU0goDLYiO
u683/fMBDCwmEtoIHKOODM7mPIJAndSocuWgR2Fn2xqlVyooDPuS9d0p0wTjl2qT
eA7SLNWIZbT2fhIZM4FV8lAwHsMj+w==
=qcwQ
-----END PGP SIGNATURE-----

--26wz6vcj2wzkdd5i--

