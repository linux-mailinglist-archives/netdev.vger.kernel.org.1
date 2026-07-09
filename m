Return-Path: <netdev+bounces-306363-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QqjpJuwAUGrnrgIAu9opvQ
	(envelope-from <netdev+bounces-306363-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:13:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92578735468
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 22:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fIPEpG29;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306363-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306363-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC6D9300BD7B
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 20:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139E3C1413;
	Thu,  9 Jul 2026 20:13:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32514499BD
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 20:13:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783628006; cv=none; b=NQc1rCaQlUttcgJrE/P2x+veWhqRmJfqW+UDW6nohmkLbD4y4XIlI63YmdhPyP4TOPHLGuOzAbRiLuzaidlycSivggGRc/towYX7Lfd+7Tc5Ck2Ow7/S/DL06AtLllNMKiuJvqj36OFI3P7aC8r4+crZrzpuYcLYvXM2dh4BZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783628006; c=relaxed/simple;
	bh=T+GhzX9+HMfNc1mPl7NUwWfpwuwo0OQ6m2yczx+qhDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ32CB3JudIgqQINauXO4mdLTiCsKLq5eYiOSGjYt4MNyrfPTls+qQzInDkBFmBlZfLAR3hYg6ZAREH3+J3dM+WObHp47/ZTt7Xxz3UeMlueyktkb4PmiGKxEaWmGp8NWiF51YWftFz2daMfsKxOGQSMixhSFueHmGGo2oopOqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIPEpG29; arc=none smtp.client-ip=209.85.128.53
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so1499165e9.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783628003; x=1784232803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eJkGeObDaOcMT+Iq1Xd1zHQwKIn2ZUrSxLhR2bO5jzg=;
        b=fIPEpG29nG9h/AXvJtL+F0NewzC3yozxUlNxQR7BcUL0yqfHo+rtC1v7dxoKYtsl3F
         8q/FBfDDk/jrdCCr/HXF3hxpr7sAm0lCdJq/cqwCVpF92KX83d2c98u5EKO/4+/fkAbT
         kP9sL+O81H5PcMnZtXgRZDQ0T151Xw0nzXzAns1hwL3P0MlvCrrQv4fNUrzrCT87JQdq
         o4+n+lNuj50/GO6JpoF/RvUppGkWSzD3SwdwGuU+4QZYbhGjNn6eS22fd7C570Kbt4fq
         sRHly98ewLokwSElExUm12/inpqF4b9vqSrn56+SCaop5kBWu4bowcGZmOgl7yH35eYw
         rc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783628003; x=1784232803;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eJkGeObDaOcMT+Iq1Xd1zHQwKIn2ZUrSxLhR2bO5jzg=;
        b=otKri57CldYJSv/OYm85/hrU7EbT43bxOgC8ncI9A2LB4DaT2F+6vb0QGu1pSpRekp
         bdovlKtnyohaShID7tc8t6ojKwtmWs+mkPu8jL11VTt0Mu4kLHXElWpcjCTmfJGIDJ6x
         NdD/ECJRtze5U0see69m0923a64VKbN5cyQ/GAiRIbcxRPgr4xiSeMlFPVy+SQG3TP1I
         YycGdWtNYzk8ZOUtFlVJgR/OkPCG6RrOCR7mK2TAhH3W6DiZ0cpoC6T5iEx3LjIl4uXk
         YsGi6ga//88VXcDnkfodj55jnJE3J3Os9LR1ntrEJ/ExUEBVq/w81b03rM5iJ2z4Frbd
         AWaA==
X-Forwarded-Encrypted: i=1; AHgh+RoLjj5Kbvu6TJW9bH4lcnAm9TrF38CCUOZgu7Nf2Mc5N7LN3q3IEOR9NDtklv/etZ+MncJgd64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1bnlEQPDJw/xWF40tJmzh4qov6tNLm8IpxX70q7Lh3niEmYus
	ShOWxyqlmUjTEc+B37r7pU2oOyEfySqWptXoP15+m8M9d4WhdjBgDAmw
X-Gm-Gg: AfdE7ckr7QSiBbUL4WaXjjC/yQvxDa/mzlSrytnmh0At/1bwiXSq/M5ngiVpB5NVYLC
	cxx0r0WIbvNcT2Faz2M9aX0tHV2UggHom/q1ro2F0zCWk+M3NvuXQiReYQuVxvohiHBivLRgQFr
	mhkwazB8PFHqH2jiZZWSWjbmCPCrN4riSajKyGypm4A3pnEg1/xaUN4sRSyLCSTb7Am1/LIgaca
	QjyV9awvkEUsyCsoA3JQbJyOVehgrdaehvMYryVBVFl2HzR31AmWLd8qObNe2tFeX1WjvNb1Ehb
	YCVHCXyJ4sFsN9ddhfivhub2kPFHXToNh5X+4LT19QJsPdpQW9gV7oxNhySh+uTSfqg+zk9ZjPf
	QnQrIavnVchiOlYIIKIRgS0faTzEcCxER670//G8SSBOVuaVdI/FpFzjzd+w0RPAqdkOXxb5ygd
	jeCpIcX1EhG2+A3BgtICRBrKmsAWow2xDGn+/JXdoU
X-Received: by 2002:a05:600c:3515:b0:493:bc92:2a2f with SMTP id 5b1f17b1804b1-493e6894936mr89946805e9.1.1783628002879;
        Thu, 09 Jul 2026 13:13:22 -0700 (PDT)
Received: from archlinux ([143.58.204.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b0cesm54980016f8f.22.2026.07.09.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 13:13:22 -0700 (PDT)
Date: Thu, 9 Jul 2026 21:13:21 +0100
From: Andre Carvalho <asantostc@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Message-ID: <ak__tD5QKz1jX99T@archlinux>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
 <f398373e-2cb4-4649-a491-9763df94d98b@kernel.org>
 <ak6jtwbct3C5lZPA@archlinux>
 <1fb14039-b56d-4757-add9-22b97d3c9f44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb14039-b56d-4757-add9-22b97d3c9f44@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306363-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asantostc@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[archlinux:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92578735468

On Thu, Jul 09, 2026 at 12:21:29PM +0200, Matthieu Baerts wrote:
> Good! I will send this patch.
> 
> Just to avoid a deadlock, do you plan to send one to handle the MAC
> address that has not been modified (and eventually one to get more debug
> messages in case of errors)?

Ack! I'll send a patch to making the test handle the MAC address unchanged
scenario (taking your suggestion above) in the next couple of days. I'll follow
up on improving debuggability across this and other netconsole selftests as well
as a lot of them share the same issues.

> Cheers,
> Matt

Sorry for the noise here and thank you for testing the fix!

-- 
Andre Carvalho

