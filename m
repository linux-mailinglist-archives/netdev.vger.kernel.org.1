Return-Path: <netdev+bounces-49554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB407F2671
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF40D1C209A7
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0242232D;
	Tue, 21 Nov 2023 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KGbWFXgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECB2C3
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:35:30 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso7575670a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700552129; x=1701156929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uuWipXU1pTJUx2Ouhcv9qxRYLEZVQlyVgnwlBWMH0Ok=;
        b=KGbWFXgzlRtV4nw6QB3Bkc9C76l7rqb5L5CILfW9vCH60nryN7dfsMRmg0GKmR0J26
         UBjs1U5Q7zdd1vAo/xqWwgRWsHrb0tGb3HJ4TPEjfVMhjNadgBejE39daRA1YLM93aU2
         Njm0nyjWOVDYtwmzKZtgklyXgdq8tUBJxjBTWR1E+cT5Ouz6n4Y1FPAGMhcJM3frboXa
         S9nJRzPP+2vWSBf0l0C5M9bk8vwdbW7b53Ms2Y+CEXv1AoPG5gFsBBcxi84Ui5dSVV68
         x0GNpTGBX46PEyIhe3KgbRRQCFi3eruLwGFsShB4XYcKNI+WOVKGDJtYQYYNtXLMxAsw
         krmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552129; x=1701156929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuWipXU1pTJUx2Ouhcv9qxRYLEZVQlyVgnwlBWMH0Ok=;
        b=Qf3N6C4dxmbOTMYzEZV86eqD0kQhCIVKC3xbxJycNXbzqs7TdXouEBmCODUxMBdpOy
         9DLTLjUFHFBv8I224SU3WA8zbriKfJuiFLviLtkog2b6amO5hKIQB6RgkRqGJ1TbBMMp
         hym3b3aRiHrfqoG9jtcVrq9KLYBD6ohDGi9go7D2AI/vIbrZJo0yRR5S13n3D1iucehR
         0tZvSXNKYVbPirEHFmUFv/WIT/Sgy2csPqt6W8aRgfnQai/JuIppzeb2+1Y2/ihp4J2G
         EEW5/Ip4L68/H2Tv2+nplZ2CYuAPAj/1LBcrzsbxyICnaA3uY6BkMVbyqCyS9jiFQzHm
         Rdlw==
X-Gm-Message-State: AOJu0YyPDhd/8sdbWzPSJN3NuiORxPujzmJ75cBQb/h/eXZgXpsJoSV/
	rHkUqHgps52Rq1jSXtG4O1GZ7Q==
X-Google-Smtp-Source: AGHT+IE4L4LDoQIAhSnc8zNihkJ/hcQeRmYrurfihNMtqJOtqTXLCaveiIRMiXGFDIzdJdiVhEkvdg==
X-Received: by 2002:a17:906:c80a:b0:9fd:cc75:3393 with SMTP id cx10-20020a170906c80a00b009fdcc753393mr4286068ejb.20.1700552129135;
        Mon, 20 Nov 2023 23:35:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id j19-20020a1709062a1300b00a0029289961sm1342577eje.190.2023.11.20.23.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:35:28 -0800 (PST)
Date: Tue, 21 Nov 2023 08:35:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
	johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org
Subject: Re: [patch net-next v3 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Message-ID: <ZVxdv9tkZ/QE5bUZ@nanopsycho>
References: <20231120084657.458076-1-jiri@resnulli.us>
 <20231120084657.458076-9-jiri@resnulli.us>
 <20231120185123.020ad0a2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120185123.020ad0a2@kernel.org>

Tue, Nov 21, 2023 at 03:51:23AM CET, kuba@kernel.org wrote:
>On Mon, 20 Nov 2023 09:46:56 +0100 Jiri Pirko wrote:
>> +	if (attrs[DEVLINK_ATTR_BUS_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_BUS_NAME]) + 1;
>> +	if (attrs[DEVLINK_ATTR_DEV_NAME])
>> +		data_size += nla_len(attrs[DEVLINK_ATTR_DEV_NAME]) + 1;
>
>> +	/* Don't attach empty filter. */
>> +	if (!flt->bus_name && !flt->dev_name) {
>
>Should the attrs be checked with GENL_REQ_ATTR_CHECK() then?

No, they are all optional. This is for the case the user passes empty
message, that clears the filter.

