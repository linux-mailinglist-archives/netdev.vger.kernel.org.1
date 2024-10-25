Return-Path: <netdev+bounces-139237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F59B10FC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB43F1C22BEC
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D316620EA27;
	Fri, 25 Oct 2024 20:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBi3KV04"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8F20C333;
	Fri, 25 Oct 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729889240; cv=none; b=qfztRHrPyzicTtfyQRv4t0TnWiwUeI7gtTjxHPN7nrRmFA/5CCFCL9Ap5mC1mVfPnczofWjUHhfZuTRUFoDwUaAATj2jjW56BEmMidKllWqh8YB0Mrk0zHVGzHB8KZYXCdRClveTcKxPLxpgUyEoTSX3vcekZYR5sCyHWAjA0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729889240; c=relaxed/simple;
	bh=oAnrTg6+ZTNIYv2RxYzpft0paLcpuLFASlreiuS/n6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izBgJsoogw76Lf9R9IQyrmSVslEjfNMWuG4IVO1CsN+JIPxgQbAR7bX9jpPoIzLkNDEHpQISA/m4pEu3fGEd8TMDAYCR/ouL+FQtmBMUwcT0ShLGTaysuOadY4KAtsVjwRSWG66Ghp6BYlRfDbv2MzoYuROGGg3x/gY/dr668Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBi3KV04; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b18da94ba9so81136585a.0;
        Fri, 25 Oct 2024 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729889237; x=1730494037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gIZHEwfOmBS9mPV2oH+jrJ1aoa5lOVY1207ho5mBV/4=;
        b=nBi3KV04MZovTkNkj3s0J0gOxq/OyLICLP/+4uxAv8ezUyH316Wv8JNWVRfxZYm5/D
         v3gvHB11SVRUnmAx6j62AXLGxZrgao/faV6IWGXinwEbTMrOy9MVkdcOFpHB74drZbn8
         FQst2gLcQpPYQFIRgvhd2bnBEjVDo6XHnv0L2eKT9pmgLf5emNxVGYN9Cen+SrVqZLZG
         urddUMIFF75xkeQd3WYd6MO2MBYIfFve4HJcx0g6CPIEizSSPl0QiipcxtgOpKOY9+7i
         fcUp+vGAO19k4OZAWh+H9Wp2eyvV62Qb4TWhENPaze9H7hQQi65Wee/njeRAV76rZDHM
         kQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729889237; x=1730494037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIZHEwfOmBS9mPV2oH+jrJ1aoa5lOVY1207ho5mBV/4=;
        b=txkejXdT8FL4DVGChv+wopmYM99fBkOkUHG2GjajMJNdfEnQHerQj+lkM9Kv3cXdxz
         gesofrPN6F7OHAh1+JBBpPxraGwazenj+ylgqb+F9ZZlB1CA4vJsPCgDSheI/Cn0gJn5
         kzAxE1CVJbXSbRStmMnNBS99NJ+TMNM9PJyxEyczd456BezMxFPVROoZhN0lKUGK4grB
         ZFYG37J3oghMqJOYv14VPc+Y/5rDyzLe+ItMA2XtDBhaRei4jpUbqpLmHwIhr62/NS8p
         krRdeo/xqkDPN2ThDJCFRcH+5ad8SU4bJk3tvRIkr6BovrAMlzxhMlAY6QUES43tpYsC
         ydGg==
X-Forwarded-Encrypted: i=1; AJvYcCVkjvUi/xkRZ/vKZGImb5J0Xz92mhGT+N1dzrJASL0Na34no3u1lCqOtB54m852CP67pJ8d3WK+MFrNPMQ=@vger.kernel.org, AJvYcCVnHD3gWHA3JGDuKbvpHBe0VwVasgVTcr/VsVoG6do0kQr3o4v2foq3Y2dvKXB2+1zxQiZbQ0ZQ@vger.kernel.org, AJvYcCXNA/sdIWiNRLvaA22goeCdLy+j4fwv3Z6lYlDEIhC9GrJlH4CCGAdjFX8rEqbyf2RO288gAxemJAoiaqBgoXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5t3V4celdPzk5lrl8MwzwxyUh/RA2Jdye7PQBki6vFzNC31wu
	GcDUuwTB25Czmlcqqd3t9dBT4rgqU7ZscFs9FGXxE1tXtDU+5wve
X-Google-Smtp-Source: AGHT+IH2FI4G4iwczx681DALwQQysvh3yFn4NumpmmuRMTRiuhG0SfWEU5XfTdFxZTORE6bjseWPOQ==
X-Received: by 2002:a05:620a:4543:b0:7a1:e37c:bde0 with SMTP id af79cd13be357-7b186648ce9mr1207119285a.24.1729889236669;
        Fri, 25 Oct 2024 13:47:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d359a47sm87530885a.125.2024.10.25.13.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 13:47:16 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 62C971200043;
	Fri, 25 Oct 2024 16:47:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Oct 2024 16:47:15 -0400
X-ME-Sender: <xms:0wMcZ4hqovkZOvEhqb4qGxi6HONlVNR1HuKl-99aCQeKECDjrNJO6w>
    <xme:0wMcZxCoM6M-EnctoKkoam0eKpiP7PUyYcaYuUHlS-ODtW89-_jgzJeNf22FAWVYs
    Pnh8e54ilQWgmesZg>
X-ME-Received: <xmr:0wMcZwFHHazRslYFNrU19f4eNVSASw0CWetmtsHC-49Ly5xSjayeCmgHUvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnh
    guohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepfhhujhhithgrrdhtohhmohhn
    ohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprh
    gtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopeht
    mhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:0wMcZ5SNES7DWLHZot_3OvBz7f84w1Cx27vegPIashITca-o4BReJg>
    <xmx:0wMcZ1wEYHshKzftML6YAAkREYupRUKkjia05ruzf2Nc_QNh3OQQ2A>
    <xmx:0wMcZ34fgxl9vw42G_M52n6cqdxvnyp9jdCvLegIqk5SfBSjO5lXbw>
    <xmx:0wMcZywu5WmZmjjtCD3rVQa2UXSC5S4_pzCG7k_N51-6RJf9BZTREg>
    <xmx:0wMcZ5j9UL-4vBjc-Gwg42a1NoSaAY_TMiKPEmaA4hG6z35jYv44HK8Z>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 16:47:14 -0400 (EDT)
Date: Fri, 25 Oct 2024 13:47:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org,
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com,
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
Message-ID: <ZxwD0fG3hTT1Nkf3@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-5-fujita.tomonori@gmail.com>
 <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local>
 <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com>
 <ZxFDWRIrgkuneX7_@boqun-archlinux>
 <CANiq72kWH8dGfnzB-wKk93NJY+k3vFSz-Z+bkPCdoehqEzFojA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kWH8dGfnzB-wKk93NJY+k3vFSz-Z+bkPCdoehqEzFojA@mail.gmail.com>

On Thu, Oct 17, 2024 at 08:58:48PM +0200, Miguel Ojeda wrote:
> On Thu, Oct 17, 2024 at 7:03 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > but one thing I'm not sure is since it looks like saturating to
> > KTIME_SEC_MAX is the current C choice, if we want to do the same, should
> > we use the name `add_safe()` instead of `saturating_add()`? FWIW, it
> > seems harmless to saturate at KTIME_MAX to me. So personally, I like
> 
> Wait -- `ktime_add_safe()` calls `ktime_set(KTIME_SEC_MAX, 0)` which
> goes into the conditional that returns `KTIME_MAX`, not `KTIME_SEC_MAX
> * NSEC_PER_SEC` (which is what I guess you were saying).
> 

Yeah.. this is very interesting ;-) I missed that.

> So I am confused -- it doesn't saturate to `KTIME_SEC_MAX` (scaled)
> anyway. Which is confusing in itself.
> 

Then I think it suffices to say ktime_add_safe() is just a
saturating_add() for i64? ;-)

> In fact, it means that `ktime_add_safe()` allows you to get any value
> whatsoever as long as you don't overflow, but `ktime_set` does not
> allow you to -- unless you use enough nanoseconds to get you there
> (i.e. over a second in nanoseconds).
> 

That seems to the be case.

Regards,
Boqun

> Cheers,
> Miguel
> 

