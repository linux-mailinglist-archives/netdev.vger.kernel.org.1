Return-Path: <netdev+bounces-168145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247BA3DB14
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B7919C08FE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651171F4E21;
	Thu, 20 Feb 2025 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoG4kkYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA7D1E9B0B
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057445; cv=none; b=OWK9EJvgN358MteYl8Ao4YZMG7wAeVwvar2mS673QFFwopbIGlGS69tQpNnmV+g/mBKyD5rwZX6Lceo7VQy53203an5v4YNxLDJFIjLNx0N7kvWwa9lpDacJboWyliBC0mhmLuoqaku/TU6eFAL4rQoUaWe205nF9Ss9r7DTmaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057445; c=relaxed/simple;
	bh=qGCx5PH6IBnUd85emvcm/CLJCm+zXaIIjGxBf79+eZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGgtODSRsTE9FdyODyLX78pOHpXgbF/O7SMMb/ozNllo5JfR73CvTzCiwkUicNMt19y3H1LxFvwoZW4zF87PHCBViPj7wFZOtr8BMjhnxjObn6bf91mnMtn9D1miiTK1eiQ0WagZi8H4jy3tpKpvDPs9GBc8dpT2zuLFXSS6bJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoG4kkYn; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so1623085a12.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 05:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740057442; x=1740662242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpOjgg5u+58o72/H+ph4WETQTh2LWVY3E0SeUKLXL1k=;
        b=XoG4kkYnatEjaHDc3Sd7yvqDoRhIeuBID733PMGiWNlywJTgSB48Vb3Uvc64uPI0lP
         0kea1m8QDHDmg7+ZmSkjQOljqeDcetOalJZJ41zz7DPiDgbQAcH3sfCoeBL3Tn8IHh4f
         eD1rP+bqsfOOWxgNQoaphTR3mV4oR87tsip3StF4wtCj29scfrA7ChX1jZ3EiwcsHa8E
         ogLU3sxjnERWzmuWywPfLYrk6ectQCQhxhEopgOgi4IMOQdoANdLIZgmUXtS1UR+oYi3
         46h4wwT+qjY19IZtyByF4bXaIbWyDooEK33EYq/HGzchfBejAFUJnoAMD/tqS+necNGg
         C2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740057442; x=1740662242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UpOjgg5u+58o72/H+ph4WETQTh2LWVY3E0SeUKLXL1k=;
        b=b3GXTp34bTwT6yit80SqnplmZaE3PfSGfdC8HlOEuHTylyC2cPFHM4gAKpHusfDboP
         jULTB83sM6JdjfyrpUo9dCxP/XANNJKtV5Rjow57C5qXNK/yGoqwyl3y6yDoMikBrpAt
         koBgiRIMdrjnrDqfH1y1NRXTRuMYoQ+VqZmQIm9gQ+ZUFSQYlKKeibHlwJ/Yu8XSn/BT
         A0ae1L0sF7694Xd5jHxVipVjDdnWGKarIt+7p0n2RA3cUSuTlSD1OCaaAZpNF0OibazV
         B7v46/vzwBLcA4bB44c6C7oTeJu2J3PR337WjyxBDhpy4Zka29cEup3RjV42bNQG920o
         9+CA==
X-Forwarded-Encrypted: i=1; AJvYcCWyDhyUs4/EHeaT10RYkstWoGWAc4wdvnFqzB0oXC//CQnK7CMsYlqe7n5Qu5q5MUfFWGEho9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ91K6v/DJ0c0pd6hKC+rvRTZlpiI/K0YCG9N92uQmpRaAwQ4k
	zBxvmyU1Or3UU6iXS7Se1QjkFYd/U+GcmtzQOyGN4eC2xsLBuZUteyN/rJOfDbanXcNsVnP2B49
	qpeezIzmw+hhO1HkpAQo7OJ5NW2Otu8ODRTT+
X-Gm-Gg: ASbGnctOxS8KkiW5fBmR0SQOtAd1361qbQVqNr3KKARdXIseAPMjQVawlHEralrvo9O
	Fqw7WgeZOHHAbFASVag8mZ1z1jGjKnBGjvGR5xa98k/sagGfL30HTJVp6BXuDMGgGlLNuzrng/z
	yihFBnCsPuxTXN4CelsJD8C4gez0IFeA==
X-Google-Smtp-Source: AGHT+IG+7j6/Fz3rUdjNu8MW6O6gxfiAeBG+Y+KyMLGWaEHrRF5iDWzEzbPu8Kn6xytQs3ASlf3TqMQgt5MNjXZvyo4=
X-Received: by 2002:a05:6402:5109:b0:5db:e7eb:1b4a with SMTP id
 4fb4d7f45d1cf-5e03608c91amr19947563a12.10.1740057441505; Thu, 20 Feb 2025
 05:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220130334.3583331-1-nicolas.dichtel@6wind.com> <20250220130334.3583331-3-nicolas.dichtel@6wind.com>
In-Reply-To: <20250220130334.3583331-3-nicolas.dichtel@6wind.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Feb 2025 14:17:10 +0100
X-Gm-Features: AWEUYZl4vWT2h7ryyxmYEjU2VbhZCzM8LUHXa_AxjYs3_T6MrVLLwqN35i4o994
Message-ID: <CANn89iKdYXKqePQ5g5eU9UGuTi4fZaxwWy2BK7D+F2wkQHAXhg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: plumb extack in __dev_change_net_namespace()
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:03=E2=80=AFPM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> It could be hard to understand why the netlink command fails. For example=
,
> if dev->netns_local is set, the error is "Invalid argument".
>

After your patch, a new message is : "  "The interface has the 'netns
local' property""

Honestly, I am not sure we export to user space the concept of 'netns local=
'

"This interface netns is not allowed to be changed" or something like that =
?

