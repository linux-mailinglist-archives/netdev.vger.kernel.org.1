Return-Path: <netdev+bounces-244627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32274CBBB18
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2646A3002D78
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A721227EB9;
	Sun, 14 Dec 2025 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS6rKOxE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD0D1DE4E1
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765718266; cv=none; b=D62oIpclULZw8vS9bnd4Gmew5fcg+i58ROdwXNo3SQPBVwOa2LhCcpVEsEVTuuQmcrePtgBs/wBOzcu/3tKE+CXre5eiklNje194guesORGtGxiza4XHc6UPq7DRlWHBdwlp+qr0xTJU7ECIdLht6HmuYRtZgckM73vaAvdsGeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765718266; c=relaxed/simple;
	bh=XmtOq1WlOXv5tvapcKs/oIm0cZgNGon3Gb1VCrDVVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjlDbR43TNNYjWQPVrGM/w/Tk0YYn+OyUwkaDCjP1sbPYSj8obSGZ3KzK3e2BTzaOX7MO80L+RYf64H26Q0zrm5TQbkPzYL9eVzFOJ6K+Hrx9rnmQ7soGSGfvOhpAGlM0MH+U5s2Ysi0P63RshLeP7wO2urFnkjkYsAC+wYWZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS6rKOxE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775895d69cso10258805e9.0
        for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 05:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765718262; x=1766323062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpywd0ooBqabRS+5lH7EYtrqn3sd1kp/pArhDDLgKLk=;
        b=fS6rKOxECWqFG4sVcdaFbufZFN0mNF9qFZ7VjjqnN2KZvEygJpFhJLZAxt6NvZLFVu
         f+DTEadQhuz4AekF2cWxUtc6075GBBhfbApDp9/0MkXytirYBLDLrsEkIpf3RmmSUoFY
         8tcMQNJd0mGu4nsxXGfrhywKa38I1GfrSwBJGNcYbeh/8r4lexXrBsGXlAkT87Sds8Kk
         nH2liVbqLto6rS6LS8W2358HZ8t5i9WjGSzZxZ7OoxpYuLrwKqYZlj+hDenqkQNvMuzh
         CNOG/kWR9nYlRX+m2jvmUVrJEBsmVFXfaElXRHb5q/Qm5XLoW3cxaNskk7RcpcLhz3OJ
         vePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765718262; x=1766323062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpywd0ooBqabRS+5lH7EYtrqn3sd1kp/pArhDDLgKLk=;
        b=lve27S8mB2Y2pZrRQg2VHwoLp3W06BQNT1LWoRpvIwudQEqxPFMpllnLWKiLtqkwQA
         +F/JYFwGfRvhO83P4Y3KwnB4H0hR3bVdLL5M5lFOlxdd/iXaCDMxLze3K4Cklp3Pdw7D
         OmJpkMV+Nwr72gpAFt/wPasSQis1rEQofcXk30u2h2zxBmT3r/t/WGgX23fZzrQ47n6v
         nlJJsZ539UGldbmekkwSw+5HO4GM7G58z9x58S/E75CDvjvIRg2uXoMm/mItFeDsEEG3
         G0ZloXdYabpjXOhV0b+99B5ZLoWwGB5zR3e+m/Dr2gRrJTdfvRXp591g4GJ8hNLhwnRl
         Szyw==
X-Forwarded-Encrypted: i=1; AJvYcCXhYs6mLBjSboIm4W0bMORDKG0yDmHZcczMh9Sl9eLGCnoY8NvJlLnZTWt8rYOb6YRIf+psoPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMOZfwENa4279wI0nNBuuf4CRIvbH12UUSxCYVz9OyXsCoDhqJ
	eKxbg+m41WitfwPByrzf2gOu4dHD5u9dIRurY1/aTJPJ8LJx2ulvJZTu
X-Gm-Gg: AY/fxX64R+CzMwNCuujyoV3FfBeUkUqSGCqzDT4L1ClPWEat975zsiXDgQinRDCR7kB
	BcOh1ivuIYuJq1cIDgtT5J2qyQ4c0fP5nuJji0ngEEdF+tWoX95K62/it+OutDDStNBDrnb0q4M
	KdoMpm83mjgDbOpjF+7kpf3GR4Bt1N9HpIcvXnYChMeaNCxn6yhc6lpBuNbKyHPycKgycQ9x41b
	Xv/bvC988/FnA6KZuLyphj3G2bDdarIxsw/45OmtNfFt58bq5ucn2HL0KJ5l3x8TM27H/u3wzhA
	qq+Otbl3U5VDxl87TLMvmN5pxi1s4iINyAB3UO5faDzqfYo9ZPw7cbYDo945JzzB95rsSf8dJil
	YbU0YxqP2yQXOBjS1dJekmUN4VMLsCm1SEQBKzVZpfMGXOwT1jo3ZDmaXT+5KHDZ2Xu7XNEPFGr
	HXzGDqmrFh3Qbrnl+jS+vnQdaAALPkHqWyJV35wc/vjAOmSAyYYuMI
X-Google-Smtp-Source: AGHT+IHTX2KIoo6rHKnWJhWyrUXne9SI979vSJQ8O09DKd6yhp5jXCNNQXUTEJFhlKpFkjoCo3wQwg==
X-Received: by 2002:a05:600c:a009:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47a8f8c4b8emr81227825e9.13.1765718262416;
        Sun, 14 Dec 2025 05:17:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4af065sm50301095e9.6.2025.12.14.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 05:17:42 -0800 (PST)
Date: Sun, 14 Dec 2025 13:17:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 11/16] bitfield: Common up validation of the mask
 parameter
Message-ID: <20251214131740.40063fd7@pumpkin>
In-Reply-To: <202512141305.J3aPiiBv-lkp@intel.com>
References: <20251212193721.740055-12-david.laight.linux@gmail.com>
	<202512141305.J3aPiiBv-lkp@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 14:19:30 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.19-rc1 next-20251212]
> [cannot apply to westeri-thunderbolt/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/david-laight-linux-gmail-com/nfp-Call-FIELD_PREP-in-NFP_ETH_SET_BIT_CONFIG-wrapper/20251213-040625
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20251212193721.740055-12-david.laight.linux%40gmail.com
> patch subject: [PATCH v2 11/16] bitfield: Common up validation of the mask parameter
> config: i386-randconfig-053-20251213 (https://download.01.org/0day-ci/archive/20251214/202512141305.J3aPiiBv-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251214/202512141305.J3aPiiBv-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512141305.J3aPiiBv-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/gpu/drm/xe/xe_guc.c:639:19: error: converting the result of '<<' to a boolean always evaluates to true [-Werror,-Wtautological-constant-compare]  
>      639 |                 klvs[count++] = PREP_GUC_KLV_TAG(OPT_IN_FEATURE_EXT_CAT_ERR_TYPE);
>          |                                 ^
>    drivers/gpu/drm/xe/xe_guc_klv_helpers.h:62:2: note: expanded from macro 'PREP_GUC_KLV_TAG'
>       62 |         PREP_GUC_KLV_CONST(MAKE_GUC_KLV_KEY(TAG), MAKE_GUC_KLV_LEN(TAG))
>          |         ^
>    drivers/gpu/drm/xe/xe_guc_klv_helpers.h:38:20: note: expanded from macro 'PREP_GUC_KLV_CONST'
>       38 |         (FIELD_PREP_CONST(GUC_KLV_0_KEY, (key)) | \
>          |                           ^
>    drivers/gpu/drm/xe/abi/guc_klvs_abi.h:36:35: note: expanded from macro 'GUC_KLV_0_KEY'
>       36 | #define GUC_KLV_0_KEY                           (0xffffu << 16)
>          |                                                          ^

I've just sent a patch to move that warning to W=2.
It is picking up the same sort of things that -Wtype-limits does - already in W=2.

	David

