Return-Path: <netdev+bounces-144834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB699C882C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744B21F214B9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31F81F80D2;
	Thu, 14 Nov 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Q5PmjgSV"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6675D192D9D
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581808; cv=none; b=pHms4b3N4g2kubaEh7s6nw/kp2mF+zAf/008OSKkycVLghI4+ZyPVme4XzZ6JySPnBgkwtHX7sEBttpQ2YA5aZqQAcxbhNa+31WtEgn0ZhoIQOSOxJ0bULMpqRpVHBsvMOH6Ktofi6jLdLtAEZ0CPQBiJRhscKbYvXwWqQzVuD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581808; c=relaxed/simple;
	bh=imaDGf/PK1SyZfgX7cIqPnhfJmOuBvFbIkKeTzSRmjw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFXWWbJL7Rdk4jxD1xJGKqqzYUqS01HKYv1IysQN9NRT/jlG1owVHgqIyl1mBAkedzE6ikHqd+qDsO27BwnmomiMTlSMObuantZnSc9eSRLtdKbnkz595d3ObGJQDgDNGyeXkPzvGMglWSo4/XN8cGqnsD9+8DoXkiDoaVLp0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Q5PmjgSV; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8C24B20826;
	Thu, 14 Nov 2024 11:56:44 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rXKZdpdhqe4I; Thu, 14 Nov 2024 11:56:44 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 152D9207A4;
	Thu, 14 Nov 2024 11:56:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 152D9207A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1731581804;
	bh=HaRlSh0TdUUult6VHhUaQ9IIC2yob7BWdLYb0ArkxSM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Q5PmjgSVN3WvkpMFDHcwyAwRdWAWVBxrhLshSvyfcQCXs82swvKPFL7J+DXdiWFcg
	 5vRBAsZ4ytESlixc5Jjw6wJpfeRiXYGa/wlA9KgphxaYTcn8tZ5c28KQrlNnYLkJa+
	 pUx1DpgyCZVxAADxWJLOm3lz4g4jOBnFVandDiEs/rIuEzwe/HT4emc1Fov4EeyyMy
	 dj2ONw0Kqjhw7DP1L1avfk3GNE6CcZ/oPgc3QFNU0t5rBCl5JTapoz+3G+04mE6yfT
	 AcNZtz7nwhnDzkwTvN8yHZTGyyZX+Xr2VnHP4RN0sq7mWwf01d23SePvtW0BXxm3Ha
	 /vkqbFihccipw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 14 Nov 2024 11:56:43 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 11:56:43 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6818E3182B52; Thu, 14 Nov 2024 11:56:43 +0100 (CET)
Date: Thu, 14 Nov 2024 11:56:43 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [bug report] xfrm: Cache used outbound xfrm states at the policy.
Message-ID: <ZzXXayCCZ2zV4f1u@gauss3.secunet.de>
References: <d8659bc6-d8a7-4fc4-9b6b-39c80b24a9c8@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d8659bc6-d8a7-4fc4-9b6b-39c80b24a9c8@stanley.mountain>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Nov 12, 2024 at 01:24:08PM +0300, Dan Carpenter wrote:
...
>     1468                 if (km_query(x, tmpl, pol) == 0) {
>     1469                         spin_lock_bh(&net->xfrm.xfrm_state_lock);
>     1470                         x->km.state = XFRM_STATE_ACQ;
>     1471                         x->dir = XFRM_SA_DIR_OUT;
>     1472                         list_add(&x->km.all, &net->xfrm.state_all);
> --> 1473                         XFRM_STATE_INSERT(bydst, &x->bydst,
>     1474                                           net->xfrm.state_bydst + h,
>                                                                            ^
> Potentially uninitialized?

A new goto jumped over the initialization of 'h'.

I'll initialize it now explicitly before we use it here.

Thanks for the report!


