Return-Path: <netdev+bounces-48651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6A7EF1A1
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685381F28728
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C1C1A290;
	Fri, 17 Nov 2023 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gy8FeT/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1355A1AD
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 03:21:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso265472866b.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 03:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700220070; x=1700824870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eHIsjVFizKvIbQl8U+CvUzO8VVtyUgWU0JIxQXuswVo=;
        b=gy8FeT/vb/riYsHKWQeemZsHomzhzwpmgCzTAtqWIL9rd1cDsOC2TxVGT3BG8rNvst
         BCj3SvSnMMezFEL1WfXFUFitHRd7nUjDb3G3BA9NHop4eouv559tpvyeaSGtJDOhdPtU
         y9hqxOaduYoW+390RDrwLRalX52X04YzpToOV+aNuZzUkaMSb641wObOD46nH1zmxyeD
         +7IpHJ7Tdi2qPsyCzrq90fFxXBHYP3cexkBSZOoJXvzC+FFCDLoGrRd+tINm6qyOFX6k
         CxJa0d1Bd4xbAI2jtEDyu1KX1q4FoPbB3Lp8v6uMOFLNK+Jfbth1x4ptkqSr1Bg6NJxA
         WS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700220070; x=1700824870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eHIsjVFizKvIbQl8U+CvUzO8VVtyUgWU0JIxQXuswVo=;
        b=kA8BX5Jq+hjJcbBYWeURcF/piIpMr0nJhcWbkQimjV+TuLV5JaO7v9EupekEwGB9xY
         uBcMElxlYzbI7xaeUYx5gOshdXCt1Xmp0GUdbxGrbqRiMa4glAiw+K2Y+5Dc/16RTxZ+
         Um22XkXgOzFBIqC82LXSTN7BTecmkpzd8wPsn0z7zuUENHCqTB+n/EC3020fERz2JaQH
         7OCyvPG8cSrHUnf0ekiO1UeK9nEO11eG3059WhcRagADKwNhQBLIlH+UHGAjP0KmTveu
         tceGfPytf/lGIT99pU05hRsmaIyLKaJq+PPX1mBJyQVFv87IPpdoEiTZgcilEjhgGFS6
         p2Ww==
X-Gm-Message-State: AOJu0Yxvy4ykVz2S/ck9Da5UGJSRaGzLN2plo2Jnc/B//nhnAcHlJLWg
	ddyjDIUfALQV/dkh25ztHV6q4A==
X-Google-Smtp-Source: AGHT+IH35q7ljA6W7fdY8McRtLg6kQqnqRXP0n88dr4WEhfMowxfS+GOWBModH14HMBc8PwitCqbWQ==
X-Received: by 2002:a17:906:37c7:b0:9a1:f81f:d0d5 with SMTP id o7-20020a17090637c700b009a1f81fd0d5mr3513420ejc.54.1700220070193;
        Fri, 17 Nov 2023 03:21:10 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gr2-20020a170906e2c200b0099d45ed589csm671223ejb.125.2023.11.17.03.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 03:21:09 -0800 (PST)
Date: Fri, 17 Nov 2023 12:21:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "Zhang, Xuejun" <xuejun.zhang@intel.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, qi.z.zhang@intel.com,
	Jakub Kicinski <kuba@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>,
	maxtram95@gmail.com, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	pabeni@redhat.com
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <ZVdMpLz1LPfMyM8S@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
 <ZORRzEBcUDEjMniz@nanopsycho>
 <20230822081255.7a36fa4d@kernel.org>
 <ZOTVkXWCLY88YfjV@nanopsycho>
 <0893327b-1c84-7c25-d10c-1cc93595825a@intel.com>
 <ZOcBEt59zHW9qHhT@nanopsycho>
 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>

Fri, Nov 17, 2023 at 06:52:49AM CET, xuejun.zhang@intel.com wrote:
>Hello Jiri & Jakub,
>
>Thanks for looking into our last patch with devlink API. Really appreciate
>your candid review.
>
>Following your suggestion, we have looked into 3 tc offload options to
>support queue rate limiting
>
>#1 mq + matchall + police

This looks most suitable. Why it would not work?

>
>#2 mq + tbf
>
>#3 htb
>
>all 3 tc offload options require some level of tc extensions to support VF tx
>queue rate limiting (tx_maxrate & tx_minrate)
>
>htb offload requires minimal tc changes or no change with similar change done
>@ driver (we can share patch for review).
>
>After discussing with Maxim Mikityanskiy( https://lore.kernel.org/netdev/54a7dd27-a612-46f1-80dd-b43e28f8e4ce@intel.com/
>), looks like sysfs interface with tx_minrate extension could be the option

I don't undestand how any sysfs know is related to any of the tree tc
solutions above.


>we can take.
>
>Look forward your opinion & guidance. Thanks for your time!
>
>Regards,
>
>Jun
>
>On 8/28/2023 3:46 PM, Zhang, Xuejun wrote:
>> 
>> On 8/24/2023 12:04 AM, Jiri Pirko wrote:
>> > Wed, Aug 23, 2023 at 09:13:34PM CEST, xuejun.zhang@intel.com wrote:
>> > > On 8/22/2023 8:34 AM, Jiri Pirko wrote:
>> > > > Tue, Aug 22, 2023 at 05:12:55PM CEST,kuba@kernel.org  wrote:
>> > > > > On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
>> > > > > > NACK! Port function is there to configure the VF/SF from the eswitch
>> > > > > > side. Yet you use it for the configureation of the
>> > > > > > actual VF, which is
>> > > > > > clear misuse. Please don't
>> > > > > Stating where they are supposed to configure the rate
>> > > > > would be helpful.
>> > > > TC?
>> > > Our implementation is an extension to this commit 42c2eb6b1f43
>> > > ice: Implement
>> > > devlink-rate API).
>> > > 
>> > > We are setting the Tx max & share rates of individual queues in a
>> > > VF using
>> > > the devlink rate API.
>> > > 
>> > > Here we are using DEVLINK_PORT_FLAVOUR_VIRTUAL as the attribute
>> > > for the port
>> > > to distinguish it from being eswitch.
>> > I understand, that is a wrong object. So again, you should use
>> > "function" subobject of devlink port to configure "the other side of the
>> > wire", that means the function related to a eswitch port. Here, you are
>> > doing it for the VF directly, which is wrong. If you need some rate
>> > limiting to be configured on an actual VF, use what you use for any
>> > other nic. Offload TC.
>> Thanks for detailed explanation and suggestions. Sorry for late reply as
>> it took a bit longer to understand options.
>> 
>> As sysfs has similar rate configuration on per queue basis with
>> tx_maxrate, is it a viable option for our use case (i.e allow user to
>> configure tx rate for each allocated queue in a VF).
>> 
>> Pls aslo see If adding tx_minrate to sysfs tx queue entry is feasible on
>> the current framework.
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan@osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

