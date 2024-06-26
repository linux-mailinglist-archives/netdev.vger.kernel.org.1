Return-Path: <netdev+bounces-106737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731579175D7
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E3FB20B1D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109ABE6C;
	Wed, 26 Jun 2024 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FIMnDukb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1C14F62
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366371; cv=none; b=fHHg7OySDgFooT2gkWErsWMxba4rqt9GXsKVkoIbkocPJRkCQih2OVlZvfXBOol38tko2A4s7nPp092MasDAL9VVoekOH8o07tfZizoCudqsH7maUeOl9Y3mHqAVpgCgDWC1VGSKcGtIGpU6VJlnGYPE4/pijdejNuM3DoHbtwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366371; c=relaxed/simple;
	bh=d4XwO43a7NXBz7l7K86p3g4y4bJt0eJkkeoqoA177Kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjJoQBNz6Do+4AFU4A79So81WtAcnwBnRglwTZGgf+hrvlhliL6CwbOW8d90IuLI/3bMn/MJD7+a0qbhZtCH+3JO1cp+4AGZ/FtoINq4Vps/P2LezkZlvMgDhqc62+97HnpBv4SC2NOpH7Ivhb5M2xxWXn2HwIJhrPn8fa/O66g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FIMnDukb; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719366369; x=1750902369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9fFmKhlMCiV4AxFRhe15+3T6kbvPQWa4wtw05HRPSmM=;
  b=FIMnDukbeYnakvkGVigE5dKFd/qyLBIQWELB+W1EYYRIabYvfzlInd/Q
   jJSLVFlSLrWh8kNqUSwbJU4yjxlW5jx/bCLHYlSoOiSni/zv49H2Av1qm
   gNIDcp9QvTRrKbQPT4bb7wB6fMAfgMyZoPDzMg8TYvaSlJa1ZbEj5ULhp
   g=;
X-IronPort-AV: E=Sophos;i="6.08,265,1712620800"; 
   d="scan'208";a="415765498"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:46:07 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:9052]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.229:2525] with esmtp (Farcaster)
 id cab1c643-2aa4-4b37-988e-7d2e78d03a83; Wed, 26 Jun 2024 01:46:06 +0000 (UTC)
X-Farcaster-Flow-ID: cab1c643-2aa4-4b37-988e-7d2e78d03a83
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 01:46:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 26 Jun 2024 01:46:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <Rao.Shoaib@oracle.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
Date: Tue, 25 Jun 2024 18:45:55 -0700
Message-ID: <20240626014555.86837-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625174449.796bc9a0@kernel.org>
References: <20240625174449.796bc9a0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 25 Jun 2024 17:44:49 -0700
> On Mon, 24 Jun 2024 18:36:36 -0700 Kuniyuki Iwashima wrote:
> > +	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
> > +		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
> > +		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
> > +
> > +		ASSERT_EQ(ret[0], expected_len);
> > +		ASSERT_EQ(recv_errno[0], expected_errno);
> > +	}
> 
> repeating the conditions feels slightly imperfect.

Yeah actually I don't like this...

> Would it be possible to modify EXPECT_* to return the condition?
> Then we could:
> 
> 	if (EXPECT(...)) {
> 		TH_LOG(...
> 		TH_LOG(...
> 	}

We can use EXPECT_EQ() {} here, but for some test cases where TCP is
buggy, I'd like to print the difference but let the test pass.

For example, see patch 6.

  #  RUN           msg_oob.no_peek.ex_oob_ahead_break ...
  # msg_oob.c:146:ex_oob_ahead_break:AF_UNIX :hellowol
  # msg_oob.c:147:ex_oob_ahead_break:TCP     :helloworl
                                                     ^
            TCP recv()s already recv()ed data, "r" --'

  #            OK  msg_oob.no_peek.ex_oob_ahead_break
  ok 11 msg_oob.no_peek.ex_oob_ahead_break

In this case, this does not print the recv()ed data,

  if (self->tcp_compliant) {
      EXPECT_EQ(...) {
          /* log retval, errno, buffer */
      }
  }

and this fails the test even though AF_UNIX is doing correct.

  EXPECT_EQ(...) {
      if (self->tcp_compliant) {
          /* log retval, errno, buffer */
      }
  }

I think we can convert it to EXPECT_EQ() {} in all places after
fixing TCP side and removing tcp_incompliant{} uses in the test.

