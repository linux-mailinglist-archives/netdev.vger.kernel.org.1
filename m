Return-Path: <netdev+bounces-211113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61B5B16A10
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DC618C7820
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49A01A29A;
	Thu, 31 Jul 2025 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt7pNr2K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389B1A2D
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753924603; cv=none; b=JVwQKkAOUqxaPcFlZiM8u61ee3tS0rC21Je7NKXmKm7gUrFwpcqmZidKpa/ARNf4bDEqLFxOjMmT6V4gas22QVBeGkMjbd9KiZ5v5nd33a3OYAcsyLTXLthL7MT4VWCcMabMpQnVYfODFRHftJHGkOdlnFzgnBPfbAMxZGW/1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753924603; c=relaxed/simple;
	bh=hR24rz/w1QiGGAO73x1Y1YKzwawofiwnC8Oyl9U8oK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRrulxmMrymN0UAZclHoO3XigvPhKCith/5dPXFUa7mmXJ/MySno/nXSYdo72/vEU+fsdLyMl8wHazPP+4QKVD/LwNTpDKYPOrcGdZwiywD0/E7CxoNJDZfFQ+GIydk2gNUXrBUoc56y21fFLn88kwX2J0xr9jFhpsq2r/rBhpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt7pNr2K; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31f28d0495fso409993a91.1
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753924600; x=1754529400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWiSTnAZMYgj12JgHgTAUdM/4v+28rX6Th4KYN2eEwM=;
        b=kt7pNr2KDLMkFtydUtn9l+y9Z4lDoN0GjhMuuNXCSFR2VPofs/KGycLMSd6P35uvci
         hSm1s84p7Bzk44BwjbidLXw6UjJjcu3i4DNnl4kuW6wUvBZTGY2GjwTjEH6zvl+1ZHjg
         sBKENqtmdqMZvKwS0FkZ8adqlpIdHGNjjS4wuYZ3l0eMi8JfDQ5qfErYu2QrWn5D24nu
         kQ4Q4lVDcNdEtDowqW/Ktpv3fMHlrRjbUUeaeS7v3v/3zTClhpK45ahuagZLKEsevtUI
         CHziI713MbTBpqHQolze5E+Vq58w97vPAaWl3thk4wDObovto13Di9tqK64ava0YJ2l2
         EPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753924600; x=1754529400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vWiSTnAZMYgj12JgHgTAUdM/4v+28rX6Th4KYN2eEwM=;
        b=to60esJzsaUFTlZ/c86shouIWMisBVUtX8WOBQM6r0qAuArEEVwK4BCEwVy4TAbT3d
         axkjMrfxAdBrvb9v15ml68tbkkBYuxHUGXXTFXdhbLVbZKSHSljDPYBXfCSYPVAWpdkm
         J49iFEqk4zmGkNtZV8kGruQB4sMeEFuxSXtCU5bmcwzoBTqM6g93p47lYHKHdsWV+/i6
         vQlatOoYNpewVC0SNvpNE0Nmbl3VSUBT6zLsUEPgihLi8gOwfTRTRzJLXqqC+Li2wWmi
         xn8egwxSh+aNOVDSWzGCvn1CA7Pzwq+pcLae9MSaFOfHAn8C7whwlGj+kehZIHGg7Gxr
         BVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU17jcFItqLGh/nS3sq7onxdIO+T6VOw6uSs3vMfA/3gcWshxTwfslmH8lYuzuyB7L9J5jiowI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqbGHYQVpTfMRDlu9zBe44zBE78qW22W4dmBtOxdIos1A/rVn
	yNZ391dyb0WMzyMRL5zOQ3KEIFS8yvg+Iu7vsjmawj3PtveQL+3na1uO
X-Gm-Gg: ASbGncv5wKYG8CCOFAlxW9iOurcVO/qD0wxWJ3+slBk1LkUjeY0V3Pn50mNPpdGu4K0
	z0D55grKLcKgsXzwmv7GSLS9LMatMLX3mgM7Ap4gVFQP5yC4uy+fIQ8wnUwmDWmdUuIPBIkMk4H
	AuiLeAGwGey87qhVcgUU3wiQkaimbFvhXKAAW4k90xye97UMcHiKGvSd5hdLNqgAVDpsxsWEanM
	SISfVvnA0z2nu3adOXSoI2Y0jjQ58YOEtmGnNKB8+gTHBcFlyLwJOzmPvbLXockoghtfoBj1XFx
	HIhTc/TTpLlzCJ2DX0/II5oTXH0X7lM/HpOj8ZWBPpbGDY0BHV/QlbMmZ6rIY4F+3ZLFtF24w1M
	UmiwAjQGhUhO6u8DVW8A9LT/DOXI=
X-Google-Smtp-Source: AGHT+IHwztmIhY8A7iE7E2MzoMKjw+Lkzeb5m/SuZ0gUp7TlZkzhm4mJTRxqMXLNtNAjjRrss7W7yw==
X-Received: by 2002:a17:90a:d604:b0:31f:3029:8854 with SMTP id 98e67ed59e1d1-31f5de5561dmr7766495a91.27.1753924600417;
        Wed, 30 Jul 2025 18:16:40 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eca6fdfsm379501a91.20.2025.07.30.18.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 18:16:39 -0700 (PDT)
Date: Thu, 31 Jul 2025 01:16:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Dong Chenchen <dongchenchen2@huawei.com>
Subject: Re: [PATCH net] selftests: avoid using ifconfig
Message-ID: <aIrD8eEfmsIggLKb@fedora>
References: <20250730115313.3356036-1-edumazet@google.com>
 <aIoWcxoHfToKkjf4@fedora>
 <20250730075139.21848612@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730075139.21848612@hermes.local>

On Wed, Jul 30, 2025 at 07:51:39AM -0700, Stephen Hemminger wrote:
> On Wed, 30 Jul 2025 12:56:19 +0000
> Hangbin Liu <liuhangbin@gmail.com> wrote:
> 
> > On Wed, Jul 30, 2025 at 11:53:13AM +0000, Eric Dumazet wrote:
> > > ifconfig is deprecated and not always present, use ip command instead.
> > > 
> > > Fixes: e0f3b3e5c77a ("selftests: Add test cases for vlan_filter modification during runtime")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Dong Chenchen <dongchenchen2@huawei.com>  
> > 
> > Not sure if there is a way to replace the ifconfig in rtnetlink.sh.
> > 
> > Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> > 
> 
> Would this work:

From Florian's commit description, the ifconfig could trigger infinite
loop/soft lockup. I'm wondering if "ip" cmd able to trigger the same issue.

6a9e9cea4c51 ("net: ipv4: fix infinite loop on secondary addr promotion")
bb2bd090854c ("selftests: rtnetlink: add small test case with 'promote_secondaries' enabled")

Thanks
Hangbin
> 
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index 2e8243a65b50..a3d3f2261bab 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -318,7 +318,7 @@ kci_test_promote_secondaries()
>         for i in $(seq 2 254);do
>                 IP="10.23.11.$i"
>                 ip -f inet addr add $IP/16 brd + dev "$devdummy"
> -               ifconfig "$devdummy" $IP netmask 255.255.0.0
> +               ip addr add dev "$devdummy" $IP/16
>         done
>  
>         ip addr flush dev "$devdummy"

