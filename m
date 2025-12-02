Return-Path: <netdev+bounces-243208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1EC9B88D
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20A94E30B4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240CB313523;
	Tue,  2 Dec 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/zVLb7W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDE3115BD
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680195; cv=none; b=eB/65Iainm8sjDUTDKNSNgi/DN8xEDMf9SO4td78vkVHf6pSslu+Bnexhzw4wWicyir7zklWameEwB2yNEbYj4n5otqpqYs7cF0KlsxsGx7q2YZtL3vkkVHCzlyx52IIf8fuOw4zkcR3zKT2fjxZJXIlQDTVp+g5/f46s/KQEXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680195; c=relaxed/simple;
	bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH013X3pcuLWFQ201zuEVos6GUSvO9SNyKFd/rsY+q8oQaGsHeE9KaRIlvO/mDG88q9zFdgTlX9QPs5exkqeQcjo7czXscPUVi0/N+R3Hmg4W6+35paEG6sJfFKW+9E2wc7RUy8O5QvXjm9plbAhWXJ2Go+ZpWWaRQ7Ck8IjqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/zVLb7W; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7866bca6765so45757897b3.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 04:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764680192; x=1765284992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
        b=E/zVLb7WsThlxshIWURSdTMjU2KO0D4xakXOhHZMj6E7yuWjp9/eCiveCk1MdZ9tDw
         ai7Aii3JoZkwlMOOMkmwq8r2iBPFf+9BA4POUREcsdkKm7sIgut/VKIxp2fafkLjGAeH
         3WcESHVqiqaVAzkrSixAO8x0k0efgsOmWz9amtwpw5Y8yNONUx8Sa1ydNfIMSBPajq6+
         Lt5MD6zwtdDei6gsH+FodNIZtPLoxjwYptmdnKasRtT4c6OISRoun/sxXstrhBOcpmx3
         VzVEv9n2gQyH5/SdpNV1JmJVLHjHMTLF1zCtZW1os7CJaNYSlqx3+BQ3tbPWjpmBHAJi
         6vuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764680192; x=1765284992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5XptyRg0V6xIXYaH8cGgPYeufNCc32cq0Y7tnm8N0E=;
        b=soOZ3eYvFfhHBAcgBoUNdW7QXhWvrfj1JAJAXcBRnm7erUM0xABBilZjY9lU09oIWB
         XAKAahVv/BVsVEXq3B9pZ8LEm3D96xXL/WgMy+hg3dhi7HT5gNjiZC6k/xJI/wnTeyCr
         Dc6e00QV2AlBhWeidyL9JUKyR1YXwwbSZaIPIaZizaAWDPd6ATXLE5Hp/PFhLdpYMgy+
         Hs2eooScz19C+thK23VWz8iLOrE0aUD3xeybYwLVmDPWu4ZRXUtkC6r0zrx3hqqgFc0x
         98GJgHBG0sNhd8g0O5B/pTQsbrujmMjBGniAuXKNxPS9NMnGDqsg/DVUK7arqky+jRTF
         C+bg==
X-Forwarded-Encrypted: i=1; AJvYcCXuCF3Mqh3dPg/O7JcNmuKRU34RThs6Tzrr3+dSdF8H623BVcxtD1+THcUXGNkvwmSpW9DfFVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QDpy/fU41jhQ9L3l4gzDjtBP//vLlDLtk3A8y4zsL7puxa7G
	07F+kR7tHw8q9bRxCYUFMtcQr4i5E9alsV1sLv3XZiHNupPFfTH8uYCMpxlgUVnTDWOGOvY9GbY
	InBcyjdeQjRcEISZasNEFg0RrG1r4TjE=
X-Gm-Gg: ASbGncvO/Qz1QeGSUxO+EN9gqg2AkU5M88GhrltXeohqBC66iPpQtkDqTpnbtoGZ8+f
	49nYtsgiYuKv+cGzhOC1pe6E3Mfvvkg2W5a8u69K23WeRqMTaM1Br3u38XoRPC/iXagXIV9Cykz
	8/0zhfFNr0LRI7ErkXE1ZfLUQ85fDiS8JgiMJPwPwOKdFvmfNTNPkMRtqQzSM0dkUJCWb1aTC8I
	5iIMxA+/nk8bTN7sb1EALV+dNsmqmTh32YCpqrMsXXCJ84rJMBNTz2KtduvbCmB/umzVk0=
X-Google-Smtp-Source: AGHT+IFWvd/Jg2PHJ8dCgKfCqITnGuYDu5UIS8p468SFhsPj2lrZIUJDqHaziM8xR41qt/h2TwW0PHnbJjWSJlr4uGg=
X-Received: by 2002:a05:690c:b9a:b0:786:5620:faf1 with SMTP id
 00721157ae682-78a8b54d499mr343901027b3.46.1764680192362; Tue, 02 Dec 2025
 04:56:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201034058.263839-1-lgs201920130244@gmail.com>
 <7917b0db-82b7-4a75-91cd-d3b6b0364728@molgen.mpg.de> <CANUHTR9o-wzkSzYeRwQvu-MEdYXQ4tbNXvDD2WyCfA1MGCG=Bw@mail.gmail.com>
 <a4ea0043-9ee1-4b9d-a2b3-811c36b12ab8@molgen.mpg.de>
In-Reply-To: <a4ea0043-9ee1-4b9d-a2b3-811c36b12ab8@molgen.mpg.de>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 2 Dec 2025 20:56:19 +0800
X-Gm-Features: AWmQ_bmBqFLvXwPU5QvquqBV9IKbR5CvMxyKznfoWOr_JLhm-lwBZGfYAbm6Z6E
Message-ID: <CANUHTR_6AgpsZszMAOvtbRYBbh+_uvvLmjrHyG_HsNQkY4=9=g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] e1000: fix OOB in e1000_tbi_should_accept()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Westphal <fw@strlen.de>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tony Nguyen <tony.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for your reply.

To run the reproducer, you'll first need to download the PrIntFuzz
project from https://github.com/vul337/PrIntFuzz and set up the
environment. Once that is done, you should be able to run the attached
syzkaller program to reproduce the issue.

Kind regards,
Guangshuo


Paul Menzel <pmenzel@molgen.mpg.de> =E4=BA=8E2025=E5=B9=B412=E6=9C=882=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Dear Guangshuo,
>
>
> Thank you for your quick and insightful reply. (No need to resend this
> often.)
>
> Am 02.12.25 um 12:34 schrieb Guangshuo Li:
>
> > thanks for your comments.
> >
> > ----Do you have reproducer to forth an invalid length?
> >
> > Yes. The issue is reproducible with a concrete system call sequence.
> >
> > I am running on top of a fuzzer called PrIntFuzz, which is built on
> > syzkaller. PrIntFuzz adds a custom syscall syz_prepare_data() that is
> > used to simulate device input. In other words, the device side traffic
> > is not coming from a real hardware device, but is deliberately
> > constructed by the fuzzer through syz_prepare_data().
> >
> > The exact reproducer is provided in the attached syzkaller program
> > (system call sequence) generated by PrIntFuzz, which consistently
> > triggers the invalid length and the crash on my setup.
> >
> > (The attached program is exactly the sequence I am running to
> > reproduce the problem.)
>
> Thank you for attaching it. Excuse my ignorance, but how do I run it?
>
> > ----Should an error be logged, or is it a common scenario, that such
> > traffic exists?
> >
> > In normal deployments, I don=E2=80=99t expect such traffic from a well-=
behaved
> > I2C device. In my case, the malformed length only appears because
> > PrIntFuzz is intentionally crafting invalid inputs and feeding them to
> > the driver via syz_prepare_data(). So this is not a =E2=80=9Ccommon=E2=
=80=9D or
> > expected scenario in real-world use, but it is a realistic
> > attacker/fuzzer scenario, since the length field can be controlled by
> > an external peer/device.
> >
> > Given that, I think the driver should treat an invalid length as an
> > error and fail the request instead of trusting it and risking memory
> > corruption.
> >
> > Regarding logging, I=E2=80=99m fully open to your preference. From my p=
oint of
> > view, logging this as an error seems reasonable, because it indicates
> > malformed or buggy input from the device side. However, if you expect
> > this condition might occur more frequently in practice and would
> > prefer to reduce noise, I can switch it to dev_dbg() or even drop the
> > log entirely.
> >
> > Please let me know which logging level you would prefer, and I will
> > update the patch accordingly.
> Then I=E2=80=99d suggest to add an error message with error level so peop=
le
> notice and can take a look.
>
>
> Kind regards,
>
> Paul

