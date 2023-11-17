Return-Path: <netdev+bounces-48722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7457EF58A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7CA1C208B7
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7634CE3;
	Fri, 17 Nov 2023 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dGyZ0E2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245881984
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 07:42:50 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da31ec03186so1709560276.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700235769; x=1700840569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8PQm6egy8dPUbOjgkFnReCtJDIVJFmjcu3ZN7vSejc4=;
        b=dGyZ0E2CwWcenXA0DgOyR+ud8CArd80AF4AyHwilkP1xZJjzQeXT8WBaSCB2kSAYwU
         oJ5mN+WK+cKObIdWjq+c1xzgE7R4MDlCU5w0iJWkDUPhw0cv0yI5BmvHo6qSPDzPcfnK
         uJY+1Lk5DuGrT2dWK8PhLvyWs+j9BjYZdYBomdQnYevO40xWCq9CGjg60R6UXPLk6QTK
         FCv+PQdHzqBDS69K63PZBqfb911qtQln5WzZ+dUiMJT4rzJ6sCGPEtgbaIVifP746Yvm
         iNciGneDFoIdqF8F1FvNcHOgCw7Jx6DVWCHvpVqrgbzRtS/RPSHIio7vyROu3VgtMo81
         tHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700235769; x=1700840569;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8PQm6egy8dPUbOjgkFnReCtJDIVJFmjcu3ZN7vSejc4=;
        b=wjXJLgPi3HxrpaZemfttJ43w1TtV3bGuXz0+KxyWPgtD4CLNKTxuHO6uGco9YwveDF
         ZIKdyB481j/hifx3WYAG0XFFtzJYL6DcQ7vBGH5Ai9hPS9UZjNBRVI6mTbagpfcgeWbW
         GCHVZ3cfO6t/0AL9w7dhcGTVUA3x1VT/17PbwwNLR87Nn3yjXtlMIZGm0NcQtcQP4+Nu
         WsSFRjJbn7KOsCpp4PEQgj9MMN9YQhO5WVu9q60L5XFxrOz2ZOwmOP+TUy3E0GE5kVNa
         OUfJdcPYzVcBI/24vgRL36ctrJ5YXzkgCHXWDeXDGDQd3oJtEq/eYHRnOyEpJwxMSXhS
         7/1g==
X-Gm-Message-State: AOJu0Ywtg43j5JIYAGuvYy5QylPqxyHsJacp8I/Ek3AFMGdD//UxQIVU
	rQW7Xc4s2HXes+V2vpQu77PgX4w4AiQ3QJ8=
X-Google-Smtp-Source: AGHT+IF19Mhe3LUEgDqdN4CbvmeL0fEDlGHdk8DFB/9v/AQIyw6un1NHwJoz1U8gNq+UooeZznMZ2gx/v5iSW/Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:602:b0:daf:3e84:d016 with SMTP
 id d2-20020a056902060200b00daf3e84d016mr168163ybt.2.1700235769326; Fri, 17
 Nov 2023 07:42:49 -0800 (PST)
Date: Fri, 17 Nov 2023 15:42:46 +0000
In-Reply-To: <61f93419-396d-4592-b28b-9c681952a873@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <61f93419-396d-4592-b28b-9c681952a873@lunn.ch>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231117154246.2571219-1-aliceryhl@google.com>
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY drivers
From: Alice Ryhl <aliceryhl@google.com>
To: andrew@lunn.ch
Cc: aliceryhl@google.com, benno.lossin@proton.me, fujita.tomonori@gmail.com, 
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

Andrew Lunn <andrew@lunn.ch> writes:
>> I used "X mutex" as an example for the synchronization mechanism in the
>> above snippets, but it sounds like its more complicated than that? Here
>> are some possible alternatives I could come up with:
> 
> So X would be phy_device->lock.
> 
> Suspend and resume don't have this lock held. I don't actually
> remember the details, but there is an email discussion with Russell
> King which does explain the problem we had, and why we think it is
> safe to not hold the lock.

So, what I would prefer to see as the struct invariant would be:

 * Either phy_device->lock is held,
 * or, we are in whatever situation you are in when you call suspend and
   resume.

The five suggestions I gave were my guesses as to what that situation
might be.

>> /// # Invariants
>> ///
>> /// Referencing a `phy_device` using this struct asserts that the X
>> /// mutex is held, or that the reference has exclusive access to the
>> /// entire `phy_device`.
>> #[repr(transparent)]
>> pub struct Device(Opaque<bindings::phy_device>);
> 
> You can never have exclusive access to the entire phy_device, because
> it contains a mutex. Other threads can block on that mutex, which
> involves changing the linked list in the mutex.
> 
> But that is also a pretty common pattern, put the mutex inside the
> structure it protects. So when you say 'exclusive access to the entire
> `phy_device`' you actually mean excluding mutex, spinlocks, atomic
> variables, etc?

No, I really meant exclusive access to everything. This suggestion is
where I guessed that the situation might be "we just created the
phy_device, and haven't yet shared it with anyone, so it's okay to
access it without the lock". But it sounds like that's not the case.

>> /// Referencing a `phy_device` using this struct asserts exclusive
>> /// access to the following fields: phy_id, state, speed, duplex. And
>> /// read access to the following fields: link, autoneg_complete,
>> /// autoneg.
>> #[repr(transparent)]
>> pub struct Device(Opaque<bindings::phy_device>);
> 
> For the Rust code, you can maybe do this. But the Rust code calls into
> C helpers to get the real work done, and they expect to have access to
> pretty much everything in phy_device.

Yeah, agreed, this is probably the suggestion I disliked the most.

>> /// # Invariants
>> ///
>> /// Referencing a `phy_device` using this struct asserts that the user
>> /// is inside a Y scope as defined in Documentation/foo/bar.
>> #[repr(transparent)]
>> pub struct Device(Opaque<bindings::phy_device>);
> 
> There is no such documentation that i know of, except it does get
> repeated again and again on the mailling lists. Its tribal knowledge.

Then, my suggestion would be to write down that tribal knowledge in the
safety comments.

>> But I don't know how these things are actually synchronized. Maybe
>> it is some sixth option. I would be happy to help draft these safety
>> comments once the actual synchronization mechanism is clear to me.
> 
> The model is: synchronisation is not the drivers problem.
> 
> With a few years of experience reviewing drivers, you notice that
> there are a number of driver writers who have no idea about
> locking. They don't even think about it. So where possible, its best
> to hide all the locking from them in the core. The core is in theory
> developed by developers who do mostly understand locking and have a
> better chance of getting it right. Its also exercised a lot more,
> since its shared by all drivers.
> 
> My experience with this one Rust driver so far is that Rust developers
> have problems accepting that its not the drivers problem.

I agree that locking should not be the driver's problem. If there's any
comment about locking in patch 5 of this patchset, then something has
gone wrong.

However, I don't see this file as part of the driver. It's a wrapper
around the core, which makes it part of the core. Like the C core, the
Rust abstractions will be shared by all Rust drivers. The correctness of
the unsafe code here is what ensures that drivers are not able to mess
up the locking in safe code.


Anyway. If you don't want to write down the tribal knowledge here, then
I suggest this simpler wording:

/// # Invariants
///
/// Referencing a `phy_device` using this struct asserts that you are in
/// a context where all methods defined on this struct are safe to call.
#[repr(transparent)]
pub struct Device(Opaque<bindings::phy_device>);

This invariant is much less precise, but at least it is correct.

Other safety comments may then be:

	/// Gets the id of the PHY.
	pub fn phy_id(&self) -> u32 {
	    let phydev = self.0.get();
	    // SAFETY: The struct invariant ensures that we may access
	    // this field without additional synchronization.
	    unsafe { (*phydev).phy_id }
	}

And:

	unsafe extern "C" fn soft_reset_callback(
	    phydev: *mut bindings::phy_device,
	) -> core::ffi::c_int {
	    from_result(|| {
	        // SAFETY: This callback is called only in contexts
		// where we hold `phy_device->lock`, so the accessors on
		// `Device` are okay to call.
	        let dev = unsafe { Device::from_raw(phydev) };
	        T::soft_reset(dev)?;
	        Ok(0)
	    })
	}

And:

	unsafe extern "C" fn resume_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
	    from_result(|| {
	        // SAFETY: The C core code ensures that the accessors on
		// `Device` are okay to call even though `phy_device->lock`
		// might not be held.
	        let dev = unsafe { Device::from_raw(phydev) };
	        T::resume(dev)?;
	        Ok(0)
	    })
	}

Alice

