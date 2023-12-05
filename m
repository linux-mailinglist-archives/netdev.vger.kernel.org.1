Return-Path: <netdev+bounces-53752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBD8045FB
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 04:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E67C1C20BFF
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DB611E;
	Tue,  5 Dec 2023 03:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSRmv69M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC4ECE;
	Mon,  4 Dec 2023 19:23:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d0c7330ad9so140195ad.1;
        Mon, 04 Dec 2023 19:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701746601; x=1702351401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvxaZrlN6riBflsS5wOrGFq6Ymsdyl6Sjh9pe9Rny5o=;
        b=DSRmv69MmqtLKL/Xz89HgP8ykjHx13h5fyDl+QH2dPi2uE+sPZUbg4EniI+EZiuat5
         xkzrbvKjTmdFpenVzjuVv50a9zWlXRvxOt7CnZj+qtsYHkaRrwo9YsQLm4NG7GxL18QC
         rYDlPV2h3vInunMHLarstdVPmJXsrXa73gkJbNOG9DtDsEI2nNE3oDu29xX5iSOPeNo3
         tbeoOZRjCZhQf1NnfFkywaLAA+pGymklNaqHr0sxOFxcsbyLUbg4HdEqVwyAaatrY+p9
         Ede1zkMzXmCc7B2ujnOM8v/ObAwCIQgtC+ACy2uMSJ8nUd4fx4fL6qW/P6F0J5oq92+Z
         Fe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701746601; x=1702351401;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JvxaZrlN6riBflsS5wOrGFq6Ymsdyl6Sjh9pe9Rny5o=;
        b=aMxqYTV/Sz1R5zED0aQE9DdMWpJeZrsIubHa0hzDQAoOPr3OOVOwlP/x6gC6CoGogM
         A3+Mf50571P6Q8PtUPzh9D9B3Vf+hs1QTXwZwx8z8CTdBtaWlWoSwiz17Al63PHeVvHD
         sysUSj6v4K+uFKV8wC/woKFjLhBXgrWQ5BLScr0biF/sq+k93MQrEbmRnpxBkaWsoMWf
         4WpX/6xIAPtHP9Z14YbBDxnMiLL1YrYBl6l/OEzHA6Z1bmX5ZvHiMDuJPIEDGzpE3qnN
         Np7DvuxdfqOFKrEDUE1ktIgYOlk4AP3prr7pbgEVtbgAiKadwPt94EXgIR1ZYVMxQ5GD
         eWsQ==
X-Gm-Message-State: AOJu0YzfZcNd9L/yIAxG3oZHJc7Pi8N3DA9UffkcNV6hMDavG3/tnMON
	7z1vmmd+SuBmiPgSAZXdAhc=
X-Google-Smtp-Source: AGHT+IGHJZ9DnXPGHbM3qszHQ8KKpstIZgpKnqcJoNdvH/c9q4IhbG2ciaK0nohhU77BVNw4Yv0Xbw==
X-Received: by 2002:a17:903:1cf:b0:1d0:83bc:5648 with SMTP id e15-20020a17090301cf00b001d083bc5648mr7720344plh.2.1701746601019;
        Mon, 04 Dec 2023 19:23:21 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001cf838dadbesm9120695plg.56.2023.12.04.19.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 19:23:20 -0800 (PST)
Date: Tue, 05 Dec 2023 12:23:20 +0900 (JST)
Message-Id: <20231205.122320.1887043941025150953.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 wedsonaf@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v9 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <ZW6EL-4XaoY3n4J9@Boquns-Mac-mini.home>
References: <20231205011420.1246000-1-fujita.tomonori@gmail.com>
	<20231205011420.1246000-2-fujita.tomonori@gmail.com>
	<ZW6EL-4XaoY3n4J9@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 18:00:15 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Tue, Dec 05, 2023 at 10:14:17AM +0900, FUJITA Tomonori wrote:
> [...]
>> +    /// Gets the current link state.
>> +    ///
>> +    /// It returns true if the link is up.
>> +    pub fn is_link_up(&self) -> bool {
>> +        const LINK_IS_UP: u64 = 1;
>> +        // TODO: the code to access to the bit field will be replaced with automatically
>> +        // generated code by bindgen when it becomes possible.
>> +        // SAFETY: The struct invariant ensures that we may access
>> +        // this field without additional synchronization.
>> +        let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
>> +        bit_field.get(14, 1) == LINK_IS_UP
> 
> I made a mistake here [1], this should be:
> 
>     let bit_field = unsafe { &*(core::ptr::addr_of!((*self.0.get())._bitfield_1)) };
>     bit_field.get(14, 1) == LINK_IS_UP
> 
> without `core::ptr::add_of!`, `*(self.0.get())` would still create a
> temporary `&` to the underlying object I believe. `addr_of!` is the way
> to avoid create the temporary reference. Same for the other functions.

If so, how about functions to access to non bit field like phy_id()?

pub fn phy_id(&self) -> u32 {
    let phydev = self.0.get();
    unsafe { (*phydev).phy_id }
}

