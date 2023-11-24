Return-Path: <netdev+bounces-50855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60787F74AD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C36280F06
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9806286B7;
	Fri, 24 Nov 2023 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ub2ZyGIt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C040D71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:18:23 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50abb83866bso2465565e87.3
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831901; x=1701436701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T29fYVQ4s7BH+SOXTUbsr98qsEYyHt2HQFwxNpNwgm0=;
        b=ub2ZyGIt5+76Vd06beMmC3HVa2u+puHYf1HOwFtFzpYP43M3/qkgkxSgOhwz1NRfYA
         jt6XEV33R5FrKZuY+rUWxkQYkQwVKmm1UTsDp5ZnUvWh5wp+jZGvhgBR9M/eQXzcpz7F
         pQWGIqwLxOa2FcSpNcsaHvvsA6+dLp5K0n7b1CPSl4VKowHRoPHH8CjafYTJvZ+hXFqs
         69nU8GhmUUuClxdDVlr3NIVOlQGwekUCTQGY8mXzqozz4I5qEItoadVfrsk71kgs3kp3
         KgSdMBfrij19QPiP8IDSvEO26aRlLVTX5RqY88suN/6D8JHRNx+JSH6PokZmkvoEtgDC
         6QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831901; x=1701436701;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T29fYVQ4s7BH+SOXTUbsr98qsEYyHt2HQFwxNpNwgm0=;
        b=JLBMLeh2Cyh4Rggi26Sl6zL8h1WaG+8gaTc+3Z8L1FuPuBaHUwff0M9WRl41wqyNG7
         gcaJGZAeNWlil8otyXNcqjZfMee16lF7rNMQpLbzNhORSnhgzOUXmLP84q71LXjqNMq3
         NOPNr8nBzqiujv7N5t3bRyJEq3Dzu2ehuZF/Ig5BMghTP5jkGfSfx0qUsVvki96Ju+Qe
         DDFSblFY7mlNu30I75uvc7QY6tEXX9/swB87Bffhf+uIk/fGU4EeQGnisps1r9uGUrwV
         zsyVSOj6PvWiTJfZcXmPugbj7lI2nMtdMHuKYJMsJjPeBZpJb8qfBNwQ/xddGGJ9bThq
         mOKw==
X-Gm-Message-State: AOJu0Yy8B5XUnje0bDl7CwOzlbk0zLFmWs+BNVT6g5VYf3WIM0ukmo/Z
	aUcgB4+XiKxNFTyIz/IIHZA9tQ==
X-Google-Smtp-Source: AGHT+IEwmcKfQEYZu+kz6am3qJSaUh4n25Ou7oUVRGVUyxfzGsZAUn1eVOzgH/bPqKxuZ5wlvN/xOA==
X-Received: by 2002:a05:6512:3d0b:b0:503:653:5711 with SMTP id d11-20020a0565123d0b00b0050306535711mr2378007lfv.9.1700831901673;
        Fri, 24 Nov 2023 05:18:21 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id v2-20020aa7dbc2000000b005484c7e30d8sm1767553edt.1.2023.11.24.05.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:18:21 -0800 (PST)
Message-ID: <07156f26-6360-e3ca-1dd0-475fce2a235e@blackwall.org>
Date: Fri, 24 Nov 2023 15:18:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next 05/10] docs: bridge: add STP doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Vladimir Oltean <olteanv@gmail.com>,
 Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-6-liuhangbin@gmail.com>
 <20231120113947.ljveakvl6fgrshly@skbuf> <ZVwd31WaAsy6Cmwy@Laptop-X1>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZVwd31WaAsy6Cmwy@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/23 05:02, Hangbin Liu wrote:
> On Mon, Nov 20, 2023 at 01:39:47PM +0200, Vladimir Oltean wrote:
>> On Fri, Nov 17, 2023 at 05:31:40PM +0800, Hangbin Liu wrote:
>>> +STP
>>> +===
>>
>> I think it would be very good to say a few words about the user space
>> STP helper at /sbin/bridge-stp, and that the kernel only has full support
>> for the legacy STP, whereas newer protocols are all handled in user
>> space. But I don't know a lot of technical details about it, so I would
>> hope somebody else chimes in with a paragraph inserted here somewhere :)
> 
> Hmm, I google searched but can't find this tool. Nikolay, is this tool still
> widely used? Do you know where I can find the source code/doc of it?
> 
> Thanks
> Hangbin

Man.. you're documenting the bridge, please check its source code and
you'll have your answer. "bridge-stp" is not a single tool, rather than
a device for the bridge to start/stop user-space stp when requested.
As an example here's the first google result:
https://github.com/mstpd/mstpd/blob/master/bridge-stp.in



