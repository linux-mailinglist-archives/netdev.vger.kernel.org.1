Return-Path: <netdev+bounces-145877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE1A9D1377
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AF8280A08
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619E91A9B44;
	Mon, 18 Nov 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="T0jkDmOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4414D29D
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941093; cv=none; b=SLmje49O8u/IrnljPM6bxW3VOLp2pF1azcrY/Oq76F+0a5DF/q91T6wJhHffnxcYRdZaRi+kpWBDaLeSPJ+0FDQQajGUTdQUolovBPV/R+tCLjtxwTdkczPN7j9X4ao8c59zObzX+trYg6ZjbaGe6HvbG/Ckb7wpeqzldUjeFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941093; c=relaxed/simple;
	bh=E0cAa2aNq6Mc7yw5zkRWWjXMUlqp1v5EgXEorunS1QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldH5Qmz84SD7ICEQWeq0es4YU+jZsn+3ueRn3TEGMhVlzaSEJ9TBc5vE0i2jLwYs975wbqdJo9KqGcKKGjaTpi12wiXA1umo6DnSW7kqanS6LRQl7H5sW42zWE8JOboYqQ9Z7x9pyKfPH+C/XW/UdPSh99uAvoM2cR4xQKRDdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=T0jkDmOT; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f8b01bd40dso2902346a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731941091; x=1732545891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYWwOYLcwcPP+A/83kJ8ifuFWs5RtxL5hdw+gOPjj8M=;
        b=T0jkDmOTqWaqDsstYAdmCyLpKnWj/BTEYdEohJl+hYC2ba33kPcgXgy0e6rSgZuZDg
         SeYuCeXgUnf4AyEmN/LdWDD86hIKu698fkFVRjM0FeyHy3PgvV6ZObDIAzSbVlTH14Aj
         sttgjxN2pJezfa5RlCbQy9PJvXbb2h8mZwabk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941091; x=1732545891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYWwOYLcwcPP+A/83kJ8ifuFWs5RtxL5hdw+gOPjj8M=;
        b=X6k4RKHWWZ7YHPdJLCfdfVb9/2aSwo1n9xdqAWRKbm+fnNh/80kZh28yVHNz8NkyUb
         UgueYrNrLXLwzF9Fwjsc9VRtrFD9ihIySSDONEFRit4ZGhf0mJOuq1WjjSNiax6KIYeu
         tAc9WSmd8lEBLLzHt+sw/gZNO0r+obL7r5WirwjGbpxDL0+OCBKWYgugiCeM2wOgAY5P
         AgdfJwMU3lcWvJHXtetrQ4WisKq/zRSBJe/7QkWiNYU5oVCW2Fc16ngGHOnk4QG5kAc8
         mGr0OYCOMvv4djo7ASyU/kFqAWGq9IAnc7Lg3L+50dkdYcSjH0sbuJsVD2yjEnXZwxJg
         gOzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC8PE1UosRr+AghV33nmPnZSigfWoyS+2i2+Sjg7OIyf4dQM/5JeSMX9X75tQNPB9akByKNwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxOf/DkGeXLTNB65iyte5B+Q8T6gky7smbPQhjbd0TtuBw1Tp4
	SrFTR48N3b33rSWKbIK5Qkqr1cweKWLejPRUYOSweiXUfBcgcZqrbXgfLITh0LI=
X-Google-Smtp-Source: AGHT+IEZJC6qrfmQYXudfPY0b39hKgIq9lvIgiYMOg8ih4+/Gb88ayPiRHQN3KIh8gpc/eYlLUmo4g==
X-Received: by 2002:a17:902:7445:b0:212:3f13:d4bc with SMTP id d9443c01a7336-2123f13d691mr14557005ad.27.1731941090785;
        Mon, 18 Nov 2024 06:44:50 -0800 (PST)
Received: from fedora ([103.3.204.127])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211ff3cdd34sm34581735ad.103.2024.11.18.06.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:44:50 -0800 (PST)
Date: Mon, 18 Nov 2024 20:14:37 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: simplify Result<()> uses
Message-ID: <efp4og5bzb4by33m3kn3nuj2tbntsddxvhrfi7fkanfampd2ao@xt5dmffq77w5>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
 <ea0ee999-06ad-40d7-9118-695859fa9afd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <ea0ee999-06ad-40d7-9118-695859fa9afd@lunn.ch>

On 18.11.2024 14:29, Andrew Lunn wrote:
>> Andrew, Miguel:
>>
>> I can split it in the following subsystems:
>>
>>   rust: block:
>>   rust: uaccess:
>>   rust: macros:
>>   net: phy: qt2025:
>>
>> Should I do a patch series for first three, and put an individual patch for
>> qt2025?
>
>qt2025 should be an individual patch. How active is the block
>Maintainer with Rust patches? It might be he also wants an individual
>patch.
>
Last commit in block was in September. I haven't heard any objections from
Andreas.

>Please also note that the merge window just opened, so no patches will
>be accepted for the next two weeks.
>
>	Andrew

-- 
Manas

