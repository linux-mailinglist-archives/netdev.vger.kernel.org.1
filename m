Return-Path: <netdev+bounces-206053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F9B012E9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EA1764CFC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 05:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D001C84D7;
	Fri, 11 Jul 2025 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILpI9yD7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A66190477;
	Fri, 11 Jul 2025 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752212689; cv=none; b=UpLflk1jlGE14MNiDs6oJXufTneLtN0ncvr4/oC4m7f7wmQx/FlrdDFx0E13qoIOEeJ+kMEs1pvd4JntZrvVVE7OH3M+wfsZBDWBi/HAdOp7u11eUAiWtVJVDkGl4jY2UBiC+Ur1fVoq44CW24FjDnutSDi6Ljt9x0S4EAPw9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752212689; c=relaxed/simple;
	bh=wKO0Y5rTrfPWFFv/RKw/Pm2KLgA4a1Ja9utiPd/DSTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smIyltLmcg9mg8Uzr9dbTPwajX+ULLg66g7fG7+osrxhMzXwzX7ewSDQUSYYT7lNzI1I1V1CXjePVsGeLhwkDNMIGFrpcvl+970ePZa79xdFQUN/3P6UuJvPj0EpxYeucUKBCeWm79wbsUxrRCGz2jmHZfXHxSScIW5pM4697cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILpI9yD7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23c8a5053c2so17557235ad.1;
        Thu, 10 Jul 2025 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752212687; x=1752817487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=svIj+HnRJ5qJzeh7W148yKUqf+BTVFsVDEIKrsaU+3k=;
        b=ILpI9yD7bs//7doOxAWKc32dX4faq6B6V/XRKfYBaVxn7/hKM9K7S2CNKt33MFog1D
         jelVSbwe6ctJwg8abiReTLZamlcWboHLlPYpsMgoUicJe+BmgdN9244OkpJYuMP87iXg
         uL0lm7BT6Ul4js0u3TRztC+SQE5o5mz/8NulgpolbRM/0VRnnRcxHi8fflzXMx92FSgv
         XhNAhWfZ4ysPSv7Q/iO6SSsq4u4qADLtTmWArSV7PYqpd+/DSIeYUGsVpmuNefXlhsrE
         khKyJEDAx/9An7m8wEvvivytgjpf39ziNPGl+5dWUCPnYJNVhyAKugQEkrv1jVouT8JE
         Buvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752212687; x=1752817487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svIj+HnRJ5qJzeh7W148yKUqf+BTVFsVDEIKrsaU+3k=;
        b=KLDoxOAVXoksr/+or0H3PpHJWSqpKgvf0Ri6rIOYd/MG7UUIL/i4OQaTcK/pCjvR+F
         2GJuBteY/+hrXbuX4aO44cfPmax+EOUflrgnVis42UJFT6PgRrGjoVjfXXlYX+MNFBVK
         lNtmmBs+srobK4SqU00rRLTTWRS8DJrmbhppzdGs2cKMSI9kX1jSG4fhiArZlgWP8r0U
         wb0nT7vr99QwRZZvU3Iy9fQa2sB20klJyjn9Nnng4PAhzPKBKeuk8dtQs9Ccl21NHzbx
         ygikVfHjwk0Q/lEXpqpRFT60F4+LEtFmrkL+1nK/PRvuS9EPfxdCJ+aquontVf5BEkXt
         Ifjg==
X-Forwarded-Encrypted: i=1; AJvYcCWNv9B6aRMN2AzdRjU2FuswClCDUoIRrNU86t5UBG5ZKR3zCLcBrjIK0TMtPHOehZi2f9oJGr+ojtw72C0=@vger.kernel.org, AJvYcCWfXlC0vdTRD3Nb3MbVHrdbXWjNfzOd4KSc4CNTnQ7U7Do4lWLE2+VD7K/ak0f+b0xeD0n8Ak53@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJ8CTl6RElbN0mLda2SnGLWjC9iKDZ1fws8mV7Lv0tP24xw6b
	YeQYqxIzeLpFtLmzN3vktO3O5kXbbOQiLBw9Fia6PFtBAFyNrwLadnDY
X-Gm-Gg: ASbGnct/8+0/4Q9Vg/8TylFUWjRIcAltVbPeI4acio1QChPkPXjSNo2vq8K9te6jpKo
	jlibkmWY0qK/yvjR/f08kKo14pTC9s5tAPUQVYL6kVaXr5fXZPFf9M1crdsWaGE5IzUU5Gb2fHe
	o5O70RyPGuzqDJRzmDWVdaG/g+XUkxznMTuZkT8hjq1E/8gXz14fVktZtdncPP0c4BjATaW4mp2
	bD4TAuzH/RlGG38OwcU0uoEMXxv8yZv5gqGhC5GnmSRp6VTpVPnjxFeIvSPITZPNUr15kATh4Xs
	ogTxw4XuWrlr9iKj9P6cj+zkYK138In7fJue9QZK0kOcMU+QM0MjY2FBKY+NXaRhhWz8NV9UuUq
	febacXz4+jT2+ZVGhvSwZ/dHG6BE=
X-Google-Smtp-Source: AGHT+IETvQpk29P3RsJyDGf7uVZW9zMEn+QsjSNk7a8KkH3ABLEI4V7c/X+CdOuTQf1b9nHWTfRgow==
X-Received: by 2002:a17:902:ebc8:b0:235:dd54:bce1 with SMTP id d9443c01a7336-23df08144f3mr16042445ad.15.1752212686848;
        Thu, 10 Jul 2025 22:44:46 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:86b6:8b81:3098:418])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4346b70sm38845945ad.195.2025.07.10.22.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 22:44:46 -0700 (PDT)
Date: Thu, 10 Jul 2025 22:44:45 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: William Liu <will@willsroot.io>, netdev@vger.kernel.org,
	jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com,
	savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: This breaks netem use cases
Message-ID: <aHCkzdhBHB8Noerp@pop-os.localdomain>
References: <20250708164141.875402-1-will@willsroot.io>
 <aG10rqwjX6elG1Gx@pop-os.localdomain>
 <9ea58b38-921c-45a0-85cc-a586a6857eb1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea58b38-921c-45a0-85cc-a586a6857eb1@redhat.com>

On Thu, Jul 10, 2025 at 10:26:46AM +0200, Paolo Abeni wrote:
> On 7/8/25 9:42 PM, Cong Wang wrote:
> > (Cc LKML for more audience, since this clearly breaks potentially useful
> > use cases)
> > 
> > On Tue, Jul 08, 2025 at 04:43:26PM +0000, William Liu wrote:
> >> netem_enqueue's duplication prevention logic breaks when a netem
> >> resides in a qdisc tree with other netems - this can lead to a
> >> soft lockup and OOM loop in netem_dequeue, as seen in [1].
> >> Ensure that a duplicating netem cannot exist in a tree with other
> >> netems.
> > 
> > As I already warned in your previous patchset, this breaks the following
> > potentially useful use case:
> > 
> > sudo tc qdisc add dev eth0 root handle 1: mq
> > sudo tc qdisc add dev eth0 parent 1:1 handle 10: netem duplicate 100%
> > sudo tc qdisc add dev eth0 parent 1:2 handle 20: netem duplicate 100%
> > 
> > I don't see any logical problem of such use case, therefore we should
> > consider it as valid, we can't break it.
> 
> My understanding is that even the solution you proposed breaks a
> currently accepted configuration:
> 
> https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrbHaGT6p3-uOD6vg@mail.gmail.com/

Maybe it is not obvious, my patch does not reject users' setup. It
probably has bugs, I am more than just happy to address any bugs in the
next iteration (like for any patch), in fact it is my obligation.

My appologize if I misled any of you to believe my patch is bug-free or
perfect, it is never the case.

For Jamal's patch, it is his intention to break users' setup, and this
won't change during any iteration.

They are significantly different.

> 
> I call them (both the linked one and the inline one) 'configurations'
> instead of 'use-cases' because I don't see how any of them could have
> real users, other than: https://xkcd.com/1172/.

Please let me know if you have any other way to use netem duplication on
a multiqueue NIC _directly_ without worrying about the global spinlock.

I bet you have none. Either you need to use it indirectly (attaching to
a non-root) or you have to face the global spinlock (aka without using
mq).

I am open to your education. :)

Thanks a lot!

