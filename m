Return-Path: <netdev+bounces-207039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 209A4B056E5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3872A7A1B8B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E742D63F6;
	Tue, 15 Jul 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zd+0ipyE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520412D5406
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572622; cv=none; b=KTfgXDlICEjLb6iBaBx9s6ew31OSt1KCCxbluDUyFKDlBtz04PTbWZo1yLudKr1l60KGNhjc+Ujp1lVVUI/fTUnV+QZ2iFN/x/+m/jHBO2MvnsXieJPiDQWNNQ+R39XFUS3d+tr/hEZwbJxiQVHIY5KJG3sg1/oGbkAcrXjN4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572622; c=relaxed/simple;
	bh=izVGqEo59aQaJ/J3dKmYZUnzyzOQr38MLYsTGyUr5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMpyF+PESX8Wfz78oUx0f2hFr5l6VmrmMxfo01slH11Tt+RDkM4TdgeOKeS2kbzUlYjPeG8Z7490xMD4zLf8linaDWP/lohUYhfSciM78wdZVVavGb5iAwWTx5KB+5zyDM7FN99hwZFls1rJkDEVLepfLmj9iIaBcpUq9dbWYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zd+0ipyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752572619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wHMd57pfXhcnKNyhyGblHFv+xYATdiBZA7QtN8Jk8ZM=;
	b=Zd+0ipyEzQpJ2GVGQZj2Esq8jY2Hs+Dmw9w7aKFptsCIqvk+8JOCLD1As3iaxRokdMR7ve
	8oMI4TYbv2UwJHqlCe/YnKifHt9NrBHz4s4bI6YzyoZStr541FjRVognnaEN5r63DCzE2k
	Ah1ltZsVJw+RhZsHUGU7PQZh7ynuJbk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-IUpRR9QgPNqVtAFSUmuTgw-1; Tue, 15 Jul 2025 05:43:37 -0400
X-MC-Unique: IUpRR9QgPNqVtAFSUmuTgw-1
X-Mimecast-MFC-AGG-ID: IUpRR9QgPNqVtAFSUmuTgw_1752572616
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45626532e27so4666395e9.1
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572616; x=1753177416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHMd57pfXhcnKNyhyGblHFv+xYATdiBZA7QtN8Jk8ZM=;
        b=fzPHUxMXTqdhRVD99lYYl/CAhsOLjWkNuyLvnsANt6Y5y88DsQs8BXEpXUZyczffTd
         QIXtf6M9d3l8jWQlrC+vi4/MTXE7rZgApPGt8iqTayj4wTiASZYlN3ITwno4ND/kJ/2S
         +33C5dOaQkau62weX/9zeBFEgRoskTSFFU8nKzuqPBRLG88ZAEy8J6eLL/pCG9k5U2Pl
         dQ3iBKULqYHcoNOptoP4fqVgi5m1W0VIqaAHovUWO+P24YPJYbhmzE2sgF6dCvhbU/XZ
         J4GkCfzzMZ6G9iBHJptHj4fKbNCXqpmyh2CbsZCC5FvQoaozCX6G/mKxD9TB2VrcVN+4
         zK3w==
X-Forwarded-Encrypted: i=1; AJvYcCXLl0W/2HeQKeKMqGo1JFjScYGtZvN26htUSK81qmpyKPfJSa3KhSgeiKDtOPATSYLm2eknnT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xyW01uRG+FjXs+NeRQFboYuDVPm+ToTxFs5DGcuIHIRDHawJ
	tf7/8oDv30pqBXPBVivIKFziLtyX4S5+xqb3ml/F9B4/BX6qVOjG7PphrRf4oxTUDTSST08r5fZ
	9NSNT0CRhBOc38ycXjTsRkkphrY+USjakRiF4KF19YgsmlIzVGMiVC/OO2A==
X-Gm-Gg: ASbGncs8a87uvbru2YMTE7/SxpULXSCXipXNkFuacFT4cTKX9CvG7Ll5maB2Qoc4VFN
	8Hg/xemKbaD22SFTI/T2lWc3ZI6epwV/alabMc/6jFjd/Kyg49fqEVUDEmgLJRz09FS9cRt1UP0
	LEu3yyDoxBz+tVIYEUkgg72l5u6+rlhyQVNnjCLH0nB3PRDksQ0rn6qPeVnGDxHyrkY0rzPJNH1
	a8TZ4zTfG5h9o+IftII37eslZFllrP5l+0o0hR/GNNdXDr0VELykZEsPNQGgH1drUhXKwlkY2OW
	XI8gAdtMHF13CuvwQQIFO4D9IT0=
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4555f89f507mr187240745e9.10.1752572616439;
        Tue, 15 Jul 2025 02:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN73ANiZ06ERUP471KmOgFnUFAPyMUPH/okS1ibcPZuQjxLvuh1FG3xOFXv+UfdNO1P57u2Q==
X-Received: by 2002:a05:600c:821b:b0:43c:ec4c:25b4 with SMTP id 5b1f17b1804b1-4555f89f507mr187240285e9.10.1752572615932;
        Tue, 15 Jul 2025 02:43:35 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1833sm14279030f8f.8.2025.07.15.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:43:34 -0700 (PDT)
Date: Tue, 15 Jul 2025 11:43:30 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Stefano Brivio <sbrivio@redhat.com>, Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Charles Bordet <rough.rock3059@datachamp.fr>,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, 1108860@bugs.debian.org
Subject: Re: [regression] Wireguard fragmentation fails with VXLAN since
 8930424777e4 ("tunnels: Accept PACKET_HOST skb_tunnel_check_pmtu().")
 causing network timeouts
Message-ID: <aHYiwvElalXstQVa@debian>
References: <aHVhQLPJIhq-SYPM@eldamar.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHVhQLPJIhq-SYPM@eldamar.lan>

On Mon, Jul 14, 2025 at 09:57:52PM +0200, Salvatore Bonaccorso wrote:
> Hi,
> 
> Charles Bordet reported the following issue (full context in
> https://bugs.debian.org/1108860)
> 
> > Dear Maintainer,
> > 
> > What led up to the situation?
> > We run a production environment using Debian 12 VMs, with a network
> > topology involving VXLAN tunnels encapsulated inside Wireguard
> > interfaces. This setup has worked reliably for over a year, with MTU set
> > to 1500 on all interfaces except the Wireguard interface (set to 1420).
> > Wireguard kernel fragmentation allowed this configuration to function
> > without issues, even though the effective path MTU is lower than 1500.
> > 
> > What exactly did you do (or not do) that was effective (or ineffective)?
> > We performed a routine system upgrade, updating all packages include the
> > kernel. After the upgrade, we observed severe network issues (timeouts,
> > very slow HTTP/HTTPS, and apt update failures) on all VMs behind the
> > router. SSH and small-packet traffic continued to work.
> > 
> > To diagnose, we:
> > 
> > * Restored a backup (with the previous kernel): the problem disappeared.
> > * Repeated the upgrade, confirming the issue reappeared.
> > * Systematically tested each kernel version from 6.1.124-1 up to
> > 6.1.140-1. The problem first appears with kernel 6.1.135-1; all earlier
> > versions work as expected.
> > * Kernel version from the backports (6.12.32-1) did not resolve the
> > problem.
> > 
> > What was the outcome of this action?
> > 
> > * With kernel 6.1.135-1 or later, network timeouts occur for
> > large-packet protocols (HTTP, apt, etc.), while SSH and small-packet
> > protocols work.
> > * With kernel 6.1.133-1 or earlier, everything works as expected.
> > 
> > What outcome did you expect instead?
> > We expected the network to function as before, with Wireguard handling
> > fragmentation transparently and no application-level timeouts,
> > regardless of the kernel version.
> 
> While triaging the issue we found that the commit 8930424777e4
> ("tunnels: Accept PACKET_HOST in skb_tunnel_check_pmtu()." introduces
> the issue and Charles confirmed that the issue was present as well in
> 6.12.35 and 6.15.4 (other version up could potentially still be
> affected, but we wanted to check it is not a 6.1.y specific
> regression).
> 
> Reverthing the commit fixes Charles' issue.
> 
> Does that ring a bell?

It doesn't ring a bell. Do you have more details on the setup that has
the problem? Or, ideally, a self-contained reproducer?


> Regards,
> Salvatore
> 


