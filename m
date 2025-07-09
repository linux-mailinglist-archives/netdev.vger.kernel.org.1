Return-Path: <netdev+bounces-205568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA80AFF4ED
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 00:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB2A487F00
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4978821ABD0;
	Wed,  9 Jul 2025 22:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="a8++rV5L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5B2944F
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101243; cv=none; b=fTAG9yvkUMHN8BLPs4UHkqYvmGUo5RqnkzrNJG/mLn6z1AqjUgtJArwRP9YHYUZU4l6mKlRb4MA3DeZG9uBFwt3hfZGAjc574/0vkvfvYsNfRCb83su5z7d7n7mEH1FHds50o2yfmsOX8a1jF4fgWlbynJWjpDcSWky/Cs9xZzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101243; c=relaxed/simple;
	bh=AMaPsBU1Rytq76Zm2TjETV+JkYTEUFlnbtQxIT6kLFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqCwlgkhZHKv5IGEk9u0NYzRURoVcaJTfrCZ6mFJci7Z0HBrGzxHbWXioxM1+MN5gamrje4RF7k6UWwZiPh8J5V1MV9Le4TvgKcg0EMimyC6VWlwBD10HqML2kml32vXqhl+NYdUkLwkzzEg7Xl0wP9BhISlI5XSlhgaSrpiFNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=a8++rV5L; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-312a806f002so64525a91.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752101240; x=1752706040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWivPj3PrSHsIYwZQr86vF7NA1uo371elH6TQuADgAM=;
        b=a8++rV5Lp/Xo8UIWEhBLJWsgGQaLFWwgd80bY1wc3oiBkAQrrICvaAG1I66kt9Hu+a
         UVFu0YDXgZuC9Il6anx+kjWlUMEDZogDIkPKi3PizYHuxhToBWQksYlBuv1wocRfXmrM
         HG4LkpV3A6M1n4jr/ivfcKrAKBA6SEkyBj+B0SY4LaI/WT99zm6Y2Lk8RKptNXGG/KCu
         YoG6QgWG2wTlK2q3XrQXEV5Qqapl9haiuJM7x5+XQUQcr1sO6JFfLl0nUHVH+1b421Yy
         crk2DpioELWa4dHXygCDJfAVN9RA4ie4Os8STbxy+Jg4eGndme6LweO9CBk6r4uITB29
         excw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101240; x=1752706040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWivPj3PrSHsIYwZQr86vF7NA1uo371elH6TQuADgAM=;
        b=t5aPL4YM3leKKgBNYpqBJLhWQ0K7YXKRocOARQqIeus4qYYlonhvJ6sz3bcIYpB/9y
         Ww2sLT60PL01+vAlsCfjFEbYYqSYc1TqdZKxfQdtcHPYjeqprfSqjf0ubsRVHl/uh3XC
         XoV+5k79lBIFj6inu/9Q6fUOhTbsoFyJ1vC2HZewm9dwJ9NCizdETlE9d/cEkS8Q0SuX
         6VetKd2wpE5UdjdrMuo2y/kCMnxCO2V+U4CpD2Ggt1+i/+6Tckj2Lmr+wfxWZqnFoncm
         JKy96p+rSUIQfu7+YfG3fhMZHZJpZELXRMsx6EMBU1FMzlqrTeQ0woFXR56zIVYSyiWP
         /70w==
X-Forwarded-Encrypted: i=1; AJvYcCURfLoBkH8ebKcJupeUFvpSUVDMC5VbW0rRaDs+Xu0eDH8JEXCMgX8Ghj3a+eBl6Ow+kItVgPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYKV77obUDwjsGh9IlOq6dXFxI1IMDEIIxYmeeRGFVDZYPERR
	wmTmNutva0NZNE1vpGJR4VLi3uXZkoVp40guPfqtJOgP9s8Uv2AboTY1nBuHx7CBhKE=
X-Gm-Gg: ASbGncuRKgJHMbGd46GuGpWQLruum8dRs27PjuOZw/+5qzB+XI6ohpEJ23ofrGfZgwg
	1KIbh+iVm1be17lAsS5bmFQ7xSx1YCd/Tq7WjBo6PBm1SIj+g0GqF3F8R3vCrhOk4OQBk8Vd3OJ
	UlTxdifR+Xke/QyG6f8PqWvftnIQ5WuKGqFqYTPU3Z7gW5PU7NEfa7yhsgrf96LoJqnUGwDYJuh
	/0Q95D6Tv07VI643JeLYSQZh+JjIZbg2cVicKZ4h/EEg78eVUaKH/qqCcLiLqKmIssck8IzqKhL
	yqlKqXzKU98k2aeoE3jeKH3CAaAg+X1rKYYTdrIHddu4Rn3T
X-Google-Smtp-Source: AGHT+IG+jFSgnEs0JKVW6bWM0FSTTQ3Kxvyr4KC6UVatwmTVNDlUrpa+OBZO81/1NzOVVRO3JRVgqw==
X-Received: by 2002:a17:903:2a85:b0:234:8f5d:e3a0 with SMTP id d9443c01a7336-23ddb19ae97mr24400685ad.2.1752101239974;
        Wed, 09 Jul 2025 15:47:19 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de43411c8sm2406415ad.184.2025.07.09.15.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 15:47:19 -0700 (PDT)
Date: Wed, 9 Jul 2025 15:47:17 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 12/12] selftests/bpf: Add tests for bucket
 resume logic in established sockets
Message-ID: <yyng5hf5yvak3vnelrsxuxhmqyefqehfzz3lbprxrhekwzeaih@brqs42cp7fd7>
References: <20250707155102.672692-1-jordan@jrife.io>
 <20250707155102.672692-13-jordan@jrife.io>
 <3c3a1640-16b6-47a8-b1a3-a90a594885af@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3a1640-16b6-47a8-b1a3-a90a594885af@linux.dev>

On Tue, Jul 08, 2025 at 04:44:50PM -0700, Martin KaFai Lau wrote:
> On 7/7/25 8:51 AM, Jordan Rife wrote:
> > +static void remove_seen_established(int family, int sock_type, const char *addr,
> > +				    __u16 port, int *listen_socks,
> > +				    int listen_socks_len, int *established_socks,
> > +				    int established_socks_len,
> > +				    struct sock_count *counts, int counts_len,
> > +				    struct bpf_link *link, int iter_fd)
> > +{
> > +	int close_idx;
> > +
> > +	/* Iterate through all listening sockets. */
> > +	read_n(iter_fd, listen_socks_len, counts, counts_len);
> > +
> > +	/* Make sure we saw all listening sockets exactly once. */
> > +	check_n_were_seen_once(listen_socks, listen_socks_len, listen_socks_len,
> > +			       counts, counts_len);
> > +
> > +	/* Leave one established socket. */
> > +	read_n(iter_fd, established_socks_len - 1, counts, counts_len);
> > +
> > +	/* Close a socket we've already seen to remove it from the bucket. */
> > +	close_idx = get_nth_socket(established_socks, established_socks_len,
> > +				   link, listen_socks_len + 1);
> > +	if (!ASSERT_GE(close_idx, 0, "close_idx"))
> > +		return;
> > +	destroy(established_socks[close_idx]);
> > +	established_socks[close_idx] = -1;
> 
> I may have missed where the fd is closed,
> does it need to be close() first before assigning -1?

Oops, forgot to do the close after I replaced these calls with destroy.
I'll add a call to close(fd) at the end of destroy in the next spin.

Jordan

