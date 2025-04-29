Return-Path: <netdev+bounces-186663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF1AA042C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6350B7A17AB
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1169B2741C6;
	Tue, 29 Apr 2025 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f2ccZmFF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07632749D1
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745911016; cv=none; b=Mxg7p9ubTBH2kiLkL+//goRUJ3NacClLHp+5kpEE+iyJlGClEC0PbFX17Br9tVZVtJbQA6oOUfUKBNBJiJCHI4a71vleClDbF6rFj7s+oQjI1QbmhyQHYFXHhxX/9+aOAgvMx3nLhqpYqaWFdsgtCzoKf/vEojjPBpiN0aickX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745911016; c=relaxed/simple;
	bh=BC3SBVMJuAeGc+jo5/GlWJ3IXSYAHyAItlcb8jp9r88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ff/Nzj5Vo3PzwGIMQB/cji7GS9Wtz7qdFIq67YoMv6jI0tQwv2r84eLCcVJ4JeVwh17/TTIelsTem4ZcQ7Zw9ph25Nm2ntnzqL+g5JaVMyl2jQtkjrNLvWapjGu5wznYG3HXoOTt93mjZfuzdSMfO4ESRzWHMpzPLS2284/Ox50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f2ccZmFF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so33863275e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745911011; x=1746515811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pMzWSZvl/Fmifo+KtAKVuXGtyyCQYEMw59QTTQh9eRU=;
        b=f2ccZmFFNs6R7u+crruXPXjlKK4q+q6haYfX5Ny0B/X7YUYreYbe8xMDpqoTZm0aqE
         QOKfp94jGSntJQmk6YWQvwjBYNvzGK/zXBYn/a3n4oAwvOYpxiDlFRJR5DXTj5pqQYOx
         zwTj/wtKjpm9Debvzjpg5w9BAnWbEj/MGb53Y+vZe9y7h70QIAvYbOOqHigNRf8QqDRK
         XWWLAPFab9CYi0KAbTF0aScfIxbZ3HCy1DcmoIyaLHhyZKrH6WtDHr18qdcfIqOCxx70
         QSM5klBCCxoMB6DIRwYDISycD2n6aimLhd7wWDGw0kx/nM4lOS1Rzza+TxP9OME9JDb2
         FWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745911011; x=1746515811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMzWSZvl/Fmifo+KtAKVuXGtyyCQYEMw59QTTQh9eRU=;
        b=DqiZ51mgKlbRkRj6OQsevyYhIGCwtk3BnpLyns/OjgzIb2Xkh71sINCwHkezjs0//B
         OWz7dfgT9rXyKgczfOonkEDZhgaetsGXMsnJIOnUNw6Rs/loMUZ6UjbbOVkhPZaoEIEJ
         qF/PL0tkloD5QJV8Mjk28hqtsmbqVtYLbMX5/mrqo/x5I1a6/O+jBbMaH+dN7FwJadVO
         zPrhql8DUInS+mCN6RE22VnNh4K58dV48HvjqStdVhN2q0WFDDed7nlOqTbqcckB4nBJ
         WErFWBliyLUkOmJSWLPml5w1Te5NkiMjUKygRCFBG86Eo4PrvBche8YQNxjdNfF79LmF
         uMYA==
X-Gm-Message-State: AOJu0YzyF6pKj+J9oKHyg92h5ioaAOwyIQspEp2/JiQ6b4BfiKR0WgmV
	8wqhA+Kp1HlLCfRl7+NHLOi+vYmQl4rI23MQfV7h1ZmmDt9CYe9NlVMK0a9j5Zo=
X-Gm-Gg: ASbGncsWNAE51iB/Ps83UF7PB9JZsYgks0uav9BkKsAVbFYjnmL3Tl5jxcQ3hwNakoX
	jC5QevqAId/FFsRWd0WVXt4i8uuXJNcLm9/HDaJvEx/cLRQPGb3wWovuA80/XlyFNaKdKivGvon
	WetuXwaKJKyogYEl/Ef/SBxEBF7Xwio3QJUzRQcqO6P7Lc48ZMJf2Wl+2MIxALfeA71HmJPpbob
	2NU/qN5H8HVL+zxFAFXt26+JHSTS/VLafbyyvRdgMtl5WTAKNFrs544jsbiQV3B/PGIBHaB89Ed
	gtSlbbDeuwLKaGuikEMyR1JBBUxIi1VUoZMvBgenk3n0JHAQ
X-Google-Smtp-Source: AGHT+IFH28vh5AmojDojg8y4bseO7ETnIv5ceXe4vJR9jcUWKhJ4I6ucIuye20UNjUOWpuTAMrpc4A==
X-Received: by 2002:a05:600c:1908:b0:43c:f629:66f3 with SMTP id 5b1f17b1804b1-441ac85dfecmr17021555e9.18.1745911010953;
        Tue, 29 Apr 2025 00:16:50 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a1ddsm147565295e9.30.2025.04.29.00.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 00:16:50 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:16:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	donald.hunter@gmail.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <u55em7inbrhkstex6fwvjr3tu5dnvmtsu77sgspwqxo5j4p6ii@dwfzd7wawrck>
References: <5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
 <20250422080238.00cbc3dc@kernel.org>
 <25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
 <20250423151745.0b5a8e77@kernel.org>
 <3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
 <20250424150629.7fbf2d3b@kernel.org>
 <kxyjur2elo3h2jkajuckkqg3fklnkmdewhch2npqnti6mylw6f@snsjaotsbdy2>
 <20250425134529.549f2cda@kernel.org>
 <fx7b7ztzrkvf7dnktqnnzudlrb3jxydqzv2fijeibk7c6cq3xb@hxreseqvu2d2>
 <20250428111252.62d4309c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428111252.62d4309c@kernel.org>

Mon, Apr 28, 2025 at 08:12:52PM +0200, kuba@kernel.org wrote:
>On Mon, 28 Apr 2025 18:28:24 +0200 Jiri Pirko wrote:
>> >You just need to find a better place to expose the client side.  
>> 
>> Okay. Why exactly you find it wrong to put it under devlink dev info?
>> I mean, to me it is perfect fit. It is basically another serial number,
>> uniqueue identification of devlink device.
>> 
>> If other place is better fit, I don't see it.
>
>devlink instance should represent the device, not a PF / port;
>and then having the attribute on the instance does not fit
>an eswitch controller with 2 PFs connected.

Why do you say so? In reality, devlink device is created per PF/VF/SF.
It actually makes sense as it is always based-on/backed-by parcticular
pci function or other device with address (like i2c).

The faux parent in the RFC I linked to is the per-device/asic instance
you are probably looking for. There is no real pci function backing it.
It is a parent of multiple PF devlink instances.


>
>> Do you have some ideas?
>
>Either subsystem specific (like a netdev attr) or not subsystem

I don't see how subsystem specific would make sense here, as the
function uuid is subsystem-agnostic.


>specific (bus dev attr, so PCI). Forcing every endpoint to expose
>a devlink instance just for one attribute is too much of a hack.

Wait, that's a misunderstanding. There is no forcing. Any driver has a
benevolency to either instantiate devlink instance for PF/VF/SF,
according to its needs, or not.

In mlx5, there is a need to do that. So if one has a need to expose
serial number of function id over devlink, he instantiates devlink
instance. What's even remotely hacky about that?

