Return-Path: <netdev+bounces-50603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4092F7F6467
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4D6FB20E1A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9B3D39F;
	Thu, 23 Nov 2023 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PSUiqdrN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDECBA
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:53:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5094727fa67so1451150e87.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700758422; x=1701363222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9InQJBGSHQE6z+ySU2vBTT+5U+O4Ov6cqbtR8heLbv0=;
        b=PSUiqdrNl589NiZpnn2+WaqlFch19oEJaOIumfj03iK36cIinbZVsSBSQLCEkscPLX
         GPQ+LWyUbMkd2lnFY8Oba6ISxYwDk4HM7DFXw/8PZIjk0Vf5iQilUyV+9gkJmjjWmU8W
         TfHAJXvfkYMpvuapACQ/whI5Bhmpmc1rhOcU8NUbPEaBEfYnWmtaeE6FluisHr3ev3uB
         VUuZZYIFzjhTLOu9jsYESGnw1J1F9+VYH/tMT6l/b8FqzE+67s2rC7lt+dmQl1q7MAyL
         e3m6ntMdKS49rnaEt8Rp8fi8XaK9uvii9kQVE8jrJuB1USQg6of+MW6vExsueqGDb6sK
         UHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700758422; x=1701363222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9InQJBGSHQE6z+ySU2vBTT+5U+O4Ov6cqbtR8heLbv0=;
        b=bKIVETNFUAHtRC45PwWKMbKPCTltrYb/bRc6OAbUTlB3ttAtS/6UDhPYvzVjLvZ93j
         P5g6u/46oyxu36me516RDOab6wQNRPblwRRNPVjUJzGUlVmpCPI2LInWYaEqV6cxIwni
         3FfEylE0R3HRgZRZBO+YgiEe+S5DbgpoCGvzpdM8ucfIFlHKohClfh2MfXwjgOt5s+H2
         AUoi6H99wqV+pppybpJp2ROKsSOulPkRkEX6VLbBm6cByQx+BVXww7TTrRDFUG/YWXMC
         zEbtgfADulcIPjSlu15S5KwBuyOoGqzEihrqFXxdGz7ReFHm2GqL3I7eUVUNGgpOPsDg
         6Oug==
X-Gm-Message-State: AOJu0YzI4J+zha8KMKqtFzqyh0rZ+GHtm7+w6q6QZoCbmJ/bSJwy/EXf
	Ac0k16qkpMEA3eGtSCpFpHV+E0/0uu5JTy0TNkk=
X-Google-Smtp-Source: AGHT+IEQB0ui4iEi/u9Z8sjtfBCql0Qrqavv/zQ/94GFUXCf9YopwWjQZn6UXqSKI1ab5KExmbag5w==
X-Received: by 2002:a05:6512:480f:b0:507:98d0:bec4 with SMTP id eo15-20020a056512480f00b0050798d0bec4mr3938261lfb.54.1700758422443;
        Thu, 23 Nov 2023 08:53:42 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906184800b009fca9484a62sm971388eje.200.2023.11.23.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 08:53:41 -0800 (PST)
Date: Thu, 23 Nov 2023 17:53:40 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 5/9] genetlink: implement release callback
 and free sk_user_data there
Message-ID: <ZV+DlMsFnTibDbBh@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-6-jiri@resnulli.us>
 <20231120185022.78f10188@kernel.org>
 <ZVys11ToRj+oo75s@nanopsycho>
 <20231121095512.089139f9@kernel.org>
 <ZV3KCF7Q2fwZyzg4@nanopsycho>
 <20231122090820.3b139890@kernel.org>
 <ZV8qJ1QX9vz3mfpT@nanopsycho>
 <20231123082408.0c038f30@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123082408.0c038f30@kernel.org>

Thu, Nov 23, 2023 at 05:24:08PM CET, kuba@kernel.org wrote:
>On Thu, 23 Nov 2023 11:32:07 +0100 Jiri Pirko wrote:
>> In this case, the socket is not opened by kernel, but it is opened by
>> the userspace app.
>> 
>> I basically need to have per-user-sk pointer somewhere I'm not clear why
>> to put it in struct netlink_sock when I can use sk_user_data which is
>> already there. From the usage of this pointer in kernel, I understand
>> this is exactly the reason to have it.
>
>Various people stuck various things in that pointer just because,
>it's a mess. IIUC the initial motivation for it is that someone
>like NFS opens a kernel socket and needs to put private data
>somewhere. A kernel user gets a callback for a socket, like data
>ready, and needs to find their private state.
>
>> Are you afraid of a collision of sk_user_data use with somebody else
>> here? I don't see how that could happen for netlink socket.
>
>Normally upper layer wraps the socket struct in its own struct. 
>Look at the struct nesting for TCP or any other bona fide protocol. 
>genetlink will benefit from having socket state, I bet it wasn't done
>that way from the start because Jamal/Thomas were told to start small.
>
>Please add a properly typed field to the netlink struct, unless you
>have technical reasons not to.

Okay.

