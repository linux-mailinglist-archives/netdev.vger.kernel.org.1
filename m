Return-Path: <netdev+bounces-60731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CE821514
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72A1281A31
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 18:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E83D520;
	Mon,  1 Jan 2024 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T81FQEzC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE27D51A
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d480c6342dso29169255ad.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 10:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704135383; x=1704740183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUSFOJmtAZhrDdrJO49Vcl3nkKtsJZro2T4EYx3QlqQ=;
        b=T81FQEzC6DTNZNdlsi+h8gbi4sgoM2+7cT1xqo1hPyevetVOEz7WkNinIVznhJDBWa
         HRLkJ95X3B07TqyjeHqketYp7iAVeDXyE8c1z/twBMamggQzdsnPf2GoUhBEPwcybVFO
         /nFBNVghWQn3Rqq5yK5g14K9A7lUVK1hyrQKnhhB/RdTSwQKpT/Yakfb9UzkSzbkPYi2
         DUbcYz4MWITYQZkzyIK1ez0nWbotxYA/0V6MfF3iaLZNDAM85tfUd7rmZWN4+BtO/D7s
         QHjzgK29qky22FqdvlHvvBcW/Al9h8fDsteczjBUtWJUrat05Jb+YEOHxet/r1QFsouV
         gBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704135383; x=1704740183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUSFOJmtAZhrDdrJO49Vcl3nkKtsJZro2T4EYx3QlqQ=;
        b=V6hsldGY903wcNBmfOghol3pezt8XdLpSjT76LxxKURusTCQrmhfSn9htJMUu5pJS4
         wVOkVuPjv5rsiZUW6EhPUx4cycQmjt84n8kUHJ9gf29zH850faKEvWFPsGc53Tdqq+Ta
         coZiHnrgYcCKiAHd7rmRSO9L40tVZAuyOj01n2TsJEm2lxaP8RySlfIPBMkuFUkyKnL3
         SlTi2xCtOZSMrVoWsqg/ncdXGbv/UyUMpEdMf6ddMwwowUPF8kmeJ18grYNbmiUWYn7Q
         YA7f+UIAx7y8cOw4G5rjWNzPDQHtFDnyFwosZkAWGvU58xpDWGRpr1CxrbK+U11LYFUM
         dkJw==
X-Gm-Message-State: AOJu0YzM0z2oNvxpt4xrOXmVR1IeC5RRfx8piIicMFBJE06OPwoMs83M
	T01Hfy5SiLbv5A/Sg23BnaY=
X-Google-Smtp-Source: AGHT+IGPxN2r+svb+EaCUpo5wQtp64FeYKKIE7ruL1H5jVTIHdmpjRQAGvIUGqiTxk+vpetOYtM6Yg==
X-Received: by 2002:a17:902:e812:b0:1d4:be53:ac54 with SMTP id u18-20020a170902e81200b001d4be53ac54mr1594393plg.79.1704135382882;
        Mon, 01 Jan 2024 10:56:22 -0800 (PST)
Received: from localhost ([2601:647:5b81:12a0:8134:8b90:8d31:15e7])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f7c400b001bbb8d5166bsm20663797plw.123.2024.01.01.10.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 10:56:22 -0800 (PST)
Date: Mon, 1 Jan 2024 10:56:21 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
	jiri@resnulli.us, netdev@vger.kernel.org, dsahern@gmail.com,
	pctammela@mojatatu.com, victor@mojatatu.com
Subject: Re: [PATCH net-next 1/5] net/sched: Remove uapi support for rsvp
 classifier
Message-ID: <ZZMK1YKpYD5VVE/3@pop-os.localdomain>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
 <20231223140154.1319084-2-jhs@mojatatu.com>
 <20231223091657.498a1595@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223091657.498a1595@hermes.local>

On Sat, Dec 23, 2023 at 09:16:57AM -0800, Stephen Hemminger wrote:
> On Sat, 23 Dec 2023 09:01:50 -0500
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> 
> > diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/linux/pkt_cls.h
> > index 3faee0199a9b..82eccb6a4994 100644
> > --- a/tools/include/uapi/linux/pkt_cls.h
> > +++ b/tools/include/uapi/linux/pkt_cls.h
> > @@ -204,37 +204,6 @@ struct tc_u32_pcnt {
> >  
> 
> Seems like a mistake for kernel source tree to include two copies of same file.
> Shouldn't there be an automated make rule to update?

It is intentional, based on the initial commit which created this file:

commit 49a249c387268882e8393dd1fafc51e3b21cb7a2
Author: Yonghong Song <yhs@fb.com>
Date:   Wed Nov 7 19:55:36 2018 -0800

    tools/bpftool: copy a few net uapi headers to tools directory

    Commit f6f3bac08ff9 ("tools/bpf: bpftool: add net support")
    added certain networking support to bpftool.
    The implementation relies on a relatively recent uapi header file
    linux/tc_act/tc_bpf.h on the host which contains the marco
    definition of TCA_ACT_BPF_ID.

    Unfortunately, this is not the case for all distributions.
    See the email message below where rhel-7.2 does not have
    an up-to-date linux/tc_act/tc_bpf.h.
      https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1799211.html
    Further investigation found that linux/pkt_cls.h is also needed for macro
    TCA_BPF_TAG.

    This patch fixed the issue by copying linux/tc_act/tc_bpf.h
    and linux/pkt_cls.h from kernel include/uapi directory to
    tools/include/uapi directory so building the bpftool does not depend
    on host system for these files.

    Fixes: f6f3bac08ff9 ("tools/bpf: bpftool: add net support")
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Cc: Li Zhijian <zhijianx.li@intel.com>
    Signed-off-by: Yonghong Song <yhs@fb.com>
    Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>


