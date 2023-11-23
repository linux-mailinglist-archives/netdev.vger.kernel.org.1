Return-Path: <netdev+bounces-50487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372D7F5F04
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D2E281CF4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 12:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E691424A07;
	Thu, 23 Nov 2023 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt2VFztN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C51A5
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:29:25 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cf74ad87e0so6591675ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 04:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700742565; x=1701347365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILlO5Ju9rH2opkKRRAf9sDu0NBM2kVszu1xEQ00T/z0=;
        b=Vt2VFztNIIZ18xHjmuSA91LSo3JzvqtNFVFjPdgSqDOESbFi+qsRTTWVf+7Oh63rbN
         KklE+NADRCaA3Kw+XNOy5LYXRFXdqURw+Qp136TwSVCPiJflAva4gPLztn45qgANVrCa
         3gfAnlXeoSKcrAHWIt8ZGQmFBXobRl9tM9XLp55BPEWE1wAxjKSIIoOAZUEcs0Cy+H05
         cfv3KbKVvsAHh7IrD/NPKh2RP3h/7c4AJTFOd+mW62t0B0cLo3JzSTDFtNeNBZNCGUCh
         +aUQukaQO2D74ULRUVCwYP688ditfqT9cVuF9qLZIw3iLbekhDOSQnWLbmZKzw1jBX7J
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700742565; x=1701347365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILlO5Ju9rH2opkKRRAf9sDu0NBM2kVszu1xEQ00T/z0=;
        b=Yjp/qdY7ReVeh+125m3Zid1JHGE3NIHmvRpKgjck2Q5hb7e6J2xM8rvlMPbmNVTuke
         S9OqwPurUOyfyr1th7cyVh4YOxz3Efx0r4Udy0tGlkZ92LrJx1Jabk2zzOvFwLvDkBOX
         FChAU3wbq3ccRxj6QcPE6+SDTkKsZMPYJCUfAhBzfP9mkkxrEyf+h3Dap2k6Ryb3V2hq
         5h5av0hvfn8tQ71Vo9vzgJlBX40TPDUfBn/jD2qAoL/PBRZRVLJK3DEF9jGCMOfueV/H
         rIsmNOz//TYPFdel6qjZMIyhtnV7LvGy+J3NfKup5bGmJdlf1S6jHmKsOHAx0QVqMFpZ
         QP+w==
X-Gm-Message-State: AOJu0Ywl23UJ+PVY28r/xI/lmHHQ45ZHJ+Ndj/toXfXnfObioD/jNgp4
	OmeRg5Ilo3G/9u84hv3NgkY=
X-Google-Smtp-Source: AGHT+IE1iE7RBu8GMn2U0cc1UwH2nHd9pucjqvQ6gcVhmKO5SkMfvCcHThns4O48X1qD45PdRJjCSg==
X-Received: by 2002:a17:902:ed4c:b0:1c7:5f03:8562 with SMTP id y12-20020a170902ed4c00b001c75f038562mr5742197plb.30.1700742565265;
        Thu, 23 Nov 2023 04:29:25 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.83.22])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001cc2f9fd74csm1238545plb.189.2023.11.23.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 04:29:24 -0800 (PST)
Date: Thu, 23 Nov 2023 17:59:18 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v3] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZV9FnjRH6VTwWaaX@swarup-virtual-machine>
References: <20231123100119.148324-1-swarupkotikalapudi@gmail.com>
 <ZV8lf8L8Me+T7iIW@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV8lf8L8Me+T7iIW@nanopsycho>
X-Spam-Level: *

On Thu, Nov 23, 2023 at 11:12:15AM +0100, Jiri Pirko wrote:
> Thu, Nov 23, 2023 at 11:01:19AM CET, swarupkotikalapudi@gmail.com wrote:
> >Add some missing(not all) attributes in devlink.yaml.
> >
> >Re-generate the related devlink-user.[ch] code.
> >
> >enum have been given name as devlink_stats(for trap stats)
> >and devlink_trap_metadata_type(for trap metadata type)
> >
> >Test result with trap-get command:
> >  $ sudo ./tools/net/ynl/cli.py \
> >   --spec Documentation/netlink/specs/devlink.yaml \
> >   --do trap-get --json '{"bus-name": "netdevsim", \
> >                          "dev-name": "netdevsim1", \
> >   "trap-name": "ttl_value_is_too_small"}' --process-unknown
> > {'attr-stats': {'rx-bytes': 47918326, 'rx-dropped': 21,
> >                'rx-packets': 337453},
> > 'bus-name': 'netdevsim',
> > 'dev-name': 'netdevsim1',
> > 'trap-action': 'trap',
> > 'trap-generic': True,
> > 'trap-group-name': 'l3_exceptions',
> > 'trap-metadata': {'metadata-type-in-port': True},
> > 'trap-name': 'ttl_value_is_too_small',
> > 'trap-type': 'exception'}
> 
> 1. You have to maintain 24 hours between submission of one
> patch/patchset:
> https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html
> 2. You didn't address my comment to last version
> 
Hi Jiri,

I have read the above link, but missed the constraint
of 24 hour gap between patches.
I will be careful and not send the patch again within 24 hours.

I could not understand your 2nd point.
Does it mean i should not include
test result e.g. "Test result with trap-get command: ...."
Or
If it is something else, please elabroate more, which helps me to address your comment.

I will try to clarify review comment, henceforth before sending new patchset for review.

Thanks,
Swarup

