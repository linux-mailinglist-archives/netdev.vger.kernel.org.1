Return-Path: <netdev+bounces-52150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25EE7FD9D7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EF4B217D5
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC3E1E53C;
	Wed, 29 Nov 2023 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i0yLVIMq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63B19B1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:41:34 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54af0eca12dso7575799a12.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701268893; x=1701873693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yyYsrVXR9VfHQeLrjs7Rji7raTyh+wNRCcIFYzXejwI=;
        b=i0yLVIMqpNVNX8hyANt/h0YDDvl9K0JE2SkT4Er90fHaikUj6P8pG6vtu5qr3jZVOr
         BL4yWpHW7g2kjSWmtR0F0Ex6suH0Lx0aEmUUBBFxgQV/aj2nM6gLjJR7eZs4wuHrQLyA
         S4VsZuev7LLUXSnr54yPTnYn+CFwc4oQbu0Yf3X5FTjqfjM6gys3wCJNAllaugErfTQj
         8RROMH7ABa+p2bztqnJ882iTs/I3hmCUwUOjB8JOWB2KB6RNqBc8nr6meIVgGfpbtqRB
         w4g1WTQi2/O4wwTlPhAYexTt0UuCHDDHplZBLrSepPrO5IT46HiKl3jWMFoi3TAO0DQo
         tkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701268893; x=1701873693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyYsrVXR9VfHQeLrjs7Rji7raTyh+wNRCcIFYzXejwI=;
        b=ZKTh7FxLffzL/+3KZ2gL5tijSii+ZQ6Hw0PJd2QwWpqhY0zFyaT6CynYA39WDkuWgG
         E8EZyztpM33vWB8h5yuvl0N7cLxnOn0ApdT8UYz2MQR59sgl+IaVB4ZN7e3ox0flnRZS
         A/JD/YbLUZmLKbw/SH/q32gvrGTx2tecLQmgkd/iV2kLVWN/hutJNZW2df+9GIaFxeCq
         y0CpHa6d1ADFd01v3AGyq72pGYtQecTtJTxdj8fpaYL0ChZmRW+y/BNtqUmZWunXiksY
         MYmXNHvpYUQv0YndPJb2TFCuJutbWiOBISULKIP3nB+PErWC5hg2QDE3+jhg3awhbI06
         sOuw==
X-Gm-Message-State: AOJu0YxMG8rof9zYCCViDo1aabxEOmvotfOk3hC9rJhnIitU5kfLXgNZ
	bvhSOB+IbyxVbhxiQN8xLu10eUrhmr65bndm8fU=
X-Google-Smtp-Source: AGHT+IHbWCQjyNsC/fDqwswBwuL8Ht4forXS21KOSAiBuCRNt8Yv7qu5c2eiDsLfudjMrXbWoHZ7aw==
X-Received: by 2002:a50:cd9d:0:b0:54b:5243:f7d6 with SMTP id p29-20020a50cd9d000000b0054b5243f7d6mr7475815edi.32.1701268893292;
        Wed, 29 Nov 2023 06:41:33 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id o24-20020aa7c7d8000000b005432f45bee9sm7311740eds.19.2023.11.29.06.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:41:32 -0800 (PST)
Date: Wed, 29 Nov 2023 15:41:31 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Bahadur, Sachin" <sachin.bahadur@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWdNm5pnmZsrO874@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
 <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
 <ZWWYx18w2BnLyAZL@nanopsycho>
 <BY5PR11MB42574A519BF05AF80BC03E1A96BCA@BY5PR11MB4257.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB42574A519BF05AF80BC03E1A96BCA@BY5PR11MB4257.namprd11.prod.outlook.com>

Tue, Nov 28, 2023 at 06:45:47PM CET, sachin.bahadur@intel.com wrote:
>
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: Monday, November 27, 2023 11:38 PM
>> To: Bahadur, Sachin <sachin.bahadur@intel.com>
>> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
>> 
>> Mon, Nov 27, 2023 at 05:23:55PM CET, sachin.bahadur@intel.com wrote:
>> >
>> >> Nack. Remove the netdev during re-init, that would solve your issue.
>> >> Looks like some checks are needed to be added in devlink code to make
>> >> sure drivers behave properly. I'm on in.
>> >
>> >Sure. This fix should apply to all drivers. Adding it in devlink makes
>> >more sense. I am not a devlink expert, so I hope you or someone else
>> >can help with it.
>> 
>> No, you misunderstood. I'll just add a check-warn in devlink for case when port
>> exists during reload. You need to fix it in your driver.
>
>
>What should be fixed in my driver. Can you clarify ? 
>And are suggesting I add the check-warn in devlink code ?

Remove the netdev during re-init.


>
>
>> >
>> >>
>> >>
>> >> >+			return -EBUSY;
>> >> >+		}
>> >> > 		ice_unload(pf);
>> >> > 		return 0;
>> >> > 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>> >> >--
>> >> >2.25.1
>> >> >
>> >> >

