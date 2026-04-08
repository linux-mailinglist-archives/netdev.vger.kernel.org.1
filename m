Return-Path: <netdev+bounces-276591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDhoIA9z1ml2FQgAu9opvQ
	(envelope-from <netdev+bounces-276591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:23:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D79343BE22F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B90B300FC45
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF283D3CF6;
	Wed,  8 Apr 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hy0bblT/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AD83AF670
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775661773; cv=none; b=VNn6jOIAibE/PtOS/ncvcRUqjqNZifOOjidP3FRyCo18ksJfbbipxxZ06ZLJmlrV8TZFhjq/X3O4J/aL1zUbZ9yZitcymhf0OXvMgezeFxCiLJaDCgqwuyJS6vHEuNMWeb4raicpMnUx8VzOwuCfgZqKYRZ8elR+dLX3tCAHp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775661773; c=relaxed/simple;
	bh=vA240ToEZpV5ABu1bLZJGQn4hXI4cp2DDe6zTQg0jQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyAY4hjQClkFWo/13UiNNf1z1xfqjevxkENpp4WNn4st6yEoqttNk1KYwFpwBr1V0oNJH+4RPtgvWnY08ZlPaKJvdv3Pb/SXmtHkiZ6Dh/o6wLsb2H5b9aJZqMsfuwCGXj8qj4paXGB45SpCj1fVOJqzBLn7NHVV4EmnzUbdK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hy0bblT/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c755b2cdeso730668466b.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1775661770; x=1776266570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6oB8sWft0bulZQQhndjF41bb2A55hZmeFDzZlsmEc5U=;
        b=Hy0bblT/37r4nKgkD9qBANOwCscm7hFk837xxRFrtmwudZUzw7NW/YIpdSw6Eu5+xm
         lTUlQnA0Y11vRoOQvlm7Ef48qE5OEFrSgi8kXIdFHcuNPIHC5Wtbm0t7Rz7X04YkN/2g
         ie2JZovdDJztnJGoPE/1cx/AY7yl62ZkXU5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661770; x=1776266570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oB8sWft0bulZQQhndjF41bb2A55hZmeFDzZlsmEc5U=;
        b=DjKu7bynXCJXSEyx7XYt8qAwUroetAbcYmH3MEC56uNdkoxLTdhva6kbt69+3S0dkH
         rOElq8vxvnrhQqhogDyTj0/gUop+I8gEvaq9wv71lolvr2PLVlh8IEzqHk2zTU6oN3zi
         0v79bhJAILAWU8CbrUIE8Y6fRxoQoz8t9nIYPxF8Mky5zxw8rfWeFbaNRxqZOT8mPZNP
         mGAKp0C3WnKPvNAUifwYCielA8CKYcjL1fM67yJl/iKiv3GfippZfUkX/OwCVJ39tqL8
         +AtPyoYngAn+sIy9Cqt4fBW6TIvF2s3DkGp9V90aw/u0vsmZYeF3+v3ng6xreWXQR17N
         uEqw==
X-Gm-Message-State: AOJu0Yy+y6EG7OCaTp9njgj66gyTobw58rqnCKyRfQE0oOdwZFDUKQzX
	Q4CgGnA2UWRjluNMR4zNKWVOs9bo+uPUQRCOTsZ619whWcQCvYe5+69DUZ5jDcIUijFpuAB6IzV
	ZKYLksd0=
X-Gm-Gg: AeBDiesQ/LIbH5NlXUghA7/DnLxzXnDNRVGQezZ7oHCzL+ragIkKnzHxGe39IXR0WQr
	7sj6zcB86h7M9vUK3xqKwz030QHA7fvrVRgHGH+3/Us0aM/OiISQ54WvglYmO7MARwWaObMFkaf
	4kg7lb33HrAdlX0WqCeH9EowimXeVDgHVNKvkhbVLejDBxymp+/pPO/0FzDAY3gakGYJ7Rai9So
	wxXCwN18YpvpPLxbl4K7kyZfPoDnYMMXX47n+UveS20qvVgUG3T6gqZJ1NXMt3aMi+9ylDm7Tc2
	tIRpkFVlXbAiyByY7fyukRIf3/t7WsScBVoL3Rm8Q6tRcGTicDEXI1iaiTR/lCMxRjvqDEqFGRB
	gfXeWwprEpkP5PR0QZEZdc8Y35R4zFL83PMctji6TdxHg9X8T1ycmjZNIgzUqfH4zfep4oJCeH6
	tnF0qeS5NLaH3TzpLgk3erXo0xqhy+9/SjgUXmQCsYmM8VBGu0UEjqvXEPmlZLeNL6Yb+xy/3A
X-Received: by 2002:a17:907:6d1b:b0:b98:d58:f75e with SMTP id a640c23a62f3a-b9c67421c4amr1115075966b.2.1775661770041;
        Wed, 08 Apr 2026 08:22:50 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3cff19c0sm650526066b.48.2026.04.08.08.22.47
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:22:48 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66bf15430ecso11802087a12.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 08:22:47 -0700 (PDT)
X-Received: by 2002:a05:6402:5305:b0:66e:aadc:2021 with SMTP id
 4fb4d7f45d1cf-670047bb29amr83427a12.17.1775661767544; Wed, 08 Apr 2026
 08:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adZTGOjjJrVJOcT8@shell.armlinux.org.uk> <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
In-Reply-To: <adZfTi3R6jtsjXx-@shell.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Apr 2026 08:22:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7+6Q5ptBNp6UGrNbgbk9jr1vsY9mJ5O3mH5RPjpBggQ@mail.gmail.com>
X-Gm-Features: AQROBzDMX29dK6Ob4UI8k1Dcez-g32vHwaiLrL1sR7wyjWf7zr7a7LiEfyJC2DA
Message-ID: <CAHk-=wi7+6Q5ptBNp6UGrNbgbk9jr1vsY9mJ5O3mH5RPjpBggQ@mail.gmail.com>
Subject: Re: BUG: net-next (7.0-rc6 based and later) fails to boot on Jetson
 Xavier NX
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-ext4@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-276591-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: D79343BE22F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 at 06:59, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> > Now building straight -rc7. If that also fails, my plan is to start
> > bisecting rc5..rc6, which will likely take most of the rest of the
> > day. So, in the mean time I'm sending this as a heads-up that rc6
> > and onwards has a problem.
>
> Plain -rc7 fails (another random oops):
>
> Now starting the bisect between 7.0-rc5 and 7.0-rc6.

Thanks. Not what I wanted to hear at this point, but a bisect should
get the culprit if this is at least sufficiently repeatable.

The exact symptoms and oops details may be random, but hopefully the
"something bad happens" is reliable enough to bisect.

              Linus

