Return-Path: <netdev+bounces-179091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C4A7A91B
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91106175F6D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F82500C9;
	Thu,  3 Apr 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YvSvT3nd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861BC8E0
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704166; cv=none; b=r45O8GaoEE59hvWfXHBqvoG7oBLXY04+kGDQGyIbEZoPKMc1xvGIVNm09iqb1Pdw6RXFOVYJUdi0c9VHVfc79irrqgC3tIWLyYgWsMvah+WeUOi8yUGQ4RXbTY4JCu9O80pOrAymPnArnOoO1JkABrnXW5nhIB6jVSdAci3IqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704166; c=relaxed/simple;
	bh=AAxrM2iRqdWg4dPkxTdNI3Bm2YqyYSHNciLHcBw4rKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erw6nv3NpMbPYy4zVDdCfX+QEWeNzOw7XpWDVTYrBe0Ym/OylhHsKsnPrBeYvcVHysKK2uHjaS2CzolCGJSVNqdSzIapBIHKWA1yYEVnvWmn8UZcFElM326bHQ1nSFuP2krBO+QHwyoIfpg73rEDsbr4ZqVRLqbJh2GQRv7DtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YvSvT3nd; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac3b12e8518so228637166b.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743704162; x=1744308962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FJlcXXP2FukqGEHv0z1cQI88EHr2Dv5R3LlDfDt2A4c=;
        b=YvSvT3ndW5dF+05wpB2s1HAcjsulUMy9zZc6IQJJr5IFJH5/Az6mDANHLIZeOSdlIv
         dip3xprggzULcTk+9TCh7aCU9dl68Hrj537o5x/ejUXx4+5gU5/HP6QZOCuJHaeKzDre
         p8l8Jku0gbe5kJLclfbflI2dstT3uzw5KB+C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704162; x=1744308962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJlcXXP2FukqGEHv0z1cQI88EHr2Dv5R3LlDfDt2A4c=;
        b=Jdo0tbHeqho9MdbTDB5o3oTzLWlutP7U/Bgwk5pIWOcK4ghcHG46T2Z9hcjD37XVYv
         bEqtO+CVkal5/oA46ZaeLCZPbaL1vEEMm0Dr0uQruZdwy34PdkdzkNc6c3tdJuJcF6xi
         klgic34+RugR0E9WS8B4OBeV86grXKImgP2PN1W4OH6fl24xEGoxQKpwyVuJ1FJkOIau
         J4lYuHDyGeGu8+T71ASM3T6Z6HEY059cspYr95xStwQyVJij1/8HaM48ZV8V6m3fFktN
         FzbuQiXstUnj+cdCQVkYWPcqgcpva11xpPwJp3lkp8L7mWBFfbzB9DjjFr6WoauMYA9f
         nigA==
X-Forwarded-Encrypted: i=1; AJvYcCVaYVTBs4Ty86sXBV2yTrBKXdDB3JwJW9YjPeJv+lAVR/9/m1QoKo9vgjJXIg7fkHJgD70c+M0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMK9oYUQlfoqTzZrOvPb2M2HFlPW8k1TpPLIGreobw5pSQkQAZ
	ggNoIxlfXnnXoZDYeRCharlekdXEF1UqjqS49JTBxHE62InyYGKVr0KLdykgm9+/6mx4aEw1w29
	MMvY=
X-Gm-Gg: ASbGncurW6xOwlOwcIOKa7BrLFk+xj3Up0RceBC+klulAA9aN14SA/2gCLIxkyQzPni
	Ext09b1/eQZNMyM7G5tLN2w31qO9qxASv2njjX8oh3JkmgxAdqKzbvcninCa4xqxCAkSG2pNzXS
	pXgYQ47Hh3Om/0nORKfOkwegCaY0OMVmrvuA8nVy+IVONVS5zyxc1o8O6AkU0SQBsK+XbqCiBtZ
	loasZpnXN6j4htHhL6mUj91lg2BtMJ/8+MliTyUo6b/Sl5mPsK8BvavcGdgTZxnSzlRfBLiHRr6
	hEPx038M385yIFNEbZ7fYMeXvOGqB0USTQacMtDzR2WSxLSupbqTBUCUPtuSeQ4zpc9SA87s/p/
	229mu2CBN+4Fyag8XbUE=
X-Google-Smtp-Source: AGHT+IHNuTabrhYAAaOA4J/6mSB8Q1DL0NTtelbUUzbiZfa4FNDSpJH79OY98qRvtrKDckyR90Y/vA==
X-Received: by 2002:a17:907:7daa:b0:ac3:97f4:9c08 with SMTP id a640c23a62f3a-ac7d191ac70mr54462766b.31.1743704162591;
        Thu, 03 Apr 2025 11:16:02 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013ec0esm128726866b.98.2025.04.03.11.16.01
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:16:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso1866148a12.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 11:16:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdaLv+pKid7Tn4F529KfW8XBnrW9EaSvkhaLyqEd92r//a0a1+TtfZ9P26sp0pC7Vp9Ac+Sv0=@vger.kernel.org
X-Received: by 2002:a17:907:9728:b0:ac7:41c:748d with SMTP id
 a640c23a62f3a-ac7d1b27f38mr53718566b.38.1743704161358; Thu, 03 Apr 2025
 11:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
In-Reply-To: <20250401134408.37312-1-przemyslaw.kitszel@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 11:15:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvh_LUpa=864joG2JJXs3+viO-kLzLidR2JLyMr4MNwA@mail.gmail.com>
X-Gm-Features: AQ5f1Jqqq_S2O0OJpyEjcg88KSOkVuR9PdTbHkE7So44nAp-S1DtNbZhUbWjRJI
Message-ID: <CAHk-=wjvh_LUpa=864joG2JJXs3+viO-kLzLidR2JLyMr4MNwA@mail.gmail.com>
Subject: Re: [RFC] slab: introduce auto_kfree macro
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz, 
	peterz@infradead.org, andriy.shevchenko@linux.intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 06:50, Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> With new auto_kfree, we simply will start with
>         struct my_dev_foo *foo auto_kfree;
> and be safe against future extensions.

Honestly, I'd much rather just see any auto-freeing *always* assigning
the value.

We used to have a rule that declarations had to be at the top of a
block, which made that not an option, but that rule went out the
window exactly because you can't do that with the cleanup macros.

So just make the rule be that __free() without an assignment is simply a bug.

               Linus

