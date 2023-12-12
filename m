Return-Path: <netdev+bounces-56378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCFB80EAAD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44701F21E73
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443935DF02;
	Tue, 12 Dec 2023 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIkUjDq4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96025C3;
	Tue, 12 Dec 2023 03:42:58 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33340c50af9so5591520f8f.3;
        Tue, 12 Dec 2023 03:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381376; x=1702986176; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rL1bOb2mLG2xSb1vMtfKL9p1Rwmx1hkRrqERQhLV3xI=;
        b=cIkUjDq4ZQ1TSh1axPiYQg/NjwAEsy8iqv0ihQNvc9tucNWJItnDlD6ZZJmMl/Al5X
         JzN1BMN0/sPI9ZYB5YpqNvv5wPpf+nta/bgLScJ5x6SXMJikoJw5CiH75VVhozNhqvOF
         dA8B922KMT2YjjcbtSVfHfCZC78xY+ciBbO1v5e2V7bCsvqw/BtX1UW4cViPRknoY0ag
         883U02+aQ1U2qENUYNuu8QW2cHkmhrjhXVZP4TMIadVg9LLlHOsfCg2Hr+JoanI+Ujzz
         DnHjE87DEYNacTZz3MJS1InMyqSyv4lEZk29O7cRlLBE8IY9DXjObtgAwpV3WCErpoTg
         D9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381376; x=1702986176;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL1bOb2mLG2xSb1vMtfKL9p1Rwmx1hkRrqERQhLV3xI=;
        b=IgdgcoUZTdUUgsj+CuY7TIThoejgCQ1ySK0wSB+RGC6qcpebSjMgoKTnnjN2hjX2HT
         UorWliNjLqY9Rjs0vvS05X5x3AIxpJKYj8qnDPiqVwLnHaGN2g7L1KoGZXnWN+bqqcq4
         vR0thwkshfHik5eLYbjd/RP0N7WLXWYvHbWAw3JGrGhp95fJ/QRy8OX4O0lNr42u8bEv
         xsXr4AAW1641TaZpXhru5ZbQWNpALRqdZc29NdnFBBpMeXA05POmcGpYhCHo4KAPzBTi
         RuJlIn44LR2vPXJvl6K4g7hJvUfA/TLT3Nukj2XlfvZpMp540TGtZ5wswi8OcIl4n2N/
         b7Kg==
X-Gm-Message-State: AOJu0YyYRs+8NN3jwXL06xExLsVaMx018JNYKmM0l/5y+fZhKBKLUJl6
	h7HXY8MvOZLX0yWETlPPBm0=
X-Google-Smtp-Source: AGHT+IGnTefpQ78PurhhoAdtZA4Hh+joS3/MDIbTEot4jw7bhssxml21mf8goutlZxqQc08bC/rgsw==
X-Received: by 2002:a5d:4b0f:0:b0:333:2fd2:3bcd with SMTP id v15-20020a5d4b0f000000b003332fd23bcdmr1943475wrq.134.1702381376210;
        Tue, 12 Dec 2023 03:42:56 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:4c3e:5ea1:9128:f0b4])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d4c4a000000b003333abf3edfsm10617321wrt.47.2023.12.12.03.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:42:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 08/11] tools/net/ynl: Add binary and pad
 support to structs for tc
In-Reply-To: <20231211180436.5560720e@kernel.org> (Jakub Kicinski's message of
	"Mon, 11 Dec 2023 18:04:36 -0800")
Date: Tue, 12 Dec 2023 11:36:03 +0000
Message-ID: <m2zfyf7ivw.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211164039.83034-9-donald.hunter@gmail.com>
	<20231211180436.5560720e@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 11 Dec 2023 16:40:36 +0000 Donald Hunter wrote:
>>                  description: The netlink attribute type
>
> We should perhaps "touch up" this doc, and add that for the use of pad
> within structs len is required. Would be even better if you could
> convince json schema to validate that. The example that starts with 
> a comment:
>
>   # type property is only required if not in subset definition
>
> should be pretty close to what we need here?

Yep, I'll update the description and see if I can get the schema
validation to play nice.

>
>> -                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary ]
>> +                enum: [ u8, u16, u32, u64, s8, s16, s32, s64, string, binary, pad ]

