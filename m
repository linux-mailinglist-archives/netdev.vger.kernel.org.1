Return-Path: <netdev+bounces-31789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D6790302
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C50281955
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E699F9E1;
	Fri,  1 Sep 2023 20:56:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DEBF9CD
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 20:56:28 +0000 (UTC)
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8210F8;
	Fri,  1 Sep 2023 13:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1693601787; x=1725137787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1VXgPQopPQYG5toOL8jno2aUmJcGbpp4C4tw0S5xR8=;
  b=RCFDlkHlPmmoZ9VhtYkjQN7jjI7AjUU+pEpjKpElcaYEsbU5yIsUEgku
   8psx+izrwDLLLOVqT7oQ5rAUlVU2bPmpN5kIkFfsk4VYUjvskJIbwn1an
   stjgQ07CFKKaS86OWGV+QOd/S+YQO1cxzAcrGwNXwrraHzsf8mjWtmOWM
   o=;
X-IronPort-AV: E=Sophos;i="6.02,220,1688428800"; 
   d="scan'208";a="669963861"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 20:56:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-83883bdb.us-west-2.amazon.com (Postfix) with ESMTPS id 9CA2460A1C;
	Fri,  1 Sep 2023 20:56:25 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 20:56:25 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 20:56:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hca@linux.ibm.com>
CC: <aleksandr.mikhalitsyn@canonical.com>, <arnd@arndb.de>,
	<bluca@debian.org>, <brauner@kernel.org>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <keescook@chromium.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ldv@strace.io>, <leon@kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<mzxreary@0pointer.de>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v7 1/4] scm: add SO_PASSPIDFD and SCM_PIDFD
Date: Fri, 1 Sep 2023 13:56:13 -0700
Message-ID: <20230901205613.59455-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230901205145.10640-A-hca@linux.ibm.com>
References: <20230901205145.10640-A-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.187.170.14]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SPF_PERMERROR autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Heiko Carstens <hca@linux.ibm.com>
Date: Fri, 1 Sep 2023 22:51:45 +0200
> On Fri, Sep 01, 2023 at 01:33:22PM -0700, Kuniyuki Iwashima wrote:
> > From: Heiko Carstens <hca@linux.ibm.com>
> > Date: Fri, 1 Sep 2023 22:05:17 +0200
> > > On Thu, Jun 08, 2023 at 10:26:25PM +0200, Alexander Mikhalitsyn wrote:
> > > > +	if ((msg->msg_controllen <= sizeof(struct cmsghdr)) ||
> > > > +	    (msg->msg_controllen - sizeof(struct cmsghdr)) < sizeof(int)) {
> > > > +		msg->msg_flags |= MSG_CTRUNC;
> > > > +		return;
> > > > +	}
> > > 
> > > This does not work for compat tasks since the size of struct cmsghdr (aka
> > > struct compat_cmsghdr) is differently. If the check from put_cmsg() is
> > > open-coded here, then also a different check for compat tasks needs to be
> > > added.
> > > 
> > > Discovered this because I was wondering why strace compat tests fail; it
> > > seems because of this.
> > > 
> > > See https://github.com/strace/strace/blob/master/tests/scm_pidfd.c
> > > 
> > > For compat tasks recvmsg() returns with msg_flags=MSG_CTRUNC since the
> > > above code expects a larger buffer than is necessary.
> > 
> > Can you test this ?
> 
> Works for me.
> 
> Tested-by: Heiko Carstens <hca@linux.ibm.com>

Thanks!
I'll post a formal patch.

