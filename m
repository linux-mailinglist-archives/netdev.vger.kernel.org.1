Return-Path: <netdev+bounces-89209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB598A9AEC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C55DB21499
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38838144D1E;
	Thu, 18 Apr 2024 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jai9tshD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107515FA7F;
	Thu, 18 Apr 2024 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445846; cv=none; b=hcnrqyC3/iCxAuP8LjkfDeQw554j0qRJBdNdAY/0d3k8IhVC290VrVDwrpdEiU/I2gnZp9HdmiwvPBvW5hdrqxcDDvFX28VGc7nKJ2wEFvb+/BRGKvbbiohPhUa4/vnBNMe3LdDNADWAKJmoNf6/uvc21M19tWjsziM6/4U/xVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445846; c=relaxed/simple;
	bh=Ijj1dwb9v6F+an491VJl7zBLMESUwDnbFdaHDHwFazM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uhPJQprLWwRvFlBNWqXeIlBmaRDtQKK4qyg0xgiwnR1Eabubhh5P6zFng+we2sfYMGWzVc9phmUWwwJ1AICYQpk2HMAWLL1J9mES/aGc/IyMmC5Amqe4lGo+CjC20+32v7PbFRt+I0BecAEkaj0tdfN2JXuREgJxt+YnOeRSAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jai9tshD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f77640a4dcso53192a12.3;
        Thu, 18 Apr 2024 06:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713445840; x=1714050640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KISK7P5bbl6r1Ilal3LAM8KQslNHMyxoFESJZBFyfeE=;
        b=Jai9tshDHyxfNrmN8haSFGGNoC9n8bCHgcnQSoRbXvY4GJoq8iZohms1El8e1LWaLk
         7qpfc1pf2AS8VxTh75qI+gsy4qpi8vVWvLu9g/p0snQp6NtqD8LWwfaZvib7fdzYSNAK
         5Lix7iBbuyJSMSMmCHOCMgZyX/j/H/Abv4a1REtIPdCwP+1rjCZ5N52JxnM3EBfvCxfV
         +pespJIHO/6tej+uJxy+jYnm3SHJg0qUkmOXlvSqzzs8IqSwZvWN74l+5e0w07QYlyfy
         E3iD9Dtn5GOeYLBu7zVFznRUEMT26Ij53tgv2q5DXJKOq6WPMNJG22oOUJ4Pt2AENXhd
         S/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445840; x=1714050640;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KISK7P5bbl6r1Ilal3LAM8KQslNHMyxoFESJZBFyfeE=;
        b=jDQas/u5BzJApRunE53zqyIR5xbTBXERHcduTsz6HIgf7oF6J4l0ipPuMId1f/uJi0
         fwpwFbSVXjnrceOJ72/UvQfiwN1UlDncwWYFMM+FAkpbAFcalNQz+ZFGlG+kFADtusCp
         04d9NGIa1Y1gX14J8tAvyPDPE4/0u7IpbectWrQWFBqQofhaVGSCY9pAFk6qpK+Wu9lI
         tghPIGLNNaLAZ3w9P47aRGCCiqGZtxVCqz74htubRG0bXOycHkUk+2jubEM2LPj860Js
         feVPX7/QAITzgx9XEZkCM7XUhI7FqW3EtN5JkamfDhucJw8Td3w0hDOCnbuExBxwWfeq
         xGnA==
X-Forwarded-Encrypted: i=1; AJvYcCWGn/fIre8HCUKOjXUOSJYiOPsKr0lQkkjB2lZCORUjCEOyPjrqTM+dGQO1YX2Vn6SFrqBbPv8GVZPyh9Di4DaqsQKM3dgQnP4oMxg3qSUJsB8WDvjpYW3GjFOxabWrhDGybWZ5YIw=
X-Gm-Message-State: AOJu0YwSPXFTtuGR+l1Fkjv3k/gFf11ISpiTCsdTh03aIjYNZUqYxGdZ
	Zzc+6W+8xTPdbabC2TjMFnwgMh7lmy6HMYbzaCMeNOWRIo3xhnhY
X-Google-Smtp-Source: AGHT+IH6kWFmckJ6i0BDSF63YBc6hZp8YdctopiXIhX2Q9KBkirn0vyClvEEBepiF5mLWL4TAn9+Sg==
X-Received: by 2002:a17:90a:2e18:b0:2ab:c769:4e65 with SMTP id q24-20020a17090a2e1800b002abc7694e65mr1941247pjd.2.1713445840504;
        Thu, 18 Apr 2024 06:10:40 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id p4-20020a17090ac00400b002a3a154b974sm1399073pjt.55.2024.04.18.06.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:10:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:10:28 +0900 (JST)
Message-Id: <20240418.221028.963285260268190475.fujita.tomonori@gmail.com>
To: dakr@redhat.com
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, mcgrof@kernel.org,
 netdev@vger.kernel.org, russ.weight@linux.dev, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v1 3/4] rust: net::phy support Firmware API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <60a3d668-4653-43b5-b40f-87fb7daaef50@redhat.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
	<20240415104701.4772-4-fujita.tomonori@gmail.com>
	<60a3d668-4653-43b5-b40f-87fb7daaef50@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 17:45:46 +0200
Danilo Krummrich <dakr@redhat.com> wrote:

> On 4/15/24 12:47, FUJITA Tomonori wrote:
>> This patch adds support to the following basic Firmware API:
>> - request_firmware
>> - release_firmware
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> CC: Luis Chamberlain <mcgrof@kernel.org>
>> CC: Russ Weight <russ.weight@linux.dev>
>> ---
>>   drivers/net/phy/Kconfig         |  1 +
>>   rust/bindings/bindings_helper.h |  1 +
>>   rust/kernel/net/phy.rs          | 45 +++++++++++++++++++++++++++++++++
>>   3 files changed, 47 insertions(+)
> 
> As Greg already mentioned, this shouldn't be implemented specifically
> for struct
> phy_device, but rather for a generic struct device.

Yeah, I have a version of creating rust/kernel/firmware.rs locally but
I wanted to know if a temporary solution could be accepted.


> In order to use them from your PHY driver, I think all you need to do
> is to implement
> AsRef<> for your phy::Device:
> 
> impl AsRef<device::Device> for Device {
>     fn as_ref(&self) -> &device::Device {
>         // SAFETY: By the type invariants, we know that `self.ptr` is non-null
>         and valid.
>         unsafe { device::Device::from_raw(&mut (*self.ptr).mdio.dev) }
>     }
> }

My implementation uses RawDevice trait in old rust branch (Wedson
implemented, I suppose):

https://github.com/Rust-for-Linux/linux/blob/18b7491480025420896e0c8b73c98475c3806c6f/rust/kernel/device.rs#L37

pub unsafe trait RawDevice {
    /// Returns the raw `struct device` related to `self`.
    fn raw_device(&self) -> *mut bindings::device;


Which is better?

