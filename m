Return-Path: <netdev+bounces-50386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C77F5859
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 07:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA112812C7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDD3D30B;
	Thu, 23 Nov 2023 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Muo2oU+7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834B1A5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:37:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5491eb3fb63so701083a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 22:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700721437; x=1701326237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMeECNyDeji/BB+8MMIjogxlRHtkT16TQSDP7sK2ghg=;
        b=Muo2oU+7jLviOMjIocKUQuONSJq/81rD30zfvKSamQ0AVWqLt8a51x4qnE4wJt2zX1
         OclgBOyPffL4LJq95MeCnBD3MwqsnM0wCgix5wlgIEKlwmExLf4Kz9uLrVYwfcrr4PVR
         HovWFIabH/ZRE7UMSiLwo88k4NamtppHYFeZrww+degJj3GnxtFDcvqlkgPhLqkdD4S5
         y+mT6iD0Z7oDelBcstLuSsi3hI9U3qzci/AS+7Wzbp4aOAqoGPmI2eluGS2o7wx3NVYO
         2NgcdPiv6BN5WNX0MLs56Pwsbwc2gwQM2YI3IRboVuXDBeLwImUSe/E1FYyQNOhV7H21
         drog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700721437; x=1701326237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMeECNyDeji/BB+8MMIjogxlRHtkT16TQSDP7sK2ghg=;
        b=YvCRifiRiI0c7cjPZSnu0oj3G1MKv747rprjLPAtali55vYEstaZvYuX7FPGLtgPkB
         NXfXx7lUBNS2JJwoUNPw+zxnSZJm37b3FzpoFq7EGBmvKIO2q8wNB+OURJhQD9fH+bzs
         eSWp4eeVQVjZOjtL1UPLavegg2558ncS0WzG4k9LSz9xJ4jM+iinzTAE1kW626YUKhhA
         Ismvkoiz5jQNM4rsg4R2/KG7ek37BioDzeF6wpf4klrGBKu6Bpxciyvbej4ADdHFxLUD
         fA1Ib2q6mPYztC4kSU4bl1VmQj7G95H6ucmnIEIeGCXuNQur4nWoICXv7VqeDET7IBeF
         f5zw==
X-Gm-Message-State: AOJu0Ywb/evVsW9Oq0VCyUhBrb+x1HRiADzoZoXjZ7sm7zzsueOk2mgZ
	Q+zNj/yV9XqGuLRTjzcAJ6nGww==
X-Google-Smtp-Source: AGHT+IE1osXWV0aT6oIEykZ25EpxXDmEFQWK3FZdm7b/dSuCgXD6hyvhxR2D4/L40NLQ4XMkgfi3DQ==
X-Received: by 2002:a05:6402:2691:b0:548:7a3a:ef39 with SMTP id w17-20020a056402269100b005487a3aef39mr3748091edd.35.1700721437121;
        Wed, 22 Nov 2023 22:37:17 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x1-20020aa7d381000000b00548ab1abc75sm296368edq.51.2023.11.22.22.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:37:16 -0800 (PST)
Date: Thu, 23 Nov 2023 07:37:15 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZV7zG63ukL8JYGve@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
 <ZVys11ToRj+oo75s@nanopsycho>
 <20231121095512.089139f9@kernel.org>
 <ZV3KCF7Q2fwZyzg4@nanopsycho>
 <20231122090820.3b139890@kernel.org>
 <ZV5GikewsOpDqHwK@nanopsycho>
 <20231122115055.0731c225@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122115055.0731c225@kernel.org>

Wed, Nov 22, 2023 at 08:50:55PM CET, kuba@kernel.org wrote:
>On Wed, 22 Nov 2023 19:20:58 +0100 Jiri Pirko wrote:
>> >I'm pretty sure I complained when it was being added. Long story.
>> >AFAIU user as in if the socket is opened by a kernel module, the kernel
>> >module is the user. There's no need to use this field for the
>> >implementation since the implementation can simply extend its 
>> >own structure to add a properly typed field.  
>> 
>> Okay, excuse me, as always I'm slow here. What structure are
>> you refering to?
>
>struct netlink_sock. Technically it may be a little cleaner to wrap 
>that in another struct that will be genetlink specific. But that's
>a larger surgery for relatively little benefit at this stage.

Got it. Will explore that path. Thanks!

