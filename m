Return-Path: <netdev+bounces-150849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1329EBC63
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACEF160698
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BBB210F51;
	Tue, 10 Dec 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2Dw/s4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28150153BF6;
	Tue, 10 Dec 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868077; cv=none; b=OyEuzSiDIuiihhrACqcFz5LFDUqKdCpLwE8u0PT0O6ABVQVKO/CheUqw3x2b+W2bc2JLUc81Aj8dkEoJXBdGcxkmkppOdTUwjEVYvkDTRq9kL0vJHNX174OwLilJh1b03q7AlymILdj8r0JocCn9RHfYsjPi0qKWz0mVMvSvnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868077; c=relaxed/simple;
	bh=yYKWF0JNmtLLNYt09YupJBTbUcQbehF+4vEK96plF/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnxOOzNC8gkxJUcPEE+eLn8mp4/+QDdSb5QGHXTEsVsTEBy/7cs+vBw2ekr7RKJNhXIBNL8h/k8Y/quEA/vjAjRFpJeDTXrtJ9uFxL6bl7oQh5PDfMFemhiLa/vjz7SoIi0ZtHinNyoLMMggZA4e6DlEcuDygh6PDxIK5hJso+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2Dw/s4F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a736518eso67729475e9.1;
        Tue, 10 Dec 2024 14:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733868074; x=1734472874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MhKC92nLwSxoxvzx2K+d7QE1ZjnBoVtbTWxJGBJQ+7w=;
        b=T2Dw/s4F8zgJNX0uOnhXWmCwZldkpJ6ZBTSI0+H6d+sqND5Nft6wELtwzbTnCyW4yx
         GYH15i9wnJkIaMlDbDjwjm9wkLptRGpHj1Y/Q/iD9zc5WNW9QEO+wPxHxC/Z5Vt+EYXc
         RZ7sOg7LjLIPglBnhM8Gpj7K4xQsCRMNteJMoKRStWlsYSeY6WLKunBZ8fCXKJZ+udlb
         yhmB4Ovc8rrHCAVbgeltv+R1k3fR9NI9tgeaEPjvEiWD+0gjuGR2KTTKfQ11B0bmO8Xy
         4VZmxPMxH6RW6mZd0+gPGYXROa1VQjJAGmjE7rLmHnpdAWkiuWmZNKsFzmozq8oSsayR
         8nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868074; x=1734472874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MhKC92nLwSxoxvzx2K+d7QE1ZjnBoVtbTWxJGBJQ+7w=;
        b=uIGc1NliRmdp+edckegGlwSLpAPxVqtoXE9WsWycVuCPY6GN8MbvtFV5RlN9yPo8fg
         UwjAtlpA/s8e3urAE6zsiV0kr4Q42WnPewMKlnrehskd+6IPQIF2KEafFxDink3VziHp
         0exjDEDYlnUERltxIGXBXNCVESOYOGd7w5of0xKm7PssRyNBxhpIOYQQIijQlhsISJAK
         YFL+KMZFEa5jsyNcT97cYUZwrt0lAZrggwiSs/IjdvQDZcU3ow5UlG456LTyeYC2tIYS
         KVoXjIMBJKpkb5SynQnH9BJLxq2VJabJRmc9kK/PhQimcQ4IrNgtDqDgRsMCBdzbcTt7
         P1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWo1VeFn2p0DDKaNcGdNc3Rkaor6KQL8ed+pzab9NjobUeZ86s2upgAy/B+dKf63ifqIVtcQss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1alcRxvubiMbHdLYif8Vf0yDULoEoe/qxGz59ScbQjajXcdoq
	aibMs/Qx6HIfNNV1arYx9yHoyZj30L3qHNmZT0aAL1j2GXA+2UJmWSMviKK9o0eHbhEvhQOAlHO
	qrwNzj+H7yqpKeKn2Au4Bq5I/oYI=
X-Gm-Gg: ASbGncuGFPhSMLR6Orft3kxPu4n8FCckJ3LpxR61UwSKNjmyVQ4/lOroljEUThKuwT5
	1mBgEyC7h3vYC65fQoLPAMySJ9pjrO9fiar7U
X-Google-Smtp-Source: AGHT+IElCszL1iwj4P8Atz85hoGmJExS9yjkoVbt2Agw69dhFLsOySt7EFf2NoXf2ZWZ0VPGs1OAZFM8xNT1zkrurLU=
X-Received: by 2002:a05:600c:1c01:b0:434:f0df:9fd with SMTP id
 5b1f17b1804b1-4361c393cb6mr3247695e9.2.1733868074073; Tue, 10 Dec 2024
 14:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210120443.1813-1-jesse.vangavere@scioteq.com> <dfb09395-78ce-477f-bbbc-747b0a234d4f@lunn.ch>
In-Reply-To: <dfb09395-78ce-477f-bbbc-747b0a234d4f@lunn.ch>
From: Jesse Van Gavere <jesseevg@gmail.com>
Date: Tue, 10 Dec 2024 23:01:02 +0100
Message-ID: <CAMdwsN_Kgb23Rw0q041fFr9T70twx2vAX2J+MvJz+585ZyyanQ@mail.gmail.com>
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: microchip,ksz: Improve
 example to a working one
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org, 
	Marek Vasut <marex@denx.de>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Vladimir Oltean <olteanv@gmail.com>, UNGLinuxDriver@microchip.com, 
	Woojung Huh <woojung.huh@microchip.com>, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew

Op di 10 dec 2024 om 17:18 schreef Andrew Lunn <andrew@lunn.ch>:
>
> To some extent, the example is for the properties defined in the
> binding. For properties defined in other bindings, you should look at
> the examples in other bindings, and then glue it all together in a
> real .dts file.
>
> I don't know if Rob will accept this patch.
>
>         Andrew

To some extent I understand that perspective, but in this case for
example dsa-port itself has no example, I also struggled quite a bit
getting the example going (admittedly a bit due to my lack of
experience, figuring out the dt-schema tool really helped as well).
In most cases when I look at an example I see the full scope of what
it should be (or at least enough to get started from there), and this
one seemed a bit off in that regard as it showcases itself as an
example but is missing some critical details.
The microchip,lan yaml in contrast does define these properties and I
think it gives a much clearer picture of how to implement it in a
device tree than expecting people to figure out all the places they
need to look and how to glue that together.
I don't think it's straightforward for most people getting into device
trees to know how to glue that all together and knowing where to look
to begin with, in that sense I figured updating this example might
help others trying to get this up and running.

Best regards,
Jesse

