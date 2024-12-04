Return-Path: <netdev+bounces-148738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8169E305B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 01:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A77164583
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 00:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AA1372;
	Wed,  4 Dec 2024 00:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LuaG3TYp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011B1624
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271924; cv=none; b=uLG5D4lAd8ouXKvZlVfsF/b2syeO0In+UDDLiSAmsxeIyWwAI4On+3JNOZc3NOWB4FzInpkIE9NTpvqlErcgtV1TbmldaAaRfko5Ir5MGWdLiPK3bURyFRbPMrhzYJN0aLtLon6DwBDUTY5VrNpzzDw5/dbdJYSoh34gQmAkXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271924; c=relaxed/simple;
	bh=Lo4binRsBPqUS9D7ps9nWAoRIkP/rPdP6eMaYI/rZXk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cv3cgBcTdoY5J3V2ZGjOpx+AqA256/9Hef1vUD2oLqoO4G5gy50zaJntbuY1IAQktXrGLSvrSZagwfK6dZCDLHGhjH1q3LORNkSUNZdogsudiI0kR71dZDn5w+4Sk9eIy35Bc3gQsNw27ij06vlNaX+Q7D4fqC+tfe/INn9cmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LuaG3TYp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733271921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
	b=LuaG3TYp3iF/yJZR4o8bum+Z5aUQNXQ7shPi8N9w2X8TMbYRmL2DodBog4LF/TX5cpSREr
	D8JBh5Jmht9ux1VeHfs/smtQGyX8PZrs2gl4me06UazD7Ar+UtV72YzP2BXlFqd8KnYJp6
	Zi191z5zLrZiAy05YBEaqP4wZMX1csk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-B5l8t4n6O6qEbcXnFCADNA-1; Tue, 03 Dec 2024 19:25:20 -0500
X-MC-Unique: B5l8t4n6O6qEbcXnFCADNA-1
X-Mimecast-MFC-AGG-ID: B5l8t4n6O6qEbcXnFCADNA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d88cde9cedso64499946d6.2
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733271920; x=1733876720;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CwFWi8FnvUArl8TpMTnNDME1h0hBhCfwwVFx5ADtG4=;
        b=b/Q4zxqqJHd7Q9vt5L6O3hP9j39irz0iXO32qqBMpoZ8ojSgab4Ezfa5qejh90u4Uv
         Ff/yKFc5n3cIRUvbHgdGzoBw3hb9BBa1nRa7f9NrogBegIp9SPePVnVZ7apD1QP6pS58
         Ifnk2Ijx1luEVNNwDmt7pcgsLjMKlmrgbGp3C7uOXFBMVvBCiW7grWh3DiVciPc2v6IX
         GPk42evuj9SS3JxnkIOQtq6A5uUuBazi8zOsH9B7j3YEexRORkVcI32IuKSqW1kzYhdc
         QIjWr1LLEvG4YjAv16nGeVX3peA6VdPZnXNA5Zdv6BdH0bO0HeT8oxMRxZhQxsr1lY5d
         A9Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVMdadViXgYPRX0JaW5QE4kj67yepmqyVLuZT1Yt7oWFgVf+PHIvFRG1n1ntY5shj9cXI6XyCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkkzC56bYe9gDrlDrV9x3TeHNllDz+zam9ZhL1FgCkAuW/LCb
	MqXF1MFOzrlz2nI3jFTceZFK5trny70fE2Gk54h0gBJ/d5D1T2kLq8Piz5kJ54rc2y3jF+r1IMa
	nX+GjcKNa2KyKL8vHkT2pJIdlBA3Ook5VzqN7tP2JgD4DLC+hhwKpPA==
X-Gm-Gg: ASbGnct58gMRw8isOIKSrk29mPbcrWfuNXPZIUgjOLrGh4uTMFG2ue+patl8y57M9DC
	eMbxJAHbQwoW8z7fUG1fdcP/SV9NVpGcqY9qzvwAsVsLHQHb+eVAxOSvtaLoRUSIERCInF/BU8M
	KeiHOSZ1MHx/fSlmi4LPBuXTkTBdB0XCnIbHo+zMfezU4raDI8D0DxUQacj8eYnPPAPFN/LPkr1
	EJC25vI/FqTOZVzOUrB3ckcPgXzk7GGIxj61MkQb9PfHvyVXg==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495476d6.28.1733271920429;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoezrTh1LfZQDXek3/OWCukqKJgO2GNowhr0mwrxAz8KSLIusKbWlk8PbDDhkEiuliYGIwDw==
X-Received: by 2002:ad4:5c88:0:b0:6d8:9002:bdd4 with SMTP id 6a1803df08f44-6d8b73c3e99mr89495216d6.28.1733271920141;
        Tue, 03 Dec 2024 16:25:20 -0800 (PST)
Received: from starship ([2607:fea8:fc01:8d8d:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89ef77c12sm37422936d6.81.2024.12.03.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 16:25:19 -0800 (PST)
Message-ID: <5bc32310f882c45d8713e324dd30cc1ca41ed20a.camel@redhat.com>
Subject: Re: [PATCH] net: mana: Fix memory leak in mana_gd_setup_irqs
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Simon Horman <horms@kernel.org>, Michael Kelley <mhklinux@outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Yury Norov <yury.norov@gmail.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Eric Dumazet <edumazet@google.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Long Li
 <longli@microsoft.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Leon Romanovsky <leon@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Souradeep
 Chakrabarti <schakrabarti@linux.microsoft.com>, Dexuan Cui
 <decui@microsoft.com>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Tue, 03 Dec 2024 19:25:17 -0500
In-Reply-To: <20241203162107.GF9361@kernel.org>
References: <20241128194300.87605-1-mlevitsk@redhat.com>
	 <SN6PR02MB4157DBBACA455AC00A24EA08D4292@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <20241203162107.GF9361@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-12-03 at 16:21 +0000, Simon Horman wrote:
> On Thu, Nov 28, 2024 at 09:49:35PM +0000, Michael Kelley wrote:
> > From: Maxim Levitsky <mlevitsk@redhat.com> Sent: Thursday, November 28, 2024 11:43 AM
> > > Commit 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > added memory allocation in mana_gd_setup_irqs of 'irqs' but the code
> > > doesn't free this temporary array in the success path.
> > > 
> > > This was caught by kmemleak.
> > > 
> > > Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  drivers/net/ethernet/microsoft/mana/gdma_main.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > index e97af7ac2bb2..aba188f9f10f 100644
> > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > @@ -1375,6 +1375,7 @@ static int mana_gd_setup_irqs(struct pci_dev *pdev)
> > >  	gc->max_num_msix = nvec;
> > >  	gc->num_msix_usable = nvec;
> > >  	cpus_read_unlock();
> > > +	kfree(irqs);
> > >  	return 0;
> > > 
> > >  free_irq:
> > 
> > FWIW, there's a related error path leak. If the kcalloc() to populate
> > gc->irq_contexts fails, the irqs array is not freed. Probably could
> > extend this patch to fix that leak as well.
> 
> Yes, as that problem also appears to be introduced by the cited commit
> I agree it would be good to fix them both in one patch.
> 
I'll send a v2 tomorrow. Thanks for the review!

Best regards,
	Maxim Levitsky


