Return-Path: <netdev+bounces-73373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525F85C2F9
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 18:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103E62845BE
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA7B77632;
	Tue, 20 Feb 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H/tNoZLL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266D56757
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708451291; cv=none; b=bYfCHbuhcJfsh2i7xu0oIidDTeiHGTWbNJsx0Y1+R3tUF+w3lYGlmyPWL+3Djd+9AnAHek/oWIhBLyMB+ShuRQtRLAzsPEHJpqzl1fQnz6hNKEUt0dDuV0jH7GrmTE7zb8Yd80NYt8FmWzLZpGUy/1lCw1SBhd9T/9fPWKUAQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708451291; c=relaxed/simple;
	bh=v3qvkFJG5vMcXjqYrPJaqft/dQzxxxjoOXQ4cfK/hBA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckYHLlhZjXz4dcP/XLhRl7DDWp/1xV1k+SMuCH2pdpoxK1O5MVH8lsdAXBQ/sMxfGsIjNHWLBRoboRn6D7Iz9egL/1Zky97+Fs2ofaz/LnylTdai69saQ1N14FjYGn22gSKMUqpi9V2qAvjlWyBnkQLizNDRG62U9jm2HgU+84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H/tNoZLL; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708451283; x=1739987283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zlCCn7ALEfKd90/I7PsTUXH4Gjn5FaTuIK7eqMGeCv4=;
  b=H/tNoZLLbUpKnS7D9HTvuGk7aRB7JxCeytXJduxu7PXku1zfzD0DBMF0
   VKmbzxfqX+jfjeqyQ+VQhAo3h4GuKmTBcLsWOUrsVv+GQo3DEyhtr4p/T
   d7d/PeRf6/OytK8g9GF80wMA+HVgLaK8yI8NzHkP1cWCYB66L1BennwSD
   M=;
X-IronPort-AV: E=Sophos;i="6.06,174,1705363200"; 
   d="scan'208";a="67355644"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 17:47:59 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:11155]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.151:2525] with esmtp (Farcaster)
 id c24d68e1-5d43-4c76-bc31-86e4db6bdb86; Tue, 20 Feb 2024 17:47:58 +0000 (UTC)
X-Farcaster-Flow-ID: c24d68e1-5d43-4c76-bc31-86e4db6bdb86
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 17:47:58 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 17:47:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 09/14] af_unix: Skip GC if no cycle exists.
Date: Tue, 20 Feb 2024 09:47:47 -0800
Message-ID: <20240220174747.47705-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <98016c09e181336c477bf07d5e58b98bd644b075.camel@redhat.com>
References: <98016c09e181336c477bf07d5e58b98bd644b075.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 20 Feb 2024 13:56:13 +0100
> On Fri, 2024-02-16 at 13:05 -0800, Kuniyuki Iwashima wrote:
> > diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> > index b3ba5e949d62..59ec8d7880ce 100644
> > --- a/include/net/af_unix.h
> > +++ b/include/net/af_unix.h
> > @@ -36,6 +36,7 @@ struct unix_vertex {
> >  	struct list_head entry;
> >  	struct list_head scc_entry;
> >  	unsigned long out_degree;
> > +	unsigned long self_degree;
> >  	unsigned long index;
> >  	unsigned long lowlink;
> >  };
> 
> The series increases considerably struct unix_sock size. Have you
> considered dynamically allocating unix_vertex only when using
> SCM_RIGTHS?

Ah good point.
Will try to do that in v3.

Thanks!

