Return-Path: <netdev+bounces-193189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523AAC2CE4
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 03:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3DD1BA7B59
	for <lists+netdev@lfdr.de>; Sat, 24 May 2025 01:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CA81E1DE2;
	Sat, 24 May 2025 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="aaU3PFa+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF21DF979
	for <netdev@vger.kernel.org>; Sat, 24 May 2025 01:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049897; cv=none; b=llWh8PuiSfCKOAjRtpr7ad93wRD/O8rLvwDLdPWlqfxJYuRuof6183tA2GwMYzd8h3ZdIy3Ue1GlRNQTI7F8H+vv0mBTdvHt43pyDsJULWOTVS3lU6CQDzD7mdZSwQtVKx5wx9VJvkulCLDulODKAnl22Q3Dexsw9ijBcIhkBUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049897; c=relaxed/simple;
	bh=JlNKQSYJeweRVq8pXvJaYnPt7vQT0Na2CL0+Bdazonk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJnuYyAFOPBZLprNy9EM1Z9jm1Rmg1krsztYsmbckf026jruW28oNePsVC8KeEpEfgytJp4iigXcXAsSMm83cTLHM3SIyVAovRRPegYczr8DSzZq7Xaig1vT5mZipIn/3eFpLaYNcxE3YDvL9ysVLebyqkDuIJYwwZNY4e2ONEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=aaU3PFa+; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3087a70557bso90443a91.2
        for <netdev@vger.kernel.org>; Fri, 23 May 2025 18:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748049895; x=1748654695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq13+igEMhsgxpMLdog5ck2P8KdfF5zkUseHq2QAlyU=;
        b=aaU3PFa+zytY1TvN91qeekYM5Ymut80Bf4IVoqVUW9fKCK4Q5hRa68otg8O2BVsp0i
         6DMNNoO+lbT5/jT4nd/dkMuvtW4T8d0gZNm+4v0jukH48SOK+PC7h+uACFHaL4HNPF+o
         XZiOjLNqBql9GDe1DLghKJgXqZGkHThMHi10ZyKg68xrxiYIVTdt2vJckInvE2Sy+l0B
         9SDsSr98h1AKTiYGzVUf9J6+0XdvKN6jXj9unvSijeA3JN9cJlnGJaAc+VbeOV78xWkj
         Bsm4zqEzcoU8UVCYnAQT11gsAwLj932GnQvb4zlp/0wwxTglH0o78MwN8iXQPHrovhRr
         /Dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049895; x=1748654695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq13+igEMhsgxpMLdog5ck2P8KdfF5zkUseHq2QAlyU=;
        b=u/cr0Z7OAgk35m6UQEkJVxTs/+89KsFn2O6PRAsiHCmXBXBhnSyPc/NYPT58P80s77
         Y7FaQ5fssumWPaVzK9eHbgUHpGbXcoC+kQBt5YBgNoOBzCPjD/aOaol2F5VRevepWIJ4
         QAD5s1DiNV2KJRQMz/I19q3Y6kBCORfNQ102VijkHGQ93oTJwFTCig25QLztMIeHPHK+
         REl/KbsSFPng1vSzSx/aVQaOhnoCcyniRO1qnTetOlrhql+CiwrDA7nzqhSEZsj8KVam
         IaEyrXAQ01EVArXhC9wIK4ozWseLQ0C0a6jFU2FLfYWJRdkf9EnMvBpu+1+FRJl74qNE
         0Mog==
X-Forwarded-Encrypted: i=1; AJvYcCXStrGSQXFuoUvgSHTsfIjAmpejMS2ajOUbmrHZPtsXIrWs/4tRFApcWv2cZwLcsGe/URWWKZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcofyxpIBXY6YCDIidhx5PIbG2RZOZLnz2UbMY4RqkftZqngl
	ocTzwaUmRe8N/P0VSR6HWUqMbDZ5Kio55gDT0rJsg5Rh2JJtI+IZGwE3tm0h2cQ4CgniIqyrHMC
	YRaL5QDQ=
X-Gm-Gg: ASbGncvdYTuKxqdeFMyem4cG4ZYmrRs9jkWxGx8NgS0NLdUHwBmgMPnybHYJ8qydMly
	nYJD+s33Y6yn33gyhUaVot3aX3nzFq+EACifSPUwykXy8T/McKUCv2lkfOLyULjBA8Z5veinPt+
	/B8ujKhmiBG/CDg6o2R1SelRVzeJO8EfFEPaTn89ge1eBTqqIGWdZsuCKutoPpGDrvjI7oEkXaO
	HxWL7RSCJ2v1erXZQAgVaj+l6Mrfy541gEiD1cLnnIuf86i3auggjzmSoodZn6xj13AeMMU+rZA
	LF3rJSTBVmxth5q/rWE8M3Fmd/IOj4Y9uEnNGK2gy7b5xHun
X-Google-Smtp-Source: AGHT+IF6WqCkeKTcmgjh1qJPsba0drc2G/bZjDpfP3R9aibTzLRrdZlX5RQ7FjpbI6Knr5PZzA6G6g==
X-Received: by 2002:a17:90b:4c0e:b0:310:ce23:a078 with SMTP id 98e67ed59e1d1-311106afdf9mr594831a91.7.1748049894796;
        Fri, 23 May 2025 18:24:54 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:ff7f:ad48:17ea:17bb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-310f885511asm1195466a91.22.2025.05.23.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:24:54 -0700 (PDT)
Date: Fri, 23 May 2025 18:24:52 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 05/10] bpf: tcp: Avoid socket skips and
 repeats during iteration
Message-ID: <mfrii5tn6wj4bskpoewzsmqmhyc47s5343qrhpq7sdotr54zoe@3kpggsqe4cxi>
References: <20250520145059.1773738-1-jordan@jrife.io>
 <20250520145059.1773738-6-jordan@jrife.io>
 <2e350e8b-3192-48e9-a419-ba727a52abee@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e350e8b-3192-48e9-a419-ba727a52abee@linux.dev>

> > +static struct sock *bpf_iter_tcp_resume_listening(struct seq_file *seq)
> > +{
> > +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> > +	struct bpf_tcp_iter_state *iter = seq->private;
> > +	struct tcp_iter_state *st = &iter->state;
> > +	unsigned int find_cookie = iter->cur_sk;
> > +	unsigned int end_cookie = iter->end_sk;
> > +	int resume_bucket = st->bucket;
> > +	struct sock *sk;
> > +
> > +	sk = listening_get_first(seq);
> 
> Since it does not advance the sk->bucket++ now, it will still scan until the
> first seq_sk_match()?

Yeah, true. It will waste some time in the current bucket to find the
first match even if iter->cur_sk == iter->end_sk.

> Does it make sense to advance the st->bucket++ in the bpf_iter_tcp_seq_next
> and bpf_iter_tcp_seq_stop?

It seems like this should work. If you're on the last listening bucket
and do st->bucket++ on stop/next, the next call to listening_get_first()
will just return NULL then fall through to the established buckets in
bpf_iter_tcp_resume(). Will need to think through the edge cases a bit
more...

> > +static struct sock *bpf_iter_tcp_resume(struct seq_file *seq)
> > +{
> > +	struct inet_hashinfo *hinfo = seq_file_net(seq)->ipv4.tcp_death_row.hashinfo;
> > +	struct bpf_tcp_iter_state *iter = seq->private;
> > +	struct tcp_iter_state *st = &iter->state;
> > +	struct sock *sk = NULL;
> > +
> > +	switch (st->state) {
> > +	case TCP_SEQ_STATE_LISTENING:
> > +		if (st->bucket > hinfo->lhash2_mask)
> 
> Understood that this is borrowed from the existing tcp_seek_last_pos().
> 
> I wonder if this case would ever be hit. If it is not, may be avoid adding
> it to this new resume function?

Yeah, I think we should be able to get rid of this.
bpf_iter_tcp_resume_listening and bpf_iter_tcp_resume_established should
just fall through and return NULL anyway in these cases.

Jordan

