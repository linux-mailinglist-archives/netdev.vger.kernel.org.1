Return-Path: <netdev+bounces-136284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273B9A12F5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE361F2611B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC02144C4;
	Wed, 16 Oct 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPmfD9IZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F518BC33;
	Wed, 16 Oct 2024 19:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108452; cv=none; b=uegqbYUJ8qYyekGN+5fyDydUocaW7boD1lY9kNyBmgnntYk1JzwvHXS4Lz23LOlr79r92t5HIdIjEBTngrdm2+ln/8PmkDyXQsi7m+Of3t3EWoA9i84CsgIftkhcHI3OtIoD4AB5y8Oput72b2wcKPq9ERvKSh37SpB3lRacwCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108452; c=relaxed/simple;
	bh=7oRThQztznlHAqI2vr89tVK4VbB3UwzOlwWA8WmLv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7v6X29PmB3z6kfxjgjA4QTQKegr63HQMCO4w9hU+idxE1tnCFzCUOqOwQMxcpt67edTYozMfmfFu/Iy2qv6+BySLJC98b4vzgLYiEPNeaoL4v7lrsIWjuJ4LP6Kb1zqrwvvwnFNhtk6snqLBnMat0//aZ6HOj4EDnHMvu9qD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPmfD9IZ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4609e784352so166681cf.0;
        Wed, 16 Oct 2024 12:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729108450; x=1729713250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v7wjKIhhww48sdwRipURJWTfa87g1A1lt2lXIVhn9U=;
        b=MPmfD9IZGA8nKoRvLgjMoBvMIKWm4YBTjvxQxghJadhJID+mJCQB75NU+0Q1Zc5Mm7
         4BsuMRs+I9pDgIUoJiFrzE9PNjgV3LkoXRXK7MFhjH7UopOf4KWNchRlcpHVm9caLqdY
         rb5afj8IsEhD+8iPkIwdLIUf9nqPChBxjZmCj8ey4oEy9nj837Phrc7xJBhNb33E9nc/
         jcYgXJcC/LIuV4AiYKbr52jo4/WHKCfEvsr09840MgYwI7J50u9OAJ4sIVUGCG9EOpPZ
         JI7kvHD0DNZm/gk1XXPn0TaoUOLLvKM9wIOwj3dug8RLD2X/rMVo1SymopJuNKixJsSd
         jTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108450; x=1729713250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v7wjKIhhww48sdwRipURJWTfa87g1A1lt2lXIVhn9U=;
        b=bpPzv798n6oQ/nomRnRmYQXn321qcQQ9he7Lje9KRWcuCWL9/SeCiPrku4EVAnx/Af
         5H9H9Zx4U5QDxu1v0bXu0fKWAg7SWkiwtrcjXXtsjR7iIt8WA9us3H41ib7Oj9HLduNu
         Y9uEU17gurEh27DHjZ+PznaEQYPdZGhaUBuhHuOadXxiTeoSKVWvtoDoWOorGgJVOGCv
         xeTbTCsJYzuTMEJ+8KWv/SrGsIXxnrEwR2PtNxuMbtAkjwSGkWj1ejcPzyhOdLtSkfez
         EFjdkDiBoyxymJy+4G4nlWYz9a0ZIzTGiEGan5QkSr/+KALWyeya11u35qWjx+1826qj
         VQtg==
X-Forwarded-Encrypted: i=1; AJvYcCUWxRFfUhX69xpy+c5XbB6Fj1uE4yXcGObbLNu3Fm4ASJTD5VY6TZzcftHxuJNIaKfdcnOYfYab+5yfLJ8JyIw=@vger.kernel.org, AJvYcCVxoD0m1il/B2o6dSLuEf/vmfCEROnWSD7CpxslVNhwRRIQbKLpCe4d9AV3ihQhNcSQHMuyMB/gPJQ6Wbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOVEpPEfuWZWg3jStP17EXF1A1WIZDCf9ZqUqgBRFOOt8ByjH9
	st+KPNokJ+8Ltsal2TxtgzVh6ZKQKxuzy0mVZkCwSEKbjZllk7rh
X-Google-Smtp-Source: AGHT+IHMBRpIGzPwXimPcca6m7ja273HIRtLtg3iMKOM7E0L5yRcxDWLHr45gMtgLpuux+wQJAnLBA==
X-Received: by 2002:a05:622a:11:b0:460:8559:e5bc with SMTP id d75a77b69052e-4608559e74amr72717081cf.4.1729108449806;
        Wed, 16 Oct 2024 12:54:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b123e13sm21032561cf.44.2024.10.16.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:54:09 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF9C21200071;
	Wed, 16 Oct 2024 15:54:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 16 Oct 2024 15:54:08 -0400
X-ME-Sender: <xms:4BkQZ8xHsD6h9WzYayhGa0jRoiusgbTp0I8_QyHGpotHEa2PUK7qUA>
    <xme:4BkQZwT2lXFVxRaE1r5piVN9pe_ZkAfsyX7hRPNLsud9KYMV7I1IsiDtxO2Yb1tfD
    iWWCpTvEGh6lcIIwg>
X-ME-Received: <xmr:4BkQZ-Wv8VKq-fK-00_FaX0F8E6chueXThLV8QnOyctEuGXun89jaoqwvMs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhnohhrihesgh
    hmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthho
    pehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehtmhhgrhhosh
    hssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:4BkQZ6gO73bXQ1zjHmAOOZXzlJnvow51wt9VhvjMvvgfXd9rP0ox6g>
    <xmx:4BkQZ-DxF9qq_5oX1MwyxNqJnvAapC_ZQjhmuERXP4sSqtXYtkslJQ>
    <xmx:4BkQZ7LY5xrdeSndBn5NKsQwhnNxN-IBMj-_-sQCOB8zKv-wjZMNQA>
    <xmx:4BkQZ1DBHFQMbT7biQM9PCAGtp5p_JSndupIDAWbp-cjGMsOBZMYng>
    <xmx:4BkQZ-z7XETN6l66igh91EPAf2oskEPzEKZJmCg5H-aPeYbvGrsZTNvG>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 15:54:08 -0400 (EDT)
Date: Wed, 16 Oct 2024 12:54:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
Message-ID: <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016035214.2229-5-fujita.tomonori@gmail.com>

On Wed, Oct 16, 2024 at 12:52:09PM +0900, FUJITA Tomonori wrote:
> Implement Add<Delta> for Ktime to support the operation:
> 
> Ktime = Ktime + Delta
> 
> This is typically used to calculate the future time when the timeout
> will occur.
> 
> timeout Ktime = current Ktime (via ktime_get()) + Delta;
> // do something
> if (ktime_get() > timeout Ktime) {
>     // timed out
> }
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/time.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 8c00854db58c..9b0537b63cf7 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
>          self.nanos / NSEC_PER_SEC
>      }
>  }
> +
> +impl core::ops::Add<Delta> for Ktime {
> +    type Output = Ktime;
> +
> +    #[inline]
> +    fn add(self, delta: Delta) -> Ktime {
> +        Ktime {
> +            inner: self.inner + delta.as_nanos(),

What if overflow happens in this addition? Is the expectation that user
should avoid overflows? I asked because we have ktime_add_safe() which
saturate at KTIME_SEC_MAX.

Regards,
Boqun

> +        }
> +    }
> +}
> -- 
> 2.43.0
> 
> 

