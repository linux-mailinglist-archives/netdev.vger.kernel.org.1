Return-Path: <netdev+bounces-237673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1C5C4EA79
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 16:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3237C3BD7FF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0006F341670;
	Tue, 11 Nov 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yYVwXie2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF73019A2
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762872022; cv=none; b=MBg8mfvGxndvAf9wddeRHCNhm9kDr+VzOQmGtYHlcVEepWH0dYzTVCpNVFWS54l9f0ZXk757KJxfZVEVHc5aYMjKlzI03ZrPzrQEo/a5TIZMArJwiuVLfniSJdXqb8maxaSMuHY7zmeDKgkn6Nsnp4ye6+ispYxJU2fgM3VS5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762872022; c=relaxed/simple;
	bh=FDghw0stYO+xXzak6/os7CYsSWNSrEWAcIyBf08OugE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7sn9ep1XBmqY7nb7WS77JVJ+VMqBiz0UxryTJ62tYwGcvTkAtowfG1a9pkeD6EHzkaykm/ASlGr2k9WVcYRaP65E5P+vQBSlHCk9OR8i7eebQchRp6MeX1ODtpeny25TW/D6wXGeFb7KkKqlx6wzltrCTz1+6TBV0HQrE1ualw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yYVwXie2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so31987855e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 06:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762872019; x=1763476819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qp5l9CleBH+90IDb02IwKlf8FOy6cwp5KCYKsO335Ps=;
        b=yYVwXie22ay4B75FFgRUarW3PAbtunWdYtW0npAqsN0gNo4Ome1Ov9DFLbh5G5QwTS
         kqkle+QZuAdfcMJY2GIVbAgcpbacNnfEDC8O2EG18jtW4udYOaIgkwN9J6bjeRqLmftb
         3Mv+Ee5G0ZQ83nrj7CtMSnWKsUuNpM9xUZRVcn5awdCR5WSPk7hSVfgY0nBMcUnve3f0
         qWb+/di3TRfuxzgcddGS5lBe0tWyh67fDG6fZh/Nj2bOI4lHSB+4Sn9iD7X/tujuyqcH
         8sImNhACyxwSd/ARQxYzW7d9IDdIcfaTssP5PI4LMnnzKfOAZojnSIiVjy4IpKcMwO3m
         l0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762872019; x=1763476819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp5l9CleBH+90IDb02IwKlf8FOy6cwp5KCYKsO335Ps=;
        b=wp73+PMk06t0vDh+mNqiNPILyxqRaHgQLtfRP9Z6UBnplwwO5euJ7eC/P6dyYWHttw
         wwlgWyRD8m1WCVXgbn+NKIgD+vbdyU7k4alCoHIMtNRZC+pCSFUkeqyr9B0AGAncOh9K
         M4Jm00VAmvL8gg0SWXpdaAA44/wCpnI69aLuQjvqY9LF/e/7E5yBL6Fru4JF90nmS/tD
         OW95JxCe9bb3c2y2j0uS9tcLCYDoJ/92xAlDjlZgnvq+7AxUa37zm/dAkoRrmgpzweU0
         hFQkrfurFtvJ1lC1LaMzKb6XKbpxkLYO6d2RjDDHN1BTZX+gWgf7eCWdceCvD4nzNcQd
         SCZw==
X-Forwarded-Encrypted: i=1; AJvYcCXSFaB7MQEXGuSQSnudmX9X5J/7CYwyI+zaluwvLJrlhETRyDsx2cpyJZfRvEGe5+V5xQEGdwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+aAkrWrasOZCTb55eKjN7nzqVu/SZiJeajYa02nuzkSfTIb/U
	T7bwlhirnyQwcnlS0cTzvmIuzh5Z5pzWUfwbR6FAPpYTlLgIRBsFZuMJSVHuDW1SKpQ=
X-Gm-Gg: ASbGncvDUjJDuh7UCsjQVf6e2AWUIz9EmIXqXhvTBOPi2uuUw/RAsUEtypQr13I8HnO
	PPdLKSD1xUJXLpguDcacuKpvAT3RyPXhjclqeqPVx4YBicDkgdHadJmY2StTD+hxOkDa7fekWLJ
	cKE9sUjmONjfS8oPNvk97aAeVUiYZ6CcqKTLmJGSi2MseagpLZCOoLb7QKFCbUIQzxGu9WAZKY7
	1F6Apt5HdHRHIjR8q6lCzkxNNlgb8z7QmDldlCCKqSjNo6gDg8PQYPm/oLllB5jO9FN1cDlmV64
	sxQG1HLWIzknRaE5Kbmeoooj4amwkhfZsjT/9X0BTt/vnIF1gzrdv0Pcp04+YwUwLA9wHMqFqRv
	06nAB68KSAlbSWjG4S/oR5oPYaAaPs3RzdL1Tc9d3aTk1JboBAD/cR0TfMubr1v2Ah4RTg6E840
	a5isxRMg1PvyeY/gs+KRk=
X-Google-Smtp-Source: AGHT+IHiizBIJOZcrq74AaefcmPGJqcFfS/u1VH/cPNz5auadvSnqgCV70GeJMtA2paFsPgExMwhBQ==
X-Received: by 2002:a05:600c:4508:b0:477:7bd2:693f with SMTP id 5b1f17b1804b1-4777bd28628mr69798945e9.6.1762872019298;
        Tue, 11 Nov 2025 06:40:19 -0800 (PST)
Received: from jiri-mlt ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm392840305e9.11.2025.11.11.06.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 06:40:18 -0800 (PST)
Date: Tue, 11 Nov 2025 15:40:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <xmqe3svfethqm3sqnu2ay27k65gx4njptvs7firsfqn57cwjat@ho3cox3ip2fq>
References: <20251107204347.4060542-1-daniel.zahka@gmail.com>
 <20251107204347.4060542-3-daniel.zahka@gmail.com>
 <mfuluoi4nebyc4avj52gkfs4nqikn6uwhqnkf4o6xfswtpceuq@zhpokcx6bb6l>
 <25ebaf18-f009-45de-a3e4-fe440c42ef19@gmail.com>
 <20251110145831.15872b86@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110145831.15872b86@kernel.org>

Mon, Nov 10, 2025 at 11:58:31PM +0100, kuba@kernel.org wrote:
>On Mon, 10 Nov 2025 08:05:57 -0500 Daniel Zahka wrote:
>> On 11/9/25 5:39 AM, Jiri Pirko wrote:
>> > Daniel, I asked twice if this could be a non-driver param. Jakub asked
>> > for clearer definition of this know in that context.
>> >
>> > Not sure why you are ignoring this :/
>> >  
>> 
>> My apologies. I think there was a miscommunication. I assumed Jakub's 
>> question was directed towards you. I have no objection to making it a 
>> generic param; I will do so in v4. It sounded to me like Jakub was 
>> wanting more information on what exactly this setting does beyond what I 
>> was able to provide in the commit message and mlx5 devlink 
>> documentation. My understanding is that this setting pertains to tx 
>> csums and how the device expects the driver to prepare partial csums 
>> when doing tx cso. I don't really know more than that. Especially not 
>> something like what the FW's role in implementing this is.
>
>Right, per To: field of my email I as asking Jiri for clarifications.
>
>Since we struggle to understand the semantics nack on making this
>generic. Chances are whoever reuses the "generic" param will have a
>different interpretation of its meaning, so what's the point of making
>it generic.

Okay, I don't mind that much.

