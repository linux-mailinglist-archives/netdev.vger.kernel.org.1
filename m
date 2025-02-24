Return-Path: <netdev+bounces-168890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6EDA4153B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 07:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3C3E7A3406
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733EC1C84BA;
	Mon, 24 Feb 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhHLcwwn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0661C84A6
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 06:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740377699; cv=none; b=dYhT5psYIU2zvWx/GvvppzzJCa8a3wFO0q5bb5fSIAvsCFspksx6wjtP1T0Sk/3uZWRYdiVrvVLMGtuQ2GdhTI+roOqPwHqNbTT7R3HWkzvTh1oPBUd32OrT3fTmvCoM+8G9vaGpiyPqxW8exhwgeLU6SYh6kdTumzSycV+vA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740377699; c=relaxed/simple;
	bh=1htTtEA3dx1EcpsLL7oZNvWAk/Euq/m93cbwWFSu67E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WYvrwzIei8Atc5BP97seilTtcjbltgDSC5rXauDDaryT6XHLJvdo43/VSE+rUPTim1820Bsb5PrEKuFBTlWvBpfktdtMz+5n2g7ycfnujiqkQ9j4KpnbFFLOGjldhCDvHsk5GMS8ogrTfAIocp81x8OwH0IKRtSwrDRRNXdIH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhHLcwwn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220bfdfb3f4so89071965ad.2
        for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 22:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740377697; x=1740982497; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EYPSIg8p/wUDQFabrRv+SfPF1pqWAP85Lise3DCcfFw=;
        b=ZhHLcwwnw8he52YZIVIfXX17rj71RIcUFlY8LYFOMzZA2+E/x/X7aS9YnePDtOj8mE
         +jWh2zPLvbvZHPmCauliyX/0CR1eNnIFWjY2bUSXRO/oLIn7c2PaQUgkPmAixwoTzMjf
         3xkLTlJ7ydI+rWHN+EVFHNWac/p9UmkvMQQvOdjQgoHfoQkMK94aSYeu2E/9FxvDtsty
         45M4Heh3qFAf9yG3ftgt5VAOHpTydE/rPJrEZJHapjqXaHA6/BusIii6UtYVuuaW5/f6
         JnbCyYwK0tyN2v0K4ORWPimXrkpOkqZW4hin6jg/VCDBEFRXYDWrCwJl0bThrQlivjwC
         ac+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740377697; x=1740982497;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYPSIg8p/wUDQFabrRv+SfPF1pqWAP85Lise3DCcfFw=;
        b=OV/I4LcZs/3e7aX3EyNPTebknnLz6eiK6CzNQagF+6CNvX+QIKq6L+L8zq0NBLxvky
         d9aUv8Dp8t7LLJoJD5xlSIfhhS9OREtLqKLnscwidYE9zqhk5R6WIeZkD9XKVvhBGGTI
         VVWOMfydIdbi+nfDF1nx/pQq8FS8EXAiU8SQUJV8Lq9CFVARhAtwvD7+F644kMwJRp2Y
         yjVkTiNMYJwKjLvBJDIAqc+ttjTsHXMFlJDQQeFZj1tBRw67EqlUsY7MmxCU5N4ueAC3
         3Ad1op8kHCt2N3bYt/0j+u6nFXx/5r5y8aTKfwLRLW9EW00ybvbOUphdaw++2bQyD0Qq
         MQEg==
X-Gm-Message-State: AOJu0YyUJ0IlzlvvoJ47vrFwjEmACfPfZDCbO2SRU2AjMfR7z/s3RrSa
	JLhBIY3n2Qm+PXUQSp45lY/8rlfwhnBipTFU2N1rCRI3SMSf5JCd7aBcIgpUUsWWIg==
X-Gm-Gg: ASbGncsFLqp5IKIccya+pv3McLr8lJobXyq8RBWIJqPRdPYTyblS/F/+fYtiBzHn9/F
	e8xZN34QcE54GWwrYNey7pofeeIo7bTq3chzohwXlcr7RV6UhReE2V3WxXl5mJ9BVviXRs/OVCT
	iRHJ/kmVttvowdHrdw+/qbLhukbMpNW/5E58T+dAjIYECrkHCj0GpvIV4OohCEKYIJ41+I1pmAH
	TqyLY0i1FM3D2XoTFWhGtits0Y4Jb+ZhAzrgeFt7sQiUdcEhEMLxi2bgSkldpcFVpZjKhQUNCob
	LJKZH+biEPGYwrwTqqQcqWV9sPNOlqQ=
X-Google-Smtp-Source: AGHT+IEaaUgD4RdEKe/cKXHiOb1aYX/muaMsh6FD7s00iC1y7iuQnhcBYUQtVBW+6hAZ2j+0H+0muA==
X-Received: by 2002:a05:6a21:7016:b0:1ee:cf13:d4b5 with SMTP id adf61e73a8af0-1eef3dd0691mr21868337637.39.1740377696907;
        Sun, 23 Feb 2025 22:14:56 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256997163sm18202586b3a.175.2025.02.23.22.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 22:14:56 -0800 (PST)
Date: Mon, 24 Feb 2025 06:14:51 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>, Di Zhu <zhudi21@huawei.com>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Subject: Re: [Issue] Handling NETDEV_UP/NETDEV_DOWN for macvlan/ipvlan in
 Namespace
Message-ID: <Z7wOWyLEwxIC-d6S@fedora>
References: <Z67lt5v6vrltiRyG@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z67lt5v6vrltiRyG@fedora>

Hi,

any comments?

Thanks
Hangbin
On Fri, Feb 14, 2025 at 06:42:07AM +0000, Hangbin Liu wrote:
> Hi folks,
> 
> Our QE team reported an issue where, if macvlan/ipvlan is moved to a namespace,
> link up/down events from the lower device are not propagated to the upper link.
> e.g.
> 
> # ip link add lower type dummy
> # ip link add link lower name macvlan type macvlan mode bridge
> # ip link set lower up
> # ip netns add ns1
> # ip link set macvlan netns ns1
> # ip -n ns1 link set macvlan up
> # ip link set lower down
> # ip -n ns1 link show macvlan
> 4: macvlan@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     link/ether 1a:f2:01:99:06:bc brd ff:ff:ff:ff:ff:ff link-netnsid 0
> 
> After reviewing the code, I found that netif_stacked_transfer_operstate()
> only transfers the carrier state but does not handle device_close/open()
> operations.
> 
> I noticed that VLAN handles this state properly—if the lower link goes down
> in the default network namespace, the VLAN interface in the namespace also
> goes down.
> 
> I’ve drafted a patch to make ipvlan/macvlan follow VLAN’s behavior. However,
> I’m a bit concerned about whether we should allow control of a device in a
> namespace from the default network. For example, if a user sets ipvlan/macvlan
> down in the namespace while the admin sets the lower device up, should we
> bring ipvlan/macvlan up as well? For VLAN, it follows the lower device’s state.
> e.g.
> 
> # ip link add link lower name lower.2 type vlan id 2
> # ip link set lower.2 netns ns1
> # ip -n ns1 link show lower.2
> 5: lower.2@if3: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether b6:82:39:94:f1:67 brd ff:ff:ff:ff:ff:ff link-netnsid 0
> # ip link set lower down
> # ip link set lower up
> # ip -n ns1 link show lower.2
> 5: lower.2@if3: <BROADCAST,NOARP,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     link/ether b6:82:39:94:f1:67 brd ff:ff:ff:ff:ff:ff link-netnsid 0
> 
> Looking forward to your thoughts.
> 
> Best,
> Hangbin

