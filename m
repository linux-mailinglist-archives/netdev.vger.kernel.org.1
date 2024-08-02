Return-Path: <netdev+bounces-115402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78953946356
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 20:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3309E2830EE
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F91547C9;
	Fri,  2 Aug 2024 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV45IUAw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4E1ABEA3
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624323; cv=none; b=TJjPyKZPDR+88WKBziXzlJuvxflLdWbKJlK4fTw4Q4DaZaI5iIqcTNdxcz3Q08qBcNeQdmcdh2CH6Jrs4zN2M8P3A/Sqe7eKEIOfKehAv7U7LyXu3nvjL9eX0hlJ3cZwmcziAskr8JhnTcg8IT0WUWZ59oJm/dmpUic3p0RlvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624323; c=relaxed/simple;
	bh=6VbM1xTfuy9x8nDg6/hr/99c0BITQcVEab1BgICHmjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUtc8hPHkvQPkxShzQxztU4zXwOnLIbN76vMEDNPWcVx0ywQjTe5WqNCJ7WlfnaE4BKouoR8bjMW+iy+xFMziW7BSzcjDMKu2xlDqXh9DMVdulPK9HFvg5gk3U5eOFU5/OXAI9S/hXebB0AVeHandX2c0FuDXP+MDbfJoxfNLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV45IUAw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722624319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9JQ2Bf0SWejaUXaO1CuoWG99+H3ynJpTMEOSBOBAU8=;
	b=FV45IUAwD8WubsDylMxR8c0XFfn49ELblSYswLBieXzaoXcJkbHjeHKTwnId8RxgpJyB56
	AeV5ZT32hzOXS6wyllKA5aKuiRwr92RuAIh7uSzsyk5FCY9SdkBGRww+RVl+g1fw8H5TUf
	UlacApqnMvqd62cGskYGfahp81V2qZI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-TR3LQSi5O_ypKCkVspheTQ-1; Fri, 02 Aug 2024 14:45:18 -0400
X-MC-Unique: TR3LQSi5O_ypKCkVspheTQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44ff196bbfaso101901061cf.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 11:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624318; x=1723229118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9JQ2Bf0SWejaUXaO1CuoWG99+H3ynJpTMEOSBOBAU8=;
        b=b7D/t4Z5pQT183g9H/U+KbI3ghZYk6Sh4aDqMhjhQvN9KoVcgPJhVStaB6rOEDuLvP
         5vcF9yvrh1pMinSDuHImfwVjQ1d1GnBiDd9i/yACnEz+pbKC+Zx8S6cY+Wr3FcAwLfwh
         Y3gC5VdzeNLuAd1TCWQ+vepmDzz9hKet/IpEhJBF/qZJyvBqhAdJ+4oj0/9M49sh11C4
         9YEX/epAdA3xjghLqMK5JGmolNYPO1gV8ChKXM5F/1YxzbuOyvqy5CKpv0ZaP+8H6y2j
         Yw8LeomMZ+wnwwbc+fBf0un/erJIBqaA/mLp3XmQ21GB3rWkTm+lBGUNOZyRCRWFXHIm
         SXVA==
X-Forwarded-Encrypted: i=1; AJvYcCXpMo/X+DLc/l9eeSElTtqoawJNtvLBkkKYwFmDIDbEsa8zWebicZ1NOKb3zDnV4AAFgeQIHXR7B/KSstfIGh9YhSguQ3hX
X-Gm-Message-State: AOJu0YyRwVL6So7kLobgduMdquxql3pKgmQ0J97AoeWEFrJ57LCFOpKQ
	jR04QKhS5VlgC1EW9YjXqVXiBnAEHKjG+xk97AUyPR4gvEY7MIQw9SGJ4XvikRzCSr9Zk0DxB28
	pb7PCaePi/7sCjajSVNoCs7+mMPuzH5fnWp4RrDv15aoHokcHjXIRbA==
X-Received: by 2002:ac8:7fc4:0:b0:447:ee02:220 with SMTP id d75a77b69052e-451892ad6a7mr52630231cf.30.1722624317894;
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwPo418K/j4TSG5frJ/PeeWs9ccUUjf6b01FC1y1GFDXNXPuzIYaN0JC6zJzw9tCN9/UwJA==
X-Received: by 2002:ac8:7fc4:0:b0:447:ee02:220 with SMTP id d75a77b69052e-451892ad6a7mr52629981cf.30.1722624317602;
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a757920sm9405371cf.67.2024.08.02.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:45:14 -0500
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
Subject: Re: [PATCH net-next 10/14] net: stmmac: move dwmac_ctrl_ane() into
 stmmac_pcs.c
Message-ID: <4t4wd6bv3gzyzc4nbbszydnagvzgynluy2rb6jtfjxtidrmoqh@62cs3wx52pob>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpob-000eHh-4p@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpob-000eHh-4p@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:47:17AM GMT, Russell King (Oracle) wrote:
> Move dwmac_ctrl_ane() into stmmac_pcs.c, changing its arguments to take
> the stmmac_priv structure. Update it to use the previously provided
> __dwmac_ctrl_ane() function, which makes use of the stmmac_pcs struct
> and thus does not require passing the PCS base address offset.
> 
> This removes the core-specific functions, instead pointing the method
> at the generic method in stmmac_pcs.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>


