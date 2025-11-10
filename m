Return-Path: <netdev+bounces-237373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AE0C49BD3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7A18835E5
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB4E302165;
	Mon, 10 Nov 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUMhSl/y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFDB242D78
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762817095; cv=none; b=D5Uie7fnbtAV0n25DleAyd2n+SyJRCfB2t//EJ6E0J1qVeEKqYPC0AX/sPLGJ5lQeKBjMwe3yEj5liMpzSy0PvM4TTOXDLsXgF5j8MsJQG+M93hXd37/6tR9enuipEHDS9o5yToWUJosXoL7fup3EPeGygjXPgKVI1yDKa/3dyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762817095; c=relaxed/simple;
	bh=LfgMc321C2gmcbEJ383Vf+rgHpae4BVbOamwU+8oUxk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UuHHuo/yeq47o8wzBDvMothwwECNG6cs/tf4CTNFF3GzNq0wp2+KDIk4nvIFs66YXem3TMdKPddKSMNYUpD6mK4tvmymrGoqXeB5KT5eQSNjdvRElSKTbTSPyKj2nPmW6L8dR+uFAzBSVchv/3hTbinN2ybkw5KJwEag3JCr/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUMhSl/y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297dc3e299bso25871225ad.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 15:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762817094; x=1763421894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rB+sgp3H4KhlCjjfdfflHKnV1BKdMwtwK7bRa+WX+h8=;
        b=NUMhSl/yWrmfhdHJdX8fih355M0vD3HaxKpbVlgg92iS8OdPmXRoQTxj3Chn08DduF
         fLeJ2Z0hRlSivSJHFLxZq/9jYEf7acz+qIrek/3pBCkBggns2OypGaXQJIOV6zKF2DFD
         3/VyInLtLJbynuXA5BT2nHR03dOhxGIH+u/w23IhcGUlqlnNdww9AGb4AOoQK5Qcf18E
         T9L5mSVa49EdF7y2xTpOujSgjpGyDRPSGzp/6NwwUfGv73tYoSHfeU/afKlvUN3w+c1r
         CbX0vx7U94T+a3o5d2CvwjknEZHNoxAxB8xDwM07ZpWYdPgmpEb+MMYIxStTPNhaYuz0
         OcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762817094; x=1763421894;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB+sgp3H4KhlCjjfdfflHKnV1BKdMwtwK7bRa+WX+h8=;
        b=vZeE6+hiFvF4MRMP3nMl1HFYDQ1ojRe7hX32kgeVUZE54RgHe3DsoSatTLCAQ3/7WH
         OGx+X0J7tPYx4FC7GCIJI+w/Vljt3KQ4ZfZCEotClW+4hnKfaBpA6rlfjvHWVBQ5eCJT
         f5L4DlVGY96SePOZpxcxefsY8wxHXguUCfqZmsFKd7g9J49DWXsvbMnyqPgOuRbvbOYo
         jj3JPUuDPWMLET42+Y1cYiKp4s8RU862HCKpB77JDyjdJUaohl8nXWd7VkRq7sik2EWs
         FpFkoi1Kkd9nwJC/9esTRCjAcN0dJ7XMVgyu57d2Ds9UBYH9oxqheR4dNtPQ+6ZbkDRx
         PwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+scR+5DP4EGofhI8JHTkqPNOSKCP87qUcryeOfp4jXkow4e7XMIPoJZ3idt0hcovKQUn4j4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsWQ3950eEf+nYoNMX6SgMoIQKnS8oOtBMdjEqv4/xe9AspqQj
	X1EksJL8NLcKwoeM67EILHejAZxppAxkPxBLTaT/uhejOwaLUebswf6H
X-Gm-Gg: ASbGncvMtUDmWmnPJmnrY1a18+0iFjoMCexcVFmllgne6JJihkBemQOK1hxagBNj3tW
	Vg6UpbsSJJpW4BOd8J5YbpeyuzeFHFtlaS6uPW5WEmqmsyW+2UrLJ/wFp5+xjlsbvqDVtAoineq
	OCT2tj2sJwiOrGNY+fFfIMTDMvHDWLu1o7S18fvcv8f9yo/WmDB6NY8+biZi9zxkIGUfFifpjqX
	tC7+hsOhkROim0saHGfNWL6i7wQwBfxF7JOZ9HHZ4qy09TekDGRHv73S1hTseV53hCPQmd81tCZ
	1gOxDKZ1MkzlV9Ctq09k1XgmaHoRU5J/5thnFtwh0l0ygKiTZiNCWYzmv6+/a6msflHi1P+Q96z
	vKTNLZPpYW1tI7wi51W1wOwY3smE7+tJtyat6sgtC97pln2aJmEIrOTkAXXRT54Y6kxjkvYWQQi
	tyIxu7Ry//tGIKDJN0Fg6/5ClaZhbDah6jlQkcShceD3k08gUUmOnhs9UT/ISTE43S
X-Google-Smtp-Source: AGHT+IGPaBk6e9Khb1yqRKfYMFmfSNYwn1VnFyXe0wXMOkJC9R7tqlKr6n2Ksy2ki1vCKQog9xKolg==
X-Received: by 2002:a17:902:ef02:b0:295:a1a5:bb0f with SMTP id d9443c01a7336-297e565d7aemr118857735ad.18.1762817093570;
        Mon, 10 Nov 2025 15:24:53 -0800 (PST)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c30b96dsm12092310a91.5.2025.11.10.15.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 15:24:53 -0800 (PST)
Date: Tue, 11 Nov 2025 08:24:38 +0900 (JST)
Message-Id: <20251111.082438.1117005832484432168.fujita.tomonori@gmail.com>
To: ojeda@kernel.org
Cc: fujita.tomonori@gmail.com, alex.gaynor@gmail.com, tmgross@umich.edu,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 dakr@kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: net: phy: fix example's references to
 `C{22,45}`
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20251110122223.1677654-1-ojeda@kernel.org>
References: <20251110122223.1677654-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:22:21 +0100
Miguel Ojeda <ojeda@kernel.org> wrote:

> The example refers to `phy::C{22,45}`, but there are no such items --
> they are within `reg`.
> 
> Thus fix it.
> 
> Fixes: 5114e05a3cfa ("rust: net::phy unified genphy_read_status function for C22 and C45 registers")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>


