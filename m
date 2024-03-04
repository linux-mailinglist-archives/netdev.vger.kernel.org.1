Return-Path: <netdev+bounces-77242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09075870C32
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3393286ECC
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEA811188;
	Mon,  4 Mar 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSu4etAW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69979F2
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586457; cv=none; b=b9vgQeJ0GcLYbJO4nw8moN4ZL44VYv3rrWLOuMmvXzuJH4QDPQkXl0dZD3mDGJ8zC8hCEK9Mmu8n4IZreCnO+x+UnMB03KLgb12aAtnnKFaBrhNBeRA91rjZ2+1Vhth6MerQC5F3yr0r7xtF6nBJROLDx1DggPFCcLTK8AiD0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586457; c=relaxed/simple;
	bh=PrlOetqGDnugsg8P4thU6wojAc8lc6/MMr9a5C90hvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t5QuRYWB1ZLIGAlRSy3evPE2C6hdwcp9yBoGNJhU1tE9sBccwZr+lut/ojDLbBA5S4EfrRBzrRFCeRF1mvJD6P4SgDTOheGFu9gx9GaeIBt6TnoEVKVNLpavIQ98opDzXsuTS8UWjsj+/9FLbId2pMkuCdge5brD9CQDRPyPtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSu4etAW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412eb6e15ceso879545e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709586454; x=1710191254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0I1KPAmkehMyBEqg9ZB5epsaKbZKet92hZYnsnmD0GE=;
        b=DSu4etAWhMdQZP/fhO/7Zs57RdS3WXCcxGheptJUhRhiAuXYYczOxRfkGdM5GuPczH
         OB/wWsKxzW40zfENY88yOk6TG9ge/29Gsx8XQ5D1GEEi7W50vN4V4da4SIui46+cbTAS
         0+JBdtAoIYLY2pwxS/HJnbL0cZb3Q4cfGyzhrJcwH7QKGE+AOhH/zaqZ58w1TOYd23DF
         7FeUA2QY9/XBsi/4Q0US87Ml2bXqxncFikO/j2NU82tgQqQvSngx5kIv+3q9x4jZznuV
         VTR9e+vBO7x3bUkpUfCGmT25EoFiOYx29u24pS1qqfUXk1DnOP1MDofAyW/NJyZ7hT7K
         +MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709586454; x=1710191254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0I1KPAmkehMyBEqg9ZB5epsaKbZKet92hZYnsnmD0GE=;
        b=g6a/CmdBykNK/enUHHjrS87KMHb513UYznE/uHzEs9Y3twXXmmsoywUGJ32P880e04
         yvs2eUS9yT0aNmfBdq5TutMTAGS4exzGOHZ3l96RQwgT9obcLwkAUCCOnmhtQNE2LZ0E
         aase2z4szi+S58oVgRhCaMXs4msiIqRc9i6HtuYzGZXDqOkmuWeZ5IyywvchET1B0vxk
         qwIVYV+7Vev3eoNlkyqwDAhPqiHuVg55xy8VZ5tBjOvS6akrlGu5Mm34VHNwLA6pi7aR
         +i4wB2ju/77nUFMlaP1mCVHHYH+PHWhi2Fd5Ji1UGap6ZffIoIYArhwRWBqaLHA9tpNS
         3MNQ==
X-Gm-Message-State: AOJu0YyTnxImpLB0wYkaRn2FQKsMOj3a9I7o6sF5pBWnYIaipt77n7g2
	8jCm2GNwnbHfsBDaP4xYS6eS8oF7UOk9BEwFEkXQDLnhhDpyovFq
X-Google-Smtp-Source: AGHT+IFJ48S5zejzTnCCQLFNlw6/+viAkJX/PRvGmbi8WM4eVtloHrsWB1Xu+971slHE7VMEalF0mQ==
X-Received: by 2002:a5d:5ccb:0:b0:33e:1627:4682 with SMTP id cg11-20020a5d5ccb000000b0033e16274682mr6230534wrb.29.1709586453510;
        Mon, 04 Mar 2024 13:07:33 -0800 (PST)
Received: from [192.168.0.3] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm13124152wru.112.2024.03.04.13.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:07:33 -0800 (PST)
Message-ID: <c18d174b-2da4-441a-ab2e-35cffcff8d85@gmail.com>
Date: Mon, 4 Mar 2024 23:07:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 00/22] Introducing OpenVPN Data Channel
 Offload
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Antonio,

On 04.03.2024 17:08, Antonio Quartulli wrote:
> Hi all!
> 
> After the comments received last month, I reworked the large patch that
> I have previously sent and I came up with this patchset hoping to make
> the review process more human and less cumbersome.
> 
> Some features are stricly intertwined with each other, therefore I
> couldn't split everything up to the very last grain of salt, but I did
> my best to create a reasonable set of features that add up on top of
> each other.
> 
> I don't expect the kernel module to work between intermediate
> patches, therefore it is important that all patches are applied if you
> want to see something meaningful happening.
> 
> 
> The following is just the introductory text from v1. It's a useful
> summary of what this new kernel module represents.
> 
> As an intereting note, an earlier version of this kernel module is already
> being used by quite some OpenVPN users out there claiming important
> improvements in terms of performance. By merging the ovpn kernel module
> upstream we were hoping to extend cooperation beyond the mere OpenVPN
> community.
> 
> ===================================================================
> 
> `ovpn` is essentialy a device driver that allows creating a virtual
> network interface to handle the OpenVPN data channel. Any traffic
> entering the interface is encrypted, encapsulated and sent to the
> appropriate destination.
> 
> `ovpn` requires OpenVPN in userspace
> to run along its side in order to be properly configured and maintained
> during its life cycle.
> 
> The `ovpn` interface can be created/destroyed and then
> configured via Netlink API.
> 
> Specifically OpenVPN in userspace will:
> * create the `ovpn` interface
> * establish the connection with one or more peers
> * perform TLS handshake and negotiate any protocol parameter
> * configure the `ovpn` interface with peer data (ip/port, keys, etc.)
> * handle any subsequent control channel communication
> 
> I'd like to point out the control channel is fully handles in userspace.
> The idea is to keep the `ovpn` kernel module as simple as possible and
> let userspace handle all the non-data (non-fast-path) features.
> 
> NOTE: some of you may already know `ovpn-dco` the out-of-tree predecessor
> of `ovpn`. However, be aware that the two are not API compatible and
> therefore OpenVPN 2.6 will not work with this new `ovpn` module.
> More adjustments are required.
> 
> If you want to test the `ovpn` kernel module, for the time being you can
> use the testing tool `ovpn-cli` available here:
> https://github.com/OpenVPN/ovpn-dco/tree/master/tests
> 
> The `ovpn` code can also be built as out-of-tree module and its code is
> available here https://github.com/OpenVPN/ovpn-dco (currently in the dev
> branch).
> 
> For more technical details please refer to the actual patches.
> 
> Any comment, concern or statement will be appreciated!
> Thanks a lot!!

Thank you for preparing this series. I briefly check it and now it looks 
much more promising!

I will do my best to do a careful review in a reasonable time, but 
please expected a delay in a few weeks :( It still a considerable amount 
of code for checking, despite it's well arrangement.

--
Sergey

