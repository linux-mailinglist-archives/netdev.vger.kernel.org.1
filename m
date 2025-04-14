Return-Path: <netdev+bounces-182379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745D2A88991
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEB3A662E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320327FD48;
	Mon, 14 Apr 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GBhTsk2X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1D18B47D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651044; cv=none; b=NXjfwX9dhuHaVwsJvST7dNnOYUZFR1zBGzw2VE6rPaRNspynGB+OjBnUVvoUfNRu2dnQpoM2xZWRsfDkxmaRMHEutqA/SZ18OCBKzzOL7fXBamJmokvklqxZ+waV71NQDCHTcyLQkfja89eGzUmLtnLuiQMzLpW6j0MW+XzhmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651044; c=relaxed/simple;
	bh=dOVE2lvwfv6ZURL3vl3+D6cw4pA0nTkjEuLd0ycTl3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UWXWk9S+FYwgANKxTrMafNnWj5cV4rMoaZKcE/wX9RMUcgkYFxieIGmE7w5E8y4NIA80FOb0OnuAhe04TF+9N+8FU4IzgYe5mNUl9HOKhuw5Ty9jingUUb7oA7LCChaOJPSWZnWRj61CUzg7vgWZJbXZY6Mtqrf15zh0FNWXJTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=GBhTsk2X; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-af6a315b491so4114390a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744651041; x=1745255841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IiVcz8w5QC/SqdYZAR5indEiKIlwFVAEigNqwbn9wM=;
        b=GBhTsk2XcaWzOzYOWUPmibbsILbHfBtN8qr0SV3CxTMGp2s2S6UhiXtX3LrmN8RqXz
         3OzdtpnsR+lE5+EVUpfD2kqKJkMG0KNeS8jYF6lw8/ff1K8X7dx4Auv3K0LevWJc9zVk
         RrYi037dei4GOlmPTviOjNhhrLK430Osf88u6mdkOLdmPL271p9T37vXsGNAahB/O/mX
         2gv49FIPIAygBW9vpOnGasCa9UtlHTVd74y6jmMLvqpcOIFNpKKXyyqehc5+QuutaWYm
         CKW0jnRtvLOaAx7W06q+T8LCNSxUp9NP+4Szq3llEurlRDcHmms5LwamTo38aBMmz8Jw
         SmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744651041; x=1745255841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+IiVcz8w5QC/SqdYZAR5indEiKIlwFVAEigNqwbn9wM=;
        b=KjmRnFb8gdRO9G7XqY/UCJ0VByyFCDZrIwHKjUfIYkYXLD5yX2JPVeL4dU22PqmTxx
         sZ4ApTedS8BBjoS2wyG+hxRpIlmCUKaDsDIfhH6b/fUne3aC1Gp7nrhKsuLbbR18e2G+
         LhWTXWFxPs2rkxn8o+kc7l9QFbyELReSUyv15r/bLrsp7KDndMalUAqET9+1Y87CV9Lp
         H+x04gRg7R5Bi3ru/9gYobfQ4C11U0T5pvrvUR6vYkU1BplJ3ZuKzvzBNlNT+220agSq
         fqapHQnuPqSdKGydjUtU1uw4SBLi+XpQwvF8Jm9Qo68qucmBDXo3BCWD8NrjcsfZ9/vl
         R0Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVET9rjDBjoXQkc1BfnSj50V1U2k6atgHQm4Vf5LBkJfDDdfEhFgvEe2CJGrohYAijdn1gxwGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKi3UqBwdYskfaAA900w+zWrdZmTIvlyGJxLh5GeZ6HiGxDjnl
	pWhpm2AOd8trOsleFQdqHLCJ16fahiSDIAkU4yG/2VFguhmGKTXWwpuSvhK5l5IIhcLSsnxHpoc
	=
X-Gm-Gg: ASbGncsWC4pqx1VMwcvb0CV2uFc94r6uTCYsg4ghUVZ9QGbvIRwNQgSdJGIdvibK9ek
	n+ria+wvm2IFcxhmqs4v4uccqC85Ktw1S+nd/LmlYlNUPX0OTd2Wq7LYgWloKW1Fa08f4akx0Ec
	ihWL/ieZ/a1vwnVgvdhdAlnsWYP+hO6vIyLuslzvVNFOJRz4j8F3mRsfTFXmv6EJJNTno9r6kFP
	hykOTolj6OpvF4dDEgmDcQSFxYCgqiBSxEhn8iLj/EJZ32fLWdSLWftll+7CE/+hYfhMkQXcix8
	DZiHSHwZRvpNMcCpczCgRPpUAgTadi+zp+Vse4CRknyYymBpyXhnaRuUM7O9y7QEZYlMutJPLMx
	MkbFA2k8mvvs5k6/HTCE+8Q==
X-Google-Smtp-Source: AGHT+IFtgep/PE9PM5dQsv4dTQeGeTo04V6YwqoZCjhYxdyP3gY0aM7tBUL1dQdsQ/VWpXtBo4xTmw==
X-Received: by 2002:a17:90b:5643:b0:2f2:a664:df20 with SMTP id 98e67ed59e1d1-30823633ed2mr20258116a91.7.1744651040935;
        Mon, 14 Apr 2025 10:17:20 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c3:dc7b:da12:1e53:d800:3508? ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd2fe1a4sm6755597a91.0.2025.04.14.10.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 10:17:20 -0700 (PDT)
Message-ID: <fde1319f-6669-44b1-b525-44e2bc48f9a1@mojatatu.com>
Date: Mon, 14 Apr 2025 14:17:16 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] net/sched: netem: UAF due to duplication routine
To: "Tai, Gerrard" <gerrard.tai@starlabs.sg>, netdev@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>, Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 jiri@resnulli.us, Pedro Tammela <pctammela@mojatatu.com>
References: <CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/14/25 02:33, Tai, Gerrard wrote:
> Hi,
> 
> I found a bug in the netem qdisc's packet duplication logic. This can
> lead to UAF in classful parents.
> [...]
> Unfortunately, I don't have any great ideas regarding a patch.

Hi,

I was thinking about this and thought maybe we can try and store
the initialisation state as a variable in the class structure
so that we can detect this recursive use case. I created the
diff below and tested it with your repro. It seems to have
solved it, but I might be missing something.

  net/sched/sch_hfsc.c | 8 +++++---
  1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b368ac0595d5..9662df5dd77e 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -160,6 +160,7 @@ struct hfsc_class {
         struct runtime_sc cl_ulimit;    /* upperlimit curve */

         u8              cl_flags;       /* which curves are valid */
+       u8              cl_initialised; /* Is cl initialised? */
         u32             cl_vtperiod;    /* vt period sequence number */
         u32             cl_parentperiod;/* parent's vt period sequence 
number*/
         u32             cl_nactive;     /* number of active children */
@@ -1548,8 +1549,8 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc 
*sch, struct sk_buff **to_free)
  {
         unsigned int len = qdisc_pkt_len(skb);
         struct hfsc_class *cl;
+       bool is_empty;
         int err;
-       bool first;

         cl = hfsc_classify(skb, sch, &err);
         if (cl == NULL) {
@@ -1559,7 +1560,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc 
*sch, struct sk_buff **to_free)
                 return err;
         }

-       first = !cl->qdisc->q.qlen;
+       is_empty = !cl->qdisc->q.qlen;
         err = qdisc_enqueue(skb, cl->qdisc, to_free);
         if (unlikely(err != NET_XMIT_SUCCESS)) {
                 if (net_xmit_drop_count(err)) {
@@ -1569,7 +1570,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc 
*sch, struct sk_buff **to_free)
                 return err;
         }

-       if (first) {
+       if (is_empty && !cl->cl_initialised) {
                 if (cl->cl_flags & HFSC_RSC)
                         init_ed(cl, len);
                 if (cl->cl_flags & HFSC_FSC)
@@ -1582,6 +1583,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc 
*sch, struct sk_buff **to_free)
                 if (cl->cl_flags & HFSC_RSC)
                         cl->qdisc->ops->peek(cl->qdisc);

+               cl->cl_initialised = 1;
         }

         sch->qstats.backlog += len;

cheers,
Victor

