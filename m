Return-Path: <netdev+bounces-199326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64AADFD52
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE523B66BA
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 05:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7A243374;
	Thu, 19 Jun 2025 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKIcXuCO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A94A242D8F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312457; cv=none; b=GB79KW2MZPe9Fvk5pNuVS6bZAd10XPRSw9vd/ayBdKWeBYsd57cqd+AG+nexG9jKypoK75FlmcuW77omeFq+qP4UFY9nQMCjoKV/KFMAp3WXasPN0Wj+tQC+lUTFgegKoHunyi5DFuiCPfUdZMm+ns5i2yyLLlv0W5fulNGqYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312457; c=relaxed/simple;
	bh=fkIz5c3VvVkstShK1H66lgQuGsJWH2TH8Np1JEM/A24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VztQZpLGrc6kQzez82dnAuT81a3P2xqQHh4HOGaLykMsGEMTA5U20SBGLHMsxFBpgAsvowGC4wcV5rC55Uqva3QVqfXQtZpGgy+enGRIAjL8lgU0a7wj81zqNp34jvGQqGPZ0qDLTBLqjKDLAQvapDkLc2HknboPNXxBBPTbvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKIcXuCO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748fe69a7baso167607b3a.3
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 22:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312455; x=1750917255; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=aKIcXuCOlkRKptm+3jS28zkHggMih4vYtkCEOExinKKMeSclcQzdyROq65tyxsKaXS
         Ax4oXlekiXh6RpFMB4rkhiv7t3KMeTrWrk+e6ewEFxc6ndT9sBxv8ZIoFOoqNabbItJJ
         wTZcWpQE0n4sgHO0OBwU0a/HKGsDRgdMMlmbBlt8ttfAgJARjQFr1BBVQM5n0sKzdh7K
         j7ZK6ROIvMiNl9uX1JDqqAZSU887fi6JUmuUsbuZKG0Ebv3LJDIz+pvdusK0betcuEz3
         GfLk3CAN2m92AlnVg4QhdCGkCAQE87e55lLCegf9ygtvPH5Ezriq6DNNJtj+7zz5Vej2
         L2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312455; x=1750917255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNX8x8v1rA4gsmPSGKn+LRzfhgT9AcyvzOiTf8D9D0s=;
        b=tEQSwW7Hk728hC7SQPPAfKYhHDKjHIn7u0kFhvRnQ8953pinamoKFp7GTCY9qq/YQt
         X378LfrxQlrcZMEzuw110F8g/D4/cnWZH0vvteOTn13shAZfEQbrw5lnVOCMwiuF4Sfc
         X6REiDxn5kZdT76YFY5Sj2N1PEKngEX9TWIk2VSPQ/u7JoDnv02w8zDjzk8WWI4cJCqM
         VRFOB4YdFxf5v7Tt68yF6UZUzY+N2Qbr3Q3SSqIGcb3d3HE3hcl5SGmpRh/a8vC2x728
         JiPbcATvSap6tc/pt0S32QKsD9tfPQCYxLX0lQkldMYXdjMo+rYi6Pp8/lTUYARbcvI3
         JpuA==
X-Forwarded-Encrypted: i=1; AJvYcCU1uD5BvN4oeuMhYfxkYTyoneXmL1WLTKBKySRVt9TzHHeC5ZoqGGpLWLeUiU62v1kMMLkmMNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxunoqicCWhfBQKDn9jt4NvFWneYmyPI48vOby5vw0RFOTaHJOA
	g21j35p1Tj2H6QLIcIPQQ9FcOzHi75+L24XVfGiOPNGpQJ+msBFB0d6w46T+FH1gbbGjfAcprIf
	YaOEO
X-Gm-Gg: ASbGncu1HjqdtI+KQcPoB1WivZ2scRnA44Q65b/gppogmkjEOplEzO5CkFN8njFcLMb
	iisevHfO5A97qY5EJfxgWBT8l4MVBIefKjGjY0dtVeSa3b2gO9GWZZGeKZxWPVlxUCL7p0taJ9A
	vJtIvYPfEfX1OKh7Bha5qS4p8iYf08sxOassT08vwNvViSg+EU+wOPmSOCy3dDqmg9SzUC2RP5r
	09N9RHZ++wi/Q8xurq8l4LFp1ALFBEGGTlK4t2UsxPb9PJfwkHtU1EGWxETlPIlTS0mB2PedWu3
	7gflHNEtutq5oCfyY14z+0653JhUumvu3hJqQW10gN8cuv9TRZ5le/A73Y2SLac=
X-Google-Smtp-Source: AGHT+IHpBy809k4j/mgtJ3pLZAei1vSVsYHbL1LodLYl1qhBrEB6gEr4Vdl8NOXI+5UF/UVojJEPMQ==
X-Received: by 2002:a05:6a21:8dc3:b0:21a:ede2:2ea3 with SMTP id adf61e73a8af0-21fbd4d2985mr27026444637.17.1750312442235;
        Wed, 18 Jun 2025 22:54:02 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b04e4sm12287505b3a.121.2025.06.18.22.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:54:01 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:23:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <vireshk@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Breno Leitao <leitao@debian.org>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
Message-ID: <20250619055359.tormmysgxxcper6q@vireshk-i7>
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com>
 <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mfjzXj0f4PKPKg7QgbOrhay4CF_+TBgScecKWO6acmyQ@mail.gmail.com>

On 18-06-25, 18:48, Miguel Ojeda wrote:
> On Sun, Jun 15, 2025 at 10:55 PM Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> 
> We need one more for `opp` [1] -- Viresh: I can do it on apply, unless
> you disagree.

Please do. Thanks.

> diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
> index a566fc3e7dcb..bc82a85ca883 100644
> --- a/rust/kernel/opp.rs
> +++ b/rust/kernel/opp.rs
> @@ -92,7 +92,7 @@ fn to_c_str_array(names: &[CString]) ->
> Result<KVec<*const u8>> {
>      let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;
> 
>      for name in names.iter() {
> -        list.push(name.as_ptr() as _, GFP_KERNEL)?;
> +        list.push(name.as_ptr().cast(), GFP_KERNEL)?;
>      }
> 
>      list.push(ptr::null(), GFP_KERNEL)?;

For cpufreq/opp:

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

