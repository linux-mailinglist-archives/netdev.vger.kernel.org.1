Return-Path: <netdev+bounces-50406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB37F5A84
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B3BB20DC0
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195881B295;
	Thu, 23 Nov 2023 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="WuL6er7a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF6109
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:51:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548f6f3cdc9so915131a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700729503; x=1701334303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmNjb7O2iWdLq7Ddg8O2OpVn6WB2n2n0qyfFk5EH9vg=;
        b=WuL6er7a165vWYllkLyN8sngDJTyOuTGynfD1NayQqo+a8Yh+gwnVeCaTeSQRCQBe7
         lqou9RgivY3GNbNMNYRncdzXZcmrqsPHWO7fZExKmezpWqeblii7HTJWdsX50abSLa47
         AQGLn4Fr0I4JUq2ICbMyCSKKE47yPTaKFDNn0ur7I9r0+cq/W3W6k9a44DhFQMvmh5IM
         Qye2VeBOUDJEHN3RYuTxNAMBkqrFGRJE53y9NFoz4z+1pGtqGbJdbZFsOrPNU+6XwSyz
         qTJadi+Eg8bpuJVqyXsiIzeqanDwi2eiP7WzBcm5rCz6tWWNby0rFjfA/7A11wvfUDPE
         JlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700729503; x=1701334303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmNjb7O2iWdLq7Ddg8O2OpVn6WB2n2n0qyfFk5EH9vg=;
        b=jPKkNNKaPd5PvDVTP+NpPw1Kq4yfxqAZoIPOuOmYK/XVsHviHLnw2y2M64z9VEylCO
         +lml4JO53MO8+4AbbbY5CMDtC3apmCx8XP+sViat61iZ1AJwTVL1aRFQh3ccZwKgLbFg
         FPanbhSzZo5K6QUl26z/L6K8UTairdIFXQZH9ujSZnSDgCIU6ysLuYwIxfTZAMSHi2/r
         H79VvoEZBloDKUyNek3nY4yrZCbAb37SSLwcKNkU78K+Sa2W/x+PJm97puLuCpNM90R4
         02KC9dvh8/M58yKOoxb/wSNkrqfMrKNNNISdjwXtLr8qauG7Q/MWJ2Kh64kHFDLvx5eL
         9wPw==
X-Gm-Message-State: AOJu0YzjYMuYabJ2hofQmHxxsc6VBluI9pPhUNL4srK96T/VgtMaY+NU
	PRT2H+SekOeAa4FquPfDdJCNJg==
X-Google-Smtp-Source: AGHT+IGfWF+7a1dcF1cvHwp5dkWsyAs1sjpw82wpIksabk2Qn2QckdlpKCH50wfzypSiBlTAkKPlUg==
X-Received: by 2002:a05:6402:5156:b0:53e:3d9f:3c72 with SMTP id n22-20020a056402515600b0053e3d9f3c72mr3555085edd.18.1700729502999;
        Thu, 23 Nov 2023 00:51:42 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h7-20020a50ed87000000b005488703d13fsm395524edr.82.2023.11.23.00.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 00:51:42 -0800 (PST)
Date: Thu, 23 Nov 2023 09:51:41 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	mleitner@redhat.com, vladbu@nvidia.com, paulb@nvidia.com,
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH net-next RFC v5 4/4] net/sched: act_blockcast: Introduce
 blockcast tc action
Message-ID: <ZV8SnZPBV4if5umR@nanopsycho>
References: <20231110214618.1883611-1-victor@mojatatu.com>
 <20231110214618.1883611-5-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110214618.1883611-5-victor@mojatatu.com>

Fri, Nov 10, 2023 at 10:46:18PM CET, victor@mojatatu.com wrote:
>This action takes advantage of the presence of tc block ports set in the
>datapath and multicasts a packet to ports on a block. By default, it will
>broadcast the packet to a block, that is send to all members of the block except
>the port in which the packet arrived on. However, the user may specify
>the option "tx_type all", which will send the packet to all members of the
>block indiscriminately.
>
>Example usage:
>    $ tc qdisc add dev ens7 ingress_block 22
>    $ tc qdisc add dev ens8 ingress_block 22
>
>Now we can add a filter to broadcast packets to ports on ingress block id 22:
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action blockcast blockid 22

Name the arg "block" so it is consistent with "filter add block". Make
sure this is aligned netlink-wise as well.


>
>Or if we wish to send to all ports in the block:
>$ tc filter add block 22 protocol ip pref 25 \
>  flower dst_ip 192.168.0.0/16 action blockcast blockid 22 tx_type all

I read the discussion the the previous version again. I suggested this
to be part of mirred. Why exactly that was not addressed?

Instead of:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action blockcast blockid 22
You'd have:
$ tc filter add block 22 protocol ip pref 25 \
  flower dst_ip 192.168.0.0/16 action mirred egress redirect block 22

I don't see why we need special action for this.

Regarding "tx_type all":
Do you expect to have another "tx_type"? Seems to me a bit odd. Why not
to have this as "no_src_skip" or some other similar arg, without value
acting as a bool (flag) on netlink level.



