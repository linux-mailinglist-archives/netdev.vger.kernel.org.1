Return-Path: <netdev+bounces-49651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1E7F2D89
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95352B212A6
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7912AD38;
	Tue, 21 Nov 2023 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2kfLOZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A65D47;
	Tue, 21 Nov 2023 04:47:34 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b83442be42so110403b6e.0;
        Tue, 21 Nov 2023 04:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700570854; x=1701175654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3P+PI2Q9AIKfxpMddliChMEhA8JFP8Cj6vfTCkDGUE=;
        b=c2kfLOZYRX2Wc5x1iWkeaWMKF75RNxrloH/eRX2rJh8tT6j9WT7LyX5pZ3Qd0oTZ2J
         DJEfpw76kgxzfMl9ToaMQb8QK3PIw+8QD8NFHzP+ZIg54LGn3BAej92LXLn1eSIYOiti
         /KXvqkiPF972saNOh0BmJaAik4N5nkKj7ZfKBDrEDuFH5687kkkcSN81740i2ubYx7jx
         NzwuPEjviRqQBL77Y1u/QVbT3nbutNnvFBTR612PnMatKd2QskRO25cOyDcV0ZmbPwC5
         GSDvDgjBfsVSHNE8lIHxmmF72Q34H2lTZK14+lYiQkPpgfkqvbHo5wGdhUrOXJ0C8m5x
         3I8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700570854; x=1701175654;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G3P+PI2Q9AIKfxpMddliChMEhA8JFP8Cj6vfTCkDGUE=;
        b=UO4UgQ3crTrp0KrdyE3hGE9OOzieAIl8j0vgAllbu8Na/aHis7ZaiIJ/gzTQbhZrjP
         d9/Bgkyt2k1AQ5JVdVLMILI8X6AILPXv+hS20mzPYEzbxIXm9GFydDqQo+/4VeQtoyFa
         CekzlkhfeuR+W979SAQ3GLtRS+wzjkF1Z6eTXWGfS7h00sqjeUmcB3yKlX/90ds39Y9Q
         YOlGAfw/G+Nq6ULyS0PWFkYZEQFBVy16prWZyAmLHNhwD/4CyufCJxhzBIXwQeEpPsk9
         zjXVt+aJhHrnqlCX4qg/rvi65pthyktasPzjmxtiSjQjicqBAVYmNYvyYTjJzIczVjjE
         j45A==
X-Gm-Message-State: AOJu0YwXrdbxcjaI6XJI7JhE5/qt50D1CK3+E+rUHF1MMk786v8XWG7n
	T4a/+9aqkB+qumxrqKgVcd6SryggWo/uc3S7
X-Google-Smtp-Source: AGHT+IGxPvubfTgvGo3yizljGD2tRxgw5B/6DaquBggRsEkqwXIV5L+9rRkHb3xM0s+K/37xqaOhEQ==
X-Received: by 2002:a05:6808:17a2:b0:3b6:cc77:6944 with SMTP id bg34-20020a05680817a200b003b6cc776944mr13981070oib.0.1700570854190;
        Tue, 21 Nov 2023 04:47:34 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v64-20020a638943000000b005b9288d51f0sm7720203pgd.48.2023.11.21.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 04:47:33 -0800 (PST)
Date: Tue, 21 Nov 2023 21:47:32 +0900 (JST)
Message-Id: <20231121.214732.541476521256381764.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: andrew@lunn.ch, benno.lossin@proton.me, fujita.tomonori@gmail.com,
 miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20231117154246.2571219-1-aliceryhl@google.com>
References: <61f93419-396d-4592-b28b-9c681952a873@lunn.ch>
	<20231117154246.2571219-1-aliceryhl@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 15:42:46 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> Anyway. If you don't want to write down the tribal knowledge here, then
> I suggest this simpler wording:
> 
> /// # Invariants
> ///
> /// Referencing a `phy_device` using this struct asserts that you are in
> /// a context where all methods defined on this struct are safe to call.
> #[repr(transparent)]
> pub struct Device(Opaque<bindings::phy_device>);
> 
> This invariant is much less precise, but at least it is correct.
> 
> Other safety comments may then be:
> 
> 	/// Gets the id of the PHY.
> 	pub fn phy_id(&self) -> u32 {
> 	    let phydev = self.0.get();
> 	    // SAFETY: The struct invariant ensures that we may access
> 	    // this field without additional synchronization.
> 	    unsafe { (*phydev).phy_id }
> 	}
> 
> And:
> 
> 	unsafe extern "C" fn soft_reset_callback(
> 	    phydev: *mut bindings::phy_device,
> 	) -> core::ffi::c_int {
> 	    from_result(|| {
> 	        // SAFETY: This callback is called only in contexts
> 		// where we hold `phy_device->lock`, so the accessors on
> 		// `Device` are okay to call.
> 	        let dev = unsafe { Device::from_raw(phydev) };
> 	        T::soft_reset(dev)?;
> 	        Ok(0)
> 	    })
> 	}
> 
> And:
> 
> 	unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
> 	    from_result(|| {
> 	        // SAFETY: The C core code ensures that the accessors on
> 		// `Device` are okay to call even though `phy_device->lock`
> 		// might not be held.
> 	        let dev = unsafe { Device::from_raw(phydev) };
> 	        T::resume(dev)?;
> 	        Ok(0)
> 	    })
> 	}

With these comments, What I should write on from_raw() function as a
safety comment?

/// # Safety
///
/// For the duration of 'a, the pointer must point at a valid
/// `phy_device`, and the caller must ensure that an user of this struct
/// in a context where all methods defined on this struct are safe to
/// call.
unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {


