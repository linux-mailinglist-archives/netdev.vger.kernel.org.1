Return-Path: <netdev+bounces-166287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5992A3559B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47FE218903CC
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA12155CBD;
	Fri, 14 Feb 2025 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEkMLijI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8787714B088;
	Fri, 14 Feb 2025 04:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506421; cv=none; b=UxgT/wAfV6n4cOmHIVlQTUuMnVwDOYBvgMqGNxScknhJkYbNPn5uE8rWXKR8HOzQ21h328djkCDDDdxWGyso1tBrXS3bSWAYdmq/xiQ0zFylR4ubnbSib5CpHwdT0gvrLPU8SzmEk/jLs8GHYaLIuEUU+2CI5CtRh5jD181wzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506421; c=relaxed/simple;
	bh=zsVSa4TSrR6lyD+HuxEGMFcXyDWqnEdajPkIjUTnTXE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=p0TnjcRgsUU8Oru+8RdEaoWNpuuCl4Tr+2S/NwuAz0uQMnCF0oZ0alrHiNyVQJ+2dOfgJk9CcnipoMm0zwXF66HburiW4DNEBl3ZTHoo5cEy5e+zKTUvx0WLpvJqv7r4OS656Ul0zjE/SOZvosE70ygmRukm0g6G13N1Z37mAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEkMLijI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220c8f38febso28345665ad.2;
        Thu, 13 Feb 2025 20:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739506420; x=1740111220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eHeVTJCzQAxCzBbbCXjwjG09eljwRN74/+whrUXZSY=;
        b=gEkMLijI7V4NMSRqlyyqp4VdGto7+E+gTVTlFl/Ml8/G6lSJJL4ErvjOPw/am1ULXC
         NbvtRbA5ONXG01eautaxN8VJVIHudaiF5V3ybfQh6aRLfZ7eZjQn2nE+KwtXvTt7IdqU
         mEYWPl8jpzJrIdoInS0TuVgfPQeFZmPGopbgZdE4ZSEx5o4XrW6H5fCKrSpAQT1Zx/E5
         cDH6qVmCoWQ5lXOwHyJK5ElYsQYuSbctBlDEh22JSvkNPF0UajWiKlx/2w634OpnVs08
         Khil0HL7SDnbEmzBMQ5X4eLgTswSYcawacYSGNwB6CG0//OdW1bnsFHHtW48W+/7neaJ
         za4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739506420; x=1740111220;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4eHeVTJCzQAxCzBbbCXjwjG09eljwRN74/+whrUXZSY=;
        b=IooEywgelTfNHTeYr/+3uRXH/lAffuOCfy/7wpYdV2SpzgVQucZ8H6iJ9cDKwekais
         b5kBlAcb1vdJDWSGINLIwMsV49QpMPcA7xxG2wieto7oKcOvhMmG9MG6EYy/mBY1C5c2
         MHWEckFXhvap9a5Gc9S1IDhOMc+ZWxZB9yPucX/wCA0gpaHuhRwJ3HimWPypiGgML1pR
         k1CGU2sNHCiipyQGfY9n7xbL9hu0ooOWUKRpe7xXmwN7ngHofjF89axKf7ZyBkc62PJ4
         FCDLIPFmbQ1H7RANiaQqKjvVvj88M4pgheVEf8wOwE/qIJ2071qQ03wQ73Lvqr9WEKt/
         MA0A==
X-Forwarded-Encrypted: i=1; AJvYcCU/rLkHZwC9+TNNbEWrH02ZyPRdrd3HMM382X8pJbSh5HilBD6A/9v9iWRKJpVpQtJLiVV0MP1aXcaUe34IWmw=@vger.kernel.org, AJvYcCVuY1NQODNTEKcDRmV3fzM3TKh+p2Ek+QksIdpOFxh8dR19pYByGe8oxKQofmtGJTf0y7lOGXIfMs2FRNE=@vger.kernel.org, AJvYcCWwpuveDPP0fACAsdpcQNGaE+Bw+lcztg+WHVszG2HgTfpVO6iv6eTZZGVmy25O/1dYaVKqTyeh@vger.kernel.org
X-Gm-Message-State: AOJu0YydkGmBRucAdoTghKxg6D3r9bgTVDmkm4VXi0maNRbRiCzllXSU
	9pxltC8kF7BwfXiXLiWMnikUXs0oe9ik0JxjR+wakBI/qsefndh/8BddTJjY
X-Gm-Gg: ASbGnctslV5CcEjMJVukBRkTuAUeXwVhOhgGXFRT/8cXngav6VBvYD+2NfONNwqUHKZ
	te5VIiYhet/m6x+T3/rHzXbTMAV/pAA0UD8wrpki3RYZKaK7DVldp61TcrMUh985iSJ2WBhgNrK
	aD7D9uLqOWAfpD+1Xg8r+nomj6ctYnzYrNBvN1amrCwMTD+Oa0earo8Kqakt1JBqpWiqKnUuyY1
	U1Habh2SdZGiMJl4NVV8OSsDrUK5VhXAVAD0iHo7fnPXw0hjrnFJj7mJHVRHjhXKJJRT3gpYIM+
	MtKzvJ1u/Rf7P9PqxM7xa0XAxnXyxk4kzO5bc+xZLxSQLeKsiwh+gc5PbXXH0+yaVMe9kFzi
X-Google-Smtp-Source: AGHT+IHfHsfYKzzk0Rceyikhzo4CkplC+zNnuN+RPfAVixTiJ2P2xJfqmXWuIPJNstimgfS88ZLEPw==
X-Received: by 2002:a17:903:124e:b0:212:996:3536 with SMTP id d9443c01a7336-220bdedcf55mr162205485ad.10.1739506419748;
        Thu, 13 Feb 2025 20:13:39 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d3a6sm20168785ad.160.2025.02.13.20.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 20:13:39 -0800 (PST)
Date: Fri, 14 Feb 2025 13:13:30 +0900 (JST)
Message-Id: <20250214.131330.2062210935756508516.fujita.tomonori@gmail.com>
To: daniel.almeida@collabora.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 7/8] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <3F610447-C8B9-4F9D-ABDA-31989024D109@collabora.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-8-fujita.tomonori@gmail.com>
	<3F610447-C8B9-4F9D-ABDA-31989024D109@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 22:50:37 -0300
Daniel Almeida <daniel.almeida@collabora.com> wrote:

>> +/// Polls periodically until a condition is met or a timeout is reached.
>> +///
>> +/// ```rust
>> +/// use kernel::io::poll::read_poll_timeout;
>> +/// use kernel::time::Delta;
>> +/// use kernel::sync::{SpinLock, new_spinlock};
>> +///
>> +/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
>> +/// let g = lock.lock();
>> +/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
>> +/// drop(g);
>> +///
>> +/// # Ok::<(), Error>(())
> 
> IMHO, the example section here needs to be improved.

Do you have any specific ideas?

Generally, this function is used to wait for the hardware to be
ready. So I can't think of a nice example.


>> +/// ```
>> +#[track_caller]
>> +pub fn read_poll_timeout<Op, Cond, T>(
>> +    mut op: Op,
>> +    mut cond: Cond,
>> +    sleep_delta: Delta,
>> +    timeout_delta: Option<Delta>,
>> +) -> Result<T>
>> +where
>> +    Op: FnMut() -> Result<T>,
>> +    Cond: FnMut(&T) -> bool,
>> +{
>> +    let start = Instant::now();
>> +    let sleep = !sleep_delta.is_zero();
>> +
>> +    if sleep {
>> +        might_sleep(Location::caller());
>> +    }
>> +
>> +    loop {
>> +        let val = op()?;
> 
> I.e.: it’s not clear that `op` computes `val` until you read this.
> 
>> +        if cond(&val) {
> 
> It’s a bit unclear how `cond` works, until you see this line here.
> 
> It’s even more important to explain this a tad better, since it differs slightly from the C API.

ok, I'll try to add some docs in v11.

> Also, it doesn’t help that `Op` and `Cond` take and return the unit type in the
> only example provided.
> 
> ― Daniel
> 
> 

