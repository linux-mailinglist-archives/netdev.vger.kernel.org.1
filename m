Return-Path: <netdev+bounces-48249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594437EDBCA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B98C2B20A2F
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 07:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157E9476;
	Thu, 16 Nov 2023 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pa58+s09"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B3819E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:10:17 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so666616a12.2
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700118616; x=1700723416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hfjAFBZcfcyOqRIQVSZY7svBJFaZ1VA+o96mKhaCOE=;
        b=pa58+s09EkwEIF57W7i1wMtBuyU2aiRquUMZMWD4FilSUP2mHunV0sudFlHW6XkezZ
         Z2GHljwvz1U0eYdrEoiQjxNo3T0RfPmQNU6Y/yesf9CF276hfXB/L8yW1+/hRqSP6pBk
         zuaAtwmt+iPle0uGyvg+VuZwdx1jFpJ3iPU1Sb+mpsQ4++cAgSWAQVfQSHRyTGAYWXPH
         ytQ5g8j42MQIojEwz6iFeByuSdZEfqRa5KZ1VeAZp7Uo9VoT/FAN6GBomidh3l2s9R60
         NjcTok0rjNcm3zW4gbvOcOimawT+Yhr+SaX7jn1nP7MUwsxWeudqrHytgpFxLatkKtKZ
         EMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700118616; x=1700723416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hfjAFBZcfcyOqRIQVSZY7svBJFaZ1VA+o96mKhaCOE=;
        b=Fbi4izhxNKuVrNKjDmrNp3blwUnL2C/hdzEWCat7V5GYhyPRfPBnpe79291XRxqM9+
         87axIvOt6woaL+wLA9SzxNuTdkjuxkc0F9rM7yDQ9/i+KhlBNaY7WLra0jy4n5J1IBez
         IP/+d7oNOSKIaJ1sMEG8v4M2cFTnFFWu7cavZfoeZDfVfHJxbmY8npzXr21ULqLhlE1o
         KJIb61A/dVasIKJcymyY8abzQKNCwW7oX4lqhG7+tf8PtQ4wQwWRlu6FVDMeKJ9txCuo
         FpZZ8IpsP9bVON8Vcvz5ODasi1S4v9No+i1jynNZUfVhEjn2YTfSx6d1YKO+m79KqDAV
         XNwA==
X-Gm-Message-State: AOJu0YxgW8CYvyJC7W0UF6g65a/LueJhmpimkdGReE2vGML8d10lfcJr
	NqEPORbLVl8um3+NNWxngJ1UwC4ldmKNAKDphZQ=
X-Google-Smtp-Source: AGHT+IEoVaWJ+jUdCvXS5zbNJ+l+mryOu1HFXknC3cdVOooaIQH4PNZshtlqXMB0o+u9w5Bo/7KJVg==
X-Received: by 2002:a17:906:4158:b0:9b2:b786:5e9c with SMTP id l24-20020a170906415800b009b2b7865e9cmr11154284ejk.28.1700118616237;
        Wed, 15 Nov 2023 23:10:16 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id cd4-20020a170906b34400b009c3827134e5sm8036770ejb.117.2023.11.15.23.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 23:10:15 -0800 (PST)
Date: Thu, 16 Nov 2023 08:10:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
	jhs@mojatatu.com, johannes@sipsolutions.net,
	amritha.nambiar@intel.com, sdf@google.com
Subject: Re: [patch net-next 8/8] devlink: extend multicast filtering by port
 index
Message-ID: <ZVXAVnJQzOKXlUlO@nanopsycho>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-9-jiri@resnulli.us>
 <ZVTe_nJ_0N4KnDkd@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTe_nJ_0N4KnDkd@smile.fi.intel.com>

Wed, Nov 15, 2023 at 04:08:46PM CET, andriy.shevchenko@linux.intel.com wrote:
>On Wed, Nov 15, 2023 at 03:17:24PM +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Expose the previously introduced notification multicast messages
>> filtering infrastructure and allow the user to select messages using
>> port index.
>
>...
>
>>  	struct {
>>  		__u32 bus_name_len;
>>  		__u32 dev_name_len;
>> +		__u32 port_index:1;
>
>From this context is not clear why others are not bitfields.

Tell it to the generator :)


>
>>  	} _present;
>>  
>>  	char *bus_name;
>>  	char *dev_name;
>> +	__u32 port_index;
>
>-- 
>With Best Regards,
>Andy Shevchenko
>
>

