Return-Path: <netdev+bounces-53459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F7803112
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B13280E55
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908F1224DB;
	Mon,  4 Dec 2023 10:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoBtcek/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0DC3
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701687523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YdQEhkWXsOUh8naWGtaApXU9iCOOldy3rlTH+Sgrjxk=;
	b=IoBtcek/SI0DSfh7AXCK3vs50eQM0V5W1D4RLyb5GxooG+prnAbvQNqpCZQWiIeAAHJvze
	iAfcFqB7+wMw7+6cfBs861CIMr16dkNykwC9o9/qB7vY8Qc+mKOlmwLJIvzFHoDav5MmQ1
	vZGEC+zRmZRMNJccSBGx+Or8SvGva+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-UHLvSpz7NGWFl8VR5Yp0Hw-1; Mon, 04 Dec 2023 05:58:41 -0500
X-MC-Unique: UHLvSpz7NGWFl8VR5Yp0Hw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b3712ef28so31785935e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701687520; x=1702292320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdQEhkWXsOUh8naWGtaApXU9iCOOldy3rlTH+Sgrjxk=;
        b=MZnHWiF0uBRaFJ04nHSWL8ZUxOm/mOcZcoNMYXucy5wyzJCbpGZt05bwfRKmR7Aeke
         l6w2gVEdenA4WHRsQ3cjK58e3k1FqXbBMBfjM9TJT4EHYNipXFmzmX5QAx9aBR7UcJ3O
         14s/Ct/gDde/ZtYRg71Am5+80LA8bO3a7hoIKDzObiNHr7+bHQZwimL+iWvhKmtXp3pp
         /bzvy3jr4681HDPaTpeiDQEsa/jPqJVexLEuOYeqRQ6vQbiC9Et994o/Gzvx6hV5kIuy
         rS0JUEPh4lBlH4U+doeUhYU6RgAZNKViIL39HpgWWwZpz4hjb8QMw2ryJQcfMkml4FJf
         LzEQ==
X-Gm-Message-State: AOJu0YyYSVXpzVXEECzSBT2TDM2nvY1jWaJiQe66j7DVVf6Z0uIEQTKJ
	l1vRtmkW1+ZBD3O2vuphC9lDxMVVce7nR1Kk4+Exo35pMNhJzPcHmI7OInqyXsNBG/rhOFGp1ET
	Yb2Fe965e7I/BCjh2
X-Received: by 2002:a05:600c:2488:b0:40b:5e4a:40b7 with SMTP id 8-20020a05600c248800b0040b5e4a40b7mr2163654wms.215.1701687520500;
        Mon, 04 Dec 2023 02:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3MNKd3KWO/xE6m6VPWr4O9uB3PiuwKe+BA25AzAHZUPbp0bKxiK7odyosZU80JwTx7TtrMw==
X-Received: by 2002:a05:600c:2488:b0:40b:5e4a:40b7 with SMTP id 8-20020a05600c248800b0040b5e4a40b7mr2163644wms.215.1701687520195;
        Mon, 04 Dec 2023 02:58:40 -0800 (PST)
Received: from debian (2a01cb058918ce000a3085b410ac38ee.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:a30:85b4:10ac:38ee])
        by smtp.gmail.com with ESMTPSA id fm19-20020a05600c0c1300b004060f0a0fd5sm14651373wmb.13.2023.12.04.02.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:58:39 -0800 (PST)
Date: Mon, 4 Dec 2023 11:58:37 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, mkubecek@suse.cz,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <ZW2w3YyNMoyN1t97@debian>
References: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
 <20231201203434.22931-1-kuniyu@amazon.com>
 <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+QvbYLFoMkr6NTj2+7eHsZ=s9wo3gpdF1BpH3ejXFEgw@mail.gmail.com>

On Fri, Dec 01, 2023 at 09:41:16PM +0100, Eric Dumazet wrote:
> On Fri, Dec 1, 2023 at 9:34 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Guillaume Nault <gnault@redhat.com>
> 
> > > +                                             goto next_bind;
> > > +
> > > +                                     if (sk->sk_state != TCP_CLOSE ||
> > > +                                         !inet->inet_num)
> >
> > Sorry for missing this in the previous version, but I think
> > inet_num is always non-zero because 0 selects a port automatically
> > and the min of ipv4_local_port_range is 1.
> >
> 
> This is not true, because it can be cleared by another thread, before
> unhashing happens in __inet_put_port()
> 
> Note the test should use READ_ONCE(inet->inet_num), but I did not
> mention this, as many reads of inet_num are racy.

Would you like me to send a v5, or do you prefer to let a future series
fix all the racy reads and writes at once?

Personally, I feel it'd look strange to have a READ_ONCE() only in
inet_diag_dump_icsk(), while the rest of the stack accesses it
directly. But just let me know if you feel otherwise and I'll post a
v5.


