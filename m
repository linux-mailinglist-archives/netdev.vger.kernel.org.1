Return-Path: <netdev+bounces-221574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A40BB50F9B
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 09:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B93B761A
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3043D30BB96;
	Wed, 10 Sep 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrhOI1xN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260E230648B
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489887; cv=none; b=iDemV9w3yUQ/+zQdyxKKvSyyLx2JB8WZekaRb9ij2YQAo8IfYpcRsYaibK54jOgzNvyKQvQQbP6oGK5E6J+pLUESggIP5OrrSTla2XvCBxLy5aDvLAkbiUd9cGTVdCULn1dqXpyYf63SPn4dFvtfiybG+2ynFtiMKJeJvuDvAQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489887; c=relaxed/simple;
	bh=L4oGK3PeESdOUWBAPXytjrHYWvgkxLGGvD9Z9Ir4ITA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAVm7FOmADiIxTovKD0ifB8gQ8KwfuCu/sjN0JplMiV1PQdm1bFxDTerEVrCTmG1BrOMfvH+vy0m4XKqWwhzhYdoKSXr7NIB48o/JHONRlKsMjC75GrY4P5vpdsn3Zu5apk/3XR6eEc5l73AHwR2IqZkP/35Cz5zmz5HYxQSdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrhOI1xN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757489883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=otk6o+qV+/FMnKKwMq2caJgygHkIl+S0Kye0WkDEbiU=;
	b=TrhOI1xNUWlJwDDwZKm6dHDFClgSkhbAQzZALAN/ejuebJeqhfPV9fIoRBTXHeDQk0a04q
	46h2iySKcVyUGa9sta09U1+QrRhl3W285TGUaBN27P0f0ZIpybVikJlghVdzCLDC1yes2G
	22kovW1qaDY2xVjEwvRVBJlyhqG8opo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-6fFKsUUuPr6TEJ5TDkSCBw-1; Wed, 10 Sep 2025 03:38:02 -0400
X-MC-Unique: 6fFKsUUuPr6TEJ5TDkSCBw-1
X-Mimecast-MFC-AGG-ID: 6fFKsUUuPr6TEJ5TDkSCBw_1757489881
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3dacc10dd30so4700554f8f.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 00:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757489881; x=1758094681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otk6o+qV+/FMnKKwMq2caJgygHkIl+S0Kye0WkDEbiU=;
        b=kDOheXbtvIvLKU+gL0I8wlBEZBhbr9lPOXF+s7AR3nU3CsHh9GmfHvsxQd54jFSjWu
         qR3akgNr3r+mD6wQ/0aCYORhJxHUStSR03eI0JxgAjTIOIByddKR/P6SDqieVp3Q4gBy
         Eque+FriJ302GDlmYzTb8DGs9XG+Q6jTs/Vy4FrPPBUmQkqtcHrPRTZLbkdvWCiGzYJq
         U7jWOQJHBl4ynG7v3qJ4VVFGp11PRKKGyrH3VNqsnBHvc6nITNIzLuSJv9uQogGBcD+J
         s6pOkb2ibcDA1QOiZJdXYVEo+qHhCqk2Ngj62/N6epqxxelMHkEwWdcFAHMzD3h7kzwe
         ZytQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7sSZxY0NwueCaQnlLUxySQh7WixRhT57k7yP/24MNHYDq5Xn9eEIEiohp9E1s7s+O0nBXKfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrmF2za7gSr7I0OVoAkf7nJstLsJq2NP4VfxLxvLm3WLXEhGl
	kTHboPNBVwvmzXnE6IZhFyLHvFYn5JPYioH6XNI1SfJ5Y7Jph9FMsuzGtAvOIgHPu8kyOTphh14
	ZncjJuO+8DST5kCW9ljHy7R85i07aLp5343o17rjJM8+rEe26dylet/bKNg==
X-Gm-Gg: ASbGncvhp2obYai1Im8ILkHivfGG+cpmvOzixpmDzTrzuu+qrqB89bRpsDokOzg4GS2
	7acoOgcW1Ev7zOJxT+vt/0dk7p2QDjc6G7L6yjbaGCMfB4a+NuBr8WjBtuJiwo5pM8ieVv0vVqx
	H0S/XvIwxGzjRKS3DxTEEV7J4roPPi6S7YZJXXXT5TR9FOdxp1zzsNER3cVeljI7JJCmJBUXYwi
	L72ZibNM3adNjaXO+05EqDiuGyxZxK+gqgjK9kc5PaYOj9PeAcuVm5d+KHrKaAN7hDcR5i37l+v
	XkoFC3XOnrvgFtsfVubS0HhyOeaD6h9/HL0SdQ==
X-Received: by 2002:a05:6000:22c2:b0:3e4:d981:e31f with SMTP id ffacd0b85a97d-3e643b19aabmr11528065f8f.60.1757489881229;
        Wed, 10 Sep 2025 00:38:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyP8y3KVJ6zMVMB9gGFAjF8KANG8pbRqLn4LVXUxF7YZBu4M7nOCpMolRLtn28VeTTuaiB0A==
X-Received: by 2002:a05:6000:22c2:b0:3e4:d981:e31f with SMTP id ffacd0b85a97d-3e643b19aabmr11528046f8f.60.1757489880842;
        Wed, 10 Sep 2025 00:38:00 -0700 (PDT)
Received: from localhost ([2a01:e11:1007:ea0:8374:5c74:dd98:a7b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223e932sm5645025f8f.42.2025.09.10.00.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 00:38:00 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:37:59 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>
Subject: Re: [PATCH net 2/7] selftests: can: enable CONFIG_CAN_VCAN as a
 module
Message-ID: <aMEq1-IZmzUH9ytu@dcaratti.users.ipa.redhat.com>
References: <20250909134840.783785-1-mkl@pengutronix.de>
 <20250909134840.783785-3-mkl@pengutronix.de>
 <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00a9d5cc-5ca2-4eef-b50a-81681292760a@ovn.org>

On Tue, Sep 09, 2025 at 09:32:49PM +0200, Ilya Maximets wrote:
> On 9/9/25 3:34 PM, Marc Kleine-Budde wrote:
> > From: Davide Caratti <dcaratti@redhat.com>
> > 
> > diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
> > new file mode 100644
> > index 000000000000..3326cba75799
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/can/config
> > @@ -0,0 +1,4 @@
> > +CONFIG_CAN=m
> > +CONFIG_CAN_DEV=m
> > +CONFIG_CAN_VCAN=m
> > +CONFIG_CAN_VXCAN=m
> > diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> > index c24417d0047b..18bec89c77b9 100644
> > --- a/tools/testing/selftests/net/config
> > +++ b/tools/testing/selftests/net/config
> > @@ -120,9 +120,6 @@ CONFIG_XFRM_USER=m
> >  CONFIG_IP_NF_MATCH_RPFILTER=m
> >  CONFIG_IP6_NF_MATCH_RPFILTER=m
> >  CONFIG_IPVLAN=m
> > -CONFIG_CAN=m
> > -CONFIG_CAN_DEV=m
> > -CONFIG_CAN_VXCAN=m
> 
> Not an expert in the CI infra, but the link_netns test clearly
> still needs these configs enabled in the common config file:
> 
> https://netdev-3.bots.linux.dev/vmksft-net/results/290682/56-link-netns-py/stdout
> 
> # selftests: net: link_netns.py
> # 0.12 [+0.12] TAP version 13
> # 0.12 [+0.00] 1..3
> # 1.44 [+1.32] ok 1 link_netns.test_event
> # 3.99 [+2.56] ok 2 link_netns.test_link_net
> ...
> # 4.13 [+0.00] # Exception| lib.py.utils.CmdExitFailure: Command failed:
>         ['ip', '-netns', 'rhsbrszn', 'link', 'add', 'foo', 'type', 'vxcan']
> # 4.14 [+0.00] # Exception| STDERR: b'Error: Unknown device type.\n'
> 

> Best regards, Ilya Maximets.

thanks for spotting this, I was testing the patch with:

 # vng --kconfig
 # yes | make kselftest-merge
 # grep ^CONFIG_CAN .config

Then it's probably safer to drop the first hunk - or restore to v1

https://lore.kernel.org/linux-can/fdab0848a377969142f5ff9aea79c4e357a72474.1755276597.git.dcaratti@redhat.com/
-- 
davide


