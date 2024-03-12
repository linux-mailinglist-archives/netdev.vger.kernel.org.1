Return-Path: <netdev+bounces-79446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D65F87943E
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F1287175
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF4D1EB37;
	Tue, 12 Mar 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTOBmJdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3A811
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710247027; cv=none; b=g25TztJOXsNGjYByhtP1eK7LvcBbNCc96/F5jVNylpOCSu652KrobGETGn/a/mYZlJgzl2O+r9Oq2VBZpBMjJzotE9v3jyX6kafS22rK24IXQ4OInJeJLaOH2FyRbV6AlPW2E0IvSM0x2DycqCkxtnjmGykZf8xGynxqLM2ODRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710247027; c=relaxed/simple;
	bh=93M3RV3rJA2Zj4gAS2asRNZrHz7aEBWTq7IuS2QN95M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k31IDKy5ySUj7sGfpU9QTYmv7SZpju0DVVdwdPXjuIN9Pi0+7lyPyEItu2RCfbuYH9q1yi58YwM5T/yg+ZBAHegEZgE9y7Bj7zAgA6uEmJnUznRIFQrY+C2LnAYZNPySBhRUX+ue2IcNJoMT2Bqo00JTIkRt9UAAC2Ut3qA8Q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTOBmJdD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6ab012eb1so396776b3a.3
        for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 05:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710247025; x=1710851825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCaWbN7risJM309JwFwjuujngb8XV/cPTtG2iOeC7eY=;
        b=YTOBmJdD8KhQmBp85TVggQql08AGUAxYfIWQFOVfpOFhD5ceAJcWoZFCHDbbmCXcuh
         U16vy29nXcL4e7TcRvjJ/S+2aFdy8h3aTMF5kBopevmZvM4/kANlAdc7hgCcQml3QeT6
         Cf+AmOv6FPthgD/cCOxbkDSJGoqcEychmKmNazBGq92/ixuI+vKtCg6mZzAiAwfyuBPM
         6OLoinBGLGSmdZZg8hKMD+KezjU82gvGxH3CGCxUWnA2zhB0eGZ5abULoM4xHLFzeP/8
         pidrZlEz44b+DCsD2VOoIY3OZ0AgVvRfH+Vx+aDKikF3PSh3Wn2skqN7dl4WbC0zJg1k
         H6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710247025; x=1710851825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCaWbN7risJM309JwFwjuujngb8XV/cPTtG2iOeC7eY=;
        b=UmqorUJNEJU5B0rpA8QgiULrJ3Rtcj9GR/O7agZKf8C+4xLHRZS5XRoUTA+GrTp6By
         q4SF7PlmCESA6HdD0Gc1YcVMQEz22D3M3SBH9E1jhC14bwI+6/TcDyE7/KFMAcjwLESZ
         c+6XuI/VhPS/FyNtG8K8rT/CgCF+6+APgu5poRjlsYcy9iMVndMNIJiCS9x+INrKnxaG
         XsOZw4a+kW3rvOAxRlOzvRNORMwpfX8Ujgr8fcJQf+bdAJX5PlVjt0NRSyT7uSNfT5k1
         jzZD24pV/4Lsb9XONkNy0VoDyAWjzEHux3uhNjA1SMjO/iFJ35EGNhnhBQ7QPwORSMML
         kdug==
X-Forwarded-Encrypted: i=1; AJvYcCXlMUlnDxerkTGcdAJw5NKqR+GNGnlrXQ2apglC0d0bN/f67Y5OMAzPa9jEYUBxpX+/Z1LEdMeIrd6I3TN3GldwIza0q6Q2
X-Gm-Message-State: AOJu0YwxyqPZKYv+qKU/P4uFdEjj4p4/dtIJGT4pjHVgt7EUtNYa5tfI
	LR397Uu2KK1OlJ9xNwiQLuL5J58b+ZsYtADOcV9GhF10RSrc2qxK
X-Google-Smtp-Source: AGHT+IEyUjNprOrer/TRXw+3F80Etaw/THKwbbFM50335idltmquuKl79B3Aic1TS/iAjdDzcGLUQQ==
X-Received: by 2002:a05:6a20:9c93:b0:1a1:847e:162d with SMTP id mj19-20020a056a209c9300b001a1847e162dmr7689049pzb.42.1710247025202;
        Tue, 12 Mar 2024 05:37:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b001d9edac54b1sm6044738plk.171.2024.03.12.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 05:37:04 -0700 (PDT)
Date: Tue, 12 Mar 2024 20:37:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: How to display IPv4 array?
Message-ID: <ZfBMbZRbgwFOFPmk@Laptop-X1>
References: <ZfApoTpVaiaoH1F0@Laptop-X1>
 <ZfBGrqVYRz6ZRmT-@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfBGrqVYRz6ZRmT-@nanopsycho>

Hi Jiri,
On Tue, Mar 12, 2024 at 01:12:30PM +0100, Jiri Pirko wrote:
> Tue, Mar 12, 2024 at 11:08:33AM CET, liuhangbin@gmail.com wrote:
> >Hi Jakub,
> >
> >I plan to add bond support for Documentation/netlink/specs/rt_link.yaml. While
> >dealing with the attrs. I got a problem about how to show the bonding arp/ns
> >targets. Because the arp/ns targets are filled as an array[1]. I tried
> >something like:
> >
> >  -
> >    name: linkinfo-bond-attrs
> >    name-prefix: ifla-bond-
> >    attributes:
> >      -
> >        name: arp-ip-target
> >        type: nest
> >        nested-attributes: ipv4-addr
> >  -
> >    name: ipv4-addr
> >    attributes:
> >      -
> >        name: addr
> >        type: binary
> >        display-hint: ipv4
> >
> >But this failed with error: Exception: Space 'ipv4-addr' has no attribute with value '0'
> >Do you have any suggestion?
> >
> >[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/bonding/bond_netlink.c#n670
> 
> Yeah, that's odd use of attr type, here it is an array index. I'm pretty
> sure I saw this in the past on different netlink places.
> I believe that is not supported with the existing ynl code.
> 
> Perhaps something like the following might work:
>       -
>         name: arp-ip-target
>         type: binary
>         display-hint: ipv4
> 	nested-array: true
> 
> "nested-array" would tell the parser to expect a nest that has attr
> type of value of array index, "type" is the same for all array members.
> The output will be the same as in case of "multi-attr", array index
> ignored (I don't see what it would be good for to the user).

Yes, this looks a do-able way. Although we already have a similar type
'array-nest'...

I also figured out a workaround. e.g.

  -
    name: linkinfo-bond-attrs
    name-prefix: ifla-bond-
    attributes:
      -
        name: arp-ip-target
        type: nest
        nested-attributes: ipv4-addr

  -
    name: ipv4-addr
    attributes:
      -
        name: addr0
        value: 0
        type: u32
        byte-order: big-endian
        display-hint: ipv4
      -
        name: addr1
        value: 1
        type: u32
        byte-order: big-endian
        display-hint: ipv4

With this we can show the target like:

     'arp-ip-target': {'addr0': '192.168.1.1',
                       'addr1': '192.168.1.2'},

But we need to add all BOND_MAX_ARP_TARGETS attrs. Which doesn't like a good
way. So maybe as you suggested, add a new type "nested-array".

Thanks
Hangbin

