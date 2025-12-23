Return-Path: <netdev+bounces-245783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A4CD77CA
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 01:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D4F301394B
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 00:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8043610785;
	Tue, 23 Dec 2025 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3Zuw6yu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB71A1862
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766449850; cv=none; b=DCmJcMiqtJ3qDSvw46zk71V+SrWNHBJiPjqm7gRCaSTPWxCTnEEvjsIB0GKyqFpClEzmAWqoF3FqAV0x6DcnLTWloRMkfgICw2qLtc6TRsFC7eGYxvFMQOPCwrsFAT5xj6thylo4e+ali3zueX00W+lUBXCNHhctadZJteCwnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766449850; c=relaxed/simple;
	bh=PiLPg5QzsLDPMMUNkb8YR841wTdH4AGM+uMJpDlOm10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=fDKytnk2IDOGXjvXnyRw+RkVktO9XfLXEGOnmC0x8L/vpwtRRLHo4mC2tBIWnznRSnURlEWgBWCgK0K1CkbcZaVUsaXScCD4UYRoH2+IzFCiT3dLM0yu2CykCzPlDvZIJXAEbtH9y5yel4HYTfgT4qEkb493U5HfxQNLE0PudRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3Zuw6yu; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-4ee328b8e38so50577621cf.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 16:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766449847; x=1767054647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PiLPg5QzsLDPMMUNkb8YR841wTdH4AGM+uMJpDlOm10=;
        b=l3Zuw6yuRFu0dB7DSwWP+/3L2+wvXb78WLQeXAJw+qoD0mKM4i7YuzmGqHonFHty9r
         aSPHprL3ndI3xkL8T/341rtyfkDq89+DIXmRz9ic8VwajUgmO9ZXwFxrn/R5CvMXFL4a
         PiPh4118uh845nHh2MFlXIqKVs+2rfMKaKJ/Silawd4eNzo8CEVAzKtshTBaYyjOiA+s
         pgN5sJ16Aa1GK4MELF/c0lIIEe/GNF+Kb/GL9v1gxYl0fmlpVUlfrlApLtbU/evuGD1g
         GvExDlooo2VLxSUKL4Tun8SQoKKlk7iTGsA6nOFxWsR2rcE6Zo/i8YDNMJbMMU2rp3WZ
         BxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766449847; x=1767054647;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PiLPg5QzsLDPMMUNkb8YR841wTdH4AGM+uMJpDlOm10=;
        b=SrHy/JgoCLWR8p4Kb9BxXHobZgNjHXojoAR2dKdYIfECIb0lGwDB5YnEIu7h7xbcZ4
         uJESaeAgFSi4RAMXpl5vt7zFgBB+VsD2cTF1/UIJ1AW1UVbFfbSY+6MEMNJnrBRYzQcN
         As87KvVaEQuH/lsSpOGIHsj7Z6MCcfFCqom6yYMtMkiRW9oTYI3nyy9appRolYK8t5lt
         QQNhkNbkJgEMt5Vargd0m6n/10EIKKF8p/p64qmxhSUKb9+pV3N+gaXaDMszTwgH9+2S
         77idEGTo/qZxjymH7KOI48uSoupIpQsRWlR0DO64S8FYYWKRcUrURmgwmDT8LSRPpxak
         7IxQ==
X-Gm-Message-State: AOJu0Yw7q/O/IYAWg/FElQydpSJUPB+bfpm0R5U8kLeVz9ejKc2pHRuq
	ozSw5JIv0xDHBarmBLO4cyhdCL1baAaks8/NA6QKy5KUllqGIA0wW7iRzq7KE8WpVkn8tflTRyq
	kGMHJH74XE62u3YTNyKOrpzfVbDm0rFFRfXQJkY0pkg==
X-Gm-Gg: AY/fxX6rVf7PejI0T28nhNud6WLvtKPAa0ZHN2KcIh6bwFyAJn22XoRPLKqkvo9aVCw
	AgYqjUz8wFPTe7pk7vOVW0ba37CTRNXPMsByDmehBMzHeHmQe1bC1XguyDZjXFI/l7T4mtoSzCv
	bAbY70Z//CKHVW/BWGxXD6UN8gEJGRIDg5G22mSYV/N93SHYCHfXFB+rRKq7hCTeX9y45LwrBSL
	bv59uVtcrV0XW8D+XIQvobBB3xzvuJjFVHc2L6dIv8zxwOFS8ci/EXhYPXdTdnLIbSJiGvvrqGm
	NcGYh3TtKzxJV63ZJ0dy9+6i++j4BGWa1M+RoDs/Gjo8Nz/npReHd3XAZg==
X-Google-Smtp-Source: AGHT+IFHvoB0cQPCC8eF3QJMGb0VdKwi6FgpKWkDdrgsf/dXaUlUMWnjUS1FZLCZo6ExVBCCDAAb72U+Ot5yVZNulEc=
X-Received: by 2002:a05:622a:2b49:b0:4ed:aeaa:ec4d with SMTP id
 d75a77b69052e-4f4abdb5e13mr195152271cf.77.1766449846681; Mon, 22 Dec 2025
 16:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221082400.50688-1-enelsonmoore@gmail.com>
 <4eb474ac-5e12-4237-bec8-f0cc08b00bb1@lunn.ch> <CADkSEUhW5+=mo8nLK9cSa7Nh0SKP-RXV=_z7RY73BZgUH=kV9w@mail.gmail.com>
 <5be10af1-e7ca-4bed-bf19-0127e2eeb556@lunn.ch>
In-Reply-To: <5be10af1-e7ca-4bed-bf19-0127e2eeb556@lunn.ch>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 22 Dec 2025 16:30:35 -0800
X-Gm-Features: AQt7F2oMLpQIV4fEhp-YumTNUSyMUzpc1j5_vUKhDyIu5FbZUzuooITMjfpYm2s
Message-ID: <CADkSEUgwA9=2fZQzDU51e71rxSHgCUPjQMEWbnOWJ1LOQFDa2A@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: sr9700: fix incorrect command used to write
 single register
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 1:07=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> Please don't top post.

Sorry. I will keep that in mind in the future.

> How finished do you think this driver is? Are there likely to be more
> instances of SR_WR_REG/SR_WR_REGS added in the future? If so, it might
> make sense to change the code to make this sort of error less likely.
>
> SR_WR_MULTIPLE_REG and SR_WR_ONE_REG?

That's a good idea. This driver has significant functional issues
because it is a copy of the dm9601 driver, but the hardware, while
generally a DM9601 clone, does not support some features of the DM9601
(for example, it has no MII or multicast filter registers). I am
probing the registers to check which registers/bits are present and
work as expected (going by the DM9601 datasheet). When I finish doing
so and submit a patch to fix these issues, I will change the names of
those constants.

