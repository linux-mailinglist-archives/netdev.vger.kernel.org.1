Return-Path: <netdev+bounces-102894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8CA905577
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8EA1F224F9
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145717E908;
	Wed, 12 Jun 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5kasKSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2117E8F6;
	Wed, 12 Jun 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203415; cv=none; b=ToxHBWBudJcJdiDXFEKu2jRDk+V7YW84GVNayPzr1jTIxpHycgIZcaX6qOc8+YONIHJS3U3yvmlaoFG55SUyF5RCRrzLTGWE+LdKkud/S+Qczhi7go9t3SiwAV+K8gTIbhtsSzlEQnYH/OMNvfl7v/07b7nHopRU8Dt94d4I9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203415; c=relaxed/simple;
	bh=PjcM7rP+hBRDz6EYnrDQ84eaIe1J2+pJjc+pb92wRfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmkrl3eAfZuCFlH+Xg2cFyvm8WKubgFmqFGa+yu4zgX6ZHwkrK+vshlljscuE+QFtOd9KocF2VaISDfxC04KulhiyGvdx4a8NqYbtTxO/UXVh0nh8d+covsT3OPGEAxB4n6+GY/URC1My/kZE5GfntUXXD+rNybHxntzabHmBeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5kasKSA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ead2c6b50bso74753311fa.0;
        Wed, 12 Jun 2024 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718203412; x=1718808212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW83Ak87jUa6osjdXWew6iZXQucAO5XQn2fmjPBjnz8=;
        b=e5kasKSA4zi1BBda0pXYoKtmWhBmPMxrRvyTo+12a2oJzv8X/wZdEp12sRwwYKZlTv
         1kM1zhDIXZYe3fS5RkIGhtxVmtLjpT+9blEcPnOi2UZfT0J0Z4nwV3I1zsGkEoJSUHZt
         JBKrAkSILMd8HJs27yg7S+DAXQm8Vo/+LMCc37/ZXQDMIVnRMYAworFMAPEtsNAtHn0g
         fAEPZNUASOVuf2YWBZaWcOT77MR84td22yd1tqNwuqWH2IevY/quIW3XPZaegS7EQ/Ub
         Uu7aASdT4OlUqv+hE1BNR++F8qeMcfvpjKSgaC3GgL5kzPphilDNZF2LrLGte6Yp+UpR
         tPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718203412; x=1718808212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW83Ak87jUa6osjdXWew6iZXQucAO5XQn2fmjPBjnz8=;
        b=FIWMT4hybq3jit/g+e9uliBPqEuT3e/ZN68drnD4dEhwj66cLlWg71YC5I8mS1+pPd
         yWUeI2Eb/Mywq3VsZVjlTmcF8jXkSg3aQ0joisitRjN2lXdhV/GI93ayX6jpVBmR8dR3
         lIipG1uXq1ujQyBnc1Ol/Dyas35G0+XGNXvly/evqg2bL4d6xfVN/v5lfSYXio3Ny8/4
         DU1I8dPAulzw3kdQp4gDXXZiTYXhPrxkla6TLdj2HnFXX6ynZJ+frRWzL+1KexX4Sly4
         cG24qRMjBRi6LCIwrlwSMfffdsEQJOoL8xXAYq92yltGyr7UplUmqI7BtqPcbgCTrobD
         JZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPtjLdfSt7uUSYm4k11NMSVMtr4SCFcWv7oEbTwQ4/1glu3MNDhdtMddINasbQnKCc+dUWSzvWKJXsTdbslwohRIHTO1ZoLLKGqlO0tiMAoE1+ypxI9olWR1Q5RzzncyxxcQuNVQkxx3JuZ2+UK7u5qcIXT+w0cFy2MjRbiKh0v6k/I1lO1NkkV8kKYNGa4HUCYZhgH6pYqvcg1cK5CwdFpQ==
X-Gm-Message-State: AOJu0Yzdyj3T9LS6jS2ctfk+udnZNwgKDmOcqfNU/TQq6X2LHD8snHYl
	1SsE/bcEMbZWcUY0ATfPB8amEuv4xm3G9nsVsRy9eLb1TCBZuDpgx+qs2DEa479a8r1KLo5EDte
	dIm4eAoXrVOcaYOouJzcMu0MB+o082g==
X-Google-Smtp-Source: AGHT+IGQSGKNUT6oh75ga9xXvvQMfdbkcrqzvWbotM/qwavxY69bbecS6VLhkRiwusswe/oDi6UAgpW8vIWNrooEw8U=
X-Received: by 2002:a2e:a796:0:b0:2eb:fda7:e35f with SMTP id
 38308e7fff4ca-2ebfda7e40bmr12880991fa.5.1718203411907; Wed, 12 Jun 2024
 07:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612075829.18241-1-brgl@bgdev.pl>
In-Reply-To: <20240612075829.18241-1-brgl@bgdev.pl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Jun 2024 10:43:19 -0400
Message-ID: <CABBYNZLrwgj848w97GP+ijybt-yU8yMNnW5UWhb2y5Zq6b5H9A@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable tag between the Bluetooth and pwrseq
 branches for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Wed, Jun 12, 2024 at 3:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Hi Marcel, Luiz,
>
> Please pull the following power sequencing changes into the Bluetooth tre=
e
> before applying the hci_qca patches I sent separately.
>
> Link: https://lore.kernel.org/linux-kernel/20240605174713.GA767261@bhelga=
as/T/
>
> The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa6=
70:
>
>   Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrse=
q-initial-for-v6.11
>
> for you to fetch changes up to 2f1630f437dff20d02e4b3f07e836f42869128dd:
>
>   power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets=
 (2024-06-12 09:20:13 +0200)
>
> ----------------------------------------------------------------
> Initial implementation of the power sequencing subsystem for linux v6.11
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (2):
>       power: sequencing: implement the pwrseq core
>       power: pwrseq: add a driver for the PMU module on the QCom WCN chip=
sets

Is this intended to go via bluetooth-next or it is just because it is
a dependency of another set? You could perhaps send another set
including these changes to avoid having CI failing to compile.

>  MAINTAINERS                                |    8 +
>  drivers/power/Kconfig                      |    1 +
>  drivers/power/Makefile                     |    1 +
>  drivers/power/sequencing/Kconfig           |   29 +
>  drivers/power/sequencing/Makefile          |    6 +
>  drivers/power/sequencing/core.c            | 1105 ++++++++++++++++++++++=
++++++
>  drivers/power/sequencing/pwrseq-qcom-wcn.c |  336 +++++++++
>  include/linux/pwrseq/consumer.h            |   56 ++
>  include/linux/pwrseq/provider.h            |   75 ++
>  9 files changed, 1617 insertions(+)
>  create mode 100644 drivers/power/sequencing/Kconfig
>  create mode 100644 drivers/power/sequencing/Makefile
>  create mode 100644 drivers/power/sequencing/core.c
>  create mode 100644 drivers/power/sequencing/pwrseq-qcom-wcn.c
>  create mode 100644 include/linux/pwrseq/consumer.h
>  create mode 100644 include/linux/pwrseq/provider.h



--=20
Luiz Augusto von Dentz

