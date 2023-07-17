Return-Path: <netdev+bounces-18275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5026E7563C0
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A19281213
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750DAD50;
	Mon, 17 Jul 2023 13:04:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42011883A
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 13:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF16C433C8;
	Mon, 17 Jul 2023 13:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689599054;
	bh=ze2MlGoasoOaP8JdKIbXQC5TEDKOOs+yneRfEWByn5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkaRIIzA3aAEDj9NrQ5MDbHNz063EwSrpyfSv9pG4wotRVhFLclI0Obr0MY7Pgdq1
	 Wt5wCFtB9Ao8UbM4sVh0pSNHIfbMIl5WtLE92l3dGhHIGC3V3M2YsYEMO2WrJ0e5h+
	 xM3CFFWl354Gc5UXDE+O+sGKTWofVXmaXcRGBdW2C/uZAGTqIBRhy1wcCkzVM467IT
	 d/L79wy8olbzvFALkQS3+0j7imErqc2pNCIdxrdCONcJf+fySryHGb5dmcV9BzjSYS
	 Hng/UL086GSNEQjTEyfyS+CeCz+4bJqkraSB5JUPcw3MqIo4RV7lZQd9LkOXgg8OGg
	 wabFVAZN19nqw==
Date: Mon, 17 Jul 2023 14:04:08 +0100
From: Lee Jones <lee@kernel.org>
To: Zheng Hacker <hackerzheng666@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, Jakub Kicinski <kuba@kernel.org>,
	Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
	linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	1395428693sheep@gmail.com, alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230717130408.GC1082701@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
 <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org>
 <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
 <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru>
 <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
 <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com>

On Sun, 16 Jul 2023, Zheng Hacker wrote:
> Zheng Hacker <hackerzheng666@gmail.com> 于2023年7月16日周日 10:11写道：
> >
> > Hello,
> >
> > This bug is found by static analysis. I'm sorry that my friends apply
> > for a CVE number before we really fix it. We made a list about the
> > bugs we have submitted and wouldn't disclose them before the fix. But
> > we had a inconsistent situation last month. And we applied it by
> > mistake foe we thought we had fixed it. And so sorry about my late
> > reply, I'll see the patch right now.
> >
> > Best regards,
> > Zheng Wang
> >
> > Sergey Shtylyov <s.shtylyov@omp.ru> 于2023年7月16日周日 04:48写道：
> > >
> > > On 7/15/23 7:07 PM, Zheng Hacker wrote:
> > >
> > > > Sorry for my late reply. I'll see what I can do later.
> > >
> > >    That's good to hear!
> > >    Because I'm now only able to look at it during weekends...
> > >
> > > > Lee Jones <lee@kernel.org> 于2023年7月12日周三 19:56写道：
> > > >>
> > > >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> > > >>
> > > >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > > >>>> For better or worse, it looks like this issue was assigned a CVE.
> > > >>>
> > > >>> Ugh, what a joke.
> > > >>
> > > >> I think that's putting it politely. :)
>
> After reviewing the code, I think it's better to put the code in
> ravb_remove. For the ravb_remove is bound with the device and
> ravb_close is bound with the file. We may not call ravb_close if
> there's no file opened.

When you do submit this, would you be kind enough to Cc me please?

-- 
Lee Jones [李琼斯]

