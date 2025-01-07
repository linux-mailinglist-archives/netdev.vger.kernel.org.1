Return-Path: <netdev+bounces-155656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76FA0348A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0931885E93
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E265F7DA7F;
	Tue,  7 Jan 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TorVCI4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343F18641;
	Tue,  7 Jan 2025 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213386; cv=none; b=o6r/vEhTmID2RobBi09Zt1Z757c9If4pO7prFu+OO2OG0SP9R7w2tVlWOnsX+LreXwjg8ky+u/LGNTJpdN8wCqkWFKOzV2QD7Zn1W81qcO9//CStQIDXULRO9vEdB8fp6YSBZwGJZYssFb8xdOENvFIKfRdWa58U1mpw6/SFCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213386; c=relaxed/simple;
	bh=J8NZcd5K9QiztEyOG2ggJP50sjAnaICLICy1UuSaR6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCxhaqOSOiu46zxY/lOE0tFpI0vZ572G2rVSy2RBk0ADzn0q1ETZeZvacQvDpCxyv8S2ia5nKr5cdP2jQ8El1T0jEeTg6g4fOdx0jLDIkNm9+lzPudC7J79Zwznr4drBdukrd4PKuEYpgQuEbS8oqUbp+cdy4+U7m8dscKVrgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TorVCI4n; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso6936675fac.1;
        Mon, 06 Jan 2025 17:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736213383; x=1736818183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiPpNCsJ1TTG4V10weTxzv9w2oWEoTHrCfYaKVCeGCc=;
        b=TorVCI4nFjd9dec1mcAsrXSjlf9p4TenPxXPf5f4LNLiTeIFskOuL0YaMYPksvbmyt
         K8frmGkhT/DZ8uPNorVGnk0T6ntkTWyA0ntV+5kuo1RyqTpfHlw2Ndb0E23joRPeasRY
         S2DHk363+MJMk+VF9oNImZZFQZ8ZLLv7QChN3vXLcHVcBac1hGSYjpmad0RaytjxB2UX
         pQG/3yk+xJcsJrzEMEe3p/m8GarUFgT8NBn2Qza6XRbRzYZCILQJrQmpG5kzsC+Oxjch
         /W0Xua9tEh/ZNMkX3SAbrGjy2qLbB5K+ph495NspO61e1DFjagId7bcYZvernBAWl9tV
         bJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736213383; x=1736818183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiPpNCsJ1TTG4V10weTxzv9w2oWEoTHrCfYaKVCeGCc=;
        b=Fz5bzPSpyHW5SOHMwGelBKZLarZk8b7KIru6rMSnE/7iubGjrxOgbD2I8SoAZkshPP
         y+uHk5citRBnK5JnOkzkv6K+hv8Bbv0DO3sl8PTjklUDv6uJc/8QwDthdRJulzsBbaR4
         C9iEN4qECFvdT+oS7fvRPj0WZhtqtz2Af9XfaWWuzgFDPfJaJYt47nyo9JHH5tzUKkZ+
         ZAlqg3+XqZfqeeMGFfLZMmBypjeEsltfbjrXdPe4V319lHrY1lolbcY9c5Q3AAUdxzQz
         isB0Exzna5WOpR9gpTzQFbdnuU1P/0WRt9N2mTeGfFFXVjkYYicZc4wJSVNYormEADYI
         iFHg==
X-Forwarded-Encrypted: i=1; AJvYcCUWRWoxoJivo/XxMH0OA8peyF+f8bv8yS+bud9J2LMsKCTYTwH8ykERp/isn4tI2ZFuyU6Vw95qYjQ+NeQ=@vger.kernel.org, AJvYcCVh5BnIjUe8Q3s8PWHxJ2PwWGAAfyNJiTIOPjmkHHtb5PX30ecMRd3zpe2gI6aV0HiG8SjDaK5c@vger.kernel.org
X-Gm-Message-State: AOJu0YxKY/3OAFBwkZmADfcTramjlsXPjQJmAxfnR05C+9y3Z0wUNJL8
	BqxYx5vZFlS3Pt/caoK61oPCSdJc7CI8pe6blhkX0faW5MkbFD5M1Wfrn/udCyidRyioymt0qdq
	EiFSeKCi72QF8D/K/ApPXfq39GQ0=
X-Gm-Gg: ASbGncuiWcbEwQNAaI8MpP3wD5ZV50XF2bRYrCQ8JgEQN47B4rvs2YPf6On7byRcpsQ
	5usrVEvfRLiBTooZPXiNw9d27cseZpVMQwYxChUc=
X-Google-Smtp-Source: AGHT+IFMM0Juf4QxkRGVrZYnhim4FEYeihObNtHL2ms4OJMOFe+GafreQohuIANxtdDwPxK+EzcfhL/UB4+GKqFhASU=
X-Received: by 2002:a05:6871:d108:b0:27c:52a1:f311 with SMTP id
 586e51a60fabf-2a7fb555857mr27281719fac.42.1736213382873; Mon, 06 Jan 2025
 17:29:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241226025319.1724209-1-Leo-Yang@quantatw.com> <b0e373986f3dad8e79266b09b225d126af8ae981.camel@codeconstruct.com.au>
In-Reply-To: <b0e373986f3dad8e79266b09b225d126af8ae981.camel@codeconstruct.com.au>
From: Leo Yang <leo.yang.sy0@gmail.com>
Date: Tue, 7 Jan 2025 09:29:32 +0800
Message-ID: <CAAfUjZFJRXDOfDjzdiaSgaDKpu3sJCD=2zFQ4APhK_aLXSX5cg@mail.gmail.com>
Subject: Re: [PATCH net] mctp i3c: fix MCTP I3C driver multi-thread issue
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Leo Yang <Leo-Yang@quantatw.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 10:28=E2=80=AFAM Jeremy Kerr <jk@codeconstruct.com.a=
u> wrote:

Hi Jeremy,

>
> Mostly out of curiosity, could you share a little detail about what you
> were observing with that read behaviour? Were the IBIs being handed by
> different CPUs in that case?
>
> I assume that you were seeing the netif_rx() out of sequence with the
> skbs populated from i3c_device_do_priv_xfers(), is that right?
>

Yes, in our test environment, I can observe this issue by making a
request via BMC -> BIC.
and the BIC replies with multiple-packet messages.

Then there is a chance that we can observe the following situation
(trimmed out to avoid long messages in the mail)
i3c from within i3c_device_do_priv_xfers() and
mctp-i3c from messages sent by netif_rx()

[  120.179246] i3c i3c-1: nresp:1, Rx:01:08:50:80:
[  120.282348] i3c i3c-1: nresp:1, Rx:01:08:50:10:
[  120.326819] mctp-i3c 1-7ec80010023: NET_RX_SUCCESS: 01:08:50:80:
[  120.433935] i3c i3c-1: nresp:1, Rx:01:08:50:20:
[  120.478631] mctp-i3c 1-7ec80010023: NET_RX_SUCCESS: 01:08:50:20:
[  120.526682] mctp-i3c 1-7ec80010023: NET_RX_SUCCESS: 01:08:50:10:
[  120.633453] i3c i3c-1: nresp:1, Rx:01:08:50:30:
[  120.736494] i3c i3c-1: nresp:1, Rx:01:08:50:40:
[  120.779371] mctp-i3c 1-7ec80010023: NET_RX_SUCCESS: 01:08:50:40:
[  120.826232] mctp-i3c 1-7ec80010023: NET_RX_SUCCESS: 01:08:50:30:

We can observe that the read order of i3c is: 80 -> 10 -> 20 -> 30 -> 40
But the final sequence of netif_rx() is: 80 -> 20 -> 10 -> 40 -> 30

> Just to clarify the intent here, and if I'm correct with the assumption
> above, it would be good to a comment on what this lock is serialising.
> If you're re-rolling with Jakub's Fixes request, can you add a comment
> too? Something like:
>
>        /* ensure that we netif_rx() in the same order as the i3c reads */
>        mutex_lock(&mi->lock);

Yes, thank you for the suggestion.


Best Regards,

Leo Yang

