Return-Path: <netdev+bounces-51565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0097FB2E6
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFEAE1C20A37
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD1C13AD2;
	Tue, 28 Nov 2023 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Q6IhPwX/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CFA1AE
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:37:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b532b261bso2733428a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701157065; x=1701761865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6gVvfRNPtJ9hR1Q42xqDgJWHxAsSJew352v7XMd5+I=;
        b=Q6IhPwX/rwSFky2IvnsJsL0f6ZRCJRdpv5wcrgEfcPvJFEfPUQN5Uho5lTDpSROg49
         +tyhtaU73urGpb5pz6gMMfYvKjUIBefLxta4LNTzDrEP4wOVJsmrWaez9dCxG4Idz3DZ
         vgDIStelzenXVGgNNVhYQhPxGBLTH9dOZxLIIM50QOL4NquUq11ZCK5048n2E+fBGmCL
         JyiDuadxudV6ryX08SeznPNEVknJfardCfQrGGIydY+S+t7muCZVeT/8PtUfKRmtC9Py
         KZgaGe+LL6UxLKxpLoVMT5OnXse32uhVGio2zATqMe35RqdOxPLyRPt5RtPs3VV1OlVT
         9FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701157065; x=1701761865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6gVvfRNPtJ9hR1Q42xqDgJWHxAsSJew352v7XMd5+I=;
        b=o0sCU7qbH13u360THnvKsK/kJDiTZwEZWIAN7LQAkGBIarlly/l1N9Du/iZcjOBNU9
         qC8g49hE09beEPe54x4c2cV0229BxK+yk3wYzeKabFa/FBr2bLkoJjWGV1kO/q9hHL12
         COgP48dD1IskEd6VrzMgYFlsX0N033rBHdIP75jKvMvLu70MFayYiNo1M8UWZJKgKV7u
         ViXD3P7P7c8k8tcWfFjxohPcaVaKSIEmTjrdRIWStL99Sj+syzjSBKQdVqUGBJIIHAPX
         9LsOQset9qFJk7ZBkxiVmgSoRxvxBimC3iE4IVNPUztKMsxN7XRm5eDnvCFpKgYeSvCY
         LB0w==
X-Gm-Message-State: AOJu0Yz7k23Qg/keo2xEQ2acSlm5HnCV4666Lwx67lx5Wf+Q9xzTE/n7
	wk93jhOI3YCb+CEih7VQHdc6mt8AxO+3O17S/pB2zg==
X-Google-Smtp-Source: AGHT+IHAXJUbRXBLD3Z9+JAA4mWVgQhBtMGH+eJvQK3wdq7h5OaR9WMkkAhzTxCbBp5v+qc3JaetcA==
X-Received: by 2002:a05:6402:944:b0:54b:984b:6b53 with SMTP id h4-20020a056402094400b0054b984b6b53mr1598682edz.17.1701157064908;
        Mon, 27 Nov 2023 23:37:44 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b00548a57d4f7bsm6072332edt.36.2023.11.27.23.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:37:44 -0800 (PST)
Date: Tue, 28 Nov 2023 08:37:43 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Bahadur, Sachin" <sachin.bahadur@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net v4] ice: Block PF reinit if attached to bond
Message-ID: <ZWWYx18w2BnLyAZL@nanopsycho>
References: <20231127060512.1283336-1-sachin.bahadur@intel.com>
 <ZWRkN12fhENyN4PY@nanopsycho>
 <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB42574D2A64F2C4E42400213A96BDA@BY5PR11MB4257.namprd11.prod.outlook.com>

Mon, Nov 27, 2023 at 05:23:55PM CET, sachin.bahadur@intel.com wrote:
> 
>> Nack. Remove the netdev during re-init, that would solve your issue.
>> Looks like some checks are needed to be added in devlink code to make sure
>> drivers behave properly. I'm on in.
>
>Sure. This fix should apply to all drivers. Adding it in devlink makes more
>sense. I am not a devlink expert, so I hope you or someone else can
>help with it.

No, you misunderstood. I'll just add a check-warn in devlink for case
when port exists during reload. You need to fix it in your driver.

>
>> 
>> 
>> >+			return -EBUSY;
>> >+		}
>> > 		ice_unload(pf);
>> > 		return 0;
>> > 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
>> >--
>> >2.25.1
>> >
>> >

