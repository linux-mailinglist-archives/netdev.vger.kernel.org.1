Return-Path: <netdev+bounces-169467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5366A440F3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8033A74BF
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB3A26982F;
	Tue, 25 Feb 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="zKBcbCuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08A2269819
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490574; cv=none; b=Ab9n0IQzCGoaNqY6wrtBIYZ3XseFccLp/c8R73Tee3G2aPIoiFy1+BTR9coWmHKbFWUEq0MawMZmI2kSJsqijXZvKPejWsTV1sueSjGgrnlHfgLCJdmDN95PKGOsfhmBWeU1ujhi6XqB5LZ/QSKuOBHCARqBic+Hgg7ayOx7mKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490574; c=relaxed/simple;
	bh=6zIDGY7o8wonG5XSWfvfNzMNhLDCQ4e5sFlmf6YJhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTL1T6VKnnvRVSitzriIURu7JnRwYGvWdEt3ETX3DqIyvWfVnsytLoHhr4/GSvSbUQ2WL7+endbLOimL+1Vsrkb3HftVhgH+S10nEWY9wEFKhaYgf3X/mYZKMz1CSs6JAimCB4VJIZ43OrVA3SQ6k/BIO3rTm2Oe1vrzUpq2+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=zKBcbCuE; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb999658fbso698227666b.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 05:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1740490571; x=1741095371; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AZPYRoqfrPagvwL/VaIj4ZSda7O5NYpHMyVSIETeVto=;
        b=zKBcbCuET1NBYuwsZqMtPPNWwln0LKbAGf9DiFhMvxHo3ePFgv2ZRwHQ1m+/X3IXF0
         /0SyQqa7PogVHz8goMiWLt/TcbuRvjr61hXI6Yae2IYtOQ8Qc2PTJ6GeOKMcJm07Lj1S
         7OKvrE31v1Jg1a7dgnH6XD2udWEbDnBhB3JWSufEr3izLLu6QVF4woo+GD4kOay2Dbxx
         6+6LshdWjmMXJiGBnp8jmvL4CP1ppPdxBwzFEiVr32IaTGIAk0VIHGawXnTF4Ng7F7Mp
         Nv8dajrEdryY97lRYRzVO5k7lLkXEGcYFFF+DloGD19YYuiCmIjxymramJBqepcGpBQY
         zHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740490571; x=1741095371;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZPYRoqfrPagvwL/VaIj4ZSda7O5NYpHMyVSIETeVto=;
        b=SEAAZcMX+MGwpGaWUUL67fBRKOTqaBdbNmKI/rp1BzHFAB0L6LnXMGVUF7tLsw3aPU
         /KNkJMw3Umtt2BbKVIKtChh0KWZDao1QfeLf4ypcxlATwh2UUbbpO7cKjVskCOmxM4Fw
         ktxtw+fxVV1Zj8kVFNU3OozLzIQGu7B0nasUYBbRkDIYmGgfJPhhpas4BS+cJV+XtjRI
         YfFoc5bSw1IzxYB1AqY3RitBFq43APu+Moi3tLFRkjrREWFBuxHBCLKSVmkCYEvFmduR
         p+UlOPIkkunRCUJdE+gM4Hki9xx4LMxRPZnP9r1YgXO+SFNYussxKdauMskksBAnceN3
         Nx7A==
X-Forwarded-Encrypted: i=1; AJvYcCV6h0i922IMjhGfsTBGucRUMszA5GIM7PHLhZljHtYRFV/vJHjv29Prr4hvV+bdUMH6drvuLMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXPoFBH/EbuDxXt/kT0zgEhBZCJWk3GNl43Z1KJRzVTvUCUbYs
	LaUwIzd6IaYm+joF6vJf0yYDnueA+29ROcgBf5Ge/sQpwO10bV3C9kqNtlbxcbg=
X-Gm-Gg: ASbGncs6gL0lU+uJMrPzMXY/Cf9+aqDNhOkkVSJdLjEmTdwQ/C84f26ww9ZrQg0pfXL
	C4TnfqbMwomyIyTPYREcdDf+EvS1ZvSpbzA8c31Zm0NiHUr5oBYSyVs69FFOTPkoACJwRDL77J/
	OVCqLlwxit5Y9GrFOUJ62k6vMl5CxDf9oqdWeamotwykjvTNjBgVpPuQnnl3dwR7lHSRXRzL9l4
	AAmC9hvMQpLRjBYVhcctL4Y4hPmGUSujfRZ1A529aa3YM4UWl/CeCK1jTL2MH6XyYp4tSbFmBH2
	T9NVfaS6c6ZRvo0PM3SlKYQrtQssDdrE8qd4DocqK5H/YXseZE7oSw==
X-Google-Smtp-Source: AGHT+IGwZxstsJgbZbrGjWctQYTkmnZEeqGMf6YIvXycHvPmwGPJt3l7AO/RiG5BKR9nAP88NqhdmQ==
X-Received: by 2002:a05:6402:4604:b0:5e0:7cc4:ec57 with SMTP id 4fb4d7f45d1cf-5e44bb37281mr6445272a12.31.1740490570625;
        Tue, 25 Feb 2025 05:36:10 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2057276sm143453466b.142.2025.02.25.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:36:10 -0800 (PST)
Date: Tue, 25 Feb 2025 14:36:07 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tariq Toukan <tariqt@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jiri Pirko <jiri@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 03/10] devlink: Serialize access to rate domains
Message-ID: <qaznnl77zg24zh72axtv7vhbfdbxnzmr73bqr7qir5wu2r6n52@ob25uqzyxytm>
References: <20250213180134.323929-1-tariqt@nvidia.com>
 <20250213180134.323929-4-tariqt@nvidia.com>
 <ieeem2dc5mifpj2t45wnruzxmo4cp35mbvrnsgkebsqpmxj5ib@hn7gphf6io7x>
 <20250218182130.757cc582@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218182130.757cc582@kernel.org>

Wed, Feb 19, 2025 at 03:21:30AM +0100, kuba@kernel.org wrote:
>On Fri, 14 Feb 2025 13:54:43 +0100 Jiri Pirko wrote:
>> For the record, I'm still not convinced that introducing this kind of
>> shared inter-devlink lock is good idea. We spent quite a bit of painful
>> times getting rid of global devlink_mutex and making devlink locking
>> scheme nice and simple as it currently is.
>> 
>> But at the same time I admit I can't think of any other nicer solution
>> to the problem this patchset is trying to solve.
>> 
>> Jakub, any thoughts?
>
>The problem comes from having a devlink instance per function /
>port rather than for the ASIC. Spawn a single instance and the
>problem will go away 🤷️

Yeah, we currently have VF devlink ports created under PF devlink instance.
That is aligned with PCI geometry. If we have a single per-ASIC parent
devlink, this does not change and we still need to configure cross
PF devlink instances.

The only benefit I see is that we don't need rate domain, but
we can use parent devlink instance lock instead. The locking ordering
might be a bit tricky to fix though.


>
>I think we talked about this multiple times, I think at least
>once with Jake, too. Not that I remember all the details now..
>-- 
>pw-bot: cr

