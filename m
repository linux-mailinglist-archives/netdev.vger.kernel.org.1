Return-Path: <netdev+bounces-92048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D588B530F
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8381F2150B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 08:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983F8171A2;
	Mon, 29 Apr 2024 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sp9pljBf"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD53517BBE
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379003; cv=none; b=Pc9HuQNi4syLOIKu10erTWyn5IUBdo11cPPMJsa4YiJenz/gNGcuLNKZWz1k38i4mF4gz3hElXXoQDG4kvXZ8AXv1lEusiahsuKZGsSREwGFXZo/CKllhjJ7/+9w+OBLwyM1cnOeWE/HVg3YxoG1fJe1XFpXnM3hjt59YiJPi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379003; c=relaxed/simple;
	bh=IDkLVSEZK/LrssK61I5JNgpafOgw4wa+oGz+vZAYWTI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4hFTgl2UThRDXoiNrDEhyWIgxsupqRLvzIii1nOYeFEfGrsthS7LzyiqXVy6DhB1f6ytbOHMdQshp6YOzSEqJ7L2p9IRP6uE6Ebx0TzoUaShLyT49skLxgLnwPA1h2AAvOvZmm0cAVFMBZySpzQdgyCGdk/1TOHvLO1OvfEbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sp9pljBf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714379001; x=1745915001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IDkLVSEZK/LrssK61I5JNgpafOgw4wa+oGz+vZAYWTI=;
  b=sp9pljBfORfbXfawDFAFqtl10sKOhdRSmoF5s8DLvmrUB8UTGf+ulacl
   Nv41SiGlfUFaWDqkLfDfn+NLOrZRZI49jjfvf1/uK7/1Dp72YhBLWYWds
   X6n+RBJfcNNu4Kv+Aj+dyw6we2nwdQvjhJndm0TS2C2Jwx+dYbtJ8CnH5
   xxrOM5Ar7kocJiRjc4+g5JJQBcT01X3wt9Ng6SVxEeIDUY7VLgvaAWS7c
   tZisfpELsd9B1C1f+FNClCxAi+hXrc8j5myh67Qe46I/H09AxD+tA5QCQ
   aISSRE5pipMYeS54+1BpIgQUfliWtt7A40aoAqtmE0c2aXin+WwdWiOY/
   w==;
X-CSE-ConnectionGUID: aJQvqhOATyir33ncWPuOqA==
X-CSE-MsgGUID: DjqU8DJsSMm+xbfHP2d5Ww==
X-IronPort-AV: E=Sophos;i="6.07,239,1708412400"; 
   d="scan'208";a="23751066"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Apr 2024 01:23:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Apr 2024 01:23:07 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 29 Apr 2024 01:23:06 -0700
Date: Mon, 29 Apr 2024 08:23:05 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phylink: add debug print for empty
 posssible_interfaces
Message-ID: <20240429082305.fjqjsoaykhbdd7m5@DEN-DL-M70577>
References: <E1s15rq-00AHye-22@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <E1s15rq-00AHye-22@rmk-PC.armlinux.org.uk>

> Add a debugging print in phylink_validate_phy() when we detect that the
> PHY has not supplied a possible_interfaces bitmap.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com> 

