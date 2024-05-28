Return-Path: <netdev+bounces-98767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7D18D260F
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905C21F258AA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5017A924;
	Tue, 28 May 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XODR3FiS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CB17967C
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928836; cv=none; b=o5V9QIFL4+gxhT9y9e1cbSkj1A/W3WSineWCPmiSaeqCRCsEVrzYmyopHBBrjVNEMyu8HPDkOLFxCT/FaEAVlr+SHwc+kwRpIGJcfutBIJuUN2fopuJTd5DDkLF+b8ei2YW0CQg3pevZSCUX0oHEvYLZ7zE4kO9AkrWD/GqQk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928836; c=relaxed/simple;
	bh=veABqGxTtnR74Fa22wOcOwdV8vy+pRgrA2LiuBvQUJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd9JmD9yXDvKu+8n2OkXdPn/tIRFfdZyhB3Uhu2p1Bn7dvGdb/59TJbdNnFv5i3epjtN7H2+zc+MxICi26UxTQDs95G2sNzeeSAeY4YwRodFxOBV7hqZWYExrcqg2yK3PukHSYOOu9ihqdbdnWe+q0IOq2dOSqEv/tPJK8uMHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XODR3FiS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716928833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yza5SyI0JcR/p8dmMKdorJ+VfFJ4YAQqKl442JnCtPg=;
	b=XODR3FiSoxys/5SMElHhYadBDdz/zXeNcD4tBb9Phv5XnRg9OX9ynN9qtezBqjv+FisFXQ
	Fozwa0FSqVU+U6fI0yTYJqUS6HvHJ+hXdiENJvrRlGLZkuutMB+0HYisybdNmX9rdEVzVk
	SODQj8wx3baVnvVdEUlhD6Wnc/9mzBA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-fTYD84VpMOyAtStcHliGwg-1; Tue, 28 May 2024 16:40:32 -0400
X-MC-Unique: fTYD84VpMOyAtStcHliGwg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ad7afb37dcso11937106d6.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928831; x=1717533631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yza5SyI0JcR/p8dmMKdorJ+VfFJ4YAQqKl442JnCtPg=;
        b=q2unYKk2Bd2VWEHzobf4kg+SmzARe5lczLqigAfmF1qwfxOHMD0tOoygpsbsovG0G+
         qan/fbzBLaU4Q+qlHqvqQvhh6SD0JOHeC0D7bER4lSw3SdHJYKIrTxvWFlcl8GdQQUVv
         RX0jdoVpO9n4kjuMEBeuz90CZNfzhKUZiAbnJVJGB0K1l1y2ZiksoOLS4pNZ2jjjLw9x
         HxWhYDczUQQjooaJl2vxYg6NlkJdMFrIW5xPT925YKuZz5P6uKchPBlj69nKVv3jgCdJ
         NHIPlE3jR5SvCmPai8/XpT8OkSd7a6uZAusjKtGbkv/PKGviMjl8WxV9ToPmCj7ZdkyD
         R/ow==
X-Forwarded-Encrypted: i=1; AJvYcCXpZFktDuyoN5dF3lTyKIVpR7HbK8qkMoACMQoTt9jOSZXzFF3a8GCFlDyTmsuJCVFFzeUpMHe0YofvxUidMfey2yYAM6l2
X-Gm-Message-State: AOJu0Ywr+UmKzA7EIYkAFPUpEOth+jve0+n/SIRubsElAj8MkEHmcPNn
	mgfxPxEaYhqKGZUCyX8vRTvOXTFXmgv0dCAb0UZv3BZAjAKOGJDkDy8KPe7Oo+yNAZyky58ntMN
	mDtZ5bs1NfXf/Po1yVjkGWLNiOEpI5zdlo4S/Ucisx+dLDvNBz+xKNg==
X-Received: by 2002:a05:6214:448c:b0:6ad:6edb:117e with SMTP id 6a1803df08f44-6ad6edb11bfmr104427636d6.12.1716928831091;
        Tue, 28 May 2024 13:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzoWdZfNI8wbyhQKj1g5pxOdHs/HarNkz6GuK6rmnxVca+HbJtoShkbsmQe8qICoUxeM40SA==
X-Received: by 2002:a05:6214:448c:b0:6ad:6edb:117e with SMTP id 6a1803df08f44-6ad6edb11bfmr104427476d6.12.1716928830711;
        Tue, 28 May 2024 13:40:30 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad83d33667sm20394086d6.107.2024.05.28.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:40:30 -0700 (PDT)
Date: Tue, 28 May 2024 15:40:28 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 3/5] net: stmmac: remove pcs_rane() method
Message-ID: <uvmwew5cusmghnnm3hc4gnrf4rfdbcliujuo2qwwewcwzlqs4x@fjybiwwljr4b>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvJw-00EHyc-0Z@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sBvJw-00EHyc-0Z@rmk-PC.armlinux.org.uk>

On Tue, May 28, 2024 at 12:48:48PM GMT, Russell King (Oracle) wrote:
> The pcs_rane() method is not called, so lets just remove this
> redundant code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


