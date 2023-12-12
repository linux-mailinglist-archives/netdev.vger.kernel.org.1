Return-Path: <netdev+bounces-56578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E180F7B6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F77B20E13
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364B963BF7;
	Tue, 12 Dec 2023 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQNESLnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8710F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:17:10 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b86f3cdca0so4560632b6e.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702412230; x=1703017030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1UBrFX+DTYouJbi/tR2BkpUd/1V1Kg/oxo4WYh77rA=;
        b=mQNESLnjrwYqu4QYEqIk+KtoaH5yfM4+VDC6SOCy+PKrdRwmCTmvKrMSp3yfhdgCOc
         XlBmX3rIm16U+cWuJ8u42PhYduhzfdixupYI0eXU9iG6MwJIXw6brnD8MG45FNRWisyI
         MnAsc2DFJykdR+a34jgwHCoGSBH+S8auLP7C2LclfYsZxMJOo85W0SdVMbU0+04bSAXJ
         rh8SnIsp/SXCydpbGq/apkHvmb3CvRG6jflmVPUfOf6PYNiYfNx6SyizVq3cjpZZdOy0
         yt/R8gBX+bc/oqCs8GWDpfvWI7m4FDcVjpbyjNFc2syD6gWrRgZb4ucmZF3upLjZvilV
         ovYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702412230; x=1703017030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1UBrFX+DTYouJbi/tR2BkpUd/1V1Kg/oxo4WYh77rA=;
        b=C6c9gFEFag5HKQ4kOEFxK0xXPbesiCkd79vlm8qCqSEJeMzRo0rAmE5lBGrRq1sTds
         rRmU8LYSXJYglIXwx5vkGvcGc/1MxVf8PS2HQxJPEL6TNzgLS36gErxbkZ4Q2YPisJ9m
         /0pthpf32qdZWh73grSC0KsWk5TaYwGGN3LkoFFF9DYARIIuQCkYwkeZz/Kib3BBWfJc
         oVm5/oxTAoMPS9xQpHOjcZt+RnC+MKEW7HKobidC2iNkswGLhAup+Q/sOalBsCoyzdSv
         EH9FGgwGPRbGD70/H9FN9NKfNKdmEf+NhM9wG+Bacq0t4/L0XtReVqtCKcCiX7hThNOI
         +ZWA==
X-Gm-Message-State: AOJu0YyG9Tk3vOKoHn1JsxbawKQGOfVY0oFyYJqg7hub5SmsH2kG3lye
	vIOD3BS64K5XjVHQJv/mqpA=
X-Google-Smtp-Source: AGHT+IHeaNMzX6VkJTNMTiKD4aMWY24pEjbyKTJv+IbheTjMkVXvgt4awh/CiNOXiQMId2A1MqXSbg==
X-Received: by 2002:a05:6870:e305:b0:1fb:75b:1302 with SMTP id z5-20020a056870e30500b001fb075b1302mr7956885oad.84.1702412230019;
        Tue, 12 Dec 2023 12:17:10 -0800 (PST)
Received: from localhost ([69.156.66.74])
        by smtp.gmail.com with ESMTPSA id v10-20020ad4528a000000b0067ef3341c77sm227822qvr.39.2023.12.12.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 12:17:09 -0800 (PST)
Date: Tue, 12 Dec 2023 15:17:01 -0500
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Petr Machata <petrm@nvidia.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jonathan Toppins <jtoppins@redhat.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXi_veDs_NMDsFrD@d3>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs07mi0w.fsf@nvidia.com>

On 2023-12-12 18:22 +0100, Petr Machata wrote:
> 
> Hangbin Liu <liuhangbin@gmail.com> writes:
> 
> > On Mon, Dec 11, 2023 at 01:01:06PM +0100, Petr Machata wrote:
> >
> >> @@ -38,7 +38,7 @@ if [[ -f $relative_path/forwarding.config ]]; then
> >>  	source "$relative_path/forwarding.config"
> >>  fi
> >>  
> >> -source ../lib.sh
> >> +source ${lib_dir-.}/../lib.sh
> >>  ##############################################################################
> >>  # Sanity checks
> >
> > Hi Petr,
> >
> > Thanks for the report. However, this doesn't fix the soft link scenario. e.g.
> > The bonding tests tools/testing/selftests/drivers/net/bonding add a soft link
> > net_forwarding_lib.sh and source it directly in dev_addr_lists.sh.
> 
> I see, I didn't realize those exist.
> 
> > So how about something like:
> >
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 8f6ca458af9a..7f90248e05d6 100755
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -38,7 +38,8 @@ if [[ -f $relative_path/forwarding.config ]]; then
> >         source "$relative_path/forwarding.config"
> >  fi
> >
> > -source ../lib.sh
> > +forwarding_dir=$(dirname $(readlink -f $BASH_SOURCE))
> > +source ${forwarding_dir}/../lib.sh
> 
> Yep, that's gonna work.
> I'll pass through our tests and send later this week.
> 

There is also another related issue which is that generating a test
archive using gen_tar for the tests under drivers/net/bonding does not
include the new lib.sh. This is similar to the issue reported here:
https://lore.kernel.org/netdev/40f04ded-0c86-8669-24b1-9a313ca21076@redhat.com/

/tmp/x# ./run_kselftest.sh
TAP version 13
[...]
# timeout set to 120
# selftests: drivers/net/bonding: dev_addr_lists.sh
# ./net_forwarding_lib.sh: line 41: ../lib.sh: No such file or directory
# TEST: bonding cleanup mode active-backup                            [ OK ]
# TEST: bonding cleanup mode 802.3ad                                  [ OK ]
# TEST: bonding LACPDU multicast address to slave (from bond down)    [ OK ]
# TEST: bonding LACPDU multicast address to slave (from bond up)      [ OK ]
ok 4 selftests: drivers/net/bonding: dev_addr_lists.sh
[...]

