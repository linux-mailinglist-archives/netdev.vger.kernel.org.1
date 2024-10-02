Return-Path: <netdev+bounces-131176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49098D098
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3B71C20F69
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8D41E4110;
	Wed,  2 Oct 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O00ubB6q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B31A2561;
	Wed,  2 Oct 2024 09:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863016; cv=none; b=qP9C2PSPyVTT8fs1JiH42KrgosXTPt1pYZuHl4tpKhhz/BGEOh64vnQMRvFmWT1NDTw7Xv/bYH5dpyf5mOv19dkHWYsRIvkNEEaDWyxnza0ZfyloVoeIAWWhiK0KIfFsRUsW6cUA7md5o5DyE9mK1k4J0P8eqfpq6vqY2Nyv7Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863016; c=relaxed/simple;
	bh=SMKm6ZW/isr/XEcC2K0ZdmrANtC/SgRBbT1uYqzbVpw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c8cYsOKg3IeN7/eeky7gk5y6YwHtAeCdGFqCT3yUXiSgR46Eybta08Hy9G4omtONlmEI6b4XVaV9wQMSrr5Z5DFpbI37Sxw8HInYdgze7TSNBbhdEllgH+SkDT9V0NkaxNqKztC1XKc4clohDHP1FKsGhQLxEU7+XVtH/RhsHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O00ubB6q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20bc506347dso7249055ad.0;
        Wed, 02 Oct 2024 02:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727863014; x=1728467814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fz7TZaaeohjRLwTDlUpSA/F0EwKYsP5O3SYTjAHb5Rc=;
        b=O00ubB6q8y4qXtEdpBcaHulyiJZRbkt9+LuO2roxmkShfVVLyL5tQFu3LOOjMsRGwf
         CByQ85XA+LTWAQ+3+smkOH8HgCDs2pYcXgcHUa5SHJBCZ2opGbMjsko+UgOmXtysqMqC
         14P2KBfoLfHJNbYwf83IV+tKQlbC99GIlSa3UTFK3IcF7nQ+4oazI0SG29hlvIdleQUQ
         PuLS7VCWxtDFXAt2w9xZchWfmOjHKSEd0NQ4WG1Bly3opiSHo9n0GY8u0WduhmIM1veR
         EmKWv8koNdRTup72p4BPU3ZWMaPaXw3rVW6KjdhryBcsKCKQVHx3nRLnDzt2cW/BtBok
         bzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727863014; x=1728467814;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fz7TZaaeohjRLwTDlUpSA/F0EwKYsP5O3SYTjAHb5Rc=;
        b=cC0Ri43GhQVIW09SlE6Imz3Kw/N7FZ/mp3B3cULy7PrkCGJl0t7fOgEHK7kK10cxkX
         AbD6zmPNQ4hvM1MbcFrOKeevaniUFGNHYVCZj+OoK67yj+yC/eRQYjyv1Pn89TjUpbTX
         zMMwLTTgp5Ar6aj0Lt3xZHPErd6gNwohF2PtaraHLp5YlJxS14rpO+twaOVsJfgGjQ2o
         qEKI5s2Edw5lSBRShol5G3wxq+YhFkLnLAzOJf2FWepuHF0ZDHYrhENt/LjTbevedYLj
         vtOsvOxt9egfecH/MY1cqyldm5+/PLxcItbh0nfa6X7RPH/FKbwFofUBB0MwRNlCSQFz
         AbbA==
X-Forwarded-Encrypted: i=1; AJvYcCVRh2MU1ozwdEehLwVVv/fazBVjZocgxzRJ9f9DSW5ygjFAQlgJmpdbOVRTgBxBHOsg20GeXsZefg8yGWWOQh8=@vger.kernel.org, AJvYcCWfMzmm6fMAq/NZozVSAI1ff/qgupQ6apwUTU1rGvfbLgXXYts9bGwczq02PK3oS9Dcc+ftCXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+9hPjThi0c0lGcGe75KUZDkMp4l00XymL8SjSZHIaFZQE+aQ
	SxOyglF4B3em5ov6Ckz/oRpJFqekX8+Xzi4Cqgrjc31wD7kiAnhE
X-Google-Smtp-Source: AGHT+IEXpQjS2WC/xxQQQLKL8kBGjWe72PY+YYM22+7BSwRgWZIoK4PW1ITzq8NLnLEuceH7hXR79A==
X-Received: by 2002:a17:903:40c9:b0:20b:5808:3e29 with SMTP id d9443c01a7336-20bc5a8f650mr33222735ad.58.1727863014283;
        Wed, 02 Oct 2024 02:56:54 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4332csm81252645ad.215.2024.10.02.02.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:56:53 -0700 (PDT)
Date: Wed, 02 Oct 2024 09:56:36 +0000 (UTC)
Message-Id: <20241002.095636.680321517586867502.fujita.tomonori@gmail.com>
To: dirk.behme@de.bosch.com
Cc: andrew@lunn.ch, aliceryhl@google.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com
Subject: Re: iopoll abstraction
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
References: <CAH5fLghAC76mZ0WQVg6U9rZxe6Nz0Y=2mgDNzVw9FzwpuXDb2Q@mail.gmail.com>
	<c8ba40d3-0a18-4fb4-9ca3-d6cee6872712@lunn.ch>
	<76d6af29-f401-4031-94d9-f0dd33d44cad@de.bosch.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 06:39:48 +0200
Dirk Behme <dirk.behme@de.bosch.com> wrote:

>> I generally point developers at iopoll.h, because developers nearly
>> always get this sort of polling for something to happen wrong.
>> The kernel sleep functions guarantee the minimum sleep time. They say
>> nothing about the maximum sleep time. You can ask it to sleep for 1ms,
>> and in reality, due to something stealing the CPU and not being RT
>> friendly, it actually sleeps for 10ms. This extra long sleep time
>> blows straight past your timeout, if you have a time based timeout.
>> What most developers do is after the sleep() returns they check to see
>> if the timeout has been reached and then exit with -ETIMEDOUT. They
>> don't check the state of the hardware, which given its had a long time
>> to do its thing, probably is now in a good state. But the function
>> returns -ETIMEDOUT.
>> There should always be a check of the hardware state after the sleep,
>> in order to determine ETIMEDOUT vs 0.
>> As i said, most C developers get this wrong. So i don't really see why
>> Rust developers also will not get this wrong. So i like to discourage
>> this sort of code, and have Rust implementations of iopoll.h.
> 
> 
> Do we talk about some simple Rust wrappers for the macros in iopoll.h?
> E.g. something like [1]?
> 
> Or are we talking about some more complex (safety) dependencies which
> need some more complex abstraction handling?

(snip)

> int rust_helper_readb_poll_timeout(const volatile void * addr,
>                                   u64 val, u64 cond, u64 delay_us,
>                                   u64 timeout_us)
> {
>        return readb_poll_timeout(addr, val, cond, delay_us, timeout_us);
> }

I'm not sure a simple wrapper for iopoll.h works. We need to pass a
function. I'm testing a macro like the following (not added ktime
timeout yet):

macro_rules! read_poll_timeout {
    ($op:expr, $val:expr, $cond:expr, $sleep:expr, $timeout:expr, $($args:expr),*) => {{
        let _ = $val;
        loop {
            $val = $op($($args),*);
            if $cond {
                break;
            }
            kernel::delay::sleep($sleep);
        }
        if $cond {
            Ok(())
        } else {
            Err(kernel::error::code::ETIMEDOUT)
        }
    }};
}

