Return-Path: <netdev+bounces-50225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB5D7F4F44
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAEF2814B3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF245C07A;
	Wed, 22 Nov 2023 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h7RY9xdG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EB31B5
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 10:21:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso107701a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 10:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700677260; x=1701282060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNDVBnjK4SKZBWySI3/3OXlEO0ThVPeUalrjXUetIak=;
        b=h7RY9xdGYBxOi6KpUIkips2qyKutq/vFgvKYebxo44fDHvSt9ZNPDK8Q92BccPE0Wd
         ER4Ai0QZf3+cpB6rxjR1HRpPd0MgKJg12ty/TDzeoVxHmJBgLaidlJRxOXhKQTrIPWX0
         nPBulM1Xys0OgUmF7b4A31G5Ofmc4vy+kPuTZT+bP/uuYjpPvGcbbPeoY1b/NfqOpBlK
         TDyeU4Co7u2knAowvLzG4NlIE6sM9bIq8Su7CHLSE3ZFD7qK4bSItnf7lW0/h+RUtNcj
         feqOJCc4+6XaSNXj7wNmpV/wpP6rgvRrToQwc/MVYnxzpKBlpCaFaclsJ/072Q22AMtW
         L6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677260; x=1701282060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNDVBnjK4SKZBWySI3/3OXlEO0ThVPeUalrjXUetIak=;
        b=DVJcxmfcbuy8TfCcLp6VvW+8IN8vFF8kvUBVhtcySadK+La03VEHvvem9D0NrhEjqb
         J1JqZh+VTFGZhx/akS7Vik3JOwgAr/xaXcZZZgHHKMIkCm5rhnJrb3xskwnGGmmMZha9
         g7bD7CRzcbpFKitUAJDltG1gXybAm7H0uCT6YlG+sxnbRkbn1WTowQByyxs9iuSaByDa
         jlCcduMzhmRJz8QScDbT9xxxEbe3stmWj9VSAfOsA800/S9IhCpvCA5PbmLIQthQEaNP
         yMdGyg5PsM2UTTohbo8f76RDVBgX7115rMPYql8DBQkw+0RwOkczovMQw7LBsglypqWG
         uilQ==
X-Gm-Message-State: AOJu0Yytwy+t/W1FZ1okigHeqpb349I1m9eA43yGVLZa4QtGevHkIrJ3
	3v2Sfr1+3SF5dETq39rVaCQO2w==
X-Google-Smtp-Source: AGHT+IFOphJWZF8PQw/kMk+nTuduIpA2YrNTCxMb95RxpsrbGCNZhoqylrz0KUevK4m0VpGx38k6bg==
X-Received: by 2002:a17:906:446:b0:a01:cb1b:f23c with SMTP id e6-20020a170906044600b00a01cb1bf23cmr1583338eja.59.1700677260175;
        Wed, 22 Nov 2023 10:21:00 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g16-20020a170906539000b009fd6a22c2e9sm50004ejo.138.2023.11.22.10.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:20:59 -0800 (PST)
Date: Wed, 22 Nov 2023 19:20:58 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZV5GikewsOpDqHwK@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
 <ZVys11ToRj+oo75s@nanopsycho>
 <20231121095512.089139f9@kernel.org>
 <ZV3KCF7Q2fwZyzg4@nanopsycho>
 <20231122090820.3b139890@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122090820.3b139890@kernel.org>

Wed, Nov 22, 2023 at 06:08:20PM CET, kuba@kernel.org wrote:
>On Wed, 22 Nov 2023 10:29:44 +0100 Jiri Pirko wrote:
>> >If you're doing it centrally, please put the state as a new field in
>> >the netlink socket. sk_user_data is for the user.  
>> 
>> I planned to use sk_user_data. What do you mean it is for the user?
>> I see it is already used for similar usecase by connector for example:
>
>I'm pretty sure I complained when it was being added. Long story.
>AFAIU user as in if the socket is opened by a kernel module, the kernel
>module is the user. There's no need to use this field for the
>implementation since the implementation can simply extend its 
>own structure to add a properly typed field.

Okay, excuse me, as always I'm slow here. What structure are
you refering to?

Thanks!

