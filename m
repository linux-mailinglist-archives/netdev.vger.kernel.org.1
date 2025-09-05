Return-Path: <netdev+bounces-220370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43CFB45A01
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CAC21C26421
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA7735FC2C;
	Fri,  5 Sep 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W44rYqP9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A31D79BE
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080948; cv=none; b=RWSjN1QIOMPp+qGuv962YukklVF4zCCFqUVnzhWqX4Q3qCzJJmAEPnXU5VrKiqi7wgOXVIvb+iNFEi2uLU8Noblz6+f7EWr+jRKNntoDt9IH6rRsQh1SofbX580lkCIpS/ah65mepPan3Iw89i9V7FOg+UqgWaj3YP8mTiqIdss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080948; c=relaxed/simple;
	bh=yGBymGwumJV51DZsAN4JFHDYp0fSEWwlKrHyzeM0LuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARoWX8bz/dkwnqR248ynJ5BBiTxrLnuPKQDjcHW1QgVzp3kcLbk6aw8dDlj3EoFbTitN3M694rwxVAyjG0nHepIYzlOW4sSply5hFI7dYIS5GHBFdQ1dDm6uTb2MdmOilEhyDhaqUbat8XqmdmNnpGu79pGklIuuwGTig2TChnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W44rYqP9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757080946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7hHWvvCpj+Eva3UbhaHhL1SoxFvZsWk18fQWBXIJ0/g=;
	b=W44rYqP94T3rXFOfWdUbQwiOnz+yEMCmHsApl9F+lTnAwKdGM2yWVBGZQlaMNsX9GLJAUR
	cBvE7voCBbUta6n7rSWhhmg0KB9nJqmzHWuPqwN6iGVi+CzTrQqS484dVfAcYZbAcj+kw9
	+gAbFRXua99PWITvwMaVhuwOI0QDgM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-xe2yywkXNniVZbF6tXuSHQ-1; Fri, 05 Sep 2025 10:02:19 -0400
X-MC-Unique: xe2yywkXNniVZbF6tXuSHQ-1
X-Mimecast-MFC-AGG-ID: xe2yywkXNniVZbF6tXuSHQ_1757080939
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso14381585e9.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 07:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757080939; x=1757685739;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7hHWvvCpj+Eva3UbhaHhL1SoxFvZsWk18fQWBXIJ0/g=;
        b=mBHT2Iz+btcFKa7hUVHmU5VIBYt94+k7pZR7FjwZOIRLZL8MC3xNGHJ8W7pT4gUeNz
         DVKDrpHGAagNWWbufJ+mAE/f8vR80hSvjZ3LP3zc2cNecYG4TxYUuFSrIY0Vyq4ZJW7s
         VzAZKBwQoL3HUYOyWldA05uADGb0kEst5lyqTmPd3/LEoz5ghoCm3qmWRlgaxOkK9GYL
         MXuKPrOR3bFwZCSFgQTbsg+PN9LxU2+1HhSwfHFJLQ/Y9WorwCfMegriTgHouAg5M3Hz
         iv9dyhWZ04w8TV/hoYgU8qrpztnWwK8Qweq4C6Z17cEc3NFmhG4WGDfMBlYW6PwLeQHm
         vsrA==
X-Forwarded-Encrypted: i=1; AJvYcCVQO8TZoA9kHizWcka7G2TemZNGqaPBGMlYVjVbc4j+koph/twy//+nW8DAANDkNdBFl2tQYjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6HkGzEEz6wbi/Jkpci77jj/odr5Lm0spxZsrstugfYNM7flc
	HW1tUXo+Nytk4Y9MQuikyOvvJ8tb6+mOi/6pr8V/wmjDwZazK/8+A9IxNOqzOIKbmjAuB+x8Ax0
	fnZsFZEdzdscrUG1cR631NW9zgDu/h3O84RTz/Hf9aV4c7HjoW+MM//wuEQ==
X-Gm-Gg: ASbGncuGzjygzXC3WJ17iuiPuJG5rVoegbdpHpXRt4BnHvlxY2b6nbQ6zzrbqeaV2bN
	/fljyCdY+eCg3/5FECXbz2tb1aYUYDnjVdkjuFYPfmXk4kpTML8i1438whraZF7UtsEaKFIVb41
	eqV2DSya4ine3UzlYgUq20dpCrpfURyGW6fzQS8X7GLCY9e5NLW90pTeM0+Pcdcp9SOR9m4Ri1r
	r6y9MUKCMmbN/q4cj1d/v5o2uyDsxql7zGhA8/vjHll4vpMAx6qgyRRNXCq29249f3KEdUZX9wp
	QFbVh4uH71XtUcF7LcPlup+h2g7x5ogSn+FgmpAcsg54Xgww9r4=
X-Received: by 2002:a05:600c:4515:b0:45b:8078:b31d with SMTP id 5b1f17b1804b1-45b85525d8dmr194570535e9.6.1757080938516;
        Fri, 05 Sep 2025 07:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2pgd2xwVG6veFaY0CKMMn16GW411eLnAIn0rFchvq70SknR7/kodVXbZeiKPP5xRQL2/mOA==
X-Received: by 2002:a05:600c:4515:b0:45b:8078:b31d with SMTP id 5b1f17b1804b1-45b85525d8dmr194569885e9.6.1757080937817;
        Fri, 05 Sep 2025 07:02:17 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd296ed51sm71823145e9.3.2025.09.05.07.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 07:02:17 -0700 (PDT)
Date: Fri, 5 Sep 2025 16:02:15 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org, Adrian
 Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net] tunnels: reset the GSO metadata before reusing the
 skb
Message-ID: <20250905160215.6ca5d764@elisabeth>
In-Reply-To: <20250904125351.159740-1-atenart@kernel.org>
References: <20250904125351.159740-1-atenart@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 14:53:50 +0200
Antoine Tenart <atenart@kernel.org> wrote:

> If a GSO skb is sent through a Geneve tunnel and if Geneve options are
> added, the split GSO skb might not fit in the MTU anymore and an ICMP
> frag needed packet can be generated. In such case the ICMP packet might
> go through the segmentation logic (and dropped) later if it reaches a
> path were the GSO status is checked and segmentation is required.
> 
> This is especially true when an OvS bridge is used with a Geneve tunnel
> attached to it. The following set of actions could lead to the ICMP
> packet being wrongfully segmented:
> 
> 1. An skb is constructed by the TCP layer (e.g. gso_type SKB_GSO_TCPV4,
>    segs >= 2).
> 
> 2. The skb hits the OvS bridge where Geneve options are added by an OvS
>    action before being sent through the tunnel.
> 
> 3. When the skb is xmited in the tunnel, the split skb does not fit
>    anymore in the MTU and iptunnel_pmtud_build_icmp is called to
>    generate an ICMP fragmentation needed packet. This is done by reusing
>    the original (GSO!) skb. The GSO metadata is not cleared.
> 
> 4. The ICMP packet being sent back hits the OvS bridge again and because
>    skb_is_gso returns true, it goes through queue_gso_packets...
> 
> 5. ...where __skb_gso_segment is called. The skb is then dropped.
> 
> 6. Note that in the above example on re-transmission the skb won't be a
>    GSO one as it would be segmented (len > MSS) and the ICMP packet
>    should go through.
> 
> Fix this by resetting the GSO information before reusing an skb in
> iptunnel_pmtud_build_icmp and iptunnel_pmtud_build_icmpv6.
> 
> Fixes: 4cb47a8644cc ("tunnels: PMTU discovery support for directly bridged IP packets")
> Reported-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Thanks for fixing this!

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano


