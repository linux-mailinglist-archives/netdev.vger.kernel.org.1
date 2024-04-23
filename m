Return-Path: <netdev+bounces-90487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA31B8AE3E7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6831282495
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315657C6DF;
	Tue, 23 Apr 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2rIPabPh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAF281AAA
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871775; cv=none; b=vDqBekXZT8DPvNre1YdGM+Wm570RCFzTPH7mRls+1zFgiaFNHHMh/W29SMlsP21ShfedBEUVVKw5Cm6KLHWHtH3NJmlVz3jiqq09py5jal0crM/wYEYG39Ak0EoLWj/whoYdR6T4fkFeO8RJ2+vsuTBOBzI7i6gBSiOki0e+NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871775; c=relaxed/simple;
	bh=mFXN2edjnM2qe5cHXA0AHOBUc0ToWeeiy+s7Bn/TCvA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9QVDZnJojOiN2RTKEYb8jVXjPeyFziMnre5z+NvBRkFNS4ZhJaiX9tR7FERSwUQ/LQkWMczGVQIQik3Q/DBPK8SuQ9j2VV9xP0OL3Vtrt7CQKIWKwkWsBOSP6x1+rvLRw8STCY3d5juccQwYup2AUgP7qkqSJkvYlU6edIigKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2rIPabPh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1713871773; x=1745407773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mFXN2edjnM2qe5cHXA0AHOBUc0ToWeeiy+s7Bn/TCvA=;
  b=2rIPabPhZuQpGSpNTSdNeZN2UwrOn7BUFQU9VopHtGVpiKgsiOP4aKf3
   eB13vC8/69I2UVfrqEIvLDXhkfDKTL66qe+Mwo0FBTwwL0sWc8Ylu/+BK
   iw5CK8j0LiYWI02lBGJiDhpIgtOensfy2QO0QsLmXbrU7r+w54rk4+msE
   0Ag1/yLwYzgYVtJe4EZmRWkecD15Lg6/PgZ58OofuVuavBcSwk49YSoLm
   TDvwxYTSWmvw2fzyrA7Ewp+sZLM7NFdH5R1J3qZ4RJiq1SE2rojmslWcd
   WgUKnGriBUb8L2uNxW8NyzmPJFhwIL3zLsDSz7QxTFU5AOzNzUuzTdXtg
   g==;
X-CSE-ConnectionGUID: 27LrOb8JR+S9XmqCg/RY/Q==
X-CSE-MsgGUID: BW5xDyjURI+/KYfiMSO/Hg==
X-IronPort-AV: E=Sophos;i="6.07,222,1708412400"; 
   d="scan'208";a="189585239"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Apr 2024 04:29:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 04:29:18 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 23 Apr 2024 04:29:15 -0700
Date: Tue, 23 Apr 2024 11:29:15 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Simon Horman <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Bryan Whitehead <bryan.whitehead@microchip.com>,
	"Richard Cochran" <richardcochran@gmail.com>, Horatiu Vultur
	<horatiu.vultur@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next 4/4] net: sparx5: Correct spelling in comments
Message-ID: <20240423112915.5cmqvmvwfwutahky@DEN-DL-M70577>
References: <20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org>
 <20240419-lan743x-confirm-v1-4-2a087617a3e5@kernel.org>
 <20240420192424.42z2aztt73grdvsj@DEN-DL-M70577>
 <20240422105756.GC42092@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422105756.GC42092@kernel.org>

> > Hi Simon,
> >
> > > -/* Convert validation error code into tc extact error message */
> > > +/* Convert validation error code into tc exact error message */
> >
> > This seems wrong. I bet it refers to the 'netlink_ext_ack' struct. So
> > the fix should be 'extack' instead.
> >
> > >  void vcap_set_tc_exterr(struct flow_cls_offload *fco, struct vcap_rule *vrule)
> > >  {
> > >         switch (vrule->exterr) {
> > > diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > index 56874f2adbba..d6c3e90745a7 100644
> > > --- a/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > +++ b/drivers/net/ethernet/microchip/vcap/vcap_api_client.h
> > > @@ -238,7 +238,7 @@ const struct vcap_set *vcap_keyfieldset(struct vcap_control *vctrl,
> > >  /* Copy to host byte order */
> > >  void vcap_netbytes_copy(u8 *dst, u8 *src, int count);
> > >
> > > -/* Convert validation error code into tc extact error message */
> > > +/* Convert validation error code into tc exact error message */
> >
> > Same here.
> 
> Thanks Daniel,
> 
> Silly me. I'll drop these changes in v2.

No reason to drop them just change it to 'extack' :-)

/Daniel

