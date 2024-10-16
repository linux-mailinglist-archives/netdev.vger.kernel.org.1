Return-Path: <netdev+bounces-136281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0149A12E1
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF8F28312E
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C101B6D0C;
	Wed, 16 Oct 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwc1ggj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7731125B9;
	Wed, 16 Oct 2024 19:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108044; cv=none; b=drl/90Kz2djhtEHMmJhXEkCAwV4vS4FrEf8QtLMmwGhYfjUlIQ4MYcfO9j4APXuo53SbFt5s+f2N4rWhwyfvV/JUMkg9fdFXa/MHz54965dQdkjYBpVRTiftQsVgszVSNn8cKsPSZ6oqSjwZElKogDjXzdOUqR48/b5snB9hJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108044; c=relaxed/simple;
	bh=pmlNSljXEUqxAokNLwjXCDGzQ9J//4EAy+e28nbhgQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxl5LUpukAx5Kpsb1oA7ksDrAirMk+XBW7T28ybhDy00owgeuwWUvABOlzDnSrKy8RoYAJVGR87KcIrlLv+jFwAHwGLS4OhOk+R7y8e2WdpM77WMk4C5wIeG9pnwMTlkxlyjn2iXX2EXfLWPPQ1+i+WkBuxrWNE41jMRO/ur9aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwc1ggj8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46045199e4dso1755251cf.3;
        Wed, 16 Oct 2024 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729108041; x=1729712841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O7rveXr8EWQwBHFtL+vhmszoaVZ34wapFadx4cT7CFY=;
        b=cwc1ggj8jvqe1du98tqYzP+BqPyJt1UjPu2d2aJdikWdke5gYWroif7tJ+QYQ5uQS9
         1riQlNXgvQ1l8sfQb7N/5H2EN6AK0e49Hqoe0em6SUY/ePp3gk2bAxKVyGj6hnH3ieiF
         B1FjmDZgigFbtRzIIiSsl8BjYBDaKB8eLS0tkEZyylUTNm/jaLXpfGaQmAuOjntt9OLy
         3Eq17TWis4Ciwm1ISRI0zhZ2jINHO7Yivtx4sKIkMNp6Vj+3bup+Yx/PYoDhl4ZFvJUI
         Mohtcg6NCXvx2W4TeyHte3tme0fjpNaL1qZUoisLVfToN6GqQaDLq2guBaEWmp+xH5dS
         Jshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729108041; x=1729712841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7rveXr8EWQwBHFtL+vhmszoaVZ34wapFadx4cT7CFY=;
        b=H3RtngpdOKxoPbHZ5Ki0OOxsMXIT5GEKYIg9CGLsFDnCd/SwspAY9XUqtNEdpmYx/L
         wV3YxV4KbquWQUAWkxywISCfIX1ic9ofjeV729nnqV7DkPLC938sPaRyFGoe0G+NFrOA
         3lD1YPB8BlqHl2Cx2Qk2zRkHTNwz1NjoV3k1Nd8WHuXkrwHJXOzkYg9TbtptVuqQ9hVg
         Pr4zFdM+OWELm+3Q5C/Z6DdYjL0bBBHqkicY0ncsC0l18K0XOQHo5YPw85DVpelRWDrb
         1t/ZI6TOe6QLVUQoNdsUxnvCOq5JnHlZI1WQ651xI7GqXJ6lpfGUXi/opY2NtobsbM//
         HmXg==
X-Forwarded-Encrypted: i=1; AJvYcCW9vPgQS246OprFySsu9Od6XGfVDhKcdTrPSjx3pCPl6lWgD+XM2cO6LkTI583fUn9qZhD0+dnefdWn0MS07LA=@vger.kernel.org, AJvYcCX678lnsKlO+OA7aLybnLQqXkcL+WND3J/SLKgGzBruYfm58xWgcSnmR/QYz0ia5ivbwbPE0foK@vger.kernel.org, AJvYcCXL9a9j9CdaINI0XnDtcBYjTNJ6OumU21IiV/DQALMxgmEiBRNLOwMRyBNf6d5ysHmNzh1TzKrLiEbemEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAT3hmPtFtwxmYmtAQTnileozk2XuLdJqGp8lXhFZxUp0Rtmyo
	78ZYSLmPYsqMhfz0zuZmBSe1exjhcxjNaS2C6CkybNRi/XEuxM6Y
X-Google-Smtp-Source: AGHT+IF6xCUs696kKcIN/z9eOsuC12fgOayKojaZu5+rDeH8ru39YGtHJA6fE30edqk6BU/Nb7r3kg==
X-Received: by 2002:a05:622a:1245:b0:460:8d74:3cb4 with SMTP id d75a77b69052e-4608d743f44mr65230681cf.17.1729108041450;
        Wed, 16 Oct 2024 12:47:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4608d335c82sm12806331cf.67.2024.10.16.12.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 12:47:20 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2E4121200071;
	Wed, 16 Oct 2024 15:47:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 16 Oct 2024 15:47:20 -0400
X-ME-Sender: <xms:SBgQZ1hFZppSlJDQAXCKMwaiTs7lokKpe4XZUx8q2rtXpo3z7P44Xg>
    <xme:SBgQZ6Cy7iThFSdFGsKZrhgSMEgyNxsboVFJGln0EaKgYzclvPhHD4_Rj8CXxr6DE
    K-UEg_LxriQtj6eNA>
X-ME-Received: <xmr:SBgQZ1Em_pBCjEseJiXGKpOpUzh7d7cn1IBQHhk6jyeO-zlp-DBlHkwrcqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllh
    ifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgt
    hhdrvgguuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SBgQZ6SCMujHgZmCytZNQeJDYBMiHTmIj5l69Z8lEhBX-dOR8rCD5Q>
    <xmx:SBgQZyy8VCLYUNxwe2c_Fd_L39BCmRTpaVzjaIOkoZJsmEWb8cyiSw>
    <xmx:SBgQZw5DmuADSNR47wUsovCloNytT-5CsrVZf7ooaQGeBs1wmqRjiA>
    <xmx:SBgQZ3yycqF25PyMSc3dJH_LVQM34pepH8-Jjs3CUSKmg5lhVMdxvw>
    <xmx:SBgQZ6gzMuWDhUdryhkIL23OeCeBFIhhdiVixoFfyZ3FwIdtC2KmRpnn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 15:47:19 -0400 (EDT)
Date: Wed, 16 Oct 2024 12:47:18 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, andrew@lunn.ch,
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub
 operation to Delta
Message-ID: <ZxAYRthmAIHfW5c2@Boquns-Mac-mini.local>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-4-fujita.tomonori@gmail.com>
 <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>

On Wed, Oct 16, 2024 at 10:25:11AM +0200, Alice Ryhl wrote:
> On Wed, Oct 16, 2024 at 5:53 AM FUJITA Tomonori
> <fujita.tomonori@gmail.com> wrote:
> >
> > Change the output type of Ktime's subtraction operation from Ktime to
> > Delta. Currently, the output is Ktime:
> >
> > Ktime = Ktime - Ktime
> >
> > It means that Ktime is used to represent timedelta. Delta is
> > introduced so use it. A typical example is calculating the elapsed
> > time:
> >
> > Delta = current Ktime - past Ktime;
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> 
> So this means that you are repurposing Ktime as a replacement for
> Instant rather than making both a Delta and Instant type? Okay. That
> seems reasonable enough.
> 

I think it's still reasonable to introduce a `Instant<ClockSource>` type
(based on `Ktime`) to avoid some mis-uses, but we can do that in the
future.

Regards,
Boqun

> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Alice
> 

