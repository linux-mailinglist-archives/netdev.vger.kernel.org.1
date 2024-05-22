Return-Path: <netdev+bounces-97556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE38CC248
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD081F243F1
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D414039E;
	Wed, 22 May 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DhfVII0i"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9514037D;
	Wed, 22 May 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716385213; cv=none; b=JjinZMxZ9fzdPKAPsJvfOvonqSC1iK09Ktpk/5foK+BN21mwD2ZJT7jhXIZiIeMS9BIkHGUw0CLErcfjE5YbuNdtXtojmyFb1d/d7qVQQmzMg9H74MFsRMuXjP7v51vcSifnsjAE2Sy9ELhE9bQpJZi0cBltbRrcEwMLMRrqMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716385213; c=relaxed/simple;
	bh=KlcfgZBOLuLi9UUyHSlAq0UwDQgF6FqjZB64J+brl1U=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihmEwwb+ee43hG8zx747uOQWoTH6i6qF88oqD71F5MSvA+J47o0Rc+AU2zPDvtCP63UkpIFgx/5Ae415j65/Dtg3XSFPMVNFdwamUcxXHbeMgz5gS7/mFyw3AhMvP5qbfU5rA3sB6Q1gdqfGrH1sL9sytUqIr9eP/B18nR2j7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DhfVII0i; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44MDe1Co116757;
	Wed, 22 May 2024 08:40:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716385201;
	bh=156ErfcH2Ob6eWxrQ7Lwe485QGxB7cdVxE6jta+DSgo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=DhfVII0iLK0gq+ozg5PPwd/mDyAosw6OPZ9sTL7PieLseF7ZPPiTyXnaZmZSXWskI
	 KPA4rPF+pJNUp/JiIfNB5yg+jCDMtIz+lL+sM4FbXyUbdwQpd8hLDwoPmpv7JBxpf5
	 QcfjEwj1ovtlrLNnCqq7yjXBZB2FFONaw1ODEOBg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44MDe13j016785
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:40:01 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 08:40:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 08:40:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44MDe1Q8022418;
	Wed, 22 May 2024 08:40:01 -0500
Date: Wed, 22 May 2024 08:40:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        "Kumar,
 Udit" <u-kumar1@ti.com>, <vigneshr@ti.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kip Broadhurst
	<kbroadhurst@ti.com>, <w.egorov@phytec.de>
Subject: Re: [PATCH] dt-bindings: net: dp8386x: Add MIT license along with
 GPL-2.0
Message-ID: <20240522134001.tjgvzglufwmi3k75@imitate>
References: <20240517104226.3395480-1-u-kumar1@ti.com>
 <20240517-poster-purplish-9b356ce30248@spud>
 <20240517-fastball-stable-9332cae850ea@spud>
 <8e56ea52-9e58-4291-8f7f-4721dd74c72f@ti.com>
 <20240520-discard-fanatic-f8e686a4faad@spud>
 <20240520201807.GA1410789-robh@kernel.org>
 <e257de5f54d361da692820f72048ed06a8673380.camel@redhat.com>
 <20240522-vanquish-twirl-4f767578ee8d@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522-vanquish-twirl-4f767578ee8d@spud>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 11:25-20240522, Conor Dooley wrote:
> On Wed, May 22, 2024 at 10:04:39AM +0200, Paolo Abeni wrote:
> > On Mon, 2024-05-20 at 15:18 -0500, Rob Herring wrote:
> > > On Mon, May 20, 2024 at 06:17:52PM +0100, Conor Dooley wrote:
> > > > On Sat, May 18, 2024 at 02:18:55PM +0530, Kumar, Udit wrote:
> > > > > Hi Conor
> > > > > 
> > > > > On 5/17/2024 8:11 PM, Conor Dooley wrote:
> > > > > > On Fri, May 17, 2024 at 03:39:20PM +0100, Conor Dooley wrote:
> > > > > > > On Fri, May 17, 2024 at 04:12:26PM +0530, Udit Kumar wrote:
> > > > > > > > Modify license to include dual licensing as GPL-2.0-only OR MIT
> > > > > > > > license for TI specific phy header files. This allows for Linux
> > > > > > > > kernel files to be used in other Operating System ecosystems
> > > > > > > > such as Zephyr or FreeBSD.
> > > > > > > What's wrong with BSD-2-Clause, why not use that?
> > > > > > I cut myself off, I meant to say:
> > > > > > What's wrong with BSD-2-Clause, the standard dual license for
> > > > > > bindings, why not use that?
> > > > > 
> > > > > want to be inline with License of top level DTS, which is including this
> > > > > header file
> > > > 
> > > > Unless there's a specific reason to use MIT (like your legal won't even
> > > > allow you to use BSD-2-Clause) then please just use the normal license
> > > > for bindings here.
> > > 
> > > Aligning with the DTS files is enough reason for me as that's where 
> > > these files are used. If you need to pick a permissive license for both, 
> > > then yes, use BSD-2-Clause. Better yet, ask your lawyer.
> > 
> > Conor would you agree with Rob? - my take is that he is ok with this
> > patch.
> 
> I don't think whether or not I agree matters, Rob said it's fine so it's
> fine.

Just to close the loop here: Udit pointed me to this thread and having
gone through this already[1] with internal TI teams, the feedback we
have gotten from our licensing team (including legal) is to go with
GPL2 or MIT. BSD (2 and 3 clauses) were considered, but due to varied
reasons, dropped.

That said, Udit, since you are touching this, please update in the next
revision:
Copyright:   (C) 2015-2024 Texas Instruments, Inc.
 to
Copyright (C) 2015-2024 Texas Instruments Incorporated - https://www.ti.com/

[1] https://serenity.dal.design.ti.com/lore/linux-patch-review/20240109231804.3879513-1-nm@ti.com/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

