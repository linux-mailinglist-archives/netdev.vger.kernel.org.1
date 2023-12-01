Return-Path: <netdev+bounces-52829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC184800510
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EEE5B20D64
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484D125C2;
	Fri,  1 Dec 2023 07:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EfDlcwTg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EB170C
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:51:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b2ad4953cso18670915e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 23:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701417086; x=1702021886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IhWDSaqITGOGxQvNAD4XkmND5A8EOl/ytFB//AOpH8=;
        b=EfDlcwTgerV8Esm8rsuBWRPJVJ2FOuE1sB2ZuEdThLANurWzNnpAswj3jQqteX0r5v
         XRqvVDikVhIM7z4wh3eLiBsUbrHayxDRhcQnTO+agvbchOjZv6PETYAMepxpLlmwpkfY
         8+8cRrz1TMe63YRB9qgyivuEC+nJvHIUNcZV/PcVvw9I6ZfPrwlo2jBJXF0LW8zTytz7
         kobdloumNsPiHSFzIv5OAXPFgCFOmQUXs5/QFu8GVCreoX7aJ09hVpQVYi1l0uua0cB/
         SkyyhIcLUzwXpMbK679fXlQ6SyAjyTb6rDhQfxm1YsA6hY+BftVBRYo+nRvIKsfyoIPY
         asOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417086; x=1702021886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IhWDSaqITGOGxQvNAD4XkmND5A8EOl/ytFB//AOpH8=;
        b=tdrXmhNIuAOmFwcT6gozKGOOrJxkPFet6HEPBiGHQNgLMuzl0vPRwCd1gZ4AJ/TbKV
         RFD5VeFkX4gDzWsWJLCnung14keR5nW7GadE18cRXEVsM8i6XUaPs2NA8DSrRheeMNc/
         73GoQl5etA3B0mRw1aNiJObJN2zVN79gdELXX5e1Yj4ZIg4wG4LolIS77dM3ku1MfSj2
         gYXOTFkc4un6kCF6gSHw1crWknTLMSnAg4wB7+JLnAuNvChDQLoTU8C/9/niqdyi86kj
         8pxm9BTVlIJsqIRIfn2Wl7pwr0xYFMC0Jnnasik4ypUjinFtdWArgEAz2eAwhJbrcE0W
         PqIQ==
X-Gm-Message-State: AOJu0YwuIIi6Rhbm8+s4F4JaKBIOZtmrER4idkLvLEeAzE1p/MNEfzVj
	dN/kV/K+35burlw3SjmWHkP6/Ug7Oqod0fVeNqtKeQ==
X-Google-Smtp-Source: AGHT+IGACpZBtj+2CulH3bzH5OUHZsddJrEzjmfJ/3mPM/PJYhOsDv67WWuRHOA0fCM/lqElucZXiw==
X-Received: by 2002:a05:600c:138d:b0:40b:2a46:6f1 with SMTP id u13-20020a05600c138d00b0040b2a4606f1mr392939wmf.2.1701417086383;
        Thu, 30 Nov 2023 23:51:26 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o18-20020a05600c511200b004064e3b94afsm8117183wms.4.2023.11.30.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:51:25 -0800 (PST)
Date: Fri, 1 Dec 2023 08:51:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <ZWmQfH1VSP3ySNX0@nanopsycho>
References: <20231128151916.780588-1-jiri@resnulli.us>
 <20231128073059.314ed76b@kernel.org>
 <ZWdOtzoBHiRY53y9@nanopsycho>
 <20231129071656.6de3f298@kernel.org>
 <ZWiOfMs1PT14LLau@nanopsycho>
 <20231130093939.06a987cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130093939.06a987cb@kernel.org>

Thu, Nov 30, 2023 at 06:39:39PM CET, kuba@kernel.org wrote:
>On Thu, 30 Nov 2023 14:30:36 +0100 Jiri Pirko wrote:
>> >connector is a really bad example, the doc would have to say "some
>> >families use NLMSG_DONE as an actual message type which may have pretty
>> >much anything attached to it". It's not worth it, sorry.  
>> 
>> The existing documentation confuses uapi users (I have sample).
>> They expect error with NLMSG_DONE.
>
>I hate this so much.

Unfortunatelly, Netlink has a lot of burden of misuse...


>
>How about we say:
>
>  Note that some families may issue custom NLMSG_DONE messages,
>  in which case the payload is implementation-specific.

I'm fine with that. Will send v2.

