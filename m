Return-Path: <netdev+bounces-115399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E204C9462CE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAE91F2159C
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215AC2837A;
	Fri,  2 Aug 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek60RuF/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07E1AE050
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 18:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621672; cv=none; b=pO7GvYzjjaZDk2YpS/ZnfORJCVNFcqPhO12vPYfor0ON4MRffpGiIBovbdSSbKJkrUL/b9MhIApiEiE0EmLdkr1YkXdgvH3SOfsxzvxrD6MRy4+Q1PbcmeYwaJ3qaLxzENh/w2rNd6Q+r1rL5+Wn6WAsZLVoIIqyd+XZTV/nxEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621672; c=relaxed/simple;
	bh=NwqwjZ1ZkmCR5L3cE68C/lUHncA4QY/rihu4kv5E3Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egV+S6T7kpOPrIMCDaxrJNmEU3s4beX4YBZU+PWbibVn98qDcpJ6W2B6Cq/CAPlcWYTorn0iufS56Hsitp+YMEIF5FrpmoWvYuKwzxDAzZuaNaeZ32KvJZwO/bW0MRHh8Kd6NHXGNZpvnyS9lSI8XJdhYrMACrBZnnBybqE0Ue4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek60RuF/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722621669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTfFpaLZUbOaQ0HJhEjOqrkLc8CExWlF+kJqRyqPAo=;
	b=Ek60RuF/LgWh/BQpNK2GhOr2Jj2aYBjbVE8xweClLQOK8x+UNpuVSpZV+8mVPeNY/tLuYm
	frou8eqsWDCYutwLqBUs+viquVlPle6JZ/Rr/8NhrVa9SqoE2IrYJdDhWdKcwvvcp6ugS/
	coZFKDbemeGsLd4NJAhup/CaUDpGg58=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-l4V9Y3ZROviQlgWd-HGzJA-1; Fri, 02 Aug 2024 14:01:08 -0400
X-MC-Unique: l4V9Y3ZROviQlgWd-HGzJA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d4238d65so959149885a.0
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 11:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621668; x=1723226468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVTfFpaLZUbOaQ0HJhEjOqrkLc8CExWlF+kJqRyqPAo=;
        b=njzTZzg6VKpiDLrhq2XbEK6PrrtVS/W0xmBPspFus6RqWkQg70oYbRWb+Uj9QEwFHf
         1rPZ4zjBwtxIDo2s025+mcgTXZSJFlVl9kJnKyvmHZZkpuAsZFLUp0RImqS03nPzOX4t
         9ktANBJkI/X+ZGUmlPEHxtzfSvyY9vkL06ct8NQV5HYi3jCGbtk1MuJ4zPdbqrh3VopQ
         jQyRWm2zzUuHUv0pUZ+ALYBK8j78VGX2MSIWDAIPTsQZFuP+nYmhZ2cRAdOyAXrjTdiA
         CMr3Kzt236inmf99gBebuSL4oyMEcXUzf5/J3Q+FmMxDgMIFipVwXjuC3CcFvQ6cfTCi
         vceQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmuQfo7WvdJN8QVnVvznXA9SVfxbpQdYiKaGq+wKWNsQNH6eTO9YsRWujh9pXhcCnWcQGESTGO1Okiz8gs4Aeh21s+cmoD
X-Gm-Message-State: AOJu0YwD/8YSF+Q36792PVzt2U2wCFIdwKjirWrHKOp0/UbWC94yCo7k
	9iotU7KxkqMD2Dj++pkSl4YMODl5cZ1FKnjujbhuQA2pd7jbvlVpV6H6h9wLDvFKWv1BYUQ070I
	gX/jL3QSl5pAI4b/QoHPckg4pGL0+Wj9/2AWQ6/prV7+q/yGhLwL7AQ==
X-Received: by 2002:a05:620a:46a4:b0:79f:735:4cfd with SMTP id af79cd13be357-7a34efaeea7mr554500385a.50.1722621667653;
        Fri, 02 Aug 2024 11:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJErAfbeHi7Cr/9xQl9lT7goXT1BrY20xVWa1C2WQla2ME5KtsJNYLix6zqIYtiFu1FmZog==
X-Received: by 2002:a05:620a:46a4:b0:79f:735:4cfd with SMTP id af79cd13be357-7a34efaeea7mr554496585a.50.1722621667225;
        Fri, 02 Aug 2024 11:01:07 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dca50sm107699185a.16.2024.08.02.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:01:06 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:01:04 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 02/14] net: stmmac: replace ioaddr with
 stmmac_priv for pcs_set_ane() method
Message-ID: <idusdyewthu5q4j7awi3rc77ncdolt27ppq2pknrbynaobgztc@3xvnkeqml2bd>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpnw-000eGw-2F@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpnw-000eGw-2F@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:36AM GMT, Russell King (Oracle) wrote:
> Pass the stmmac_priv structure into the pcs_set_ane() MAC method rather
> than having callers dereferencing this structure for the IO address.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


