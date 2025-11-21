Return-Path: <netdev+bounces-240698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C1944C77F00
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 09:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CF35344F92
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52A2E0917;
	Fri, 21 Nov 2025 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="czs09i9a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48689296BA5
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714131; cv=none; b=DKCuOQJeoTajbxQudFnlzGvjfxfQ6v35sW33cPszzUPWswXP8QevtH4KHP5Olul6MY+7kFKc5Ik44dtwPTfKU3QcgvWiJWN38R6QpJhIOzEMlbKZg9epEYBaUueFmd/OlnkR8aI742tA3Ig0gOAm258Y6fdAz/AICgdHWUvohzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714131; c=relaxed/simple;
	bh=zI+X3AeCVVRFA81Cu8JTV/RA6oXRMYyKJF4z8JM4bDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=setQjf1kMCr4PPrgNjiiatV/rbJi9YGF1nrIszPQvsYgUNiak87qoxj1mzAcmIl4jBS6yMf1ACwwsAEsIAflw6CWfeTb5sfTvVr1M3cbXw+HBQ3gFsEOshXkpSltbt5Gy/LfqnXeNXmoNAlNUZ+75UV5/oO327byEgt0XIbU3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=czs09i9a; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64162c04f90so3002964a12.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763714127; x=1764318927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hddq8kazojkamoAHF74BkvhvgAzbI671oY6Po7awP+U=;
        b=czs09i9ah/AIGds4XS9rObmJvRf6S3PI48BK9sHjMGm3weXADTRIvieSgQ228rQKD1
         Q5kSZYkzXByluNiRaJ4rPHR7vMX48o0n5rI+f49xYOmOAGJMVwh5DmkKOJLYqtisVSop
         NKmnsTckoPo/8PFnr0VtC/KK6gngVpMq+wzbhUK9PAcb273pbBfTgikuQ5mwz5Byla/I
         EmnZr4VO9+B53w9ColNmjVeQ+UlMp8NQL3B2Mdwxmg0104YPeW3eduAmCyWbXiraELKJ
         YBOloOaah28YMTlTjzIYLs6tq5xMKwFckWpppywk7ewtLxi9/wbZJra8wqbo0sGMQNcH
         Jh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763714127; x=1764318927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hddq8kazojkamoAHF74BkvhvgAzbI671oY6Po7awP+U=;
        b=fXZxNP+IVv/Gt9WnQusnLpIRt2UyeIKHaFUDXFHlfkBBIO52NygmePUU0Od1Y3zoJD
         nzFlw2ZyZGSww+mr2a5vxZsGTY8YR6i/HBo6BE2IyPxRpYIb0uexghEA2JnFP1eFUSQV
         VHpkENNuQxKIgK9pJ3YAInCw6xr5IedAsPcg1Bl/VBixWDzK2mzDJa+FQkcVQaRM84vQ
         E0tt2MCJZvNpxDzy9Jd/C2fEyR4KI+NcRGYOuqOvGhuTze6MPwREg0qQXiv3zC1GhcMZ
         Hnf2IyY1gCtsvXnkeDM19+W/qeGjoGchWZyyWEuUSvJI912qthwfBfVBgfKQaB3c17Ks
         J4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCU05N/TGfDmh9OlTlU0EV9z4+XvsXR6MFrhHItrueQRQ10hMhExopuLFAsmCoVDZHH5zw6kx1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg7AzcHBkHJkvT1YQA7Tj7ahwUYpM4ZHw02Wf41dxAuevXXJ69
	0sXtU+yo+67K0kekeF6OpbxOAzwgUF4ZRWObaUHKefEta4FpYR6bqg4KgRntPLmv1g8=
X-Gm-Gg: ASbGncthNeQdxxQoJcFXUGiX315GVInw8DoQPMl86V6hLqErXnLckeRKUM+SKGxUqYf
	r2otsw/PruoG31wYyw21JoNQsEu2qwSgaDJA9KgJVc3p34ojlBXHu8QQn/iq0Jj4TgDQ21ldqoo
	7SGFvz2XpooO7DcKdL3+OwV67+docCLSHAwxRnngt9RadBTtjo2BYaoGGw1n4Rth//GqKd+CxFn
	fYMiyj7qH7sL/gqg/nGLtvijoErlUbE5ZkcLPfsv0vSkoBqdHW8Ipqn5eCeucl9cKxXOSMVdQ+B
	zJZTedyp+jbVhamUDPheuJKoSxSXAn6Ba8zxnlfhw9A/8d9K85ztgPyl137fXKtWqL4v9yF8ucQ
	5Lv10Rh0E4o2iN7V8PkS4PfC95QTpxXT+r9rF0ItOE7+U1wChzPwNkJ1KPmgev+EDrIdPGT/dGb
	mpLtGV7HDmvkZAd//FoxM=
X-Google-Smtp-Source: AGHT+IGdJSVL3dA/pHHWk1QfSIkvZJRQANyLOPvhyZve5ZwTg/4c0JEYuv1o3oMo88XdgA1vaiqU7w==
X-Received: by 2002:a05:6402:42c7:b0:63e:b49:c9c3 with SMTP id 4fb4d7f45d1cf-64555cf83f3mr1098214a12.31.1763714127134;
        Fri, 21 Nov 2025 00:35:27 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645977dsm3996289a12.30.2025.11.21.00.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:35:26 -0800 (PST)
Date: Fri, 21 Nov 2025 09:35:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
References: <20251119165936.9061-1-parav@nvidia.com>
 <20251119175628.4fe6cd4d@kernel.org>
 <32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
 <20251120065223.7c9d4462@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120065223.7c9d4462@kernel.org>

Thu, Nov 20, 2025 at 03:52:23PM +0100, kuba@kernel.org wrote:
>On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:
>> Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:
>> >On Wed, 19 Nov 2025 18:59:36 +0200 Parav Pandit wrote:  
>> >> When eswitch mode changes, notify such change to the
>> >> devlink monitoring process.
>> >> 
>> >> After this notification, a devlink monitoring process
>> >> can see following output:
>> >> 
>> >> $ devlink mon
>> >> [eswitch,get] pci/0000:06:00.0: mode switchdev inline-mode none encap-mode basic
>> >> [eswitch,get] pci/0000:06:00.0: mode legacy inline-mode none encap-mode basic
>> >> 
>> >> Reviewed-by: Jiri Pirko <jiri@nvidia.com>  
>> >
>> >Jiri, did you have a chance to re-review this or the tag is stale?  
>> 
>> Nope, I reviewed internally, that's why the tag was taken.
>> 
>> >I have a slight preference for a new command ID here but if you
>> >think GET is fine then so be it.  
>> 
>> Well, For the rest of the notifications, we have NEW/DEL commands.
>> However in this case, as "eswitch" is somehow a subobject, there is no
>> NEW/DEL value defined. I'm fine with using GET for notifications for it.
>> I'm also okay with adding new ID, up to you.
>
>Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
>easier / possible to use the same socket for requests and notifications.

Well, you still can use the same socket with just ESWITCH_GET. Request
messages are going from userspace, notifications from kernel, there is
no mixup.

For the sake of consistency, shouldn't the name be ESWITCH_NEW?


>-- 
>pw-bot: cr

